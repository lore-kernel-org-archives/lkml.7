Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92410C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F98621850
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NWNJH4YR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfC2DOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 23:14:39 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41678 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfC2DOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 23:14:39 -0400
Received: by mail-ed1-f66.google.com with SMTP id a25so771285edc.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 20:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GF0t9hjBANZK/xL8IFoFlLxTHyDCRG1cX0E1XVftfCQ=;
        b=NWNJH4YRLn73WxJ+OMF8BbCZOXWvt04LUrI7GvgJQAiiz+pCZ+ELk3zjogqnffOsng
         RJeI/aG/nHAJeAHvygBTARy1UxBpiGjWjamgS9Mggq7SrBD48CDGR8fSPgpw7jxzTEOt
         SPcQUDG78b4LFz5xok5ej6XFjhpqih1J1nF3WZpUFDphzR7vMd7DRWqetDEuZEWu+2qe
         e34i795II4EoD/BXw7NbQ8yHgUHsLrH3Knf+OdxTKQjxUjkkBzEFJIKA45u6Wb6G9NXF
         v39OvnUheamlRjW/yJDaOkmuNHsUZiJ8TxhspF9BNd4tqy+CwpkG1rXFJc67w5vbR/gV
         vkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GF0t9hjBANZK/xL8IFoFlLxTHyDCRG1cX0E1XVftfCQ=;
        b=uT7E5/tjLjfoXXDNbjfXbeJsWijlFi6G81/TcpgOHnlvO3zOZxkLLzcAcZPMVy6oco
         kFzn//V/O9BdNJctzeXaqXdvzfTga2ykut0WjCIbxMdxK56a02xk8WamVNwgC0vWiZcV
         UPPFaXmPxmcqRr9X0Tmw+ULk2YIeOvR/tMb67KiI7iq9qu7vG3BOg4Tk9YNbB1njoGPD
         A59qVobDWqlHPpNIHSqJiHXm6jGHX6mBM/QalTVpUh+crctXNcC2wEzBDqqJEEDheuGC
         lFcnVQAor8O2Bp7RoIlfZW8WVw3W4AN678HnLEOR949ZWJ3z6IjNGFdxICaEATw7SWwA
         wk8g==
X-Gm-Message-State: APjAAAXZcsa+J0t4iK28uI/5QEUE4FYLQuAC91OQHne/9n/QuGm3WP9J
        SzbDcvhR8ISrxMPCEXsQDIrzvaLdeTETJZyl3zO8yg==
X-Google-Smtp-Source: APXvYqxidO348/jxHH+oHL4dd0hOqwOMYmxL2eq/hxJ1mVr6dbVOfyP8J4L+R96YxY+aX8YrePqvNhyjy5abQ4rfL34=
X-Received: by 2002:a17:906:c793:: with SMTP id cw19mr585981ejb.86.1553829277105;
 Thu, 28 Mar 2019 20:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190128072948.45788-1-linfish@google.com> <20190329025950.52582-1-linfish@google.com>
In-Reply-To: <20190329025950.52582-1-linfish@google.com>
From:   Fish Lin <linfish@google.com>
Date:   Fri, 29 Mar 2019 11:14:01 +0800
Message-ID: <CAHpF3dedkOzX0o3raKWZMkVAUMsyMHw+iUtk-4wRwEZc9e3fPg@mail.gmail.com>
Subject: Re: [PATCH v7] [media] v4l: add I / P frame min max QP definitions
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Smitha T Murthy <smitha.t@samsung.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, please ignore this patch, I mis-edit the patch file, will send
the correct one.

Fish

Fish Lin <linfish@google.com> =E6=96=BC 2019=E5=B9=B43=E6=9C=8829=E6=97=A5 =
=E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8810:59=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Add following V4L2 QP parameters for H.264:
> * V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MIN_QP
> * V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MAX_QP
> * V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MIN_QP
> * V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MAX_QP
>
> These controls will limit QP range for intra and inter frame,
> provide more manual control to improve video encode quality.
>
> Signed-off-by: Fish Lin <linfish@google.com>
> ---
> Changelog since v6:
> - Adjust ctrl id start from 385.
>
> Changelog since v5:
> - Adjust documentation wording.
>
> Changelog since v4:
> - Fix patch subject and send again.
>
> Changelog since v3:
> - Put document in ext-ctrls-codec.rst instead of extended-controls.rst
>   (which was previous version).
>
> Changelog since v2:
> - Add interaction with V4L2_CID_MPEG_VIDEO_H264_MIN/MAX_QP
>   description in the document.
>
> Changelog since v1:
> - Add description in document.
>
>  .../media/uapi/v4l/ext-ctrls-codec.rst        | 24 +++++++++++++++++++
>  drivers/media/v4l2-core/v4l2-ctrls.c          |  4 ++++
>  include/uapi/linux/v4l2-controls.h            |  6 +++++
>  3 files changed, 34 insertions(+)
>
> diff --git a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst b/Documenta=
tion/media/uapi/v4l/ext-ctrls-codec.rst
> index c97fb7923be5..5b2db52d3b4e 100644
> --- a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
> @@ -1048,6 +1048,30 @@ enum v4l2_mpeg_video_h264_entropy_mode -
>      Quantization parameter for an B frame for H264. Valid range: from 0
>      to 51.
>
> +``V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MIN_QP (integer)``
> +    Minimum quantization parameter for the H264 I frame to limit I frame
> +    quality to a range. Valid range: from 0 to 51. If
> +    V4L2_CID_MPEG_VIDEO_H264_MIN_QP is also set, the quantization parame=
ter
> +    should be chosen to meet both requirements.
> +
> +``V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MAX_QP (integer)``
> +    Maximum quantization parameter for the H264 I frame to limit I frame
> +    quality to a range. Valid range: from 0 to 51. If
> +    V4L2_CID_MPEG_VIDEO_H264_MAX_QP is also set, the quantization parame=
ter
> +    should be chosen to meet both requirements.
> +
> +``V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MIN_QP (integer)``
> +    Minimum quantization parameter for the H264 P frame to limit P frame
> +    quality to a range. Valid range: from 0 to 51. If
> +    V4L2_CID_MPEG_VIDEO_H264_MIN_QP is also set, the quantization parame=
ter
> +    should be chosen to meet both requirements.
> +
> +``V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MAX_QP (integer)``
> +    Maximum quantization parameter for the H264 P frame to limit P frame
> +    quality to a range. Valid range: from 0 to 51. If
> +    V4L2_CID_MPEG_VIDEO_H264_MAX_QP is also set, the quantization parame=
ter
> +    should be chosen to meet both requirements.
> +
>  ``V4L2_CID_MPEG_VIDEO_MPEG4_I_FRAME_QP (integer)``
>      Quantization parameter for an I frame for MPEG4. Valid range: from 1
>      to 31.
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-co=
re/v4l2-ctrls.c
> index b79d3bbd8350..115fb8debe23 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls.c
> @@ -828,6 +828,10 @@ const char *v4l2_ctrl_get_name(u32 id)
>         case V4L2_CID_MPEG_VIDEO_H264_CONSTRAINED_INTRA_PREDICTION:
>                                                                 return "H=
264 Constrained Intra Pred";
>         case V4L2_CID_MPEG_VIDEO_H264_CHROMA_QP_INDEX_OFFSET:   return "H=
264 Chroma QP Index Offset";
> +       case V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MIN_QP:           return "H=
264 I-Frame Minimum QP Value";
> +       case V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MAX_QP:           return "H=
264 I-Frame Maximum QP Value";
> +       case V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MIN_QP:           return "H=
264 P-Frame Minimum QP Value";
> +       case V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MAX_QP:           return "H=
264 P-Frame Maximum QP Value";
>         case V4L2_CID_MPEG_VIDEO_MPEG4_I_FRAME_QP:              return "M=
PEG4 I-Frame QP Value";
>         case V4L2_CID_MPEG_VIDEO_MPEG4_P_FRAME_QP:              return "M=
PEG4 P-Frame QP Value";
>         case V4L2_CID_MPEG_VIDEO_MPEG4_B_FRAME_QP:              return "M=
PEG4 B-Frame QP Value";
> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2=
-controls.h
> index 06479f2fb3ae..4421baa84177 100644
> --- a/include/uapi/linux/v4l2-controls.h
> +++ b/include/uapi/linux/v4l2-controls.h
> @@ -535,6 +535,12 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_type {
>  #define V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING_LAYER_QP  (V4L2_CID=
_MPEG_BASE+382)
>  #define V4L2_CID_MPEG_VIDEO_H264_CONSTRAINED_INTRA_PREDICTION  (V4L2_CID=
_MPEG_BASE+383)
>  #define V4L2_CID_MPEG_VIDEO_H264_CHROMA_QP_INDEX_OFFSET                (=
V4L2_CID_MPEG_BASE+384)
> +#define V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MIN_QP        (V4L2_CID_MPEG_BA=
SE+385)
> +#define V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MAX_QP        (V4L2_CID_MPEG_BA=
SE+386)
> +#define V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MIN_QP        (V4L2_CID_MPEG_BA=
SE+387)
> +#define V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MAX_QP        (V4L2_CID_MPEG_BA=
SE+388)
>  #define V4L2_CID_MPEG_VIDEO_MPEG4_I_FRAME_QP   (V4L2_CID_MPEG_BASE+400)
>  #define V4L2_CID_MPEG_VIDEO_MPEG4_P_FRAME_QP   (V4L2_CID_MPEG_BASE+401)
>  #define V4L2_CID_MPEG_VIDEO_MPEG4_B_FRAME_QP   (V4L2_CID_MPEG_BASE+402)
> --
> 2.21.0.225.g810b269d1ac-goog
>
