Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26E8CA9EBB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 20:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53B021D71
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 20:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHgenitc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbfKCUmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 15:42:31 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34434 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbfKCUmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 15:42:21 -0500
Received: by mail-lf1-f67.google.com with SMTP id f5so10709757lfp.1;
        Sun, 03 Nov 2019 12:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dCIWMfP1VPP4Mlo+oAntsMXZNvH354k2VUOlKxxlyNs=;
        b=SHgenitc+d9TdYTmb88OgDRLuQtlqrC6wH3ynKx7AeKywzEdeWR4I+PGGvgj8+dTU7
         tXuRUkvN1ISdlKCNpj/wTID2PztAUvezADwqts9qFNlZR5KczHzCso/NYvKK9Zv+17Yq
         FjQVvyxt8Ru41OLgDzvi9SjhKAkq4HO2JHsNPaCnfZ2xTJLq2z74BK91hmsIEQ2uzHN7
         F9zCGQRfgaTyBakFIPzBEZpOVQfxOKfJ06qineOL7yHFwCV/c0ArsF5sXxkWg0JfB598
         pWRaSan57e5veSuBMDpO2jO5puvxcV2ltCoHGdMacbQPTQsmyuQDSYOCzWzpZTCmj2Dp
         z5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dCIWMfP1VPP4Mlo+oAntsMXZNvH354k2VUOlKxxlyNs=;
        b=C/1+NA3B5tTn3RTCUjkXQLX12HnJneS5SeSGotmjAXaqeFa/BVqe2ahBNQoPKnBIWT
         ICAya9YL6AimFvvgnbHSMaMB7OfZUVx9+WwzghQUtFc4T8ejF/b28jmxEfYOQgmSbpP8
         XjBVpAWytdWSPCXb+hI8ydOS7mK+SKgfW8KzR37B4O2WNZLpxMU79WWDt1Xq8Gf0oLFv
         5d4twEKjL7EARhQbfbjv26cdgN7i7BT3nefhiUVR8fhzx/e3E3mbGzzYSj3jRmdb998B
         ksWY5rAn531Re894Fwc0k34tgcriUmKkKOgSlwkEPMjMio9R2bykURJSP7hSXLfXbObg
         AACg==
X-Gm-Message-State: APjAAAXnhD9h3k9Vrw6WcsI9EYJaJF3WcDGTb+qDrnr6RfDYYdKG0fwE
        9tjSJZyuDoXvpG7y38kKCfs=
X-Google-Smtp-Source: APXvYqzB8P/6NLtNYQ+iWrNg9Oh+f76HhBrbbedQnN9RqSpF7XVcRjpTWtO5x2d737RhkKXvQbbKkA==
X-Received: by 2002:ac2:5295:: with SMTP id q21mr13904642lfm.93.1572813739765;
        Sun, 03 Nov 2019 12:42:19 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id e22sm7099853ljg.73.2019.11.03.12.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 12:42:19 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 18/18] PM / devfreq: tegra20/30: Add Dmitry as a maintainer
Date:   Sun,  3 Nov 2019 23:41:30 +0300
Message-Id: <20191103204130.2172-19-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191103204130.2172-1-digetx@gmail.com>
References: <20191103204130.2172-1-digetx@gmail.com>
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
index 9f69d01da3a6..4b9679988514 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10632,6 +10632,15 @@ F:	include/linux/memblock.h
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
2.23.0

