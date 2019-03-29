Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824A5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566632184E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfC2Kip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:38:45 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58095 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfC2Kip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:38:45 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 49F68803CF; Fri, 29 Mar 2019 11:38:35 +0100 (CET)
Date:   Fri, 29 Mar 2019 11:38:35 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marek Behun <marek.behun@nic.cz>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: kernfs: can read/write method grow buffer size?
Message-ID: <20190329103835.GB23356@atrey.karlin.mff.cuni.cz>
References: <20190329040922.34ab01c6@nic.cz>
 <20190329062253.GA9659@kroah.com>
 <20190329083440.GA12945@amd>
 <20190329094823.426d7ed8@nic.cz>
 <20190329102436.GA7286@kroah.com>
 <20190329102606.GB7286@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329102606.GB7286@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Yes, and cpufreq governors too list available governosrs as space
> > > separated list.
> > > Maybe the "one value per file" rule was thought-of only after these
> > > were merged?
> > 
> > For small numbers of things, like /sys/power/state, which was the first
> > file to use this style, it was fine as we "knew" this was going to be a
> > small, well-bounded list of states that the file could be in.
> > 
> > As you have seen, 'trigger' is not that, and I am pretty sure I have
> > complained about this in the past.
> > 
> > I suggest you use a different way of "discovering" what types of
> > triggers are available.  I don't know what would work best for you, but
> > any time you are ever worried about the size of a sysfs file's buffer,
> > you know you are doing something wrong.
> 
> Ok, while writing this out, I realized that to keep things still
> working, and to enable you to have an unlimited list of triggers, why
> not just turn the file into a binary sysfs file?
> 
> Yes, that's not what binary sysfs files are for, they are supposed to be
> only used for data that is "pass through" from userspace to hardware,
> where the kernel does not touch the information at all.  But I'm willing
> to give you an exception here as long as you document the heck out of it
> in the code itself, saying that no one else should ever copy this way of
> doing things again.
> 
> Would that work?

That would work, I guess.

We'll also want to limit number of triggers in LEDs -- there should be
one trigger "cpu" with parameters, not 1024 triggers "cpu0"
.. "cpu1023". But that will take some time to sort out.

Best regards,

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
