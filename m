Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D2AC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 09:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1A82086C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 09:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kBpAVqCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfHRJjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 05:39:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46449 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfHRJjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 05:39:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so5624174wru.13
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 02:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LxvxKTPsHiH7UyfUtgY+QrOf6MaZaGNFhraZnj8cu+w=;
        b=kBpAVqChwEj7CrYLYsV9bO+MmvHHN4/ns32u8ZjkZBg5oUYPHdHEQ5tBdamPXCnYO6
         unlnqHRujP58MV9zddJB+YEFtAEKlDwbDUlWCC3cAJIKWyHfcYRcYjziJBeWOuRUXnQ8
         MvSUSy6HG3IUSojO7yDeFwM9W7gLEG8P5iy7szskAyTiUHAROVUxd54QsrkMhri/rJyR
         1s+1AXo/+qfUofTP3inpaMP9QiQS3Ed9S7/DXxg+dI1cBlRyksJ6/hWun8S5cInaEztp
         P2KC/8Qlm8787ff17y3K8Oc+7Ods1Ss6qhEzCGv83jLAOtVqziL48K2CHEO89XNXdzBN
         uwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LxvxKTPsHiH7UyfUtgY+QrOf6MaZaGNFhraZnj8cu+w=;
        b=O2eSNSjfkXVPJSZ6ysEeTOl49qU8IZnd+sl9w4JDX1DgpJ9bagCtlsqlImyhq0KMZl
         MnTGHSkOTtXlhf6LlQJGcpM7DgMqq5LPCUZHNDW3RX8SKzuVl+naX98O49/ZQ2/Q7p8A
         NRhNYMe3vKEIj5n52oUE5xyMtq2IOv03t8C6dgmQkaBp/7qYf0iLTbufBbgUt7oysBBU
         qEoPiQWefpletmA/0Dg6PBzhrkc+SFFpIVhshWFdVk8132YlUuKxpT4GjhIz8fu+7oIK
         n+CpNQcjdMvnc5BcKh7Pph0dbpl0YOA/g8igO/Dx7s+tbxb4Zcsf8NkQH0YvLwvgGgNj
         BnOw==
X-Gm-Message-State: APjAAAXCdcVQt3gMEVVa2MkkQx7KdINTQxMogbAXHk/0JtaPbx1ODCrC
        u4K/nHh5Yp5rw9ZadGGPrv8LCg==
X-Google-Smtp-Source: APXvYqyKFE0hJikbUGh05bHqv1ExX27XnQDau5vQi7YgBI/GHDj5Lrq+BPUYdDtV4DwqB2RRsPcmPA==
X-Received: by 2002:a5d:4ecb:: with SMTP id s11mr12491768wrv.323.1566121173145;
        Sun, 18 Aug 2019 02:39:33 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q3sm11520190wma.48.2019.08.18.02.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 02:39:32 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] slimbus: qcom-ngd-ctrl: Add of_node_put() before return
Date:   Sun, 18 Aug 2019 10:39:01 +0100
Message-Id: <20190818093902.29993-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190818093902.29993-1-srinivas.kandagatla@linaro.org>
References: <20190818093902.29993-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishka Dasgupta <nishkadg.linux@gmail.com>

Each iteration of for_each_available_child_of_node puts the previous
node, but in the case of a return from the middle of the loop, there is
no put, thus causing a memory leak. Hence add an of_node_put before the
return in two places.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index f3585777324c..29fbab55c3b3 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1338,12 +1338,15 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 			continue;
 
 		ngd = kzalloc(sizeof(*ngd), GFP_KERNEL);
-		if (!ngd)
+		if (!ngd) {
+			of_node_put(node);
 			return -ENOMEM;
+		}
 
 		ngd->pdev = platform_device_alloc(QCOM_SLIM_NGD_DRV_NAME, id);
 		if (!ngd->pdev) {
 			kfree(ngd);
+			of_node_put(node);
 			return -ENOMEM;
 		}
 		ngd->id = id;
-- 
2.21.0

