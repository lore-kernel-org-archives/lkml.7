Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B80C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 00:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61AEE22313
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 00:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdSa8VqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKSAfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 19:35:03 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39698 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfKSAfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 19:35:03 -0500
Received: by mail-pj1-f65.google.com with SMTP id t103so2003660pjb.6;
        Mon, 18 Nov 2019 16:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FN106ZUWWfNYwsB0PRZFSrGY6XvVfYNB96qNuOPH1T0=;
        b=rdSa8VqByecMeeFhXC93q1cjf2TEgfSBNQv2wWcWqptlTltoqwJPXcLpHIxvRDRJjf
         gyIgtbgAs5SHmZBp5dUcMBZyr9Ge1tyLuxPKj+ZWOpxuN0PpdQcNowZOlPqiuFae87BF
         joU2w8BJwq5ks1saq66N6OPfQNmgpj544Z/s5MJDNPcgWksWo4ZcSu3LumEknEQ3AsNV
         aE8Dfu5hQkhZaxUt7bz6F50MT7tE80bkjw6YjfK+PopBbUbxElrveWu9dcG1GWlTxrb7
         wtT+qhXkoEBpwlmYcifWKrRFGzqHh8cWfKY3gdrE6hIEINoqz+lJSH1+8UDAe6htcaZz
         uvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FN106ZUWWfNYwsB0PRZFSrGY6XvVfYNB96qNuOPH1T0=;
        b=qRMW3x0vfgGNhjacRRD9WhA1RT9kPoCOHuSE/n1l0h2H5P7KURMBTqlenqcHqs2QcI
         O4+h+0nIP7vl01IogIEqsV4Y4LyVuO3onytjhvFJ6/LieZskxIroFqlzEJgviozRYn/+
         iMdqeRkesUYFMKe9p7i2Zp7h2ZGJz3upq94idwEEa3MExQuiI0bisEFJ+6JOTj/HeHW1
         6x+0hoLOEzHHECn1nzqWZFlkx7X7B2BXTuLkjTEG3Y7RPiyPs7f9/I92tbMBraqqHeUn
         SiebP0hulYFZz2RoTth/Mvt64yToLK1KOgdQW68WHPfuFxTRS0dRn9FAmMrCIoKi6AtG
         v9pg==
X-Gm-Message-State: APjAAAXq540vvxFpLoA/DcRm8u9PT4O8SORTvXB8nbquSQUK0f/Exc3V
        rrevt1X5fjnWLOmuXp874k/l1wvs
X-Google-Smtp-Source: APXvYqx8imSoCelGePuMMcUv7Yj0PTuLKkJusvuGIi7LqQSoOhpv3q5echKXeY8P/Tfovw5dyMxD5A==
X-Received: by 2002:a17:902:868f:: with SMTP id g15mr31481417plo.294.1574123701089;
        Mon, 18 Nov 2019 16:35:01 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id f185sm23241602pfb.183.2019.11.18.16.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 16:34:59 -0800 (PST)
Date:   Tue, 19 Nov 2019 09:34:57 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Jonathan Richardson <jonathan.richardson@broadcom.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>, gregkh@linuxfoundation.org,
        jslaby@suse.com, sergey.senozhatsky@gmail.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: console output duplicated when registering additional consoles
Message-ID: <20191119003457.GA208047@google.com>
References: <CAHrpVsUHgJA3wjh4fDg43y5OFCCvQb-HSRpyGyhFEKXcWw8WnQ@mail.gmail.com>
 <CAHrpVsW6jRUYK_mu+dLaBvucAAtUPQ0zcH6_NxsUsTrPewiY_w@mail.gmail.com>
 <20191114095737.wl5nvxu3w6p5thfc@pathway.suse.cz>
 <20191115043356.GA220831@google.com>
 <CAHrpVsWu54rKg3bGhY6WVj5d-myYxGSEkxGhOJKTyyc1EH4qOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHrpVsWu54rKg3bGhY6WVj5d-myYxGSEkxGhOJKTyyc1EH4qOA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (19/11/18 13:38), Jonathan Richardson wrote:
> > +static bool known_console_driver(struct console *newcon)
> > +{
> > +       struct console *con;
> > +
> > +       for_each_console(con) {
> > +               if (!(con->flags & CON_ENABLED))
> > +                       continue;
> > +               if (con->device && con->device == newcon->device)
> > +                       return true;
> > +       }
> > +       return false;
> > +}
> > +
> >  /*
> >   * The console driver calls this routine during kernel initialization
> >   * to register the console printing procedure with printk() and to
> > @@ -2828,6 +2841,9 @@ void register_console(struct console *newcon)
> >         if (newcon->flags & CON_EXTENDED)
> >                 nr_ext_console_drivers++;
> >
> > +       if (known_console_driver(newcon))
> > +               newcon->flags &= ~CON_PRINTBUFFER;
> > +
> >         if (newcon->flags & CON_PRINTBUFFER) {
> >                 /*
> >                  * console_unlock(); will print out the buffered messages
>
> Thanks. It also needs to be cleared when the second console driver is
> registered (of the same type, boot or normal)

The second 'normal' console can be, for instance, netcon - it's sort
of OK to have CON_PRINTBUFFER tty and CON_PRINTBUFFER netcon consoles.

Maybe

> not just when a normal con replaces a bootconsole. A simple way of
> avoiding the problem I'm seeing is to not even set the CON_PRINTBUFFER
> flag on my consoles.

This is up to the console driver to decide.

> It skips the replay and the output on all consoles looks fine. The flag
> is only used by register_console(), although I don't think that is the
> intended usage? There are no console drivers that do this.

Not sure I'm following. There are consoles that want all logbuf messages
once those consoles are available.

$ git grep "\.flags" drivers/tty/ | grep -c CON_PRINTBUFFER
72

	-ss
