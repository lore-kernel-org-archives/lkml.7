Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FD3CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B161208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIvX0idW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403947AbfJ1Q6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:58:42 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:35349 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfJ1Q6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:58:41 -0400
Received: by mail-il1-f195.google.com with SMTP id p8so8819471ilp.2;
        Mon, 28 Oct 2019 09:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VsYOYw/63XAVKPUsYisyXnfblClorjAawHJi/it0oEA=;
        b=OIvX0idWV6esLVnTUjwsh8UX0Y3MegoKcCrUD36IazFKX/z4o4uXg0RgARV00n2l9A
         IsJFqlj41Kkp+0TO1kGJBeTa93xlWKkBk2sUsCbSx9I0xYqM23tRWBEsXzZbI9B1KdIm
         gJK5ScQ+N5hznm3+xbFwlmmllQeuPSzoTwLC2MBXy9aVrEduAt+jm+bZdVrIkQYQdipw
         eh4+A+1UszCvXqa5t2qNh0QPHipSR5BsWKa/AVAeWpl7mKf3On3n8D2TjXOvoQWqukRD
         E99/TWyhTaurLqz0QfX0oAbXkzqkEDrmroVb2688sx/hKI4ycpfahn2P7K/IBPjUdnSH
         A+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VsYOYw/63XAVKPUsYisyXnfblClorjAawHJi/it0oEA=;
        b=U56Qpt7i7qeOISd+p2YS69CNVQYCA2dUBs6Hz+zgSIuNDSEOe7pPcjPkE/OxsjBcZ0
         GGDsuIdVs87AADqpDMpPIWzMFCrRL5eQ8xBIYo/mTk//uTgBVwz+oGFjTnwXjYoAL9B/
         JR7giJWYVGwtvqZmFFs9nPUbAieJHt7Vfz/hRd8c56VWBdG7bTtBj992b9wKgBYbsgQJ
         qn3JgiYMunWRRlDBS9faljabIAhZhO0lEDjqmQ4U1jzaVsEC9XWZfxPoCQmCm8pc+Bs8
         VPnfHUu2t+rJrWgSemMBxUvuxFvOx54vlQzbAkPGC2eguPwoRNi0ltwog+osmcTvrMP5
         K+3Q==
X-Gm-Message-State: APjAAAV57W+Ir4FnsCUjpj5sdxd9ooex/31AdiWTCnYGS1cP7ueWtQLn
        1L2AMmyY4QfG018y5ura7aU=
X-Google-Smtp-Source: APXvYqx2qXlEPCIiPVhl6XhY2JTF9eYwSmAPTLsncPs7iDDy0d9kOOdavwbVbzeSJzJSR1vraAyjIw==
X-Received: by 2002:a92:9a54:: with SMTP id t81mr22517749ili.197.1572281920640;
        Mon, 28 Oct 2019 09:58:40 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id l2sm597572ilc.34.2019.10.28.09.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 09:58:39 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     jae.hyun.yoo@linux.intel.com
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Eddie James <eajames@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-media@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] media: aspeed-video: Fix memory leaks in aspeed_video_probe
Date:   Mon, 28 Oct 2019 11:58:26 -0500
Message-Id: <20191028165827.24949-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <d9c04318-586a-bfc2-fce6-6218c6bab1d6@linux.intel.com>
References: <d9c04318-586a-bfc2-fce6-6218c6bab1d6@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of aspeed_video_probe() the allocated memory for
video should be released if either devm_ioremap_resource()
or aspeed_video_init() or aspeed_video_setup_video() fails. Replace
kzalloc() with devm_kzalloc to avoid explicit release for video.

Fixes: d2b4387f3bdf ("media: platform: Add Aspeed Video Engine driver")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
Changes in v2:
	-- replace kzalloc with devm_kzalloc based on Jae Hyun Yoo
suggestion

 drivers/media/platform/aspeed-video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index eb12f3793062..2aa8ea2f9824 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -1646,7 +1646,7 @@ static int aspeed_video_probe(struct platform_device *pdev)
 {
 	int rc;
 	struct resource *res;
-	struct aspeed_video *video = kzalloc(sizeof(*video), GFP_KERNEL);
+	struct aspeed_video *video = devm_kzalloc(sizeof(*video), GFP_KERNEL);
 
 	if (!video)
 		return -ENOMEM;
-- 
2.17.1

