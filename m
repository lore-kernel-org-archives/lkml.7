Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B551AC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 06:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797542081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 06:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="USMRKPMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfCIGaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 01:30:52 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:33274 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfCIGav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 01:30:51 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 1F1D7D22
        for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2019 06:30:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NckIvF4KZEvy for <linux-kernel@vger.kernel.org>;
        Sat,  9 Mar 2019 00:30:49 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id DB8E0D1B
        for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2019 00:30:49 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id m15so17170548ioc.16
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 22:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=nurTLZi7ZZTrj3Ks+uFfVRbQaS2Tt+sCNdUD/Hv/o9Q=;
        b=USMRKPMoeU2OvadzshIJIBt3XHuUPgqFspFs97EcX5etOYE8NTB8daL92DmivZLDYr
         PN39g0w1+37o9aO0ZS8dcMC2JXUsbHI+f4am0XpxCAQWW4nfYvqq7yLODyX2dLI8ZF+3
         GtfVe7oIhDLk41hgRz0S50VIXR6aKAt1NMlr/O2tb7h0h2i6a3pMPOPkB6nxJID3gs3P
         W85FbgIWUIC4TCyG+HJ1z7NnoipdHGby5agj84YxXqIc8kYj5cvZe5kQ+rSZFh15pcSt
         HTE20U9T3z1td1JoiNqomjgKCbnrPldPfFUhkB9Tr7/ojh8ouIS85lvakseP8NScEnty
         mCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nurTLZi7ZZTrj3Ks+uFfVRbQaS2Tt+sCNdUD/Hv/o9Q=;
        b=kVyUj5+4H1Hd4E/2J+IUtlSpMLxaPj2Eb+9v96UTE5R+vBTEdnWZVpS2xCvtyllR3b
         zw/1dAXyyNIDfDmTZyxFu6bL4uOPFjgl8vAJBmOKiMyV2tHWzktA6SnbUs3WKGbV/gSF
         +vZVBeerIvO3htx7bbIbBboV9UI/dQ08AZCZjKvBe0gc1FTQT8I5vdUoDvq6B1/MFCaL
         NZzBMWdPnitnwZusdCTifxyXVTuH9KPHi1Rz9VwYdvq2MpuBAAhqWH1iPjT0AEO41/35
         +6yM1Qlm6l9qX581vQO4wm0t2Zvlc9R1Q2GZdu55c5nb88TdfXO+SaBH4csUzcV+nueY
         ++ZA==
X-Gm-Message-State: APjAAAWCkY2wIgQLxhVncdMb/joLm3KOVT3kVQzUr8hxgY2yIhsfCzyH
        toO/oQZTIv8YRzo3dHtYP/CFC25xo8pHEMbeoyHA/X8X0xYtPKWZEczRpd+EXj1T5MR7tk1qvC2
        Wsb5VpV4v6GTDealOY009SF9VhpBs
X-Received: by 2002:a24:7d84:: with SMTP id b126mr10353707itc.58.1552113049479;
        Fri, 08 Mar 2019 22:30:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqyqjI8njjJ9Z2cAPmCIt8r2qQ+6vdawBVkBUnpXidgCuvJW0bjX7C5sK4BIRtWdMmQWBXb5jw==
X-Received: by 2002:a24:7d84:: with SMTP id b126mr10353700itc.58.1552113049209;
        Fri, 08 Mar 2019 22:30:49 -0800 (PST)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id o200sm5190000ito.32.2019.03.08.22.30.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 22:30:48 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: stv090x: add missed checks for STV090x_WRITE_DEMOD
Date:   Sat,  9 Mar 2019 00:30:07 -0600
Message-Id: <20190309063009.31558-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conservatively check return value of STV090x_WRITE_DEMOD in case
it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/media/dvb-frontends/stv090x.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/media/dvb-frontends/stv090x.c b/drivers/media/dvb-frontends/stv090x.c
index a0622bb71803..3e2af3969e16 100644
--- a/drivers/media/dvb-frontends/stv090x.c
+++ b/drivers/media/dvb-frontends/stv090x.c
@@ -1446,14 +1446,17 @@ static int stv090x_start_search(struct stv090x_state *state)
 		/* >= Cut 3 */
 		if (state->srate <= 5000000) {
 			/* enlarge the timing bandwidth for Low SR */
-			STV090x_WRITE_DEMOD(state, RTCS2, 0x68);
+			if (STV090x_WRITE_DEMOD(state, RTCS2, 0x68) < 0)
+				goto err;
 		} else {
 			/* reduce timing bandwidth for high SR */
-			STV090x_WRITE_DEMOD(state, RTCS2, 0x44);
+			if (STV090x_WRITE_DEMOD(state, RTCS2, 0x44) < 0)
+				goto err;
 		}
 
 		/* Set CFR min and max to manual mode */
-		STV090x_WRITE_DEMOD(state, CARCFG, 0x46);
+		if (STV090x_WRITE_DEMOD(state, CARCFG, 0x46) < 0)
+			goto err;
 
 		if (state->algo == STV090x_WARM_SEARCH) {
 			/* WARM Start
@@ -2604,7 +2607,8 @@ static enum stv090x_signal_state stv090x_get_sig_params(struct stv090x_state *st
 
 	if (state->algo == STV090x_BLIND_SEARCH) {
 		tmg = STV090x_READ_DEMOD(state, TMGREG2);
-		STV090x_WRITE_DEMOD(state, SFRSTEP, 0x5c);
+		if (STV090x_WRITE_DEMOD(state, SFRSTEP, 0x5c) < 0)
+			goto err;
 		while ((i <= 50) && (tmg != 0) && (tmg != 0xff)) {
 			tmg = STV090x_READ_DEMOD(state, TMGREG2);
 			msleep(5);
@@ -2910,7 +2914,9 @@ static int stv090x_optimize_track(struct stv090x_state *state)
 			pilots = STV090x_GETFIELD_Px(reg, DEMOD_TYPE_FIELD) & 0x01;
 			aclc = stv090x_optimize_carloop(state, modcod, pilots);
 			if (modcod <= STV090x_QPSK_910) {
-				STV090x_WRITE_DEMOD(state, ACLC2S2Q, aclc);
+				if (STV090x_WRITE_DEMOD(state, ACLC2S2Q, aclc)
+						< 0)
+					goto err;
 			} else if (modcod <= STV090x_8PSK_910) {
 				if (STV090x_WRITE_DEMOD(state, ACLC2S2Q, 0x2a) < 0)
 					goto err;
@@ -2972,7 +2978,8 @@ static int stv090x_optimize_track(struct stv090x_state *state)
 	reg = STV090x_READ_DEMOD(state, TMGOBS);
 
 	if (state->algo == STV090x_BLIND_SEARCH) {
-		STV090x_WRITE_DEMOD(state, SFRSTEP, 0x00);
+		if (STV090x_WRITE_DEMOD(state, SFRSTEP, 0x00) < 0)
+			goto err;
 		reg = STV090x_READ_DEMOD(state, DMDCFGMD);
 		STV090x_SETFIELD_Px(reg, SCAN_ENABLE_FIELD, 0x00);
 		STV090x_SETFIELD_Px(reg, CFR_AUTOSCAN_FIELD, 0x00);
-- 
2.17.1

