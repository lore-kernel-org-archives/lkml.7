Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82BEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9678206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfCUT34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 15:29:56 -0400
Received: from ale.deltatee.com ([207.54.116.67]:52856 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727991AbfCUT34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 15:29:56 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1h73Np-00073k-1w; Thu, 21 Mar 2019 13:29:45 -0600
To:     Knut Omang <knut.omang@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Kees Cook <keescook@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, shuah@kernel.org,
        Rob Herring <robh@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        devicetree <devicetree@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, wfg@linux.intel.com,
        Alan Maguire <alan.maguire@oracle.com>
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <6d9b3b21-1179-3a45-7545-30aa15306cb4@deltatee.com>
 <01b2a950f661e8ebd6acbc45c2f89c8f10063daf.camel@oracle.com>
 <ce355f5c-189c-816c-cde4-fb4e816d44e7@deltatee.com>
 <CAFd5g45LKU+SZAFzn3RNCoxhzum0NAr9t+UJ80SJDMc_FeKgBQ@mail.gmail.com>
 <73b62e929f631038a9d8d21d261aa22ac3c18949.camel@oracle.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <961494a3-d08c-2720-c59d-7d7008edb288@deltatee.com>
Date:   Thu, 21 Mar 2019 13:29:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <73b62e929f631038a9d8d21d261aa22ac3c18949.camel@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: alan.maguire@oracle.com, wfg@linux.intel.com, dan.carpenter@oracle.com, amir73il@gmail.com, Alexander.Levin@microsoft.com, pmladek@suse.com, devicetree@vger.kernel.org, linux-nvdimm@lists.01.org, dan.j.williams@intel.com, dri-devel@lists.freedesktop.org, daniel@ffwll.ch, linux-um@lists.infradead.org, richard@nod.at, jdike@addtoit.com, linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, julia.lawall@lip6.fr, khilman@baylibre.com, Tim.Bird@sony.com, rostedt@goodmis.org, brakmo@fb.com, joe@perches.com, mpe@ellerman.id.au, joel@jms.id.au, gregkh@linuxfoundation.org, frowand.list@gmail.com, kieran.bingham@ideasonboard.com, robh@kernel.org, shuah@kernel.org, mcgrof@kernel.org, keescook@google.com, brendanhiggins@google.com, knut.omang@oracle.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC v4 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-03-21 1:13 p.m., Knut Omang wrote:
>> Nevertheless, I don't really see KTF as a real unit testing framework
>> for a number of different reasons; you pointed out some below, but I
>> think the main one being that it requires booting a real kernel on
>> actual hardware; 
> 
> That depends on what you want to test. If you need hardware (or simulated or
> emulated hardware) for the test, of course you would need to have that hardware,
> but if, lets say, you just wanted to run tests like the skbuff example tests
> (see link above) you wouldn't need anything more than what you need to run KUnit
> tests.

I'm starting to get the same impression: KTF isn't unit testing. When we
are saying "unit tests" we are specifying exactly what we want to test:
small sections of code in isolation. So by definition you should not
need hardware for this.

> I have fulfilled that dream, so I know it is possible (Inifinband driver,
> kernels from 2.6.39 to 4.8.x or so..) I know a lot of projects would benefit
> from support for such workflows, but that's not really the point here - we want
> to achieve both goals!

This is what makes me think we are not talking about testing the same
things. We are not talking about end to end testing of entire drivers
but smaller sections of code. A unit test is far more granular and
despite an infinband driver existing for 2.6.39 through 4.8, the
internal implementation could be drastically different. But unit tests
would be testing internal details which could be very different version
to version and has to evolve with the implementation.

> If your target component under test can be built as a kernel module, or set of
> modules, with KTF your workflow would not involve booting at all (unless you
> happened to crash the system with one of your tests, that is :) )

> You would just unload your module under test and the test module, recompile the
> two and insmod again. My work current work cycle on this is just a few seconds.

Yes, I'm sure we've all done that many a time but it's really beside the
point. Kunit offers a much nicer method for running a lot of unit tests
on existing code.

Logan
