Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80363C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55271222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3LIBBZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbfIZTZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 15:25:42 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39277 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbfIZTZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 15:25:41 -0400
Received: by mail-lf1-f65.google.com with SMTP id 72so59229lfh.6;
        Thu, 26 Sep 2019 12:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0kXG5yDieCzAILD8cRkpsMGSlnoUT5rFe6gbk7OKPRU=;
        b=P3LIBBZ/lW82t3QCarXGEBEV+PWZOP+3Qlu4QflVZqswGdCfLW+G+CUlubMOZlYQ4c
         nTRLLgS2WB0kJbnoCtEKOBZWXKluuBoTkeLFDD51ZLF/93LXuTknTD+6d1f1AxQSFGr3
         nWTx49C/zOxVl2I3/YA+N8wjxsb65q9QLBugc8jYRiOXw1Gz3e3CU69ASnWFUj02rEWt
         4Co3z4FVhkzQISA8bzfhz44OMK0YN5LchNpO2deoU/90IYgt8z6wUUfVv+NYds3XdGR/
         CdjbFFuuisDs7Zwj1jpDbhJlbb0nRzaKnVAUsLq072Hn5/tckhY/FloulQHcPnlC6Qlt
         6zBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0kXG5yDieCzAILD8cRkpsMGSlnoUT5rFe6gbk7OKPRU=;
        b=SYZfksQlgPFFEpH5Spcpc3LxA15rbqFw0oRd8gEA9OqFVhUVq3H6Tpgldg4aH1nhf2
         00ysJUXVyMZRyVh4wu6lGjEW4GasZIpbtjMNIy+AvCf08EaK5aavwX+RBgPPLBkuVmsC
         vuo2Y+6048h08syCR2pr+Jg931ilpBqLfDLpjpTZu/69/M9fPAaNESejyLt85wUfRHN/
         xFNzf2yVHZqj1wgJZIJuwrrtZuM2PwV9+p/CFidYb3zsbr3p+sJWUXMlcwIHgsdRs8E5
         FKR32GfWZ4pqJJg6BITWINTLXB/fKqyUjxzndQqIqA2dQkEI9y9yWTeu1FVLcVgYstLK
         OlVA==
X-Gm-Message-State: APjAAAUJAy5Uxj9hanvh1nKNly5xv3LsR053o8BVJc2bfMqr/8o0GAlZ
        leYev0ZsnaSukvSDliqUT98=
X-Google-Smtp-Source: APXvYqzYbJ+v6GyybIl3sa2JHnlUOsgcwZtvaKA7TQLwkTgfEF/yFZ/lvrJ/VqdKf57e/98s32V1mw==
X-Received: by 2002:a05:6512:4dd:: with SMTP id w29mr131874lfq.2.1569525938947;
        Thu, 26 Sep 2019 12:25:38 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-32-67.pppoe.spdop.ru. [94.29.32.67])
        by smtp.gmail.com with ESMTPSA id 202sm13888ljf.75.2019.09.26.12.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 12:25:38 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] soc/tegra: pmc: Remove unnecessary memory barrier
Date:   Thu, 26 Sep 2019 22:17:55 +0300
Message-Id: <20190926191755.27131-2-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190926191755.27131-1-digetx@gmail.com>
References: <20190926191755.27131-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The removed barrier isn't needed because writes/reads are strictly ordered
and even if PMC had separate ports for writes, it wouldn't matter since
the hardware logic takes into effect after triggering CPU's power-gating
and at that point all CPU accesses are guaranteed to be completed. That
barrier was copied from the old arch/ code during transition to the soc/
PMC driver and even that the code structure was different back then, the
barrier didn't have a real useful purpose from the start. Lastly, the
tegra_pmc_writel() naturally inserts wmb() because it uses writel(),
and thus this change doesn't actually make any difference in terms of
interacting with hardware. Hence let's remove the barrier to clean up
code a tad.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v5: Extended the commit's message.

v4: No changes.

v3: No changes.

v2: New patch that was added after Jon's Hunter pointing that it's better
    not to change the barrier's placement in the code. In fact the barrier
    is not needed at all.

 drivers/soc/tegra/pmc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index ee39ded6bc7b..f75708a935ac 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1463,8 +1463,6 @@ void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
 	do_div(ticks, USEC_PER_SEC);
 	tegra_pmc_writel(pmc, ticks, PMC_CPUPWROFF_TIMER);
 
-	wmb();
-
 	value = tegra_pmc_readl(pmc, PMC_CNTRL);
 	value &= ~PMC_CNTRL_SIDE_EFFECT_LP0;
 	value |= PMC_CNTRL_CPU_PWRREQ_OE;
-- 
2.23.0

