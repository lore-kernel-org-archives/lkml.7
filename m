Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DBBC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 04:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9D921E6F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 04:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVgKQ7C0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411687AbfIYEYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 00:24:21 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44505 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392142AbfIYEYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 00:24:21 -0400
Received: by mail-io1-f65.google.com with SMTP id j4so10099710iog.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 21:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MS2fxSO5B4fdSwTSr588JEm97CHbkHnZPXYIa8kugGg=;
        b=MVgKQ7C0XNYOr+wZQ7k0LZDFFkkfMarqBz67S1MUs1pNITYkcaGTG+R6ELtapPUAsH
         h8RkjQkLp5vca+bpvQGYkPVfrlMqMjrguUMBoMlhYmV+hjreJhY9Zl5kuVMICZwvka4A
         ppbdTu1xJNUpA2lZQa6N4k7h5+a+5QazXKuGx0zIPCtcLb5myxiBt2X1Fgo6Nnv2iZJ1
         hzSVi6+h2FmPUMyE+ffZNnHEJ0UtPw9wa54tygJOopMCqDy8Sf5vufMNOQ4RW2Sp1xjC
         NUlF4Tsg+Ud4bq/yim6m675DEibvGPgFjVXSUJa2q3BN2b1EnA/OtWIVNKexac2kA2s2
         6QoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MS2fxSO5B4fdSwTSr588JEm97CHbkHnZPXYIa8kugGg=;
        b=EQjI71Y9KZb+5o8gwUX7qE/a1QeYSguOKkEYDuRzLUtv2b1MP7OWY90giHUOFqCwSN
         juFHPnLc1yITDku3CcYDWfLngxODUgiy9ktWSYxJ43oed4LLx0Q+N0mlKPfGWnyn5dee
         bQynakeCAkAsJgLgmh8q8nGibctauLXQ0ZwUpI0olwEp3Ud6FAEasXMXtslZnKIjaAwJ
         2vtcbgEQhDv6SdEYHIG/UFfufiiVe+K1GBuWBqTd6IztgdMDiGzvZVuExhH02TTAUTf6
         X+cv0vuMhsUXpKQE9ZwS95qvRtd76hneqm4HEoHImSekOnpjo4lip3bnf8yBXiSMzw9e
         dQ7w==
X-Gm-Message-State: APjAAAVNANWI0ot/ucC51n1q54TMWWz5EptaHWFVEFPqw80mX15csSCH
        Uu8TVFs5prnbm2SvrrzJfcFOubuhFRU=
X-Google-Smtp-Source: APXvYqzndtOTM69mP51f/SoXtLy/fJyC/cIcsyLkt0PidJyn5iMPKKB+A8DdYyC3O8hIk4pqT4OWiA==
X-Received: by 2002:a6b:6110:: with SMTP id v16mr8052275iob.199.1569385458891;
        Tue, 24 Sep 2019 21:24:18 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id r12sm33707ilq.70.2019.09.24.21.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 21:24:18 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Eric Yang <Eric.Yang2@amd.com>, Jun Lei <Jun.Lei@amd.com>,
        Wesley Chalmers <Wesley.Chalmers@amd.com>,
        David Francis <David.Francis@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Aidan Wood <Aidan.Wood@amd.com>,
        Ken Chalmers <ken.chalmers@amd.com>,
        Eric Bernstein <Eric.Bernstein@amd.com>,
        hersen wu <hersenxs.wu@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>, Roman Li <Roman.Li@amd.com>,
        Wang Hai <wanghai26@huawei.com>,
        Thomas Lim <Thomas.Lim@amd.com>,
        Su Sung Chung <Su.Chung@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: prevent memory leak
Date:   Tue, 24 Sep 2019 23:23:56 -0500
Message-Id: <20190925042407.31383-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dcn*_create_resource_pool the allocated memory should be released if
construct pool fails.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c   | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
index afc61055eca1..1787b9bf800a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
@@ -1091,6 +1091,7 @@ struct resource_pool *dce100_create_resource_pool(
 	if (construct(num_virtual_links, dc, pool))
 		return &pool->base;
 
+	kfree(pool);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
index c66fe170e1e8..318e9c2e2ca8 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
@@ -1462,6 +1462,7 @@ struct resource_pool *dce110_create_resource_pool(
 	if (construct(num_virtual_links, dc, pool, asic_id))
 		return &pool->base;
 
+	kfree(pool);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index 3ac4c7e73050..3199d493d13b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -1338,6 +1338,7 @@ struct resource_pool *dce112_create_resource_pool(
 	if (construct(num_virtual_links, dc, pool))
 		return &pool->base;
 
+	kfree(pool);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
index 7d08154e9662..bb497f43f6eb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
@@ -1203,6 +1203,7 @@ struct resource_pool *dce120_create_resource_pool(
 	if (construct(num_virtual_links, dc, pool))
 		return &pool->base;
 
+	kfree(pool);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 5a89e462e7cc..59305e411a66 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -1570,6 +1570,7 @@ struct resource_pool *dcn10_create_resource_pool(
 	if (construct(init_data->num_virtual_links, dc, pool))
 		return &pool->base;
 
+	kfree(pool);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
-- 
2.17.1

