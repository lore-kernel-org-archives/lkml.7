Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A941FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC02218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XGTF3JpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfCUTRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 15:17:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34384 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbfCUTRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 15:17:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2LJ9CHQ045105;
        Thu, 21 Mar 2019 19:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2018-07-02;
 bh=JTYPvktLqCZXhjaRtZAGj8CV8y0kKGDp+nZH2DlnBDk=;
 b=XGTF3JpT5NuQJeriJ5qPkWN1lzh7RJRbP9I1RPoVlsKAdYKPHp48SvcPehAJOO30/MWe
 0GgyytB0J9IT8sQIQmkOdxx/08IMz2sJ/Gty7bNw4uXyOJ98v8R41Ds5khL+1P4jZn6s
 2pRcHf3KPV7hvUcNiq83jUbDmfqx0sS0291cHKvGDXWm4nZVYZxxHeWDvEz7eUt7hW2x
 84TKImCjh/K9HgUZPMwUMgmvJKhBMlulxxhd/hfN81z2gWHbB6w5iSGDmMAMDgjsiQ2X
 DMum9O/ql5a+3m75ajV/UKWGYDmvn6gSODuRu//DpCwG3Z9EldVkmWMwtnWKRXEzA5u5 CA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2r8rjv2e18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Mar 2019 19:14:19 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2LJEF79005225
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Mar 2019 19:14:16 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2LJEAE6021813;
        Thu, 21 Mar 2019 19:14:10 GMT
Received: from ovo (/213.188.19.88)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Mar 2019 12:14:09 -0700
Message-ID: <73b62e929f631038a9d8d21d261aa22ac3c18949.camel@oracle.com>
Subject: Re: [RFC v4 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
From:   Knut Omang <knut.omang@oracle.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Logan Gunthorpe <logang@deltatee.com>
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
Date:   Thu, 21 Mar 2019 20:13:56 +0100
In-Reply-To: <CAFd5g45LKU+SZAFzn3RNCoxhzum0NAr9t+UJ80SJDMc_FeKgBQ@mail.gmail.com>
References: <20190214213729.21702-1-brendanhiggins@google.com>
         <6d9b3b21-1179-3a45-7545-30aa15306cb4@deltatee.com>
         <01b2a950f661e8ebd6acbc45c2f89c8f10063daf.camel@oracle.com>
         <ce355f5c-189c-816c-cde4-fb4e816d44e7@deltatee.com>
         <CAFd5g45LKU+SZAFzn3RNCoxhzum0NAr9t+UJ80SJDMc_FeKgBQ@mail.gmail.com>
Organization: Oracle Inc
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9202 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903210135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-21 at 09:55 -0700, Brendan Higgins wrote:
> On Thu, Mar 21, 2019 at 8:56 AM Logan Gunthorpe <logang@deltatee.com> wrote:
> > 
> > 
> > On 2019-03-20 11:23 p.m., Knut Omang wrote:
> > > Testing drivers, hardware and firmware within production kernels was the
> > > use
> > > case that inspired KTF (Kernel Test Framework). Currently KTF is available
> > > as a
> > > standalone git repository. That's been the most efficient form for us so
> > > far,
> > > as we typically want tests to be developed once but deployed on many
> > > different
> > > kernel versions simultaneously, as part of continuous integration.
> > 
> > Interesting. It seems like it's really in direct competition with KUnit.
> 
> I won't speak for Knut, but I don't think we are in competition. 

I would rather say we have some overlap in functionality :)
My understanding is that we have a common goal of providing better
infrastructure for testing, but have approached this whole problem complex from
somewhat different perspectives.

> I see
> KTF as a novel way to do a kind of white box end-to-end testing for
> the Linux kernel, which is a valuable thing, especially in some
> circumstances. I could see KTF having a lot of value for someone who
> wants to maintain out of tree drivers, in particular.

The best argument here is really good examples.
I'm not sure the distinction between "black box" and "white box" testing is
useful here, there's always underlying assumptions behind specific,
deterministic tests. Writing a test is a very good way to get to 
understand a piece of code. Just look at the flow of the example in
https://blogs.oracle.com/linux/writing-kernel-tests-with-the-new-kernel-test-framework-ktf, clearly unit tests, but the knowledge gathering is an important
part and motivation!

> Nevertheless, I don't really see KTF as a real unit testing framework
> for a number of different reasons; you pointed out some below, but I
> think the main one being that it requires booting a real kernel on
> actual hardware; 

That depends on what you want to test. If you need hardware (or simulated or
emulated hardware) for the test, of course you would need to have that hardware,
but if, lets say, you just wanted to run tests like the skbuff example tests
(see link above) you wouldn't need anything more than what you need to run KUnit
tests.

> I imagine it could be made to work on a VM, but that
> isn't really the point; it fundamentally depends on having part of the
> test, or at least driving the test from userspace on top of the kernel
> under test. Knut, myself, and others, had a previous discussion to
> this effect here: https://lkml.org/lkml/2018/11/24/170

> > I didn't really go into it in too much detail but these are my thoughts:
> > 
> > From a developer perspective I think KTF not being in the kernel tree is
> > a huge negative. I want minimal effort to include my tests in a patch
> > series and minimal effort for other developers to be able to use them.
> > Needing to submit these tests to another project or use another project
> > to run them is too much friction.

As said, I recognize the need to upstream KTF, and we are working to do that,
that's why I bother to write this :)

> > Also I think the goal of having tests that run on any kernel version is
> > a pipe dream. 

I have fulfilled that dream, so I know it is possible (Inifinband driver,
kernels from 2.6.39 to 4.8.x or so..) I know a lot of projects would benefit
from support for such workflows, but that's not really the point here - we want
to achieve both goals!

> > You'd absolutely need a way to encode which kernel
> > versions a test is expected to pass on because the tests might not make
> > sense until a feature is finished in upstream. And this makes it even
> > harder to develop these tests because, when we write them, we might not
> > even know which kernel version the feature will be added to. Similarly,
> > if a feature is removed or substantially changed, someone will have to
> > do a patch to disable the test for subsequent kernel versions and create
> > a new test for changed features. So, IMO, tests absolutely have to be
> > part of the kernel tree so they can be changed with the respective
> > features they test.

Of course a feature that is not part of a kernel cannot easily pass for that
kernel. And yes, testing for kernel version might be necessary in some cases,
and even to write a section of extra code to handle differences, still that's 
worth the benefit.
And that's also a use case: "Can I use kernel v.X.Y.Z if I need feature w?"
Lets assume we had a set of tests covering a particular feature, and someone
needed that feature, then they could just run the latest set of tests for that
feature on an older kernel to determine if they had enough support for what they
needed. If necessary, they could then backport the feature, and run the tests to
verify that they actually implemented it correctly.

On example I recall of this from the Infiniband driver times was 
the need to have a predictable way to efficiently use huge scatterlists across
kernels. We relied upon scatterlist chaining in a particular way, and the API
descriptions did not really specify to a detailed enough level how the
guaranteed semantics were supposed to be.
I wrote a few simple KTF tests that tested the driver code for the semantics we
expected, and ran them against older and newer kernels and used them to make
sure we would have a driver that worked across a few subtle changes to
scatterlists and their use. 

> > Kunit's ability to run without having to build and run the entire kernel
> >  is also a huge plus. 

IMHO the UML kernel is still a kernel running inside a user land program,
and so is a QEMU/KVM VM, which is my favourite KTF test environment.
 
Also with UML it is more difficult/less useful to deploy user space tools such
as valgrind, which IMHO would be my main reason for getting kernel code out of
the kernel. I recognize that there's a need for 
doing just that (e.g. compiling complicated data structures entirely in user
space with mocked interfaces) but I think it would be much more useful 
to be able to do that without the additional complexity of UML (or QEMU).

> > (Assuming there's a way to get around the build
> > dependency issues). Because of this, it can be very quick to run these
> > tests which makes development a *lot* easier seeing you don't have to
> > reboot a machine every time you want to test a fix.

If your target component under test can be built as a kernel module, or set of
modules, with KTF your workflow would not involve booting at all (unless you
happened to crash the system with one of your tests, that is :) )

You would just unload your module under test and the test module, recompile the
two and insmod again. My work current work cycle on this is just a few seconds.

> I will reply to your comments directly on your original email. I don't
> want to hijack this thread, in case we want to discuss the topic of
> KUnit vs. KTF further.

Good idea!
We can at least agree upon that such an important matter as this can 
be worthy a good, detailed discussion! :)

Thanks!
Knut

