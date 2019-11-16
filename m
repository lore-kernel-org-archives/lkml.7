Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E59C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28E32089D
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573919880;
	bh=i4QKo1c3jisTV2BspdLecAEOwACkSI6dwzcxae6X5fI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r95Ahq0D9ievsS6PN0UTEEAarKb82YHgkEgpW9BDpGR2kboR4IeprixHl/LXGhc18
	 ZAGQFA4w4A/AOmXWueWX+KRCmsLfzbXQi2MOMuwm9bjm+25T+ziZuEShUOeq32jBkD
	 Pshv5nU98S1Ho3xlm9LaGHZyUtjcliaabRn86v2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbfKPP56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:57:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:36108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730145AbfKPPy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:54:27 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91FB8208E3;
        Sat, 16 Nov 2019 15:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919666;
        bh=i4QKo1c3jisTV2BspdLecAEOwACkSI6dwzcxae6X5fI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ghND9pJ10iJPn3seTYiL7rttUJQVIySVfAlYxSW08UQnUsAXPrazLsNrpDXgtoco1
         pKhMGDPrYk8+79R72fqTvPJxI0h7U8V0Fa+lhlZ7ZLYkSHNEO3idBu8gUBPdOQqxJf
         /qaYUQE2mk2owMY5Zey8pONJl+F0YrovKgTz8h2Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 39/77] thermal: rcar_thermal: Prevent hardware access during system suspend
Date:   Sat, 16 Nov 2019 10:53:01 -0500
Message-Id: <20191116155339.11909-39-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116155339.11909-1-sashal@kernel.org>
References: <20191116155339.11909-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 3a31386217628ffe2491695be2db933c25dde785 ]

On r8a7791/koelsch, sometimes the following message is printed during
system suspend:

    rcar_thermal e61f0000.thermal: thermal sensor was broken

This happens if the workqueue runs while the device is already
suspended.  Fix this by using the freezable system workqueue instead,
cfr. commit 51e20d0e3a60cf46 ("thermal: Prevent polling from happening
during system suspend").

Fixes: e0a5172e9eec7f0d ("thermal: rcar: add interrupt support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/rcar_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 13d01edc7a043..487c5cd7516c0 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -350,8 +350,8 @@ static irqreturn_t rcar_thermal_irq(int irq, void *data)
 	rcar_thermal_for_each_priv(priv, common) {
 		if (rcar_thermal_had_changed(priv, status)) {
 			rcar_thermal_irq_disable(priv);
-			schedule_delayed_work(&priv->work,
-					      msecs_to_jiffies(300));
+			queue_delayed_work(system_freezable_wq, &priv->work,
+					   msecs_to_jiffies(300));
 		}
 	}
 
-- 
2.20.1

