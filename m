Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172BBC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19DE20856
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="euLLhY+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404871AbfHVRfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:35:51 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38555 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391819AbfHVRZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:25:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id w11so3370520plp.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 10:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RtuYujDQbGoE383NaOTW8yNTTYMDfvcRIoYrv77xBo0=;
        b=euLLhY+946DfyFpuvIdyFGJfMj0knyI7kYwiFDLPxTrrpqBXt30egdCgq3fEB/sL88
         GJZHY1upb9230M9+Zx2VsXWQbb6terlbASK2Y8NjIXMYqZYxmMrwPJrKbYsdrXVKdKVp
         h3oLBX6Xq2Kyr7bh2rZD1m3sNpfVxJEePoY4q7+bX1Usir70lWfAZ2Q5Wm9c3x/iC2oF
         i845R9dxFgTKai1UsSQc1aFVXhbltY2Rql4zSkj4KmwbqXDJHZOd0ZxLP53dYJHtXhvW
         PFZDbnj5L0kebFpNB0KndJJvUuR+yNkmwD89p/IsdVDOyVRCYiob6rsRKOyrv39tDlJH
         213g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RtuYujDQbGoE383NaOTW8yNTTYMDfvcRIoYrv77xBo0=;
        b=UrbFbbSfG6dX3z54us8LBliNX5bMfZl39LsDSqFX7Arige/5dY0tVlpWsYz6PiEeJ7
         0uf8KxR98m5G7UmGC8D/0mv1NaopDuJc0sNbIStS3S9UqTFOfuL7NtzpXbBV+Zv1zQV9
         mNUwk+5e5bBh073Xx1ct2z4xsDFxHvAcDBNS47CkxIDGd6BTFmI2GGKkWBYS/x0KxJ+i
         z0Hm8njcl/+JDO+Du01NyxBAQusIR84Tg7L5Ex1qOK4fccv0zmj6mmkf9U0jUezge0az
         OMCabi3fAZh8nC0jmdVlfhX+/stdkgjqt3waIATItAW4lpOaQLjGK0x4wMOGvsBqQxY/
         wPnQ==
X-Gm-Message-State: APjAAAVpMFauOFyueEDkih4t+CsxUiI9rrKkygZP6XId1hkKqhkmbOuC
        TL03Yx2q7+UuWqBaDXKZ4Z5Y
X-Google-Smtp-Source: APXvYqz5vFIuN706iVqol8q3EsrpnwcsQfBFEXMXn/Nwi/SX1PpPwoQhg1LPT7MBQ1EhYyTnuzzXkA==
X-Received: by 2002:a17:902:788b:: with SMTP id q11mr40640145pll.308.1566494703001;
        Thu, 22 Aug 2019 10:25:03 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:71cc:5738:24ad:193e:4b59:8a76])
        by smtp.gmail.com with ESMTPSA id r12sm31705798pgb.73.2019.08.22.10.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 10:25:02 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 3/8] clk: Add clk_hw_unregister_composite helper function definition
Date:   Thu, 22 Aug 2019 22:54:21 +0530
Message-Id: <20190822172426.25879-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190822172426.25879-1-manivannan.sadhasivam@linaro.org>
References: <20190822172426.25879-1-manivannan.sadhasivam@linaro.org>
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

