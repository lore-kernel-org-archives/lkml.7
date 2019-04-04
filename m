Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9DEC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFA82082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfDDAOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:14:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726193AbfDDAOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:14:41 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x340B2qj047392
        for <linux-kernel@vger.kernel.org>; Wed, 3 Apr 2019 20:14:40 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rn5e6utub-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:14:40 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 4 Apr 2019 01:14:39 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 4 Apr 2019 01:14:36 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x340EZUa10551446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Apr 2019 00:14:35 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67F61B2068;
        Thu,  4 Apr 2019 00:14:35 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 471F8B2065;
        Thu,  4 Apr 2019 00:14:35 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.202.55])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  4 Apr 2019 00:14:35 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B839F16C0FB0; Wed,  3 Apr 2019 17:14:35 -0700 (PDT)
Date:   Wed, 3 Apr 2019 17:14:35 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Corey Minyard <cminyard@mvista.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: Re: linux-next: build failure after merge of the ipmi tree
Reply-To: paulmck@linux.ibm.com
References: <20190403143323.156ac503@canb.auug.org.au>
 <20190403202728.GD2479@minyard.net>
 <20190403211212.GE2479@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403211212.GE2479@minyard.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19040400-0072-0000-0000-0000041524C4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010869; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01183956; UDB=6.00619883; IPR=6.00964708;
 MB=3.00026286; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-04 00:14:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040400-0073-0000-0000-00004BB3C858
Message-Id: <20190404001435.GC14111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904040000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 04:12:12PM -0500, Corey Minyard wrote:
> On Wed, Apr 03, 2019 at 03:27:29PM -0500, Corey Minyard wrote:
> > On Wed, Apr 03, 2019 at 02:33:23PM +1100, Stephen Rothwell wrote:
> > > Hi Corey,
> > > 
> > > After merging the ipmi tree, today's linux-next build (x86_64
> > > allmodconfig) failed like this:
> > 
> > Paul, any opinions on this?  Is just running this in a workqueue
> > the best idea?
> 
> Well, I just that patch using a work item and pushed it up.  Seems
> to work ok.  That was already done for other things in the driver.

Sounds good to me, apologies for the slow response.

							Thanx, Paul

> > -corey
> > 
> > > 
> > > drivers/char/ipmi/ipmi_msghandler.c: In function 'free_user':
> > > drivers/char/ipmi/ipmi_msghandler.c:1268:2: error: implicit declaration of function 'cleanup_srcu_struct_quiesced'; did you mean 'cleanup_srcu_struct'? [-Werror=implicit-function-declaration]
> > >   cleanup_srcu_struct_quiesced(&user->release_barrier);
> > >   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >   cleanup_srcu_struct
> > > 
> > > Caused by commit
> > > 
> > >   487ecb21fa66 ("ipmi: fix sleep-in-atomic in free_user at cleanup SRCU user->release_barrier")
> > > 
> > > interacting with commit
> > > 
> > >   f5ad3991493c ("srcu: Remove cleanup_srcu_struct_quiesced()")
> > > 
> > > from the rcu tree.
> > > 
> > > Based on the comments in the rcu tree commit, I have reverted the impi
> > > tree commit for today.
> > > 
> > > -- 
> > > Cheers,
> > > Stephen Rothwell
> > 
> > 
> 

