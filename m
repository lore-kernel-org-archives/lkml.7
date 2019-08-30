Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56868C3A5A7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 09:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDD821874
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 09:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EoqZX1Vs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfH3Jsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 05:48:53 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46246 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbfH3Jsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 05:48:52 -0400
Received: by mail-oi1-f194.google.com with SMTP id t24so4848710oij.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 02:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=opPJo7Zv4ht/hnWpVSpz0d5Vp3/hOswmpsE3zretzJE=;
        b=EoqZX1Vsy9Szxp+b2Sg//tUs6kcL4ZoTGUwdLa+NeVeQfQf7IVynklZrNliG7NbW3c
         BqTTvlkqs6KgPDc2/MsnL7jzP3HCSBgEPj3iAcwf3MaoLg8C9MgHhZhnJloMTNHx7gHf
         ehsnc475CaxsOCW2n9iAALHDplUCtX23vexks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=opPJo7Zv4ht/hnWpVSpz0d5Vp3/hOswmpsE3zretzJE=;
        b=N8clu11F2qRzN12ILdMN5HlABxtm0rhhQInLbB26gmcOtUeW8UPXP0r3bRFlyI4USv
         AsYUkVi6cyOdVwBHmyk5eyc97KTwgOpy6fIZnyJvT/8dH3g9UD+Z/HD9Ll1Ygjj4A6i5
         wH69i/mKrDejNMBEjjoiWBwylEKOdEb9asPQ7pZSEzYWv4kvjsYoZR5NZYTTE36dMWDn
         8GZn3ZXemsIoke6RY9uMGBFHIS4Yf6tkzkJZXi8ZeDSLrlHVdWEJJk6+22a4toSUVdg+
         J07rPkgQmK0Fx4LX2K1787NJD7zdjX1hjSm+CoNHXU0YNHVFklgdHpYDG00fYrEpIj1M
         aTGA==
X-Gm-Message-State: APjAAAU68NrvdnfQfVfbIAbYuF1E2ynqHx+v87E09rfgsLVX2CcRbO2N
        QvAJD8hcESDkExWyZxxV4Mi+rBwEBAI=
X-Google-Smtp-Source: APXvYqwImrklsoUjZr7rDvVfJ2uH80e5LD1FtwMcLL9YBfCZjdzPC0UErppsfQtduudZ0Y8DyKtyTg==
X-Received: by 2002:aca:1007:: with SMTP id 7mr5867295oiq.24.1567158531121;
        Fri, 30 Aug 2019 02:48:51 -0700 (PDT)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id k16sm1942332otj.58.2019.08.30.02.48.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2019 02:48:50 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id 97so3523435otr.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 02:48:49 -0700 (PDT)
X-Received: by 2002:a9d:4817:: with SMTP id c23mr10736054otf.97.1567158529318;
 Fri, 30 Aug 2019 02:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190822194500.2071-1-jernej.skrabec@siol.net>
 <20190822194500.2071-3-jernej.skrabec@siol.net> <CAPBb6MUChtZcNSTa2uT50k6uPU9T68wofLYGUFRJntDhjH8+iw@mail.gmail.com>
 <907f3c43-b994-f1c7-a15b-116566e19003@xs4all.nl>
In-Reply-To: <907f3c43-b994-f1c7-a15b-116566e19003@xs4all.nl>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 30 Aug 2019 18:48:36 +0900
X-Gmail-Original-Message-ID: <CAPBb6MV979V4BpOyYRGr4oAJOeqSmn-w1V3TRRhWePtqpzzWeQ@mail.gmail.com>
Message-ID: <CAPBb6MV979V4BpOyYRGr4oAJOeqSmn-w1V3TRRhWePtqpzzWeQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] videodev2.h: add V4L2_DEC_CMD_FLUSH
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        mripard@kernel.org, Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>, Chen-Yu Tsai <wens@csie.org>,
        gregkh@linuxfoundation.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, devel@driverdev.osuosl.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        Ezequiel Garcia <ezequiel@collabora.com>, jonas@kwiboo.se
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 6:45 PM Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>
> On 8/30/19 11:38 AM, Alexandre Courbot wrote:
> > On Fri, Aug 23, 2019 at 4:45 AM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> >>
> >> From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> >>
> >> Add this new V4L2_DEC_CMD_FLUSH decoder command and document it.
> >>
> >> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> >> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> >> ---
> >>  Documentation/media/uapi/v4l/vidioc-decoder-cmd.rst | 11 ++++++++++-
> >>  Documentation/media/videodev2.h.rst.exceptions      |  1 +
> >>  include/uapi/linux/videodev2.h                      |  1 +
> >>  3 files changed, 12 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/media/uapi/v4l/vidioc-decoder-cmd.rst b/Documentation/media/uapi/v4l/vidioc-decoder-cmd.rst
> >> index 57f0066f4cff..0bffef6058f7 100644
> >> --- a/Documentation/media/uapi/v4l/vidioc-decoder-cmd.rst
> >> +++ b/Documentation/media/uapi/v4l/vidioc-decoder-cmd.rst
> >> @@ -208,7 +208,16 @@ introduced in Linux 3.3. They are, however, mandatory for stateful mem2mem decod
> >>         been started yet, the driver will return an ``EPERM`` error code. When
> >>         the decoder is already running, this command does nothing. No
> >>         flags are defined for this command.
> >> -
> >> +    * - ``V4L2_DEC_CMD_FLUSH``
> >> +      - 4
> >> +      - Flush any held capture buffers. Only valid for stateless decoders,
> >> +        and only if ``V4L2_BUF_CAP_SUPPORTS_M2M_HOLD_CAPTURE_BUF`` was set.
> >> +       This command is typically used when the application reached the
> >> +       end of the stream and the last output buffer had the
> >> +       ``V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF`` flag set. This would prevent
> >> +       dequeueing the last capture buffer containing the last decoded frame.
> >> +       So this command can be used to explicitly flush that last decoded
> >> +       frame.
> >
> > Just for safety, can we also specify that it is valid to call this
> > command even if no buffer was held (in which case it is a no-op), as
> > this can help make user-space code simpler?
>
> Ah yes, thanks for the reminder.
>
> Jernej, when you post the next version of this series, can you change the text
> above to:
>
> - Flush any held capture buffers. Only valid for stateless decoders.
>   This command is typically used when the application reached the
>   end of the stream and the last output buffer had the
>   ``V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF`` flag set. This would prevent
>   dequeueing the capture buffer containing the last decoded frame.
>   So this command can be used to explicitly flush that final decoded
>   frame. This command does nothing if there are no held capture buffers.

With the above,

Reviewed-by: Alexandre Courbot <acourbot@chromium.org>

Thanks!

>
> Regards,
>
>         Hans
>
> >
> >>
> >>  Return Value
> >>  ============
> >> diff --git a/Documentation/media/videodev2.h.rst.exceptions b/Documentation/media/videodev2.h.rst.exceptions
> >> index adeb6b7a15cb..a79028e4d929 100644
> >> --- a/Documentation/media/videodev2.h.rst.exceptions
> >> +++ b/Documentation/media/videodev2.h.rst.exceptions
> >> @@ -434,6 +434,7 @@ replace define V4L2_DEC_CMD_START decoder-cmds
> >>  replace define V4L2_DEC_CMD_STOP decoder-cmds
> >>  replace define V4L2_DEC_CMD_PAUSE decoder-cmds
> >>  replace define V4L2_DEC_CMD_RESUME decoder-cmds
> >> +replace define V4L2_DEC_CMD_FLUSH decoder-cmds
> >>
> >>  replace define V4L2_DEC_CMD_START_MUTE_AUDIO decoder-cmds
> >>  replace define V4L2_DEC_CMD_PAUSE_TO_BLACK decoder-cmds
> >> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> >> index 4fa9f543742d..91a79e16089c 100644
> >> --- a/include/uapi/linux/videodev2.h
> >> +++ b/include/uapi/linux/videodev2.h
> >> @@ -1978,6 +1978,7 @@ struct v4l2_encoder_cmd {
> >>  #define V4L2_DEC_CMD_STOP        (1)
> >>  #define V4L2_DEC_CMD_PAUSE       (2)
> >>  #define V4L2_DEC_CMD_RESUME      (3)
> >> +#define V4L2_DEC_CMD_FLUSH       (4)
> >>
> >>  /* Flags for V4L2_DEC_CMD_START */
> >>  #define V4L2_DEC_CMD_START_MUTE_AUDIO  (1 << 0)
> >> --
> >> 2.22.1
> >>
>
