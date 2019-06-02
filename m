Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B39C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 21:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E596268AF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 21:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsDpK0en"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfFBVoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 17:44:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42253 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfFBVoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 17:44:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id y13so11961729lfh.9;
        Sun, 02 Jun 2019 14:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SBjg5eRa81EzQPPSxTQMKBg6nX0dKdVE0RBDky8GBmA=;
        b=YsDpK0enaC3AKpHJBpeWesF3I3XFx4UEa2ArMOUJ2gsU4VYeNUUuq4kR/nx155oPpP
         xl6GGEIP9QYoSDkJ5aAoJUMPa2/3s0W852J27jTTKA45mngN7mX8kMnfXIHTQxukywXz
         q7vYo5pRad4doGyTnwL4f7QLHY/pm2sRcSSA03cDGkvt94fRYjgUWlfCsj5CiHL4FfSS
         LRlmMRRq+MH5nc0Nua1SOa69PCFksPfDcwUv74z9l8SruttXz2bBmMhcpQHswHTTA4z0
         QgHoXCM5GYRgJrB6GtS2USoORtnW0OVNnzkTo3vEywkLWMLh3AdQyA3iQx2MIlgjw05P
         HZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SBjg5eRa81EzQPPSxTQMKBg6nX0dKdVE0RBDky8GBmA=;
        b=bn1sZQikJF3LR6BshmspF4bgHkC8ILuknU7t4UpFOkphnASqKH0wJW86felA2a9uHd
         b6tH77ZcSWVtoofJgJ1/6RlhiZVsHV+3omLX9DOS0/OK/q1TSsGYqDN9sEOXS1F+QoLW
         2suR73dRVi2OwpdUOnJYlM7p4BL5KtIIG/hEcmCcHvCSdGtT+ZZ440hNNe+fiRAvv/wl
         zmkTcLoxtiYyKdMlTzHvvV9gzY8C1HGrrFYXRiS2zxVN+BDOoj7lumst6cqj5H5y9q3P
         qs2rDnGJYkSwn/g3w1fgLObH+hJ2CyWjK9TClC+KrK8iFBu+97HN0PRqy28J0CYkGAQU
         nJpw==
X-Gm-Message-State: APjAAAV1MWyBhm5cdCpLq91HTol1i2HoVNsA9xyNbW2omSI+NyAofELK
        aX18wps5D+rrF2zPCpSSb8c=
X-Google-Smtp-Source: APXvYqzRFvCNnsb07UorKV39uaj4aB8VnwzziVDJkkHdhszJ9fxKQWmdYoy/eC6HvwChuiuiNPCnww==
X-Received: by 2002:a19:6a01:: with SMTP id u1mr10103527lfu.141.1559511876507;
        Sun, 02 Jun 2019 14:44:36 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id g22sm2803653lje.43.2019.06.02.14.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 14:44:35 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] NVIDIA Tegra Video Decoder driver improvements
Date:   Mon,  3 Jun 2019 00:37:05 +0300
Message-Id: <20190602213712.26857-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series cleans up some of minor shortcomings that are caused by
checkpatch recommendations that are not very applicable for the driver.
Then IOMMU support is added to the driver and now it can handle sparse
memory buffers that GPU hands to VDE in a default kernel configuration
on Tegra30+.

Dmitry Osipenko (4):
  staging: media: tegra-vde: Remove BIT() macro from UAPI header
  staging: media: tegra-vde: Manually pack UAPI structures
  staging: media: tegra-vde: Add IOMMU support
  staging: media: tegra-vde: Defer dmabuf's unmapping

 drivers/staging/media/tegra-vde/Kconfig       |   1 +
 drivers/staging/media/tegra-vde/Makefile      |   1 +
 .../staging/media/tegra-vde/dmabuf-cache.c    | 223 ++++++++++++++++++
 drivers/staging/media/tegra-vde/iommu.c       | 146 ++++++++++++
 drivers/staging/media/tegra-vde/trace.h       |   1 +
 drivers/staging/media/tegra-vde/uapi.h        |  48 ++--
 .../media/tegra-vde/{tegra-vde.c => vde.c}    | 212 ++++++-----------
 drivers/staging/media/tegra-vde/vde.h         | 105 +++++++++
 8 files changed, 574 insertions(+), 163 deletions(-)
 create mode 100644 drivers/staging/media/tegra-vde/dmabuf-cache.c
 create mode 100644 drivers/staging/media/tegra-vde/iommu.c
 rename drivers/staging/media/tegra-vde/{tegra-vde.c => vde.c} (88%)
 create mode 100644 drivers/staging/media/tegra-vde/vde.h

-- 
2.21.0

