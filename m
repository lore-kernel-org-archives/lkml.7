Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9E3C17440
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 15:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511F421882
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 15:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573314832;
	bh=oLLA+LJRZMutBc/w7UnwS4e+AYT2tL1ph+XE6WfNUI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OHuHBwtNOQuWr2LOHpiAp/qnxZ7B0DNflDWjdOeSMDQ0iNsFYyBKdeYwuw9QS/TlY
	 akugPzGp6qTc0vWZL9q3jhYnbhCGCtuKdBsWGZkJycvNq8SJq5ad4r87eJcd5e83n3
	 V9x7Tvzr9z6kw1be9m+vW8o2jAvboapbW7p5+Qac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfKIPxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 10:53:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:52108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfKIPxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 10:53:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8625821848;
        Sat,  9 Nov 2019 15:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573314830;
        bh=oLLA+LJRZMutBc/w7UnwS4e+AYT2tL1ph+XE6WfNUI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o5fT5S0eLSmN8EtH7zNxKk61vhxbel33EySr2WnEskAkERgmCLksyyuu7fOcGDq9Z
         RjeQXU3Jmde9fxzrKBAAbMlqpKac9yH+vKdNeYfanSaXBgAkAOfxba38mTpKTkNEgq
         mI/idEMA1SPGuIo61mYINSMQ8R+ORvwe7keCNjB0=
Date:   Sat, 9 Nov 2019 16:53:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/93] 4.19.81-stable review
Message-ID: <20191109155346.GB1367023@kroah.com>
References: <20191027203251.029297948@linuxfoundation.org>
 <20191029162419.cumhku6smn2x2bq4@ucw.cz>
 <20191029180233.GA587491@kroah.com>
 <20191106185932.GA2183@amd>
 <20191106201818.GA105063@kroah.com>
 <c065df06c9e5d351b4a33c473fd397f27680489f.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c065df06c9e5d351b4a33c473fd397f27680489f.camel@codethink.co.uk>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 04:43:17PM +0000, Ben Hutchings wrote:
> On Wed, 2019-11-06 at 21:18 +0100, Greg Kroah-Hartman wrote:
> > On Wed, Nov 06, 2019 at 07:59:32PM +0100, Pavel Machek wrote:
> [...]
> > > I'm confused. You said "by Tue ... 08:27:02 PM UTC". That 8 PM is 20h,
> > > but did the release on 10h GMT+1, or 9h UTC -- 9 AM.... so like 11
> > > hours early, if I got the timezones right.
> > > 
> > > Does PM mean something else in the above context?
> > 
> > Ugh, no, you are right, I was ignoring the PM thing, I thought the -u
> > option to date would give me a 24 hour date string, and so I thought
> > that was 8:27 in the morning.
> > 
> > Let me mess around with 'date' to see if I can come up with a better
> > string to use here.  I guess:
> > 	date --rfc-3339=seconds -u
> > would probably be best?
> 
> The --rfc-822 option should give you something close to the current
> format, but with 24-hour numbering.

Ah, missed that.  I'll go use that.

Also, I just remembered that if you look in the email headers, there's a
"X-KernelTest-Deadline:" field that uses the --iso-8601=minutes format.
I think kernelci uses that to parse for when it needs to finish things
by, but I don't know if that actually happens or not.

I'll go fix the string up for the next round.

thanks,

greg k-h
