Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61754C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304DE2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GKSXGJcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfDASwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:52:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32862 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728898AbfDASwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:52:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id i19so5023196pfd.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 11:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=7/IN4AS74kHhnTS76qLjnlyZdJM2U5JLJsmTGlsxxno=;
        b=GKSXGJcCmgZ6v/2sdp6uP2DxCGILVrLy6q2orPsze5t44OGzOCg9LcaQUuo9hBDBoV
         ty8CxUPtCM/33XKW5/6R4Gy/FNsBbqk7Q5ogQQC4ywAxDxCnFCNpAiWQVFaD8gn6VX5w
         TaTCnNn5q3KuxYkXLbMdGsP1eP4G9/iEnkceE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=7/IN4AS74kHhnTS76qLjnlyZdJM2U5JLJsmTGlsxxno=;
        b=DCe22QCrD2VTwPwtVYwcnP9lQMMjGY8ExnQIAQkbJR0GI1R/4rYWD5wNcENOq8WHH4
         lwxxngr4EuEW2uOQUd/UplMwcs7igd31/Af93Xtx7nPmmsx939hdTdX4ob5U1JD5EL/i
         nTpsmASNexjaVHvGvJ+4chfgNMJ/5RJM1rzRIxb6HZL7XlGEjg+TnoElBe9Y+99nyvZJ
         5ns5/2m0kcvN+qg4QnIkos5bs3WgiGgF8fCX9upu5VFjMPjJ2xR9Ubcmj3VGhzE9DnM+
         D/A95aCFPQnKLOcjzGd3nC8YuDtCGtU43zpHskpA8pP3nKT2VZK9eL6t/+rKKuTcuTre
         XfrQ==
X-Gm-Message-State: APjAAAV2hXriCmhBgM+8XQ3qKNMYp1I8RxrIEYzohgIxMETKT/R2xiJw
        C0YGV2dKCrY3vDN+2E3mPSkkPA==
X-Google-Smtp-Source: APXvYqzqsuzgYdZfQFWOvucA5+eop/VVSZDvOnoDJ/pHdfFsFfXDajhLhcRiVdBDhvIhF59PLMfISw==
X-Received: by 2002:a62:5206:: with SMTP id g6mr48029247pfb.227.1554144740913;
        Mon, 01 Apr 2019 11:52:20 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id a13sm12786505pgw.91.2019.04.01.11.52.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 11:52:19 -0700 (PDT)
Date:   Mon, 1 Apr 2019 11:52:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Phil Baker <baker1tex@gmail.com>,
        Craig Robson <craig@zhatt.com>,
        Laura Abbott <labbott@redhat.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-integrity@vger.kernel.org
Subject: [PATCH v2] tpm: Actually fail on TPM errors during "get random"
Message-ID: <20190401185219.GA22215@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A "get random" may fail with a TPM error, but those codes were returned
as-is to the caller, which assumed the result was the number of bytes
that had been written to the target buffer, which could lead to a kernel
heap memory exposure and over-read.

This fixes tpm1_get_random() and tpm2_get_random() to mask positive TPM
errors into -EIO while still passing through any negative errors.

[   18.092103] tpm tpm0: A TPM error (379) occurred attempting get random
[   18.092106] usercopy: Kernel memory exposure attempt detected from SLUB object 'kmalloc-64' (offset 0, size 379)!

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1650989
Reported-by: Phil Baker <baker1tex@gmail.com>
Reported-by: Craig Robson <craig@zhatt.com>
Fixes: 7aee9c52d7ac ("tpm: tpm1: rewrite tpm1_get_random() using tpm_buf structure")
Fixes: ce63c05b664e ("tpm: migrate tpm2_get_random() to use struct tpm_buf")
Cc: Laura Abbott <labbott@redhat.com>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: - also fix tpm2 implementation (Jason Gunthorpe)
---
 drivers/char/tpm/tpm1-cmd.c | 7 +++++--
 drivers/char/tpm/tpm2-cmd.c | 7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 85dcf2654d11..8e17d4f30aeb 100644
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
@@ -524,7 +524,7 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 
 	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_RANDOM);
 	if (rc)
-		return rc;
+		goto fail;
 
 	do {
 		tpm_buf_append_u32(&buf, num_bytes);
@@ -559,6 +559,9 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	rc = total ? (int)total : -EIO;
 out:
 	tpm_buf_destroy(&buf);
+fail:
+	if (rc > 0)
+		rc = -EIO;
 	return rc;
 }
 
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index e74c5b7b64bf..dd0677f50f9c 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -301,7 +301,7 @@ struct tpm2_get_random_out {
  *
  * Return:
  *   size of the buffer on success,
- *   -errno otherwise
+ *   -errno otherwise ((positive TPM return codes are masked to -EIO)
  */
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 {
@@ -319,7 +319,7 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 
 	err = tpm_buf_init(&buf, 0, 0);
 	if (err)
-		return err;
+		goto fail;
 
 	do {
 		tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_RANDOM);
@@ -352,6 +352,9 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	return total ? total : -EIO;
 out:
 	tpm_buf_destroy(&buf);
+fail:
+	if (err > 0)
+		erro = -EIO;
 	return err;
 }
 
-- 
2.17.1


-- 
Kees Cook
