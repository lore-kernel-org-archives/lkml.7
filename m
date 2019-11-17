Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2795FC33C9D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 14:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F121820850
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 14:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dozuA7JK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfKQOAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 09:00:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43726 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfKQOAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 09:00:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id n1so16325627wra.10;
        Sun, 17 Nov 2019 06:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lfb97txnqBkpAAA0tczISRiqax5ID5KyvODmGSMgTQQ=;
        b=dozuA7JKPzxsob1ruenYebX+2uaraYQlCzRTEAu7EPK6gph0AbZCFHA+S/5MyNqBIG
         U3qymAOFS6vWauytLtQCtWkwbdVNdg483jY8NGjUbw9Vw6W2i0UE+ng5vK8J7uklbAfY
         WpJ2q846EfjkIszhGkbvdR6W2GJlSL2qj2t0iTHugUeSESi+20LOwQxSDq0OL22IYVNI
         RPhyRSmev++noqTcud3jT2qZPl2UfunG+/hqqpbUTh/ItsyFRKcqwqNU6cIiIbOBXNfU
         uyCoBtXaQa+BdwjDF9xqHWL14uJnCE/KjTqxl6Cd0kPq5bz40GGkrwvwxjgMUATksylH
         vVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lfb97txnqBkpAAA0tczISRiqax5ID5KyvODmGSMgTQQ=;
        b=OIU+Bic3l3H8+sQnJnFdMjpaGiGT+ICqs6ycXuEVnaO+GaBXSTvTMhwnEY1lVQAACc
         U2Tnlb1o0dlOC+CKWv3e0nzUXLXz0QNDhtrDEPd7uEHEV1K0Cau01K2ZABTyP6ytawMd
         RIm+CqED8WaFiL7liPxqfBtmoiTgDMLmXT5ddEnmyZgpyC1f8HqTmyLdgR9y8+7sN2V7
         0flFh6wXt+8GhsxRGcfYB8x3WABsQ7jxLC3LTXZIpgnmtm7EX1RAmDtflXyYXFbpmhQ7
         1QhQdaZJ3GuOmDoxJS+WFYO2CluAhpNZz2uhW1RYLsvtvFwDFQMIo17TFaOSMQ5Z7q1W
         2iaQ==
X-Gm-Message-State: APjAAAVtyZxPJt04ilNmcW+jYqOUIQdnrFj4adJznvA05RhN+zgswCer
        7+AoIxaJAZ9WsGa0G39Y5AQ6/bMW
X-Google-Smtp-Source: APXvYqxH00nil5ICai5RDo5aD0yjFRhs/HB+0oOEKHsK3hLQUPvOZu3Ej+DTySsb5xf6DaKTR0H2Rg==
X-Received: by 2002:a5d:5411:: with SMTP id g17mr24558469wrv.360.1573999201105;
        Sun, 17 Nov 2019 06:00:01 -0800 (PST)
Received: from localhost.localdomain (p200300F1371CB100428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:371c:b100:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id n65sm18004803wmf.28.2019.11.17.06.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 06:00:00 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 5/5] clk: meson: meson8b: use of_clk_hw_register to register the clocks
Date:   Sun, 17 Nov 2019 14:59:27 +0100
Message-Id: <20191117135927.135428-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191117135927.135428-1-martin.blumenstingl@googlemail.com>
References: <20191117135927.135428-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch from clk_hw_register to of_clk_hw_register so we can use
clk_parent_data.fw_name. This will be used to get the "xtal", "ddr_pll"
and possibly others from the .dtb.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 44e97bacd628..3408297bff65 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -3701,7 +3701,7 @@ static void __init meson8b_clkc_init_common(struct device_node *np,
 		if (!clk_hw_onecell_data->hws[i])
 			continue;
 
-		ret = clk_hw_register(NULL, clk_hw_onecell_data->hws[i]);
+		ret = of_clk_hw_register(np, clk_hw_onecell_data->hws[i]);
 		if (ret)
 			return;
 	}
-- 
2.24.0

