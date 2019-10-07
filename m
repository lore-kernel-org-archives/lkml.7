Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB46C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C3520684
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x1nWDenY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbfJGR4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:56:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45315 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbfJGR4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:56:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id q7so8629869pgi.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 10:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oFS6SaDoQ5fogHAHlhUMYfV/B7rrjNj6XYxhAXSXdHY=;
        b=x1nWDenY+0OgbS5Si4sl4DdYea+ca+L0YaFIzXKakFAoV8rokW8Wv4O9U4fSg4XRT3
         C36yiu+wbHF79WBypFf0D+jFIoGAugRVQALrQvA4zgQpwlAKaFe18wS0DG4ys81258Xg
         wgVcnDbTcYXFQ5a8ynD7RjXxF6GJRLeReKA3BBb1Pledy4pQNOgHWFZE4HNvX4cuLe2Y
         AnKZ+FLYTAUg3PJjrc2pUo26D4LnXuAiz8pV5Z9XiIjb7C+LtjsvwGCKtkfwh7TF0mNW
         tcEOos93Wrae9VkosnEAjX2oowhtK4u159OFqQL2v1Hlwc9MHeD5i9FPvfFkifEd8ISf
         lhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oFS6SaDoQ5fogHAHlhUMYfV/B7rrjNj6XYxhAXSXdHY=;
        b=swfy9Gt4Aeaw+RWSToMJcv3S+bFmX6/44wFEt7IAtW596tzSC7+U/o7g8bxTyJ/NLM
         sED/DTGgaciKAL+ZJBA3RZrYs54NHSZaVGZNsbwktWQzLrDqpdQarQZkqo7wjhUN33dC
         H843mmAaYClebCZc76HBHqk6xxXp06X3dxeyf8rFfuWi7pbvBy0NWnhdz+8lPGeQvGnT
         NZ8+iRwUczzotTci9SFEBaIgsPh9A9NH28OUCroOUuM+YsnIKh599V799uMPug38ZrU4
         be8ANf9BimD7tVSbq2VEvjQUqOgQpAnnCIOAQcCNNsY3lpCem7E2x2No5PtCE/1g81Z2
         UxOQ==
X-Gm-Message-State: APjAAAUgwCaQFQ8LLzrgxR+nZyzn2dlLDMc5q/Rweo+lxicnafmy24DQ
        69UizOtVq38HFseD1Om7DyeVv1dVCok=
X-Google-Smtp-Source: APXvYqwMP8ygmDxBtrmpiUIThUb/AoKHCnnSdgO0txYlKecbRvRqSCa7T55269OWxjGj1A/VvCtLzg==
X-Received: by 2002:a62:ab04:: with SMTP id p4mr34552992pff.227.1570470965054;
        Mon, 07 Oct 2019 10:56:05 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id k15sm3820096pgt.25.2019.10.07.10.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 10:56:04 -0700 (PDT)
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
Subject: [RFC][PATCH v2 3/5] usb: dwc3: Increase timeout for CmdAct cleared by device controller
Date:   Mon,  7 Oct 2019 17:55:51 +0000
Message-Id: <20191007175553.66940-4-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007175553.66940-1-john.stultz@linaro.org>
References: <20191007175553.66940-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Chen <chenyu56@huawei.com>

It needs more time for the device controller to clear the CmdAct of
DEPCMD on Hisilicon Kirin Soc.

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
 drivers/usb/dwc3/gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 8adb59f8e4f1..81907e163252 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -270,7 +270,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
 {
 	const struct usb_endpoint_descriptor *desc = dep->endpoint.desc;
 	struct dwc3		*dwc = dep->dwc;
-	u32			timeout = 1000;
+	u32			timeout = 5000;
 	u32			saved_config = 0;
 	u32			reg;
 
-- 
2.17.1

