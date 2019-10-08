Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A8EC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E6320873
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZLi8SVXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbfJHWVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 18:21:42 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46551 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJHWVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 18:21:42 -0400
Received: by mail-io1-f67.google.com with SMTP id c6so425828ioo.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 15:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u4tftPbCrv3Ywdv/Yr7lGlylwby5ziOgn4R8Izjj4JY=;
        b=ZLi8SVXF0W7jPNHHCEk2AUCffy+7zMrgf0XWhZS7LbFvNSuPfTRfCpgfafY+GDGc1S
         gvMSvpsBQ00YM+ZXcT24vvny2NYdRTh9ZM+Nb11hw2fYcf2WKkl3yANCI2NUvjeXX+rM
         eQijQ+fVF6zxiHRtsHL1nGLB4Iy3EXAkasznY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u4tftPbCrv3Ywdv/Yr7lGlylwby5ziOgn4R8Izjj4JY=;
        b=oWluw/5Gcio9TsCakyngKyMqxxA8urvZH+X0JvfC2Sdj/H7ZoozXTqjkj5K7aHV4t2
         TB8/+g5Q9YQl97ZE9t6/Lt46NpiFNtpR5TPDXaMJQzpDUrOYSeorULlQ686/F5zv/qws
         W5SJgXQsfODNh+cKiGFY4GAOjDtVCEbpQXaaC2OAj8zERzbTv8Yx9od4NcOATGdD8m6c
         EowNbO5pTbhjbzuOF+UD8K8jpNZ2ZKTv3XYx4XPI6wv+ccsTjEHtQwAKV6BIY+cmoR7Y
         LVC0XocQ2HjvLnP60JKpO5tXvizpA1F/iA1317T4iI7EtuSaDTOEug339w7jH6x/3wG9
         YfdA==
X-Gm-Message-State: APjAAAVKHpeYHUC+DsPWsB93o+XfUvCVFkxoMYF+KxUtAGpqmGNOy/2c
        aRxnK4f5kOtDoCH83/+nPAoJ2Eh618g=
X-Google-Smtp-Source: APXvYqypFd33UDBwh7o77TvaoauNKdHmg3rSS56FzcJ5T+UbB34rj8jH5rQgSV7Uqj8KhvrTRi/XwA==
X-Received: by 2002:a02:bb85:: with SMTP id g5mr301626jan.7.1570573301282;
        Tue, 08 Oct 2019 15:21:41 -0700 (PDT)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id v70sm232043ilk.58.2019.10.08.15.21.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 15:21:40 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id w12so455552iol.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 15:21:40 -0700 (PDT)
X-Received: by 2002:a02:b691:: with SMTP id i17mr300479jam.132.1570573300103;
 Tue, 08 Oct 2019 15:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191008132043.7966-1-daniel.thompson@linaro.org> <20191008132043.7966-6-daniel.thompson@linaro.org>
In-Reply-To: <20191008132043.7966-6-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 8 Oct 2019 15:21:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=US8y=JrcQy3mB9MqFCaMd-N8FS2=JDe2zGWZhyHtTZtw@mail.gmail.com>
Message-ID: <CAD=FV=US8y=JrcQy3mB9MqFCaMd-N8FS2=JDe2zGWZhyHtTZtw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] kdb: Tweak escape handling for vi users
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 8, 2019 at 6:21 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently if sequences such as "\ehelp\r" are delivered to the console then
> the h gets eaten by the escape handling code. Since pressing escape
> becomes something of a nervous twitch for vi users (and that escape doesn't
> have much effect at a shell prompt) it is more helpful to emit the 'h' than
> the '\e'.

I have no objection to this change.


> We don't simply choose to emit the final character for all escape sequences
> since that will do odd things for unsupported escape sequences (in
> other words we retain the existing behaviour once we see '\e[').

It's not like it handles unsupported escape sequences terribly well
anyway, of course.  As soon as if finds something it doesn't recognize
then it stops processing the escape sequence and will just interpret
the rest of it verbatim.  Like if I press Ctrl-Home on my keyboard I
see "5H" spit out, for instance.


> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  kernel/debug/kdb/kdb_io.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 288dd1babf90..b3fb88b1ee34 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -158,8 +158,8 @@ static int kdb_getchar(void)
>
>                 *pbuf++ = key;
>                 key = kdb_read_handle_escape(buf, pbuf - buf);
> -               if (key < 0) /* no escape sequence; return first character */
> -                       return buf[0];
> +               if (key < 0) /* no escape sequence; return best character */
> +                       return buf[pbuf - buf != 2 ? 0 : 1];

optional nit: for me the inverse is easier to conceptualize, AKA:

buf[pbuf - buf == 2 ? 1 : 0];

-Doug
