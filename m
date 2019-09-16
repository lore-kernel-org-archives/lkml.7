Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897C7C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 16:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A776214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 16:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hj6QoIN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389781AbfIPQPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 12:15:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46779 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389726AbfIPQPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 12:15:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id a3so248668pgm.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 09:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RtuYujDQbGoE383NaOTW8yNTTYMDfvcRIoYrv77xBo0=;
        b=Hj6QoIN6KZ6+DhiumykPCijqElZfOah/NzphYnS7V98SDfdJQfhOakb9NSOsbAz7ME
         9PmGP929SZ56sAB1fQ17iyymu1/w7wo0r8yJfKfzQwLPCelP2u+rV01jXg++B4kEGtVX
         nL9TljiPJiRSyfMXWTl1ZHFj45Z+zy1ID9LsuXayael/sHHLjGIw4w8hOycBpZ74Wtb2
         ga/10z3Bz5tHOmdC+oMWG3LFl8/UN24QIAemzNhxmSY01cbgc1ReYhF0dv9ykFP89zxD
         YHzeCDmMnOkqD57pJsZKTPpr3ye2+7dKPkFDkPnj8LiApv6XvKqiujop9pXqJbeWGip1
         SvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RtuYujDQbGoE383NaOTW8yNTTYMDfvcRIoYrv77xBo0=;
        b=LmPoUcqsbcj0hg7LAWxqhwTFUockHkpMU9hOFu5HwZPLLE51B3Xijc3sW0L2ve9Ph0
         vWmUf/Y7o8BHP5B2bNxz/HWCKJpcJBOmFm9eIi6iYYVtsZ/L4ar34MyeL5a8Fqr5dtgF
         t49LWAVQDd7qmTx98KAgiugQInba+NAOIKl7gsequ67UfiDDZcSi4RW0CxI3hbZJjvyR
         zNsOD+s6He4OWRlTZjWFpuIzjWADTbiCpG4H2bP5ZOSU0dbO+OBtJp/wiMBDozEVimBp
         OdmJQ3YRneBd1jSsDkadcwpuzkLtKuVDAO8FAlTiiHKaFALWeg4wui9c9XxY5UZp/1o3
         595g==
X-Gm-Message-State: APjAAAVGo1Z51DEDpVVQiqwsc74AsupRi6LtuPZ/+CEgrIh9qHGKH0CT
        oX6QSZx+hwYBuCPlBpsWb4XL
X-Google-Smtp-Source: APXvYqykGw2se+1YdEpdnu59uhuq+FCf/teB61ZdN3oz9apYHya31RXFapv1QdA8jAI3JZ65NhNx/g==
X-Received: by 2002:a63:10a:: with SMTP id 10mr57256448pgb.281.1568650515328;
        Mon, 16 Sep 2019 09:15:15 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:90b:91ce:94c2:ef93:5bd:cfe8])
        by smtp.gmail.com with ESMTPSA id h66sm614134pjb.0.2019.09.16.09.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 09:15:14 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 3/8] clk: Add clk_hw_unregister_composite helper function definition
Date:   Mon, 16 Sep 2019 21:44:42 +0530
Message-Id: <20190916161447.32715-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916161447.32715-1-manivannan.sadhasivam@linaro.org>
References: <20190916161447.32715-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function has been delcared but not defined anywhere. Hence, this
commit adds definition for it.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/clk-composite.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 4d579f9d20f6..ccca58a6d271 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -344,3 +344,14 @@ void clk_unregister_composite(struct clk *clk)
 	clk_unregister(clk);
 	kfree(composite);
 }
+
+void clk_hw_unregister_composite(struct clk_hw *hw)
+{
+	struct clk_composite *composite;
+
+	composite = to_clk_composite(hw);
+
+	clk_hw_unregister(hw);
+	kfree(composite);
+}
+EXPORT_SYMBOL_GPL(clk_hw_unregister_composite);
-- 
2.17.1

