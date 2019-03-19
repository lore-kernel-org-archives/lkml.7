Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF80C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5DA20872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfCSRMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:12:19 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:57152 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfCSRMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:12:18 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1h6IHO-0002bp-KA; Tue, 19 Mar 2019 18:11:58 +0100
Date:   Tue, 19 Mar 2019 18:11:58 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Chris Brannon <chris@the-brannons.com>,
        Okash Khawaja <okash.khawaja@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        William Hubbs <w.d.hubbs@gmail.com>,
        Kirk Reiser <kirk@reisers.ca>, linux-kernel@vger.kernel.org
Subject: Re: Staging status of speakup
Message-ID: <20190319171158.GA6807@angband.pl>
References: <20190315130035.6a8f16e9@narunkot>
 <87ef77obtg.fsf@cmbmachine.messageid.invalid>
 <20190316093543.w4i6djt5uuqtx5xr@function>
 <20190319163121.5e7ab8c7@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190319163121.5e7ab8c7@alans-desktop>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 04:31:21PM +0000, Alan Cox wrote:
> On Sat, 16 Mar 2019 10:35:43 +0100
> Samuel Thibault <samuel.thibault@ens-lyon.org> wrote:
> > Chris Brannon, le ven. 15 mars 2019 18:19:39 -0700, a ecrit:
> > > What kind of reproducer do you need here?  It's straightforward to
> > > reproduce in casual use, at least with a software synthesizer.  
> > 
> > we need a walk-through of the kind of operation that
> > produces the issue. It does not have to be reproducible each time it is
> > done. Perhaps (I really don't know what that bug is about actually) it
> > is a matter of putting text in the selection buffer, and try to paste it
> > 100 times, and once every 10 times it will be garbled, for instance.
> 
> paste_selection still says
> 
> /* Insert the contents of the selection buffer into the
>  * queue of the tty associated with the current console.
>  * Invoked by ioctl().
>  *
>  * Locking: called without locks. Calls the ldisc wrongly with
>  * unsafe methods,
>  */
> 
> from which I deduce that with everyone using X nobody ever bothered to
> fix it. So before you look too hard at the speakup code you might want to
> review the interaction with selection.c too.

This looks like https://bugs.debian.org/849474 which causes a lockup, and
for which Bill Allombert wrote a nice reproducer.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁ Did ya know that typing "test -j8" instead of "ctest -j8"
⢿⡄⠘⠷⠚⠋⠀ will make your testsuite pass much faster, and fix bugs?
⠈⠳⣄⠀⠀⠀⠀
