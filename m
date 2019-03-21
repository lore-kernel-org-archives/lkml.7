Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4881C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989E8218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfCULJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:09:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbfCULJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 07:09:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D0F6A1E317;
        Thu, 21 Mar 2019 11:09:04 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id 09BC95D6A6;
        Thu, 21 Mar 2019 11:09:01 +0000 (UTC)
Date:   Thu, 21 Mar 2019 12:09:01 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>,
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
Message-ID: <20190321110901.GA16430@krava>
References: <20190318182116.17388-1-jolsa@kernel.org>
 <20190318182116.17388-2-jolsa@kernel.org>
 <20190320154833.GH6058@hirez.programming.kicks-ass.net>
 <20190320160329.GA14021@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320160329.GA14021@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 21 Mar 2019 11:09:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 05:03:29PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Mar 20, 2019 at 04:48:33PM +0100, Peter Zijlstra wrote:
> > On Mon, Mar 18, 2019 at 07:21:09PM +0100, Jiri Olsa wrote:
> > > Adding perf_msr_probe function to provide interface for
> > > checking up on MSR register and add its related event
> > > attributes if it passes the check.
> > > 
> > > User defines following struct for each MSR register:
> > > 
> > >   struct perf_msr {
> > >        u64                       msr;
> > >        struct attribute        **attrs;
> 
> Please use attribute groups where ever possible.  I've been working to
> fix up the remaining places that use list of attributes as that is not
> flexible at all (and broken in places.)
> 
> And this is a device, so why not device attributes?

ok, will check

> 
> > >        bool                    (*test)(int idx, void *data);
> > >        bool                      no_check;
> > >   };
> > > 
> > > Where:
> > >   msr      - is the MSR address
> > >   attrs    - is attributes array to add if the check passed
> > >   test     - is test function pointer
> > >   no_check - is bool that bypass the check and adds the
> > >               attribute without any test
> > > 
> > > The array of struct perf_msr is passed into:
> > > 
> > >   perf_msr_probe(struct perf_msr *msr, int cnt,
> > >                 struct attribute **attrs, void *data)
> > > 
> > > Together with:
> > >   cnt   - which is the number of struct msr array elements
> > >   attrs - which is an array placeholder for added attributes
> > >           and needs to be big enough
> > >   data  -which is user pointer passed to the test function
> > > 
> > > The perf_msr_probe will executed test code, read the MSR and
> > > check the value is != 0. If all these tests pass, related
> > > attributes are added into attrs array.
> > > 
> > > Also adding MSR_ATTR macro helper to define attribute array
> > > from single attribute. It will be used in following patches.
> 
> Please no, don't we have enough ATTR macros?  Why do you need another
> one?  What are you trying to save code on?
> 
> > Somewhere along the line you lost the explanation of _why_ we're doing
> > this; namely: virt sucks.
> > 
> > Also, recently GregKH had a chance to look at perf code and we scored
> > fairly high on the WTF'o'meter for what we're doing with the attribute
> > stuff.
> > 
> > He pointed me to sysfs attribute_group::is_visible functions to replace
> > some of our 'creative' code.
> 
> Yes, that would be very good to do.  If no one is working on it, I can
> take a look next week as I have long plane rides...

if I dont send v2 till then, it's all yours ;-)

thanks,
jirka
