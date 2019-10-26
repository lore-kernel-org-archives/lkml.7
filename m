Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F6FCA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 07:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBB72084C
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 07:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfJZHuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 03:50:20 -0400
Received: from mailoutvs22.siol.net ([185.57.226.213]:60155 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725966AbfJZHuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 03:50:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 3165A521C51;
        Sat, 26 Oct 2019 09:50:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id GGY99NcpPuBy; Sat, 26 Oct 2019 09:50:16 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id D4D8D521CAF;
        Sat, 26 Oct 2019 09:50:16 +0200 (CEST)
Received: from localhost.localdomain (cpe-86-58-59-25.static.triera.net [86.58.59.25])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 6928B521C52;
        Sat, 26 Oct 2019 09:50:16 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        gregkh@linuxfoundation.org, wens@csie.org,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 0/3] media: cedrus: Add support for 4k videos
Date:   Sat, 26 Oct 2019 09:49:56 +0200
Message-Id: <20191026074959.1073512-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While cedrus driver accepts videos up to 3840x2160, they are not decoded
correctly. Driver doesn't correctly set mode register for widths greater
than 2048 (patch 1). H264 engine also needs additional buffers which are
not provided currently (patch 2). Finally, there are several different
resolutions which can be considered 4k. Biggest is 4096x2304 which is
also supported by HW. Set that new maximum size (patch 3).

HEVC engine was not yet tested with 4k video, but as far as I know, it
doesn't need any special setting besides patch 1.

Following video was used for H264 video testing:
http://jernej.libreelec.tv/videos/h264/PUPPIES%20BATH%20IN%204K%20(ULTRA%=
20HD)(Original_H.264-AAC)%20(4ksamples.com).mp4

Note that at this point memory allocation is suboptimal and H264 engine
allocates far more memory that it is really needed. For above video to
work, I had to set CMA size to 512 MiB and add "vmalloc=3D512M" to kernel
arguments. Memory optimizations will be done later.

This series is based on top of https://patchwork.linuxtv.org/cover/59653/

Best regards,
Jernej

Jernej Skrabec (3):
  media: cedrus: Properly signal size in mode register
  media: cedrus: Fix H264 4k support
  media: cedrus: Increase maximum supported size

 drivers/staging/media/sunxi/cedrus/cedrus.h   |  7 ++
 .../staging/media/sunxi/cedrus/cedrus_h264.c  | 85 +++++++++++++++++--
 .../staging/media/sunxi/cedrus/cedrus_h265.c  |  2 +-
 .../staging/media/sunxi/cedrus/cedrus_hw.c    |  9 +-
 .../staging/media/sunxi/cedrus/cedrus_hw.h    |  2 +-
 .../staging/media/sunxi/cedrus/cedrus_mpeg2.c |  2 +-
 .../staging/media/sunxi/cedrus/cedrus_regs.h  | 13 +++
 .../staging/media/sunxi/cedrus/cedrus_video.c |  4 +-
 8 files changed, 108 insertions(+), 16 deletions(-)

--=20
2.23.0

