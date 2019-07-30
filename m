Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7463C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F4C205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BEkIkKCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbfG3VgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 17:36:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35232 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbfG3VgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 17:36:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id u14so30530703pfn.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 14:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7h4V6pFvz5YMnkeEk6oaxnljHZqVDHeBg8oie3blmAc=;
        b=BEkIkKCJibvwYxWGtcT3q4f8D2+LIADBHvxlEFw8n0cuKAu/ZcNLfxfDnszgF16OSn
         A08Hus67n8AzZRxcHG6uCOnJ089KVjiiW6zDS7ykAV1Wr4qXzyI1VFjd9C2gwfAGHkRC
         EwUnlPC6fqXy8M/HoSYC2nWqXrGG3untxlTlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7h4V6pFvz5YMnkeEk6oaxnljHZqVDHeBg8oie3blmAc=;
        b=oT6lmZ+1WPRSpIgaUq15aS0tnFS2cGfVZAI8Tg0mt+x6dHMu2ZEVPxynDagmIcUCVk
         NMPczEQGCRzDZS2ezlQdMrE9QKTDSsoiLbg3ti7xsHZShV2y8p7APdwKKD43RhqwMNTT
         0LFI2WXSB/m8LJTVaMxICfPPnkjPNYR2oxxcpt4xZK+Ya2MfB7MNiUDFEiBfIT2PT/Wo
         /fGLI002f3XrdxvZTK2vRWTNBOWOBoMQXb7vUNPZxkPFdHYl3EKnZgIEa2wTSZFmaEyC
         5DRV1+3loaikE3EIP+pyZxqdc4YzRmrXHPELmUgBtR+Q3EvB3hJHK0u1mdLX3FxII1mJ
         fyIw==
X-Gm-Message-State: APjAAAUbMHilB/bXLGYgTxxRaxE7sfqxnNfL2uJQD4bCIBOVaPnAGSW6
        pmCQYquvE/mI9pUkLqskQQCC45gq/5794g==
X-Google-Smtp-Source: APXvYqyPwOaFo/kiaRbe4SmFEQ46K5Ck5hCnvC//EjWdpVZmSbRXyHKjOjLKfRZ+NFb4rvxK1UzHHw==
X-Received: by 2002:a17:90a:f488:: with SMTP id bx8mr118008574pjb.91.1564522570164;
        Tue, 30 Jul 2019 14:36:10 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id p26sm14046937pgl.64.2019.07.30.14.36.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 14:36:09 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v7 2/2] soc: qcom: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 14:36:07 -0700
Message-Id: <20190730213607.171156-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730183503.GX7234@tuxbook-pro>
References: <20190730183503.GX7234@tuxbook-pro>
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

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/smp2p.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index c7300d54e444..07183d731d74 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -474,10 +474,8 @@ static int qcom_smp2p_probe(struct platform_device *pdev)
 		goto report_read_failure;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "unable to acquire smp2p interrupt\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	smp2p->mbox_client.dev = &pdev->dev;
 	smp2p->mbox_client.knows_txdone = true;
-- 
Sent by a computer through tubes

