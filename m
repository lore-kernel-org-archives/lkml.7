Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBB4C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F7720873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XK+t4wD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732040AbfJNSnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 14:43:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34391 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfJNSnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 14:43:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id k20so3235231pgi.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 11:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=amREymzw1c6IsU6bF35CaFvFb2Rgm1/hiMFDrclp26M=;
        b=XK+t4wD79Ig4XGQ4KNdIg9ZVoBmi2QaekTMsU8vIwP32GqyVTKnznyb7UAYapnT37+
         IGoq46ttsalEit36po3g3a5Lq8LjvNj6jGaacY3w0J3KRdhr9ugyweQAt8WB0PcozswI
         qiKwxFZ+EH4NgXEd5a1jurV2477AM8DxKkkWk6bvRE8IzqVLhgLBjSr61VOhV9BGzRBM
         qSURxpI4BjxrK/ralolypJPuECgp98diaQrXcAgVydZ6lu+wmEwsI3cnyczcZGd7y2ME
         Vq3M/J40MNlo209NJQfcVrYX8aclXLFe5QjZb8HgV0+99B8NiRSfiiTVtRHcC1OYafps
         8/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=amREymzw1c6IsU6bF35CaFvFb2Rgm1/hiMFDrclp26M=;
        b=GLmSYVDwgGqrr4SgOEevVCp2NHJ7MDD8j/Ex1qFh5Lq/bftGd2Mc/5LHxIx7zhGxzM
         pOlG1j2T6bAd9MD7eXLaMyVK3GA91iK6DU/Uk1Yp5v+/6iS5sVvf4sKmwKkasGCn2GUm
         /62mMhppkgfq9eSY2vVBmd8LR/SoHMKTbwvw419hgdFSJgJRNBcHeVJTzX4O0qs8bhUI
         g8QcO1cMtVIdGD1c/coD4yaiDSLOoTLe3n2Tgxns3oV1pMRqECHp9eFg4jgcY4esHwsF
         JNTt0IzoZgbEKSNBAx4SVHTdcN1ZcG067RIsD36gCx7uLH8A5cPIav3HR889zHm7ZrZD
         JcPw==
X-Gm-Message-State: APjAAAUepy6VH2OpM9SA199xbacb8DYk4vr5KP5mx75cPp8QSR29MXYt
        j4g6jdT+Mb6SdqZfB2IlxRs=
X-Google-Smtp-Source: APXvYqycaefK5rF/bgwFS26ZwLJNFQ3sCrNf1OMFZGNcsDq/+L0n63OCH9D2loyEuczmKh42TzZDXA==
X-Received: by 2002:a63:e802:: with SMTP id s2mr34339525pgh.188.1571078603482;
        Mon, 14 Oct 2019 11:43:23 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id c26sm16932953pfo.173.2019.10.14.11.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 11:43:22 -0700 (PDT)
Date:   Mon, 14 Oct 2019 11:43:20 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: ti-tfp410: switch to using
 fwnode_gpiod_get_index()
Message-ID: <20191014184320.GA161094@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of fwnode_get_named_gpiod() that I plan to hide away, let's use
the new fwnode_gpiod_get_index() that mimics gpiod_get_index(), but
works with arbitrary firmware node.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Andrzej, Neil,

This depends on the new code that can be bound in
ib-fwnode-gpiod-get-index immutable branch of Linus' Walleij tree:

        git pull git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git ib-fwnode-gpiod-get-index

I hope that it would be possible to pull in this immutable branch and
not wait until after 5.5 merge window, or, alternatively, merge through
Linus Walleij's tree.

Thanks!

 drivers/gpu/drm/bridge/ti-tfp410.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index aa3198dc9903..6f6d6d1e60ae 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -285,8 +285,8 @@ static int tfp410_get_connector_properties(struct tfp410 *dvi)
 	else
 		dvi->connector_type = DRM_MODE_CONNECTOR_DVID;
 
-	dvi->hpd = fwnode_get_named_gpiod(&connector_node->fwnode,
-					"hpd-gpios", 0, GPIOD_IN, "hpd");
+	dvi->hpd = fwnode_gpiod_get_index(&connector_node->fwnode,
+					  "hpd", 0, GPIOD_IN, "hpd");
 	if (IS_ERR(dvi->hpd)) {
 		ret = PTR_ERR(dvi->hpd);
 		dvi->hpd = NULL;
-- 
2.23.0.700.g56cf767bdb-goog


-- 
Dmitry
