Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1627C2BD09
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC5724249
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RgVylUW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfLEPeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 10:34:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33993 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLEPeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 10:34:14 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so4183143wrr.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 07:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GIebstkH20puIVZWgC2hGKzku3yRSI4A3CVg92MDVQs=;
        b=RgVylUW7KveDxJ3ohhKWc4l3cCuIRuSxVDGHkWxQkyJAq73UqLAdPV5ykqeEWOigV6
         kPpYyUfLkJwt8IUI7hhNJv/97o+h4NHtlJazgz6EhwrKqxF9drvekDzXRe5tjwM29eUR
         ou0SaXgUYQl6RGpaa/vdtqqHjcM41TwNDT/A4IYz3ZVnjEBr86CwYX+iwkPTmAamoCFN
         h9xXbU3THxhkfLDA6APB86DdG30Tcpup3M1NbJY9FVtUa0dQimhFEg+OSFlfEKDW1EPp
         Xwej+fYV2ZOfw5abJAN/P9svXvtmQEdIUi8mQfIb18Eynf5CuyQAcOdy13tj9b1xXNN4
         uZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GIebstkH20puIVZWgC2hGKzku3yRSI4A3CVg92MDVQs=;
        b=lwAAXL0W8zrawonnbfiLW1tbpA2cPtYYTAp5KlrwDXbz4IN3GP7Jbrb+Cfmx760RTG
         osdxqQRf93/nTGrANgPtdBEi6komLBXl4E8ujYyUGd9qK/h1d8j9Sz1jVgZgJvTCMV0V
         Zr0xK67Mhq3Yzl44Jo5qVaPFyyyOezFbARPVLHuj/aRrMqcrdQ1P3LPgMeBSATAHPmJr
         bnBD3CrhM2JlWWbMMpOxTS/BbSz80lJj2Xni3X5ASEmQe+Uy2Oe7gPqw6ARz0lYHhlb4
         XKbG9HpNUVheNBdMwhP8rU85tIPFPS3x+YUQuCiM7DR92ptEbwnU2M9suXi3SYbLtxu5
         HQYw==
X-Gm-Message-State: APjAAAWZWMjHqNbxCGgiPc7gd0WHUZybYyhnEc068VVk3+jzcvMQL/+3
        aS5miMll742Zpb7Waa1iJZ1iOGJQ7VEXQQ==
X-Google-Smtp-Source: APXvYqzISVFwgl00Y4cT7qU6re/o5QIa1Ua3iwxFaohFbaqWWtF4alAmwbSyhxysbWxjiZGXBlFlxA==
X-Received: by 2002:adf:cd0a:: with SMTP id w10mr10564920wrm.107.1575560052661;
        Thu, 05 Dec 2019 07:34:12 -0800 (PST)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id u26sm191894wmj.9.2019.12.05.07.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 07:34:11 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     mjourdan@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] media: meson: vdec: add g12a platform
Date:   Thu,  5 Dec 2019 16:34:04 +0100
Message-Id: <20191205153408.26500-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the current Amlogic Video Decoder
driver for the Amlogic G12A & compatible SoCs.

The bindings are converted to YAML and dt-schemes to ease validation
of the bindings and the Amlogic DT.

Then support is added for the currently supported MPEG1 & MPEG2 decoders
and additional clock for upcoming HEVC/VP9 decoder support.

M2M Decoder compliance is handled in a separate patchset at [1].

# v4l2-compliance
v4l2-compliance SHA: 7ead0e1856b89f2e19369af452bb03fd0cd16793, 64 bits

Compliance test for meson-vdec device /dev/video0:

Driver Info:
	Driver name      : meson-vdec
	Card type        : Amlogic Video Decoder
	Bus info         : platform:meson-vdec
	Driver version   : 5.4.0
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
	test Scaling: OK (Not Supported)

Codec ioctls:
	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
	test VIDIOC_(TRY_)DECODER_CMD: OK

Buffer ioctls:
	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
	test VIDIOC_EXPBUF: OK
	test Requests: OK (Not Supported)

Total for meson-vdec device /dev/video0: 44, Succeeded: 44, Failed: 0, Warnings: 0

[1] https://lore.kernel.org/linux-media/20191126093733.32404-1-narmstrong@baylibre.com

Maxime Jourdan (2):
  media: meson: vdec: add g12a platform
  arm64: dts: meson-g12-common: add video decoder node

Neil Armstrong (2):
  dt-bindings: media: amlogic,vdec: convert to yaml
  dt-bindings: media: amlogic,gx-vdec: add bindings for G12A family

 .../bindings/media/amlogic,gx-vdec.yaml       | 139 ++++++++++++++++++
 .../bindings/media/amlogic,vdec.txt           |  72 ---------
 .../boot/dts/amlogic/meson-g12-common.dtsi    |  23 +++
 drivers/staging/media/meson/vdec/vdec.c       |  13 +-
 drivers/staging/media/meson/vdec/vdec.h       |   1 +
 .../staging/media/meson/vdec/vdec_platform.c  |  30 ++++
 .../staging/media/meson/vdec/vdec_platform.h  |   2 +
 7 files changed, 206 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/amlogic,gx-vdec.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/amlogic,vdec.txt

-- 
2.22.0

