Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA82C10F0F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91ADF217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbfDEK7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 06:59:34 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33973 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730546AbfDEK7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 06:59:33 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hCMZH-0006bS-94; Fri, 05 Apr 2019 12:59:31 +0200
Message-ID: <1554461965.3060.5.camel@pengutronix.de>
Subject: Re: [PATCH v3 1/2] media: docs-rst: Document memory-to-memory video
 decoder interface
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Kamil Debski <kamil@wypas.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jeongtae Park <jtp.park@samsung.com>,
        Tiffany Lin =?UTF-8?Q?=28=E6=9E=97=E6=85=A7=E7=8F=8A=29?= 
        <tiffany.lin@mediatek.com>,
        Andrew-CT Chen =?UTF-8?Q?=28=E9=99=B3=E6=99=BA=E8=BF=AA=29?= 
        <andrew-ct.chen@mediatek.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Date:   Fri, 05 Apr 2019 12:59:25 +0200
In-Reply-To: <20190124100419.26492-2-tfiga@chromium.org>
References: <20190124100419.26492-1-tfiga@chromium.org>
         <20190124100419.26492-2-tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-24 at 19:04 +0900, Tomasz Figa wrote:
> Due to complexity of the video decoding process, the V4L2 drivers of
> stateful decoder hardware require specific sequences of V4L2 API calls
> to be followed. These include capability enumeration, initialization,
> decoding, seek, pause, dynamic resolution change, drain and end of
> stream.
> 
> Specifics of the above have been discussed during Media Workshops at
> LinuxCon Europe 2012 in Barcelona and then later Embedded Linux
> Conference Europe 2014 in Düsseldorf. The de facto Codec API that
> originated at those events was later implemented by the drivers we already
> have merged in mainline, such as s5p-mfc or coda.
> 
> The only thing missing was the real specification included as a part of
> Linux Media documentation. Fix it now and document the decoder part of
> the Codec API.
> 
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> ---
>  Documentation/media/uapi/v4l/dev-decoder.rst  | 1076 +++++++++++++++++
>  Documentation/media/uapi/v4l/dev-mem2mem.rst  |    5 +
>  Documentation/media/uapi/v4l/pixfmt-v4l2.rst  |    5 +
>  Documentation/media/uapi/v4l/v4l2.rst         |   10 +-
>  .../media/uapi/v4l/vidioc-decoder-cmd.rst     |   40 +-
>  Documentation/media/uapi/v4l/vidioc-g-fmt.rst |   14 +
>  6 files changed, 1135 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/media/uapi/v4l/dev-decoder.rst
> 
> diff --git a/Documentation/media/uapi/v4l/dev-decoder.rst b/Documentation/media/uapi/v4l/dev-decoder.rst
> new file mode 100644
> index 000000000000..b7db2352ad41
> --- /dev/null
> +++ b/Documentation/media/uapi/v4l/dev-decoder.rst
> @@ -0,0 +1,1076 @@
> +.. -*- coding: utf-8; mode: rst -*-
> +
> +.. _decoder:
> +
> +*************************************************
> +Memory-to-memory Stateful Video Decoder Interface
> +*************************************************
> +
[...]
> +
> +Drain
> +=====
> +
[...]
> +
> +3. Once all the ``OUTPUT`` buffers queued before the ``V4L2_DEC_CMD_STOP`` call
> +   are dequeued and the last ``CAPTURE`` buffer is dequeued, the decoder is
> +   stopped and it will accept, but not process, any newly queued ``OUTPUT``
> +   buffers until the client issues any of the following operations:
> +
[...]
> +
> +.. note::
> +
> +   Once the drain sequence is initiated, the client needs to drive it to
> +   completion, as described by the steps above, unless it aborts the process by
> +   issuing :c:func:`VIDIOC_STREAMOFF` on any of the ``OUTPUT`` or ``CAPTURE``
> +   queues.  The client is not allowed to issue ``V4L2_DEC_CMD_START`` or
> +   ``V4L2_DEC_CMD_STOP`` again while the drain sequence is in progress and they
> +   will fail with -EBUSY error code if attempted.

Should the V4L2_DEC_CMD_STOP documentation in
Documentation/media/uapi/v4l/vidioc-decoder-cmd.rst:

  * - ``V4L2_DEC_CMD_STOP``
    - 1
    - Stop the decoder. When the decoder is already stopped, this
      command does nothing.

be updated to mention that for mem2mem decoders this not only does
nothing, but returns an -EBUSY error return value?

Also, if V4L2_DEC_CMD_STOP_IMMEDIATELY is set, should the decoder drop
all pending buffers and signal EOS immediately? Should this be mentioned
here?

> +   Although mandatory, the availability of decoder commands may be queried
> +   using :c:func:`VIDIOC_TRY_DECODER_CMD`.

Do the TRY_DECODER_CMD also return -EBUSY during the draining phase?

regards
Philipp
