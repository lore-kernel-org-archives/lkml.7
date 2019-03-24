Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402D3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106612147C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1S3hgTkY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfCXSH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 14:07:58 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35036 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfCXSH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 14:07:58 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2OI4vmh155809;
        Sun, 24 Mar 2019 18:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=SLGCr8pYhi3ByqsLE70fRmvuYYUTuZJ04gB7QSmu7Vk=;
 b=1S3hgTkY8zvoTyE3+Qdgy7t7g4h59aqAdJd7GDF6RHez9RS7B8h86RSBGomDeDm9odeg
 JonKYFxPIQ+dji8jNGQ0PsGb7Y37aY4WW8YUX7V60JIn+53shVGZk/AkkyDj1/3R3JLF
 fsukYVFebv8B+pe0kVyc+MDbWBCNpi6xVbPP/+bz0BgSq8I22ibjKdkrBpU6DDBAGvoH
 X3lRB4EgHOwLbslAT84FPQKVBzrkepMdbhKMsHVM+xkr3G04MkQlP283Jqa0w1GQUEhe
 UebuZTNjbxl7kr5jWc7+GGy0EDEkkY/XAFRL2c3YVrZzyTL+Pj2yGw68SPF5C60Ci2jw 2Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2re6g0gqdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 24 Mar 2019 18:07:11 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2OI7An2007976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 24 Mar 2019 18:07:10 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2OI78id026806;
        Sun, 24 Mar 2019 18:07:09 GMT
Received: from nat-wireless-guest-reg-153-50.bu.edu (/204.8.153.50)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 24 Mar 2019 11:07:08 -0700
Date:   Sun, 24 Mar 2019 14:07:25 -0400
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
To:     Ryan Thibodeaux <thibodux@gmail.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        oleksandr_andrushchenko@epam.com, tglx@linutronix.de,
        jgross@suse.com, ryan.thibodeaux@starlab.io
Subject: Re: [PATCH] x86/xen: Add "xen_timer_slop" command line option
Message-ID: <20190324180724.GA4400@nat-wireless-guest-reg-153-50.bu.edu>
References: <1553279397-130201-1-git-send-email-ryan.thibodeaux@starlab.io>
 <abf65a68-9463-0f0e-1f51-6eefd3cacc88@oracle.com>
 <20190323120052.GB11100@centos-dev.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190323120052.GB11100@centos-dev.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9205 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903240140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 08:00:52AM -0400, Ryan Thibodeaux wrote:
> On Fri, Mar 22, 2019 at 06:10:16PM -0400, Boris Ostrovsky wrote:
> > On 3/22/19 2:29 PM, thibodux@gmail.com wrote:
> > > From: Ryan Thibodeaux <ryan.thibodeaux@starlab.io>
> > >
> > > Add a new command-line option "xen_timer_slop=<INT>" that sets the
> > > minimum delta of virtual Xen timers. This commit does not change the
> > > default timer slop value for virtual Xen timers.
> > >
> > > Lowering the timer slop value should improve the accuracy of virtual
> > > timers (e.g., better process dispatch latency), but it will likely
> > > increase the number of virtual timer interrupts (relative to the
> > > original slop setting).
> > >
> > > The original timer slop value has not changed since the introduction
> > > of the Xen-aware Linux kernel code. This commit provides users an
> > > opportunity to tune timer performance given the refinements to
> > > hardware and the Xen event channel processing. It also mirrors
> > > a feature in the Xen hypervisor - the "timer_slop" Xen command line
> > > option.
> > 
> > Is there any data that shows effects of using this new parameter?
> > 
> > -boris
> > 
> 
> For our own testing using "cyclictest" from the rt-tests project,
> lowering the timer slop helped produce the best test runs, especially
> in terms of maximum process dispatch latency (PDL).
> 
> Here is the output from one such test that ran overnight. The Xen
> timer slop in this case was 10000 or 10 microseconds.
> 
> ...
> [root@slop1 ~]# cset shield -c 3
> [root@slop1 ~]# echo ; date ; echo ; \
> ./rt-tests-1.3/cyclictest -p95 -a3 -t1 -m; echo ; date
> 
> Thu Mar 14 19:45:36 UTC 2019
> 
> # /dev/cpu_dma_latency set to 0us
> policy: fifo: loadavg: 0.00 0.02 0.00 1/91 4260
> T: 0 ( 3212) P:95 I:1000 C:57077313 Min: 27 Act: 44 Avg: 43 Max: 145
> ^C
> Fri Mar 15 11:36:53 UTC 2019
> ...
> 
> This test system was configured to use a TSC clocksource, disabled
> C states, and lowered the timer slop. I am not claiming the timer
> slop change was solely responsible for the best results.

How can we then be sure that the proposed change will indeed provide
some sort of benefit?

Were there any other changes between your tests to think that slop
time modification may not be responsible for better results?

-boris


> In other
> testing with the default timer slop setting of 100000 (100
> microseconds), the average PDL would run slightly higher, but the
> spikes were much higher and more in number, often near the 1000s
> and happening multiple times per 10 minutes of testing.
> 
> - Ryan
