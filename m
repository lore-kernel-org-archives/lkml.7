Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C03BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F13218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbfCUBIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:08:13 -0400
Received: from ale.deltatee.com ([207.54.116.67]:45046 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbfCUBIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 21:08:12 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1h6mBV-0008MJ-NR; Wed, 20 Mar 2019 19:07:54 -0600
To:     Brendan Higgins <brendanhiggins@google.com>, keescook@google.com,
        mcgrof@kernel.org, shuah@kernel.org, robh@kernel.org,
        kieran.bingham@ideasonboard.com, frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, joel@jms.id.au, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com, rostedt@goodmis.org,
        Tim.Bird@sony.com, khilman@baylibre.com, julia.lawall@lip6.fr,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, jdike@addtoit.com, richard@nod.at,
        linux-um@lists.infradead.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, dan.j.williams@intel.com,
        linux-nvdimm@lists.01.org, knut.omang@oracle.com,
        devicetree@vger.kernel.org, pmladek@suse.com,
        Alexander.Levin@microsoft.com, amir73il@gmail.com,
        dan.carpenter@oracle.com, wfg@linux.intel.com
References: <20190214213729.21702-1-brendanhiggins@google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6d9b3b21-1179-3a45-7545-30aa15306cb4@deltatee.com>
Date:   Wed, 20 Mar 2019 19:07:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190214213729.21702-1-brendanhiggins@google.com>
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

Hi,

On 2019-02-14 2:37 p.m., Brendan Higgins wrote:
> This patch set proposes KUnit, a lightweight unit testing and mocking
> framework for the Linux kernel.

I haven't followed the entire conversation but I saw the KUnit write-up
on LWN and ended up, as an exercise, giving it a try.

I really like the idea of having a fast unit testing infrastructure in
the kernel. Occasionally, I write userspace tests for tricky functions
that I essentially write by copying the code over to a throw away C file
and exercise them as I need. I think it would be great to be able to
keep these tests around in a way that they can be run by anyone who
wants to touch the code.

I was just dealing with some functions that required some mocked up
tests so I thought I'd give KUnit a try. I found writing the code very
easy and the infrastructure I was testing was quite simple to mock out
the hardware.

However, I got a bit hung up by one issue: I was writing unit tests for
code in the NTB tree which itself depends on CONFIG_PCI which cannot be
enabled in UML (for what should be obvious reasons). I managed to work
around this because, as luck would have it, all the functions I cared
about testing were actually static inline functions in headers. So I
placed my test code in the kunit folder (so it would compile) and hacked
around a couple a of functions I didn't care about that would not be
compiled.

In the end I got it to work acceptably, but I get the impression that
KUnit will not be usable for wide swaths of kernel code that can't be
compiled in UML. Has there been any discussion or ideas on how to work
around this so it can be more generally useful? Or will this feature be
restricted roughly to non-drivers and functions in headers that don't
have #ifdefs around them?

If you're interested in seeing the unit tests I ended up writing you can
find the commits here[1].

Thanks,

Logan

[1] https://github.com/sbates130272/linux-p2pmem/ ntb_kunit
