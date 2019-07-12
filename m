Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F10DC742A8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B032084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562920713;
	bh=znfS1tIVsdDsPnI4loA05mUj2+D+UfKCfNMiKikS3qc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E2CczyFAW4x45A3e0DqcklHqsKLX4ZBvYlLYK0k9cMVO8Edw43O5pu3ePzPJkpml/
	 fJgRGF5wUnUdWUpd+ZNGiBJ3jGkl7I2AjuxDLA73RNVxyulztgHO0IoNvCSbICLwJA
	 lEhXRUyJcVwCSYen2fFOH7z/cxR620rLxnxtnhhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfGLIi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 04:38:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfGLIiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 04:38:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32FC52084B;
        Fri, 12 Jul 2019 08:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562920704;
        bh=znfS1tIVsdDsPnI4loA05mUj2+D+UfKCfNMiKikS3qc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O8/6HMhjSQdegv2kCpGxIva1Er3pQZ/I5WzjudAaiMTEB10s1cxD7mp5z19yVSZxi
         RpLi25UFr4qpV5xph1Me6NViWypu62WhDBF0NYru/qStveIQfURSoXXOS7n2FKXjJ6
         nMp2u8Kg1eeaA8Is/FwWfgRef6+hEL9pXjnoQyus=
Date:   Fri, 12 Jul 2019 10:38:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Okash Khawaja <okash.khawaja@gmail.com>
Cc:     devel@driverdev.osuosl.org, Kirk Reiser <kirk@reisers.ca>,
        Simon Dickson <simonhdickson@gmail.com>,
        speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Christopher Brannon <chris@the-brannons.com>
Subject: Re: Staging status of speakup
Message-ID: <20190712083819.GA8862@kroah.com>
References: <20190315130035.6a8f16e9@narunkot>
 <20190316031831.GA2499@kroah.com>
 <20190706200857.22918345@narunkot>
 <20190707065710.GA5560@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190707065710.GA5560@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 07, 2019 at 08:57:10AM +0200, Greg Kroah-Hartman wrote:
> On Sat, Jul 06, 2019 at 08:08:57PM +0100, Okash Khawaja wrote:
> > On Fri, 15 Mar 2019 20:18:31 -0700
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > > On Fri, Mar 15, 2019 at 01:01:27PM +0000, Okash Khawaja wrote:
> > > > Hi,
> > > > 
> > > > We have made progress on the items in TODO file of speakup driver in
> > > > staging directory and wanted to get some clarity on the remaining
> > > > items. Below is a summary of status of each item along with the
> > > > quotes from TODO file.
> > > > 
> > > > 1. "The first issue has to do with the way speakup communicates
> > > > with serial ports.  Currently, we communicate directly with the
> > > > hardware ports. This however conflicts with the standard serial
> > > > port drivers, which poses various problems. This is also not
> > > > working for modern hardware such as PCI-based serial ports.  Also,
> > > > there is not a way we can communicate with USB devices.  The
> > > > current serial port handling code is in serialio.c in this
> > > > directory."
> > > > 
> > > > Drivers for all external synths now use TTY to communcate with the
> > > > devices. Only ones still using direct communication with hardware
> > > > ports are internal synths: acntpc, decpc, dtlk and keypc. These are
> > > > typically ISA cards and generally hardware which is difficult to
> > > > make work. We can leave these in staging.  
> > > 
> > > Ok, that's fine.
> > > 
> > > > 2. "Some places are currently using in_atomic() because speakup
> > > > functions are called in various contexts, and a couple of things
> > > > can't happen in these cases. Pushing work to some worker thread
> > > > would probably help, as was already done for the serial port
> > > > driving part."
> > > > 
> > > > There aren't any uses of in_atomic anymore. Commit d7500135802c
> > > > "Staging: speakup: Move pasting into a work item" was the last one
> > > > that removed such uses.  
> > > 
> > > Great, let's remove that todo item then.
> > > 
> > > > 3. "There is a duplication of the selection functions in
> > > > selections.c. These functions should get exported from
> > > > drivers/char/selection.c (clear_selection notably) and used from
> > > > there instead."
> > > > 
> > > > This is yet to be done. I guess drivers/char/selection.c is now
> > > > under drivers/tty/vt/selection.c.  
> > > 
> > > Yes, someone should update the todo item :)
> > > 
> > > > 4. "The kobjects may have to move to a more proper place in /sys.The
> > > > discussion on lkml resulted to putting speech synthesizers in the
> > > > "speech" class, and the speakup screen reader itself
> > > > into /sys/class/vtconsole/vtcon0/speakup, the nasty path being
> > > > handled by userland tools."
> > > > 
> > > > Although this makes logical sense, the change will mean changing
> > > > interface with userspace and hence the user space tools. I tried to
> > > > search the lkml discussion but couldn't find it. It will be good to
> > > > know your thoughts on this.  
> > > 
> > > I don't remember, sorry.  I can review the kobject/sysfs usage if you
> > > think it is "good enough" now and see if I find anything
> > > objectionable.
> > > 
> > > > Finally there is an issue where text in output buffer sometimes gets
> > > > garbled on SMP systems, but we can continue working on it after the
> > > > driver is moved out of staging, if that's okay. Basically we need a
> > > > reproducer of this issue.
> > > > 
> > > > In addition to above, there are likely code style issues which will
> > > > need to be fixed.
> > > > 
> > > > We are very keen to get speakup out of staging both, for settling
> > > > the driver but also for getting included in distros which build
> > > > only the mainline drivers.  
> > > 
> > > That's great, I am glad to see this happen.  How about work on the
> > > selection thing and then I can review the kobject stuff in a few
> > > weeks, and then we can start moving things for 5.2?
> > 
> > Hi Greg,
> > 
> > Apologies for the delay. I de-duplicated selection code in speakup to
> > use code that's already in kernel (commit ids 496124e5e16e and
> > 41f13084506a). Following items are what remain now:
> > 
> > 1. moving kobjects location
> > 2. fixing garbled text
> > 
> > I couldn't replicate garbled text but Simon (also in CC list) is
> > looking into it.
> > 
> > Can you please advise on the way forward?
> 
> I don't think the "garbled text" is an issue to get this out of staging
> if others do not see this.  It can be fixed like any other bug at a
> later point if it is figured out.
> 
> The kobject stuff does need to be looked at.  Let me carve out some time
> next week to do that and I will let you know what I see/recommend.

At first glance, this might all be just fine.

But, I can't quite figure out what some files are doing.  No matter
what, you will need Documentation/ABI/ entries for the speakup code for
these sysfs files.

Can you make up a patch to create a
drivers/staging/speakup/sysfs-speakup file with the needed information?
That way it will be much easier to determine exactly what these sysfs
files do and my review can be easier, and perhaps not needed at all :)

thanks,

greg k-h
