Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B856C4320D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295D4214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CY37DBXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441916AbfIXTlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 15:41:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39926 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441488AbfIXTlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 15:41:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id v17so1429192wml.4;
        Tue, 24 Sep 2019 12:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XhC3wq4vnz9dCrPPtANW7Gd6kr94sSY1a0mgkc8r4EQ=;
        b=CY37DBXd/SmJAW/5GRkDACbXmmmc6o36VZIzoHxKUwCvcIpTDy7X9dgve7XlJu9HYw
         97lK0EO8fH3fwaFl+k9XVhOL8cPdJklTlwOj33qGoH5mBCfU11BUP468WLmU2/APuzi6
         6Y/JGdDzc+iitdMcsLLJOG45f17zG4Urd5par51PNtvDeO4soTKZV/Frux/lx+8kkR5o
         DQY7RxxHibK/Tl0/ntBAtIcEbd6qrCqvN77PPKGrtYRCDM4e+m0HVHlRXGtk+WNUtZAk
         852SbCoHhRv6AGvGs28A5iGB+mgnNfR5kHtxFuXT46EDdwiA14K1AQvUFmx/Ms4BfDId
         66pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XhC3wq4vnz9dCrPPtANW7Gd6kr94sSY1a0mgkc8r4EQ=;
        b=t0uVFjtgUO0Tirek/zY1R+0KNFATJdExaZ2iCB9tsHZsFQd4QaEKMZoeGejhVaV/9n
         AMwO/hhBdIYPho7xBHC2eBEo0HD93yv7o3JJyDsL4OdhmYhGY8Q4kOvPEIjICG3wbXQs
         0KQNhdTtgsCtRZviVqLDS2Cu9wpHHhN1OmBTCY8xUJlDbKHwnaAJ8q/wdJ6gGy3v5tKY
         OwADicNrPwpS7aTqqvWcTm9v3tvwRfHkLcz4sYlRd16IygUScDQm7CNpOmztlVk/BcJq
         rhFCptgwD7h7PlXD9FoCLPi5omYzp56D94zncY91IrM7VV21YhestdwCrEC+tDnXtbF3
         7R0A==
X-Gm-Message-State: APjAAAVzY3z+0NGMl3MnqLgboBVwGPXC+wfonf7i8ZeJlhdpbEmdiTEe
        H8Ezb2xU6JZ6++8T9urvoRM=
X-Google-Smtp-Source: APXvYqy3HRtteEbMdRKHil1aXcmwlPxU0IHqRVSyOwMTsaJLIes+WEuQwzm0WxNP0Z4LB4SBhD3qIA==
X-Received: by 2002:a7b:c92d:: with SMTP id h13mr2042376wml.169.1569354101320;
        Tue, 24 Sep 2019 12:41:41 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id h9sm1792281wrv.30.2019.09.24.12.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 12:41:40 -0700 (PDT)
Date:   Tue, 24 Sep 2019 12:41:39 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        jdelvare@suse.com,
        Tomasz =?utf-8?B?UGF3ZcWC?= Gajc <tpgxyz@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] hwmon: (applesmc) fix UB and udelay overflow
Message-ID: <20190924194139.GA3597785@archlinux-threadripper>
References: <CAKwvOd=GVdHhsdHOMpuhEKkWMssW37keqX5c59+6fiEgLs+Q1g@mail.gmail.com>
 <20190924174728.201464-1-ndesaulniers@google.com>
 <20190924183827.GA2800937@archlinux-threadripper>
 <CAKwvOdmVfyhG85BHdaHgc23RuRkJJnvd2bLUEzNNpZDuqJ79mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdmVfyhG85BHdaHgc23RuRkJJnvd2bLUEzNNpZDuqJ79mw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 12:36:44PM -0700, Nick Desaulniers wrote:
> On Tue, Sep 24, 2019 at 11:38 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Tue, Sep 24, 2019 at 10:47:28AM -0700, Nick Desaulniers wrote:
> > > Fixes the following 2 issues in the driver:
> > > 1. Left shifting a signed integer is undefined behavior. Unsigned
> > >    integral types should be used for bitwise operations.
> > > 2. The delay scales from 0x0010 to 0x20000 by powers of 2, but udelay
> > >    will result in a linkage failure when given a constant that's greater
> > >    than 20000 (0x4E20). Agressive loop unrolling can fully unroll the
> > >    loop, resulting in later iterations overflowing the call to udelay.
> > >
> > > 2 is fixed via splitting the loop in two, iterating the first up to the
> > > point where udelay would overflow, then switching to mdelay, as
> > > suggested in Documentation/timers/timers-howto.rst.
> > >
> > > Reported-by: Tomasz Paweł Gajc <tpgxyz@gmail.com>
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/678
> > > Debugged-by: Nathan Chancellor <natechancellor@gmail.com>
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > ---
> > > Changes V1 -> V2:
> > > * The first loop in send_byte() needs to break out on the same condition
> > >   now. Technically, the loop condition could even be removed. The diff
> > >   looks funny because of the duplicated logic between existing and newly
> > >   added for loops.
> > >
> > >  drivers/hwmon/applesmc.c | 35 +++++++++++++++++++++++++++++++----
> > >  1 file changed, 31 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> > > index 183ff3d25129..c76adb504dff 100644
> > > --- a/drivers/hwmon/applesmc.c
> > > +++ b/drivers/hwmon/applesmc.c
> > > @@ -46,6 +46,7 @@
> > >  #define APPLESMC_MIN_WAIT    0x0010
> > >  #define APPLESMC_RETRY_WAIT  0x0100
> > >  #define APPLESMC_MAX_WAIT    0x20000
> > > +#define APPLESMC_UDELAY_MAX  20000
> > >
> > >  #define APPLESMC_READ_CMD    0x10
> > >  #define APPLESMC_WRITE_CMD   0x11
> > > @@ -157,14 +158,23 @@ static struct workqueue_struct *applesmc_led_wq;
> > >  static int wait_read(void)
> > >  {
> > >       u8 status;
> > > -     int us;
> > > -     for (us = APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<= 1) {
> > > +     unsigned int us;
> > > +
> > > +     for (us = APPLESMC_MIN_WAIT; us < APPLESMC_UDELAY_MAX; us <<= 1) {
> > >               udelay(us);
> > >               status = inb(APPLESMC_CMD_PORT);
> > >               /* read: wait for smc to settle */
> > >               if (status & 0x01)
> > >                       return 0;
> > >       }
> > > +     /* switch to mdelay for longer sleeps */
> > > +     for (; us < APPLESMC_MAX_WAIT; us <<= 1) {
> > > +             mdelay(us);
> > > +             status = inb(APPLESMC_CMD_PORT);
> > > +             /* read: wait for smc to settle */
> > > +             if (status & 0x01)
> > > +                     return 0;
> > > +     }
> > >
> > >       pr_warn("wait_read() fail: 0x%02x\n", status);
> > >       return -EIO;
> > > @@ -177,10 +187,10 @@ static int wait_read(void)
> > >  static int send_byte(u8 cmd, u16 port)
> > >  {
> > >       u8 status;
> > > -     int us;
> > > +     unsigned int us;
> > >
> > >       outb(cmd, port);
> > > -     for (us = APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<= 1) {
> > > +     for (us = APPLESMC_MIN_WAIT; us < APPLESMC_UDELAY_MAX; us <<= 1) {
> > >               udelay(us);
> > >               status = inb(APPLESMC_CMD_PORT);
> > >               /* write: wait for smc to settle */
> > > @@ -190,6 +200,23 @@ static int send_byte(u8 cmd, u16 port)
> > >               if (status & 0x04)
> > >                       return 0;
> > >               /* timeout: give up */
> > > +             if (us << 1 == APPLESMC_UDELAY_MAX)
> > > +                     break;
> > > +             /* busy: long wait and resend */
> > > +             udelay(APPLESMC_RETRY_WAIT);
> > > +             outb(cmd, port);
> > > +     }
> > > +     /* switch to mdelay for longer sleeps */
> > > +     for (; us < APPLESMC_MAX_WAIT; us <<= 1) {
> > > +             mdelay(us);
> > > +             status = inb(APPLESMC_CMD_PORT);
> > > +             /* write: wait for smc to settle */
> > > +             if (status & 0x02)
> > > +                     continue;
> > > +             /* ready: cmd accepted, return */
> > > +             if (status & 0x04)
> > > +                     return 0;
> > > +             /* timeout: give up */
> > >               if (us << 1 == APPLESMC_MAX_WAIT)
> > >                       break;
> > >               /* busy: long wait and resend */
> > > --
> > > 2.23.0.351.gc4317032e6-goog
> > >
> >
> > This resolves the __bad_udelay appearance at -O3 for me. I am not
> > familiar enough with this code to give a reviewed by though!
> 
> Does that constitute a Tested-by tag?

Given that this could have real implications for the hardware, I would
think tested by would imply running this on said hardware. FWIW:

Build-tested-by: Nathan Chancellor <natechancellor@gmail.com>

> >
> > Also, for some odd reason, I couldn't apply your patch with 'git apply':
> >
> > % curl -LSs https://lore.kernel.org/lkml/20190924174728.201464-1-ndesaulniers@google.com/raw | git apply
> > error: corrupt patch at line 117
> >
> > It looks like some of the '=' got changed into =3D and some spaces got
> > changed into =20. Weird encoding glitch?
> 
> The text in my email client shows no encoding error; the link above
> shows the issue.  Attaching a copy here, in case git-send-email
> related.

Yes, appears git send-email related because your attached patch applies
just fine.

Cheers,
Nathan
