Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C426C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8D621655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdT1OzK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgABKCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 05:02:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35286 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbgABKCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 05:02:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so5173847wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 02:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mm65JcAg1ZYpA82nx53uBDXsueD59zvLBeCy6xVJP4U=;
        b=ZdT1OzK7hQuktzkey9WnEYjOrin4SyuliWpOAh8jEtsCjx/hNutr1uZeMy1UXuyWlQ
         RwDATLzRrEsR2ctZbCIFmY3ooZsKRJL0RW92rnFL8rFUt0DiT8bonCZGPfNkNGv78n6X
         ChZetuJF8lJNgf2wu+h4JveqtRT0DirsTgDXTf+1d4yM5wIv2+I74jeHo+X1TZSSR9kb
         rqPFGfB7MUb28/njJcjaFDyUFpoRcbo46Dc5o3ZkTNy+fZ2cqOTTDM/m3QsPKQKrV7UA
         pQXX22i+r5ZqJCHrzK42557dgPYscLCfgMlMPr1leAfunSrGuXu73Xe8XawgVhh7Xr5u
         Oskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mm65JcAg1ZYpA82nx53uBDXsueD59zvLBeCy6xVJP4U=;
        b=cs1y5Iux90gV7x/icMy///O08uxqwreJlA9T7AajlKA0PDS+VZch42YAr9NUhw1LG7
         Mu/wimIOr8srci5W88Sr/zWhQvlJNTBOT9nZj1VJwioTUb2p+Gc5214Hsnwgezn0gDA5
         3/6vBS2VL0UvT+E0zZRzIdDeTfatMqEmwlJ5hfx0cCsLPil1Xyl08KV5NbT/GKtYCoAT
         RlKhW3Vcur+w+FObEnZEyeEjsRmoOIYyNqB6x7+knUxueOGPiW3dK17Dg5yUaP5pyI1u
         rmMyj1IDIeVqczdLO8yvVumeNREyiapQwKLLrFQfEqBMd/UYowzMJ+5ewjLNPYAqJj3S
         zWJg==
X-Gm-Message-State: APjAAAW2oYuv1ahzTYZacPjOQjwRvbyc1sQ5eEtU3TzN9x+Md6Vgzq6I
        fR7ukXoTjUuc4g614nhTWdf/TLtuVv8=
X-Google-Smtp-Source: APXvYqzzEosiPHarvSoykIKuTVfw921HCy0TuMLrmxCxTM856SYCk1wYvbSMbHGIMA6VIfHGSlyCvA==
X-Received: by 2002:a1c:f001:: with SMTP id a1mr13007143wmb.76.1577959357407;
        Thu, 02 Jan 2020 02:02:37 -0800 (PST)
Received: from localhost.localdomain (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id r6sm55418683wrq.92.2020.01.02.02.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 02:02:36 -0800 (PST)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 0/6] update hwdw for gc400
Date:   Thu,  2 Jan 2020 11:02:14 +0100
Message-Id: <20200102100230.420009-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series extends the hwdb for an entry for the gc400 found
in the ST STM32 SoC. With this patches we report the same limits and
features for this GPU as the galcore kernel driver does.

Christian Gmeiner (6):
  drm/etnaviv: update hardware headers from rnndb
  drm/etnaviv: determine product, customer and eco id
  drm/etnaviv: show identity information in debugfs
  drm/etnaviv: update gc7000 chip identity entry
  drm/etnaviv: update hwdb selection logic
  drm/etnaviv: add hwdb entry for gc400 found in STM32

 drivers/gpu/drm/etnaviv/etnaviv_gpu.c  | 29 ++++++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h  |  6 +--
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 53 +++++++++++++++++++++++++-
 drivers/gpu/drm/etnaviv/state_hi.xml.h | 29 ++++++++------
 4 files changed, 102 insertions(+), 15 deletions(-)

-- 
2.24.1

