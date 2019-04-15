Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81D0C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A867D20818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ebq4sbxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfDOO5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:57:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44258 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbfDOOzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:55:42 -0400
Received: by mail-lj1-f196.google.com with SMTP id h16so15931178ljg.11;
        Mon, 15 Apr 2019 07:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i6Xn9R9brWUT4b6RnyZ3sxN9szgqfnxfRVF7qHAQNak=;
        b=Ebq4sbxCdwRWFLTiMoDLZq7P/iZ5W97pwxcwiITZKZfWPmzEeT5B1C3Fpr07aXO3ns
         Tp5ibxnl2tFwuZDceYGWA3sq0Q744cbN4wW4xlXaTyLRCxfDEJW29SFEPSSQmkhbV3yU
         UJjpcVEbwbtsoziOkvVPb9FnOyPAQH2oBSJj0MXttp9K2OwRjE5pbpeTSjIm4rnC7aOR
         OnLw2F0RhR5Q39o3M5NVjYVdP5zH5uNSGNwsMmB74BpEytq8AGH23J8RpevqDxwJ8QI+
         YC/IkpHbogtw2ljJFQd1XEjBtCE7qah01DQkTyTPm71HMsVT+oNgGLRTdLmSmSgmHovp
         y42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i6Xn9R9brWUT4b6RnyZ3sxN9szgqfnxfRVF7qHAQNak=;
        b=UoTuO3CeSAogtoVkjHHn7W7sOEHVZOMv46jh7lxfAX2MZJlyeFVTL+L7x0XOLFX5tY
         KKnjqdX17OGYka5kQ8ulLZoq3d7+R9a4Wai9J36ecjg8zu8LYn4XileiKoFxly9AtEou
         LSV6tGdYtTfp1Lp7E/OkWDHm8q57e+JHzqhkYupWq0mYILBknlQLX944ogalKYQqpqJ1
         LNyen9Np2jVl1xWy3va7uDcCAAD4qZxiB7QFnaHxQQ5Y2Xyymcye754MMkyLVMtawf+i
         5TBmdhhZULv2Hcwxc/q9Z5TKNltYMyRlh1maaMJCfQWUtBbfu4SH+9hAyyor5hIHDM2n
         w4RA==
X-Gm-Message-State: APjAAAUdjEiyIWauiyRwbhsUOWaF3wwa7xiwW2JBHkk2G+m9hxOVcGcl
        sJwWB5CHfFlgxOsrYREiNyY=
X-Google-Smtp-Source: APXvYqxQau+WvyLk8STbVoFeKqGPr/V7AzFSo6YVuvzNfeYFaaRkVH4j+GCgdELhqBNGspq42LgQGA==
X-Received: by 2002:a2e:9597:: with SMTP id w23mr33961266ljh.111.1555340140224;
        Mon, 15 Apr 2019 07:55:40 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l12sm9989932lfc.61.2019.04.15.07.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 07:55:39 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 05/19] PM / devfreq: tegra: Replace write memory barrier with the read barrier
Date:   Mon, 15 Apr 2019 17:54:51 +0300
Message-Id: <20190415145505.18397-6-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415145505.18397-1-digetx@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The write memory barrier isn't needed because the BUS buffer is flushed
by read after write that happens after the removed wmb(), we will also
use readl() instead of the relaxed version to ensure that read is indeed
completed.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index d62fb1b0d9bb..f0f0d78f6cbf 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -243,8 +243,7 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
 static void actmon_write_barrier(struct tegra_devfreq *tegra)
 {
 	/* ensure the update has reached the ACTMON */
-	wmb();
-	actmon_readl(tegra, ACTMON_GLB_STATUS);
+	readl(tegra->regs + ACTMON_GLB_STATUS);
 }
 
 static void actmon_isr_device(struct tegra_devfreq *tegra,
-- 
2.21.0

