Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E61C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 07:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66A0206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 07:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WS4m+yfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfJMHaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 03:30:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52343 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbfJMHaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 03:30:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id r19so14086398wmh.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 00:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cAZyc87LrJA9irWHCTAXQtd3veb+dxG3I+9z8/PQGys=;
        b=WS4m+yfZIoG3gZONTlMeU8FGiZ5EQV8M1nCBin5qyMWka6+rQLioxUVP8X5HRI+hHM
         i3CXkNwqudzbrbl49JdvcC7UaFtP6Dvp3THn06vnNfngI1nfC9IONbe7wbUB+45ntu4x
         IraI6XonJKqkMb694vYK+VIsjsqCDgq/woWnWP4a6sKM/fiZfPQBqixconZ+EeuhpCGR
         BICt47QAlvVlFfdAWx//JfoViQBivSK5hd6zICl6eKs7HkRq0wmIKRIz03HhOFf6P5W5
         ORh33mtVf3SKjKrgWoN8cbQvkF/LvJea1v8Z2qoKu9vo22TGEqWRmtr5uUYpul2Qeaka
         tJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cAZyc87LrJA9irWHCTAXQtd3veb+dxG3I+9z8/PQGys=;
        b=QG4mCUgOKbiH0SfnKHnlvrG8bAeXQh7GA7vgyQQmacFz/74LSL8T7cYfDSBpp/MBaW
         5o+tpHMiV8ZIfivSFu6lQrmFCVbNDMrDIQkNpM+MrwKZ2h+isc5wSBKBRvDQvHpvhc3N
         DqoxehWO/9Y3Zq+pTXaSTSEFpARXkORAQDsfSeZxNySZumzChmUl7mhraQI1p+l3mHnZ
         bw0InzaK3d1pRDAfyKeVEwcm5Y+f3q+6hme7osrUg234EMz7DzLUqIa2DlK5nTvFHEII
         stx/V7CWBYosdu1EMVAoTuU/rPQ+S09UAXTQ9qLYgjOP+BhnUc6w6JFHI5zO1OIrMFVm
         ay3A==
X-Gm-Message-State: APjAAAXlW6snWXU3MlkKCuRQYVDACNTTQUfs4sHzqY3v460sSScBeZZM
        S3ldbqdc663HBJn+Xq0Cim3W9Q==
X-Google-Smtp-Source: APXvYqznGkcnxX5HZ0Z/lymZfH00qLp/B92yIwvzKY6v3GohleajPrTRI0P1LW5giqn8pJ4bmvjq0w==
X-Received: by 2002:a1c:9894:: with SMTP id a142mr9968853wme.70.1570951813802;
        Sun, 13 Oct 2019 00:30:13 -0700 (PDT)
Received: from [192.168.0.31] (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id 59sm29656866wrc.23.2019.10.13.00.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Oct 2019 00:30:13 -0700 (PDT)
Subject: Re: [PATCH 0/2] media: meson: vdec: Add compliant H264 support
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20191007145909.29979-1-mjourdan@baylibre.com>
 <bf072b400ce7d5a9f52cf7ca7ac0b36b22fff24f.camel@ndufresne.ca>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Message-ID: <a00ee3d3-f771-efd8-a864-5dcffbad83bd@baylibre.com>
Date:   Sun, 13 Oct 2019 09:30:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bf072b400ce7d5a9f52cf7ca7ac0b36b22fff24f.camel@ndufresne.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,
On 13/10/2019 03:08, Nicolas Dufresne wrote:
> Le lundi 07 octobre 2019 à 16:59 +0200, Maxime Jourdan a écrit :
>> Hello,
>>
>> This patch series aims to bring H.264 support as well as compliance update
>> to the amlogic stateful video decoder driver.
>>
>> There is 1 issue that remains currently:
>>
>>   - The following codepath had to be commented out from v4l2-compliance as
>> it led to stalling:
>>
>> if (node->codec_mask & STATEFUL_DECODER) {
>> 	struct v4l2_decoder_cmd cmd;
>> 	buffer buf_cap(m2m_q);
>>
>> 	memset(&cmd, 0, sizeof(cmd));
>> 	cmd.cmd = V4L2_DEC_CMD_STOP;
>>
>> 	/* No buffers are queued, call STREAMON, then STOP */
>> 	fail_on_test(node->streamon(q.g_type()));
>> 	fail_on_test(node->streamon(m2m_q.g_type()));
>> 	fail_on_test(doioctl(node, VIDIOC_DECODER_CMD, &cmd));
>>
>> 	fail_on_test(buf_cap.querybuf(node, 0));
>> 	fail_on_test(buf_cap.qbuf(node));
>> 	fail_on_test(buf_cap.dqbuf(node));
>> 	fail_on_test(!(buf_cap.g_flags() & V4L2_BUF_FLAG_LAST));
>> 	for (unsigned p = 0; p < buf_cap.g_num_planes(); p++)
>> 		fail_on_test(buf_cap.g_bytesused(p));
>> 	fail_on_test(node->streamoff(q.g_type()));
>> 	fail_on_test(node->streamoff(m2m_q.g_type()));
>>
>> 	/* Call STREAMON, queue one CAPTURE buffer, then STOP */
>> 	fail_on_test(node->streamon(q.g_type()));
>> 	fail_on_test(node->streamon(m2m_q.g_type()));
>> 	fail_on_test(buf_cap.querybuf(node, 0));
>> 	fail_on_test(buf_cap.qbuf(node));
>> 	fail_on_test(doioctl(node, VIDIOC_DECODER_CMD, &cmd));
>>
>> 	fail_on_test(buf_cap.dqbuf(node));
>> 	fail_on_test(!(buf_cap.g_flags() & V4L2_BUF_FLAG_LAST));
>> 	for (unsigned p = 0; p < buf_cap.g_num_planes(); p++)
>> 		fail_on_test(buf_cap.g_bytesused(p));
>> 	fail_on_test(node->streamoff(q.g_type()));
>> 	fail_on_test(node->streamoff(m2m_q.g_type()));
>> }
>>
>> The reason for this is because the driver has a limitation where all
>> capturebuffers must be queued to the driver before STREAMON is effective.
>> The firmware needs to know in advance what all the buffers are before
>> starting to decode.
>> This limitation is enforced via q->min_buffers_needed.
>> As such, in this compliance codepath, STREAMON is never actually called
>> driver-side and there is a stall on fail_on_test(buf_cap.dqbuf(node));
>>
>>
>> One last detail: V4L2_FMT_FLAG_DYN_RESOLUTION is currently not recognized
>> by v4l2-compliance, so it was left out for the test. However, it is
>> present in the patch series.
>>
>> The second patch has 3 "Alignment should match open parenthesis" lines
>> where I preferred to keep them that way.
>>
>> Thanks Stanimir for sharing your HDR file creation tools, this was very
>> helpful :).
> 
> I tried to test this with a pending branch of GStreamer supporting
> dynamic resolution changes. The even driver mechanism does not seem to
> work with this driver. I've grepped the code, and don't see any places
> were the event would be emitted.

Thanks for taking the time to test!

The event is sent in vdec_helpers.c:434

void amvdec_src_change(struct amvdec_session *sess, u32 width,
		       u32 height, u32 dpb_size)
{
	static const struct v4l2_event ev = {
		.type = V4L2_EVENT_SOURCE_CHANGE,
		.u.src_change.changes = V4L2_EVENT_SRC_CH_RESOLUTION };

[..]

	dev_dbg(sess->core->dev, "Res. changed (%ux%u), DPB size %u\n",
		width, height, dpb_size);
	v4l2_event_queue_fh(&sess->fh, &ev);
}

> 
> Then I grepped, and it seems the driver accept source_change
> subscription but does not set V4L2_FMT_FLAG_DYN_RESOLUTION. I believe
> these two things are bit redundant and confusing, I'll fix the proposed
> patch never the less, and see if that makes it work.
It is set for H.264 if you look at the second patch of the series adding 
support for it.

{
	.pixfmt = V4L2_PIX_FMT_H264,
[..]
	.flags = V4L2_FMT_FLAG_COMPRESSED |
		 V4L2_FMT_FLAG_DYN_RESOLUTION,
},

The reason for this flag is because not all formats within a decoder 
driver may support dynamic resolution.

Your 2 points make me wonder if you used the staging driver + this patch 
series, or if you used something else ? The various branches I have on 
github are not up to date with all the compliance work.

> 
>>
>> Maxime
>>
>> # v4l2-compliance --stream-from-hdr test-25fps.h264.hdr -s250
>> v4l2-compliance SHA: a162244d47d4bb01d0692da879dce5a070f118e7, 64 bits
>>
>> Compliance test for meson-vdec device /dev/video0:
>>
>> Driver Info:
>> 	Driver name      : meson-vdec
>> 	Card type        : Amlogic Video Decoder
>> 	Bus info         : platform:meson-vdec
>> 	Driver version   : 5.4.0
>> 	Capabilities     : 0x84204000
>> 		Video Memory-to-Memory Multiplanar
>> 		Streaming
>> 		Extended Pix Format
>> 		Device Capabilities
>> 	Device Caps      : 0x04204000
>> 		Video Memory-to-Memory Multiplanar
>> 		Streaming
>> 		Extended Pix Format
>> 	Detected Stateful Decoder
>>
>> Required ioctls:
>> 	test VIDIOC_QUERYCAP: OK
>>
>> Allow for multiple opens:
>> 	test second /dev/video0 open: OK
>> 	test VIDIOC_QUERYCAP: OK
>> 	test VIDIOC_G/S_PRIORITY: OK
>> 	test for unlimited opens: OK
>>
>> Debug ioctls:
>> 	test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
>> 	test VIDIOC_LOG_STATUS: OK (Not Supported)
>>
>> Input ioctls:
>> 	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
>> 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>> 	test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
>> 	test VIDIOC_ENUMAUDIO: OK (Not Supported)
>> 	test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
>> 	test VIDIOC_G/S_AUDIO: OK (Not Supported)
>> 	Inputs: 0 Audio Inputs: 0 Tuners: 0
>>
>> Output ioctls:
>> 	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
>> 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>> 	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
>> 	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
>> 	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
>> 	Outputs: 0 Audio Outputs: 0 Modulators: 0
>>
>> Input/Output configuration ioctls:
>> 	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
>> 	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
>> 	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
>> 	test VIDIOC_G/S_EDID: OK (Not Supported)
>>
>> Control ioctls:
>> 	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
>> 	test VIDIOC_QUERYCTRL: OK
>> 	test VIDIOC_G/S_CTRL: OK
>> 	test VIDIOC_G/S/TRY_EXT_CTRLS: OK
>> 	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
>> 	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
>> 	Standard Controls: 2 Private Controls: 0
>>
>> Format ioctls:
>> 	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
>> 	test VIDIOC_G/S_PARM: OK (Not Supported)
>> 	test VIDIOC_G_FBUF: OK (Not Supported)
>> 	test VIDIOC_G_FMT: OK
>> 	test VIDIOC_TRY_FMT: OK
>> 	test VIDIOC_S_FMT: OK
>> 	test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
>> 	test Cropping: OK (Not Supported)
>> 	test Composing: OK (Not Supported)
>> 	test Scaling: OK
>>
>> Codec ioctls:
>> 	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
>> 	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
>> 	test VIDIOC_(TRY_)DECODER_CMD: OK
>>
>> Buffer ioctls:
>> 	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
>> 	test VIDIOC_EXPBUF: OK
>> 	test Requests: OK (Not Supported)
>>
>> Test input 0:
>>
>> Streaming ioctls:
>> 	test read/write: OK (Not Supported)
>> 	test blocking wait: OK
>> 	Video Capture Multiplanar: Captured 250 buffers
>> 	test MMAP (select): OK
>> 	Video Capture Multiplanar: Captured 250 buffers
>> 	test MMAP (epoll): OK
>> 	test USERPTR (select): OK (Not Supported)
>> 	test DMABUF: Cannot test, specify --expbuf-device
>>
>> Total for meson-vdec device /dev/video0: 49, Succeeded: 49, Failed: 0, Warnings: 0
>>
>> Maxime Jourdan (2):
>>    media: meson: vdec: bring up to compliance
>>    media: meson: vdec: add H.264 decoding support
>>
>>   drivers/staging/media/meson/vdec/Makefile     |   2 +-
>>   drivers/staging/media/meson/vdec/codec_h264.c | 482 ++++++++++++++++++
>>   drivers/staging/media/meson/vdec/codec_h264.h |  14 +
>>   drivers/staging/media/meson/vdec/esparser.c   |  34 +-
>>   drivers/staging/media/meson/vdec/vdec.c       |  70 ++-
>>   drivers/staging/media/meson/vdec/vdec.h       |  14 +-
>>   .../staging/media/meson/vdec/vdec_helpers.c   |  85 ++-
>>   .../staging/media/meson/vdec/vdec_helpers.h   |   6 +-
>>   .../staging/media/meson/vdec/vdec_platform.c  |  43 ++
>>   9 files changed, 654 insertions(+), 96 deletions(-)
>>   create mode 100644 drivers/staging/media/meson/vdec/codec_h264.c
>>   create mode 100644 drivers/staging/media/meson/vdec/codec_h264.h
>>
> 

