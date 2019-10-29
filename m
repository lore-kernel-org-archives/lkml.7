Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FF7CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 22:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0DD217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 22:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHjXhDh5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbfJ2WH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 18:07:29 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33891 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbfJ2WGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 18:06:16 -0400
Received: by mail-lf1-f66.google.com with SMTP id f5so11733464lfp.1;
        Tue, 29 Oct 2019 15:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0jKqCM1lPNx4jTVY6ohbyCzf4iaBIQpqrKhcpHeA2TU=;
        b=FHjXhDh5l6YzWPdTOCF4rhn7ygTpA6Cwa3mpjG7/0oGvRFHnB8NZ5qJ81KTFh62JoG
         VoSr8+zlEzNxwS29tZWBdxPEzefc4uhSJ0GpCkN9B3usYHDWN5GopWfytcZ5J6TndSqy
         F2j4IQK3WVCF3pJnq1Mgmli6tS2d5OHPOkLC9Yp2s7UTzRMH61TVGivx7XCVPv3AdqJC
         jDA+QnODsjtBy1DGEfkEV124t8/PDluvwHJtiaicVCUTDfYrBi7Y8KeDL8DC1/l9m22f
         2IBS8rg3OoRctD9jL4cEtShYPIaARP0UZCK+r/ELDDfY9d5knydMb+E5XB81AfeMav4c
         8N7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0jKqCM1lPNx4jTVY6ohbyCzf4iaBIQpqrKhcpHeA2TU=;
        b=aDXZeuqNGIo8jLEuElaTBVRce+Rti3Zlj0qixFz/mcNl7WiMRdOODrnVlW/JZo4lii
         WE/njJ91VUWtuJeGD2dmvCeGEsMBhtPnvwX2PS+i38N/Fkyj+jwAmkfl2Rmgu03OcOMK
         yz+GDcPeBDuhwPXoCPt0B3f9T9UXNrNqXaTRvy8jOeSPnhnd96KfVnJkxpRUQSTzjmkM
         cJbWtT7ssHLl4K5yRAV9+U69SYoT9P4z4mr04/Qr2Hje0/iD09Y4C7kqWOsnroe3nIgE
         y4A00LIYf/FVIPoSr0EdX/k7DBN/AkGUHKjARRL/hMxVsx4SReZoK8tJOks/DRquhqcV
         kQuA==
X-Gm-Message-State: APjAAAUIeH1V+ySc+3i0mQz3JCXzJyz3lMOYiFVND5F+IFO65JirT4Uy
        xHbcCbt6qlQV/yWLHwyCpps=
X-Google-Smtp-Source: APXvYqyWN7FIpXwxn/5reuV15lckKjfRQ42jmDAY+nz6+JXY+5tW6eYYN6vpZU2idVjO6I5CtsZLEg==
X-Received: by 2002:a19:6d12:: with SMTP id i18mr3861749lfc.153.1572386774017;
        Tue, 29 Oct 2019 15:06:14 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id 12sm51536lje.92.2019.10.29.15.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 15:06:13 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 05/19] PM / devfreq: tegra30: Fix integer overflow on CPU's freq max out
Date:   Wed, 30 Oct 2019 01:00:05 +0300
Message-Id: <20191029220019.26773-6-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191029220019.26773-1-digetx@gmail.com>
References: <20191029220019.26773-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is another kHz-conversion bug in the code, resulting in integer
overflow. Although, this time the resulting value is 4294966296 and it's
close to ULONG_MAX, which is okay in this case.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index ee14bf534c0d..1d22f5239cd5 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -69,6 +69,8 @@
 
 #define KHZ							1000
 
+#define KHZ_MAX						(ULONG_MAX / KHZ)
+
 /* Assume that the bus is saturated if the utilization is 25% */
 #define BUS_SATURATION_RATIO					25
 
@@ -170,7 +172,7 @@ struct tegra_actmon_emc_ratio {
 };
 
 static struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
-	{ 1400000, ULONG_MAX },
+	{ 1400000,    KHZ_MAX },
 	{ 1200000,    750000 },
 	{ 1100000,    600000 },
 	{ 1000000,    500000 },
-- 
2.23.0

