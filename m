Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACB5C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 01:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69DD92089F
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 01:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="fpT712Tj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfJMBIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 21:08:35 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40717 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbfJMBIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 21:08:34 -0400
Received: by mail-qt1-f196.google.com with SMTP id m61so19761625qte.7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 18:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=RiiTwpQS0mYXMCffosrGRNKPibt05f52ictxLJwzvMU=;
        b=fpT712Tjpp9uPzY85eDF0u+LnkZ1H6ejeS1YrHZD9pKSCvqNQrio4Zr+6YsMZZOMIO
         kOZ+hnsfdXLEHLe/cycvv7n8ROM5xDNotmBPVC+U8w/9k3CpuX6UU1ojQGIaH+d286Ck
         oRWxh3t3PSylyyysnTSRUEGuGmXmNn232Eey3AeSzxBvZPG+FKQfbRb35RJHB5qekQ08
         66zpa3f5445bql3MNKROPZ29uqWYvyrA+k7LKE2r6e+6pYlxfOKLRWir4I3LPONDQY9X
         txW/oNKUYGeGoU395gE9hqKvnnucgGNH3GbgxrOoxupTwBjfECjhOHS4XugtFyjaCbH4
         b5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=RiiTwpQS0mYXMCffosrGRNKPibt05f52ictxLJwzvMU=;
        b=CmzV2zYYFt4kQ+RfQnnfDUlQ/vdcdsvzMXqDpshvR3PPHXDDBgL0e5CygX6B8i7nPh
         T6glns/z+buJYCo0+YuqSPGoeJfA2M/znXeXndaPiabOrXyAXtoUN0aTKmg6q2BhKjzt
         cy1zZ0xVECIopMrPNv4xhhNddexL8HFTBIGzLZCHQEMoUV+bVkEpKNOZN6vvVhncStHE
         isqNhKFkRFUsLv89VVuAj7HG5L5rFFxRaKzyivQpnF8GrJhJiS0Lw8P6zm7Lva9FUezZ
         m6n+O22Z679kFbxNvWbHrDDJbfY6sZ5TQ/BMkT0j1O3f4WyEvJkyiXVw7hW6ZfXSdNi8
         N1bQ==
X-Gm-Message-State: APjAAAVh4OqpBoLvqb6q5U1SzzaApmg0tiJgia8vNtLuvC2Cz+cN9CiM
        bSBsQ4qoEfjtwrEk1y0HL77FJA==
X-Google-Smtp-Source: APXvYqw5Qlzus9NC2+DxGhuvgV3/CCP1I0biun6Wwc03PRi5rg3PVvDhH04cGhtGm00ois8o47RN9A==
X-Received: by 2002:ac8:708f:: with SMTP id y15mr25342761qto.247.1570928913106;
        Sat, 12 Oct 2019 18:08:33 -0700 (PDT)
Received: from skullcanyon ([192.222.193.21])
        by smtp.gmail.com with ESMTPSA id u39sm6944344qtj.34.2019.10.12.18.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 18:08:31 -0700 (PDT)
Message-ID: <bf072b400ce7d5a9f52cf7ca7ac0b36b22fff24f.camel@ndufresne.ca>
Subject: Re: [PATCH 0/2] media: meson: vdec: Add compliant H264 support
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Maxime Jourdan <mjourdan@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Date:   Sat, 12 Oct 2019 21:08:29 -0400
In-Reply-To: <20191007145909.29979-1-mjourdan@baylibre.com>
References: <20191007145909.29979-1-mjourdan@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 07 octobre 2019 à 16:59 +0200, Maxime Jourdan a écrit :
> Hello,
> 
> This patch series aims to bring H.264 support as well as compliance update
> to the amlogic stateful video decoder driver.
> 
> There is 1 issue that remains currently:
> 
>  - The following codepath had to be commented out from v4l2-compliance as
> it led to stalling:
> 
> if (node->codec_mask & STATEFUL_DECODER) {
> 	struct v4l2_decoder_cmd cmd;
> 	buffer buf_cap(m2m_q);
> 
> 	memset(&cmd, 0, sizeof(cmd));
> 	cmd.cmd = V4L2_DEC_CMD_STOP;
> 
> 	/* No buffers are queued, call STREAMON, then STOP */
> 	fail_on_test(node->streamon(q.g_type()));
> 	fail_on_test(node->streamon(m2m_q.g_type()));
> 	fail_on_test(doioctl(node, VIDIOC_DECODER_CMD, &cmd));
> 
> 	fail_on_test(buf_cap.querybuf(node, 0));
> 	fail_on_test(buf_cap.qbuf(node));
> 	fail_on_test(buf_cap.dqbuf(node));
> 	fail_on_test(!(buf_cap.g_flags() & V4L2_BUF_FLAG_LAST));
> 	for (unsigned p = 0; p < buf_cap.g_num_planes(); p++)
> 		fail_on_test(buf_cap.g_bytesused(p));
> 	fail_on_test(node->streamoff(q.g_type()));
> 	fail_on_test(node->streamoff(m2m_q.g_type()));
> 
> 	/* Call STREAMON, queue one CAPTURE buffer, then STOP */
> 	fail_on_test(node->streamon(q.g_type()));
> 	fail_on_test(node->streamon(m2m_q.g_type()));
> 	fail_on_test(buf_cap.querybuf(node, 0));
> 	fail_on_test(buf_cap.qbuf(node));
> 	fail_on_test(doioctl(node, VIDIOC_DECODER_CMD, &cmd));
> 
> 	fail_on_test(buf_cap.dqbuf(node));
> 	fail_on_test(!(buf_cap.g_flags() & V4L2_BUF_FLAG_LAST));
> 	for (unsigned p = 0; p < buf_cap.g_num_planes(); p++)
> 		fail_on_test(buf_cap.g_bytesused(p));
> 	fail_on_test(node->streamoff(q.g_type()));
> 	fail_on_test(node->streamoff(m2m_q.g_type()));
> }
> 
> The reason for this is because the driver has a limitation where all
> capturebuffers must be queued to the driver before STREAMON is effective.
> The firmware needs to know in advance what all the buffers are before
> starting to decode.
> This limitation is enforced via q->min_buffers_needed.
> As such, in this compliance codepath, STREAMON is never actually called
> driver-side and there is a stall on fail_on_test(buf_cap.dqbuf(node));
> 
> 
> One last detail: V4L2_FMT_FLAG_DYN_RESOLUTION is currently not recognized
> by v4l2-compliance, so it was left out for the test. However, it is
> present in the patch series.
> 
> The second patch has 3 "Alignment should match open parenthesis" lines
> where I preferred to keep them that way.
> 
> Thanks Stanimir for sharing your HDR file creation tools, this was very
> helpful :).

I tried to test this with a pending branch of GStreamer supporting
dynamic resolution changes. The even driver mechanism does not seem to
work with this driver. I've grepped the code, and don't see any places
were the event would be emitted.

Then I grepped, and it seems the driver accept source_change
subscription but does not set V4L2_FMT_FLAG_DYN_RESOLUTION. I believe
these two things are bit redundant and confusing, I'll fix the proposed
patch never the less, and see if that makes it work.

> 
> Maxime
> 
> # v4l2-compliance --stream-from-hdr test-25fps.h264.hdr -s250
> v4l2-compliance SHA: a162244d47d4bb01d0692da879dce5a070f118e7, 64 bits
> 
> Compliance test for meson-vdec device /dev/video0:
> 
> Driver Info:
> 	Driver name      : meson-vdec
> 	Card type        : Amlogic Video Decoder
> 	Bus info         : platform:meson-vdec
> 	Driver version   : 5.4.0
> 	Capabilities     : 0x84204000
> 		Video Memory-to-Memory Multiplanar
> 		Streaming
> 		Extended Pix Format
> 		Device Capabilities
> 	Device Caps      : 0x04204000
> 		Video Memory-to-Memory Multiplanar
> 		Streaming
> 		Extended Pix Format
> 	Detected Stateful Decoder
> 
> Required ioctls:
> 	test VIDIOC_QUERYCAP: OK
> 
> Allow for multiple opens:
> 	test second /dev/video0 open: OK
> 	test VIDIOC_QUERYCAP: OK
> 	test VIDIOC_G/S_PRIORITY: OK
> 	test for unlimited opens: OK
> 
> Debug ioctls:
> 	test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
> 	test VIDIOC_LOG_STATUS: OK (Not Supported)
> 
> Input ioctls:
> 	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
> 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> 	test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
> 	test VIDIOC_ENUMAUDIO: OK (Not Supported)
> 	test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
> 	test VIDIOC_G/S_AUDIO: OK (Not Supported)
> 	Inputs: 0 Audio Inputs: 0 Tuners: 0
> 
> Output ioctls:
> 	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
> 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> 	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
> 	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
> 	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
> 	Outputs: 0 Audio Outputs: 0 Modulators: 0
> 
> Input/Output configuration ioctls:
> 	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
> 	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
> 	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
> 	test VIDIOC_G/S_EDID: OK (Not Supported)
> 
> Control ioctls:
> 	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
> 	test VIDIOC_QUERYCTRL: OK
> 	test VIDIOC_G/S_CTRL: OK
> 	test VIDIOC_G/S/TRY_EXT_CTRLS: OK
> 	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
> 	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
> 	Standard Controls: 2 Private Controls: 0
> 
> Format ioctls:
> 	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
> 	test VIDIOC_G/S_PARM: OK (Not Supported)
> 	test VIDIOC_G_FBUF: OK (Not Supported)
> 	test VIDIOC_G_FMT: OK
> 	test VIDIOC_TRY_FMT: OK
> 	test VIDIOC_S_FMT: OK
> 	test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
> 	test Cropping: OK (Not Supported)
> 	test Composing: OK (Not Supported)
> 	test Scaling: OK
> 
> Codec ioctls:
> 	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
> 	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
> 	test VIDIOC_(TRY_)DECODER_CMD: OK
> 
> Buffer ioctls:
> 	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
> 	test VIDIOC_EXPBUF: OK
> 	test Requests: OK (Not Supported)
> 
> Test input 0:
> 
> Streaming ioctls:
> 	test read/write: OK (Not Supported)
> 	test blocking wait: OK
> 	Video Capture Multiplanar: Captured 250 buffers   
> 	test MMAP (select): OK
> 	Video Capture Multiplanar: Captured 250 buffers   
> 	test MMAP (epoll): OK
> 	test USERPTR (select): OK (Not Supported)
> 	test DMABUF: Cannot test, specify --expbuf-device
> 
> Total for meson-vdec device /dev/video0: 49, Succeeded: 49, Failed: 0, Warnings: 0
> 
> Maxime Jourdan (2):
>   media: meson: vdec: bring up to compliance
>   media: meson: vdec: add H.264 decoding support
> 
>  drivers/staging/media/meson/vdec/Makefile     |   2 +-
>  drivers/staging/media/meson/vdec/codec_h264.c | 482 ++++++++++++++++++
>  drivers/staging/media/meson/vdec/codec_h264.h |  14 +
>  drivers/staging/media/meson/vdec/esparser.c   |  34 +-
>  drivers/staging/media/meson/vdec/vdec.c       |  70 ++-
>  drivers/staging/media/meson/vdec/vdec.h       |  14 +-
>  .../staging/media/meson/vdec/vdec_helpers.c   |  85 ++-
>  .../staging/media/meson/vdec/vdec_helpers.h   |   6 +-
>  .../staging/media/meson/vdec/vdec_platform.c  |  43 ++
>  9 files changed, 654 insertions(+), 96 deletions(-)
>  create mode 100644 drivers/staging/media/meson/vdec/codec_h264.c
>  create mode 100644 drivers/staging/media/meson/vdec/codec_h264.h
> 

