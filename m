Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98067C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 05:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666D821582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 05:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XRJUCRbB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfLRF51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 00:57:27 -0500
Received: from mail-m972.mail.163.com ([123.126.97.2]:35158 "EHLO
        mail-m972.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLRF51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 00:57:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=BulQTA6G1N4TWHEAvp
        OsyuqFrzbeQQmLPGWhFy4BohA=; b=XRJUCRbB0X3DC2/ZWr5mhVoutDzXnQaiEt
        WgrdPoK52rCc6FT37BGdo8Hhrvn2tMTeTA0OnEvtoK44npKsg7WF10/hfhZQLKBG
        CzR4vDrxolydO3b0qEmiKwWiYHEOoW0U4F+dPnzZ3csAD9CqAV4qYCXI1CvXqGqy
        /IL6HA/1g=
Received: from localhost.localdomain (unknown [218.106.182.184])
        by smtp2 (Coremail) with SMTP id GtxpCgBnMzqbv_ldmP0WAA--.443S3;
        Wed, 18 Dec 2019 13:57:01 +0800 (CST)
From:   Xidong Wang <wangxidong_97@163.com>
To:     Xidong Wang <wangxidong_97@163.com>,
        Marc Dietrich <marvin24@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] staging: nvec: check return value
Date:   Wed, 18 Dec 2019 13:56:38 +0800
Message-Id: <1576648598-12257-1-git-send-email-wangxidong_97@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: GtxpCgBnMzqbv_ldmP0WAA--.443S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtryxWw1DXw4Uuw4DJr4Utwb_yoW3ZFX_Cw
        savw1xZrZrArn7Ar4qywn8ArW29rWfWrs2qr4qg392vayUur4Sv3yDXr1DC3yUW3yxGrW3
        uFyqkr4ayr13ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjFAp7UUUUU==
X-Originating-IP: [218.106.182.184]
X-CM-SenderInfo: pzdqw5xlgr0wrbzxqiywtou0bp/1tbi8A2P81uoWGCDAwAAsK
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In nvec_kbd_probe(), the return value of devm_input_allocate_device()
should be checked before it is used.

Signed-off-by: Xidong Wang <wangxidong_97@163.com>
---
 drivers/staging/nvec/nvec_kbd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/nvec/nvec_kbd.c b/drivers/staging/nvec/nvec_kbd.c
index 01dbb66..386d619 100644
--- a/drivers/staging/nvec/nvec_kbd.c
+++ b/drivers/staging/nvec/nvec_kbd.c
@@ -123,6 +123,8 @@ static int nvec_kbd_probe(struct platform_device *pdev)
 		keycodes[j++] = extcode_tab_us102[i];
 
 	idev = devm_input_allocate_device(&pdev->dev);
+	if (!idev)
+		return -ENOMEM;
 	idev->name = "nvec keyboard";
 	idev->phys = "nvec";
 	idev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) | BIT_MASK(EV_LED);
-- 
2.7.4

