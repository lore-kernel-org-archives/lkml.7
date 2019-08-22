Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C25C3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FF7233FE
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732331AbfHVOAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:00:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8928 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbfHVOAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:00:50 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7MDob8m085843;
        Thu, 22 Aug 2019 10:00:43 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uhuestxqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Aug 2019 10:00:43 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7ME031x022877;
        Thu, 22 Aug 2019 14:00:42 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02dal.us.ibm.com with ESMTP id 2ue976q0mp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Aug 2019 14:00:42 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7ME0flH49938846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Aug 2019 14:00:42 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E13E8B2067;
        Thu, 22 Aug 2019 14:00:41 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4662B2064;
        Thu, 22 Aug 2019 14:00:41 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 22 Aug 2019 14:00:41 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9ACB716C265B; Thu, 22 Aug 2019 07:00:42 -0700 (PDT)
Date:   Thu, 22 Aug 2019 07:00:42 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     josh@joshtriplett.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: don't include <linux/ktime.h> in rcutiny.h
Message-ID: <20190822140042.GZ28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190822015343.4058-1-hch@lst.de>
 <20190822030200.GX28441@linux.ibm.com>
 <20190822034841.GA13668@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822034841.GA13668@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-22_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908220146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 05:48:41AM +0200, Christoph Hellwig wrote:
> On Wed, Aug 21, 2019 at 08:02:00PM -0700, Paul E. McKenney wrote:
> > On Thu, Aug 22, 2019 at 10:53:43AM +0900, Christoph Hellwig wrote:
> > > The kbuild reported a built failure due to a header loop when RCUTINY is
> > > enabled with my pending riscv-nommu port.  Switch rcutiny.h to only
> > > include the minimal required header to get HZ instead.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > Queued for review and testing, thank you!
> > 
> > Do you need this in v5.4?  My normal workflow would put it into v5.5.
> 
> I hope the riscv-nommu coe gets merges for 5.4, so if we could queue
> it up for that I'd appreciate it.

OK, it did pass rcutorture's various !SMP scenarios, so this seems
plausible.

I am sending my main pull request today, but will also put this patch
where 0day and -next can see it.  If it does OK with that and with
additional review/testing for a few days, I will send a second pull
request with that patch some time next week.

							Thanx, Paul
