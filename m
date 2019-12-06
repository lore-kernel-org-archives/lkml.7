Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAD2C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 07:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF15D2467A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 07:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eB7FB8k+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfLFHxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 02:53:36 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46548 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfLFHxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 02:53:36 -0500
Received: by mail-pg1-f193.google.com with SMTP id z124so2876991pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 23:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1EgUIOkIOxBCz33igi7r1HkqftzoXNr9Kp6yceaT6vI=;
        b=eB7FB8k+B+Jl6hb20SCbjEVroUS2ALBqXwUYWIDq+UgAqGhSMBSbSJc2BiER4nOoNE
         guUipg59Ls0JVrUgsWuliKipQ926yRWNwqUxbU2GdCHCjooDIbIlRAAySNFr+qYlcMJS
         QgZ9QvtNVtTwunVr5KdSwT/Ym6AbVmnscDSM5ADRDN9vilTPiiI+SCUD2FZDDSGyYu4b
         1KpHP6HSc+yAK4YS+RDbTfWXjICkzDwiu5Bi3+da53j4WVZynKmebE/5LKexN45TEouE
         SRi2PNr9wVQa6RtFTIiwyoonPFolMStjJGOd3CfWWNyJ9wk6asTVFy2c921RWBa31K3/
         Sjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1EgUIOkIOxBCz33igi7r1HkqftzoXNr9Kp6yceaT6vI=;
        b=j9M1ZQbMxsdAvpOtJ1uavAP0lu3Wh9Bg4G2wr5YNYwWiI816H0ia8pfl+bHTSFas8p
         XVRBoumWaaJI5uo4QB6y7Zvfe5no+YuuCu9s2OOdUn7k6ae8LRGJl0xqhaqNDKLBLtkB
         aCzWrWXpQJYOm37g9t/nUfPLqsKYs4EWuGoL5Mh7E2qK5TYGXSwZSlxHl7Dw44pQEdfN
         FcGkTG02mLlHp5QoSKGqdceL+YlNZCyOLrxPN5nmpTO8LYNxFenzr3WEhChwgw9gFLFO
         21El6AyNiXS11G2z//I8Y5RQU3p06kdTwklWuRVdFIC82RYxdOX+U6iFAA4bvoQzecHY
         lZKw==
X-Gm-Message-State: APjAAAWhA9FqeY8MBff0zsU+RahvaQoLUCUZOmUmzr238pcZL8ycQPaM
        aqTEHDNXzWf92IfOpJuskxc=
X-Google-Smtp-Source: APXvYqywvw21DTGo7hukn/xRAaCsyHCskev0EPREMmv1UJqgV2f1YpgiSRlNmk6PjO5XpUVmgdnI3w==
X-Received: by 2002:a62:ed0b:: with SMTP id u11mr12890108pfh.46.1575618816036;
        Thu, 05 Dec 2019 23:53:36 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id b129sm14876391pfb.147.2019.12.05.23.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 23:53:35 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] drm/dp_mst: add missed nv50_outp_release in nv50_msto_disable
Date:   Fri,  6 Dec 2019 15:53:21 +0800
Message-Id: <20191206075321.18239-1-hslester96@gmail.com>
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

