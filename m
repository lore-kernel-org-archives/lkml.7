Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD48AC2D0C9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 07:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BF92465B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 07:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576310122;
	bh=37tV1SM+durbtVnc1SZJaIoQfBdJLToeVvqsv8IROTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AbsVNtnR42VdVsVtmrqU1Z2wTmKumdN6/OxLcmo9enaA57PrI3I0iN3PGBztMReuD
	 CA/V08nT82cNThNbpE/BZWvbzQX4pb0gNbYGjr7ocuvb1J5g+iWJrbsYCw0c6e5NMQ
	 ovKueBv4oI/sM7915Buc/8xpKmG7O+3jGy7onVOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfLNHzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 02:55:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:42112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfLNHzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 02:55:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61B032073D;
        Sat, 14 Dec 2019 07:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576310120;
        bh=37tV1SM+durbtVnc1SZJaIoQfBdJLToeVvqsv8IROTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dKTe7f5Na3+7CLUnVjCF7EOhyTtJ2pHjUXEe1t4rQjsuuiBTBpGjFpR0aBBNv+Wkj
         LzeKZ0DvFcG2v5lwx1DsNU7xU1SxYalBvu68J8qcBh2xvNw/R0ac+0QzCiFbcrA3T0
         JCAd9aZgMezJH5a9dZ186sq5sP9iFMaYN8FTU1D0=
Date:   Sat, 14 Dec 2019 08:55:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+f4f1e871965064ae689e@syzkaller.appspotmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        asierra@xes-inc.com, ext-kimmo.rautkoski@vaisala.com,
        Jiri Slaby <jslaby@suse.com>,
        kai heng feng <kai.heng.feng@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        mika.westerberg@linux.intel.com, o.barta89@gmail.com,
        paulburton@kernel.org, sr@denx.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yegorslists@googlemail.com
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 mem_serial_out
Message-ID: <20191214075517.GA3314866@kroah.com>
References: <00000000000053539a0599173973@google.com>
 <20191212105701.GB1476206@kroah.com>
 <CACT4Y+ZeR=z-3CSXFazmngUhs9DqfxgZLKBNhzvfg49Nrw=EzA@mail.gmail.com>
 <20191213093357.GB2135612@kroah.com>
 <CACT4Y+beoeY9XwbQX7nDY_5EPMQwK+j3JZ9E-k6vhiZudEA1LA@mail.gmail.com>
 <74859736-478a-6ad7-f0be-cfe87ec40ff5@i-love.sakura.ne.jp>
 <20191213160700.GA2632926@kroah.com>
 <4f514a5a-af11-e688-8f8d-72bbadadc889@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f514a5a-af11-e688-8f8d-72bbadadc889@i-love.sakura.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2019 at 09:48:29AM +0900, Tetsuo Handa wrote:
> On 2019/12/14 1:07, Greg KH wrote:
> > On Fri, Dec 13, 2019 at 11:31:08PM +0900, Tetsuo Handa wrote:
> >> On 2019/12/13 19:00, Dmitry Vyukov wrote:
> >>> Easier said than done. "normal user of the serial port" is not really
> >>> a thing in Linux, right? You either have CAP_SYS_ADMIN or not, that's
> >>> not per-device...
> >>> As far as I remember +Tetsuo proposed a config along the lines of
> >>> "restrict only things that legitimately cause damage under a fuzzer
> >>> workload", e.g. freezing filesystems, disabling console output, etc.
> >>> This may be another candidate. But I can't find where that proposal is
> >>> now.
> >>
> >> That suggestion got no response for two months.
> >>
> >>   https://lkml.kernel.org/r/3e4e2b6b-7828-54ab-cf28-db1a396d7e20@i-love.sakura.ne.jp
> >>
> >> Unless we add such kernel config option to upstream kernels, it will become
> >> a whack-a-mole game.
> > 
> > It will be a whack-a-mole game no matter what.
> > 
> > Yes, /dev/mem/ makes no sense to fuzz.  Neither does other things (like
> > serial port memory addresses.)
> 
> /dev/mem makes sense to fuzz. Ditto for other things.

What?  What are you going to find if you randomly start to write to
/dev/mem?  How are we supposed to "fix" that?

> > You just will have a list of things that you "do not fuzz as these are
> > dangerous".  Nothing new here, any os will have that.
> 
> The list of kernel config options will become too complicated to maintain.
> If we can have one kernel config option, we can avoid maintaining
> the list of kernel config options (which keeps changing over time).

Use the newly added security_locked_down() call, that gives you a great
indication that root can cause problems for those things.

And it's not a config thing, it's a functionality thing within features,
as is explicitly shown by this very thread for the serial port memory
location.

thanks,

greg k-h
