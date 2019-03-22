Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11626C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EB32082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Blt/HSdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfCVDaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 23:30:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37368 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbfCVD3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 23:29:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id q206so505895pgq.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 20:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VOc/5yQCsAvD8OjvVz+n50OZOgpX7N3tx64piXBEesg=;
        b=Blt/HSdUEH/v/5vwEHd0IJzvLpi/M1PDMXkn2f7n8RlRDaNJWV831F5ZTdLWbV3vht
         +OvDDJvJ1fNEL+EjA72VCRVDJKxu83PhwTkISn0rz3kYexr1U9mO8u9DOICOFlzHoTzW
         qJNw3M2q/NB17jWf2tyWD0+8vTkMS1iv/a45bySuESh56NXi8ORjUHZF0/CUOAao9GrG
         MtQcUQtAGAqZMaA2zBcExydLq53LiVcftw8w32+nS0PWQ6ZENXKtG4YFYiOCNkRXG8tw
         991GwJP4UJU7ifsDFsy1dsmzNZnNg5zhGhalD9Nhk2L4Uif905ZO9QVFZnzuHWcitn0r
         8o6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VOc/5yQCsAvD8OjvVz+n50OZOgpX7N3tx64piXBEesg=;
        b=joPz4cSKvHh6VrAuxqbA26DyCFgbzqHy9Pfsjp2ECI5nQKM4bPY7DhDfxqqd5GLHA7
         tojIX11l4sfjwx4b2OnjQrp3K/T4jYdkeEoEC/LCoA8fjcZhiFXEbxhFE1yM0dq1vztu
         v4zIAqXgguZto9IfaEOIfKGOhwDhr1tBUk8GqJx6cO7X/K4eiqmoZXbOiQZtEeFfAvfU
         8OKWY2mX3VQy+XeHwCZ9wdxcf1KPpYUMs058hofVAUdNhmR9V7vQXS/czaovj2n3Jbg8
         uf7C/Ok41cpPQfkSX55S8qnoDvfK51GfR3IdFnozliPIqA57iy8OxTzC8QdSDePXRwj5
         VX5w==
X-Gm-Message-State: APjAAAWesiRo6vO/MEDtzzXWX0fAe5J2Boq6tr6oNaosEVZ+RT5XWfB8
        5OfZRfG2JoJ/Aais6rTAncY=
X-Google-Smtp-Source: APXvYqycK7iLScZNxNVOYrFkda9YdoAMbf6K2CLIpZNjv6EPTe8sUbWc+PaMWEhMZsRvDLcH1BGKew==
X-Received: by 2002:a63:3fc8:: with SMTP id m191mr6722072pga.240.1553225358146;
        Thu, 21 Mar 2019 20:29:18 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o76sm16154476pfa.156.2019.03.21.20.29.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 20:29:17 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/15] drm/bridge: tc358767: Simplify polling in tc_link_training()
Date:   Thu, 21 Mar 2019 20:28:49 -0700
Message-Id: <20190322032901.12045-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322032901.12045-1-andrew.smirnov@gmail.com>
References: <20190322032901.12045-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace explicit polling in tc_link_training() with equivalent call to
tc_poll_timeout() for simplicity. No functional change intended (not
including slightly altered debug output).

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Archit Taneja <architt@codeaurora.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 2531f4dadbf8..38d542f553cd 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -733,21 +733,18 @@ static int tc_set_video_mode(struct tc_data *tc, struct drm_display_mode *mode)
 
 static int tc_wait_link_training(struct tc_data *tc, u32 *error)
 {
-	u32 timeout = 1000;
 	u32 value;
 	int ret;
 
-	do {
-		udelay(1);
-		tc_read(DP0_LTSTAT, &value);
-	} while ((!(value & LT_LOOPDONE)) && (--timeout));
-
-	if (timeout == 0) {
+	ret = tc_poll_timeout(tc, DP0_LTSTAT, LT_LOOPDONE,
+			      LT_LOOPDONE, 1, 1000);
+	if (ret) {
 		dev_err(tc->dev, "Link training timeout waiting for LT_LOOPDONE!\n");
-		ret = -ETIMEDOUT;
 		goto err;
 	}
 
+	tc_read(DP0_LTSTAT, &value);
+
 	*error = (value >> 8) & 0x7;
 
 	return 0;
-- 
2.20.1

