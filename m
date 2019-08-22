Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54A7C3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD84723426
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RX3L3NEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391879AbfHVRZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:25:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35741 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391767AbfHVRY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:24:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id d85so4414132pfd.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 10:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a/DBFL5pnFxmW7r8pfJ654oUFkPKTYmOJJb8EXbuSt0=;
        b=RX3L3NEysLNGueK8XYcm4tI5nQZ2pEFyeSxHYiObmFt8nWRtF62qzckIHmf2rpGxrP
         BLn4KXyVPFgfoviJQgPO/s2j82QZFQl96pFgqGNU4z2fsVsaxfgeFqyUhckvdrHLzqrA
         p8HLWOVvrNzJ8jujwhikFfgqm0RNuFfV4wK1Xj4qfo6pDRR2KeGAgorfqhi1U2Q1agzD
         qLOLhFMM0fBHGwattVPoacW0SA8gg+UqkAchcyWJxEspzojX5olDwPFZWk9xUAaO6LPb
         8Qp3+xNgeubaXFd3rIDxjUGNumFk054qag4X+vH9xDBisRUZi4LK940Ny0tqYab7R/zY
         5V+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a/DBFL5pnFxmW7r8pfJ654oUFkPKTYmOJJb8EXbuSt0=;
        b=b3oKASauCo0V8foytynCuqG9Xg7phECwmjG/1lTfi2WwBVLvuMUazCvav5+tQ5cFU5
         IetuB20O7UD0l/g34diADBFqcl7Pd3i25oYgrtAU1Iq7Nl8G82HNQabwvzLVHOTcJWH8
         D26R3WpiURmq6wswsw9JmivLwsOTWxcqdwixUZOJZkgJkonfuou9ZiNrVQQ+LeSiKqPi
         kC/ddVVxYcph+fveqc6dFjora6YDMwpuO7FUX6DCVYAP2OO3q3bKDaCCQEsoNH8E6dAz
         2qM93H2kQcYSjl2w4UHhVj99p1QrWmk/5JUeVhpijcWOKp2r/5XWXMrKxftuMUvNjOhM
         m2NQ==
X-Gm-Message-State: APjAAAWA0zJlEPPvIQ70sz7VI/E4NE599YS0i6b0Dn+o3wBqTsXG7vnl
        0zvp2m7OHQtbyZgVF8yH0+VS
X-Google-Smtp-Source: APXvYqxXFDaJ955RJz/a34+rWtNfFOs3hBYdX2U9Etyi7MVotAVqBYvnVOl+UsQc16TjNDKQSF4Dkw==
X-Received: by 2002:a63:e20a:: with SMTP id q10mr327282pgh.24.1566494695791;
        Thu, 22 Aug 2019 10:24:55 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:71cc:5738:24ad:193e:4b59:8a76])
        by smtp.gmail.com with ESMTPSA id r12sm31705798pgb.73.2019.08.22.10.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 10:24:55 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 2/8] clk: Warn if clk_init_data is not zero initialized
Date:   Thu, 22 Aug 2019 22:54:20 +0530
Message-Id: <20190822172426.25879-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190822172426.25879-1-manivannan.sadhasivam@linaro.org>
References: <20190822172426.25879-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new implementation for determining parent map uses multiple ways
to pass parent info. The order in which it gets processed depends on
the first available member. Hence, it is necessary to zero init the
clk_init_data struct so that the expected member gets processed correctly.
So, add a warning if multiple clk_init_data members are available during
clk registration.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/clk.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c0990703ce54..7d6d6984c979 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3497,6 +3497,14 @@ static int clk_core_populate_parent_map(struct clk_core *core)
 	if (!num_parents)
 		return 0;
 
+	/*
+	 * Check for non-zero initialized clk_init_data struct. This is
+	 * required because, we only require one of the (parent_names/
+	 * parent_data/parent_hws) to be set at a time. Otherwise, the
+	 * current code would use first available member.
+	 */
+	WARN_ON((parent_names && parent_data) || (parent_names && parent_hws));
+
 	/*
 	 * Avoid unnecessary string look-ups of clk_core's possible parents by
 	 * having a cache of names/clk_hw pointers to clk_core pointers.
-- 
2.17.1

