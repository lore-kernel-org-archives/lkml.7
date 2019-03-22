Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8347C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F0B204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256179;
	bh=oHrfIO7Oo8zUZHRHEswT/b2HUYERA8VpXw78MHvOXR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ic+M8OENmP2URujbw3YSePgE/g+YF0tkb02osptgNRW9KgBF2MBdVDmyY8GKvEQK1
	 UcgmHGPXbEVq2hTNFcKy3TBy9XmVY5kRsDc593jNaY42ZKsbaSC7rHDb3C/T/wuzvT
	 1+b4M4sejRbyO/fXmdFwXwfeX0KLyTBibfIEVDMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388445AbfCVMC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:02:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388124AbfCVMC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:02:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0940B204FD;
        Fri, 22 Mar 2019 12:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256175;
        bh=oHrfIO7Oo8zUZHRHEswT/b2HUYERA8VpXw78MHvOXR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HlG1E5J+ygx8QEC+420swfEzbmdJjWnW7Ib8hj883oyMid6We8LPr7bIvtOcONkgo
         +gDJNsWUO18HTWk5ShOs9s6ek4qdCrCT5vvKVsKgAVsISB8DVdUKfecOftys8M6C1u
         S5m8NpKLQpQZDB89E44QrSS/xA2mWBf5wdq4WG5s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 131/280] crypto: testmgr - skip crc32c context test for ahash algorithms
Date:   Fri, 22 Mar 2019 12:14:44 +0100
Message-Id: <20190322111316.692405274@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit eb5e6730db98fcc4b51148b4a819fa4bf864ae54 upstream.

Instantiating "cryptd(crc32c)" causes a crypto self-test failure because
the crypto_alloc_shash() in alg_test_crc32c() fails.  This is because
cryptd(crc32c) is an ahash algorithm, not a shash algorithm; so it can
only be accessed through the ahash API, unlike shash algorithms which
can be accessed through both the ahash and shash APIs.

As the test is testing the shash descriptor format which is only
applicable to shash algorithms, skip it for ahash algorithms.

(Note that it's still important to fix crypto self-test failures even
 for weird algorithm instantiations like cryptd(crc32c) that no one
 would really use; in fips_enabled mode unprivileged users can use them
 to panic the kernel, and also they prevent treating a crypto self-test
 failure as a bug when fuzzing the kernel.)

Fixes: 8e3ee85e68c5 ("crypto: crc32c - Test descriptor context format")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/testmgr.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -1894,14 +1894,21 @@ static int alg_test_crc32c(const struct
 
 	err = alg_test_hash(desc, driver, type, mask);
 	if (err)
-		goto out;
+		return err;
 
 	tfm = crypto_alloc_shash(driver, type, mask);
 	if (IS_ERR(tfm)) {
+		if (PTR_ERR(tfm) == -ENOENT) {
+			/*
+			 * This crc32c implementation is only available through
+			 * ahash API, not the shash API, so the remaining part
+			 * of the test is not applicable to it.
+			 */
+			return 0;
+		}
 		printk(KERN_ERR "alg: crc32c: Failed to load transform for %s: "
 		       "%ld\n", driver, PTR_ERR(tfm));
-		err = PTR_ERR(tfm);
-		goto out;
+		return PTR_ERR(tfm);
 	}
 
 	do {
@@ -1928,7 +1935,6 @@ static int alg_test_crc32c(const struct
 
 	crypto_free_shash(tfm);
 
-out:
 	return err;
 }
 


