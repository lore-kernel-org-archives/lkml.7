Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D6CC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E96020740
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IzRk5AUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfL0Rhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:37:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46688 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfL0Rhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:37:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so26596200wrl.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 09:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CgL35F0PbHIPU/xEH/yy9QoMVLs1tW/HJnhHgsc5otw=;
        b=IzRk5AUha85e7ZBCIOmBml/0x7GVSoZe86A4RuekbCtKw9koHk96jYDQzvksMlroIw
         QPo76Lk1FreaiJs+nJlxY+DGPDuAY+IqoHZrnEab+FZNodNyyzGPZuhhZGqNA0ygRsSn
         OvxTJQgLvEO58F9eoYgth4dX9kL9tvBf8pkR4nNOy4ygfr+6ypFaOskRNfV+HjgNjTP9
         SRXFGXA4FjuXIRfJOWUn34EHQSluO7zRj5sm7nGRHcDIecXkNdVEpdLeGYmaKErg5yfQ
         /IVeaOYZu4c7oWdEMsF8yE3bTmR5fv4KWbFol8SVD2OByfCJyKRmC/iD7pBQB5Vr/sho
         9vDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CgL35F0PbHIPU/xEH/yy9QoMVLs1tW/HJnhHgsc5otw=;
        b=adTRI5eOMN5GrhZA6YvVCXLtsndYMAUz3H37EFZriBMyK2pqOqvXX55nvJfLH3hN3V
         oDmn1zXuCAU+DJDVeffFv9apcN/GKVj9reGRfW4DQH5D6LUB4Ob6DP+fpH8810q5TtVn
         r+QG5LFuOPmNdI20lrteO8YxHmfFgIOrXRl4kE5e6NwAD4zFi2CplEAkHCPHnLFnYNPI
         2s6NfWF2+378atQNHD3fuBI5I4bSUUUOFKu3KroTz29mG1BYMXRlSluExddmvBd/+qsm
         0tZI1xNN+nqx8kqo87aTR2FvGEwrnHuQX3Nl71FxZ8nY/HzNi/Bz/lt78bXZiWg5hhVN
         1S5w==
X-Gm-Message-State: APjAAAWFaz3fuXhDb9kssQAlIMUghu2GfMUtRmq8Tg4glkdpZU5+j5T0
        JxGZZt4Imiq2fb8usX0R3C4=
X-Google-Smtp-Source: APXvYqy2UYkwMWU2dPVz7z8FO3EUeuKP2Q67lEtRTqjhCkPr42la3j1A1wB8F6mXKYw58lhzPxwabg==
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr41875477wrj.325.1577468265643;
        Fri, 27 Dec 2019 09:37:45 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id f1sm35001776wru.6.2019.12.27.09.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 09:37:45 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     yuq825@gmail.com, dri-devel@lists.freedesktop.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        tomeu.vizoso@collabora.com, robh@kernel.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org, wens@csie.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC v2 0/1] drm: lima: devfreq and cooling device support
Date:   Fri, 27 Dec 2019 18:37:06 +0100
Message-Id: <20191227173707.20413-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is my attempt at adding devfreq (and cooling device) support to
the lima driver.

I am seeking comments in two general areas:
- regarding the integration into the existing lima code
- for the actual devfreq code (I had to adapt the panfrost code
  slightly, because lima uses a bus and a GPU/core clock)

My own TODO list includes "more" testing on various Amlogic SoCs.
So far I have tested this on Meson8b and Meson8m2 (which both have a
GPU OPP table defined). However, I still need to test this on a GXL
board (which is currently missing the GPU OPP table).

Test results from a Meson8m2 board:
TEST #1: glmark2-es2-drm --off-screen in an infinite loop while cycling
         through all available frequencies using the userspace governor

     From  :   To
           : 182142857 318750000 425000000 510000000 637500000   time(ms)
  182142857:         0      1274      1274      1273      1279   5399468
  318750000:      1274         0      1274      1273      1272   5114700
  425000000:      1276      1274         0      1272      1271   5122008
  510000000:      1909      1273      1273         0       636   5274292
* 637500000:       640      1272      1272      1273         0   5186796
Total transition : 24834

TEST #2: glmark2-es2-drm --off-screen in an infinite loop with the
         simple_ondemand governor
     From  :   To
           : 182142857 318750000 425000000 510000000 637500000   time(ms)
  182142857:         0         0         0         0       203    318328
  318750000:        53         0         0         0        21     56044
  425000000:        27        18         0         0         2     34172
  510000000:        27         6        14         0         1     41348
* 637500000:        95        50        33        48         0   2085312


Changes since RFC v1 at [0]:
- added lock to protect the statistics as these can be written 
  concurrently for example when the GP and PP IRQ are firing at the
  same time. Thanks to Qiang Yu for the suggestion!
- updated the copyright notice of lima_devfreq.c to indicate that the
  code is derived from panfrost_devfreq.c. Thanks to  Chen-Yu Tsai  for
  the suggestion!
- I did not unify the code with panfrost yet because I don't know where
  to put the result. any suggestion is welcome though!


[0] https://patchwork.freedesktop.org/series/70967/


Martin Blumenstingl (1):
  drm/lima: Add optional devfreq support

 drivers/gpu/drm/lima/Kconfig        |   1 +
 drivers/gpu/drm/lima/Makefile       |   3 +-
 drivers/gpu/drm/lima/lima_devfreq.c | 183 ++++++++++++++++++++++++++++
 drivers/gpu/drm/lima/lima_devfreq.h |  15 +++
 drivers/gpu/drm/lima/lima_device.c  |   4 +
 drivers/gpu/drm/lima/lima_device.h  |  17 +++
 drivers/gpu/drm/lima/lima_drv.c     |  14 ++-
 drivers/gpu/drm/lima/lima_sched.c   |   7 ++
 drivers/gpu/drm/lima/lima_sched.h   |   3 +
 9 files changed, 244 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/lima/lima_devfreq.c
 create mode 100644 drivers/gpu/drm/lima/lima_devfreq.h

-- 
2.24.1

