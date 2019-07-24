Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190D9C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBAF21850
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccqbYRrV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbfGXOsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:48:55 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41156 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfGXOsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:48:55 -0400
Received: by mail-io1-f68.google.com with SMTP id j5so85989793ioj.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 07:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HwPqXIBxuHIER7tZJnlecipE0woOms8twNHrVL6AxIQ=;
        b=ccqbYRrVXkWfyYKmh7Upb9MbsCYPBan3zydRkRaUhEuI5q6tIR1OzPPTtiWL1m/Sk6
         VVlxwoUUxsSWzk7Ocec0lrH4P+knZmoHlZ28dnYxtdP6208JaloU2ZgabooDnZc++gUq
         mKQ2OOVqz4iwFU7dOb6lfzOFILxwYUIYjrsmdGb3xl2ZNtkglK9bXsqZdbr///lbzOnY
         5ieqzTE6od5Wha1JVuKZL42DmPA1XuEUe7bzOYdEiPNhTSml/7UmuqVSLYFK4vt3V3wy
         tD/Cr7ZXVjLRxzIpELo3KZHP576woP4R/lg5T2yMv6VA5ZJAJ25HeBzdn2jkPEfsWpzF
         mkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HwPqXIBxuHIER7tZJnlecipE0woOms8twNHrVL6AxIQ=;
        b=FUCqFdMnB4mpOSNnoKH+PfdsxkXMSGfhbvBEHdMVezplTKmdgPh792R7XxE2T7rPnA
         f9ITO9ITIiROhVGVyoSawNu/yld2drMNKnIkG79I1RuZ1lF4jahoaaTdstYkG48g8K60
         iUe/xulh69dFboY8X3OPJ7J7H2+niDTZIs+wIEBMFdJYBY96y3Ly6UBOtt0eILFbxHsK
         B8duiNH8xkKsON/F204NgovIGpYZKdx4bQEBDM9vk8jRWxKiAuZhQTzwXrjv4zHkReeP
         lrR89RwblIbYO6ztn+0riOofr4oZq2zibV55MmMEIinHWqepAaU14m/2P5UQzykjUBgK
         fPXw==
X-Gm-Message-State: APjAAAUN828X4b693MjP4ECgsw/JzrhA6Wzs1yMEF+NxJlH4+KGSXrbA
        8pdQQVlrEO17KuNE/9MHFG8=
X-Google-Smtp-Source: APXvYqybxf0p/pRKzwGgO28J2Y6iMki/RDBF//ojjPz80URKoUjc81TTfDxmFdfx6YAwy9bj8g8P4Q==
X-Received: by 2002:a5e:a712:: with SMTP id b18mr75486828iod.220.1563979734599;
        Wed, 24 Jul 2019 07:48:54 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id e26sm39596961iod.10.2019.07.24.07.48.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 07:48:54 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     sam@ravnborg.org
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        secalert@redhat.com, Navid Emamdoost <navid.emamdoost@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel: check failure cases in the probe func
Date:   Wed, 24 Jul 2019 09:48:44 -0500
Message-Id: <20190724144845.4791-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190724051700.GA22730@ravnborg.org>
References: <20190724051700.GA22730@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following function calls may fail and return NULL, so the null check
is added.
of_graph_get_next_endpoint
of_graph_get_remote_port_parent
of_graph_get_remote_port

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
index 28c0620dfe0f..9484fdb60f68 100644
--- a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
+++ b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
@@ -399,7 +399,13 @@ static int rpi_touchscreen_probe(struct i2c_client *i2c,
 
 	/* Look up the DSI host.  It needs to probe before we do. */
 	endpoint = of_graph_get_next_endpoint(dev->of_node, NULL);
+	if (!endpoint)
+		return -ENODEV;
+
 	dsi_host_node = of_graph_get_remote_port_parent(endpoint);
+	if (!dsi_host_node)
+		return -ENODEV;
+
 	host = of_find_mipi_dsi_host_by_node(dsi_host_node);
 	of_node_put(dsi_host_node);
 	if (!host) {
@@ -408,6 +414,9 @@ static int rpi_touchscreen_probe(struct i2c_client *i2c,
 	}
 
 	info.node = of_graph_get_remote_port(endpoint);
+	if (!info.node)
+		return -ENODEV;
+
 	of_node_put(endpoint);
 
 	ts->dsi = mipi_dsi_device_register_full(host, &info);
-- 
2.17.1

