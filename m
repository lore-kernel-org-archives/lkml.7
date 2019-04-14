Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D01C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 19:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8EC20850
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 19:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2kwauP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfDNTPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 15:15:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51055 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbfDNTPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 15:15:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id z11so17834500wmi.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 12:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IVWF5VbXq88Oe2XailmJT797hCzhKaf4Udl5bCUersw=;
        b=E2kwauP9kAv6Vek9iveRlBPfygNSsknEEmkxfwpoNpkp1USB3nYhRie3JcVP6mBEcU
         OvsC7buj8sI7kYXo9BEXOakenYHbfqh6FWNyy6NsKdu1cVMhIfa9gypEvuy19tpO8iV4
         2m0Zw+FVVadWO0rION1dJrwpHk4sLsSf/4BtHVpa15w5t+1WWTHS5/y8UIdih9pTxK7q
         vwfig9RJKrR9ur3xucSvMAmQJOIyxyvtYcviBytgn/mDiHfq5WsPewnH2xWoxR8Zjsze
         t3rUzbucj7QFRoThDY3I8fN+k8SDbFhyY5PffDPyqGZH+slLdW4ctPNOfmY0HWA+59AJ
         UsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IVWF5VbXq88Oe2XailmJT797hCzhKaf4Udl5bCUersw=;
        b=nw6oqfix0NCVI4wSeOoqykX9WF+wbccHEAli3Xf+xF/Ru+WBqLvMMpNDhlWowMUMBb
         czXhpNKOWXZe6oCxLaolCqSDIlVEDWIm+CXZ5YiDBaQ0o/yXzdNVvw3WsYTqpxA6WfHu
         F6trd/9+tUMwyPMVgwcavs5lPFmhJOtVtf1DGPNQAQjcxCzBrj5anBZOVGd3veuN5lW9
         YcA28tSpM0mK+DAineIII11I5lqOkm3tOYhXeJ64jbN4+3psfebcT6iMcddauomw1Jib
         qzBsxgm2UcwzkdELmZO+7GRa6dTkNN9dRWQFW6EdR8FCZ7frbVaINoP29kNejA9VpENB
         7WWw==
X-Gm-Message-State: APjAAAV2faq/nDwa9mpI7+CM9HkWquJIhbRhLbyuhieZOz4iHYbqSNvj
        zTPCovGRLOqXn1U94XJS+5Y=
X-Google-Smtp-Source: APXvYqw9xtJOlYdm8kIIjs3GPTe1nPDZwu8LxNodAniOJpc5iVOjx7iA8wLMBdWjxLBImhYSqo6AHg==
X-Received: by 2002:a1c:a742:: with SMTP id q63mr18522874wme.133.1555269311048;
        Sun, 14 Apr 2019 12:15:11 -0700 (PDT)
Received: from localhost.localdomain (p12.eregie.pub.ro. [141.85.0.112])
        by smtp.gmail.com with ESMTPSA id v16sm96654246wro.48.2019.04.14.12.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 12:15:10 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, daniel.baluta@gmail.com
Subject: [PATCH 2/2] ASoC: mpc5200_psc_i2s: Fix invalid license ID
Date:   Sun, 14 Apr 2019 22:14:50 +0300
Message-Id: <20190414191450.18377-3-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190414191450.18377-1-andradanciu1997@gmail.com>
References: <20190414191450.18377-1-andradanciu1997@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the file had no other license notice/reference, it falls under the
project license and therefore the proper SPDX id is: GPL-2.0-only

Cc: Daniel Baluta <daniel.baluta@nxp.com>
Fixes: 864a8472c4412 ("ASoC: mpc5200_psc_i2s: Switch to SPDX identifier")
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
---
 sound/soc/fsl/mpc5200_psc_i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index 6de97461ba25..9bc01f374b39 100644
--- a/sound/soc/fsl/mpc5200_psc_i2s.c
+++ b/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL
+// SPDX-License-Identifier: GPL-2.0-only
 //
 // Freescale MPC5200 PSC in I2S mode
 // ALSA SoC Digital Audio Interface (DAI) driver
-- 
2.11.0

