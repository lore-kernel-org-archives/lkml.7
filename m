Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00559C49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 03:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAEC820665
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 03:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+yWSNJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392201AbfIQDVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 23:21:43 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42473 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfIQDVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 23:21:42 -0400
Received: by mail-io1-f67.google.com with SMTP id n197so4055132iod.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 20:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uMCwEHQvtNjk+/l7SPshcA4CM/OKg67DuvF3ouBwv+s=;
        b=i+yWSNJc3bZlvKnVhSjjMRCBCwtmu5ooFGKZkGLKMAjHkZ7wqLgf5B1Ge8VWsOMQ9D
         0ZMxcBL3/Bw+tbjePdVCiMNDzLZHb8OHz3KHL3rFah0+a7jG+3jHM2w1M7QldzzrKWlA
         AOuDVcblakTGqdGh8O7qeTty9pg7dh6lCZFFQ7+qa3Zfo/sMsFoOLD7/RnmqQceRlD7A
         9Js0M9EBevwVt+gWJWV4Gv3MpUwABCxFFkqCEi/S5fHiitflplxWobhvKnBCJqFJVOvj
         Rgl0PSBqUMSwjqhK+gmIrrFp1lJQJyMDWK1p9Ind6kM83mnW5SatKmWATZfrs7p5Qk2A
         Sc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uMCwEHQvtNjk+/l7SPshcA4CM/OKg67DuvF3ouBwv+s=;
        b=bBvdDCz7oHXsR7YnK6pGKZs2o2VRtgDOzEkRrz/bvOz3tFFyvFG2XrocLOfov9tH6n
         HOGGLg4G2ARpQu/QDSQGFbw80YImedAmUtgoass8V370mG6OaAtOKhVOU6dJp776WLa8
         /4Xh7bHk2Ymu+el7p46eGbiecACu91Q1HIaBWAn/jtqRfVCsPiULBoRxxSgt4/l/yCDZ
         0dnP6s3Yg9GvEJDJJ5Ek/ut9EkXnx5u45EpKUSZnQiuJLyu8CFtR40Qp+iXZy33js15n
         Ltvz0xsciRX0Wxn0KjXxI9aU9onzpJ3l78UlCKISLSBUsxR7utQysukFpoin1dtr9AK0
         EZiw==
X-Gm-Message-State: APjAAAXUkGtCw+oOmbyg9Lqp7ql8xTU/TsIg2ASeMRr0wPBIEY9ZQfRJ
        kIkzo7qLcCjwC60KayUnpxA=
X-Google-Smtp-Source: APXvYqwUAbHzObmxlcKTs7Sr7rY0DuCnBsDeDL5086A+CmYlktYdRFHclzi8wQ5tlTQQ0uKm5fZfWw==
X-Received: by 2002:a6b:9109:: with SMTP id t9mr1456924iod.16.1568690500448;
        Mon, 16 Sep 2019 20:21:40 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id c25sm651242iod.47.2019.09.16.20.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 20:21:39 -0700 (PDT)
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
        David Francis <David.Francis@amd.com>,
        Wesley Chalmers <Wesley.Chalmers@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Aidan Wood <Aidan.Wood@amd.com>,
        Ken Chalmers <ken.chalmers@amd.com>,
        Eric Bernstein <Eric.Bernstein@amd.com>,
        Roman Li <Roman.Li@amd.com>, Wang Hai <wanghai26@huawei.com>,
        Thomas Lim <Thomas.Lim@amd.com>,
        Su Sung Chung <Su.Chung@amd.com>,
        hersen wu <hersenxs.wu@amd.com>,
        Nikola Cornij <nikola.cornij@amd.com>,
        Charlene Liu <Charlene.Liu@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: memory leak
Date:   Mon, 16 Sep 2019 22:20:44 -0500
Message-Id: <20190917032106.32342-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dcn*_clock_source_create when dcn20_clk_src_construct fails allocated
clk_src needs release.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c   | 1 +
 7 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
index 6248c8455314..21de230b303a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
@@ -667,7 +667,8 @@ struct clock_source *dce100_clock_source_create(
 		clk_src->base.dp_clk_src = dp_clk_src;
 		return &clk_src->base;
 	}
-
+
+	kfree(clk_src);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
index 764329264c3b..0cb83b0e0e1e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
@@ -714,6 +714,7 @@ struct clock_source *dce110_clock_source_create(
 		return &clk_src->base;
 	}
 
+	kfree(clk_src);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index c6136e0ed1a4..147d77173e2b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -687,6 +687,7 @@ struct clock_source *dce112_clock_source_create(
 		return &clk_src->base;
 	}
 
+	kfree(clk_src);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
index 4a6ba3173a5a..0b5eeff17d00 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
@@ -500,6 +500,7 @@ static struct clock_source *dce120_clock_source_create(
 		return &clk_src->base;
 	}
 
+	kfree(clk_src);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
index 860a524ebcfa..952440893fbb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
@@ -701,6 +701,7 @@ struct clock_source *dce80_clock_source_create(
 		return &clk_src->base;
 	}
 
+	kfree(clk_src);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index a12530a3ab9c..3f25e8da5396 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -786,6 +786,7 @@ struct clock_source *dcn10_clock_source_create(
 		return &clk_src->base;
 	}
 
+	kfree(clk_src);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index b949e202d6cb..418fdcf1f492 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -955,6 +955,7 @@ struct clock_source *dcn20_clock_source_create(
 		return &clk_src->base;
 	}
 
+	kfree(clk_src)
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
-- 
2.17.1

