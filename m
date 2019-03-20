Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A84DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4507A218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553097815;
	bh=Soj8rOEfiEu0Ftg5/ksrUAWh0af+LcuuNw0aczKypLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Lo9+A+B1cRcoJbySIwHi+ujUrDq/CnGBpYOByrWPYIFV9/bX0fzKe/pY0f7DU5Iya
	 rkHfmUTthOsHA0KeIhGXDNWGj/6bg2elc3/iQlQaFJwNi5TvooUAhJg/ieZwKL0E8Z
	 jt7TqU3N+00aBCJrT8mF2l+LSn+V3/ALyW54TIlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfCTQDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:03:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbfCTQDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:03:33 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7735F2183E;
        Wed, 20 Mar 2019 16:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553097812;
        bh=Soj8rOEfiEu0Ftg5/ksrUAWh0af+LcuuNw0aczKypLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QLUuRHs2BDz9u/3++U0wmJKnz7v3Le2CFU2fvoBe61vHVuD4qcWuZKa3N5hW26yB1
         ihH1wKkytrcXCQF8Vb3u7IaozQ/V5KeeWRwPVcpOLlcbdfCQxuP887ZtRkyAFsd/jT
         7y+t5aAcO+0Vz9/2DOkn21pNj15fgmqN3/f5+ggU=
Date:   Wed, 20 Mar 2019 17:03:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 1/8] perf/x86: Add msr probe interface
Message-ID: <20190320160329.GA14021@kroah.com>
References: <20190318182116.17388-1-jolsa@kernel.org>
 <20190318182116.17388-2-jolsa@kernel.org>
 <20190320154833.GH6058@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320154833.GH6058@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 04:48:33PM +0100, Peter Zijlstra wrote:
> On Mon, Mar 18, 2019 at 07:21:09PM +0100, Jiri Olsa wrote:
> > Adding perf_msr_probe function to provide interface for
> > checking up on MSR register and add its related event
> > attributes if it passes the check.
> > 
> > User defines following struct for each MSR register:
> > 
> >   struct perf_msr {
> >        u64                       msr;
> >        struct attribute        **attrs;

Please use attribute groups where ever possible.  I've been working to
fix up the remaining places that use list of attributes as that is not
flexible at all (and broken in places.)

And this is a device, so why not device attributes?

> >        bool                    (*test)(int idx, void *data);
> >        bool                      no_check;
> >   };
> > 
> > Where:
> >   msr      - is the MSR address
> >   attrs    - is attributes array to add if the check passed
> >   test     - is test function pointer
> >   no_check - is bool that bypass the check and adds the
> >               attribute without any test
> > 
> > The array of struct perf_msr is passed into:
> > 
> >   perf_msr_probe(struct perf_msr *msr, int cnt,
> >                 struct attribute **attrs, void *data)
> > 
> > Together with:
> >   cnt   - which is the number of struct msr array elements
> >   attrs - which is an array placeholder for added attributes
> >           and needs to be big enough
> >   data  -which is user pointer passed to the test function
> > 
> > The perf_msr_probe will executed test code, read the MSR and
> > check the value is != 0. If all these tests pass, related
> > attributes are added into attrs array.
> > 
> > Also adding MSR_ATTR macro helper to define attribute array
> > from single attribute. It will be used in following patches.

Please no, don't we have enough ATTR macros?  Why do you need another
one?  What are you trying to save code on?

> Somewhere along the line you lost the explanation of _why_ we're doing
> this; namely: virt sucks.
> 
> Also, recently GregKH had a chance to look at perf code and we scored
> fairly high on the WTF'o'meter for what we're doing with the attribute
> stuff.
> 
> He pointed me to sysfs attribute_group::is_visible functions to replace
> some of our 'creative' code.

Yes, that would be very good to do.  If no one is working on it, I can
take a look next week as I have long plane rides...

thanks,

greg k-h
