Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63E7C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC7021871
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OiMXk0ne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfJHWV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 18:21:29 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38814 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJHWV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 18:21:28 -0400
Received: by mail-io1-f66.google.com with SMTP id u8so538998iom.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 15:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ly0L4G4+dtf2vmkYamGPVXKHjeQLrnBZThMAR5CUXZE=;
        b=OiMXk0ne2OviCBwnCcqAwuZhvAFOgbQZHQR3sGMMEzWbZrLdNkmbijoAhD5cwqL+2u
         zZbnqTJ69EKGjKT0aZfynEEOhv33vLGhOpaE8ijiy3mWJG4RBmojdR2psTz25bToOdMy
         hif3B2W+eRVSn+vKav8PgTyGRKEwsmOxylUrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ly0L4G4+dtf2vmkYamGPVXKHjeQLrnBZThMAR5CUXZE=;
        b=WuDI1rC/Qw/d73wdaU0YB4BhJldl22wgDPyfVXta5/odJJu8lQxjotZvNkztNMl+D9
         Y1clU7Xz+CGcpFtZD0T5F2524oZTj+KJe4PCAen+A2pLLstHtJH+8lCXcSK1u10JOxJe
         NODiGPyegpzTJr4V8xdRHXv/iEwjOiHndTUh0t3oCChpA/CWGM0ymBeKMBKHg0igPskl
         pcycYg6/5qUeXvF0/Mqx5Wjn0JPDbZfA+5K9OSrx61cc516IfRxPYr3eltXrn094KLhR
         PrdKFifV8+9Ed+loWFXPZFpRlAgrobyumfqehSYJm/9Fk+9qKjQ83kKmKJZw63eSUF1v
         yGhw==
X-Gm-Message-State: APjAAAXeWZoyLPKm+SrYNwqms7Wp1T+gPtrgIOBBpU+PDFX2iYZwX41W
        ZdWw2nOwkpJ747TqgUnTkHdzQ+TR9KA=
X-Google-Smtp-Source: APXvYqzw112hAWfWw3ia0ZFASxV7FKNndnMpBaTHyjGCKOTla8iBoS4C0fLCdrQSM0vgkKXf+IZtqA==
X-Received: by 2002:a92:8702:: with SMTP id m2mr892513ild.294.1570573287616;
        Tue, 08 Oct 2019 15:21:27 -0700 (PDT)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id 17sm151862ioo.21.2019.10.08.15.21.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 15:21:27 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id n197so479603iod.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 15:21:27 -0700 (PDT)
X-Received: by 2002:a5e:8b0b:: with SMTP id g11mr501928iok.58.1570573286584;
 Tue, 08 Oct 2019 15:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191008132043.7966-1-daniel.thompson@linaro.org> <20191008132043.7966-5-daniel.thompson@linaro.org>
In-Reply-To: <20191008132043.7966-5-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 8 Oct 2019 15:21:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W008gO4HbtcSXH-uA4jyb6iJLYQJF5L++6CM0AtJmkAg@mail.gmail.com>
Message-ID: <CAD=FV=W008gO4HbtcSXH-uA4jyb6iJLYQJF5L++6CM0AtJmkAg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] kdb: Improve handling of characters from different
 input sources
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
> Currently if an escape timer is interrupted by a character from a
> different input source then the new character is discarded and the
> function returns '\e' (which will be discarded by the level above).
> It is hard to see why this would ever be the desired behaviour.

I guess the 2nd input source would be if you enable keyboard input?
Personally I've never used this myself, but your functional change
seems OK to me.


> Fix this to return the new character rather then the '\e'.

s/then/than


> This is a bigger refactor that might be expected because the new
> character needs to go through escape sequence detection.
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  kernel/debug/kdb/kdb_io.c | 37 ++++++++++++++++++-------------------
>  1 file changed, 18 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index a9e73bc9d1c3..288dd1babf90 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -122,8 +122,8 @@ static int kdb_getchar(void)
>  {
>  #define ESCAPE_UDELAY 1000
>  #define ESCAPE_DELAY (2*1000000/ESCAPE_UDELAY) /* 2 seconds worth of udelays */
> -       char escape_data[5];    /* longest vt100 escape sequence is 4 bytes */
> -       char *ped = escape_data;
> +       char buf[4];    /* longest vt100 escape sequence is 4 bytes */
> +       char *pbuf = buf;
>         int escape_delay = 0;
>         get_char_func *f, *f_escape = NULL;
>         int key;
> @@ -145,27 +145,26 @@ static int kdb_getchar(void)
>                         continue;
>                 }
>
> -               if (escape_delay == 0 && key == '\e') {
> -                       escape_delay = ESCAPE_DELAY;
> -                       ped = escape_data;
> +               /*
> +                * When the first character is received (or we get a change
> +                * input source) we set ourselves up to handle an escape
> +                * sequences (just in case).
> +                */
> +               if (f_escape != f) {
>                         f_escape = f;

Would it make sense to rename "f_escape" to "f_last" or "f_prev" now?
Essentially this logic now happens every time you change input
sources.


-Doug
