Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94BAC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9267E20859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ErpuCgIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388606AbfFJIm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 04:42:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40116 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388430AbfFJImZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 04:42:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so7280444wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 01:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FalRLEADzMPtGyW8NIPAA0F5olxzxXGnPVoGFb+myak=;
        b=ErpuCgIKx7tdIhXc0Vgq27YYh5IdzYS8ZROzqkhZo992Lvnn19vfhbIqZzxfQ10161
         q/yb5S3UOlu7jVewR6gPOHtopPzH2mIm47P8H5DIDXJkkAvu/fVLeYL+XDHodIfbmI/Q
         CKa9e4AABXjZuSQiUwSxAL/oBnskNHq1jEInWN4Q5Tp+sQdhRKsiH2TxkMt482GTBNR7
         aY1rlYW3/QXDuFLndlbV2tpu9/XuFDuowc7j5gTlPoBAZBoUbY32p3JHHxZM6+39iUMi
         I88QsPzhpoQOgqfRr4ELN1VJv09S0GcBFZHzKYKYqObfTb0uzFEHbnk2tmqKPOZqSUBm
         gHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FalRLEADzMPtGyW8NIPAA0F5olxzxXGnPVoGFb+myak=;
        b=Ex6dGnHx1kiXkPhSYzjDklpUJYmlB8QBbofxqYVN7O/n5KAsNIKzNtTfXQgeNkCoFk
         5UTrQER+6tOgWrXBqKGKWoTpV/JmuDVGn2g2JJNzcBpAAco93oJCS8gUgwyeu8d/2KEB
         UCe1Hx8Wt2/y6429le1tQtTXy89WLbQWYtMtp0USXY0xtmwzA4u7dUFrLrcjdE2GqnLm
         ZqmVSIRkJXyOrAFi7C5uxXfp2a46nFC5gpJrJHstFFz/FazPcCJj2sdH5J/cI/AmwFnq
         kI/Y+Af12F1Qpu3C8/CRrVPAkqSUYw3qNGopJWOx2UCHKcyU98mYXFNhQhL2X5z6+caU
         2sGg==
X-Gm-Message-State: APjAAAVV9J9p7KsXZXQb+50A877uItfZQJOw6IwdDX1nT5r8Tjdbv7+d
        aUo6td+wGMJtUymUYnvYMylB3g==
X-Google-Smtp-Source: APXvYqyC2APpf/zAbitrU/BjHOuyVW/f2vbj2/AUhh+FVA31orPg+ghJwVZnl4+ZvUlYkGglrWpA1w==
X-Received: by 2002:a1c:35c9:: with SMTP id c192mr12941297wma.147.1560156143556;
        Mon, 10 Jun 2019 01:42:23 -0700 (PDT)
Received: from localhost.localdomain ([2.31.167.229])
        by smtp.gmail.com with ESMTPSA id a125sm9929670wmf.42.2019.06.10.01.42.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 01:42:23 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     alokc@codeaurora.org, andy.gross@linaro.org,
        david.brown@linaro.org, wsa+renesas@sang-engineering.com,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org,
        balbi@kernel.org, gregkh@linuxfoundation.org,
        ard.biesheuvel@linaro.org, jlhugo@gmail.com,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 8/8] usb: dwc3: qcom: Improve error handling
Date:   Mon, 10 Jun 2019 09:42:13 +0100
Message-Id: <20190610084213.1052-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610084213.1052-1-lee.jones@linaro.org>
References: <20190610084213.1052-1-lee.jones@linaro.org>
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

