Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598E9CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2068020679
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYmllqNN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfJ0Vxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:53:41 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36059 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbfJ0Vxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:53:41 -0400
Received: by mail-io1-f65.google.com with SMTP id c16so8490231ioc.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 14:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CCZl0j1P1FyTjIpTDRJfaJQYXzqQniNrCSsMSJER5FE=;
        b=hYmllqNNLIaHWyfzEhzbgV41fN6DR4+U1k3TUA8UD/BT4nz/7KR0ZyVtq8sUS9T5wk
         bLFsQMrd5ii67uAp22grpEvPHmldksyk9foPhnfAZsSDBRm5CCsZDcSgoCh3E3fU1kg1
         nvpMNxIL7IRDaNHOVsXf03TRrAQ/L3larGXZLsnb/3U8PTR732e1dUia+ImSqrDjKRz0
         yMKXpkv7a0ocLAumQDPFlx2JGwJ0hy966ZusA/a2/LGUzs0kh8ggiG55BLesTCumL2rT
         PHU4X6WjyZsE90RRq4RdP1CHL/Bp5WF1RY3VR3gSN1KeqJvklgOOIyBM4ZfCxJQdlNNq
         lr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CCZl0j1P1FyTjIpTDRJfaJQYXzqQniNrCSsMSJER5FE=;
        b=rllol094mbLY3z7RYVyEgg4nQ4uOKdAfub5oE0xPZEtNC8GfBTLLer7rBujaW6V3GC
         P57O7CFk+WW8DkUiO40lFlkIZp8Y9U3qlvwu5pH0Tw6oQgMudedTYwAViIKsU04EdD3e
         op9INiQ5COgnb7blZ69fH2qKypOjin8Ol7JVbcIb0Jp0NxBsiJadJiyxBHduf3da5Dza
         rO4HyEw1ERWTRxuM69nPmjpKXEH6xXbmaEomQ2MNvXT8HM5La23/AclsvM/1Ca839axT
         j0zcoqn/eMd0qN7LQiXvlaKFKDKZBoHzdnA5TzQitjTVqffn0jCwKQl7myx4CJ/z8Alb
         Eifg==
X-Gm-Message-State: APjAAAVYkNiayoESrMR/EzFUGT5dwMeezwYCosqpJ7/Z800nw+1c17CV
        1Vb2hKKndk+tUO0ceBZuM1Q=
X-Google-Smtp-Source: APXvYqx0XI3ng3sOrKsNNVRkOoLbKi3BQ92jxGPmPUezDvyxLx62hpOCJ8W8vjpQY4WRYfopUQUaYA==
X-Received: by 2002:a02:19c1:: with SMTP id b184mr14699631jab.54.1572213219249;
        Sun, 27 Oct 2019 14:53:39 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id d17sm948686ioe.31.2019.10.27.14.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 14:53:38 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pan Xiuli <xiuli.pan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Slawomir Blauciak <slawomir.blauciak@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: SOF: ipc: Fix memory leak in sof_set_get_large_ctrl_data
Date:   Sun, 27 Oct 2019 16:53:24 -0500
Message-Id: <20191027215330.12729-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of sof_set_get_large_ctrl_data() there is a memory
leak in case an error. Release partdata if sof_get_ctrl_copy_params()
fails.

Fixes: 54d198d5019d ("ASoC: SOF: Propagate sof_get_ctrl_copy_params() error properly")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 sound/soc/sof/ipc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc.c b/sound/soc/sof/ipc.c
index b2f359d2f7e5..086eeeab8679 100644
--- a/sound/soc/sof/ipc.c
+++ b/sound/soc/sof/ipc.c
@@ -572,8 +572,10 @@ static int sof_set_get_large_ctrl_data(struct snd_sof_dev *sdev,
 	else
 		err = sof_get_ctrl_copy_params(cdata->type, partdata, cdata,
 					       sparams);
-	if (err < 0)
+	if (err < 0) {
+		kfree(partdata);
 		return err;
+	}
 
 	msg_bytes = sparams->msg_bytes;
 	pl_size = sparams->pl_size;
-- 
2.17.1

