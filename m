Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E67C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419DA214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A56APE8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388473AbfDYBr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 21:47:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43640 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388430AbfDYBr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 21:47:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3P1hPbe192509;
        Thu, 25 Apr 2019 01:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=m5ftTYRrPOj/N3lOffaOsUs8i/+eGVM1j6ISGW9DwEo=;
 b=A56APE8ofC8SCuRSVB99zB7aiTYX92gYK342Y0bfoIG+UKXrHFPXBIiu29i2XI9+nR9j
 9kk+YGbtjxA0rBaTcrqMygEZ1kIoRDwRw1OO/0QFM2ibOEEFIDFn05HDA6f4kW4KRQib
 82Kvu4qvwja6mR4cZaLnc34sPR8YLhPk8YnsmomT3nC5feMY5NtcOm3+cGRmSDus+Hq4
 AgY/I+MzKnvZhANi530l362688ZQWSqr93r+cof3XuuLlmVjU/0Qt+AdKedmia0dCyN9
 UVXhFNWMVFScl6GqKsiK4OgTUaFkbifggefTHZyYo4S8E33y7XyQHOIxoZde1A3NBx+6 2g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2rytut5hra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Apr 2019 01:46:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3P1kkuG079991;
        Thu, 25 Apr 2019 01:46:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2s0dwf50tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Apr 2019 01:46:46 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3P1kaV7005547;
        Thu, 25 Apr 2019 01:46:36 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Apr 2019 18:46:35 -0700
Date:   Wed, 24 Apr 2019 21:47:05 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Paul Mackerras <paulus@samba.org>,
        Christoph Lameter <cl@linux.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 5/6] powerpc/mmu: drop mmap_sem now that locked_vm is
 atomic
Message-ID: <20190425014705.k5twrldr5n5a5gsz@ca-dmjordan1.us.oracle.com>
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
 <20190402204158.27582-6-daniel.m.jordan@oracle.com>
 <964bd5b0-f1e5-7bf0-5c58-18e75c550841@c-s.fr>
 <20190403164002.hued52o4mga4yprw@ca-dmjordan1.us.oracle.com>
 <20190424021544.ygqa4hvwbyb6nuxp@linux-r8p5>
 <20190424111018.GA16077@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424111018.GA16077@mellanox.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9237 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904250010
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9237 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904250010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 11:10:24AM +0000, Jason Gunthorpe wrote:
> On Tue, Apr 23, 2019 at 07:15:44PM -0700, Davidlohr Bueso wrote:
> > Wouldn't the cmpxchg alternative also be exposed the locked_vm changing between
> > validating the new value and the cmpxchg() and we'd bogusly fail even when there
> > is still just because the value changed (I'm assuming we don't hold any locks,
> > otherwise all this is pointless).

That's true, I hadn't considered that we could retry even when there's enough
locked_vm.  Seems like another one is that RLIMIT_MEMLOCK could change after
it's read.  I guess nothing's going to be perfect.  :/

> Well it needs a loop..
> 
> again:
>    current_locked = atomic_read(&mm->locked_vm);
>    new_locked = current_locked + npages;
>    if (new_locked < lock_limit)
>       if (cmpxchg(&mm->locked_vm, current_locked, new_locked) != current_locked)
>             goto again;
> 
> So it won't have bogus failures as there is no unwind after
> error. Basically this is a load locked/store conditional style of
> locking pattern.

This is basically what I have so far.

> > > That's a good idea, and especially worth doing considering that an arbitrary
> > > number of threads that charge a low amount of locked_vm can fail just because
> > > one thread charges lots of it.
> > 
> > Yeah but the window for this is quite small, I doubt it would be a real issue.
>
> > What if before doing the atomic_add_return(), we first did the racy new_locked
> > check for ENOMEM, then do the speculative add and cleanup, if necessary. This
> > would further reduce the scope of the window where false ENOMEM can occur.

So the upside of this is that there's no retry loop so tasks don't spin under
heavy contention?  Seems better to always guard against false ENOMEM, at least
from the locked_vm side if not from the rlimit changing.

> > > pinned_vm appears to be broken the same way, so I can fix it too unless someone
> > > beats me to it.
> > 
> > This should not be a surprise for the rdma folks. Cc'ing Jason nonetheless.
> 
> I think we accepted this tiny race as a side effect of removing the
> lock, which was very beneficial. Really the time window between the
> atomic failing and unwind is very small, and there are enough other
> ways a hostile user could DOS locked_vm that I don't think it really
> matters in practice..
> 
> However, the cmpxchg seems better, so a helper to implement that would
> probably be the best thing to do.

I've collapsed all the locked_vm users into such a helper and am now working on
converting the pinned_vm users to the same helper.  Taking longer than I
thought.
