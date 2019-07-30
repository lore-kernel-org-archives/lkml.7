Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0187C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99103208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564501104;
	bh=UuPKdfs5BLdDE8f1jc0otSMWO5+pfZcQAJmf6u5hiO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YR2ytzPW4JkB+oDwflpuAu/6mPJOWi9UU4DTkI6R3WrJIpksnSh8CP1P/97LglDvB
	 0LEFbQUPz0GvZ7TUZ9h4rrhUqn8uZVaWxFzTQcSzDvksOLbTp7DxpzCS+ep6BfZlLY
	 S998p0Bj3YT3oPtJONrpdi4mY1SJxsPR3Xw9eQfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732470AbfG3PiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:38:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727723AbfG3PiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:38:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 854F72089E;
        Tue, 30 Jul 2019 15:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564501101;
        bh=UuPKdfs5BLdDE8f1jc0otSMWO5+pfZcQAJmf6u5hiO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BUTZZdpnLH5oDMqskfndGqzfqGwHwNTj9ImZuvM0+vMz7og3LiqRye1ZOoK1HHTjC
         0pfepWhSgw6I3ofYY+MMKTKZs7lEojG/MukUlthhf66u67UyXJt4dvpTUJQejIonZK
         I2Tcm8gneESjxPlr2kqdrs3o3FFe5O1TAwGAry1A=
Date:   Tue, 30 Jul 2019 17:38:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>, Jiri Slaby <jslaby@suse.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH] kgdboc: disable the console lock when in kgdb
Message-ID: <20190730153818.GA1025@kroah.com>
References: <20190725183551.169208-1-dianders@chromium.org>
 <20190726091630.GA20016@kroah.com>
 <CAD=FV=WVaksqBE4HBTMZwV1hv6_FJMmAqF+kWBpdfvsHQyRkSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WVaksqBE4HBTMZwV1hv6_FJMmAqF+kWBpdfvsHQyRkSA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 09:19:21AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Fri, Jul 26, 2019 at 2:16 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jul 25, 2019 at 11:35:51AM -0700, Douglas Anderson wrote:
> > > After commit ddde3c18b700 ("vt: More locking checks") kdb / kgdb has
> > > become useless because my console is filled with spews of:
> > >
> > > WARNING: CPU: 0 PID: 0 at .../drivers/tty/vt/vt.c:3846 con_is_visible+0x50/0x74
> > > CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.3.0-rc1+ #48
> > > Hardware name: Rockchip (Device Tree)
> > > Backtrace:
> > > [<c020ce9c>] (dump_backtrace) from [<c020d188>] (show_stack+0x20/0x24)
> > > [<c020d168>] (show_stack) from [<c0a8fc14>] (dump_stack+0xb0/0xd0)
> > > [<c0a8fb64>] (dump_stack) from [<c0232c58>] (__warn+0xec/0x11c)
> > > [<c0232b6c>] (__warn) from [<c0232dc4>] (warn_slowpath_null+0x4c/0x58)
> > > [<c0232d78>] (warn_slowpath_null) from [<c06338a0>] (con_is_visible+0x50/0x74)
> > > [<c0633850>] (con_is_visible) from [<c0634078>] (con_scroll+0x108/0x1ac)
> > > [<c0633f70>] (con_scroll) from [<c0634160>] (lf+0x44/0x88)
> > > [<c063411c>] (lf) from [<c06363ec>] (vt_console_print+0x1a4/0x2bc)
> > > [<c0636248>] (vt_console_print) from [<c02f628c>] (vkdb_printf+0x420/0x8a4)
> > > [<c02f5e6c>] (vkdb_printf) from [<c02f6754>] (kdb_printf+0x44/0x60)
> > > [<c02f6714>] (kdb_printf) from [<c02fa6f4>] (kdb_main_loop+0xf4/0x6e0)
> > > [<c02fa600>] (kdb_main_loop) from [<c02fd5f0>] (kdb_stub+0x268/0x398)
> > > [<c02fd388>] (kdb_stub) from [<c02f3ba0>] (kgdb_cpu_enter+0x1f8/0x674)
> > > [<c02f39a8>] (kgdb_cpu_enter) from [<c02f4330>] (kgdb_handle_exception+0x1c4/0x1fc)
> > > [<c02f416c>] (kgdb_handle_exception) from [<c0210fe0>] (kgdb_compiled_brk_fn+0x30/0x3c)
> > > [<c0210fb0>] (kgdb_compiled_brk_fn) from [<c020d7ac>] (do_undefinstr+0x180/0x1a0)
> > > [<c020d62c>] (do_undefinstr) from [<c0201b44>] (__und_svc_finish+0x0/0x3c)
> > > ...
> > > [<c02f3224>] (kgdb_breakpoint) from [<c02f3310>] (sysrq_handle_dbg+0x58/0x6c)
> > > [<c02f32b8>] (sysrq_handle_dbg) from [<c062abf0>] (__handle_sysrq+0xac/0x154)
> > >
> > > Let's disable this warning when we're in kgdb to avoid the spew.  The
> > > whole system is stopped when we're in kgdb so we can't exactly wait
> > > for someone else to drop the lock.  Presumably the best we can do is
> > > to disable the warning and hope for the best.
> > >
> > > Fixes: ddde3c18b700 ("vt: More locking checks")
> > > Cc: Daniel Vetter <daniel.vetter@intel.com>
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > >
> > >  drivers/tty/serial/kgdboc.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> > > index bfe5e9e034ec..c7d51b51898f 100644
> > > --- a/drivers/tty/serial/kgdboc.c
> > > +++ b/drivers/tty/serial/kgdboc.c
> > > @@ -277,10 +277,14 @@ static void kgdboc_pre_exp_handler(void)
> > >       /* Increment the module count when the debugger is active */
> > >       if (!kgdb_connected)
> > >               try_module_get(THIS_MODULE);
> > > +
> > > +     atomic_inc(&ignore_console_lock_warning);
> > >  }
> > >
> > >  static void kgdboc_post_exp_handler(void)
> > >  {
> > > +     atomic_dec(&ignore_console_lock_warning);
> > > +
> > >       /* decrement the module count when the debugger detaches */
> > >       if (!kgdb_connected)
> > >               module_put(THIS_MODULE);
> > > --
> > > 2.22.0.709.g102302147b-goog
> >
> > I have the following patch in my tree to go to Linus that I think might
> > fix this issue for you.  Can you test it instead?
> >
> > thanks,
> >
> > greg k-h
> >
> > -----------------
> >
> >
> > From 61d51456f35760a09e8aa1e6ddd247f1547015d3 Mon Sep 17 00:00:00 2001
> > From: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Date: Thu, 18 Jul 2019 10:09:03 +0200
> > Subject: [PATCH] vt: Grab console_lock around con_is_bound in show_bind
> >
> > Not really harmful not to, but also not harm in grabbing the lock. And
> > this shuts up a new WARNING I introduced in commit ddde3c18b700 ("vt:
> > More locking checks").
> >
> > Reported-by: Jens Remus <jremus@linux.ibm.com>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-fbdev@vger.kernel.org
> > Cc: linux-s390@vger.kernel.org
> > Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> > Cc: Martin Hostettler <textshell@uchuujin.de>
> > Cc: Adam Borowski <kilobyte@angband.pl>
> > Cc: Mikulas Patocka <mpatocka@redhat.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Fixes: ddde3c18b700 ("vt: More locking checks")
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Tested-by: Jens Remus <jremus@linux.ibm.com>
> > Acked-by: Sam Ravnborg <sam@ravnborg.org>
> > Link: https://lore.kernel.org/r/20190718080903.22622-1-daniel.vetter@ffwll.ch
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/tty/vt/vt.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> > index ec92f36ab5c4..34aa39d1aed9 100644
> > --- a/drivers/tty/vt/vt.c
> > +++ b/drivers/tty/vt/vt.c
> > @@ -3771,7 +3771,11 @@ static ssize_t show_bind(struct device *dev, struct device_attribute *attr,
> >                          char *buf)
> >  {
> >         struct con_driver *con = dev_get_drvdata(dev);
> > -       int bind = con_is_bound(con->con);
> > +       int bind;
> > +
> > +       console_lock();
> > +       bind = con_is_bound(con->con);
> > +       console_unlock();
> >
> >         return snprintf(buf, PAGE_SIZE, "%i\n", bind);
> >  }
> 
> Thanks for checking.  I had actually noticed that patch (I searched
> the mailing lists for the short git hash of the commit that broke me
> and found it) and had decided it wouldn't fix my problems.
> Specifically I think it could only possibly fix things if the function
> show_bind() was somewhere in my stack trace.  ...and it isn't.
> 
> ...but after your message I decided to be extra super sure.  I tried:
> 
> 1. Going back to mainline commit 6789f873ed37 ("Merge tag 'pm-5.3-rc2'
> of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm") and
> picking commit 61d51456f357 ("vt: Grab console_lock around
> con_is_bound in show_bind") from linuxnext.  It didn't fix my problem.
> 
> 2. Going to next-20190726.  It didn't fix my problem.
> 
> ...so indeed my patch addresses a different issue than the one you
> pointed to, even if both fix problems introduced by the same commit.

Thanks for testing, I'll go queue this up now.

greg k-h
