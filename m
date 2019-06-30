Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D137BC4646D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 21:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C8A2146E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 21:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNHeJwLY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfF3VEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 17:04:53 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34873 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfF3VEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 17:04:50 -0400
Received: by mail-lf1-f65.google.com with SMTP id a25so7355571lfg.2;
        Sun, 30 Jun 2019 14:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ktJdYx+oayM5XZOYipi+WOTUfNybPIUthW663QchIPc=;
        b=CNHeJwLYtES01T/MLO8htraajR7hzRwjTkTKisgkj91iVRRMLltXLek4sbYWdT3L77
         Oy30N9xSHsrYQXogvOYkZxrivfb5V+FLbJ9CSmtaOnlWpFFZyLEdpl3vojSkO+m2GOCr
         rgNYgvtDf2YK6/JcNr7SciFvSD7kcQV/9Fm2lU1B4kgkR/0HK+qEuedZUqux9eFc9C9e
         CffK4WLzibzrX3Jy58eI55Y1HmDgKACXGf4GDB5/a55ktUUKocemWuZnDa+Xq4sWAvFH
         cZ9zZ5PF7fXoNEXYkWO1pDk/SNP9BshvWYuG50BOM/DMXtGF/G5IRtITwTahGFoPRFzd
         nkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ktJdYx+oayM5XZOYipi+WOTUfNybPIUthW663QchIPc=;
        b=XmwENpzlB9F6iyCs365z/3sq79RrvupOdGTz7QZy6ih4TLzXgoiI/IpVsYFlIi0gOR
         iBEJTUrVWQqfcM9aWH/m/+aGeFdxX2WJG6JQJK/gE96SfI6TO8C76/jdan2yvkhjDuS1
         ZR2tpQGWDXPsEGYTv2Z4URrx1DKawQ5N3uePuP8RYBIheW4/9kJog5LLqBq18X4QCfOi
         p2YJv1sCvFOSHdHsWFrfoEivsOugzMiS3ThVJ9oNIefD7jkpWAGTkg13xN+IbUL2PiXO
         MkpvcKCFKqfgXU9tCd7c8qITrtPV6cnAdK9QV8Wwjhh2XRezKf3zI0Upn39GnwUOAQ2j
         xtaA==
X-Gm-Message-State: APjAAAVQtqz/h/s+Hrqg7QWwuMiX3GB2fej1vlyMlPiB+rf2xEJJACqc
        aoiOweilFoz+mPnbYY0XcYs=
X-Google-Smtp-Source: APXvYqxkbnJNJXgHM56JuwVV5SLJZWipoIJK8TXLTsyK2OVcXw8AHnIy79bqeBUEP1gpJQVAihqM/A==
X-Received: by 2002:a19:ed0c:: with SMTP id y12mr9630213lfy.191.1561928688261;
        Sun, 30 Jun 2019 14:04:48 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id u9sm2221408lfb.38.2019.06.30.14.04.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jun 2019 14:04:47 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 11/15] memory: tegra: Ensure timing control debug features are disabled
Date:   Mon,  1 Jul 2019 00:00:15 +0300
Message-Id: <20190630210019.26914-12-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190630210019.26914-1-digetx@gmail.com>
References: <20190630210019.26914-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Timing control debug features should be disabled at a boot time, but you
never now and hence it's better to disable them explicitly because some of
those features are crucial for the driver to do a proper thing.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 3 +++
 drivers/memory/tegra/mc.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 43819e8df95c..1bad7f238881 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -657,6 +657,9 @@ static int tegra_mc_probe(struct platform_device *pdev)
 	} else
 #endif
 	{
+		/* ensure that debug features are disabled */
+		mc_writel(mc, 0x00000000, MC_TIMING_CONTROL_DBG);
+
 		err = tegra_mc_setup_latency_allowance(mc);
 		if (err < 0) {
 			dev_err(&pdev->dev,
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index 410efc4d7e7b..cd52628c2b96 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -30,6 +30,8 @@
 #define MC_EMEM_ARB_OVERRIDE				0xe8
 #define MC_EMEM_ARB_OVERRIDE_EACK_MASK			0x3
 
+#define MC_TIMING_CONTROL_DBG				0xf8
+
 #define MC_TIMING_CONTROL				0xfc
 #define MC_TIMING_UPDATE				BIT(0)
 
-- 
2.22.0

