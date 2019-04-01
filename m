Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AADC10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1555820830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oLCd5m4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfDATGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 15:06:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41506 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbfDATGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 15:06:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id f6so5231204pgs.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 12:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=A5zCJPVV0Q3tfgwssyIvV6XXb4+UfBWxjT0gfi9Y8ck=;
        b=oLCd5m4Vdq+/Othv8/hqM+4FN4ESeX27RYF7lzPokIxpV1PSa/zIhq+HOm2aOGEc7t
         kSzNjpTBe+RdfZXLXCYky3c2eWYJlINdmzlwDkkUmZt49qw2e9R5Wr5XV6+dt7+jSsab
         B1aNKuUSt9+C+XMb7Y7zm81Scnyox09Sjc87I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=A5zCJPVV0Q3tfgwssyIvV6XXb4+UfBWxjT0gfi9Y8ck=;
        b=Uzm3pJhyV38b6FMm7WOkT7cygOgr5jIyyQVu3T9igUDIt8sSZeCB9cwE96zhbYnZ2P
         525sNuSR3GEn9PKYqd1IqBkScL1puYO8RWs/Msp+akaEZP/T+Jjl6BPTdUDzIttDyFzd
         WAfZauHmOOKw3tsYvMh89f0n1s67bETvd/pE66hcvSDRp6DqzsscWpNZRqcIWOWLwUrN
         skAEzFhPziV0YW5lqtDCeKZ//uFR1hY30G1GnRxdo2PfVCMglQamPxDStEDB/owC6vBl
         yAMI3gp84a9RU/yOZTT8iNPAG6QwlFAS11bf9vpFWjSKIXdqlaYc0LjKI4Moz1ANkGTd
         +qUA==
X-Gm-Message-State: APjAAAXSfZnmZoZ3Bn1+bKjs3/lKhEuGS6UzZhKqIw4JuhyfiLBTANJ3
        TX9Xu0O132o51oQJGJvlv3829w==
X-Google-Smtp-Source: APXvYqyuiH00xOIE26hiHfas8Cmorh8zwv8SPi22i4niL8IMm6N5Jxi3TSYwkbKD/XjJ0bsFxQwGbg==
X-Received: by 2002:a62:76c1:: with SMTP id r184mr29866883pfc.229.1554145569747;
        Mon, 01 Apr 2019 12:06:09 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id v1sm15664781pff.81.2019.04.01.12.06.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 12:06:08 -0700 (PDT)
Date:   Mon, 1 Apr 2019 12:06:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Phil Baker <baker1tex@gmail.com>,
        Craig Robson <craig@zhatt.com>,
        Laura Abbott <labbott@redhat.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-integrity@vger.kernel.org
Subject: [PATCH v3] tpm: Actually fail on TPM errors during "get random"
Message-ID: <20190401190607.GA23795@beast>
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
---
v3: fix never-succeed, limit checks to tpm cmd return (James, Jason)
v2: also fix tpm2 implementation (Jason Gunthorpe)
---
 drivers/char/tpm/tpm1-cmd.c | 7 +++++--
 drivers/char/tpm/tpm2-cmd.c | 7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 85dcf2654d11..faacbe1ffa1a 100644
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
@@ -531,8 +531,11 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 
 		rc = tpm_transmit_cmd(chip, &buf, sizeof(out->rng_data_len),
 				      "attempting get random");
-		if (rc)
+		if (rc) {
+			if (rc > 0)
+				rc = -EIO;
 			goto out;
+		}
 
 		out = (struct tpm1_get_random_out *)&buf.data[TPM_HEADER_SIZE];
 
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index e74c5b7b64bf..8ffa6af61580 100644
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
@@ -328,8 +328,11 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
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
-- 
2.17.1


-- 
Kees Cook
