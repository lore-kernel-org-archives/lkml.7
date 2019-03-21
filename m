Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7607FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EEB7218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfCUP4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:56:37 -0400
Received: from ale.deltatee.com ([207.54.116.67]:51320 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfCUP4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:56:36 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1h703H-00043G-7V; Thu, 21 Mar 2019 09:56:20 -0600
To:     Knut Omang <knut.omang@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        keescook@google.com, mcgrof@kernel.org, shuah@kernel.org,
        robh@kernel.org, kieran.bingham@ideasonboard.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, joel@jms.id.au, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com, rostedt@goodmis.org,
        Tim.Bird@sony.com, khilman@baylibre.com, julia.lawall@lip6.fr,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, jdike@addtoit.com, richard@nod.at,
        linux-um@lists.infradead.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, dan.j.williams@intel.com,
        linux-nvdimm@lists.01.org, devicetree@vger.kernel.org,
        pmladek@suse.com, Alexander.Levin@microsoft.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, wfg@linux.intel.com
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <6d9b3b21-1179-3a45-7545-30aa15306cb4@deltatee.com>
 <01b2a950f661e8ebd6acbc45c2f89c8f10063daf.camel@oracle.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ce355f5c-189c-816c-cde4-fb4e816d44e7@deltatee.com>
Date:   Thu, 21 Mar 2019 09:56:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <01b2a950f661e8ebd6acbc45c2f89c8f10063daf.camel@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: wfg@linux.intel.com, dan.carpenter@oracle.com, amir73il@gmail.com, Alexander.Levin@microsoft.com, pmladek@suse.com, devicetree@vger.kernel.org, linux-nvdimm@lists.01.org, dan.j.williams@intel.com, dri-devel@lists.freedesktop.org, daniel@ffwll.ch, linux-um@lists.infradead.org, richard@nod.at, jdike@addtoit.com, linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, julia.lawall@lip6.fr, khilman@baylibre.com, Tim.Bird@sony.com, rostedt@goodmis.org, brakmo@fb.com, joe@perches.com, mpe@ellerman.id.au, joel@jms.id.au, gregkh@linuxfoundation.org, frowand.list@gmail.com, kieran.bingham@ideasonboard.com, robh@kernel.org, shuah@kernel.org, mcgrof@kernel.org, keescook@google.com, brendanhiggins@google.com, knut.omang@oracle.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC v4 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-03-20 11:23 p.m., Knut Omang wrote:
> Testing drivers, hardware and firmware within production kernels was the use
> case that inspired KTF (Kernel Test Framework). Currently KTF is available as a
> standalone git repository. That's been the most efficient form for us so far, 
> as we typically want tests to be developed once but deployed on many different
> kernel versions simultaneously, as part of continuous integration.

Interesting. It seems like it's really in direct competition with KUnit.
I didn't really go into it in too much detail but these are my thoughts:

From a developer perspective I think KTF not being in the kernel tree is
a huge negative. I want minimal effort to include my tests in a patch
series and minimal effort for other developers to be able to use them.
Needing to submit these tests to another project or use another project
to run them is too much friction.

Also I think the goal of having tests that run on any kernel version is
a pipe dream. You'd absolutely need a way to encode which kernel
versions a test is expected to pass on because the tests might not make
sense until a feature is finished in upstream. And this makes it even
harder to develop these tests because, when we write them, we might not
even know which kernel version the feature will be added to. Similarly,
if a feature is removed or substantially changed, someone will have to
do a patch to disable the test for subsequent kernel versions and create
a new test for changed features. So, IMO, tests absolutely have to be
part of the kernel tree so they can be changed with the respective
features they test.

Kunit's ability to run without having to build and run the entire kernel
 is also a huge plus. (Assuming there's a way to get around the build
dependency issues). Because of this, it can be very quick to run these
tests which makes development a *lot* easier seeing you don't have to
reboot a machine every time you want to test a fix.

Logan
