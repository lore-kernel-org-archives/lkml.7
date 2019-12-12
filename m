Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9518BC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607E620663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vCnXBu3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbfLLKEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:04:09 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33619 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfLLKEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:04:09 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so909813pgk.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 02:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3U83CIcKE/SRi+DvpZ5ExDXp0Aib42JfoWBjJw1CdoY=;
        b=vCnXBu3dpOEsSlMFDA3zopAhw0OK6/iX56Ggf6RICdFnChUXqTdPp0GZCB4crBjViQ
         xKQ9GC1t7Y8tKnAO98HbiNn5bf6rIOwJ0l1LHdlcyb8ONbACAdWkLsC+ghq+Dj2jGZwd
         BkP0a4P8kPPU4krEASG4catRFWcTU08fwZNL9Bjgzf6Vj7Ub5TByUy/bQdHpZaVjkaKe
         sMMfF0UTefMT4+1PyL7u82VY+8jnow6fl4iuqM8eLhAGQT/XsGort5OHykOiQ/PyEGcD
         yOsJAT3lImH6GdddbI3mefW2LVJtpbTTxw+UMf0PKYBI3tvo85StBCS8/gMchZ4gSlqt
         Mp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3U83CIcKE/SRi+DvpZ5ExDXp0Aib42JfoWBjJw1CdoY=;
        b=gQ1Y0772c9ZX+wv/kIy4FVdqnRvY8le/czxqrm0FTWfHgIbBpbCD+t5YeRgX3pbApx
         q8sry/9ClJix7kYD2GYv9ZJGNp8wX+lqHzF3aE3Uk2JjF3+rdw632g1wjK+vV7xW8yfD
         XhvKxuqBY08GdZYeofyFjqRdlO30WQMZ7WtSlPMCKnydfn7NM3lzcLZWjWcK79k4igaG
         cmRvplf2F2hYY9pNjPRl3Ws51lJwOyE5T6TZ/0Fm/pm1RB0CHeIPDxTvsf9m2+WHNpTO
         hW2L8REqkrHQ9dJ5icBSdh4uGLlI18ebrq8EnMKf4oBCb/fqmgy05WBxd0VJYXE5L4oN
         cHLA==
X-Gm-Message-State: APjAAAWLKx+4SnFXiG/ip8czyhK0VtlZzkWEZBiFINTe6fpksXhELeRT
        AnHY14BRuMxpDe8groKz5si2S7r5
X-Google-Smtp-Source: APXvYqwJREwsRCqyKBWa0CL0bcmG/1cRF3jdvXmB1l6ty6DnFhtsoMoX233t/vjQlv3gcKFWcqzSpg==
X-Received: by 2002:a62:7590:: with SMTP id q138mr8630797pfc.241.1576145048455;
        Thu, 12 Dec 2019 02:04:08 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id g19sm6375868pfh.134.2019.12.12.02.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 02:04:07 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] drm/nouveau/dispnv50: add missed nv50_outp_release in nv50_msto_disable
Date:   Thu, 12 Dec 2019 18:03:56 +0800
Message-Id: <20191212100356.11309-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nv50_msto_disable() does not call nv50_outp_release() to match
nv50_outp_acquire() like other disable().
Add the missed call to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Fix the subject prefix.

 drivers/gpu/drm/nouveau/dispnv50/disp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 549486f1d937..84e1417355cc 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -862,8 +862,10 @@ nv50_msto_disable(struct drm_encoder *encoder)
 
 	mstm->outp->update(mstm->outp, msto->head->base.index, NULL, 0, 0);
 	mstm->modified = true;
-	if (!--mstm->links)
+	if (!--mstm->links) {
 		mstm->disabled = true;
+		nv50_outp_release(mstm->outp);
+	}
 	msto->disabled = true;
 }
 
-- 
2.24.0

