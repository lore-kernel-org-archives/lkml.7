Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95CBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95CF920651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbfC0PKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:10:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47152 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726054AbfC0PKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:10:19 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2RF3ILY099389
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 11:10:18 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rg9tjdsuk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 11:10:18 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 27 Mar 2019 15:10:17 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Mar 2019 15:10:14 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2RFADHv23527534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 15:10:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A388B2070;
        Wed, 27 Mar 2019 15:10:13 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 378D3B206E;
        Wed, 27 Mar 2019 15:10:13 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 27 Mar 2019 15:10:13 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E38E216C60F9; Wed, 27 Mar 2019 08:10:12 -0700 (PDT)
Date:   Wed, 27 Mar 2019 08:10:12 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Zhang, Jun" <jun.zhang@intel.com>
Cc:     "He, Bo" <bo.he@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
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
 <20190326155537.GO4102@linux.ibm.com>
 <88DC34334CA3444C85D647DBFA962C2735B04EB8@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88DC34334CA3444C85D647DBFA962C2735B04EB8@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032715-0060-0000-0000-00000322CF5C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010823; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180450; UDB=6.00617763; IPR=6.00961167;
 MB=3.00026180; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-27 15:10:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032715-0061-0000-0000-000048BEAA1C
Message-Id: <20190327151012.GY4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-27_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=918 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903270106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Jun,

Do you see the same hang without the patch?

							Thanx, Paul

On Wed, Mar 27, 2019 at 01:50:57AM +0000, Zhang, Jun wrote:
> Hello，Paul
> 
> I use a new NUC (made in 2017) to test, meet the same hang. System run very slowly.
> 
> But I use my PC (made before 2015), test V3.18.136+ patch for 12 hours, still well.
> 
> Maybe V3.18.y don't support some new devices.
> 
> 
> -----Original Message-----
> From: Paul E. McKenney [mailto:paulmck@linux.ibm.com] 
> Sent: Tuesday, March 26, 2019 23:56
> To: He, Bo <bo.he@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-kernel@vger.kernel.org; stable@vger.kernel.org; Zhang, Jun <jun.zhang@intel.com>; Xiao, Jin <jin.xiao@intel.com>; Bai, Jie A <jie.a.bai@intel.com>
> Subject: Re: [PATCH 3.18 132/134] rcu: Do RCU GP kthread self-wakeup from softirq and interrupt
> 
> On Tue, Mar 26, 2019 at 08:43:45AM +0000, He, Bo wrote:
> > Hi, Paul:
> > 	I have tried on my PC and not hit any hang issue with RCU torture test for one hour, the configurations are like:
> > OS: ubuntu 16.04
> > kenrel: 3.18.136 + 3.18 rcu patch
> > CPU:  Intel(R) Xeon(R) CPU E3-1225 V2 @ 3.20GHz
> 
> Sounds good, please proceed!
> 
> 							Thanx, Paul
> 
> > -----Original Message-----
> > From: Paul E. McKenney <paulmck@linux.ibm.com>
> > Sent: Tuesday, March 26, 2019 12:00 AM
> > To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: He, Bo <bo.he@intel.com>; linux-kernel@vger.kernel.org; 
> > stable@vger.kernel.org; Zhang, Jun <jun.zhang@intel.com>; Xiao, Jin 
> > <jin.xiao@intel.com>; Bai, Jie A <jie.a.bai@intel.com>
> > Subject: Re: [PATCH 3.18 132/134] rcu: Do RCU GP kthread self-wakeup 
> > from softirq and interrupt
> > 
> > On Sat, Mar 23, 2019 at 07:33:15AM +0100, Greg Kroah-Hartman wrote:
> > > On Fri, Mar 22, 2019 at 04:00:17PM +0000, He, Bo wrote:
> > > > Hi, Greg:
> > > > 	Can you hold on the 3.18-stable branch, it seems there are some issue, please see the comments from Paul:
> > > > 
> > > > Comments from Paul:
> > > > I subjected all of the others to light rcutorture testing, which 
> > > > they passed.  This v3.18 patch hung, however.  Trying it again 
> > > > with stock
> > > > v3.18 got the same hang, so I believe we can exonerate the patch and give it a good firm "maybe" on 3.18.
> > > > 
> > > > Worth paying special attention to further test results from 3.18.x, though!
> > > 
> > > Ok, I've dropped this from the 3.18.y queue now, thanks.
> > 
> > Bo, if you know of a "y" for 3.18.y that would likely pass rcutorture testing, please let me know.
> > 
> > 							Thanx, Paul
> > 
> 

