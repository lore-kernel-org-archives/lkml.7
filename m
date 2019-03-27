Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADB8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F83F20651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfC0PF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:05:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59660 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725764AbfC0PF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:05:59 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2RF2XUi020310
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 11:05:57 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rg9mmpctk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 11:05:56 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 27 Mar 2019 15:04:07 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Mar 2019 15:04:04 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2RF433w22806708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 15:04:03 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C9EBB2064;
        Wed, 27 Mar 2019 15:04:03 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3AA1B206B;
        Wed, 27 Mar 2019 15:04:02 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 27 Mar 2019 15:04:02 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A7D1516C60F9; Wed, 27 Mar 2019 08:04:02 -0700 (PDT)
Date:   Wed, 27 Mar 2019 08:04:02 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     NeilBrown <neilb@suse.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] rhashtable: use bit_spin_locks to protect hash
 bucket.
Reply-To: paulmck@linux.ibm.com
References: <155349021177.1111.15681654355431465791.stgit@noble.brown>
 <155349033961.1111.18247269615646768227.stgit@noble.brown>
 <20190326050320.gwk3tgtqwl5csivt@gondor.apana.org.au>
 <874l7p463d.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874l7p463d.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032715-0060-0000-0000-00000322CEA4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010823; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180448; UDB=6.00617762; IPR=6.00961165;
 MB=3.00026180; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-27 15:04:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032715-0061-0000-0000-000048BEA4DF
Message-Id: <20190327150402.GX4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-27_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903270106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 09:35:18AM +1100, NeilBrown wrote:
> On Tue, Mar 26 2019, Herbert Xu wrote:
> 
> > On Mon, Mar 25, 2019 at 04:05:39PM +1100, NeilBrown wrote:
> >>
> >> + * Sometimes we unlock a bucket by writing a new pointer there.  In that
> >> + * case we don't need to unlock, but we do need to reset state such as
> >> + * local_bh. For that we have rht_unlocked().  This doesn't include
> >> + * the memory barrier that bit_spin_unlock() provides, but rcu_assign_pointer()
> >> + * will have provided that.
> >
> > Hmm, are you sure that's enough? IIRC rcu_assign_pointer only
> > provides a write barrier compared to the more complete (but one-way)
> > barrier that a spin-lock provides.
> >
> 
> The bit_spin_unlock(), which I am avoiding as unnecessary, would have
> provided release semantics.
> i.e. any write by this CPU that happened before the releasing write
> will be visible to other CPUs before (or when) they see the result of
> the releasing write.
> This is (as I understand it) exactly that rcu_assign_pointer() promises
> - even before acquire semantics were added as Paul just reported.
> 
> So yes, I am sure (surer now that I've walked through it carefully).

But why not construct a litmus test and apply tools/memory-model?  ;-)

							Thanx, Paul

