Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FE0C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 02:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E524218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 02:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="d+18mWO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfCWCoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 22:44:44 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:58664 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbfCWCoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 22:44:44 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 9B802DF8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 02:44:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yl7jbEEMEIyo for <linux-kernel@vger.kernel.org>;
        Fri, 22 Mar 2019 21:44:42 -0500 (CDT)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 664F0DEF
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 21:44:42 -0500 (CDT)
Received: by mail-it1-f200.google.com with SMTP id q192so3929124itb.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 19:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DQEP0Ecrj0S52jv+NCt0UhJGFEyXuw7IK/qEbjIGKCA=;
        b=d+18mWO2B9ynaSObnkOK348G3yJwtpJzIT+LdvYHjaG14R1RVHK39GtyeS6WL+wfnK
         zlqTD+/H6kFbooUhJ4GFCUTZ1SpavlosxSbgHYu6ckH23LL/aLsIECdlIWPxBQ7XpCrc
         IvvQdTuROozAM31W7BeCIPO4RmvB8pYTDNgVX/hrnCNNSTngDJ+gYYAYTTdoh9ALfy44
         bUcq0A/W8OYn8LbZdR7+kfRhDQWpPyc1Y2FSTnuAuwmTVHwQhbv6x/GR64D149OyGIjo
         t+piT+jtsLuj6tBTT43hHws1K8G1zWsfAXXIstfKHh4kKvL6mpAoUsLGsSBQbkSd6Hob
         ZAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DQEP0Ecrj0S52jv+NCt0UhJGFEyXuw7IK/qEbjIGKCA=;
        b=CUELGWI1CQj59BgsuKd971yM8GF6i8SXETkwJNwOgJ7+qyfwzN/GaghgaBKm3SurZj
         C2bfOknw7uFnyHME5ydF2T8HJqAG+qWaAfofsu/ZX9MLzzp/HLiVDzooOkgekWOt1rp9
         COI59cbqGaNjfMSHmuTjkoK/efVLUac+LCIbQ+coxMfnQfksKVkEWAcv0uxy+vWGcoO9
         iPOKa7dGmm22r0PYo5iJCMUNTBeSM3QiaSRI0QrnkJToh1HEXAU3nZ4Z+djjf2BkysFP
         1F338Co/K7BG5Zh5q8KEz/DB27v/PMIXdgWgzPegdICo34A976o3DDjBn0PV69PjBDTr
         h9QA==
X-Gm-Message-State: APjAAAVYvK1Pd2kb9Czvgb6xSbEFQC9Fo/p1IYL7F/WdR8Sla7wiFINK
        9ttD7UhUWQyMq2sjaGe2YPp1DbIFR0Z+ic5nPvBxF8RGn3bT8BHVP0LMjViWWtuj+JncxePZN0G
        jfpFrEXPhLgeNR3K+uwsJGuxDF07s
X-Received: by 2002:a6b:ee02:: with SMTP id i2mr8847658ioh.219.1553309082041;
        Fri, 22 Mar 2019 19:44:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzrvV0mJ8xglWbZ7EKdV7CId3I3/GAxOiBwjb6juiO3+riV7jk8ZC6UbtVdNc2EpOR6UdGkow==
X-Received: by 2002:a6b:ee02:: with SMTP id i2mr8847649ioh.219.1553309081825;
        Fri, 22 Mar 2019 19:44:41 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id j23sm4120997iog.59.2019.03.22.19.44.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 19:44:41 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] input: pm8xxx-vibrator: fix a potential NULL pointer dereference
Date:   Fri, 22 Mar 2019 21:44:33 -0500
Message-Id: <20190323024434.14794-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of_device_get_match_data fails to find the matched data,
returns -ENODEV

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/input/misc/pm8xxx-vibrator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
index 7dd1c1fbe42a..740e59c11808 100644
--- a/drivers/input/misc/pm8xxx-vibrator.c
+++ b/drivers/input/misc/pm8xxx-vibrator.c
@@ -196,6 +196,8 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
 	vib->vib_input_dev = input_dev;
 
 	regs = of_device_get_match_data(&pdev->dev);
+	if (unlikely(!regs))
+		return -ENODEV;
 
 	/* operate in manual mode */
 	error = regmap_read(vib->regmap, regs->drv_addr, &val);
-- 
2.17.1

