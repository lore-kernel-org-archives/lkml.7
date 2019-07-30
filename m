Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBC9C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F5B208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlqFb134"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733017AbfG3QdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:33:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35823 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732924AbfG3Qcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:32:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so57214847wmg.0;
        Tue, 30 Jul 2019 09:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hKvLl5MtLqHMnv3zCjcaW8MF73v11AH4bgm8S8ldXCE=;
        b=GlqFb134XfxnMkEh6uLn1kRhDbMEnXJfanH+X3B32Z4zKb0sE8jm/rxkuSYxWHisOi
         OU3o1DyNgJk7/7GgUrWw5IhJtxiwz0Y2iiK/0eY7zdagnniETk2BjXEGHS/yR1kMuaWv
         4ULJmslxpRwhmDfifIuTY7KyhK9ByrMfKd9Shhor0iFBaiYVotkTN//Ns7JYzgvhvj6y
         VitepvML8Gwaj5g9DLkZd4hfgCV0JQ6TnThaJ0wB9sADjyqQLmHgmd226tt4ZNqtflnS
         8jzr1iOqhxicgKU5SD8/Rwt3B3CVao2lNUUr0NUSamKRp8o0dApg04ulG7OZzkjSHj8q
         /2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hKvLl5MtLqHMnv3zCjcaW8MF73v11AH4bgm8S8ldXCE=;
        b=qfkRlbqDaNpF83miNLFcOGuviPmFmAuT15ClTPwhi3afJ/i/U91R9hNblKs7f5OkPI
         N+sHTByAQQUzO7LeHzloZIk33DwLMU+r5oiyyycRutjDmKfYSlU8yrGMHMip05pCLAkf
         kRMOrqRZEqNDHd8+Pno01SJszwZi+6n0DL7V7O2OG6b+7qWy3wkbwjObEbUqMclhDsc4
         ZFu97k84drx0Nsy8AanuC5LESDYUtIqEV2YPyXSc//icvQs5+OMFH0pikB6BNNiwagfE
         ZSU5JkytdejTIC4SumMHfSDXxaryvYvP8WZCb4gYYDiFC+JSoGXfe4z15CZtPJF0XBMG
         DyKQ==
X-Gm-Message-State: APjAAAVsitiXWJ/gforVcxJIYPU/Fd5IGzHDWV8bvnf7XmM8phoj+U5k
        pvPm+JE+qJza9060qpDS3YK3B8EN
X-Google-Smtp-Source: APXvYqy7ZambOH2FqJffPbsZIhK05NktYW91mK2UAxhPST/+7yvKY9FJpMgpADfq2QZ6C86Eb63VQQ==
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr98670207wmc.110.1564504364538;
        Tue, 30 Jul 2019 09:32:44 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id c65sm64835175wma.44.2019.07.30.09.32.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:32:44 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 20/20] PM / devfreq: tegra20/30: Add Dmitry as a maintainer
Date:   Tue, 30 Jul 2019 19:22:36 +0300
Message-Id: <20190730162236.6063-21-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730162236.6063-1-digetx@gmail.com>
References: <20190730162236.6063-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was contributing to the NVIDIA Tegra20+ devfreq drivers recently and
want to help keep them working and evolving in the future.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf2225b161f0..49010404fdea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10420,6 +10420,15 @@ F:	include/linux/memblock.h
 F:	mm/memblock.c
 F:	Documentation/core-api/boot-time-mm.rst
 
+MEMORY FREQUENCY SCALING DRIVERS FOR NVIDIA TEGRA
+M:	Dmitry Osipenko <digetx@gmail.com>
+L:	linux-pm@vger.kernel.org
+L:	linux-tegra@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
+S:	Maintained
+F:	drivers/devfreq/tegra20-devfreq.c
+F:	drivers/devfreq/tegra30-devfreq.c
+
 MEMORY MANAGEMENT
 L:	linux-mm@kvack.org
 W:	http://www.linux-mm.org
-- 
2.22.0

