Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47718ECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A36217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lGAST+mY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403830AbfJPDdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 23:33:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43429 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403812AbfJPDdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 23:33:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id i32so13390661pgl.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 20:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+L6QotxBXClg8Fe4NEIvH2M7vhWfz5AENh5gfCd6GV4=;
        b=lGAST+mYnUw2+fFUvOyyVN68vAR+ZDOyy8WoR3kjWo+W2+qfO342xlBSDzAujCE92W
         xE0pXYq5oYJMudqdUUTFcA4aWTLpzR+HCUmB2mLqubMM06EZSAOSYJjIUw4X7hTl3wuZ
         nuUIgEUQvBCjVCKdCz7w+QZpLjGw9uKQAXLeecMbO1I9Jv6BXS5VvWMhSILKzjD9zOKQ
         13+n9QYnIPx0gCFbGdo1DDHBdarXxErH5EaN8Pyqbtxwar/4fbU5+fiWPJ2fPmqi1oJM
         +YU3v3GRs0ICUUyn1sNwz9LHFqOGijZHx5d3agCBmyOak2HuwQbcxym7UyWvVtNxdO5H
         0a8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+L6QotxBXClg8Fe4NEIvH2M7vhWfz5AENh5gfCd6GV4=;
        b=S5mT30j2J/wp2UJRs6rB4Wm2ylCDY6seFTqV0df42J+dsu991SdhyZQfXt2/edeZ4y
         +eVWSLbrgusrhODCnOAhZDgHfaIsq94goqjONyTlSCXfV0TtFO0sL8joQWIURvru6gKn
         Dc8sN+W917Av26NHpCd7invk2Zj4A2SU8pK6LiWq5VQwkbDp1gkePTld+9i8Nl3UmO7W
         ComMh9V7DyLcfRuuaS6YTCXhMaKN01WVGt1QHnxf1GbdD9GfWhaqW+nRnVcxNQfHYZxe
         gjjSSVwRuPorAiexalKWtf4DMG26NHU7q47Wcn5LbOkrwpzg6HxWeQglsN8mP1zthTNf
         HReA==
X-Gm-Message-State: APjAAAWLg0Fkb3Cjvwa7DWbvbhSCSb+xr79xUEiMgB12LlDUkauHeQDD
        ef1eZemONIstRRX1VwfFMIP0WzeAYD4=
X-Google-Smtp-Source: APXvYqx4mHE3Pk26QZ2wQVQI9bb5Z31XRA2QB6VDKjNpj4Ri/jYSuBD2qTj2kfwGMLGU4KLE6yoqJA==
X-Received: by 2002:a63:d457:: with SMTP id i23mr42038764pgj.276.1571196826240;
        Tue, 15 Oct 2019 20:33:46 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id l23sm748356pjy.12.2019.10.15.20.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 20:33:45 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, John Stultz <john.stultz@linaro.org>
Subject: [RFC][PATCH v3 02/11] usb: dwc3: Execute GCTL Core Soft Reset while switch modes
Date:   Wed, 16 Oct 2019 03:33:31 +0000
Message-Id: <20191016033340.1288-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016033340.1288-1-john.stultz@linaro.org>
References: <20191016033340.1288-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Chen <chenyu56@huawei.com>

On the HiKey960, we need to do a GCTL soft reset when
switching modes.

Jack Pham also noted that in the Synopsys databook it
mentions performing a GCTL CoreSoftReset when changing the
PrtCapDir between device & host modes.

So this patch always does a GCTL Core Soft Reset when
changing the mode.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
CC: ShuFan Lee <shufan_lee@richtek.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Yu Chen <chenyu56@huawei.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jun Li <lijun.kernel@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Jack Pham <jackp@codeaurora.org>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Yu Chen <chenyu56@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v3: Remove quirk conditional, as Jack Pham noted the
    Synopsis databook states this should be done generally.
    Also, at Jacks' suggestion, make the reset call before
    changing the prtcap direction.
---
 drivers/usb/dwc3/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 999ce5e84d3c..a039e35ec7ad 100644
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
@@ -154,6 +167,9 @@ static void __dwc3_set_mode(struct work_struct *work)
 
 	spin_lock_irqsave(&dwc->lock, flags);
 
+	/* Execute a GCTL Core Soft Reset when switch mode */
+	dwc3_gctl_core_soft_reset(dwc);
+
 	dwc3_set_prtcap(dwc, dwc->desired_dr_role);
 
 	spin_unlock_irqrestore(&dwc->lock, flags);
-- 
2.17.1

