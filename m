Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D46C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117E5206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Xam3wbBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfCKKvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 06:51:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45176 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfCKKvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 06:51:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id o7so4493457wrp.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 03:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=acF3DitoyymhurVq8KUqY0AN8ctPL+NGsZ1lE4tVO3I=;
        b=Xam3wbBfd+QhtmWpMxny/jrawAMCumM4nWMa7Xu337tUqy+CimqV1cXpy16vr2loIv
         H+zh7kWK0sEQgpQkR2C3jsbZJUBEHWdNI0oBweRGtbGu4gv1YXstggVDlvHO2uTwBP/v
         Kz9tvYfHV6jCjcDMnVU1coDvtlBWi4AXHY3Xu1nGNWB0Pe/A/NzSM/tsWkl9HgcHAa9M
         csXTu5eUKcvjv4Yj9VLCc9riOgMX4RKPHihgAZ/wcvNYMGj45EMBuzl0n3vJZd3lRxk+
         UgqXRH1z8Svc4MoBi0krEkk8KpGroThieJLsvSRY8zFEGp/RcC5M40LEQgIy7bMKviVd
         5szQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=acF3DitoyymhurVq8KUqY0AN8ctPL+NGsZ1lE4tVO3I=;
        b=fqJeLFZfUl8XPBQaT+pVTGZKl0S+1cer9pVb50Q3s+vZYbgR4FG3txFzNlgcxpC/ID
         WX4vtZGy+ZtmyMPvBaMBh3uqYAmeGwBYqWudwjfrYC2/piyzv7BGw2AhYvL8x58DUAK6
         DsF5h/bmtN7GknJd2qry/N+r3LSXcPLQolb/o6Wt/zT6mMm1gvE7A/8vWIR4XA55ed98
         S+NimlTuLwM9BHYihB6aZZoq8iXVKq8CDKzg6U+Bbwz6FGLbsaNDBGqO6jHMSWMj7ZbC
         Vc299fWaHxokygvaWjbhEo52R9+xw9eotQJHIjpPB1H75JTy0wE1gx+s5QxWyhC5SkPj
         0J7A==
X-Gm-Message-State: APjAAAVSp2wZslbFwLqtW74s20NCaZxZ0bIbn0LW0CCiNnXhpC9ccySt
        6gttWPl8wtlPW/jE0ptCCpjDYQ==
X-Google-Smtp-Source: APXvYqwshDw1X8JBQbcUMRf0bddU46IVIkrhV3UbcV4g/noVcWEUba+Kf7z9rnKOxGqJ9FDS8wnrLQ==
X-Received: by 2002:a5d:474b:: with SMTP id o11mr2667939wrs.182.1552301508744;
        Mon, 11 Mar 2019 03:51:48 -0700 (PDT)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id c21sm6902640wre.35.2019.03.11.03.51.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 03:51:48 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 0/2] drm/meson: only allow using meson-canvas
Date:   Mon, 11 Mar 2019 11:51:42 +0100
Message-Id: <20190311105144.7276-1-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series aims at removing access to the DMC register range from
the meson DRM driver, and is the final step at fully migrating it to using
the meson canvas provider module.

Please see the commit notes of patch 1/2
"dt-bindings: display: amlogic, meson-vpu: exclusively use amlogic,canvas"
for more information.

This series also incorporates a probing fix proposed by Neil Armstrong [1]
although rewritten because of heavy code changes in the corresponding
location.

[1] https://lkml.org/lkml/2019/2/4/152

Maxime Jourdan (2):
  dt-bindings: display: amlogic, meson-vpu: exclusively use
    amlogic,canvas
  drm/meson: exclusively use the canvas provider module

 .../bindings/display/amlogic,meson-vpu.txt    |  5 +-
 drivers/gpu/drm/meson/Makefile                |  2 +-
 drivers/gpu/drm/meson/meson_canvas.c          | 73 ----------------
 drivers/gpu/drm/meson/meson_canvas.h          | 51 -----------
 drivers/gpu/drm/meson/meson_crtc.c            | 84 ++++++-------------
 drivers/gpu/drm/meson/meson_drv.c             | 68 ++++++---------
 drivers/gpu/drm/meson/meson_drv.h             |  1 -
 drivers/gpu/drm/meson/meson_overlay.c         |  8 --
 drivers/gpu/drm/meson/meson_plane.c           |  6 +-
 drivers/gpu/drm/meson/meson_viu.c             |  1 -
 10 files changed, 53 insertions(+), 246 deletions(-)
 delete mode 100644 drivers/gpu/drm/meson/meson_canvas.c
 delete mode 100644 drivers/gpu/drm/meson/meson_canvas.h

-- 
2.21.0

