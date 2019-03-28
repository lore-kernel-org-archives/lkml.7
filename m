Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0477C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4FF321773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfC1NVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:21:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45694 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726185AbfC1NVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:21:37 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2SDKTfq133479
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 09:21:35 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rgwxquj5k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 09:21:32 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 28 Mar 2019 13:21:24 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Mar 2019 13:21:21 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2SDLKn217301726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 13:21:20 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C7ECB205F;
        Thu, 28 Mar 2019 13:21:20 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E0C0B2064;
        Thu, 28 Mar 2019 13:21:20 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 28 Mar 2019 13:21:20 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 02BC416C35CE; Thu, 28 Mar 2019 06:21:20 -0700 (PDT)
Date:   Thu, 28 Mar 2019 06:21:20 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Zhang, Jun" <jun.zhang@intel.com>, "He, Bo" <bo.he@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Xiao, Jin" <jin.xiao@intel.com>,
        "Bai, Jie A" <jie.a.bai@intel.com>
Subject: Re: [PATCH 3.18 132/134] rcu: Do RCU GP kthread self-wakeup from
 softirq and interrupt
Reply-To: paulmck@linux.ibm.com
References: <20190322111220.102008032@linuxfoundation.org>
 <CD6925E8781EFD4D8E11882D20FC406D52A646D1@SHSMSX104.ccr.corp.intel.com>
 <20190323063315.GB31361@kroah.com>
 <20190325160017.GD4102@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A6526B@SHSMSX104.ccr.corp.intel.com>
 <20190326155537.GO4102@linux.ibm.com>
 <88DC34334CA3444C85D647DBFA962C2735B04EB8@SHSMSX104.ccr.corp.intel.com>
 <20190327151012.GY4102@linux.ibm.com>
 <88DC34334CA3444C85D647DBFA962C2735B0510F@SHSMSX104.ccr.corp.intel.com>
 <20190328052826.GA18668@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190328052826.GA18668@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032813-0072-0000-0000-00000411A187
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010828; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180891; UDB=6.00618030; IPR=6.00961609;
 MB=3.00026192; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-28 13:21:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032813-0073-0000-0000-00004BA1D061
Message-Id: <20190328132120.GK4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=731 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903280093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 06:28:26AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Mar 28, 2019 at 01:36:12AM +0000, Zhang, Jun wrote:
> > Hello, Paul
> > 
> > Yes, I only use original V3.18.136 to test. Because system run very slowly, I give up.
> > 
> > Device: NUC (made in 2017)
> > OS:        ubuntu 16.04
> > Kernel: V3.18.136 (come from https://kernel.ubuntu.com/~kernel-ppa/mainline/v3.18.136/) 
> > System can boot, but run very slowly, and couldn't connect the network.
> > This make me not to work with terminal, because system very slowly. 
> > So I don’t use V3.18.136+patch to test.
> 
> Please do not worry about 3.18.y if it is any problem, I only keep it
> alive for a few users and if they have not reported issues yet, it is
> fine.  Please do not do any extra work for this kernel tree at all, it
> is just too old :)

Very good.  ;-)

From what I can see, if 3.18.y works for them, then 3.18.y+patch
should also work for them.

							Thanx, Paul

