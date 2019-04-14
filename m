Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CC0C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 19:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388D020850
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 19:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkeD1/xk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfDNTZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 15:25:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45137 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfDNTZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 15:25:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id bf11so7466846plb.12;
        Sun, 14 Apr 2019 12:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pp1ylpAMq1DcvOKU5DqK7TZfKN1qmsD9XOpVBBwXOus=;
        b=mkeD1/xkOznJNC0ijtPxz7QMbwsKBtetTIWyHoOhKGKqdhV6xPSQ/E1it16fDE6wcS
         fnnWiBUfiN02mqfs6vy+m4QqfCydzeKhH3MwBq6vSOLJZnZeM3pwEJjAz2oruJLjmFXz
         jwoC2F2udLt0QKu2SedTKmw73MeI6RR2F7S1gMto252BRzqMP0IZXARc60EWpIBKIb45
         Oo8l0igiRYGXDk8XeS5J2thlo6bZgCLmAWgeoCy1QVgUVYXSqH3pTgzZ8gOonKhEf6pJ
         Z02mihkavy7DNNyvuCtfC4sYJDOfau2aujSUhPjNlYbYlQhQ5/7DgXrFNmS/4JwV7muW
         o+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pp1ylpAMq1DcvOKU5DqK7TZfKN1qmsD9XOpVBBwXOus=;
        b=WgSCQUVNAPDdaSaD+8jUKKFmD4q/qbLZCdkOPcmv2jvkHUy5kx5Iiao/3WEJ79iTLO
         PjuvERA4ukF7kFRC1w4Lyoj1p7Bh4opSiSonxbPhh3GxBnrUuM53qzZB4MjcIMMqNtRN
         aMVozk1fOo2J6cU8p5zY5KMm36l2GZ1LWCe0RvdTo9f29ruYDwiSsdaWsDXiutU2los8
         s1h5xzSODMMVRzhPwa6d6vzHk0rS472PEhMRzZAHtQpmMwSqPKi3vG3ApNykPIIc/s2x
         YYsKh1EoGLuuH1Cznec4i0ty2dkdse+4FzVSZGsrc/FYQdXmJ/Djz7kYMkI6uLzs1rb1
         mXtw==
X-Gm-Message-State: APjAAAWAFsto33GhdlpcKXakiAgTlAxRoYvNHHrWbe1HKJN5vXgTiUDU
        a6FJZ5hzHY4/2OUAE5PS8N4=
X-Google-Smtp-Source: APXvYqwH8cewAO6SkDk7XPuFqxfmyq7CURGAp6r7Bwa2rJdrFdodvjPqW62RQheM2g8k5YEYRiNHSw==
X-Received: by 2002:a17:902:a607:: with SMTP id u7mr71951874plq.66.1555269916293;
        Sun, 14 Apr 2019 12:25:16 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id j4sm17837398pgi.71.2019.04.14.12.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 12:25:15 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] clk: tegra: emc: Replace BUG() with WARN_ONCE()
Date:   Sun, 14 Apr 2019 22:23:20 +0300
Message-Id: <20190414192321.23294-5-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190414192321.23294-1-digetx@gmail.com>
References: <20190414192321.23294-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no justification for the BUG() in this code.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-emc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-emc.c b/drivers/clk/tegra/clk-emc.c
index 9a0179235939..93ecb538e59b 100644
--- a/drivers/clk/tegra/clk-emc.c
+++ b/drivers/clk/tegra/clk-emc.c
@@ -222,7 +222,10 @@ static int emc_set_timing(struct tegra_clk_emc *tegra,
 
 	if (emc_get_parent(&tegra->hw) == timing->parent_index &&
 	    clk_get_rate(timing->parent) != timing->parent_rate) {
-		BUG();
+		WARN_ONCE(1, "parent %s rate mismatch %lu %lu\n",
+			  __clk_get_name(timing->parent),
+			  clk_get_rate(timing->parent),
+			  timing->parent_rate);
 		return -EINVAL;
 	}
 
-- 
2.21.0

