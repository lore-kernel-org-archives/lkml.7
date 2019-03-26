Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A178BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2F220863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732093AbfCZPzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:55:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42760 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732035AbfCZPzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:55:44 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QFrxHD074278
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:55:42 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rfpn51mxk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:55:41 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 15:55:41 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 15:55:37 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QFtbZ823593012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 15:55:37 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA3EFB2064;
        Tue, 26 Mar 2019 15:55:36 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCA39B206B;
        Tue, 26 Mar 2019 15:55:36 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 15:55:36 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6222D16C3238; Tue, 26 Mar 2019 08:55:37 -0700 (PDT)
Date:   Tue, 26 Mar 2019 08:55:37 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "He, Bo" <bo.he@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Zhang, Jun" <jun.zhang@intel.com>,
        "Xiao, Jin" <jin.xiao@intel.com>,
        "Bai, Jie A" <jie.a.bai@intel.com>
Subject: Re: [PATCH 3.18 132/134] rcu: Do RCU GP kthread self-wakeup from
 softirq and interrupt
Reply-To: paulmck@linux.ibm.com
References: <20190322111210.465931067@linuxfoundation.org>
 <20190322111220.102008032@linuxfoundation.org>
 <CD6925E8781EFD4D8E11882D20FC406D52A646D1@SHSMSX104.ccr.corp.intel.com>
 <20190323063315.GB31361@kroah.com>
 <20190325160017.GD4102@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A6526B@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CD6925E8781EFD4D8E11882D20FC406D52A6526B@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032615-0040-0000-0000-000004D787DD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010818; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01179987; UDB=6.00606765; IPR=6.00960702;
 MB=3.00026165; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 15:55:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032615-0041-0000-0000-000008E2A8DF
Message-Id: <20190326155537.GO4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=945 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 08:43:45AM +0000, He, Bo wrote:
> Hi, Paul:
> 	I have tried on my PC and not hit any hang issue with RCU torture test for one hour, the configurations are like:
> OS: ubuntu 16.04
> kenrel: 3.18.136 + 3.18 rcu patch
> CPU:  Intel(R) Xeon(R) CPU E3-1225 V2 @ 3.20GHz

Sounds good, please proceed!

							Thanx, Paul

> -----Original Message-----
> From: Paul E. McKenney <paulmck@linux.ibm.com> 
> Sent: Tuesday, March 26, 2019 12:00 AM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: He, Bo <bo.he@intel.com>; linux-kernel@vger.kernel.org; stable@vger.kernel.org; Zhang, Jun <jun.zhang@intel.com>; Xiao, Jin <jin.xiao@intel.com>; Bai, Jie A <jie.a.bai@intel.com>
> Subject: Re: [PATCH 3.18 132/134] rcu: Do RCU GP kthread self-wakeup from softirq and interrupt
> 
> On Sat, Mar 23, 2019 at 07:33:15AM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Mar 22, 2019 at 04:00:17PM +0000, He, Bo wrote:
> > > Hi, Greg:
> > > 	Can you hold on the 3.18-stable branch, it seems there are some issue, please see the comments from Paul:
> > > 
> > > Comments from Paul:
> > > I subjected all of the others to light rcutorture testing, which 
> > > they passed.  This v3.18 patch hung, however.  Trying it again with 
> > > stock
> > > v3.18 got the same hang, so I believe we can exonerate the patch and give it a good firm "maybe" on 3.18.
> > > 
> > > Worth paying special attention to further test results from 3.18.x, though!
> > 
> > Ok, I've dropped this from the 3.18.y queue now, thanks.
> 
> Bo, if you know of a "y" for 3.18.y that would likely pass rcutorture testing, please let me know.
> 
> 							Thanx, Paul
> 

