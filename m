Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31208C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFEC22CF5
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfH2U1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 16:27:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbfH2U1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 16:27:12 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 04876821C6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 20:27:12 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id y67so4876377qkc.14
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 13:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=1UoUxHgTB5Uy/aybY3C3VZnWVwFk7FnjRDCSMP/k6AQ=;
        b=tpz4+bcuoi9xVcCVkStnRfXj48Wo1hMN9ZmCCR+DxbVioeRC/M8h1FnMxQKTOHqw5K
         Avq4ll2GuWOpGoj8FAikk+249WOAtthv3fqWDHEseOlImMKE0mXj3t7mmJBygWSqGiyY
         Kv10CQvFX0aNK6/xb9YILW/Uo6gySYqSv5MUU/dSDJ7/ZUiB+S3cyWeEj+LCFwyiWgPI
         R9lXzfJ0b1zgFz6gQhflm5zJPb1+S2PTa1xlGRVvh58z+z39v3QDoAJ9bWqNs/ONXIGU
         7AYjClPAe5BI372ymiV8bkzSOB75mk1vnvxKLYUpnTdZUs0Bzrd6VRXDeYDwBtlu5lEr
         vZZg==
X-Gm-Message-State: APjAAAUmhiS4FoSTSTurUq6EuDOmzL0Nx3ISiXnuHK8fLNkvQcire+Fz
        eFNoIYiI9AHwhOt9aCo1iq5PdzOcxwTCWkrz+b94DdezS8HyHxCSULsNC6UtsyLdrsVT5kNPmPW
        4Q/LIoPtttNLalXJBo7Um28BM
X-Received: by 2002:a0c:a9dc:: with SMTP id c28mr7934798qvb.85.1567110431215;
        Thu, 29 Aug 2019 13:27:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzou5DOWqWSIgnTW6q4WMuRuBZoLmxtqrS/C4RFDH2yaHyECoBCV8xLCVVixTyw+4t38Nq/Sw==
X-Received: by 2002:a0c:a9dc:: with SMTP id c28mr7934780qvb.85.1567110430961;
        Thu, 29 Aug 2019 13:27:10 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id t124sm1969478qke.31.2019.08.29.13.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 13:27:10 -0700 (PDT)
Date:   Thu, 29 Aug 2019 13:27:08 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        Alexey Klimov <aklimov@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Remove duplicate code from caps_show() in
 tpm-sysfs.c
Message-ID: <20190829202708.pspcjy4etbq4jmwd@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, Alexey Klimov <aklimov@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190829143807.30647-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190829143807.30647-1-jarkko.sakkinen@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Aug 29 19, Jarkko Sakkinen wrote:
>Replace existing TPM 1.x version structs with new structs that consolidate
>the common parts into a single struct so that code duplication is no longer
>needed in caps_show().
>
>Cc: Alexey Klimov <aklimov@redhat.com>
>Cc: Jerry Snitselaar <jsnitsel@redhat.com>
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>---
>Jerry, Alexey: Plese include this to the next version of your patches.
>This a low priority patch alone so it does not need to be merge upfront.

Will do. I'll add my Reviewed-by and Tested-by to it and submit it with v3.

> drivers/char/tpm/tpm-sysfs.c | 44 ++++++++++++++++++------------------
> drivers/char/tpm/tpm.h       | 23 ++++++++-----------
> 2 files changed, 32 insertions(+), 35 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
>index edfa89160010..8064fea2de59 100644
>--- a/drivers/char/tpm/tpm-sysfs.c
>+++ b/drivers/char/tpm/tpm-sysfs.c
>@@ -217,6 +217,7 @@ static ssize_t caps_show(struct device *dev, struct device_attribute *attr,
> 			 char *buf)
> {
> 	struct tpm_chip *chip = to_tpm_chip(dev);
>+	struct tpm1_version *version;
> 	ssize_t rc = 0;
> 	char *str = buf;
> 	cap_t cap;
>@@ -232,31 +233,30 @@ static ssize_t caps_show(struct device *dev, struct device_attribute *attr,
> 	str += sprintf(str, "Manufacturer: 0x%x\n",
> 		       be32_to_cpu(cap.manufacturer_id));
>
>-	/* Try to get a TPM version 1.2 TPM_CAP_VERSION_INFO */
>-	rc = tpm1_getcap(chip, TPM_CAP_VERSION_1_2, &cap,
>+	/* TPM 1.2 */
>+	if (!tpm1_getcap(chip, TPM_CAP_VERSION_1_2, &cap,
> 			 "attempting to determine the 1.2 version",
>-			 sizeof(cap.tpm_version_1_2));
>-	if (!rc) {
>-		str += sprintf(str,
>-			       "TCG version: %d.%d\nFirmware version: %d.%d\n",
>-			       cap.tpm_version_1_2.Major,
>-			       cap.tpm_version_1_2.Minor,
>-			       cap.tpm_version_1_2.revMajor,
>-			       cap.tpm_version_1_2.revMinor);
>-	} else {
>-		/* Otherwise just use TPM_STRUCT_VER */
>-		if (tpm1_getcap(chip, TPM_CAP_VERSION_1_1, &cap,
>-				"attempting to determine the 1.1 version",
>-				sizeof(cap.tpm_version)))
>-			goto out_ops;
>-		str += sprintf(str,
>-			       "TCG version: %d.%d\nFirmware version: %d.%d\n",
>-			       cap.tpm_version.Major,
>-			       cap.tpm_version.Minor,
>-			       cap.tpm_version.revMajor,
>-			       cap.tpm_version.revMinor);
>+			 sizeof(cap.version2))) {
>+		version = &cap.version2.version;
>+		goto out_print;
> 	}
>+
>+	/* TPM 1.1 */
>+	if (tpm1_getcap(chip, TPM_CAP_VERSION_1_1, &cap,
>+			"attempting to determine the 1.1 version",
>+			sizeof(cap.version1))) {
>+		version = &cap.version1;
>+		goto out_ops;
>+	}
>+
>+out_print:
>+	str += sprintf(str,
>+		       "TCG version: %d.%d\nFirmware version: %d.%d\n",
>+		       version->major, version->minor,
>+		       version->rev_major, version->rev_minor);
>+
> 	rc = str - buf;
>+
> out_ops:
> 	tpm_put_ops(chip);
> 	return rc;
>diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>index a7fea3e0ca86..a4f74dd02a35 100644
>--- a/drivers/char/tpm/tpm.h
>+++ b/drivers/char/tpm/tpm.h
>@@ -186,19 +186,16 @@ struct	stclear_flags_t {
> 	u8	bGlobalLock;
> } __packed;
>
>-struct	tpm_version_t {
>-	u8	Major;
>-	u8	Minor;
>-	u8	revMajor;
>-	u8	revMinor;
>+struct tpm1_version {
>+	u8 major;
>+	u8 minor;
>+	u8 rev_major;
>+	u8 rev_minor;
> } __packed;
>
>-struct	tpm_version_1_2_t {
>-	__be16	tag;
>-	u8	Major;
>-	u8	Minor;
>-	u8	revMajor;
>-	u8	revMinor;
>+struct tpm1_version2 {
>+	__be16 tag;
>+	struct tpm1_version version;
> } __packed;
>
> struct	timeout_t {
>@@ -243,8 +240,8 @@ typedef union {
> 	struct	stclear_flags_t	stclear_flags;
> 	__u8	owned;
> 	__be32	num_pcrs;
>-	struct	tpm_version_t	tpm_version;
>-	struct	tpm_version_1_2_t tpm_version_1_2;
>+	struct tpm1_version version1;
>+	struct tpm1_version2 version2;
> 	__be32	manufacturer_id;
> 	struct timeout_t  timeout;
> 	struct duration_t duration;
>-- 
>2.20.1
>
