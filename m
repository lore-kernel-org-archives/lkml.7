Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F871C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 05:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365A2218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 05:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GqEaOGrv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfCUF0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 01:26:10 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34052 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfCUF0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 01:26:10 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2L5OQ0I172795;
        Thu, 21 Mar 2019 05:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2018-07-02;
 bh=CYXv3U6J+BKsaMJ1kigCPH8LU08LREjp5kfcSQ/+bpc=;
 b=GqEaOGrvgWTaH/o/1prKPUqJG3AT04QkGJ8yt52ZXCcNZVlXcWWFta1kppCeGiYwSv5v
 m3gqY2VUffBri/VsHbmCr0XazGyCPj+OWFSP0TsJwH9RQtd2mZaMECmSTL9fgmRHvx5y
 ZKql6GE9QWRV10tzKZSjw1mq8hKFEdBOPXYYf2heLGzcQ5MeU8d//zLOoImDMcvZnz6W
 Xjx8vx4pP12KHjmJEIqVtQ1r+twmE1IPI+cTslOPTPfTwUKLHSVmHNlaRsY2XhVOgdcM
 oX62mkvAOaH89C+4NeZfawHt7nWjgFwlrry4n/3YVWXuiPtIxqqNW0CFdyrxde5W6ZLT eA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2r8pnexp97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Mar 2019 05:24:26 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2L5OKjq000918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Mar 2019 05:24:20 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2L5OE50027680;
        Thu, 21 Mar 2019 05:24:14 GMT
Received: from ovo (/213.188.19.88)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Mar 2019 22:24:12 -0700
Message-ID: <01b2a950f661e8ebd6acbc45c2f89c8f10063daf.camel@oracle.com>
Subject: Re: [RFC v4 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
From:   Knut Omang <knut.omang@oracle.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
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
Date:   Thu, 21 Mar 2019 06:23:59 +0100
In-Reply-To: <6d9b3b21-1179-3a45-7545-30aa15306cb4@deltatee.com>
References: <20190214213729.21702-1-brendanhiggins@google.com>
         <6d9b3b21-1179-3a45-7545-30aa15306cb4@deltatee.com>
Organization: Oracle Inc
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9201 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903210037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Logan,

On Wed, 2019-03-20 at 19:07 -0600, Logan Gunthorpe wrote:
> Hi,
> 
> On 2019-02-14 2:37 p.m., Brendan Higgins wrote:
> > This patch set proposes KUnit, a lightweight unit testing and mocking
> > framework for the Linux kernel.
> 
> I haven't followed the entire conversation but I saw the KUnit write-up
> on LWN and ended up, as an exercise, giving it a try.
> 
> I really like the idea of having a fast unit testing infrastructure in
> the kernel. Occasionally, I write userspace tests for tricky functions
> that I essentially write by copying the code over to a throw away C file
> and exercise them as I need. I think it would be great to be able to
> keep these tests around in a way that they can be run by anyone who
> wants to touch the code.
> 
> I was just dealing with some functions that required some mocked up
> tests so I thought I'd give KUnit a try. I found writing the code very
> easy and the infrastructure I was testing was quite simple to mock out
> the hardware.
> 
> However, I got a bit hung up by one issue: I was writing unit tests for
> code in the NTB tree which itself depends on CONFIG_PCI which cannot be
> enabled in UML (for what should be obvious reasons). I managed to work
> around this because, as luck would have it, all the functions I cared
> about testing were actually static inline functions in headers. So I
> placed my test code in the kunit folder (so it would compile) and hacked
> around a couple a of functions I didn't care about that would not be
> compiled.
> 
> In the end I got it to work acceptably, but I get the impression that
> KUnit will not be usable for wide swaths of kernel code that can't be
> compiled in UML. Has there been any discussion or ideas on how to work
> around this so it can be more generally useful? Or will this feature be
> restricted roughly to non-drivers and functions in headers that don't
> have #ifdefs around them?

Testing drivers, hardware and firmware within production kernels was the use
case that inspired KTF (Kernel Test Framework). Currently KTF is available as a
standalone git repository. That's been the most efficient form for us so far, 
as we typically want tests to be developed once but deployed on many different
kernel versions simultaneously, as part of continuous integration.

But we're also working towards a suitable proposal for how it can be 
smoothly integrated into the kernel, but while still keeping the benefits 
and tools to allow cross-kernel development of tests. As part of this,
I have a master student who has been looking at converting some of 
the existing kernel test suites to KTF, and we have more examples coming 
from our internal usage, as we get more mileage and more users.
See for instance this recent blog entry testing skbuff as an example,
on the Oracle kernel development blog:

https://blogs.oracle.com/linux/writing-kernel-tests-with-the-new-kernel-test-framework-ktf

Other relevant links:

Git repo: https://github.com/oracle/ktf
Formatted docs: http://heim.ifi.uio.no/~knuto/ktf/
LWN mention from my presentation at LPC'17: https://lwn.net/Articles/735034/
Earlier Oracle blog post: https://blogs.oracle.com/linux/oracles-new-kernel-test-framework-for-linux-v2
OSS'18 presentation slides: https://events.linuxfoundation.org/wp-content/uploads/2017/12/Test-Driven-Kernel-Development-Knut-Omang-Oracle.pdf

> If you're interested in seeing the unit tests I ended up writing you can
> find the commits here[1].

It would certainly be interesting to see how the use cases you struggled with
would work with KTF ;-)

Thanks,
Knut

>
> Thanks,
> 
> Logan
> 
> [1] https://github.com/sbates130272/linux-p2pmem/ ntb_kunit

