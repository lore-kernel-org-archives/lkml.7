Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF4ECA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE2D2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfJaKVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 06:21:02 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46156 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfJaKVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:21:02 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 47A4728EE37;
        Thu, 31 Oct 2019 10:21:00 +0000 (GMT)
Date:   Thu, 31 Oct 2019 11:20:56 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Jonas Karlman <jonas@kwiboo.se>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v2 09/10] media: uapi: h264: Add DPB entry field reference
 flags
Message-ID: <20191031112056.3442d6ac@collabora.com>
In-Reply-To: <HE1PR06MB401142C1E45B302094AD1149AC610@HE1PR06MB4011.eurprd06.prod.outlook.com>
References: <HE1PR06MB401108289F09802C261374F8AC610@HE1PR06MB4011.eurprd06.prod.outlook.com>
        <20191029012550.24628-1-jonas@kwiboo.se>
        <HE1PR06MB401142C1E45B302094AD1149AC610@HE1PR06MB4011.eurprd06.prod.outlook.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019 01:26:01 +0000
Jonas Karlman <jonas@kwiboo.se> wrote:

> Add DPB entry flags to help indicate when a reference frame is a field picture
> and how the DPB entry is referenced, top or bottom field or full frame.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  Documentation/media/uapi/v4l/ext-ctrls-codec.rst | 12 ++++++++++++
>  include/media/h264-ctrls.h                       |  4 ++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst b/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
> index 28313c0f4e7c..d472a54d1c4d 100644
> --- a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
> @@ -2028,6 +2028,18 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_type -
>      * - ``V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM``
>        - 0x00000004
>        - The DPB entry is a long term reference frame
> +    * - ``V4L2_H264_DPB_ENTRY_FLAG_FIELD_PICTURE``
> +      - 0x00000008
> +      - The DPB entry is a field picture
> +    * - ``V4L2_H264_DPB_ENTRY_FLAG_REF_TOP``
> +      - 0x00000010
> +      - The DPB entry is a top field reference
> +    * - ``V4L2_H264_DPB_ENTRY_FLAG_REF_BOTTOM``
> +      - 0x00000020
> +      - The DPB entry is a bottom field reference
> +    * - ``V4L2_H264_DPB_ENTRY_FLAG_REF_FRAME``
> +      - 0x00000030
> +      - The DPB entry is a reference frame
>  
>  ``V4L2_CID_MPEG_VIDEO_H264_DECODE_MODE (enum)``
>      Specifies the decoding mode to use. Currently exposes slice-based and
> diff --git a/include/media/h264-ctrls.h b/include/media/h264-ctrls.h
> index e877bf1d537c..76020ebd1e6c 100644
> --- a/include/media/h264-ctrls.h
> +++ b/include/media/h264-ctrls.h
> @@ -185,6 +185,10 @@ struct v4l2_ctrl_h264_slice_params {
>  #define V4L2_H264_DPB_ENTRY_FLAG_VALID		0x01
>  #define V4L2_H264_DPB_ENTRY_FLAG_ACTIVE		0x02
>  #define V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM	0x04
> +#define V4L2_H264_DPB_ENTRY_FLAG_FIELD_PICTURE	0x08
> +#define V4L2_H264_DPB_ENTRY_FLAG_REF_TOP	0x10
> +#define V4L2_H264_DPB_ENTRY_FLAG_REF_BOTTOM	0x20
> +#define V4L2_H264_DPB_ENTRY_FLAG_REF_FRAME	0x30

I don't remember all the details, but do we really need 3 flags?
Maybe I'm wrong, but it looks like the following combination doesn't
make sense:

- FIELD_PICTURE + REF_FRAME: if it's a full frame ref it should
  contain both top and bottom fields right, so it's no longer a
  FIELD_PICTURE, is it?

Can't we just have 2 flags?

FIELD_PICTURE		0x08
FIELD_REF_TOP		0x10 (meaning that FIELD_REF_BOTTOM is
			      0x00)

and then have the following combinations:

top field ref => FIELD_PICTURE | FIELD_REF_TOP
bottom field ref => FIELD_PICTURE
full frame ref => 0x0

>  
>  struct v4l2_h264_dpb_entry {
>  	__u64 reference_ts;

