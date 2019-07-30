Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DE9C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0097F2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g7NxQfqo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfG3SRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:17:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41634 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388167AbfG3SQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so20131573pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ejbky3Ait/2fuVRBv/Aea0ZW9E8YvQRjIE68KrxG858=;
        b=g7NxQfqoHmAHu6FjiviV+l42gg60rayxYXW9umctHkawL0+ZOaMmX4rSGjSIgYitw/
         JwYphBkhREl0mc9HGhGRpP4mJRGKBlCHFsIf4zXpF7AwUnneoonMz0J6Fi+rLAp6N6PY
         M/6I/sE+dEfMD36MCDCUmiNTGgs+7tt2vwqqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ejbky3Ait/2fuVRBv/Aea0ZW9E8YvQRjIE68KrxG858=;
        b=gKaupRK5VrSWxSOtWPG36iBENaaEEIL7m3UdfOp6kxH2rd8QQeD1fJt8AvK42hj0Zv
         tVnAEMgPJcjoZx9qI2Rge1Qt/iPKNjsEXOwOv4OGbVzcjuAPzWhHWvCMXN9Qi8/Ent3U
         KL0iAmwDm2HEsNpI3NJ38BpL1xH/N3VB1V0TbTxmilUpqDO8KSdu0GkMmv6hOAWPTVh5
         47BsvauFrpG0n0KTr5ov0lTHHVLD2HUGwQmFpmUyiZrFvdZfmt1db8hpw2stTXKS1Noa
         HdBBiTiLgOUE5EDXD3IMq4o1vEorIzmRVAjqXxCOxFpKrHfWtOpRA6fYYrfqRnhVT/yA
         TdLQ==
X-Gm-Message-State: APjAAAUC2/7bKuJsTMw9QM/bwYuEs6gQ8ivUSpycclkfSl59p0K264Ss
        r3R7VvjNwMP/gTKQdLs2FVCniKS5s6BmlA==
X-Google-Smtp-Source: APXvYqzaS9Quj+uj+10jY75vRg+7pd4gpdEfZ85MzPRqS6VPRENa+I85aezt52LGvJ1whXawhY8vFg==
X-Received: by 2002:a65:680b:: with SMTP id l11mr15407071pgt.35.1564510605774;
        Tue, 30 Jul 2019 11:16:45 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:45 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 56/57] scsi: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:56 -0700
Message-Id: <20190730181557.90391-57-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/scsi/ufs/ufshcd-pltfrm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
index d7d521b394c3..f84943553454 100644
--- a/drivers/scsi/ufs/ufshcd-pltfrm.c
+++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
@@ -404,7 +404,6 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "IRQ resource not available\n");
 		err = -ENODEV;
 		goto out;
 	}
-- 
Sent by a computer through tubes

