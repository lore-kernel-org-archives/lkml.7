Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F472C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E41820872
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vA6EZ1Bw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395208AbfIXRmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 13:42:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43366 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387559AbfIXRmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 13:42:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id v27so1691090pgk.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 10:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b25PjZ9f4KQf91gHoZ/sA7aRK+24UL8wYgxN5Qi37+s=;
        b=vA6EZ1BwpZsPaLzGQV8iSv+Hv9klcNnY5SMwJRMBMcGvxqcKoympzEGVdsZA3sId6E
         qtUE+OefpYETjulXC4bF+50sEBl/4+FcrxT5KywAExr0CsXMuFAbWcdE13ymkpwbY4UI
         l4Xls4A9zznkuaLHaBMbiOrLLnI0hr/Ql18pR+tS2s86ZNdO+bB52MN8g2dKFWPSNbX4
         qel9Vszbd/OKp8Vy5zRy07+nyP0gnuc4Jx01iKlcJRMoQlOQbmLe4wd8/tw4ZlCJ3v9X
         WfDJh9SmR3J3bopANm5/OgDU71Lh0MDIBx5dWwLPdpCuvgcJ3za1q8HdS1WmJteTtETg
         scmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b25PjZ9f4KQf91gHoZ/sA7aRK+24UL8wYgxN5Qi37+s=;
        b=UG8pIRbP4TBvu/UcKOltDtJ6sNpcZglUPbGUq6bPbUEeH57Kr7DbNnBFDiq4nJtRlG
         eHMLg5RKsNxLLPlVMp7GRVyqAhPU98cBsR1ZdFfZmco+S0VaINrOwjpCvQf6xJE1D9FA
         wE481bMhqY2fC1KnurKBO8IHoMWngc2aji+EXdiV45aR8gYBs2icJ8y52D9XcwCvE8Q2
         F2H5W6mXo/iqo38SIptngMnK5yOg5OGbnJAdT1akpo2l96EwYyS/TEgTVEnA+FsnL0Ag
         xINJY9jkwUxlq9jxbSS6wyIZpB5kplrthdyLSUGSAY/s572QupDchW5m85AODoJVt20d
         /y4A==
X-Gm-Message-State: APjAAAUua2+fywNvdvsagPgDglaHQnc2nIEtwxwsx3GmCEubADCtOt99
        UdLkf38SWFlzp0J40YHQHp8PFAi7h9JUig4Ukb3q6A==
X-Google-Smtp-Source: APXvYqwuMZdkP/hktoOEkDRBi5o6/ehk5X6MOBBHbTYmwwX5gnsdFJ5L6cs+WBKrpAflcR1bKXq7ySEw7P9ws/M02EA=
X-Received: by 2002:a17:90a:154f:: with SMTP id y15mr1299955pja.73.1569346948095;
 Tue, 24 Sep 2019 10:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190924173717.198637-1-ndesaulniers@google.com>
In-Reply-To: <20190924173717.198637-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 24 Sep 2019 10:42:16 -0700
Message-ID: <CAKwvOd=GVdHhsdHOMpuhEKkWMssW37keqX5c59+6fiEgLs+Q1g@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (applesmc) fix UB and udelay overflow
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        jdelvare@suse.com,
        =?UTF-8?Q?Tomasz_Pawe=C5=82_Gajc?= <tpgxyz@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 10:37 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Fixes the following 2 issues in the driver:
> 1. Left shifting a signed integer is undefined behavior. Unsigned
>    integral types should be used for bitwise operations.
> 2. The delay scales from 0x0010 to 0x20000 by powers of 2, but udelay
>    will result in a linkage failure when given a constant that's greater
>    than 20000 (0x4E20). Agressive loop unrolling can fully unroll the
>    loop, resulting in later iterations overflowing the call to udelay.
>
> 2 is fixed via splitting the loop in two, iterating the first up to the
> point where udelay would overflow, then switching to mdelay, as
> suggested in Documentation/timers/timers-howto.rst.
>
> Reported-by: Tomasz Pawe=C5=82 Gajc <tpgxyz@gmail.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/678
> Debugged-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  drivers/hwmon/applesmc.c | 35 +++++++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> index 183ff3d25129..2bc12812f52f 100644
> --- a/drivers/hwmon/applesmc.c
> +++ b/drivers/hwmon/applesmc.c
> @@ -46,6 +46,7 @@
>  #define APPLESMC_MIN_WAIT      0x0010
>  #define APPLESMC_RETRY_WAIT    0x0100
>  #define APPLESMC_MAX_WAIT      0x20000
> +#define APPLESMC_UDELAY_MAX    20000
>
>  #define APPLESMC_READ_CMD      0x10
>  #define APPLESMC_WRITE_CMD     0x11
> @@ -157,14 +158,23 @@ static struct workqueue_struct *applesmc_led_wq;
>  static int wait_read(void)
>  {
>         u8 status;
> -       int us;
> -       for (us =3D APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<=3D 1=
) {
> +       unsigned int us;
> +
> +       for (us =3D APPLESMC_MIN_WAIT; us < APPLESMC_UDELAY_MAX; us <<=3D=
 1) {
>                 udelay(us);
>                 status =3D inb(APPLESMC_CMD_PORT);
>                 /* read: wait for smc to settle */
>                 if (status & 0x01)
>                         return 0;
>         }
> +       /* switch to mdelay for longer sleeps */
> +       for (; us < APPLESMC_MAX_WAIT; us <<=3D 1) {
> +               mdelay(us);
> +               status =3D inb(APPLESMC_CMD_PORT);
> +               /* read: wait for smc to settle */
> +               if (status & 0x01)
> +                       return 0;
> +       }
>
>         pr_warn("wait_read() fail: 0x%02x\n", status);
>         return -EIO;
> @@ -177,10 +187,10 @@ static int wait_read(void)
>  static int send_byte(u8 cmd, u16 port)
>  {
>         u8 status;
> -       int us;
> +       unsigned int us;
>
>         outb(cmd, port);
> -       for (us =3D APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<=3D 1=
) {
> +       for (us =3D APPLESMC_MIN_WAIT; us < APPLESMC_UDELAY_MAX; us <<=3D=
 1) {
>                 udelay(us);
>                 status =3D inb(APPLESMC_CMD_PORT);
>                 /* write: wait for smc to settle */
> @@ -196,6 +206,23 @@ static int send_byte(u8 cmd, u16 port)
>                 udelay(APPLESMC_RETRY_WAIT);
>                 outb(cmd, port);
>         }
> +       /* switch to mdelay for longer sleeps */
> +       for (; us < APPLESMC_MAX_WAIT; us <<=3D 1) {
> +               mdelay(us);
> +               status =3D inb(APPLESMC_CMD_PORT);
> +               /* write: wait for smc to settle */
> +               if (status & 0x02)
> +                       continue;
> +               /* ready: cmd accepted, return */
> +               if (status & 0x04)
> +                       return 0;
> +               /* timeout: give up */
> +               if (us << 1 =3D=3D APPLESMC_MAX_WAIT)
> +                       break;

Sorry, I need to modify the first for loop in this function to break
out properly. v2 inbound.

> +               /* busy: long wait and resend */
> +               udelay(APPLESMC_RETRY_WAIT);
> +               outb(cmd, port);
> +       }
>
>         pr_warn("send_byte(0x%02x, 0x%04x) fail: 0x%02x\n", cmd, port, st=
atus);
>         return -EIO;
> --
> 2.23.0.351.gc4317032e6-goog
>


--=20
Thanks,
~Nick Desaulniers
