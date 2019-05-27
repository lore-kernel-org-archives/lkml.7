Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FC9C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 04:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DB52075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 04:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SEIZZEXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfE0Ev0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 00:51:26 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:38253 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfE0Ev0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 00:51:26 -0400
Received: by mail-pg1-f174.google.com with SMTP id v11so8382480pgl.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 21:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+pghJ3QtYkbMJ3TCzTPXHLJ/5p1F8C3Os/Bvo/JdKfg=;
        b=SEIZZEXrBAFGXzBgVAyoamK5sJIK5UZGppPItkKO+xGbuTud9szjLsxir/q5ZtHRrY
         A6F0w/RQHS5wiv/Nho1yKYDHxKHYaA5JpGEmYIpfAcbYpjfIzRVJNrpN6iaLC2IHuAsV
         aCbVQcAzDSmQyKMwyqZftwxAW5d/ld3/Cj9C4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+pghJ3QtYkbMJ3TCzTPXHLJ/5p1F8C3Os/Bvo/JdKfg=;
        b=mHXAFDwLp/El/tcjBbfk2wlnxPWlMBYgy7rk4YcF7MLG9/Xqh1jrbfRreHBzIZUKPi
         hnV3lasxh+p2BGKbnz49RMtR3U6izE18mzk68DW5t1FWc4bXwxO8s8JbpGV+THkOmgF4
         SAH+dvTdHWMgkUuvfA13jSPYo7URWHusabEFXoYkjx7ug8OM8sWgYXMBe/cm9pqb4tcK
         PRlqe6fE4BqWEC2iMGcHs4P724IzFxA/NGGla5HCxK9YU34ambOSIvEgTEe0CwlomOUK
         rZr3cIxACebG+CiALVFW/fo5+aBolqbvz7XJj7JSKMkp+QFtqaQzJg/gv19E/7GajO3+
         N2gw==
X-Gm-Message-State: APjAAAU6maDbOUOzeQtUAh0w6yn7fzHF/K+zqSUczfyiODEXb+BFz9BP
        X9tBV4pRLLK/9emBMGzRdR8seA==
X-Google-Smtp-Source: APXvYqwh/5/rhXpwbURGFIHVfZLO0fYXK7K8Mlv98GJtnZi4raWyoWkb3AtxYitbz76kcJUga2aqBw==
X-Received: by 2002:a17:90a:2e89:: with SMTP id r9mr28510768pjd.117.1558932685483;
        Sun, 26 May 2019 21:51:25 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id t18sm8082745pgm.69.2019.05.26.21.51.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 May 2019 21:51:25 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] fix mediatek drm, dis, and disp-* unbind/bind
Date:   Mon, 27 May 2019 12:50:51 +0800
Message-Id: <20190527045054.113259-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some errors when unbinding and rebinding mediatek drm, dsi,
and disp-* drivers. This series is to fix those errors and warnings.

Hsin-Yi Wang (3):
  drm: mediatek: fix unbind functions
  drm: mediatek: remove clk_unprepare() in mtk_drm_crtc_destroy()
  drm: mediatek: unbind components in mtk_drm_unbind()

 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 4 ----
 drivers/gpu/drm/mediatek/mtk_drm_drv.c  | 8 +++-----
 drivers/gpu/drm/mediatek/mtk_dsi.c      | 4 +++-
 3 files changed, 6 insertions(+), 10 deletions(-)

-- 
2.20.1

