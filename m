Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A326C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A6420693
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255454;
	bh=bQEPIgL7+0S3lHbbeLS8tt3tsYc8wx/1ldiIEubfjIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iahTlIvGilvk/EwKil0wOA+wsKgHzklyKp57yDH1664DWvWa6mk8cZ5Ap3PhEssUh
	 QiM9tYTc7htEqI7xhQYo8KRRYodU+tNUR1oHa9tn2v3obdl11HXBVrMmnT2AyjNgBA
	 /WUUsBBQQU8Jjq9elH3xgS9zApXcSfvPOm2i1oc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732711AbfCVLuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:50:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732681AbfCVLuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:50:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBB9620693;
        Fri, 22 Mar 2019 11:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255449;
        bh=bQEPIgL7+0S3lHbbeLS8tt3tsYc8wx/1ldiIEubfjIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bt0q2OI7lAPapO6TfB/i8Hk+pWYB/ui+IV2roVVQFQfBnajXW4UiqyGfGofCWOE3e
         55Grb+dVVjCLp1dGN4vhegmC+bhWs296eaysHgdU7g6gV71IoIwZz7Ndft+pgkNXbj
         otApWyx0Fo9QRd37Txif6V+4iIkJ8B6W4oLyIwHI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 076/183] crypto: testmgr - skip crc32c context test for ahash algorithms
Date:   Fri, 22 Mar 2019 12:15:04 +0100
Message-Id: <20190322111247.241962264@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1839,14 +1839,21 @@ static int alg_test_crc32c(const struct
 
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
@@ -1873,7 +1880,6 @@ static int alg_test_crc32c(const struct
 
 	crypto_free_shash(tfm);
 
-out:
 	return err;
 }
 


