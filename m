Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F23DC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BB921971
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569343586;
	bh=qqZxm8KNU3bkkqJKEYWUqs8sTqIDkTaNn9u3huRE85Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EPYpmb9pbYAR6Fv4ArxROGczW6+m3tF306A/t1ZI9P14AtNoWIfwsfTJCq5NdN+3M
	 wiXy5BPgDALpCVC260jPEslyHJeVtGdXimYTyBSIHfIgZia2/ZMVjlNL2sZslMCFoo
	 2hGmNCQqz7WcwTZ5NTuaGfpk3+7JNJF6lfZaIaG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410108AbfIXQqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:46:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbfIXQqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:46:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5366F21841;
        Tue, 24 Sep 2019 16:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343573;
        bh=qqZxm8KNU3bkkqJKEYWUqs8sTqIDkTaNn9u3huRE85Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bUsQk9/UfwheQ33KEy2tM3Vbh0YYoVHvndjrxdWjQP4q66Edowx9zKqgk9WZyu3t7
         8phfaoR4mUrGDUG+zCFxFC5MdTWBtmgdsi37RYqCkZBgt1WY3jXHAghUhCux9G/Jf5
         x6VJRc+bkBbut8kGg/Gz7pxY6tBZPLHpkbncORG8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.2 11/70] drm/panel: check failure cases in the probe func
Date:   Tue, 24 Sep 2019 12:44:50 -0400
Message-Id: <20190924164549.27058-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924164549.27058-1-sashal@kernel.org>
References: <20190924164549.27058-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit afd6d4f5a52c16e1483328ac074abb1cde92c29f ]

The following function calls may fail and return NULL, so the null check
is added.
of_graph_get_next_endpoint
of_graph_get_remote_port_parent
of_graph_get_remote_port

Update: Thanks to Sam Ravnborg, for suggession on the use of goto to avoid
leaking endpoint.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20190724195534.9303-1-navid.emamdoost@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/panel/panel-raspberrypi-touchscreen.c   | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
index 2c9c9722734f5..9a2cb8aeab3a4 100644
--- a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
+++ b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
@@ -400,7 +400,13 @@ static int rpi_touchscreen_probe(struct i2c_client *i2c,
 
 	/* Look up the DSI host.  It needs to probe before we do. */
 	endpoint = of_graph_get_next_endpoint(dev->of_node, NULL);
+	if (!endpoint)
+		return -ENODEV;
+
 	dsi_host_node = of_graph_get_remote_port_parent(endpoint);
+	if (!dsi_host_node)
+		goto error;
+
 	host = of_find_mipi_dsi_host_by_node(dsi_host_node);
 	of_node_put(dsi_host_node);
 	if (!host) {
@@ -409,6 +415,9 @@ static int rpi_touchscreen_probe(struct i2c_client *i2c,
 	}
 
 	info.node = of_graph_get_remote_port(endpoint);
+	if (!info.node)
+		goto error;
+
 	of_node_put(endpoint);
 
 	ts->dsi = mipi_dsi_device_register_full(host, &info);
@@ -429,6 +438,10 @@ static int rpi_touchscreen_probe(struct i2c_client *i2c,
 		return ret;
 
 	return 0;
+
+error:
+	of_node_put(endpoint);
+	return -ENODEV;
 }
 
 static int rpi_touchscreen_remove(struct i2c_client *i2c)
-- 
2.20.1

