Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4C4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2742B2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FPK+hTHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbfDDNBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:01:05 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40845 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfDDNBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:01:05 -0400
Received: by mail-ot1-f67.google.com with SMTP id t8so2219834otp.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 06:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NnoQXOk98mUw/zU+LHAe8k8yy8pprlhhfEKmVQVVBjo=;
        b=FPK+hTHmgyZYalgoT9WI9CBxCJQY5Ja9ggM8B/WRJVVqJBb8BdFZJxJLCLsZsFuxrU
         D7gkiuLpVMaaA7fVjG2Z2WWQMITm+x4L93ICOFO5aukSiV5sUmxerlfOc4c7usbbSXDs
         Ae3tGTf9qaaZsk2xRupqXuXb9pKcJIkQBey7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NnoQXOk98mUw/zU+LHAe8k8yy8pprlhhfEKmVQVVBjo=;
        b=diKbsC4osn1dNelHUZISkOrhWbd6LV8GXo+AwMYapNAm8kdgLdl6uDKSdWtREBCOTT
         jv0oa2Wst7T/pETKWMAcBck9wPiobIiwZiDPnDh/ZRQ1T0u48LGGYvUEfMpkFD4Uflzo
         qjvIDysG2Jm9TWS9kGzqTAz3hsoTwV9ATYBaHn8YalZ6WprfkJI3YzBrAaKkTANyjg54
         tEmNLhLGsBfGxolqRvuWj6j4bSScPC34aj/36QHRTsFl3lhNlqztR58LfJQFA7RDgcJB
         mbZpU2HV7aPQAUA0+q98UyJfClH3hEoA4Ecy57x8oCuZL07dmqRYdA9oZu/qfzbBO8PZ
         H0MA==
X-Gm-Message-State: APjAAAVxpOlNZ4/FdZy2mpm0TZt1Uvi/X8lktKLVWxsMWBNJmX3a5guR
        iVTJfL+a3AYOh6GI2nN/A0Uk+uNamhY=
X-Google-Smtp-Source: APXvYqz/ICR/mh4xJlpNGyQI3v7ntWRtvBxLYuVrHTJmoeu+wtA6ghHZGi7tAaf7jyR7F/CttJmNlg==
X-Received: by 2002:a9d:5d0b:: with SMTP id b11mr4144739oti.80.1554382864125;
        Thu, 04 Apr 2019 06:01:04 -0700 (PDT)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id a198sm7913763oib.19.2019.04.04.06.01.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 06:01:03 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id t8so2219779otp.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 06:01:03 -0700 (PDT)
X-Received: by 2002:a9d:7749:: with SMTP id t9mr3886832otl.229.1554382482715;
 Thu, 04 Apr 2019 05:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.bfe197a82766125bea21dd26fd3de85893a921ac.1554380738.git-series.maxime.ripard@bootlin.com>
 <7cd913545cfc80fa9999839c62c4bf7b354a7904.1554380738.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <7cd913545cfc80fa9999839c62c4bf7b354a7904.1554380738.git-series.maxime.ripard@bootlin.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 4 Apr 2019 21:54:30 +0900
X-Gmail-Original-Message-ID: <CAAFQd5ASMJL2_ovNeFOhCh2JoD86KMtV5XO+7OgM37ckxrxmfA@mail.gmail.com>
Message-ID: <CAAFQd5ASMJL2_ovNeFOhCh2JoD86KMtV5XO+7OgM37ckxrxmfA@mail.gmail.com>
Subject: Re: [PATCH RESEND v7 1/2] media: uapi: Add H264 low-level decoder API
 compound controls.
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Alexandre Courbot <acourbot@chromium.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        jenskuske@gmail.com, Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-sunxi@googlegroups.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 4, 2019 at 9:26 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> From: Pawel Osciak <posciak@chromium.org>
>
> Stateless video codecs will require both the H264 metadata and slices in
> order to be able to decode frames.
>
> This introduces the definitions for a new pixel format for H264 slices that
> have been parsed, as well as the structures used to pass the metadata from
> the userspace to the kernel.
>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Pawel Osciak <posciak@chromium.org>
> Signed-off-by: Guenter Roeck <groeck@chromium.org>
> Co-developed-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  Documentation/media/uapi/v4l/biblio.rst            |   9 +-
>  Documentation/media/uapi/v4l/ext-ctrls-codec.rst   | 569 ++++++++++++++-
>  Documentation/media/uapi/v4l/pixfmt-compressed.rst |  19 +-
>  Documentation/media/uapi/v4l/vidioc-queryctrl.rst  |  30 +-
>  Documentation/media/videodev2.h.rst.exceptions     |   5 +-
>  drivers/media/v4l2-core/v4l2-ctrls.c               |  42 +-
>  drivers/media/v4l2-core/v4l2-ioctl.c               |   1 +-
>  include/media/h264-ctrls.h                         | 192 +++++-
>  include/media/v4l2-ctrls.h                         |  13 +-
>  include/uapi/linux/videodev2.h                     |   1 +-
>  10 files changed, 880 insertions(+), 1 deletion(-)
>  create mode 100644 include/media/h264-ctrls.h
>
> diff --git a/Documentation/media/uapi/v4l/biblio.rst b/Documentation/media/uapi/v4l/biblio.rst
> index ec33768c055e..8f4eb8823d82 100644
> --- a/Documentation/media/uapi/v4l/biblio.rst
> +++ b/Documentation/media/uapi/v4l/biblio.rst
> @@ -122,6 +122,15 @@ ITU BT.1119
>
>  :author:    International Telecommunication Union (http://www.itu.ch)
>
> +.. _h264:
> +
> +ITU-T Rec. H.264 Specification (04/2017 Edition)
> +================================================
> +
> +:title:     ITU-T Recommendation H.264 "Advanced Video Coding for Generic Audiovisual Services"
> +
> +:author:    International Telecommunication Union (http://www.itu.ch)
> +
>  .. _jfif:
>
>  JFIF
> diff --git a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst b/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
> index 67a122339c0e..1285bfec7d3d 100644
> --- a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
> @@ -1371,6 +1371,575 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_type -
>        - Layer number
>
>
> +.. _v4l2-mpeg-h264:
> +
> +``V4L2_CID_MPEG_VIDEO_H264_SPS (struct)``
> +    Specifies the sequence parameter set (as extracted from the
> +    bitstream) for the associated H264 slice data. This includes the
> +    necessary parameters for configuring a stateless hardware decoding
> +    pipeline for H264. The bitstream parameters are defined according
> +    to :ref:`h264`, section 7.4.2.1.1 "Sequence Parameter Set Data
> +    Semantics". For further documentation, refer to the above
> +    specification, unless there is an explicit comment stating
> +    otherwise.
> +
> +    .. note::
> +
> +       This compound control is not yet part of the public kernel API and
> +       it is expected to change.
> +
> +.. c:type:: v4l2_ctrl_h264_sps
> +
> +.. cssclass:: longtable
> +
> +.. flat-table:: struct v4l2_ctrl_h264_sps
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - __u8
> +      - ``profile_idc``
> +      -
> +    * - __u8
> +      - ``constraint_set_flags``
> +      - See :ref:`Sequence Parameter Set Constraints Set Flags <h264_sps_constraints_set_flags>`
> +    * - __u8
> +      - ``level_idc``
> +      -
> +    * - __u8
> +      - ``seq_parameter_set_id``
> +      -
> +    * - __u8
> +      - ``chroma_format_idc``
> +      -
> +    * - __u8
> +      - ``bit_depth_luma_minus8``
> +      -
> +    * - __u8
> +      - ``bit_depth_chroma_minus8``
> +      -
> +    * - __u8
> +      - ``log2_max_frame_num_minus4``
> +      -
> +    * - __u8
> +      - ``pic_order_cnt_type``
> +      -
> +    * - __u8
> +      - ``log2_max_pic_order_cnt_lsb_minus4``
> +      -
> +    * - __u8
> +      - ``max_num_ref_frames``
> +      -
> +    * - __u8
> +      - ``num_ref_frames_in_pic_order_cnt_cycle``
> +      -
> +    * - __s32
> +      - ``offset_for_ref_frame[255]``
> +      -
> +    * - __s32
> +      - ``offset_for_non_ref_pic``
> +      -
> +    * - __s32
> +      - ``offset_for_top_to_bottom_field``
> +      -
> +    * - __u16
> +      - ``pic_width_in_mbs_minus1``
> +      -
> +    * - __u16
> +      - ``pic_height_in_map_units_minus1``
> +      -

We recently had some reflection with Alex that this is redundant with
the width and height in the OUTPUT format. It may also apply to some
other fields in these structs. I feel like they should be removed and
passed via corresponding generic V4L2 properties - format, selection,
etc.

The same problem is also present in the MPEG2 controls. In fact, there
was a patch already which used some fields from the controls to
calculate the destination buffer strides, rather than bytesperline in
the format.

Since we're in staging, it could be done with a follow-up patch, though.

Best regards,
Tomasz
