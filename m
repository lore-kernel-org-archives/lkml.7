Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F02C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6E5217D4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334250;
	bh=GKK/7wK91Yf3sfK6ORnQnJ3PSdPZH9e1OlDo+OAUrBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n7GBZ30ECJbVM0ed1iB4hTnzXG/ws5byQszD1BiZMNu4idtToHYY5cqoGtYCsR101
	 mqn8kgokU11l912IOGtXrJnsE9YHA6U0rtZWIm2eFvJ7Xlq3N0bJZ7TTs505Ji91zF
	 EUtiicZBTkwakeFh50ROLO8m39B+wgIlUcAqKZ2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfCKT52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:57:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729043AbfCKT5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:57:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C19202087C;
        Mon, 11 Mar 2019 19:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334243;
        bh=GKK/7wK91Yf3sfK6ORnQnJ3PSdPZH9e1OlDo+OAUrBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BoeF7Xf3RvLTfjpF4SXOBgs7+/fNmeR0HeVvr8mgYHxFEw98FLWcbtR9s/JTaBkrp
         ZjRntxdrnDzmLesCcDYW6mVtpiqbZtyj8mYZ2bdvBPz1iJTk51PR78/pX9LAAWmY5k
         xcl1X45Gl/KG1RmAAMaP3OMVMbVMkHNZ37oNoOx8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 11/44] Input: pwm-vibra - stop regulator after disabling pwm, not before
Date:   Mon, 11 Mar 2019 15:56:27 -0400
Message-Id: <20190311195700.138462-11-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195700.138462-1-sashal@kernel.org>
References: <20190311195700.138462-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>

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

