Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1B3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1911421916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfCUW1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:27:08 -0400
Received: from ale.deltatee.com ([207.54.116.67]:54168 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfCUW1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:27:07 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1h769I-0001B1-70; Thu, 21 Mar 2019 16:26:57 -0600
To:     Brendan Higgins <brendanhiggins@google.com>
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
        Knut Omang <knut.omang@oracle.com>,
        devicetree <devicetree@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, wfg@linux.intel.com
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <6d9b3b21-1179-3a45-7545-30aa15306cb4@deltatee.com>
 <CAFd5g47G=mTdk+=wpO+rkyO0+mAbEfPAg=Pr7_507Uek4sdWeA@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3bdbe44c-5bd8-db37-89f9-a518cd5a21a8@deltatee.com>
Date:   Thu, 21 Mar 2019 16:26:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g47G=mTdk+=wpO+rkyO0+mAbEfPAg=Pr7_507Uek4sdWeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: wfg@linux.intel.com, dan.carpenter@oracle.com, amir73il@gmail.com, Alexander.Levin@microsoft.com, pmladek@suse.com, devicetree@vger.kernel.org, knut.omang@oracle.com, linux-nvdimm@lists.01.org, dan.j.williams@intel.com, dri-devel@lists.freedesktop.org, daniel@ffwll.ch, linux-um@lists.infradead.org, richard@nod.at, jdike@addtoit.com, linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, julia.lawall@lip6.fr, khilman@baylibre.com, Tim.Bird@sony.com, rostedt@goodmis.org, brakmo@fb.com, joe@perches.com, mpe@ellerman.id.au, joel@jms.id.au, gregkh@linuxfoundation.org, frowand.list@gmail.com, kieran.bingham@ideasonboard.com, robh@kernel.org, shuah@kernel.org, mcgrof@kernel.org, keescook@google.com, brendanhiggins@google.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC v4 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-03-21 4:07 p.m., Brendan Higgins wrote:
> A couple of points, as for needing CONFIG_PCI; my plan to deal with
> that type of thing has been that we would add support for a KUnit/UML
> version that is just for KUnit. It would mock out the necessary bits
> to provide a fake hardware implementation for anything that might
> depend on it. I wrote a prototype for mocking/faking MMIO that I
> presented to the list here[1]; it is not part of the current patchset
> because we decided it would be best to focus on getting an MVP in, but
> I plan on bringing it back up at some point. Anyway, what do you
> generally think of this approach?

Yes, I was wondering if that might be possible. I think that's a great
approach but it will unfortunately take a lot of work before larger
swaths of the kernel are testable in Kunit with UML. Having more common
mocked infrastructure will be great by-product of it though.

> Awesome, I looked at the code you posted and it doesn't look like you
> have had too many troubles. One thing that stood out to me, why did
> you need to put it in the kunit/ dir?

Yeah, writing the code was super easy. Only after, did I realized I
couldn't get it to easily build.

Putting it in the kunit directory was necessary because nothing in the
NTB tree builds unless CONFIG_NTB is set (see drivers/Makefile) and
CONFIG_NTB depends on CONFIG_PCI. I didn't experiment to see how hard it
would be to set CONFIG_NTB without CONFIG_PCI; I assumed it would be tricky.

> I am looking forward to see what you think!

Generally, I'm impressed and want to see this work in upstream as soon
as possible so I can start to make use of it!

Logan
