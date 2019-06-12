Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64CDC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB84A215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K+P6qWGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439706AbfFLO1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 10:27:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33344 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439683AbfFLO1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:27:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id h19so4418120wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 07:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FalRLEADzMPtGyW8NIPAA0F5olxzxXGnPVoGFb+myak=;
        b=K+P6qWGcKWtU/iGNHzOV9jjR+RXyRp8egtBtmeeUZNHtvIIVBJLVzsH3Vy3gAMuwgR
         Ao6Mudj+9wGNnHwdrOfxdgHdBdIcy5MyVOGRSFy+u/wbSjuIQHDF55F9J3zqhVi/3bzW
         5HtveVGkaSLRv+2iEeE0w1LhFjT4UWtVB79zLW2+qAbLhdEdMRRAWva9Df2T5N4cUgds
         7+g7+Wl3XKZO1rJ7uvAaX/LDxFQBwuJvjUCgufBdOzBsYf9UsfRDcBji+JpUDqmSS7Q4
         /AWCGhD4M9fDnPW+0gkmxkwUaYgWL72BfJzZ7ePa8q3MSEccMjIXUPf0b5gg6hRk1f2l
         pkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FalRLEADzMPtGyW8NIPAA0F5olxzxXGnPVoGFb+myak=;
        b=K9BP8YC9ud3YDubcncuECu9uqVCuUpFoHfvsJTRikb6MzgnOicm1+d9082V7qMPb3A
         rKI4h0S1SwoXMQvqRpNVgsLv5kPwPSX+Puo1N0FlpvAKPq1mZXASWO22gLBDJOc8b0X6
         Rnxx4ppDlrH1F+eHNbgOrpkchApvJlKKFj+Unx2/8IwAVfT6UAvboZnp0fFn5TJCKaaC
         C9y5upYWVPl5MAMqCKqwFFThBYj2Og83c1NLuY6gYdpxTCz3YgGMFrjMLsr3nbwhen2Q
         Vu0dHajvPpY+/Dj/W1jaJsfqxqvz1B8p/D4Ahqa7SoV0tvtCOE1nEfbHCUIuC3rCWBJQ
         a8KQ==
X-Gm-Message-State: APjAAAW+XDnUr69mT1nipvF4tJQa5xwZxicjg+854a72z9XRZY3IkUau
        haiTkL0s2DE8fw22wfV/954Y6mBXCRw=
X-Google-Smtp-Source: APXvYqzjB8dEwMcpuK7RiZ75qjBQSuVJatCq0iH0MPFGa+TZG6aAniFlqCXSYhHK14VPYk4WNlKsjA==
X-Received: by 2002:a1c:1fc2:: with SMTP id f185mr23429895wmf.154.1560349625039;
        Wed, 12 Jun 2019 07:27:05 -0700 (PDT)
Received: from dell.watershed.co.uk ([185.80.132.160])
        by smtp.gmail.com with ESMTPSA id y18sm203959wmd.29.2019.06.12.07.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 07:27:04 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     alokc@codeaurora.org, agross@kernel.org, david.brown@linaro.org,
        wsa+renesas@sang-engineering.com, bjorn.andersson@linaro.org,
        balbi@kernel.org, gregkh@linuxfoundation.org,
        ard.biesheuvel@linaro.org, jlhugo@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-usb@vger.kernel.or,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v4 6/6] usb: dwc3: qcom: Improve error handling
Date:   Wed, 12 Jun 2019 15:26:54 +0100
Message-Id: <20190612142654.9639-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190612142654.9639-1-lee.jones@linaro.org>
References: <20190612142654.9639-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dwc3_qcom_clk_init() is called with of_count_phandle_with_args() as an
argument.  If of_count_phandle_with_args() returns an error, the number
of clocks will be a negative value and will lead to undefined behaviour.

Ensure we check for an error before attempting to blindly use the value.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 55ba04254e38..e4dac82abd7d 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -409,6 +409,9 @@ static int dwc3_qcom_clk_init(struct dwc3_qcom *qcom, int count)
 	if (!np || !count)
 		return 0;
 
+	if (count < 0)
+		return count;
+
 	qcom->num_clocks = count;
 
 	qcom->clks = devm_kcalloc(dev, qcom->num_clocks,
-- 
2.17.1

