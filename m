Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E57C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B62A218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wQdB5/Dd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbfCUUQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:16:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35074 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfCUUQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:16:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2LKE1iW101072;
        Thu, 21 Mar 2019 20:15:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2018-07-02;
 bh=PowfQm24qXGgiOSTDFxL7Y7HhjHCgJLN5H2hI3h1Us0=;
 b=wQdB5/DdM5aiTrT60apIVq+9RAjVNIOYss9LZ71xGQc4SBgPdc7KLOIrwBo7ACYDjybh
 kiZatw+yZF5RPAjxD7YJ2fu/fMCh7cl0qS0hI2bIH3BZpn5/DwQcxz4zhpczz5SMRE50
 weAk2Brju5vVy40Tc5AYeRZA2IoINhkw78azuCFhI6nTN5uKh5CP7hBOYtOZrBWBPSE0
 lp4onFxHsvaGo6wYTLidHa08NRia1RhkX3RxOIT7fC8/EBzqSFeNUbIwjXUAyFFDf97h
 5gL4BuQFVK1grli2p146QeTr/5dtBZlTfhR60KcbkldHAeFR1e1LVZqz7ukiTo/SNzJY Wg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2r8ssrtgud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Mar 2019 20:15:05 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2LKF3Od015267
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Mar 2019 20:15:03 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2LKErMB027612;
        Thu, 21 Mar 2019 20:14:53 GMT
Received: from ovo (/213.188.19.88)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Mar 2019 13:14:53 -0700
Message-ID: <356e2b5f8d18b7789a38d0e6e3fe7a48784ba56b.camel@oracle.com>
Subject: Re: [RFC v4 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
From:   Knut Omang <knut.omang@oracle.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
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
Date:   Thu, 21 Mar 2019 21:14:40 +0100
In-Reply-To: <961494a3-d08c-2720-c59d-7d7008edb288@deltatee.com>
References: <20190214213729.21702-1-brendanhiggins@google.com>
         <6d9b3b21-1179-3a45-7545-30aa15306cb4@deltatee.com>
         <01b2a950f661e8ebd6acbc45c2f89c8f10063daf.camel@oracle.com>
         <ce355f5c-189c-816c-cde4-fb4e816d44e7@deltatee.com>
         <CAFd5g45LKU+SZAFzn3RNCoxhzum0NAr9t+UJ80SJDMc_FeKgBQ@mail.gmail.com>
         <73b62e929f631038a9d8d21d261aa22ac3c18949.camel@oracle.com>
         <961494a3-d08c-2720-c59d-7d7008edb288@deltatee.com>
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
 definitions=main-1903210142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-21 at 13:29 -0600, Logan Gunthorpe wrote:
> 
> On 2019-03-21 1:13 p.m., Knut Omang wrote:
> > > Nevertheless, I don't really see KTF as a real unit testing framework
> > > for a number of different reasons; you pointed out some below, but I
> > > think the main one being that it requires booting a real kernel on
> > > actual hardware; 
> > 
> > That depends on what you want to test. If you need hardware (or simulated or
> > emulated hardware) for the test, of course you would need to have that
> > hardware,
> > but if, lets say, you just wanted to run tests like the skbuff example tests
> > (see link above) you wouldn't need anything more than what you need to run
> > KUnit
> > tests.
> 
> I'm starting to get the same impression: KTF isn't unit testing. When we
> are saying "unit tests" we are specifying exactly what we want to test:
> small sections of code in isolation. So by definition you should not
> need hardware for this.

In my world hardware is just that: a piece of code. It can be in many forms, but
it is still code to be tested, and code that can be changed (but sometimes at a
slightly higher cost than a recompile ;-)

But that's not the point here: KTF can be used for your narrower definition of
unit tests, and it can be used for small, precise tests, for particular bugs for
instance, that you would not characterize as a unit test, still it serves the
same purpose, and I believe in a pragmatic approach to this. We want to maximize
the value of our time. I believe there's a sweet point wrt return on investment
on the scale from purist unit testing to just writing code and test with
existing applications. We're targeting that ;-)

> > I have fulfilled that dream, so I know it is possible (Inifinband driver,
> > kernels from 2.6.39 to 4.8.x or so..) I know a lot of projects would benefit
> > from support for such workflows, but that's not really the point here - we
> > want
> > to achieve both goals!
> 
> This is what makes me think we are not talking about testing the same
> things. We are not talking about end to end testing of entire drivers
> but smaller sections of code.

No! I am talking about testing units within a driver, or within any kernel
component. I am sure you agree that what constitutes a unit depend on what 
level of abstraction you are looking at.

>  A unit test is far more granular and
> despite an infinband driver existing for 2.6.39 through 4.8, the
> internal implementation could be drastically different. But unit tests
> would be testing internal details which could be very different version
> to version and has to evolve with the implementation.

> > If your target component under test can be built as a kernel module, or set
> > of
> > modules, with KTF your workflow would not involve booting at all (unless you
> > happened to crash the system with one of your tests, that is :) )
> > You would just unload your module under test and the test module, recompile
> > the
> > two and insmod again. My work current work cycle on this is just a few
> > seconds.
> 
> Yes, I'm sure we've all done that many a time but it's really beside the
> point. Kunit offers a much nicer method for running a lot of unit tests
> on existing code.

Again, use cases and examples are the key here,..

Knut


