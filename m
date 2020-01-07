Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB9FC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 23:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF412077B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 23:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Jwsj+YaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgAGXG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 18:06:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54743 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgAGXGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 18:06:52 -0500
Received: by mail-wm1-f67.google.com with SMTP id b19so574039wmj.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 15:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3OMmRwlsdJ8B0kThVmC1teyeuGIZ28R3SGQmOXkOZCg=;
        b=Jwsj+YaWZljQ8pVmlO9Qg4ZcVd6YTIaUwlN4E6/YRZXVupsZDBCT/IG6YD11LfvIC/
         wjubzJKkd+EnH9ivm1vzUrC9AahftMhox5ChzHfqAmpmu/1Jjf34KITt92zTYh9Ccer4
         BajpuRcy+q5Yr7VOOc3TBrZxGv1yTiSbaMIQQALctcEalMwOrS9YBAk0s6XznaDoa87x
         B+EtRQk5P3BEPsKrIR94ZCh9/aYzCUZ6C4dDGIKIWIH9d0IJnWHyNEmYEODKlcdmyiro
         VIjh7IxwSKbbuUP7LniDN/REatFU3fByJiPTFH/dFD8CG816+WaDRy+1coyGQQZruUOB
         jlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3OMmRwlsdJ8B0kThVmC1teyeuGIZ28R3SGQmOXkOZCg=;
        b=MrbxzQW6ksZxN7tDtRon8ymwzg2/de39i27PyXTwc4sUB7Ni2FkxXNQOVKiqxoFajm
         ma62lXgGWB+CUrMlaWVsG8z7Jdt3kxBmxhtTvfrYCZZDCO7j5Ykdh8rIE48ixpbmQu0p
         exYOv16ZqfYqTa/5OXi5EEwXpzWEpJLQ9ySSpmtz4Tb5MbuMV/yYjHOrz1o/lLAuCg8K
         SC/1cZOmGyQ8SmEwokzRo38kX3P16Coz9TRltVzDmmohxmbSG2vCrQjjxMSCkwClnacY
         7WNMr0/a46ODfLe7SGfFFeU41Cwmb4CN6kaVcB0BIvrYcjznoyH35lME/HTCRRHqHGJY
         LEsQ==
X-Gm-Message-State: APjAAAVfULTQxGt4Yf9Sc0mqaqZ5JEt2w5BOOYefJtPOIPFmVEMAkHol
        43WN2nEG/Xgdb+kw58s9u8Y=
X-Google-Smtp-Source: APXvYqx4pOW8OEjv1gMruzFtuQEsNgeqBVsbKCG8agEZlBX/w/EIHafixJNy4g1otnUEt/LO8xsr3g==
X-Received: by 2002:a1c:f009:: with SMTP id a9mr584150wmb.73.1578438410327;
        Tue, 07 Jan 2020 15:06:50 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id g21sm1335912wmh.17.2020.01.07.15.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 15:06:49 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     dri-devel@lists.freedesktop.org, alyssa@rosenzweig.io,
        steven.price@arm.com, tomeu.vizoso@collabora.com, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        robin.murphy@arm.com, linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFT v1 2/3] drm/panfrost: call dev_pm_opp_of_remove_table() in all error-paths
Date:   Wed,  8 Jan 2020 00:06:25 +0100
Message-Id: <20200107230626.885451-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107230626.885451-1-martin.blumenstingl@googlemail.com>
References: <20200107230626.885451-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If devfreq_recommended_opp() fails we need to undo
dev_pm_opp_of_add_table() by calling dev_pm_opp_of_remove_table() (just
like we do it in the other error-path below).

Fixes: f3ba91228e8e91 ("drm/panfrost: Add initial panfrost driver")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 1471588763ce..170f6c8c9651 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -93,8 +93,10 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	cur_freq = clk_get_rate(pfdev->clock);
 
 	opp = devfreq_recommended_opp(dev, &cur_freq, 0);
-	if (IS_ERR(opp))
+	if (IS_ERR(opp)) {
+		dev_pm_opp_of_remove_table(dev);
 		return PTR_ERR(opp);
+	}
 
 	panfrost_devfreq_profile.initial_freq = cur_freq;
 	dev_pm_opp_put(opp);
-- 
2.24.1

