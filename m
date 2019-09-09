Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E77FC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 18:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA99218AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 18:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbfIISiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 14:38:24 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:41248 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfIISiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 14:38:24 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1i7OYL-0003LS-UH; Mon, 09 Sep 2019 20:38:17 +0200
Date:   Mon, 9 Sep 2019 20:38:17 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: sysrq: don't recommend 'S' 'U' before 'B'
Message-ID: <20190909183817.GB12602@angband.pl>
References: <20190903160840.56652-1-kilobyte@angband.pl>
 <20190909083331.GA27626@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190909083331.GA27626@amd>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 10:33:31AM +0200, Pavel Machek wrote:
> On Tue 2019-09-03 18:08:40, Adam Borowski wrote:
> > This advice is obsolete and slightly harmful for filesystems from this
> > millenium: any modern filesystem can handle unexpected crashes without
> > requiring fsck -- and on the other hand, trying to write to the disk when
> > the kernel is in a bad state risks introducing corruption.
> 
> Actually no, I don't think it is good idea.
> 
> sync is still useful these days -- you want the current data to be
> written to disk; true, you'll not have to do fsck, but you may lose
> your current data.

Well yeah, but that's only if you have a reason to suspect there's some data
you care about.  I'd say that in the usual case, saving whatever volatile
state the system has tends to be not worth risking corruption.

Ie, the default advice for a locked-up system should be SysRq B.

Is there some other wording that you would be happier with?

> > For ext2, any unsafe shutdown meant widespread breakage, but it's no longer
> > a reasonable filesystem for any non-special use.
> > 
> > Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> > ---
> >  Documentation/admin-guide/sysrq.rst | 20 +++++++++-----------
> >  1 file changed, 9 insertions(+), 11 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
> > index 7b9035c01a2e..72b2cfb066f4 100644
> > --- a/Documentation/admin-guide/sysrq.rst
> > +++ b/Documentation/admin-guide/sysrq.rst
> > @@ -171,22 +171,20 @@ It seems others find it useful as (System Attention Key) which is
> >  useful when you want to exit a program that will not let you switch consoles.
> >  (For example, X or a svgalib program.)
> >  
> > -``reboot(b)`` is good when you're unable to shut down. But you should also
> > -``sync(s)`` and ``umount(u)`` first.
> > +``reboot(b)`` is good when you're unable to shut down, it is an equivalent
> > +of pressing the "reset" button.
> >  
> >  ``crash(c)`` can be used to manually trigger a crashdump when the system is hung.
> >  Note that this just triggers a crash if there is no dump mechanism available.
> >  
> > -``sync(s)`` is great when your system is locked up, it allows you to sync your
> > -disks and will certainly lessen the chance of data loss and fscking. Note
> > -that the sync hasn't taken place until you see the "OK" and "Done" appear
> > -on the screen. (If the kernel is really in strife, you may not ever get the
> > -OK or Done message...)
> > +``sync(s)`` is handy before yanking removable medium or after using a rescue
> > +shell that provides no graceful shutdown -- it will ensure your data is
> > +safely written to the disk. Note that the sync hasn't taken place until you see
> > +the "OK" and "Done" appear on the screen.
> >  
> > -``umount(u)`` is basically useful in the same ways as ``sync(s)``. I generally
> > -``sync(s)``, ``umount(u)``, then ``reboot(b)`` when my system locks. It's saved
> > -me many a fsck. Again, the unmount (remount read-only) hasn't taken place until
> > -you see the "OK" and "Done" message appear on the screen.
> > +``umount(u)`` can be used to mark filesystems as properly unmounted. From the
> > +running system's point of view, they will be remounted read-only. The remount
> > +isn't complete until you see the "OK" and "Done" message appear on the screen.
> >  
> >  The loglevels ``0``-``9`` are useful when your console is being flooded with
> >  kernel messages you do not want to see. Selecting ``0`` will prevent all but


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢰⠒⠀⣿⡁
⢿⡄⠘⠷⠚⠋⠀ I was born a dumb, ugly and work-loving kid, then I got swapped on
⠈⠳⣄⠀⠀⠀⠀ the maternity ward.
