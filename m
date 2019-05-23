Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EBAC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3072B21019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="peBQCQTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbfEWMyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:54:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36158 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbfEWMyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:54:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id a3so3111092pgb.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 05:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PxeLHI+jcJnNa8egh+nhhwEm8X7EMV+hjf297FNmO2k=;
        b=peBQCQTsOhZRPBlQhXGKjX9BmJCm8odmIaIdt9AnoBnHuLuHgBSIXKze8HoLcLodx8
         88zvIel1MVoqD70UqU0d105JJNVD6H45YVT8ukmGTeINvYrVwbVAq99W+/3EMHSFu79x
         a9SuvDw1Perwg9+I1hzp8+WrgIt0MLVSOz021DaYE2pY6y3n5bwN2lSwdQhUA33W+WYu
         H/tb+45zUX2AC1E+N/eai3SA4M03ghD0k8Ne4ccQHQEtAQMZniNsrAOereY6Hg1xhXpy
         rvwNkm5FJ2VMWSIR8Hrnw4zJs1UyEvsPXi7pgLKnkbAq2Z/19DJzAjKc4+nh/8fslNbX
         AMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PxeLHI+jcJnNa8egh+nhhwEm8X7EMV+hjf297FNmO2k=;
        b=fnN1ijtCUKFaBM3Gmoofge5R9j4xPoBw2rarrI78ArkrCQFAGQoT4XR5DmSuMScuId
         8J38KKKXsohucT6my3Oz7UBIrwHUhiKNHheqL2Dj7F/5YwkV4XPGgogcfyIhlJIpF2em
         CY6y5Wkux5CVaxSXnieA4kcsUfGkMdYWF7gcXuaFaXR4l8PHkzNFFF2rKTY83O/f9T0g
         5jYV9PT/gu0UVpzptzx8cbKJKjlLrXHEtTP1WUXNeObq8wACyRGv7UH271Hd6IxCuDBR
         AiCviuhYibtADtXiFF1vNfTeh6zw9HGB+GquuChxtBTZtZJ1hv+Y9/AEyy1qH5gA1hGz
         lQsQ==
X-Gm-Message-State: APjAAAVykARKERAg7oavNChNK0mdXeeMJ+Z/hendUzs4neUbbXoxWjsd
        lNyohDh5Jf1t2/82+6sT/YQ=
X-Google-Smtp-Source: APXvYqxV4KBmIXZqYjcYRuW7xGgYl0YjuSZmNGQlm0u6NJ3EFrA8/HTX+//gsnRZZM/zz+A7JhRanA==
X-Received: by 2002:a63:4a16:: with SMTP id x22mr5750690pga.219.1558616059112;
        Thu, 23 May 2019 05:54:19 -0700 (PDT)
Received: from localhost.localdomain ([122.163.94.48])
        by smtp.gmail.com with ESMTPSA id w12sm27355248pgp.51.2019.05.23.05.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 05:54:18 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     gregkh@linuxfoundation.org, straube.linux@gmail.com,
        realwakka@gmail.com, hle@owl.eu.com, rico.schrage@gmail.com,
        sophie.matter@web.de, weiyongjun1@huawei.com, jbi.octave@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH v2] staging: pi433: Remove unnecessary variable
Date:   Thu, 23 May 2019 18:23:41 +0530
Message-Id: <20190523125340.29338-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable retval is assigned constant values twice, and can therefore
be replaced by its values.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
Changes in v2:
- Add Wei Yongjun to the recipients list
- Fix From and Signed-off-by fields

 drivers/staging/pi433/pi433_if.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index c889f0bdf424..40c6f4e7632f 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -871,7 +871,6 @@ pi433_write(struct file *filp, const char __user *buf,
 static long
 pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
-	int			retval = 0;
 	struct pi433_instance	*instance;
 	struct pi433_device	*device;
 	struct pi433_tx_cfg	tx_cfg;
@@ -923,10 +922,10 @@ pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		mutex_unlock(&device->rx_lock);
 		break;
 	default:
-		retval = -EINVAL;
+		return -EINVAL;
 	}
 
-	return retval;
+	return 0;
 }
 
 #ifdef CONFIG_COMPAT
-- 
2.19.1

