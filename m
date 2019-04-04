Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE8EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EEEC2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfDDOnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:43:09 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44501 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfDDOnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:43:08 -0400
Received: by mail-ed1-f66.google.com with SMTP id d11so2436185edp.11;
        Thu, 04 Apr 2019 07:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nnmDJsRN//8GWWwn19teE/B0LTp6P8qcvFQeTuk4I9A=;
        b=HdkduZ+TlF4sUuZNmBt8uge84YyRjPK+mjqQA7I+7l3PcNRe33M0STGvUppzGcAiZ/
         KfYBifM3iU37kAvGztxcYiNX3yN4FIGFulG9ST58Dq4AnRVKwnttjFLwFt2n8zEexiFn
         lREUdR6zkp0JA5q1/XiwFOAewqJ7y08QnpY1wtDBa/QdW0jL5Ks7ypqObdlG17hgdXqZ
         lcIPLRmEr8g9B5yHgZ0JFsHs/9Hm4j0X8PPH4UGQyZ/b/1W9HgvaeIR40PzLE9WMIg7q
         YulAxs3oZzfdL6FVq4kmE2EBTfCBQ14GUhdutlI3YYSc8lgM4NJyxETL8TWMFfR+2daA
         cfRw==
X-Gm-Message-State: APjAAAW96YVjfALhWHrKqjh2+JYGDdLuN6wDE3XyMriv8bbbXRaELBOv
        RlFfirhU7c5uEILO19g4zZOA0EpMSHg=
X-Google-Smtp-Source: APXvYqy3LItIStSlX7rCnwClT5ha9JtGSFw/ghaV4Q7B0iUGl1h1AcJBAvqF/8cIKu5OQ0Plyy1yOw==
X-Received: by 2002:aa7:da51:: with SMTP id w17mr4075839eds.71.1554388985526;
        Thu, 04 Apr 2019 07:43:05 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id bz3sm3637088ejb.52.2019.04.04.07.43.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 07:43:03 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id r4so4126333wrq.8;
        Thu, 04 Apr 2019 07:43:03 -0700 (PDT)
X-Received: by 2002:a5d:4750:: with SMTP id o16mr2009265wrs.206.1554388982858;
 Thu, 04 Apr 2019 07:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.bfe197a82766125bea21dd26fd3de85893a921ac.1554380738.git-series.maxime.ripard@bootlin.com>
 <7cd913545cfc80fa9999839c62c4bf7b354a7904.1554380738.git-series.maxime.ripard@bootlin.com>
 <CAAFQd5ASMJL2_ovNeFOhCh2JoD86KMtV5XO+7OgM37ckxrxmfA@mail.gmail.com>
In-Reply-To: <CAAFQd5ASMJL2_ovNeFOhCh2JoD86KMtV5XO+7OgM37ckxrxmfA@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 4 Apr 2019 22:42:50 +0800
X-Gmail-Original-Message-ID: <CAGb2v642__AF3iHO+d9FKazJ4=uRAQSfxAN_uCUWagH6Jz2twQ@mail.gmail.com>
Message-ID: <CAGb2v642__AF3iHO+d9FKazJ4=uRAQSfxAN_uCUWagH6Jz2twQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v7 1/2] media: uapi: Add H264 low-level decoder API
 compound controls.
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Jens Kuske <jenskuske@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 8:54 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> Hi,
>
> On Thu, Apr 4, 2019 at 9:26 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > From: Pawel Osciak <posciak@chromium.org>
> >
> > Stateless video codecs will require both the H264 metadata and slices in
> > order to be able to decode frames.
> >
> > This introduces the definitions for a new pixel format for H264 slices that
> > have been parsed, as well as the structures used to pass the metadata from
> > the userspace to the kernel.
> >
> > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > Signed-off-by: Pawel Osciak <posciak@chromium.org>
> > Signed-off-by: Guenter Roeck <groeck@chromium.org>
> > Co-developed-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > ---
> >  Documentation/media/uapi/v4l/biblio.rst            |   9 +-
> >  Documentation/media/uapi/v4l/ext-ctrls-codec.rst   | 569 ++++++++++++++-
> >  Documentation/media/uapi/v4l/pixfmt-compressed.rst |  19 +-
> >  Documentation/media/uapi/v4l/vidioc-queryctrl.rst  |  30 +-
> >  Documentation/media/videodev2.h.rst.exceptions     |   5 +-
> >  drivers/media/v4l2-core/v4l2-ctrls.c               |  42 +-
> >  drivers/media/v4l2-core/v4l2-ioctl.c               |   1 +-
> >  include/media/h264-ctrls.h                         | 192 +++++-
> >  include/media/v4l2-ctrls.h                         |  13 +-
> >  include/uapi/linux/videodev2.h                     |   1 +-
> >  10 files changed, 880 insertions(+), 1 deletion(-)
> >  create mode 100644 include/media/h264-ctrls.h
> >
> > diff --git a/Documentation/media/uapi/v4l/biblio.rst b/Documentation/media/uapi/v4l/biblio.rst
> > index ec33768c055e..8f4eb8823d82 100644
> > --- a/Documentation/media/uapi/v4l/biblio.rst
> > +++ b/Documentation/media/uapi/v4l/biblio.rst
> > @@ -122,6 +122,15 @@ ITU BT.1119
> >
> >  :author:    International Telecommunication Union (http://www.itu.ch)
> >
> > +.. _h264:
> > +
> > +ITU-T Rec. H.264 Specification (04/2017 Edition)
> > +================================================
> > +
> > +:title:     ITU-T Recommendation H.264 "Advanced Video Coding for Generic Audiovisual Services"
> > +
> > +:author:    International Telecommunication Union (http://www.itu.ch)
> > +
> >  .. _jfif:
> >
> >  JFIF
> > diff --git a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst b/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
> > index 67a122339c0e..1285bfec7d3d 100644
> > --- a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
> > +++ b/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
> > @@ -1371,6 +1371,575 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_type -
> >        - Layer number
> >
> >
> > +.. _v4l2-mpeg-h264:
> > +
> > +``V4L2_CID_MPEG_VIDEO_H264_SPS (struct)``
> > +    Specifies the sequence parameter set (as extracted from the
> > +    bitstream) for the associated H264 slice data. This includes the
> > +    necessary parameters for configuring a stateless hardware decoding
> > +    pipeline for H264. The bitstream parameters are defined according
> > +    to :ref:`h264`, section 7.4.2.1.1 "Sequence Parameter Set Data
> > +    Semantics". For further documentation, refer to the above
> > +    specification, unless there is an explicit comment stating
> > +    otherwise.
> > +
> > +    .. note::
> > +
> > +       This compound control is not yet part of the public kernel API and
> > +       it is expected to change.
> > +
> > +.. c:type:: v4l2_ctrl_h264_sps
> > +
> > +.. cssclass:: longtable
> > +
> > +.. flat-table:: struct v4l2_ctrl_h264_sps
> > +    :header-rows:  0
> > +    :stub-columns: 0
> > +    :widths:       1 1 2
> > +
> > +    * - __u8
> > +      - ``profile_idc``
> > +      -
> > +    * - __u8
> > +      - ``constraint_set_flags``
> > +      - See :ref:`Sequence Parameter Set Constraints Set Flags <h264_sps_constraints_set_flags>`
> > +    * - __u8
> > +      - ``level_idc``
> > +      -
> > +    * - __u8
> > +      - ``seq_parameter_set_id``
> > +      -
> > +    * - __u8
> > +      - ``chroma_format_idc``
> > +      -
> > +    * - __u8
> > +      - ``bit_depth_luma_minus8``
> > +      -
> > +    * - __u8
> > +      - ``bit_depth_chroma_minus8``
> > +      -
> > +    * - __u8
> > +      - ``log2_max_frame_num_minus4``
> > +      -
> > +    * - __u8
> > +      - ``pic_order_cnt_type``
> > +      -
> > +    * - __u8
> > +      - ``log2_max_pic_order_cnt_lsb_minus4``
> > +      -
> > +    * - __u8
> > +      - ``max_num_ref_frames``
> > +      -
> > +    * - __u8
> > +      - ``num_ref_frames_in_pic_order_cnt_cycle``
> > +      -
> > +    * - __s32
> > +      - ``offset_for_ref_frame[255]``
> > +      -
> > +    * - __s32
> > +      - ``offset_for_non_ref_pic``
> > +      -
> > +    * - __s32
> > +      - ``offset_for_top_to_bottom_field``
> > +      -
> > +    * - __u16
> > +      - ``pic_width_in_mbs_minus1``
> > +      -
> > +    * - __u16
> > +      - ``pic_height_in_map_units_minus1``
> > +      -
>
> We recently had some reflection with Alex that this is redundant with
> the width and height in the OUTPUT format. It may also apply to some
> other fields in these structs. I feel like they should be removed and
> passed via corresponding generic V4L2 properties - format, selection,
> etc.
>
> The same problem is also present in the MPEG2 controls. In fact, there
> was a patch already which used some fields from the controls to
> calculate the destination buffer strides, rather than bytesperline in
> the format.
>
> Since we're in staging, it could be done with a follow-up patch, though.

Just my two cents. I played with some codecs a while back. IIRC some
specify a "codec" size in addition to the actual picture size, like
when the encoder does padding to fit the requirements of the codec
(spec). Is this needed anywhere?

ChenYu
