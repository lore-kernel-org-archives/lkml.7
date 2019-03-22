Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084B2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF9021916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255259;
	bh=WCJi7EtrlDxEOMLGi2G3hJ14legWFkII0dHyUp9zVDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TRH8q6UErBVUSWQKHw4bkixtZknImAQPLMQFVZA4nz9BfBTtjPZWYJDgitpoUeQ0m
	 HQhN35clYPYvQXwk6mrOO1lai0araDa+tLGGolh0jkTno0Ysr3hjYenZYoUXMzohVs
	 sdplqHEldTD3f/jAfnRNzhx407nh26FdbCe408dc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbfCVLri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:47:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729276AbfCVLrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:47:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE9812075E;
        Fri, 22 Mar 2019 11:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255256;
        bh=WCJi7EtrlDxEOMLGi2G3hJ14legWFkII0dHyUp9zVDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wSVJCUkBv/UZLKAXZ22j+PSEpRvvdTQ5N++W1CYsDc9Tj9APWkS8bb6RT1Z0rnzZ+
         TDvc5mfpfOo6q9gVIVnbyWXjn+nvc4kgktu0gtxkhKUBI8Zh6wAFJbuRSpgoX/NQwB
         fM0zjSfKXM6xZkTwSDnsn/xpG6fwAGN65/KLhYMA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 016/183] Input: pwm-vibra - stop regulator after disabling pwm, not before
Date:   Fri, 22 Mar 2019 12:14:04 +0100
Message-Id: <20190322111242.958459068@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 94803aef3533676194c772383472636c453e3147 ]

This patch fixes order of disable calls in pwm_vibrator_stop.
Currently when starting device, we first enable vcc regulator and then
setup and enable pwm. When stopping, we should do this in oposite order,
so first disable pwm and then disable regulator.
Previously order was the same as in start.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/misc/pwm-vibra.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/pwm-vibra.c b/drivers/input/misc/pwm-vibra.c
index 9df87431d7d4..dbb6d9e1b947 100644
--- a/drivers/input/misc/pwm-vibra.c
+++ b/drivers/input/misc/pwm-vibra.c
@@ -80,14 +80,14 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
 
 static void pwm_vibrator_stop(struct pwm_vibrator *vibrator)
 {
+	if (vibrator->pwm_dir)
+		pwm_disable(vibrator->pwm_dir);
+	pwm_disable(vibrator->pwm);
+
 	if (vibrator->vcc_on) {
 		regulator_disable(vibrator->vcc);
 		vibrator->vcc_on = false;
 	}
-
-	if (vibrator->pwm_dir)
-		pwm_disable(vibrator->pwm_dir);
-	pwm_disable(vibrator->pwm);
 }
 
 static void pwm_vibrator_play_work(struct work_struct *work)
-- 
2.19.1



