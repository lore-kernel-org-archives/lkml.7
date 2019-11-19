Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445DDC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264FA222DD
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfKSLaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:30:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:60568 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725280AbfKSLaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:30:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2D790BC27;
        Tue, 19 Nov 2019 11:30:28 +0000 (UTC)
Date:   Tue, 19 Nov 2019 12:30:27 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Jonathan Richardson <jonathan.richardson@broadcom.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        sergey.senozhatsky@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: console output duplicated when registering additional consoles
Message-ID: <20191119113027.74lp3dsg5ftvylp4@pathway.suse.cz>
References: <CAHrpVsUHgJA3wjh4fDg43y5OFCCvQb-HSRpyGyhFEKXcWw8WnQ@mail.gmail.com>
 <CAHrpVsW6jRUYK_mu+dLaBvucAAtUPQ0zcH6_NxsUsTrPewiY_w@mail.gmail.com>
 <20191114095737.wl5nvxu3w6p5thfc@pathway.suse.cz>
 <20191115043356.GA220831@google.com>
 <CAHrpVsWu54rKg3bGhY6WVj5d-myYxGSEkxGhOJKTyyc1EH4qOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHrpVsWu54rKg3bGhY6WVj5d-myYxGSEkxGhOJKTyyc1EH4qOA@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-11-18 13:38:04, Jonathan Richardson wrote:
> On Thu, Nov 14, 2019 at 8:33 PM Sergey Senozhatsky
> <sergey.senozhatsky.work@gmail.com> wrote:
> >
> > Gosh, that part of printk is really complex.
> >
> > On (19/11/14 10:57), Petr Mladek wrote:
> > > For a proper solution we would need to match boot and real
> > > consoles that write messages into the physical device.
> > > But I am afraid that there is no support for this.
> >
> > Wouldn't those have same tty driver?

Interesting idea. Well, do early consoles have tty driver?

> > ---
> >
> >  kernel/printk/printk.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index f1b08015d3fa..a84cb20acf42 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2690,6 +2690,19 @@ static int __init keep_bootcon_setup(char *str)
> >
> >  early_param("keep_bootcon", keep_bootcon_setup);
> >
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
> Thanks.

Jonathan, have you tried this patch, please?
Does it solve your problem?

Best Regards,
Petr
