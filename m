Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C33C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F5E2077B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NwIoRKWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbfLEAke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 19:40:34 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:37845 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728557AbfLEAke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 19:40:34 -0500
Received: by mail-il1-f194.google.com with SMTP id t9so1394953iln.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 16:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fO9gtIsalSOE0LJbwjwWOC5kliKZZAsXyfcY1acwND4=;
        b=NwIoRKWP9rsacN/oIOZabiTCAFvcFmwPfU/2JxMX5t4NY71U2tiGRRz1U2SqE7kuWr
         MdsNP3zQqY9F1xmYSzB349Q1PJOAYwKDF9OefiklEiTj9B6ql9L5etsZ+NvtKuoD0Wj3
         30gOu7Vm2UmvSDF2+QVZCj/OdaLHMIGFBnu5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fO9gtIsalSOE0LJbwjwWOC5kliKZZAsXyfcY1acwND4=;
        b=cTtGxuX79qvr9w3AIVMPtHFIkpbNRm7mQVzIfMhvONqa+1IqI68Wpj/EK25181yd/V
         0e0uOmyD+TL3w4cO/Ykvv6ewZ4k+FH2T8A8gICcAgPrfWT/T/HRK17YRFn1CQ/aoIoSq
         u4mkrtHcsSYIYzAmzQdEfC+fuywEY6ebDkaK3EW41z1S/WU/HdSwoD7uLQnNnk0a2S4c
         Md7wQIbw/yYpwqC9Q/rCduTMBP1cKf/Z72fgfwWzoj2+ipGVVEGGqS0EmM/HLiD8RprO
         ups8dj1wtqUhOwwingvDdJ+TvSyx0GzbLg/ePGMqCAGluh2S9jxqCiIGzArzQWGmHHuk
         vyfg==
X-Gm-Message-State: APjAAAUsbQHSfY8BfaZP07hKtuSAs8g6qliCyKHfsO7MoMudGjBPiNtn
        OBlU8HOdjv6vR98HoTh121EDfUKUPcg=
X-Google-Smtp-Source: APXvYqxBSgGOesXwFMrzzubgrBYJAiZxWf58Qy170H35nWI9wZPCmO0K1ycnJmwRrEqEARpDwRKJDA==
X-Received: by 2002:a92:5855:: with SMTP id m82mr6229672ilb.302.1575506433307;
        Wed, 04 Dec 2019 16:40:33 -0800 (PST)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com. [209.85.166.175])
        by smtp.gmail.com with ESMTPSA id q3sm2290086ilk.15.2019.12.04.16.40.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 16:40:32 -0800 (PST)
Received: by mail-il1-f175.google.com with SMTP id t9so1394893iln.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 16:40:31 -0800 (PST)
X-Received: by 2002:a92:3c41:: with SMTP id j62mr6440578ila.269.1575506431610;
 Wed, 04 Dec 2019 16:40:31 -0800 (PST)
MIME-Version: 1.0
References: <20191127141544.4277-1-leo.yan@linaro.org> <20191127141544.4277-2-leo.yan@linaro.org>
In-Reply-To: <20191127141544.4277-2-leo.yan@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 5 Dec 2019 08:40:20 +0800
X-Gmail-Original-Message-ID: <CAD=FV=W2nENJF0fNpTzjuAVOo_AoZQryThua9vdtt-zsMk82qg@mail.gmail.com>
Message-ID: <CAD=FV=W2nENJF0fNpTzjuAVOo_AoZQryThua9vdtt-zsMk82qg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tty: serial: msm_serial: Fix lockup for sysrq and oops
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 27, 2019 at 10:16 PM Leo Yan <leo.yan@linaro.org> wrote:
>
> As the commit 677fe555cbfb ("serial: imx: Fix recursive locking bug")
> has mentioned the uart driver might cause recursive locking between
> normal printing and the kernel debugging facilities (e.g. sysrq and
> oops).  In the commit it gave out suggestion for fixing recursive
> locking issue: "The solution is to avoid locking in the sysrq case
> and trylock in the oops_in_progress case."
>
> This patch follows the suggestion (also used the exactly same code with
> other serial drivers, e.g. amba-pl011.c) to fix the recursive locking
> issue, this can avoid stuck caused by deadlock and print out log for
> sysrq and oops.
>
> Fixes: 04896a77a97b ("msm_serial: serial driver for MSM7K onboard serial peripheral.")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/tty/serial/msm_serial.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index 3657a24913fc..889538182e83 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -1576,6 +1576,7 @@ static void __msm_console_write(struct uart_port *port, const char *s,
>         int num_newlines = 0;
>         bool replaced = false;
>         void __iomem *tf;
> +       int locked = 1;
>
>         if (is_uartdm)
>                 tf = port->membase + UARTDM_TF;
> @@ -1588,7 +1589,13 @@ static void __msm_console_write(struct uart_port *port, const char *s,
>                         num_newlines++;
>         count += num_newlines;
>
> -       spin_lock(&port->lock);
> +       if (port->sysrq)
> +               locked = 0;
> +       else if (oops_in_progress)
> +               locked = spin_trylock(&port->lock);
> +       else
> +               spin_lock(&port->lock);

I don't have tons of experience with the "msm" serial driver, but the
above snippet tickled a memory in my brain for when I was looking at
the "qcom_geni" serial driver, which is a close cousin.

I seemed to remember that the "if (port->sysrq)" was something you
didn't want.  ...but maybe that's only if you do something like commit
336447b3298c ("serial: qcom_geni_serial: Process sysrq at port unlock
time")?  Any way you can try making a similar change to the msm driver
and see if it allow you to remove the special case for "port->sysrq"?

-Doug
