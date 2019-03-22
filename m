Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E1CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810F6218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553253707;
	bh=VmYwHchFG0nS/1a791g5naJJkRJw1E/YKHhKR8MWwm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YNMshosG5rxTqV+E2nvScWv7Rexw59a1GGUuiY4gbct3Iy2/3chJyiJNdoVryQ/UD
	 P+OXoQlSGpkhxndzT3vZq/IHL51vV6qbPALq3LH9NP3LYrSobjvQkWABj2U20PoeLB
	 jebp2hcbZVPrV69O5XsrZcpeBUcH3xvvYU3PMv1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfCVLVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:21:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728645AbfCVLVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:21:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E04A218A2;
        Fri, 22 Mar 2019 11:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253704;
        bh=VmYwHchFG0nS/1a791g5naJJkRJw1E/YKHhKR8MWwm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T2cBol0DMNhacbEOezXvLvgjjBJjibfZ3Z6QATXvQKcMk1nyypIdMoF0DtjwXCOFE
         9hd/vjHWjamEnbkuykuC8HszGfN4JjnCPEeCtrw6EQiXliV7rKQxUkA7jEoddGpkgD
         npUL4F04O8VOFl6rMDvT3NmXG2veJ15C8BJJm1K8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Eric Biggers <ebiggers@google.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <james.morris@microsoft.com>
Subject: [PATCH 3.18 018/134] KEYS: user: Align the payload buffer
Date:   Fri, 22 Mar 2019 12:13:51 +0100
Message-Id: <20190322111211.261485677@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit cc1780fc42c76c705dd07ea123f1143dc5057630 upstream.

Align the payload of "user" and "logon" keys so that users of the
keyrings service can access it as a struct that requires more than
2-byte alignment.  fscrypt currently does this which results in the read
of fscrypt_key::size being misaligned as it needs 4-byte alignment.

Align to __alignof__(u64) rather than __alignof__(long) since in the
future it's conceivable that people would use structs beginning with
u64, which on some platforms would require more than 'long' alignment.

Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Fixes: 2aa349f6e37c ("[PATCH] Keys: Export user-defined keyring operations")
Fixes: 88bd6ccdcdd6 ("ext4 crypto: add encryption key management facilities")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: James Morris <james.morris@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/keys/user-type.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/keys/user-type.h
+++ b/include/keys/user-type.h
@@ -29,7 +29,7 @@
 struct user_key_payload {
 	struct rcu_head	rcu;		/* RCU destructor */
 	unsigned short	datalen;	/* length of this data */
-	char		data[0];	/* actual data */
+	char		data[0] __aligned(__alignof__(u64)); /* actual data */
 };
 
 extern struct key_type key_type_user;


