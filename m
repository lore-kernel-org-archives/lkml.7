Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4CCC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B0C206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="t79rivHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfDCPlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:41:11 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51290 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDCPlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:41:11 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x33FYFcO072696;
        Wed, 3 Apr 2019 15:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=JJb+mGlvysjZ2er76WJTbYjeGDgSM4AIc2gb6fPnsmo=;
 b=t79rivHfrUrVNYIjoUQh+JxEatd0gOW+tTu2UesEIH6nQYorbHw5vMY0qaFlmBmRd856
 uiXp9JpAG2pmAJ8PjTQjwIg0ehoXM7HmnTqrYSVyoKJ41QzGYfZ5QK8nxD2HXHGDV03n
 EvhGrztjcXqnChQSLndk+vzO7MELwN2lSix0c6gE2y9ICt8aq+aoEjq+X7YvR+WumtBK
 YllEQglLX85lV/TCMXiCNGmLOlx3PhwRMnfcYiCxufre9E474JcYKP0PKTAKo4Aodho/
 DnHmpl0BALo5yEFj7Gqoh6NN8p8zhNKpOejf/TevvEkLQH51DMYFUuCIoXgONCFI+So+ Pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2rhwyda1h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 15:39:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x33Fc8aE126918;
        Wed, 3 Apr 2019 15:39:02 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2rm8f55ry9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 15:39:02 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x33FcuHo020332;
        Wed, 3 Apr 2019 15:38:56 GMT
Received: from [10.11.111.157] (/10.11.111.157)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Apr 2019 08:38:56 -0700
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20190402094320.GM11158@hirez.programming.kicks-ass.net>
Date:   Wed, 3 Apr 2019 11:39:09 -0400
Cc:     Waiman Long <longman@redhat.com>, linux@armlinux.org.uk,
        mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, dave.dice@oracle.com,
        rahul.x.yadav@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <6AEDE4F2-306A-4DF9-9307-9E3517C68A2B@oracle.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
 <20190402094320.GM11158@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3259)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904030105
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904030105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter, Longman, many thanks for your detailed comments!

A few follow-up questions are inlined below.

> On Apr 2, 2019, at 5:43 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Mon, Apr 01, 2019 at 10:36:19AM -0400, Waiman Long wrote:
>> On 03/29/2019 11:20 AM, Alex Kogan wrote:
>>> +config NUMA_AWARE_SPINLOCKS
>>> +	bool "Numa-aware spinlocks"
>>> +	depends on NUMA
>>> +	default y
>>> +	help
>>> +	  Introduce NUMA (Non Uniform Memory Access) awareness into
>>> +	  the slow path of spinlocks.
>>> +
>>> +	  The kernel will try to keep the lock on the same node,
>>> +	  thus reducing the number of remote cache misses, while
>>> +	  trading some of the short term fairness for better =
performance.
>>> +
>>> +	  Say N if you want absolute first come first serve fairness.
>>> +
>>=20
>> The patch that I am looking for is to have a separate
>> numa_queued_spinlock_slowpath() that coexists with
>> native_queued_spinlock_slowpath() and
>> paravirt_queued_spinlock_slowpath(). At boot time, we select the most
>> appropriate one for the system at hand.
Is this how this selection works today for paravirt?
I see a PARAVIRT_SPINLOCKS config option, but IIUC you are talking about =
a different mechanism here.
Can you, please, elaborate or give me a link to a page that explains =
that?

>=20
> Agreed; and until we have static_call, I think we can abuse the =
paravirt
> stuff for this.
>=20
> By the time we patch the paravirt stuff:
>=20
>  check_bugs()
>    alternative_instructions()
>      apply_paravirt()
>=20
> we should already have enumerated the NODE topology and so =
nr_node_ids()
> should be set.
>=20
> So if we frob pv_ops.lock.queued_spin_lock_slowpath to
> numa_queued_spin_lock_slowpath before that, it should all get patched
> just right.
>=20
> That of course means the whole NUMA_AWARE_SPINLOCKS thing depends on
> PARAVIRT_SPINLOCK, which is a bit awkward=E2=80=A6
Just to mention here, the patch so far does not address paravirt, but =
our goal is to add this support once we address all the concerns for the =
native version.
So we will end up with four variants for the queued_spinlock_slowpath() =
=E2=80=94 one for each combination of native/paravirt and NUMA/non-NUMA.
Or perhaps we do not need a NUMA/paravirt variant?

=E2=80=94 Alex


