Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D126C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB932084B
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEtd5ugU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfFPXtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 19:49:16 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46650 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfFPXtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 19:49:15 -0400
Received: by mail-lf1-f67.google.com with SMTP id z15so5126857lfh.13;
        Sun, 16 Jun 2019 16:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W26NvpJgTq7RlTVHJ5BiocSXngTL8DTnLT4KicQH9Qg=;
        b=pEtd5ugU7m813fz/Kxtp0yO/vHiXfTUWRLcSnuVtwL9kqZyybg9d7tvYQpzuAw2R3c
         S4ttV50SwmNKARKxNfndEh+1aHpm5XXERdWGG59ZqBIktaEXfkvzwiFODqlS6S9Z3O69
         i2jVQss7TSQ2EUNoIa0DrOX8yq60P+B3/a1Wtr3hPAXclSQ8e+vXeNHcFW1Wkp9pwg/w
         Zso2pY8wK7Bf9g52Bh7kbV6Gcfm0S+GpRrUX2Q97WeJpvMYZ/yg64hPjZ9Pe4MHoOOdD
         MIMsbAXt4bJBbuW3gYrdFoP7bk4Jyl9GhxL/J5VSlpqIAo0SWIkesUY0HliUukU/ffFe
         LPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W26NvpJgTq7RlTVHJ5BiocSXngTL8DTnLT4KicQH9Qg=;
        b=KH0LGn6LuJ4TAr7uOPW54ChiptAQ0qqVLeDYAGqV1FHcuLXrhZVS5B1oLBr7O+hxhz
         AohaP1bq4v2DOB4skEEMdF8xNaYPS6rdY6me6tMwImjBpDd2GiATEEqxIKkKQbCmawwo
         nFQUXyTel8MxhJKo2qtgBnuK4MUKkmFmKK2+jci2a3SfjzD3VAeqI5heEsmi66W6VJFz
         vZXYugbT7rOlgcffSknO6jrQJ4sBZ4PpFW5ZsDTvY6D5dKsC1KD3XNrnXTSjkvadHvWw
         WeS2WY0FAVdToDZNSv+I97wCJzARUq9cKgRG7rU/daS9kLvtPgydcavatmr7OLb2f2Tf
         D0cg==
X-Gm-Message-State: APjAAAUWAtcYjOaKrV1eaRmuuf+iFbCtXFXeHNi81WdbNHOSxHjPhzu/
        YxlEgGxoAyCoZwueMvugBGc=
X-Google-Smtp-Source: APXvYqxNr6XmOR6OKhdZoVvVqRAhFzSkspQAG0RbpueTaZkw4TKHK7tnqL9vMrH1QVJBCauiLGji9w==
X-Received: by 2002:a05:6512:51c:: with SMTP id o28mr37314897lfb.67.1560728953184;
        Sun, 16 Jun 2019 16:49:13 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id w1sm2032390ljm.81.2019.06.16.16.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 16:49:12 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] clocksource/drivers/tegra: Set up maximum limit properly
Date:   Mon, 17 Jun 2019 02:47:44 +0300
Message-Id: <20190616234744.8975-2-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190616234744.8975-1-digetx@gmail.com>
References: <20190616234744.8975-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra's timer has 29 bits for the counter. The counter's value is smaller
than the actual value by 1, hence the maximum equals to 29 bits + 1.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/timer-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
index 090c85358fe8..d0a46e10dbca 100644
--- a/drivers/clocksource/timer-tegra.c
+++ b/drivers/clocksource/timer-tegra.c
@@ -130,7 +130,7 @@ static int tegra_timer_setup(unsigned int cpu)
 
 	clockevents_config_and_register(&to->clkevt, timer_of_rate(to),
 					1, /* min */
-					0x1fffffff); /* 29 bits */
+					0x20000000); /* 29 bits + 1 */
 
 	return 0;
 }
-- 
2.22.0

