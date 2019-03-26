Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC46FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8226A20856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbfCZInw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:43:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:30394 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730795AbfCZInv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:43:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 01:43:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,271,1549958400"; 
   d="scan'208";a="143872030"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Mar 2019 01:43:49 -0700
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 26 Mar 2019 01:43:48 -0700
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
 fmsmsx109.amr.corp.intel.com (10.18.116.9) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 26 Mar 2019 01:43:48 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.74]) by
 SHSMSX108.ccr.corp.intel.com ([169.254.8.57]) with mapi id 14.03.0415.000;
 Tue, 26 Mar 2019 16:43:46 +0800
From:   "He, Bo" <bo.he@intel.com>
To:     "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Zhang, Jun" <jun.zhang@intel.com>,
        "Xiao, Jin" <jin.xiao@intel.com>,
        "Bai, Jie A" <jie.a.bai@intel.com>
Subject: RE: [PATCH 3.18 132/134] rcu: Do RCU GP kthread self-wakeup from
 softirq and interrupt
Thread-Topic: [PATCH 3.18 132/134] rcu: Do RCU GP kthread self-wakeup from
 softirq and interrupt
Thread-Index: AQHU4KqYbVRqZb7atkmxHemt0KStl6YXzqyAgABueYCAA8MXgIABnYkA
Date:   Tue, 26 Mar 2019 08:43:45 +0000
Message-ID: <CD6925E8781EFD4D8E11882D20FC406D52A6526B@SHSMSX104.ccr.corp.intel.com>
References: <20190322111210.465931067@linuxfoundation.org>
 <20190322111220.102008032@linuxfoundation.org>
 <CD6925E8781EFD4D8E11882D20FC406D52A646D1@SHSMSX104.ccr.corp.intel.com>
 <20190323063315.GB31361@kroah.com> <20190325160017.GD4102@linux.ibm.com>
In-Reply-To: <20190325160017.GD4102@linux.ibm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODMxZTY5NzMtYmRlYy00YTg1LWFlYTQtYWUyYjdjMWFlZDczIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYlIrWk5HXC9NTExmNWw3U25OWmRHVUFVa1Y1K0w1cXdNOGtzV25ub0FZeG1KY1VrSFRWYkpaWjFrSU43N09ESHEifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Paul:
	I have tried on my PC and not hit any hang issue with RCU torture test for one hour, the configurations are like:
OS: ubuntu 16.04
kenrel: 3.18.136 + 3.18 rcu patch
CPU:  Intel(R) Xeon(R) CPU E3-1225 V2 @ 3.20GHz

-----Original Message-----
From: Paul E. McKenney <paulmck@linux.ibm.com> 
Sent: Tuesday, March 26, 2019 12:00 AM
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: He, Bo <bo.he@intel.com>; linux-kernel@vger.kernel.org; stable@vger.kernel.org; Zhang, Jun <jun.zhang@intel.com>; Xiao, Jin <jin.xiao@intel.com>; Bai, Jie A <jie.a.bai@intel.com>
Subject: Re: [PATCH 3.18 132/134] rcu: Do RCU GP kthread self-wakeup from softirq and interrupt

On Sat, Mar 23, 2019 at 07:33:15AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Mar 22, 2019 at 04:00:17PM +0000, He, Bo wrote:
> > Hi, Greg:
> > 	Can you hold on the 3.18-stable branch, it seems there are some issue, please see the comments from Paul:
> > 
> > Comments from Paul:
> > I subjected all of the others to light rcutorture testing, which 
> > they passed.  This v3.18 patch hung, however.  Trying it again with 
> > stock
> > v3.18 got the same hang, so I believe we can exonerate the patch and give it a good firm "maybe" on 3.18.
> > 
> > Worth paying special attention to further test results from 3.18.x, though!
> 
> Ok, I've dropped this from the 3.18.y queue now, thanks.

Bo, if you know of a "y" for 3.18.y that would likely pass rcutorture testing, please let me know.

							Thanx, Paul

