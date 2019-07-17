Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAD6C76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26ED121841
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fciAn2pT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfGQKTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 06:19:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39602 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQKTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 06:19:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so10935734pgi.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 03:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=47h7mNoqO2yjIf+Awl5RozvneGnjTx6MR3XFMeu6eY4=;
        b=fciAn2pTVnVyE5s5FVXbRgH1XKNS9xOCpqD5H9fswkBPYdyiTkKHfBJv0kncocpENV
         MpYMoIyUn616Kd5L0p3GFB1WFSkm02dI2a2n7BPn0+/fr6xw/nLGhzLkOwC7DDtBweQr
         PEOBXwF9y9dJwMvqwMmxHtrcAoeomRVRjy9MEObaBEaGLJuPTROHEt125DzEZvuBTbA3
         pWjsGu2/Z8V4O+eFtVYpdoihmo6+1nT/yu1Jtw84lTURE63k2Pu591ftFL94w9iJgfGf
         QWzrJCuMwAwa+s/dZhiBNO+ZH40XA44CqyoP26vGQNoSSXVo9HkRa5mXIXtin7KOj19v
         TttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=47h7mNoqO2yjIf+Awl5RozvneGnjTx6MR3XFMeu6eY4=;
        b=bGmJ3uyxxfVKe+QWCBQkpKlP0GBjyxNxNIFP5v7CLAGOQhHeiq9e8B6Lt/SfWzIWaI
         Ad6RpgHOX15QOGiNmnuPfj/MtznwMkZm5I/UEN7Om3yXNAZJPxnnH2hLix0l7lLds6tH
         PJKbsapYOOIir0RrXfnQZpaE9vqEFcPu8muy3240+xLaVVY22dAJS8cpzm/ptXRevuCN
         oNAE5RW6/8JZ93PySWCxDA2lmrjkLK3FwG+cFzcUY16ZbNW1cSqNOp+MWug3wsHcqbDR
         AuCtvnkptUTyAcUhhhbWdLhTcwHkmCpzT3mGfxBkJhih7Qvm+uUlQS/5zBxf64dA5cw5
         tKZg==
X-Gm-Message-State: APjAAAUxzOCY5zm1SIDLkQmPCTKIljmq1hiT9BKvcECofTzs9DnjgA+9
        0Cm07uLFNTqmX947kG+QYfyT7g==
X-Google-Smtp-Source: APXvYqx99DGNvMjwQ9E+nXYfGa8Bpdx3n8eMr1L+9m55nCd8gA3oMk/ssQiH9ob9gKOnQmAxabFGiQ==
X-Received: by 2002:a17:90a:2506:: with SMTP id j6mr7362792pje.129.1563358794014;
        Wed, 17 Jul 2019 03:19:54 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id i126sm23884866pfb.32.2019.07.17.03.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 03:19:53 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, niklas.cassel@linaro.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] opp: Not all power-domains are scalable
Date:   Wed, 17 Jul 2019 15:49:46 +0530
Message-Id: <90ba3941b56e50ea5548dd1e90bf3bcd8c9da4fe.1563358721.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A device may have multiple power-domains and not all of them may be
scalable (i.e. support performance states). But
dev_pm_opp_attach_genpd() doesn't take that into account currently.

Fix that by not verifying the names argument with "power-domain-names"
DT property and finding the index into the required-opps array. The
names argument will anyway get verified later on when we call
dev_pm_domain_attach_by_name().

Fixes: 6319aee10e53 ("opp: Attach genpds to devices from within OPP core")
Reported-by: Rajendra Nayak <rnayak@codeaurora.org>
Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 2958cc7bbb58..4e2a81698cd2 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1788,12 +1788,15 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
  *
  * This helper needs to be called once with a list of all genpd to attach.
  * Otherwise the original device structure will be used instead by the OPP core.
+ *
+ * The order of entries in the names array must match the order in which
+ * "required-opps" are added in DT.
  */
 struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names)
 {
 	struct opp_table *opp_table;
 	struct device *virt_dev;
-	int index, ret = -EINVAL;
+	int index = 0, ret = -EINVAL;
 	const char **name = names;
 
 	opp_table = dev_pm_opp_get_opp_table(dev);
@@ -1819,14 +1822,6 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names
 		goto unlock;
 
 	while (*name) {
-		index = of_property_match_string(dev->of_node,
-						 "power-domain-names", *name);
-		if (index < 0) {
-			dev_err(dev, "Failed to find power domain: %s (%d)\n",
-				*name, index);
-			goto err;
-		}
-
 		if (index >= opp_table->required_opp_count) {
 			dev_err(dev, "Index can't be greater than required-opp-count - 1, %s (%d : %d)\n",
 				*name, opp_table->required_opp_count, index);
@@ -1847,6 +1842,7 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names
 		}
 
 		opp_table->genpd_virt_devs[index] = virt_dev;
+		index++;
 		name++;
 	}
 
-- 
2.21.0.rc0.269.g1a574e7a288b

