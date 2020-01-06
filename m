Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24068C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EFC207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KB5fdqLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgAFPRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 10:17:02 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34972 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgAFPRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:17:01 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so15658642wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 07:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gpvhQLZoHknjJ48p3/o2FGQ5HOsekKMFfojG0bDSsqg=;
        b=KB5fdqLSM2cxZ4hWFKG4I+fvO8r5AB9PHS98h9BBsn2xLvMouLGDrBteRn9sUKU50h
         G9fMGn6fIYvg3Wm8+FA3eKhnVFvJj6lHr20iqMVWGB6loLxYo3CM+kuXNXui28iiqeNX
         T3kT8cT0BLyftcJiL7QHrrj1PUUqYg60s9HwMlSdOmbykqR/eSe7ZIHNsQnObzjtl3Ug
         u4d++4DJPrFPehKamp36pLNtFkalxWAw7EjIQm29xzy2tpLGMGl9vDNoB96pi0oLAN/g
         0EC9TSrN8i4pohD3Qr7ofD14U2vVlfoA9XbK8wRcZC1EPRHP9uBvb3UQWmDZYVqLmPla
         erKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gpvhQLZoHknjJ48p3/o2FGQ5HOsekKMFfojG0bDSsqg=;
        b=Z1ZuEZ/rhJiGZwxQtXGmtblvalRD7T3X8Rr2sqWH7XQZSTitOm8lGC22IX2+ZZQMOh
         OntX8HYwVOVsBvYKEloocNy6ksM9KEnHPrd03nxO5PIAsxjN4FhS2IeOe56eJclX43Uz
         n4iwPl00CrQx7i0lQyLP2/S5qCcroKZXX47Ab7tjQfbtoiNbcBojes6xTr0wCMvGdzge
         tAlymPMVTmZexz9nAxB4yzfaw8cffo9U94fihkYeK89LPXhrfyXd/iUssUpf6p/+rNKl
         UU3bFGqoKGwFEBXxZRuMLYHGPjslnOsvmhxYKNF5NRQEVkxFFLbhNzMhoqprZQ+zmptc
         UCaA==
X-Gm-Message-State: APjAAAVLtkG/3xFjrmLFealXnQNmHfMX3Z1UDWQ7ix2AGxkGk+wvLxnb
        tNOgudRZ0CdCT8VATcRVGdg2enA9VQPsAQ==
X-Google-Smtp-Source: APXvYqyPuCXy4xd36sgrJa286zCiAoAPjP2058i4I+qddvYosdeD5QkkY6BQZOszgfUbZSuabmd/mQ==
X-Received: by 2002:a1c:4884:: with SMTP id v126mr32826252wma.64.1578323820322;
        Mon, 06 Jan 2020 07:17:00 -0800 (PST)
Received: from localhost.localdomain ([62.178.82.229])
        by smtp.gmail.com with ESMTPSA id l3sm72122463wrt.29.2020.01.06.07.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 07:16:58 -0800 (PST)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/6] update hwdw for gc400
Date:   Mon,  6 Jan 2020 16:16:45 +0100
Message-Id: <20200106151655.311413-1-christian.gmeiner@gmail.com>
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

 drivers/gpu/drm/etnaviv/etnaviv_gpu.c  | 18 ++++++++++-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h  |  6 ++--
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 42 +++++++++++++++++++++++++-
 drivers/gpu/drm/etnaviv/state_hi.xml.h | 29 +++++++++++-------
 4 files changed, 79 insertions(+), 16 deletions(-)

-- 
2.24.1

