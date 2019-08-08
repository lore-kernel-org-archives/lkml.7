Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2B7C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD73A2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404853AbfHHWhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 18:37:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16468 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404581AbfHHWhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 18:37:51 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x78Mb79S015279;
        Thu, 8 Aug 2019 18:37:08 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u8uyx9h4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Aug 2019 18:37:08 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x78Mb6bq015237;
        Thu, 8 Aug 2019 18:37:06 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u8uyx9h1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Aug 2019 18:37:06 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x78MZ1dr012957;
        Thu, 8 Aug 2019 22:37:00 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04dal.us.ibm.com with ESMTP id 2u51w7a45p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Aug 2019 22:37:00 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x78Maxdb38666712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Aug 2019 22:36:59 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14AE4B2065;
        Thu,  8 Aug 2019 22:36:59 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8F4BB205F;
        Thu,  8 Aug 2019 22:36:58 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Aug 2019 22:36:58 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6A47916C9A3D; Thu,  8 Aug 2019 15:37:00 -0700 (PDT)
Date:   Thu, 8 Aug 2019 15:37:00 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, kernel-team@android.com,
        kernel-team@lge.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu
 batching
Message-ID: <20190808223700.GZ28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190806212041.118146-1-joel@joelfernandes.org>
 <20190806235631.GU28441@linux.ibm.com>
 <20190807094504.GB169551@google.com>
 <20190808102610.GA7227@X58A-UD3R>
 <20190808181112.GQ28441@linux.ibm.com>
 <20190808201333.GE261256@google.com>
 <20190808205129.GU28441@linux.ibm.com>
 <20190808223415.GG261256@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808223415.GG261256@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-08_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908080201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 06:34:15PM -0400, Joel Fernandes wrote:
> On Thu, Aug 08, 2019 at 01:51:29PM -0700, Paul E. McKenney wrote:
> [snip]
> > > Also, I am thinking that whenever we do per-slab optimization, then the
> > > kmem_cache_free_bulk() can be optimized further. If all pointers are on the
> > > same slab, then we can just do virt_to_cache on the first pointer and avoid
> > > repeated virt_to_cache() calls. That might also give a benefit -- but I could
> > > be missing something.
> > 
> > A sort might be required to make that work nicely, which would add some
> > overhead.  Probably not that much, though, the increased locality would
> > have a fighting chance of overcoming the sort's overhead.
> > 
> > > Right now kmem_cache_free_bulk() just looks like a kmem_cache_free() in a
> > > loop except the small benefit of not disabling/enabling IRQs across each
> > > __cache_free, and the reduced cache miss benefit of using the array.
> > 
> > C'mon!  Show some respect for the awesome power of temporal locality!!!  ;-)
> 
> Good point. I will try to respect it more in the future ;-) After all, it is
> quite a useful concept.

;-) ;-) ;-)

It still has to prove itself in real benchmarks, of course!

							Thanx, Paul
