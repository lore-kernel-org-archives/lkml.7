Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C1CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605D42084D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQMLI6pk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732734AbfB1NTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:19:11 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46064 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732580AbfB1NSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:18:49 -0500
Received: by mail-lj1-f195.google.com with SMTP id d24so16819908ljc.12;
        Thu, 28 Feb 2019 05:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yq5wxwSzSOiQKae/Fl8cjis8j+TFJgO/dAYMPjapJ44=;
        b=ZQMLI6pkhz4FichQRovBsROZVE0o1rccfacXxVHAiwvz2vsqEAKw1odE9HOdp6P1A+
         77qbZvwH72y8VWPpNd/yOA/aBLZuC4pmoTnJr39Au3GxjAVzuwwvNFBwJUv3wvb9zsjW
         AeTSYeQzICtECPhVbeiOg2o48Ks+RwysQldHJ81ZojpuwGx6aOunQtTqBHz9p5kxjJ3h
         t6kM79dJpqiHDrNCzmrkfXENwCeru8ryZEdEBupUuTWHijV2fSbmwpOq9bomUCkNjWbA
         JxMhUXrRxqEFOVBrwKRCkSLaSkwej7U312zPVY+24A/Cf1lF9PPd0ryCsWF1/JVlwLQX
         L8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yq5wxwSzSOiQKae/Fl8cjis8j+TFJgO/dAYMPjapJ44=;
        b=jtIe+IaZnvOsWsi9ucTV/7wrqDzDVjGK1O1n/1XOwDa7XoHmoH1y138XX8xsfSftJI
         ulaXEanB9jqCkSAaMxsxi+NRvwqsOLwbQAU/MPHbfZx29J8TpWy8+g1QPPKh0LseSYia
         S23rqz8PzGRTgcrvrWt5LwZnFk1366Yb5ZuoQ5rP2JgO1DGMPeAQV5/qcrDXfjgghXv5
         Mh4to4/0ejIqfSBzaJVjlDJQwClOJZonLbnIS5sqBJdv4To/Rgz7bLFk2m0TQ/XSX/Rw
         /zLEwQgyiXNrILgL22U4vZhGfPHL0YVj2wB4Nwe2EirliSu9m6Imn43oo6b6OXcXfkhR
         1+gw==
X-Gm-Message-State: APjAAAVZxzcV0khipQpfd6BhJZgOpwToIHgRULBtX98qlfnv1KJ22XNl
        CmN/4Hc0vQpDVgH3mv3n99w=
X-Google-Smtp-Source: APXvYqxhdeUnAcaKfxEk18cNm/P81OPskRfooEv3C22QWq4rZhSz64N/MELa1q5Y+lxpHlG4jedC7g==
X-Received: by 2002:a2e:7d09:: with SMTP id y9mr211227ljc.11.1551359927305;
        Thu, 28 Feb 2019 05:18:47 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id l26sm4600069lfc.37.2019.02.28.05.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 05:18:46 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/7] ARM: tegra: Set up L2 cache using Trusted Foundations firmware
Date:   Thu, 28 Feb 2019 16:17:04 +0300
Message-Id: <20190228131707.2592-5-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228131707.2592-1-digetx@gmail.com>
References: <20190228131707.2592-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tegra30 L2 cache should be initialized using firmware call if CPU
is running in insecure mode. Set up the required outer-cache write_sec()
callback early during boot using the firmware API, it is always a NO-OP
on T114+ and is NO-OP on T20/30 if Trusted Foundations firmware node
isn't present in device-tree.

Tested-by: Robert Yang <decatf@gmail.com>
Tested-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/tegra.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index f9587be48235..1e89cfefbf68 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -38,6 +38,7 @@
 #include <soc/tegra/fuse.h>
 #include <soc/tegra/pmc.h>
 
+#include <asm/firmware.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -74,6 +75,7 @@ static void __init tegra_init_early(void)
 {
 	of_register_trusted_foundations();
 	tegra_cpu_reset_handler_init();
+	call_firmware_op(l2x0_init);
 }
 
 static void __init tegra_dt_init_irq(void)
-- 
2.20.1

