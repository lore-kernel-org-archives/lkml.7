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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D638AC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC72D205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLk0Wv3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404593AbfGXT4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:56:06 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46717 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404576AbfGXTz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:55:59 -0400
Received: by mail-io1-f68.google.com with SMTP id i10so92135426iol.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 12:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Sco7/Mcnd83BlhtKzamoEr69UcyH5M4+yy+9bnNAKM=;
        b=KLk0Wv3SBFPzgoA1kbc2bJqn82kEu4H7BRBV9Q6nO9qDFvRPxVr9CjNrioVEjlpM1Y
         uhq9hWWPqIJ/0sgyTaZ9penAhEgps3wdnKRzoqnlM3l/vpG/K8qQMFs5yCEtPoqbYfLu
         GZxoYREsayfQsYrPSLhKsLnzGJhdzY10XEpwMhGkIT5Tl6ip66gFt94Ajtoi/KxqVcxj
         pT6wUXzjSPSEW3Ppr1EY5vH0r8G/DywVyEBvocKdFIiD6eU16sc4zfMedqFfflmRxSIm
         A9JylbVbRdpg5Sxz1SxweranVQqx0B+l9w+16SZso94edNwK4d/sY7DmKXja4FC3HpxF
         Xrlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1Sco7/Mcnd83BlhtKzamoEr69UcyH5M4+yy+9bnNAKM=;
        b=XUpVe1nxuGTF+lXKKwfKtrNf5RH77Es0xhROQF8NvzhXTJ6fhlbfRe3kNxh1u16uvr
         MvqExO6PCZEkbeG5miv2Sung/ZtIKpgzToiu3fj1/gLxi5Xgw/O3Zlo5Ks4PvjGatD55
         uUBQb1GI+lF9c9JFUiOJhMDkss87MaY818IlVVWsFyBtJOzkHUjg0BR1yBadC8UL8KYl
         L7SYU3dyShlWKbDb+RPU5UCM1VuLwYMlW6Cgltyt0jYqwOyQNoC7CoaoVPLJC8rsqWOT
         WiOxri99x2FI/nbwcmUG9CZk1GYpsgUmmDcH2CBxHRnWai2aY0QLLDOFJp7COk+8Nvlk
         iY5g==
X-Gm-Message-State: APjAAAWUUU6O5BmWB2iALM3XP9hP1ukj1sv07RDvmPQkOEDUDa8cmwTR
        mp3WdsHxjBIrjqB6rOPYgMur1bygpVA=
X-Google-Smtp-Source: APXvYqy2v8zWsqu7uQpMunLNvmoxDbBoaEGUJMoqEkxgsFog2kX+6hzkt9Mg9AnrgdQTxLQiErz9gw==
X-Received: by 2002:a6b:f203:: with SMTP id q3mr29645158ioh.208.1563998158160;
        Wed, 24 Jul 2019 12:55:58 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id l14sm42949340iob.1.2019.07.24.12.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 12:55:57 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     sam@ravnborg.org
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        secalert@redhat.com, Navid Emamdoost <navid.emamdoost@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/panel: check failure cases in the probe func
Date:   Wed, 24 Jul 2019 14:55:34 -0500
Message-Id: <20190724195534.9303-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190724185933.GE22640@ravnborg.org>
References: <20190724185933.GE22640@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following function calls may fail and return NULL, so the null check
is added.
of_graph_get_next_endpoint
of_graph_get_remote_port_parent
of_graph_get_remote_port

Update: Thanks to Sam Ravnborg, for suggession on the use of goto to avoid
leaking endpoint.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 .../gpu/drm/panel/panel-raspberrypi-touchscreen.c   | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
index 28c0620dfe0f..b5b14aa059ea 100644
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
+		goto error;
+
 	host = of_find_mipi_dsi_host_by_node(dsi_host_node);
 	of_node_put(dsi_host_node);
 	if (!host) {
@@ -408,6 +414,9 @@ static int rpi_touchscreen_probe(struct i2c_client *i2c,
 	}
 
 	info.node = of_graph_get_remote_port(endpoint);
+	if (!info.node)
+		goto error;
+
 	of_node_put(endpoint);
 
 	ts->dsi = mipi_dsi_device_register_full(host, &info);
@@ -428,6 +437,10 @@ static int rpi_touchscreen_probe(struct i2c_client *i2c,
 		return ret;
 
 	return 0;
+
+error:
+	of_node_put(endpoint);
+	return -ENODEV;
 }
 
 static int rpi_touchscreen_remove(struct i2c_client *i2c)
-- 
2.17.1

