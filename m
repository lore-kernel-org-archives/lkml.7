Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B70BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3122B21871
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DL02br3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfC2C6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 22:58:10 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36988 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbfC2C6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 22:58:10 -0400
Received: by mail-ed1-f67.google.com with SMTP id v21so769565edq.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 19:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g1vXUCDG+3wkypyf77Td0aRi/7OTsfFPNA5di/oEquc=;
        b=DL02br3oEZ1w5uiRqCBm1XiOac7w69Fkf8GijSrsh0uDa/e6tydKbWKRuppLrmcP0l
         2Hfl4VpKkD/hMi1GXjZZwyQxz7WvppIFz0lATzhEINXpuyKf1OcpeMe+nWC8y9yHfuVf
         pycjcqq5zKWtdp2rvd3g6GNkLmlPuBtE+XGt3Z+i7D7V1BwQ7oqvW+AVtSrHmW9uzV/n
         f1u6SeeXocy4LmGraXgEU1je8EUUGUvFd5RRLmUFCOhtaPJvxVc5wXeE1U6TtadD8I8T
         jsEISNIfAVMuxRefHahbJQoFWdB7zTVw5LJ24SMU6Cq+0qSlr604EmsFXVeL0yBNcZZA
         r42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g1vXUCDG+3wkypyf77Td0aRi/7OTsfFPNA5di/oEquc=;
        b=aIR3otLlwxhazcTpmVzhE70ttizUi5QJLczyUPy+RJB1n7oWV6DkwCzr2FGN7l9hXX
         +HUN+f9u7bmrzsxwASHBT4jYRZJ9PdotPOdPpiff9yp5PrO6aW3AdrhUje/P0KNZg20I
         LvnMJrVpDx3wCQGLs+H8N3l66cbQ2iAxjE/qsWUveZKn0bC53W7cMwepMfV9Sjfkr2Dz
         fcubeQG8kH5jnb6rxpaVmbbYC8+6lkAlIHf0j862DNbXX1Sd2GtUtfp9SlIFaozHmaCE
         5DY9yC7+FKknPK40emnFzT++1gs50FijBEQ+v1J5ryIqmC+DYmS5+0cEDwmaJbSwONxb
         nqvA==
X-Gm-Message-State: APjAAAWtHHVgeaZ0cVkA4N0h0/CQP94PkBttHPR72cMYMfn1Ci7pZayw
        ks8Fo0PtnjT07AwLks049WN9YJeINstpNYfgBNmhWg==
X-Google-Smtp-Source: APXvYqxhNF8KzQ6gYZhDnxcN0e/ZV4y6b2Ubka/2v5S4fpjYQi185RJi450j3wdtbQLR01QYy0WnEzIlRJiQf9x/umk=
X-Received: by 2002:a50:9970:: with SMTP id l45mr31049672edb.171.1553828287641;
 Thu, 28 Mar 2019 19:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190128072948.45788-1-linfish@google.com> <20190321022052.164967-1-linfish@google.com>
 <a6eaaf4e-9645-9cd8-8a2e-94a4ee6c52ce@xs4all.nl>
In-Reply-To: <a6eaaf4e-9645-9cd8-8a2e-94a4ee6c52ce@xs4all.nl>
From:   Fish Lin <linfish@google.com>
Date:   Fri, 29 Mar 2019 10:57:31 +0800
Message-ID: <CAHpF3dcjJsY71GE4gT5ecQUmktAdXd+rmB6YxZ6tozbQb64SRw@mail.gmail.com>
Subject: Re: [PATCH v6] [media] v4l: add I / P frame min max QP definitions
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
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

Hans Verkuil <hverkuil-cisco@xs4all.nl> =E6=96=BC 2019=E5=B9=B43=E6=9C=8828=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8811:01=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On 3/21/19 3:20 AM, Fish Lin wrote:
> > Add following V4L2 QP parameters for H.264:
> > * V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MIN_QP
> > * V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MAX_QP
> > * V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MIN_QP
> > * V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MAX_QP
> >
> > These controls will limit QP range for intra and inter frame,
> > provide more manual control to improve video encode quality.
> >
> > Signed-off-by: Fish Lin <linfish@google.com>
> > ---
> > Changelog since v5:
> > - Adjust documentation wording.
> >
> > Changelog since v4:
> > - Fix patch subject and send again.
> >
> > Changelog since v3:
> > - Put document in ext-ctrls-codec.rst instead of extended-controls.rst
> >   (which was previous version).
> >
> > Changelog since v2:
> > - Add interaction with V4L2_CID_MPEG_VIDEO_H264_MIN/MAX_QP
> >   description in the document.
> >
> > Changelog since v1:
> > - Add description in document.
> >
> >  .../media/uapi/v4l/ext-ctrls-codec.rst        | 24 +++++++++++++++++++
> >  drivers/media/v4l2-core/v4l2-ctrls.c          |  4 ++++
> >  include/uapi/linux/v4l2-controls.h            |  6 +++++
> >  3 files changed, 34 insertions(+)
> >
> > diff --git a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst b/Documen=
tation/media/uapi/v4l/ext-ctrls-codec.rst
> > index c97fb7923be5..5b2db52d3b4e 100644
> > --- a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
> > +++ b/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
> > @@ -1048,6 +1048,30 @@ enum v4l2_mpeg_video_h264_entropy_mode -
> >      Quantization parameter for an B frame for H264. Valid range: from =
0
> >      to 51.
> >
> > +``V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MIN_QP (integer)``
> > +    Minimum quantization parameter for the H264 I frame to limit I fra=
me
> > +    quality to a range. Valid range: from 0 to 51. If
> > +    V4L2_CID_MPEG_VIDEO_H264_MIN_QP is also set, the quantization para=
meter
> > +    should be chosen to meet both requirements.
> > +
> > +``V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MAX_QP (integer)``
> > +    Maximum quantization parameter for the H264 I frame to limit I fra=
me
> > +    quality to a range. Valid range: from 0 to 51. If
> > +    V4L2_CID_MPEG_VIDEO_H264_MAX_QP is also set, the quantization para=
meter
> > +    should be chosen to meet both requirements.
> > +
> > +``V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MIN_QP (integer)``
> > +    Minimum quantization parameter for the H264 P frame to limit P fra=
me
> > +    quality to a range. Valid range: from 0 to 51. If
> > +    V4L2_CID_MPEG_VIDEO_H264_MIN_QP is also set, the quantization para=
meter
> > +    should be chosen to meet both requirements.
> > +
> > +``V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MAX_QP (integer)``
> > +    Maximum quantization parameter for the H264 P frame to limit P fra=
me
> > +    quality to a range. Valid range: from 0 to 51. If
> > +    V4L2_CID_MPEG_VIDEO_H264_MAX_QP is also set, the quantization para=
meter
> > +    should be chosen to meet both requirements.
> > +
> >  ``V4L2_CID_MPEG_VIDEO_MPEG4_I_FRAME_QP (integer)``
> >      Quantization parameter for an I frame for MPEG4. Valid range: from=
 1
> >      to 31.
> > diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-=
core/v4l2-ctrls.c
> > index b79d3bbd8350..115fb8debe23 100644
> > --- a/drivers/media/v4l2-core/v4l2-ctrls.c
> > +++ b/drivers/media/v4l2-core/v4l2-ctrls.c
> > @@ -828,6 +828,10 @@ const char *v4l2_ctrl_get_name(u32 id)
> >       case V4L2_CID_MPEG_VIDEO_H264_CONSTRAINED_INTRA_PREDICTION:
> >                                                               return "H=
264 Constrained Intra Pred";
> >       case V4L2_CID_MPEG_VIDEO_H264_CHROMA_QP_INDEX_OFFSET:   return "H=
264 Chroma QP Index Offset";
> > +     case V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MIN_QP:           return "H=
264 I-Frame Minimum QP Value";
> > +     case V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MAX_QP:           return "H=
264 I-Frame Maximum QP Value";
> > +     case V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MIN_QP:           return "H=
264 P-Frame Minimum QP Value";
> > +     case V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MAX_QP:           return "H=
264 P-Frame Maximum QP Value";
> >       case V4L2_CID_MPEG_VIDEO_MPEG4_I_FRAME_QP:              return "M=
PEG4 I-Frame QP Value";
> >       case V4L2_CID_MPEG_VIDEO_MPEG4_P_FRAME_QP:              return "M=
PEG4 P-Frame QP Value";
> >       case V4L2_CID_MPEG_VIDEO_MPEG4_B_FRAME_QP:              return "M=
PEG4 B-Frame QP Value";
> > diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4=
l2-controls.h
> > index 06479f2fb3ae..4421baa84177 100644
> > --- a/include/uapi/linux/v4l2-controls.h
> > +++ b/include/uapi/linux/v4l2-controls.h
> > @@ -535,6 +535,12 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_type=
 {
> >  #define V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING_LAYER_QP        (=
V4L2_CID_MPEG_BASE+382)
> >  #define V4L2_CID_MPEG_VIDEO_H264_CONSTRAINED_INTRA_PREDICTION        (=
V4L2_CID_MPEG_BASE+383)
> >  #define V4L2_CID_MPEG_VIDEO_H264_CHROMA_QP_INDEX_OFFSET              (=
V4L2_CID_MPEG_BASE+384)
> > +
> > +#define V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MIN_QP      (V4L2_CID_MPEG_BA=
SE+390)
>
> There is no need for a gap in numbering. Just start with +385.
>
> Sorry for this, I missed that in the previous reviews. Everything else lo=
oks good
> to me, so if you post a v7 I'll take it.
>
> Thanks!
>
>         Hans
>
> > +#define V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MAX_QP      (V4L2_CID_MPEG_BA=
SE+391)
> > +#define V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MIN_QP      (V4L2_CID_MPEG_BA=
SE+392)
> > +#define V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MAX_QP      (V4L2_CID_MPEG_BA=
SE+393)
> > +
> >  #define V4L2_CID_MPEG_VIDEO_MPEG4_I_FRAME_QP (V4L2_CID_MPEG_BASE+400)
> >  #define V4L2_CID_MPEG_VIDEO_MPEG4_P_FRAME_QP (V4L2_CID_MPEG_BASE+401)
> >  #define V4L2_CID_MPEG_VIDEO_MPEG4_B_FRAME_QP (V4L2_CID_MPEG_BASE+402)
> > --
> > 2.21.0.225.g810b269d1ac-goog
> >
>

Thanks for the review!

Fish
