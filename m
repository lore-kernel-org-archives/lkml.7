Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC716C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 20:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B683D20863
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 20:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfI2UA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 16:00:57 -0400
Received: from mailoutvs48.siol.net ([185.57.226.239]:53999 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725948AbfI2UA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 16:00:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 866535223B9;
        Sun, 29 Sep 2019 22:00:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Fd2JwI3Pambk; Sun, 29 Sep 2019 22:00:52 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id F375F522639;
        Sun, 29 Sep 2019 22:00:51 +0200 (CEST)
Received: from localhost.localdomain (cpe-86-58-59-25.static.triera.net [86.58.59.25])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id A3F3E5225ED;
        Sun, 29 Sep 2019 22:00:50 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        paul.kocialkowski@bootlin.com, mripard@kernel.org,
        pawel@osciak.com, m.szyprowski@samsung.com,
        kyungmin.park@samsung.com, tfiga@chromium.org, wens@csie.org
Cc:     gregkh@linuxfoundation.org, boris.brezillon@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        ezequiel@collabora.com, jonas@kwiboo.se, jernej.skrabec@siol.net
Subject: [PATCH v2 0/6] media: cedrus: h264: Support multi-slice frames
Date:   Sun, 29 Sep 2019 22:00:17 +0200
Message-Id: <20190929200023.215831-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for decoding multi-slice H264 frames along with
support for V4L2_DEC_CMD_FLUSH and V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF.

Code was tested by modified ffmpeg, which can be found here:
https://github.com/jernejsk/FFmpeg, branch mainline-test
It has to be configured with at least following options:
--enable-v4l2-request --enable-libudev --enable-libdrm

Samples used for testing:
http://jernej.libreelec.tv/videos/h264/BA1_FT_C.mp4
http://jernej.libreelec.tv/videos/h264/h264.mp4

Command line used for testing:
ffmpeg -hwaccel drm -hwaccel_device /dev/dri/card0 -i h264.mp4 -pix_fmt b=
gra -f fbdev /dev/fb0

Please note that V4L2_DEC_CMD_FLUSH was not tested because I'm
not sure how. ffmpeg follows exactly which slice is last in frame
and sets hold flag accordingly. Improper usage of hold flag would
corrupt ffmpeg assumptions and it would probably crash. Any ideas
how to test this are welcome!

Thanks to Jonas for adjusting ffmpeg.

Please let me know what you think.

Best regards,
Jernej

Changes from v1:
- added Rb tags
- updated V4L2_DEC_CMD_FLUSH documentation
- updated first slice detection in Cedrus
- hold capture buffer flag is set according to source format
- added v4l m2m stateless_(try_)decoder_cmd ioctl helpers

Hans Verkuil (2):
  vb2: add V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF
  videodev2.h: add V4L2_DEC_CMD_FLUSH

Jernej Skrabec (4):
  media: v4l2-mem2mem: add stateless_(try_)decoder_cmd ioctl helpers
  media: cedrus: Detect first slice of a frame
  media: cedrus: h264: Support multiple slices per frame
  media: cedrus: Add support for holding capture buffer

 Documentation/media/uapi/v4l/buffer.rst       | 13 ++++++
 .../media/uapi/v4l/vidioc-decoder-cmd.rst     | 10 +++-
 .../media/uapi/v4l/vidioc-reqbufs.rst         |  6 +++
 .../media/videodev2.h.rst.exceptions          |  1 +
 .../media/common/videobuf2/videobuf2-v4l2.c   |  8 +++-
 drivers/media/v4l2-core/v4l2-mem2mem.c        | 35 ++++++++++++++
 drivers/staging/media/sunxi/cedrus/cedrus.h   |  1 +
 .../staging/media/sunxi/cedrus/cedrus_dec.c   | 11 +++++
 .../staging/media/sunxi/cedrus/cedrus_h264.c  | 11 ++++-
 .../staging/media/sunxi/cedrus/cedrus_hw.c    |  8 ++--
 .../staging/media/sunxi/cedrus/cedrus_video.c | 14 ++++++
 include/media/v4l2-mem2mem.h                  | 46 +++++++++++++++++++
 include/media/videobuf2-core.h                |  3 ++
 include/media/videobuf2-v4l2.h                |  5 ++
 include/uapi/linux/videodev2.h                | 14 ++++--
 15 files changed, 175 insertions(+), 11 deletions(-)

--=20
2.23.0

