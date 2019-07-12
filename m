Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D237EC742B9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A354921670
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934849;
	bh=KDB7BkkpHiBg9CX+rLZM9phDdX5FbUHbfnLEUuAj8Zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PNqKQLdtZPrjK16xmKcWpCANAZ541akNP2OugDt0c7Zt6COwSg8qn/irt/sPZi4yF
	 P+pIne5qovgsQl/TPZp5puZsus9RvMZrpJ0lQ8OdoJi0hbs6NMEDaQqbfsVBEF0LCl
	 rz/W7unTHC71XG85fCuME3FG+4t8jSl9T2u11Mm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbfGLMeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:34:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbfGLMeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:34:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83F9F216C4;
        Fri, 12 Jul 2019 12:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934845;
        bh=KDB7BkkpHiBg9CX+rLZM9phDdX5FbUHbfnLEUuAj8Zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Asx7jd17k9Zue098gWiwKiGJEn8uKO81jXiAR2OQse9eY/4KR8sA6oboiLuLivdah
         p3/Dle9eb/uxa0cca9OPciEzNZRN25tYzkKkz7yXKfsfQLX2g/h+xQH7J0KSgY0u+z
         gATGh9IdY9RKdZBvzaSsuWFdQBQdo2pbWhAsqq9A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Phil Baker <baker1tex@gmail.com>,
        Craig Robson <craig@zhatt.com>,
        Laura Abbott <labbott@redhat.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Bartosz Szczepanek <bsz@semihalf.com>
Subject: [PATCH 5.2 09/61] tpm: Actually fail on TPM errors during "get random"
Date:   Fri, 12 Jul 2019 14:19:22 +0200
Message-Id: <20190712121621.125477736@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121620.632595223@linuxfoundation.org>
References: <20190712121620.632595223@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

commit 782779b60faa2fc7ff609ac8ef938260fd792c0f upstream.

A "get random" may fail with a TPM error, but those codes were returned
as-is to the caller, which assumed the result was the number of bytes
that had been written to the target buffer, which could lead to a kernel
heap memory exposure and over-read.

This fixes tpm1_get_random() to mask positive TPM errors into -EIO, as
before.

[   18.092103] tpm tpm0: A TPM error (379) occurred attempting get random
[   18.092106] usercopy: Kernel memory exposure attempt detected from SLUB object 'kmalloc-64' (offset 0, size 379)!

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1650989
Reported-by: Phil Baker <baker1tex@gmail.com>
Reported-by: Craig Robson <craig@zhatt.com>
Fixes: 7aee9c52d7ac ("tpm: tpm1: rewrite tpm1_get_random() using tpm_buf structure")
Cc: Laura Abbott <labbott@redhat.com>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Tomas Winkler <tomas.winkler@intel.com>
Tested-by: Bartosz Szczepanek <bsz@semihalf.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm1-cmd.c |    7 +++++--
 drivers/char/tpm/tpm2-cmd.c |    7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -510,7 +510,7 @@ struct tpm1_get_random_out {
  *
  * Return:
  * *  number of bytes read
- * * -errno or a TPM return code otherwise
+ * * -errno (positive TPM return codes are masked to -EIO)
  */
 int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 {
@@ -531,8 +531,11 @@ int tpm1_get_random(struct tpm_chip *chi
 
 		rc = tpm_transmit_cmd(chip, &buf, sizeof(out->rng_data_len),
 				      "attempting get random");
-		if (rc)
+		if (rc) {
+			if (rc > 0)
+				rc = -EIO;
 			goto out;
+		}
 
 		out = (struct tpm1_get_random_out *)&buf.data[TPM_HEADER_SIZE];
 
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -297,7 +297,7 @@ struct tpm2_get_random_out {
  *
  * Return:
  *   size of the buffer on success,
- *   -errno otherwise
+ *   -errno otherwise (positive TPM return codes are masked to -EIO)
  */
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 {
@@ -324,8 +324,11 @@ int tpm2_get_random(struct tpm_chip *chi
 				       offsetof(struct tpm2_get_random_out,
 						buffer),
 				       "attempting get random");
-		if (err)
+		if (err) {
+			if (err > 0)
+				err = -EIO;
 			goto out;
+		}
 
 		out = (struct tpm2_get_random_out *)
 			&buf.data[TPM_HEADER_SIZE];


