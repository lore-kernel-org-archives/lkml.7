Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4F2C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5057C2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QKMO16Hz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfFELnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 07:43:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54670 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfFELnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:43:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id g135so1922317wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 04:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FalRLEADzMPtGyW8NIPAA0F5olxzxXGnPVoGFb+myak=;
        b=QKMO16HzOa6yOl0TtOpHhtaz2SlgdqhYZJyTw38c30d4UIeX/UDQnVA2Q9d0ipicdD
         Emx8H2oabCuuVPEsxhBlwmfa+rkssHoxoqRU3YK8BQlbomqW5kzJbpEytzeiEhZgRzTj
         UuIbaCfiENidI6XCj4Q+ItiQk6OwNI+MlfHUM4Ee1wn3nAm4MbEgnWVI2SXMhsKUpm74
         uQFspWBHEtn7jRgazZmuN+pcHm22NJx+aTrImCUgcPsYActEEks62mCVCDgBdhq4xHqV
         aLwalHia+TPEdWi3LiXfCNf8Dzv+nwpo4e0Tsvy22vppNbw+xuPuEpZs6dyJHOhTwxZg
         pP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FalRLEADzMPtGyW8NIPAA0F5olxzxXGnPVoGFb+myak=;
        b=dx/mChoviWRWX5Lzy+5JD88ZGIcQaf+Jlyz9dkTpeveRU2rAfWsxJuJgnkoP4om5eH
         QBQs5N66H3b3QMz3rE3PuPSC3aGlRi6c5CFPZTseopk793thAnWdPjQYSeMY0203ESDq
         U+sPzIyM3Gi/0bbzSFUDx1Dn1OvCAT1obrFjtwUzWN1smXBGP8SWp9mpuAcypFr8hQWO
         YhZ3NZbYZSuc2XS7hRHPxpbprwDiFW7y2SnFRNzSHttK9yQvQKXgDo3QvWvirgc8U3bO
         5qrmAefZh1qzwhz/OhtC7Os2HbzjxqA6Z4fTh2d7/cxL7Hl9fs7mUh3zSj2rvOsqt1vu
         D2RQ==
X-Gm-Message-State: APjAAAWS6ULQWKz8yUDyUXoxVAHWTxY/a9e8SYRuBSsDVBa28FdkLgHg
        oV/p0Xulwazbxine15LBnbUpyHwXAC8=
X-Google-Smtp-Source: APXvYqwEFvsfbNVarbCKn/CaPPWWGkVmIUJ55Mc+kqvQbIA3b9FWJAmPfuM+8mkgIFBS0YNQs5g27A==
X-Received: by 2002:a7b:cb06:: with SMTP id u6mr10100159wmj.170.1559734994798;
        Wed, 05 Jun 2019 04:43:14 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id 34sm27718740wre.32.2019.06.05.04.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 04:43:14 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     alokc@codeaurora.org, andy.gross@linaro.org,
        david.brown@linaro.org, wsa+renesas@sang-engineering.com,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org,
        balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jlhugo@gmail.com, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 8/8] usb: dwc3: qcom: Improve error handling
Date:   Wed,  5 Jun 2019 12:43:02 +0100
Message-Id: <20190605114302.22509-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605114302.22509-1-lee.jones@linaro.org>
References: <20190605114302.22509-1-lee.jones@linaro.org>
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

