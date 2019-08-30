Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD2CC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 09:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445EC23427
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 09:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JZSzfjCV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfH3Jit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 05:38:49 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37710 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfH3Jis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 05:38:48 -0400
Received: by mail-ot1-f68.google.com with SMTP id 97so3500182otr.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 02:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hfIr0oG7zkjfTylZRL1EmDdcoClxx4OzN+k3Fa69QOk=;
        b=JZSzfjCV+OzEP0NKiy064AMNbZCphzNNPFXwQYxpUoxKno8taFSuAONsfm81PEzvhQ
         qaCbe4ObT5UHEJBtWQSMdiRygC0gFb4piQ27RfDvbgjt1MFHx4FUZYcXKDJ16XhUnr/e
         s1OWlBpt4sKcZVLl+qYpSVUn0vbanGsamHLos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hfIr0oG7zkjfTylZRL1EmDdcoClxx4OzN+k3Fa69QOk=;
        b=f3Lv+YJD96VYtQ1+J9NV37yAHw0apUkkLidEsH2UycWEq7AmM2ASDJz+sn70lm5iaR
         OcsEoJtCWpUZZ/PsOY5cTPMUNvIIS9Y1JhnhLLBrGewo0c4tPVQblJbXmcNykZ11udJn
         4SmMhW69Eh4akAIQ41mikVj7vZCHQmbqJkJ0hSAlqvHJ7ti5uhOlIXXGdHeXrENqVOcN
         BoPZ3rcgX87qBlZTFUBjzUiqqKwDiZX9mlHmGDSHxdY1dmfJhbQ6JANDECN5qXA5hjNA
         1ekaH8j424Zoeq67yC7uiQBqUoWAT8LnFBo9QqRyp/7fFseMuNMHhhtJFuqAlzZQf9dQ
         cOrA==
X-Gm-Message-State: APjAAAWl98YLjGE87XDu4+qZJsIduBEmGETKoJXBp6np9Qpt7imrd3An
        zu5hdwXsUHv4oZ0rtY3VW9Z4yM7Mnyo=
X-Google-Smtp-Source: APXvYqydPOiJCSJ6lci9akcXcqPzqatgRIV9T89FmJQ+wQjSj4ZWfGhqwKo38fSBiNPwWJRc6nTdBw==
X-Received: by 2002:a05:6830:17d2:: with SMTP id p18mr11323858ota.113.1567157926899;
        Fri, 30 Aug 2019 02:38:46 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id j19sm1780360otk.46.2019.08.30.02.38.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2019 02:38:45 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id m24so6309487otp.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 02:38:45 -0700 (PDT)
X-Received: by 2002:a9d:c67:: with SMTP id 94mr11849012otr.33.1567157924626;
 Fri, 30 Aug 2019 02:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190822194500.2071-1-jernej.skrabec@siol.net> <20190822194500.2071-3-jernej.skrabec@siol.net>
In-Reply-To: <20190822194500.2071-3-jernej.skrabec@siol.net>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 30 Aug 2019 18:38:32 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUChtZcNSTa2uT50k6uPU9T68wofLYGUFRJntDhjH8+iw@mail.gmail.com>
Message-ID: <CAPBb6MUChtZcNSTa2uT50k6uPU9T68wofLYGUFRJntDhjH8+iw@mail.gmail.com>
Subject: Re: [PATCH 2/8] videodev2.h: add V4L2_DEC_CMD_FLUSH
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
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

On Fri, Aug 23, 2019 at 4:45 AM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
>
> Add this new V4L2_DEC_CMD_FLUSH decoder command and document it.
>
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  Documentation/media/uapi/v4l/vidioc-decoder-cmd.rst | 11 ++++++++++-
>  Documentation/media/videodev2.h.rst.exceptions      |  1 +
>  include/uapi/linux/videodev2.h                      |  1 +
>  3 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/media/uapi/v4l/vidioc-decoder-cmd.rst b/Documentation/media/uapi/v4l/vidioc-decoder-cmd.rst
> index 57f0066f4cff..0bffef6058f7 100644
> --- a/Documentation/media/uapi/v4l/vidioc-decoder-cmd.rst
> +++ b/Documentation/media/uapi/v4l/vidioc-decoder-cmd.rst
> @@ -208,7 +208,16 @@ introduced in Linux 3.3. They are, however, mandatory for stateful mem2mem decod
>         been started yet, the driver will return an ``EPERM`` error code. When
>         the decoder is already running, this command does nothing. No
>         flags are defined for this command.
> -
> +    * - ``V4L2_DEC_CMD_FLUSH``
> +      - 4
> +      - Flush any held capture buffers. Only valid for stateless decoders,
> +        and only if ``V4L2_BUF_CAP_SUPPORTS_M2M_HOLD_CAPTURE_BUF`` was set.
> +       This command is typically used when the application reached the
> +       end of the stream and the last output buffer had the
> +       ``V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF`` flag set. This would prevent
> +       dequeueing the last capture buffer containing the last decoded frame.
> +       So this command can be used to explicitly flush that last decoded
> +       frame.

Just for safety, can we also specify that it is valid to call this
command even if no buffer was held (in which case it is a no-op), as
this can help make user-space code simpler?

>
>  Return Value
>  ============
> diff --git a/Documentation/media/videodev2.h.rst.exceptions b/Documentation/media/videodev2.h.rst.exceptions
> index adeb6b7a15cb..a79028e4d929 100644
> --- a/Documentation/media/videodev2.h.rst.exceptions
> +++ b/Documentation/media/videodev2.h.rst.exceptions
> @@ -434,6 +434,7 @@ replace define V4L2_DEC_CMD_START decoder-cmds
>  replace define V4L2_DEC_CMD_STOP decoder-cmds
>  replace define V4L2_DEC_CMD_PAUSE decoder-cmds
>  replace define V4L2_DEC_CMD_RESUME decoder-cmds
> +replace define V4L2_DEC_CMD_FLUSH decoder-cmds
>
>  replace define V4L2_DEC_CMD_START_MUTE_AUDIO decoder-cmds
>  replace define V4L2_DEC_CMD_PAUSE_TO_BLACK decoder-cmds
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 4fa9f543742d..91a79e16089c 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -1978,6 +1978,7 @@ struct v4l2_encoder_cmd {
>  #define V4L2_DEC_CMD_STOP        (1)
>  #define V4L2_DEC_CMD_PAUSE       (2)
>  #define V4L2_DEC_CMD_RESUME      (3)
> +#define V4L2_DEC_CMD_FLUSH       (4)
>
>  /* Flags for V4L2_DEC_CMD_START */
>  #define V4L2_DEC_CMD_START_MUTE_AUDIO  (1 << 0)
> --
> 2.22.1
>
