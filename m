Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25B6C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 05:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29A32075C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 05:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lON1htqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfE1F5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 01:57:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45481 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfE1F5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 01:57:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id w34so5608297pga.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 22:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DM2roW1uDasR/ZhwHW+lf0A3UJpao3MjC7jIgvQYwWs=;
        b=lON1htqnT51A/TgqWDNbasbuMR3FlrSuB4q9IdzD9gunXLPoXv6HIWiRzcGkEZ/FSW
         iazvgJJzI1AYNDHg5Tas2VKcqI4dR3V38lwXzk1me/GpbxuvFrZXEsS+27DjSuHiNE1g
         Ws9YGKoMjcyGzzqymF6/QeLwG3ppJqVEiaaBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DM2roW1uDasR/ZhwHW+lf0A3UJpao3MjC7jIgvQYwWs=;
        b=SKDUVgX2iXVA8FwSj4tdCorNs9C/+RuxVIamcOY+tQobcbkfw1AmtL6DdTvQad0EW1
         kpfBVpt6G5H9Nz6lvbhgQPhd27Rdarw2PE7+ccRAPSodL5Xjj4yaOIa3hynqFFMhH/GV
         LnHoQzVRBJQe0yBA06xtGi8Yu4nFHl9rbbHnwyWXZhPRip1bNEf/tTS7a6vQ8q2ahtGn
         vnAQ7VuFrhW2L8HligJkLuz5dxyQyns7KPBa9hpUcP5hLgakDFdIWR45UbylGQf79gsA
         N1NBqdqE2o8TtdNZalBdUmbecxE4EhwWIBfyg4yUS9vKqw5x5FVEAOIfwKYHqSGrOrVm
         kzAg==
X-Gm-Message-State: APjAAAXGn81lBAxhbmoapaOmxRyK4Qi1a+91ekBT3IKkTIVl7t2bRQGV
        g2xfAuJ+kSaZoCp53lHfOXLnmA==
X-Google-Smtp-Source: APXvYqzllEC5p/Z7QS0hLnM3/Kb5OyKB96SW7huDFH2YYaMAl4Rsg2svryHrforUkjGoMCld1uerGQ==
X-Received: by 2002:a17:90a:cf83:: with SMTP id i3mr3379555pju.71.1559023030501;
        Mon, 27 May 2019 22:57:10 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:4:4:9712:8cf1:d0f:7d33])
        by smtp.gmail.com with ESMTPSA id w1sm13950551pfg.51.2019.05.27.22.57.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 22:57:09 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [RFCv1 00/12] media: mtk-vcodec: support for MT8183 decoder
Date:   Tue, 28 May 2019 14:56:23 +0900
Message-Id: <20190528055635.12109-1-acourbot@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a refactoring/split of the initial patch for MT8183 codec support
that was posted for Chrome OS [1] in order to make it upstreamable.

The line count has been significantly reduced compared to the initial patch,
although support for the MT8183 encoder is not here yet to limit the amount of
code to review.

Although the series applies on top of today's media tree, it will not compile
until support for the SCP is merged, hence the RFC status. Note also that the
H.264 structures used and implementation of the stateless codec API may not be
completely up-to-date. So the goal of this publication is to review the general
idea (especially split unto stateful and stateless ops), and maybe merge the
first 5 patches.

Patches 1-5 are cleanup/small fixes that came while working on this series. They
should be harmless and can be merged.

Patches 6 adds a layer of abstraction to some of the decoder operations.
Currently mtk-vcodec and MT8173 use the stateful codec API, but MT8183 is based
on a stateless model. So patch 6 isolates the ops specific to the stateful codec
so MT8173 and MT8183 can share a big part of the code.

Patch 7 abstracts the firmware interface, as MT8173 and MT8183 are controlled
by different interfaces (VPU or SCP). Patch 8 adds the firmware ops for MT8183.

Patch 9 and 10 add support for stateless decoders in the driver, and support for
stateless H.264 decoding respectively.

Patch 11 takes care of adding the media device for stateless codecs, and
patch 12 allows the MT8183 decoder to probe.

I am mostly expecting comments about the general direction, but of course more
in-depth reviews are also welcome.

[1] https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1377757/

Alexandre Courbot (3):
  media: mtk-vcodec: avoid unneeded pointer-to-long conversions
  media: mtk-vcodec: remove unneeded proxy functions
  media: mtk-vcodec: constify formats

Yunfei Dong (9):
  media: mtk-vcodec: fix copyright indent
  media: mtk-vcodec: support single-buffer frames
  media: mtk-vcodec: move stateful ops into their own file
  media: mtk-vcodec: abstract firmware interface
  media: mtk-vcodec: add SCP firmware ops
  media: mtk-vcodec: vdec: support stateless API
  media: mtk-vcodec: vdec: support stateless H.264 decoding
  media: mtk-vcodec: vdec: add media device if using stateless api
  media: mtk-vcodec: enable MT8183 decoder

 drivers/media/platform/Kconfig                |   1 +
 drivers/media/platform/mtk-vcodec/Makefile    |   7 +-
 .../platform/mtk-vcodec/mtk_vcodec_dec.c      | 751 +++---------------
 .../platform/mtk-vcodec/mtk_vcodec_dec.h      |  30 +-
 .../platform/mtk-vcodec/mtk_vcodec_dec_drv.c  | 103 ++-
 .../platform/mtk-vcodec/mtk_vcodec_dec_pm.c   |   1 -
 .../mtk-vcodec/mtk_vcodec_dec_stateful.c      | 629 +++++++++++++++
 .../mtk-vcodec/mtk_vcodec_dec_stateless.c     | 493 ++++++++++++
 .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  81 +-
 .../platform/mtk-vcodec/mtk_vcodec_enc.c      |  45 +-
 .../platform/mtk-vcodec/mtk_vcodec_enc_drv.c  |  49 +-
 .../platform/mtk-vcodec/mtk_vcodec_enc_pm.c   |  26 +-
 .../media/platform/mtk-vcodec/mtk_vcodec_fw.c | 208 +++++
 .../media/platform/mtk-vcodec/mtk_vcodec_fw.h |  38 +
 .../platform/mtk-vcodec/mtk_vcodec_util.c     |   1 -
 .../platform/mtk-vcodec/vdec/vdec_h264_if.c   |  22 +-
 .../mtk-vcodec/vdec/vdec_h264_req_if.c        | 533 +++++++++++++
 .../platform/mtk-vcodec/vdec/vdec_vp8_if.c    |  22 +-
 .../platform/mtk-vcodec/vdec/vdec_vp9_if.c    |  22 +-
 .../media/platform/mtk-vcodec/vdec_drv_base.h |  10 +-
 .../media/platform/mtk-vcodec/vdec_drv_if.c   |  19 +-
 .../media/platform/mtk-vcodec/vdec_vpu_if.c   |  10 +-
 .../media/platform/mtk-vcodec/vdec_vpu_if.h   |  11 +-
 .../platform/mtk-vcodec/venc/venc_h264_if.c   |  34 +-
 .../platform/mtk-vcodec/venc/venc_vp8_if.c    |  27 +-
 .../media/platform/mtk-vcodec/venc_drv_base.h |   8 +-
 .../media/platform/mtk-vcodec/venc_drv_if.c   |  11 +-
 .../media/platform/mtk-vcodec/venc_vpu_if.c   |  15 +-
 .../media/platform/mtk-vcodec/venc_vpu_if.h   |   5 +-
 29 files changed, 2328 insertions(+), 884 deletions(-)
 create mode 100644 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateful.c
 create mode 100644 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateless.c
 create mode 100644 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.c
 create mode 100644 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.h
 create mode 100644 drivers/media/platform/mtk-vcodec/vdec/vdec_h264_req_if.c

-- 
2.22.0.rc1.257.g3120a18244-goog

