Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BC8C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 23:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A56C21D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 23:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l1rHJE7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732552AbfIYXmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 19:42:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33149 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfIYXmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 19:42:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so554952pfl.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 16:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YKLbWLWjJ/GA5qz2gzrLI3oAv45tZggVEaoyYmAEWtc=;
        b=l1rHJE7hxxmeTFkh1J9YV8QMV1yV0qFXV/DmDWNsLVb2CYq7qYSUgzimth3Sm/WpfC
         YWcrIQUFR2O2toA2iR/QzLOROQiwG171rBZSbi0sjNtVqYU9zdends52ay6d2mJkaVFC
         FtShBLWc9mElkWRSKgv70PgTH40gn+Tc8nJi53MKUQNJZuSmlje0XLRZvVRfk85PwRL0
         W3vhi922biTqSjfQTQnZD+R33u6YXHQoFZ8QthoyMdEBFMRdrQrhrzyFhUDHaSDfyRVv
         EP6IDGGBXKPs00w/3avZo8yti/H9cxL6e/7vcJNssTDqNu5lRTEuw3edBZQUJPxyoXYH
         XP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YKLbWLWjJ/GA5qz2gzrLI3oAv45tZggVEaoyYmAEWtc=;
        b=VaZVQfk0W/BrR4j/HuEYf2bH6DO7p4gYy3HEEKtlgm7scu5Nnr+zRUbAgotAkEEZ/O
         1Jf+Qd0BVKnnLFGxOqGiXPXlsU08uftkJ6+moHKlDxsaagS8eFqp/5msJeUbYEnTMFvQ
         uh1fpLr/eM48PzDZXi/7ACf+fM5PiJ2MbSF/d5P8Y6GBT9Og5tiHCnoZxRD0VH4QnpBv
         l1WrfXz6Jhn2DB/l2ldCqVIUfNX623GSCb4j958BcNv2bbYVjGAFhb8vvErWLepUrwAc
         Uvd7Un0TE9JrNw6Ukx+fKNXD4Xk/Ap8wMvHMlCjRdQOis52HjumWKvs01Irm5N6QHWhp
         7aNA==
X-Gm-Message-State: APjAAAUyGUri6UV6Oa7x5EqzDLXreC0FH+y3rkp60gIPbQdrR/JpsMtc
        eBa5Y5mXlEykRbqcmHerFKpOXtN/md8=
X-Google-Smtp-Source: APXvYqx/aC5q8MMHMmA8YIA0gNGSPcJcNCThJHGYsY3eE0QwFH+ToKX9bx4/+M03ERzZoDMMHZ0kbg==
X-Received: by 2002:a63:ff1a:: with SMTP id k26mr471666pgi.154.1569454954359;
        Wed, 25 Sep 2019 16:42:34 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id d1sm131127pfc.98.2019.09.25.16.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 16:42:33 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 2/5] usb: dwc3: Execute GCTL Core Soft Reset while switch mode for Hisilicon Kirin Soc
Date:   Wed, 25 Sep 2019 23:42:21 +0000
Message-Id: <20190925234224.95216-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925234224.95216-1-john.stultz@linaro.org>
References: <20190925234224.95216-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Chen <chenyu56@huawei.com>

A GCTL soft reset should be executed when switch mode for dwc3 core
of Hisilicon Kirin Soc.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Yu Chen <chenyu56@huawei.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Yu Chen <chenyu56@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/usb/dwc3/core.c | 20 ++++++++++++++++++++
 drivers/usb/dwc3/core.h |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 999ce5e84d3c..440261432421 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -112,6 +112,19 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
 	dwc->current_dr_role = mode;
 }
 
+static void dwc3_gctl_core_soft_reset(struct dwc3 *dwc)
+{
+	u32 reg;
+
+	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+	reg |= DWC3_GCTL_CORESOFTRESET;
+	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+
+	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+	reg &= ~DWC3_GCTL_CORESOFTRESET;
+	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+}
+
 static void __dwc3_set_mode(struct work_struct *work)
 {
 	struct dwc3 *dwc = work_to_dwc(work);
@@ -156,6 +169,10 @@ static void __dwc3_set_mode(struct work_struct *work)
 
 	dwc3_set_prtcap(dwc, dwc->desired_dr_role);
 
+	/* Execute a GCTL Core Soft Reset when switch mode */
+	if (dwc->gctl_reset_quirk)
+		dwc3_gctl_core_soft_reset(dwc);
+
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	switch (dwc->desired_dr_role) {
@@ -1316,6 +1333,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->dis_metastability_quirk = device_property_read_bool(dev,
 				"snps,dis_metastability_quirk");
 
+	dwc->gctl_reset_quirk = device_property_read_bool(dev,
+				"snps,gctl-reset-quirk");
+
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 1c8b349379af..b3cb6eec3f8f 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1029,6 +1029,7 @@ struct dwc3_scratchpad_array {
  * 	2	- No de-emphasis
  * 	3	- Reserved
  * @dis_metastability_quirk: set to disable metastability quirk.
+ * @gctl_reset_quirk: set to do a gctl soft-reset while switch operation mode.
  * @imod_interval: set the interrupt moderation interval in 250ns
  *                 increments or 0 to disable.
  */
@@ -1219,6 +1220,8 @@ struct dwc3 {
 
 	unsigned		dis_metastability_quirk:1;
 
+	unsigned		gctl_reset_quirk:1;
+
 	u16			imod_interval;
 };
 
-- 
2.17.1

