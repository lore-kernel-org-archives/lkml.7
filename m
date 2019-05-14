Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7258C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A7A2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vRhN6Oyp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfENN4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 09:56:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37279 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfENN4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 09:56:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id e15so6941997wrs.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 06:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JrFvYsL9fwlu+wGRvMZUzKBLdClu5UnEjuCYqxgFHo4=;
        b=vRhN6OyptonXD2qpAiv7fRpzH/Ey0Db5kx/NZfg1Kas+20VHEBpr9O8wu2ZC5W+Uya
         jonjVyjvIIJs63re8xNvmuoukPLdZlQFi7eR3FYItubTHemeWP3jmdBa4DQ1xeoa4jTc
         IjwXweOM8SekW6uNNR2NR9A6HNvJpeM3XTAAC5zzWHCSPBI4d/4lcguokMUGFyht4fGS
         CeXVTzfsuWsmjla0GQv9xh4eDpLAuq9J3Jc+DvmuWcjSr416xctmDNrBoCETaLKeIduP
         WoZhltnk1pKvfsFnZwp+cgHNL+T6nhY7miF8XanwWT8SMgSirhenrbHcdXh3ZgB2YWvE
         ZQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JrFvYsL9fwlu+wGRvMZUzKBLdClu5UnEjuCYqxgFHo4=;
        b=KrFr7vqzd8C8OyavmFJ8cpIHb/m5XHk0439Bgcrib6Vb2xGUPBghbeGCxmlyKg2rzo
         ut2mkWfgkrV+rykelaKoR/uYcwgZ/s5dDdziniyAZMqFFIelh1oqP8S5mig9RHFSl2Ac
         VsnweACQ69O2sDQKvQUlFe5OEI81eP/X++Z0/rVfboxnodBXPag9lGdIWubDVWJwQ9wj
         8hlGESM3UZYSK8Cj3XkWWkNpW7tORvkVDraCjqN7eoxmacQKN18nOWTngXssDhTwKfx4
         nwG11Chh/+2fRlruE09GgeEncVc3/sC84p4W60bs8WAE+hJK7BfUGuLb4ppAW5NkInNv
         WpRQ==
X-Gm-Message-State: APjAAAUGs36pXeU9w/v0ZrQvBEanhLYlReNVXfLUrqnKvP0N5VksupPb
        3tWIcSyT6Yqpkzs9alL9x20GCQ==
X-Google-Smtp-Source: APXvYqzGuTXOH1T/sqT7pwkrQAZzOpjyGHiQ0wi7lNh6MTK1fPtvzgs991odG+29VIdC3rEdzIW6mA==
X-Received: by 2002:adf:cc8e:: with SMTP id p14mr6585441wrj.82.1557842176332;
        Tue, 14 May 2019 06:56:16 -0700 (PDT)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id d72sm1375764wmd.12.2019.05.14.06.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 06:56:15 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v6 0/4] Add Amlogic video decoder driver
Date:   Tue, 14 May 2019 15:56:08 +0200
Message-Id: <20190514135612.30822-1-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

[V6] Good news, the firmware situation is resolved. We have received a
redistributable license from Amlogic and the firmwares have been merged
in linux-firmware[5].

[V5] It's been a while since the last patch series regarding the Amlogic
video decoder. Unfortunately, the firmware licensing situation is still
on hold as we await communication from Amlogic. As such, we do not have
the firmwares in linux-firmware yet.
I decided to push the V5 anyway, as changes were starting to pile up.

This patch series adds support for the Amlogic video decoder,
as well as the corresponding dt bindings for GXBB/GXL/GXM chips.

It features decoding for the following formats:
- MPEG 1
- MPEG 2

The following formats will be added in future patches:
- MJPEG
- MPEG 4 (incl. Xvid, H.263)
- H.264
- HEVC (incl. 10-bit)
- VP9 (incl. 10-bit)

The code was made in such a way to allow easy inclusion of those formats
in the future.

The decoder is single instance.

Files:
 - vdec.c handles the V4L2 M2M logic
 - esparser.c manages the hardware bitstream parser
 - vdec_helpers.c provides helpers to DONE the dst buffers as well as
 various common code used by the codecs
 - vdec_1.c manages the VDEC_1 block of the vdec IP
 - vdec_ctrls.c handles the V4L2 controls exposed by the driver
 - codec_mpeg12.c enables decoding for MPEG 1/2.
 - vdec_platform.c links codec units with vdec units
 (e.g vdec_1 with codec_mpeg12) and lists all the available
 src/dst formats and requirements (max width/height, etc.),
 per compatible chip.

It was tested primarily with ffmpeg's v4l2-m2m implementation. For instance:
$ ffmpeg -c:v mpeg2_v4l2m2m -i sample_mpeg2.mkv -f rawvideo out.nv12

The v4l2-compliance results are available below the patch diff.

Changes since v5 [4]:
 - Rebased against media_tree (fixes conflict with platform/meson/Makefile
 following the meson CEC driver updates)

Changes since v4 [3]:
 - Updated for 5.1: 
  - cropcap -> g_pixelaspect
  - dma_zalloc_coherent -> dma_alloc_coherent
 - enum_framesizes: changed from STEPWISE to CONTINUOUS, as suggested by Hans
 - Reintroduced support for CREATE_BUFS. It was a driver bug where I wasn't
 accounting for the amount of buffers created this way (only buffers created
 via REQBUFS were).
 - Added the patch introducing V4L2_FMT_FLAG_FIXED_RESOLUTION to the V4L2
 framework, needed as MPEG2 on Amlogic hardware only supports a fixed
 resolution during a decode session.
 - Added support for events and V4L2_EVENT_SOURCE_CHANGE, as it is now checked
 by v4l2-compliance for stateful decoders. I was planning on introducing this
 for codecs that actually use it (H264, HEVC..), but it doesn't hurt to have
 this in the initial commit.
 - Added support for controls, mainly V4L2_CID_MIN_BUFFERS_FOR_CAPTURE

Changes since v3 [2]:
 - strlcpy -> strscpy
 - queue_setup: account for existing buffers when clamping *num_buffers
 - removed support for CREATE_BUFS. This caused issues with gstreamer and allowed
 userspace to alloc more buffers than the decoder can handle in its fixed list.
 So for now we just disable it and only allow allocating via REQBUFS.
 - rebased & tested with 4.20-rc1

Changes since v2 [1]:
 - Override capture queue's min_buffers_needed in queue_setup
 The HW needs the full buffer list to be available when doing start_streaming
 - Fix the draining sequence
 The blob that we write to the ESPARSER to trigger drain is codec-dependent.
 The one that was sent in v1 is specific to H.264 and isn't guaranteed to
 trigger drain for MPEG2. For the latter, a simple MPEG2 EOS code
 should be sent to the ESPARSER instead.
 - Slight enhancements to the way we do vififo offset<=>timestamp matching

Changes since v1 [0]:
 - use named interrupts in the bindings
 - rewrite description in the bindings doc
 - don't include the dts changes in the patch series
 - fill the vb2 queues locks
 - fill the video_device lock
 - use helpers for wait_prepare and wait_finish vb2_ops
 - remove unnecessary usleep in between esparser writes.
 Extensive testing of every codec on GXBB/GXL didn't reveal
 any fails without it, so just remove it.
 - compile v4l2_compliance inside the git repo
 - Check for plane number/plane size to pass the latest v4l2-compliance test
 - Moved the single instance check (returning -EBUSY) to start/stop streaming
 The check was previously in queue_setup but there was no great location to
 clear it except for .close().
 - Slight rework of the way CAPTURE frames are timestamped for better accuracy
 - Implement PAR reporting via VIDIOC_CROPCAP

[5] https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/?id=e04cc56d0e6b6ff05924ff88fdba1a438ee7d3c8
[4] https://patchwork.kernel.org/cover/10879959/
[3] https://patchwork.kernel.org/cover/10669875/
[2] https://lore.kernel.org/patchwork/cover/993093/
[1] https://patchwork.kernel.org/cover/10595803/
[0] https://patchwork.kernel.org/cover/10583391/

Maxime Jourdan (4):
  dt-bindings: media: add Amlogic Video Decoder Bindings
  media: videodev2: add V4L2_FMT_FLAG_FIXED_RESOLUTION
  media: meson: add v4l2 m2m video decoder driver
  MAINTAINERS: Add meson video decoder

 .../bindings/media/amlogic,vdec.txt           |   71 ++
 .../media/uapi/v4l/vidioc-enum-fmt.rst        |    6 +
 MAINTAINERS                                   |    8 +
 drivers/media/platform/Kconfig                |   10 +
 drivers/media/platform/meson/Makefile         |    1 +
 drivers/media/platform/meson/vdec/Makefile    |    8 +
 .../media/platform/meson/vdec/codec_mpeg12.c  |  209 ++++
 .../media/platform/meson/vdec/codec_mpeg12.h  |   14 +
 drivers/media/platform/meson/vdec/dos_regs.h  |   98 ++
 drivers/media/platform/meson/vdec/esparser.c  |  323 +++++
 drivers/media/platform/meson/vdec/esparser.h  |   32 +
 drivers/media/platform/meson/vdec/vdec.c      | 1071 +++++++++++++++++
 drivers/media/platform/meson/vdec/vdec.h      |  265 ++++
 drivers/media/platform/meson/vdec/vdec_1.c    |  229 ++++
 drivers/media/platform/meson/vdec/vdec_1.h    |   14 +
 .../media/platform/meson/vdec/vdec_ctrls.c    |   51 +
 .../media/platform/meson/vdec/vdec_ctrls.h    |   14 +
 .../media/platform/meson/vdec/vdec_helpers.c  |  441 +++++++
 .../media/platform/meson/vdec/vdec_helpers.h  |   80 ++
 .../media/platform/meson/vdec/vdec_platform.c |  107 ++
 .../media/platform/meson/vdec/vdec_platform.h |   30 +
 include/uapi/linux/videodev2.h                |    5 +-
 22 files changed, 3085 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/amlogic,vdec.txt
 create mode 100644 drivers/media/platform/meson/vdec/Makefile
 create mode 100644 drivers/media/platform/meson/vdec/codec_mpeg12.c
 create mode 100644 drivers/media/platform/meson/vdec/codec_mpeg12.h
 create mode 100644 drivers/media/platform/meson/vdec/dos_regs.h
 create mode 100644 drivers/media/platform/meson/vdec/esparser.c
 create mode 100644 drivers/media/platform/meson/vdec/esparser.h
 create mode 100644 drivers/media/platform/meson/vdec/vdec.c
 create mode 100644 drivers/media/platform/meson/vdec/vdec.h
 create mode 100644 drivers/media/platform/meson/vdec/vdec_1.c
 create mode 100644 drivers/media/platform/meson/vdec/vdec_1.h
 create mode 100644 drivers/media/platform/meson/vdec/vdec_ctrls.c
 create mode 100644 drivers/media/platform/meson/vdec/vdec_ctrls.h
 create mode 100644 drivers/media/platform/meson/vdec/vdec_helpers.c
 create mode 100644 drivers/media/platform/meson/vdec/vdec_helpers.h
 create mode 100644 drivers/media/platform/meson/vdec/vdec_platform.c
 create mode 100644 drivers/media/platform/meson/vdec/vdec_platform.h


root@libretech-cc:~# v4l2-compliance -d /dev/video0 
v4l2-compliance SHA: 40fd5611c5176137c80616f6ee93b36f0d88f2d5, 64 bits

Compliance test for meson-vdec device /dev/video0:

Driver Info:
        Driver name      : meson-vdec
        Card type        : Amlogic Video Decoder
        Bus info         : platform:meson-vdec
        Driver version   : 5.1.0
        Capabilities     : 0x84204000
                Video Memory-to-Memory Multiplanar
                Streaming
                Extended Pix Format
                Device Capabilities
        Device Caps      : 0x04204000
                Video Memory-to-Memory Multiplanar
                Streaming
                Extended Pix Format
        Detected Stateful Decoder

Required ioctls:
        test VIDIOC_QUERYCAP: OK

Allow for multiple opens:
        test second /dev/video0 open: OK
        test VIDIOC_QUERYCAP: OK
        test VIDIOC_G/S_PRIORITY: OK
        test for unlimited opens: OK

Debug ioctls:
        test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
        test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
        test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
        test VIDIOC_ENUMAUDIO: OK (Not Supported)
        test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDIO: OK (Not Supported)
        Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
        test VIDIOC_G/S_MODULATOR: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_ENUMAUDOUT: OK (Not Supported)
        test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDOUT: OK (Not Supported)
        Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
        test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
        test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
        test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
        test VIDIOC_G/S_EDID: OK (Not Supported)

Control ioctls:
        test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
        test VIDIOC_QUERYCTRL: OK
        test VIDIOC_G/S_CTRL: OK
        test VIDIOC_G/S/TRY_EXT_CTRLS: OK
        test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
        test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
        Standard Controls: 2 Private Controls: 0

Format ioctls:
        test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
        test VIDIOC_G/S_PARM: OK (Not Supported)
        test VIDIOC_G_FBUF: OK (Not Supported)
        test VIDIOC_G_FMT: OK
        test VIDIOC_TRY_FMT: OK
        test VIDIOC_S_FMT: OK
        test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
        test Cropping: OK (Not Supported)
        test Composing: OK (Not Supported)
        test Scaling: OK

Codec ioctls:
        test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK

Buffer ioctls:
        test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
        test VIDIOC_EXPBUF: OK
        test Requests: OK (Not Supported)

Total for meson-vdec device /dev/video0: 44, Succeeded: 44, Failed: 0, Warnings: 0

-- 
2.21.0

