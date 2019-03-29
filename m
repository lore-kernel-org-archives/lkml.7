Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A598DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCF52183E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="geAkRCfW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfC2Cqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 22:46:49 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46843 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfC2Cqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 22:46:48 -0400
Received: by mail-ed1-f68.google.com with SMTP id d1so711612edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 19:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0+42zuAaHk5LA8x0uspwvqR74XV3PXl4bVD5/fxSnsg=;
        b=geAkRCfWASwmGRMkdorFKEYqMiJnC+vSQpVAWiqyRVw+wIGmKx9ugW+KFR6CR0YsRx
         qYxWhqu/3ycw2s4x1FTQW7H3Yogcb7XElb+ILLdAg3VyskMkU8F9IA8yAHkIWF+iGQON
         OdHTsp3mZrtjLiLde9OX/34WnHarcPOtGTQ8rLD+BYcEf01drJfk238Kws/+up5NjzHj
         FBbgXMpHXQxeZuqazokkMIeXVfePGf6Yl3Mzik8sqqjaOI+hjOTOISx8JFBt1zA+H6/q
         4dYPEj9ITk1yXfcqbKchZF/7P/g2S566DVYyzot/bR4bSjDvR8Da/2Lagl4nokHT+51f
         fr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0+42zuAaHk5LA8x0uspwvqR74XV3PXl4bVD5/fxSnsg=;
        b=NO/K9C8V0G8hCAX5bh9nlYOdvVto9YORfwKaLrDFoZ0m7HRylcuRroBP84arRNSs+e
         pL7xH5JJXalDBqKcPL+5WzI24Ws+yUgNW6rHPb3d4bKDn2eXVK1ma6IaqtI6icP8RIkc
         5dVilYCYZ2+5k3uc+01xT2hER0Ow6oKOYL2Ppl1dftatZR5bpxoAPifV7VEF7GYGrDc8
         WZdCqX1vDihmQabuxGCCO1cKWXVI6aitZfqMnFXBS1q7jI3YSDwhcj3FHTLsNW3k3bAW
         7tBDfrbvwWSExwvpIc6xcruvS9yH3fSxbM3vaCeQH1qUyvKW56SCgzTA3heZFpROaEqn
         jPkw==
X-Gm-Message-State: APjAAAV/6eo8GAEA357g19OVPBpmbL5P8KZV1NygGiAlH/0N6KznYUNC
        UTYgh+3PUzinmDDBuy7iDiXA3UKEiUnD4mGhNKyvvw==
X-Google-Smtp-Source: APXvYqxM4JLiUeG/zj2DZoLEUELB8AHL1vyChCO3qajjySaVoZIHGPBE/sIpD12MoPG3H4KTw0H2k4/O/Y1aMlNnRJs=
X-Received: by 2002:a17:906:c3cd:: with SMTP id cj13mr695088ejb.247.1553827605579;
 Thu, 28 Mar 2019 19:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190320031022.174052-1-linfish@google.com> <0aaba609-1551-e09d-a39f-111dbe99288e@xs4all.nl>
In-Reply-To: <0aaba609-1551-e09d-a39f-111dbe99288e@xs4all.nl>
From:   Fish Lin <linfish@google.com>
Date:   Fri, 29 Mar 2019 10:46:34 +0800
Message-ID: <CAHpF3df+nJFyg=40NnK-4uRm3fQnrmXk-Ra3QPMHu3jpTZOuQg@mail.gmail.com>
Subject: Re: [PATCH] media: v4l-ctrl: add control for variable frame rate
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Smitha T Murthy <smitha.t@samsung.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idea for variable framerate is to reduce bitrate by encode less frames.
Sometimes the motion is too much and encoder can encode in really low
bitrate, will be able to dynamic drop some frames to archive
requirement.

Codec like H.264 and HEVC can support VFR, and lots of containers also supp=
ort.
https://en.wikipedia.org/wiki/Comparison_of_video_container_formats

Yes, the decoder need to know if video is CFR or VFR, not all decoder
support VFR, especially for video editing.
There are also some tools to convert VFR video to CFR video.

Some reference:
https://en.wikipedia.org/wiki/Variable_frame_rate
https://www.bandicam.com/support/tips/vfr-cfr/
https://pro-av.panasonic.net/manual/html/AJ-PX270P_PJ_PX_EN_AN(VQT5J83A-8(E=
))/chapter04_08.htm

Hans Verkuil <hverkuil-cisco@xs4all.nl> =E6=96=BC 2019=E5=B9=B43=E6=9C=8828=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8810:57=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On 3/20/19 4:10 AM, Fish Lin wrote:
> > These flag are added
> > * V4L2_CID_MPEG_VIDEO_VFR_ENABLE
> > * V4L2_CID_MPEG_VIDEO_VFR_MIN_FRAMERATE
> > One is to set variable frame rate enable or not, another is to control
> > minimal frame rate that video encoder should keep per second.
> >
> > Signed-off-by: Fish Lin <linfish@google.com>
> > ---
> >  Documentation/media/uapi/v4l/ext-ctrls-codec.rst | 9 +++++++++
> >  drivers/media/v4l2-core/v4l2-ctrls.c             | 3 +++
> >  include/uapi/linux/v4l2-controls.h               | 3 +++
> >  3 files changed, 15 insertions(+)
> >
> > diff --git a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst b/Documen=
tation/media/uapi/v4l/ext-ctrls-codec.rst
> > index c97fb7923be5..4bc013d71b67 100644
> > --- a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
> > +++ b/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
> > @@ -620,7 +620,16 @@ enum v4l2_mpeg_video_bitrate_mode -
> >      * - Bit 24:31
> >        - Must be zero.
> >
> > +.. _v4l2-mpeg-video-variable-framerate:
> >
> > +``V4L2_CID_MPEG_VIDEO_VFR_ENABLE (boolean)``
> > +    Set variable framerate enable or not. When enabled, video encoder =
is able
> > +    to drop frames based on some mechanism, like frame similarity or b=
itrate
> > +    control (default disable).
> > +
> > +``V4L2_CID_MPEG_VIDEO_VFR_MIN_FRAMERATE (integer)``
> > +    Minimal kept frame per second when variable framerate is enabled (=
default
> > +    is input framerate).
>
> You don't really have a concept of frames per second when encoding. What =
you
> are probably trying to say is something like: "don't drop more than one f=
rame for
> every X frames" or something like that.
>
> Which codecs support this? A decoder needs to know that a frame is missin=
g, right?
>
> What's the use-case for this?
>
> Sorry, just trying to understand this better.
>
> Regards,
>
>         Hans
>
> >
> >  .. _v4l2-mpeg-video-dec-pts:
> >
> > diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-=
core/v4l2-ctrls.c
> > index b79d3bbd8350..566c6552c9a0 100644
> > --- a/drivers/media/v4l2-core/v4l2-ctrls.c
> > +++ b/drivers/media/v4l2-core/v4l2-ctrls.c
> > @@ -786,6 +786,8 @@ const char *v4l2_ctrl_get_name(u32 id)
> >       case V4L2_CID_MPEG_VIDEO_MB_RC_ENABLE:                  return "H=
264 MB Level Rate Control";
> >       case V4L2_CID_MPEG_VIDEO_HEADER_MODE:                   return "S=
equence Header Mode";
> >       case V4L2_CID_MPEG_VIDEO_MAX_REF_PIC:                   return "M=
ax Number of Reference Pics";
> > +     case V4L2_CID_MPEG_VIDEO_VFR_ENABLE:                    return "V=
ariable Frame Rate Enable";
> > +     case V4L2_CID_MPEG_VIDEO_VFR_MIN_FRAMERATE:             return "V=
FR Minimal Frame Rate";
> >       case V4L2_CID_MPEG_VIDEO_H263_I_FRAME_QP:               return "H=
263 I-Frame QP Value";
> >       case V4L2_CID_MPEG_VIDEO_H263_P_FRAME_QP:               return "H=
263 P-Frame QP Value";
> >       case V4L2_CID_MPEG_VIDEO_H263_B_FRAME_QP:               return "H=
263 B-Frame QP Value";
> > @@ -1108,6 +1110,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, en=
um v4l2_ctrl_type *type,
> >       case V4L2_CID_MPEG_VIDEO_DECODER_SLICE_INTERFACE:
> >       case V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE:
> >       case V4L2_CID_MPEG_VIDEO_MB_RC_ENABLE:
> > +     case V4L2_CID_MPEG_VIDEO_VFR_ENABLE:
> >       case V4L2_CID_MPEG_VIDEO_H264_8X8_TRANSFORM:
> >       case V4L2_CID_MPEG_VIDEO_H264_VUI_SAR_ENABLE:
> >       case V4L2_CID_MPEG_VIDEO_MPEG4_QPEL:
> > diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4=
l2-controls.h
> > index 06479f2fb3ae..f1bf52eb0152 100644
> > --- a/include/uapi/linux/v4l2-controls.h
> > +++ b/include/uapi/linux/v4l2-controls.h
> > @@ -404,6 +404,9 @@ enum v4l2_mpeg_video_multi_slice_mode {
> >  #define V4L2_CID_MPEG_VIDEO_MV_V_SEARCH_RANGE                (V4L2_CID=
_MPEG_BASE+228)
> >  #define V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME          (V4L2_CID_MPEG_BA=
SE+229)
> >
> > +#define V4L2_CID_MPEG_VIDEO_VFR_ENABLE (V4L2_CID_MPEG_BASE + 250)
> > +#define V4L2_CID_MPEG_VIDEO_VFR_MIN_FRAMERATE (V4L2_CID_MPEG_BASE + 25=
1)
> > +
> >  #define V4L2_CID_MPEG_VIDEO_H263_I_FRAME_QP          (V4L2_CID_MPEG_BA=
SE+300)
> >  #define V4L2_CID_MPEG_VIDEO_H263_P_FRAME_QP          (V4L2_CID_MPEG_BA=
SE+301)
> >  #define V4L2_CID_MPEG_VIDEO_H263_B_FRAME_QP          (V4L2_CID_MPEG_BA=
SE+302)
> >
>
