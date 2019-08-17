Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D10C3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 18:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20F22075E
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 18:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T9fyNuGo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfHQShM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 14:37:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43169 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfHQShL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 14:37:11 -0400
Received: by mail-pf1-f196.google.com with SMTP id v12so4796213pfn.10
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 11:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a/DBFL5pnFxmW7r8pfJ654oUFkPKTYmOJJb8EXbuSt0=;
        b=T9fyNuGo7nXkSqgRbKRXwczkyhajG9D4rCnAPsUVh/g/paIXjQTwipVm1uF/ABT2V9
         cjX/57obkUbaSbUg2sQ8coroy4v0Hgd51SHP8S9tOEXpVOuYbVtzYwtNJlPCnOktQjFf
         kOVOpXGYlxPLKVxW8k0WsCm0fid2aAyuCeLH4rsHkbgV772Ak58F7M0gCcNFFm5TLEes
         E5vxEmhWsTueRFidXcLztgrb0kAly+e8Sy/3bFx3pZ/8RWtz+SNR+zbFFMiXAp7QmObT
         0cTuFNpdDqLdAseLFnL80NXg7Cx1cbma6cPnuzGALJhT/+zYduRgU3QADv2WfG8bVBaD
         J5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a/DBFL5pnFxmW7r8pfJ654oUFkPKTYmOJJb8EXbuSt0=;
        b=N+hmGYN9ptFaN/6vNySHzUeLN1/d4Wdd9qKfSJE9FqcjpvHRSLHjs/AlEqavs243Mh
         jASFdKoWoimoXb8WLTnUFuUJ87k52Rjj1atdVsBBFYG8yE40eZcuNKHHL5Ab0DwjzMaq
         7sBeLn0eRe2Lc2AbsCgIAaitBFNUBI2FKmdD8n5tAZtchhOafGljiGxMR1zEI/6Z9aQu
         poQWwGG5oqPI6uudu0A3zdZRyIpBjU7aoSJG2Pw45XUWcaFxwmoX0eIrhW34VLEF4PJd
         CUDx4VtTSJpbmQI1D7JLocNqKWUfc4iX/2wiqGP/kTo91eF/3rfe4KftrpYyzv3xMyMw
         50/Q==
X-Gm-Message-State: APjAAAXVpAat27qvMgVEfDVnP3aE0rDkIR5h25LaQ+KIpmBcR63+QvCW
        mLzP/CI84pk6wKObvSLDwQ2r
X-Google-Smtp-Source: APXvYqysG+ORw2lSBaxTYwdL1FKWqn7EDAacICLrMuXWKnS8dBwKXrAqnklYhymDEx1/Eb48y+/nkQ==
X-Received: by 2002:a17:90a:21c1:: with SMTP id q59mr12582966pjc.6.1566067030621;
        Sat, 17 Aug 2019 11:37:10 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:909:4559:9185:a772:a21d:70ac])
        by smtp.gmail.com with ESMTPSA id 33sm8588640pgy.22.2019.08.17.11.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2019 11:37:10 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 6/7] clk: Warn if clk_init_data is not zero initialized
Date:   Sun, 18 Aug 2019 00:06:13 +0530
Message-Id: <20190817183614.8429-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190817183614.8429-1-manivannan.sadhasivam@linaro.org>
References: <20190817183614.8429-1-manivannan.sadhasivam@linaro.org>
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

