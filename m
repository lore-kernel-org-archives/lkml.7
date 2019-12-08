Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FB2C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 17:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6A320409
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 17:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ntEJWwp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfLHRTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 12:19:02 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34368 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfLHRTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 12:19:01 -0500
Received: by mail-wm1-f67.google.com with SMTP id f4so13643295wmj.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 09:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gu+8XaIloextUHW957Mh8GSvlNfk6Ho+2WvTpE6YLbI=;
        b=ntEJWwp25ChtTEmus7kaTseWRnnt4433csuQqPdH/cYACBb1MO4xJwO6wWHQSbA1zX
         fnvaiAiCgGo6ynY4RRumZL14YYOP3zCqSF4rsoFfG1tolFIeD7zxZmUrSvCozM1FYu24
         W6dBfwOmS1aJ9rdS0GUPN8FNgBc0R8OOKA60VHUzqem2s824NyrULJx866i9Ki4Qc/sr
         UtmZIGkGJvCe7lkSG7zeMxMcAEaaksaFIAjCP9+FuItI1MzF1rF3XUfTuG4dUaYTGTOl
         8BvS68O2VO0h1jM4/ypFZCnn/tkW44q/aSUi/ciFzL8FS7nu1DEJBpchEeiwDIRmeVI4
         q5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gu+8XaIloextUHW957Mh8GSvlNfk6Ho+2WvTpE6YLbI=;
        b=MjRpnCePO7ee7d92y2lJaz2UXm4FlB77QppRxu0SmJJvdl9xZnujZ+eOWA1N7ZTr48
         p3dIAYPHJFAOl+wawYiqW3zFyUfzAR9yEqFRvU1TaDGWJl8SNG6+vugDAR2jS/muOnx3
         0FZ9mqdYNTaXnXAT2wP2fOksb/IBCpCGLArDJxK+diOmzBndLipk2OsiSySPFoTelfCY
         TWS7Oh1f7SuYvbSu5GsLLQ76PRI0YaaxiWj8kF4M2vIQS0PCApLxn0twhJMRkZ6pe5mc
         Wj6tOjdRalzSJdppvUTCJqGRV/GYrBqF5VJn+wf6CeQSZcQyBVXZzQaHoeylDiLxNagZ
         0yLQ==
X-Gm-Message-State: APjAAAXy6qLp1Naqx7+cpzO8ecrlNeRSYcsRk6CdEt+EH+bkdAzNfQ5Y
        Wk5GqlCzMHQXAtLBunCYzeXZbL/K
X-Google-Smtp-Source: APXvYqwl5vSlTNtHmhBHy96IhpgjESZ2vDOODYVSQ2Xh9Rx4mQ3d3VrOlJuOKtGiQrnauWl4d2kqKA==
X-Received: by 2002:a7b:c0d8:: with SMTP id s24mr21854540wmh.30.1575825539428;
        Sun, 08 Dec 2019 09:18:59 -0800 (PST)
Received: from localhost.localdomain (p200300F1371AD700428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:371a:d700:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id g25sm11791383wmh.3.2019.12.08.09.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2019 09:18:58 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, narmstrong@baylibre.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, daniel@ffwll.ch,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/2] Meson VPU: fix CVBS output
Date:   Sun,  8 Dec 2019 18:18:30 +0100
Message-Id: <20191208171832.1064772-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of this series is to fix the CVBS output with the Meson VPU
driver. Prior to this series kmscube reported:
  failed to set mode: Invalid argument

Changes since v1 at [0]:
- add patch to remove duplicate code (to match patch #2 easier)
- use drm_mode_match without DRM_MODE_MATCH_ASPECT_RATIO as suggested
  by Neil


[0] https://patchwork.kernel.org/patch/11268161/


Martin Blumenstingl (2):
  drm: meson: venc: cvbs: deduplicate the meson_cvbs_mode lookup code
  drm: meson: venc: cvbs: fix CVBS mode matching

 drivers/gpu/drm/meson/meson_venc_cvbs.c | 48 ++++++++++++++-----------
 1 file changed, 27 insertions(+), 21 deletions(-)

-- 
2.24.0

