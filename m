Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBB2C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D60A20CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oaiyNUFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbfILJLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:11:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36694 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730327AbfILJLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:11:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id y19so27586283wrd.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 02:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BNNdf6pK+mCx6ftnRWMxKvAZQ+4ajUB9tHI29q1KvNY=;
        b=oaiyNUFi3itForwHOvFSiPV4hFujOxmXjG5fhYeq+683YOgScQNtDfl9ekjlX6U0QB
         xh9eA6o8aHoCYIipSvuzwxIrqmuDfZg0R5z+YUu4531OzTB6ZGeK/jOjPDd1tM2nyWRH
         DsfUti3RTJM4wdKDk1bcSNRVzn8KBAq75pDwvX3jNHzVfaf+m7dfyvnV7tn26NHpWZfT
         m+Hsymx0O+uxkOP7MOnMfBNhpVNTqsLlAE5gfC6/rQW3CZjl07XDQW2/wa1Y51prYf0D
         97fNU5THdwVKJWsodDewvSJP4rTyCKqfdvxBrwuSIUiWrel+ijABtNPaZ7i+oFcG3VXD
         87fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BNNdf6pK+mCx6ftnRWMxKvAZQ+4ajUB9tHI29q1KvNY=;
        b=a1g8QoLhuH4STlPuSQdPlb84mg9l0GY/2USwkbv/G1hs1rIo9BtajoX0zD8H+S03iA
         c/B1WNHHihLJ0YmsmwnmjZK8KIjKY4i+aQCXpEV0Ix+FW6f5aBPKyiKqQcnoflsQgMxn
         TzlyCylHoULfQWO/Iqza3aKfHEpCBNxwMIS6Sqwg+qBQcNsx7o1gPhZ3E3GxWKPpJp/h
         tQi1vIxooFkJ2ibrdSebxPlgLaa9LjJtNY+As0fzUb50DCKpMH9fL6QvKGz6/ImhIde3
         BtSsp+lDs6GFNcuuZp8Ion2fpYMnjnBypwwO081tgOa0HnSCPEatkURVlM9ShfmnyMsg
         mVaw==
X-Gm-Message-State: APjAAAXguFu40UFQmLrkCvovCsWpZMrvt80p5A3nlSMvzWc7s/Ij/ooc
        vb0k98d4cOHEnldXC3qQMc6v1A==
X-Google-Smtp-Source: APXvYqzA/o7qluqOpXXnZQUZ3Gav6EZgPQqH/7DI4tf2PWyXyXMLcq/31ofd3vX8/sVl/DyJiR6Wxw==
X-Received: by 2002:a5d:6703:: with SMTP id o3mr10910294wru.335.1568279460416;
        Thu, 12 Sep 2019 02:11:00 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id g185sm11016899wme.10.2019.09.12.02.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 02:10:59 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     andy.gross@linaro.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] soc: qcom: socinfo: add sdm845 and sda845 soc ids
Date:   Thu, 12 Sep 2019 10:10:56 +0100
Message-Id: <20190912091056.5385-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing soc ids for sdm845 and sda845

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soc/qcom/socinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 855353bed19e..8dc86a74559b 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -198,6 +198,8 @@ static const struct soc_id soc_id[] = {
 	{ 310, "MSM8996AU" },
 	{ 311, "APQ8096AU" },
 	{ 312, "APQ8096SG" },
+	{ 321, "SDM845"},
+	{ 341, "SDA845"},
 };
 
 static const char *socinfo_machine(struct device *dev, unsigned int id)
-- 
2.21.0

