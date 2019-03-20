Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF990C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6E82186A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553058426;
	bh=8p/yQVuYxwPBUvtN5pJ6q3FFkPCc2jHRg4Ry482iwVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k+28210izLAjGw7Wt2pUtKh4GjN6VCRFZhLAqv4JZ7kZLq7+o5hBpmYxSfXy8clOE
	 1Hv2ImQlTPH3MxIezXMEB7EI1dAbFGnuRdBAy47zgvIVUuT/4p0z6rNry3Cyd/Pw/Q
	 nn6Z1UpsXCD+swhghuFcVpUTet4byMuzepl1gxgc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfCTFHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 01:07:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfCTFHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 01:07:04 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A2482184E;
        Wed, 20 Mar 2019 05:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553058424;
        bh=8p/yQVuYxwPBUvtN5pJ6q3FFkPCc2jHRg4Ry482iwVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XC2uir3Xk/AX1uJ8bdb1jKQJ3kKkm7tM4nADXJ46Rw6BMufgdgUfmciBN6WOO6pf9
         v3iWaJ+RUrn5x/HwsX3BpJ1+iLLndn9fG9LQ5Qf+WeKTLbtOoSUj1gW+hZCZqQZKLB
         CxfwzlJTesAblrINzQ8FtW/YZxpWLW6CLFuUNnEk=
Date:   Wed, 20 Mar 2019 06:06:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jon Masters <jcm@jonmasters.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Steve French <smfrench@gmail.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <20190320050659.GA16580@kroah.com>
References: <20190212170012.GF69686@sasha-vm>
 <CAH2r5mviqHxaXg5mtVe30s2OTiPW2ZYa9+wPajjzz3VOarAUfw@mail.gmail.com>
 <CAOQ4uxjMYWJPF8wFF_7J7yy7KCdGd8mZChfQc5GzNDcfqA7UAA@mail.gmail.com>
 <20190213073707.GA2875@kroah.com>
 <CAOQ4uxgQGCSbhppBfhHQmDDXS3TGmgB4m=Vp3nyyWTFiyv6z6g@mail.gmail.com>
 <20190213091803.GA2308@kroah.com>
 <20190213192512.GH69686@sasha-vm>
 <20190213195232.GA10047@kroah.com>
 <79d10599-70d2-7d06-1cee-6e52d36233bf@jonmasters.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79d10599-70d2-7d06-1cee-6e52d36233bf@jonmasters.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 11:46:09PM -0400, Jon Masters wrote:
> On 2/13/19 2:52 PM, Greg KH wrote:
> > On Wed, Feb 13, 2019 at 02:25:12PM -0500, Sasha Levin wrote:
> 
> >> So really, it sounds like a low hanging fruit: we don't really need to
> >> write much more testing code code nor do we have to refactor existing
> >> test suites. We just need to make sure the right tests are running on
> >> stable kernels. I really want to clarify what each subsystem sees as
> >> "sufficient" (and have that documented somewhere).
> > 
> > kernel.ci and 0-day and Linaro are starting to add the fs and mm tests
> > to their test suites to address these issues (I think 0-day already has
> > many of them).  So this is happening, but not quite obvious.  I know I
> > keep asking Linaro about this :(
> 
> We're working on investments for LDCG[0] in 2019 that include kernel CI
> changes for server use cases. Please keep us informed of what you folks
> ultimately want to see, and I'll pass on to the steering committee too.
> 
> Ultimately I've been pushing for a kernel 0-day project for Arm. That's
> probably going to require a lot of duplicated effort since the original
> 0-day project isn't open, but creating an open one could help everyone.

Why are you trying to duplicate it on your own?  That's what kernel.ci
should be doing, please join in and invest in that instead.  It's an
open source project with its own governance and needs sponsors, why
waste time and money doing it all on your own?

thanks,

greg k-h
