Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3A5C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14AC72072B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FJ0dExR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfLTSEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:04:15 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35256 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfLTSEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 13:04:14 -0500
Received: by mail-pg1-f195.google.com with SMTP id l24so5319484pgk.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 10:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=52Gk/VaXrSmPzcos2yNkL/HEF6ayuibFpqM231tfu30=;
        b=FJ0dExR9GXViv86qdSt98OHtWPuMo+PECDEq4JyEp1GZ5XqLGAAcBbkoNlvQ22O2tG
         ONfngWRxptHOJUpxwSHfoWVzIumRFNq7QEE8Q33Fzs6xWEx+seZnFNYCuJwmKDg1L/91
         5v3slVOXKUtGiZs2A3dbA7mDK4Linjaq15vQYtGjtauwojLeiwxrtBeUZsTaXpgfOs1C
         7rrPTHrB3gS6mLRaKHEx/KJ29CJfd8GPc2K/09iv/ulpdLZHN8BDTHk3rRllqKPB28mi
         eh9dGU6nDjYMaZhTscuvkOIsFwQmtRc5UMmEqkxLnWYN2bRGca9nCgAg1GiVWm2TwPaB
         kPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=52Gk/VaXrSmPzcos2yNkL/HEF6ayuibFpqM231tfu30=;
        b=dOChkne5MJy4NJO1bZd7u/H5+KWnJlHzgM7mHikDN7KudwOnKh7tGzhLPcDKcKa53r
         ygUnoVi7+u6iEsr7sQmKsviV2gwCpRmkMJjGDLUJOXXkMU3tM4GPutDpJmMAl7SQJt5g
         CAF2NKvgENOVpbCBo8Mu153zmjIWcDD7tsohBTvGIaH8A6DRRcz8uy//c360Ggf8t1Oo
         GZbHoPBXtm50iZcZCZhqakfnginW5TQM4obMvy1uazyWxnC6vSDH4p1QXkg+0qj9AfPf
         VSk6Ce26OyzOD3ZQZZ/80urO/MI8+yIlO2jJN7+Syyuz3lZmMLm4aG70cae+RHP2ZBuz
         HP2Q==
X-Gm-Message-State: APjAAAU3gBoECHvG+fkI05gryDaP3HDVuEUSF3K2LUwDDInG2jli6C8A
        8YWozy1fsOezXMUu5TyLGVZaTeKhXAMGPJ2JImDVqg==
X-Google-Smtp-Source: APXvYqyZE72QwX4P8PButLipqhBfPWh40ZmZX0mq4s4FluVgsXKVp4N0yyPNe8lvuscXK6MyvSamXzNCNh1FbPXqd2A=
X-Received: by 2002:a63:f24b:: with SMTP id d11mr15965153pgk.381.1576865053620;
 Fri, 20 Dec 2019 10:04:13 -0800 (PST)
MIME-Version: 1.0
References: <20191218022758.53697-1-natechancellor@gmail.com>
In-Reply-To: <20191218022758.53697-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 20 Dec 2019 10:04:02 -0800
Message-ID: <CAKwvOdnOYUy7M0upKsknwPJOa6iYwtaqZAafrxdb4z_=vDmuXw@mail.gmail.com>
Subject: Re: [PATCH] tty: synclink: Adjust indentation and style in several functions
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 6:28 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> ../drivers/tty/synclink.c:1167:3: warning: misleading indentation;
> statement is not part of the previous 'if' [-Wmisleading-indentation]
>         if ( (status & RXSTATUS_ABORT_RECEIVED) &&
>         ^
> ../drivers/tty/synclink.c:1163:2: note: previous statement is here
>         if ( debug_level >= DEBUG_LEVEL_ISR )
>         ^
> ../drivers/tty/synclink.c:1973:3: warning: misleading indentation;
> statement is not part of the previous 'if' [-Wmisleading-indentation]
>         if (I_BRKINT(info->port.tty) || I_PARMRK(info->port.tty))
>         ^
> ../drivers/tty/synclink.c:1971:2: note: previous statement is here
>         if (I_INPCK(info->port.tty))
>         ^
> ../drivers/tty/synclink.c:3229:3: warning: misleading indentation;
> statement is not part of the previous 'else' [-Wmisleading-indentation]
>         usc_set_serial_signals(info);
>         ^
> ../drivers/tty/synclink.c:3227:2: note: previous statement is here
>         else
>         ^
> ../drivers/tty/synclink.c:4918:4: warning: misleading indentation;
> statement is not part of the previous 'else' [-Wmisleading-indentation]
>                 if ( info->params.clock_speed )
>                 ^
> ../drivers/tty/synclink.c:4901:3: note: previous statement is here
>                 else
>                 ^
> 4 warnings generated.
>
> The indentation on these lines is not at all consistent, tabs and spaces
> are mixed together. Convert to just using tabs to be consistent with the
> Linux kernel coding style and eliminate these warnings from clang.
>
> Additionally, clean up some of lines touched by the indentation shift to
> eliminate checkpatch warnings and leave this code in a better condition
> than when it was left.

Indeed, this file is kind of a mess.

>
> -:10: ERROR: trailing whitespace
> -:10: ERROR: that open brace { should be on the previous line
> -:10: ERROR: space prohibited after that open parenthesis '('
> -:14: ERROR: space prohibited before that close parenthesis ')'
> -:82: ERROR: trailing whitespace
> -:87: WARNING: Block comments use a trailing */ on a separate line
> -:88: ERROR: that open brace { should be on the previous line
> -:88: ERROR: space prohibited after that open parenthesis '('
> -:88: ERROR: space prohibited before that close parenthesis ')'
> -:99: ERROR: else should follow close brace '}'
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/821
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/tty/synclink.c | 55 ++++++++++++++++++++----------------------
>  1 file changed, 26 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
> index 61dc6b4a43d0..586810defb21 100644
> --- a/drivers/tty/synclink.c
> +++ b/drivers/tty/synclink.c
> @@ -1164,21 +1164,20 @@ static void mgsl_isr_receive_status( struct mgsl_struct *info )
>                 printk("%s(%d):mgsl_isr_receive_status status=%04X\n",
>                         __FILE__,__LINE__,status);
>
> -       if ( (status & RXSTATUS_ABORT_RECEIVED) &&
> +       if ((status & RXSTATUS_ABORT_RECEIVED) &&
>                 info->loopmode_insert_requested &&
> -               usc_loopmode_active(info) )
> -       {
> +               usc_loopmode_active(info)) {
>                 ++info->icount.rxabort;
> -               info->loopmode_insert_requested = false;
> -
> -               /* clear CMR:13 to start echoing RxD to TxD */
> +               info->loopmode_insert_requested = false;
> +
> +               /* clear CMR:13 to start echoing RxD to TxD */
>                 info->cmr_value &= ~BIT13;
> -               usc_OutReg(info, CMR, info->cmr_value);
> -
> +               usc_OutReg(info, CMR, info->cmr_value);
> +
>                 /* disable received abort irq (no longer required) */
> -               usc_OutReg(info, RICR,
> -                       (usc_InReg(info, RICR) & ~RXSTATUS_ABORT_RECEIVED));
> -       }
> +               usc_OutReg(info, RICR,
> +                       (usc_InReg(info, RICR) & ~RXSTATUS_ABORT_RECEIVED));
> +       }
>
>         if (status & (RXSTATUS_EXITED_HUNT | RXSTATUS_IDLE_RECEIVED)) {
>                 if (status & RXSTATUS_EXITED_HUNT)
> @@ -1970,8 +1969,8 @@ static void mgsl_change_params(struct mgsl_struct *info)

I'm surprised the next hunk isn't mgsl_isr_transmit_status() in
L1211-L1268?  I don't mind reformatting this file, but would you mind:
1. splitting the changes that fix the warning and reformatting the
rest of the file in two?  That way the warning fix is more likely to
merge back cleanly to LTS branches with less risk of merge conflict?
Warning fix first, then reformat.
2. reformat the whole thing, not just most of it.

It's easier to see if you set up your editor to highlight all tabs and spaces.

mgsl_isr_io_pin() for instance has trailing tabs, tabs between
`struct` and `mgsl_icount`...

mgsl_change_params() has tabs followed by spaces followed by nothing...

>         info->read_status_mask = RXSTATUS_OVERRUN;
>         if (I_INPCK(info->port.tty))
>                 info->read_status_mask |= RXSTATUS_PARITY_ERROR | RXSTATUS_FRAMING_ERROR;
> -       if (I_BRKINT(info->port.tty) || I_PARMRK(info->port.tty))
> -               info->read_status_mask |= RXSTATUS_BREAK_RECEIVED;
> +       if (I_BRKINT(info->port.tty) || I_PARMRK(info->port.tty))
> +               info->read_status_mask |= RXSTATUS_BREAK_RECEIVED;
>
>         if (I_IGNPAR(info->port.tty))
>                 info->ignore_status_mask |= RXSTATUS_PARITY_ERROR | RXSTATUS_FRAMING_ERROR;
> @@ -3211,7 +3210,7 @@ static int carrier_raised(struct tty_port *port)
>         struct mgsl_struct *info = container_of(port, struct mgsl_struct, port);
>
>         spin_lock_irqsave(&info->irq_spinlock, flags);
> -       usc_get_serial_signals(info);
> +       usc_get_serial_signals(info);
>         spin_unlock_irqrestore(&info->irq_spinlock, flags);
>         return (info->serial_signals & SerialSignal_DCD) ? 1 : 0;
>  }
> @@ -3226,7 +3225,7 @@ static void dtr_rts(struct tty_port *port, int on)
>                 info->serial_signals |= SerialSignal_RTS | SerialSignal_DTR;
>         else
>                 info->serial_signals &= ~(SerialSignal_RTS | SerialSignal_DTR);
> -       usc_set_serial_signals(info);
> +       usc_set_serial_signals(info);
>         spin_unlock_irqrestore(&info->irq_spinlock,flags);
>  }
>
> @@ -4907,24 +4906,22 @@ static void usc_set_sdlc_mode( struct mgsl_struct *info )
>                 /*  of rounding up and then subtracting 1 we just don't subtract */
>                 /*  the one in this case. */
>
> -               /*--------------------------------------------------
> -                * ejz: for DPLL mode, application should use the
> -                * same clock speed as the partner system, even
> -                * though clocking is derived from the input RxData.
> -                * In case the user uses a 0 for the clock speed,
> -                * default to 0xffffffff and don't try to divide by
> -                * zero
> -                *--------------------------------------------------*/
> -               if ( info->params.clock_speed )
> -               {
> +               /*
> +                * ejz: for DPLL mode, application should use the
> +                * same clock speed as the partner system, even
> +                * though clocking is derived from the input RxData.
> +                * In case the user uses a 0 for the clock speed,
> +                * default to 0xffffffff and don't try to divide by
> +                * zero
> +                */
> +               if (info->params.clock_speed) {
>                         Tc = (u16)((XtalSpeed/DpllDivisor)/info->params.clock_speed);
>                         if ( !((((XtalSpeed/DpllDivisor) % info->params.clock_speed) * 2)
>                                / info->params.clock_speed) )
>                                 Tc--;
> -               }
> -               else
> -                       Tc = -1;
> -
> +               } else {
> +                       Tc = -1;
> +               }
>
>                 /* Write 16-bit Time Constant for BRG1 */
>                 usc_OutReg( info, TC1R, Tc );
> --
> 2.24.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20191218022758.53697-1-natechancellor%40gmail.com.



-- 
Thanks,
~Nick Desaulniers
