Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10ABC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89255206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbfD0PcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:32:06 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60760 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726809AbfD0PPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:12 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2k-0000zG-5w; Sat, 27 Apr 2019 16:15:10 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0004Po-PE; Sat, 27 Apr 2019 16:15:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "Eric Biggers" <ebiggers@google.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.955841822@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 028/202] crypto: authenc - fix parsing key with
 misaligned rta_len
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 8f9c469348487844328e162db57112f7d347c49f upstream.

Keys for "authenc" AEADs are formatted as an rtattr containing a 4-byte
'enckeylen', followed by an authentication key and an encryption key.
crypto_authenc_extractkeys() parses the key to find the inner keys.

However, it fails to consider the case where the rtattr's payload is
longer than 4 bytes but not 4-byte aligned, and where the key ends
before the next 4-byte aligned boundary.  In this case, 'keylen -=
RTA_ALIGN(rta->rta_len);' underflows to a value near UINT_MAX.  This
causes a buffer overread and crash during crypto_ahash_setkey().

Fix it by restricting the rtattr payload to the expected size.

Reproducer using AF_ALG:

	#include <linux/if_alg.h>
	#include <linux/rtnetlink.h>
	#include <sys/socket.h>

	int main()
	{
		int fd;
		struct sockaddr_alg addr = {
			.salg_type = "aead",
			.salg_name = "authenc(hmac(sha256),cbc(aes))",
		};
		struct {
			struct rtattr attr;
			__be32 enckeylen;
			char keys[1];
		} __attribute__((packed)) key = {
			.attr.rta_len = sizeof(key),
			.attr.rta_type = 1 /* CRYPTO_AUTHENC_KEYA_PARAM */,
		};

		fd = socket(AF_ALG, SOCK_SEQPACKET, 0);
		bind(fd, (void *)&addr, sizeof(addr));
		setsockopt(fd, SOL_ALG, ALG_SET_KEY, &key, sizeof(key));
	}

It caused:

	BUG: unable to handle kernel paging request at ffff88007ffdc000
	PGD 2e01067 P4D 2e01067 PUD 2e04067 PMD 2e05067 PTE 0
	Oops: 0000 [#1] SMP
	CPU: 0 PID: 883 Comm: authenc Not tainted 4.20.0-rc1-00108-g00c9fe37a7f27 #13
	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-20181126_142135-anatol 04/01/2014
	RIP: 0010:sha256_ni_transform+0xb3/0x330 arch/x86/crypto/sha256_ni_asm.S:155
	[...]
	Call Trace:
	 sha256_ni_finup+0x10/0x20 arch/x86/crypto/sha256_ssse3_glue.c:321
	 crypto_shash_finup+0x1a/0x30 crypto/shash.c:178
	 shash_digest_unaligned+0x45/0x60 crypto/shash.c:186
	 crypto_shash_digest+0x24/0x40 crypto/shash.c:202
	 hmac_setkey+0x135/0x1e0 crypto/hmac.c:66
	 crypto_shash_setkey+0x2b/0xb0 crypto/shash.c:66
	 shash_async_setkey+0x10/0x20 crypto/shash.c:223
	 crypto_ahash_setkey+0x2d/0xa0 crypto/ahash.c:202
	 crypto_authenc_setkey+0x68/0x100 crypto/authenc.c:96
	 crypto_aead_setkey+0x2a/0xc0 crypto/aead.c:62
	 aead_setkey+0xc/0x10 crypto/algif_aead.c:526
	 alg_setkey crypto/af_alg.c:223 [inline]
	 alg_setsockopt+0xfe/0x130 crypto/af_alg.c:256
	 __sys_setsockopt+0x6d/0xd0 net/socket.c:1902
	 __do_sys_setsockopt net/socket.c:1913 [inline]
	 __se_sys_setsockopt net/socket.c:1910 [inline]
	 __x64_sys_setsockopt+0x1f/0x30 net/socket.c:1910
	 do_syscall_64+0x4a/0x180 arch/x86/entry/common.c:290
	 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fixes: e236d4a89a2f ("[CRYPTO] authenc: Move enckeylen into key itself")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 crypto/authenc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/crypto/authenc.c
+++ b/crypto/authenc.c
@@ -62,14 +62,22 @@ int crypto_authenc_extractkeys(struct cr
 		return -EINVAL;
 	if (rta->rta_type != CRYPTO_AUTHENC_KEYA_PARAM)
 		return -EINVAL;
-	if (RTA_PAYLOAD(rta) < sizeof(*param))
+
+	/*
+	 * RTA_OK() didn't align the rtattr's payload when validating that it
+	 * fits in the buffer.  Yet, the keys should start on the next 4-byte
+	 * aligned boundary.  To avoid confusion, require that the rtattr
+	 * payload be exactly the param struct, which has a 4-byte aligned size.
+	 */
+	if (RTA_PAYLOAD(rta) != sizeof(*param))
 		return -EINVAL;
+	BUILD_BUG_ON(sizeof(*param) % RTA_ALIGNTO);
 
 	param = RTA_DATA(rta);
 	keys->enckeylen = be32_to_cpu(param->enckeylen);
 
-	key += RTA_ALIGN(rta->rta_len);
-	keylen -= RTA_ALIGN(rta->rta_len);
+	key += rta->rta_len;
+	keylen -= rta->rta_len;
 
 	if (keylen < keys->enckeylen)
 		return -EINVAL;

