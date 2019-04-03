Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E63C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43DF120643
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ohy1m45p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfDCPyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:54:14 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:38254 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfDCPyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:54:14 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x33FmlQx086647;
        Wed, 3 Apr 2019 15:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=qReBWK8TFnnRJ4GgchFv6RlNPNP9puAXnouaEBsFg1Q=;
 b=Ohy1m45pvk9TJdKhCLWgta9Nf0uVuyy9XMgjoQXvQjQ2jL2F/A8ohKSeOmaPqQPVKDa0
 3cKD/ZNj9n7TMWUFz3j4F7+Ud0GRExJAW2iyvq6c7VKZ0UmtGuiTUN1gFz7ov+cs7Vnf
 012u6zZ7SVLBUzlTSBM5sVr+RFajQJ8UpwF+R3EpPhoJd5SORBTS54GiiJqoBlhd9xKH
 0OxrZlINEGwdESzy4I4yuLtSfoHMnfiEtYfnk1otaeHEzxW7YbIhz3M/rlXoabBwtarM
 F8uga9R9BfgjSpDGQP0vCBYH8G3vEPw6Vg7Jb/vvfap9KeKzSytw/nYFKabMa6cFJVFy 0Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2rhwyda4jq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 15:53:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x33FqWhG165584;
        Wed, 3 Apr 2019 15:53:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2rm8f560v0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 15:53:42 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x33Frekr030517;
        Wed, 3 Apr 2019 15:53:41 GMT
Received: from [10.11.111.157] (/10.11.111.157)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Apr 2019 08:53:40 -0700
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20190401093345.GA14281@hirez.programming.kicks-ass.net>
Date:   Wed, 3 Apr 2019 11:53:53 -0400
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <7A8A6827-BF79-47FC-99A1-C9EE00D9C3B1@oracle.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <20190401090653.GF11158@hirez.programming.kicks-ass.net>
 <20190401093345.GA14281@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3259)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904030108
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904030107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Apr 1, 2019, at 5:33 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Mon, Apr 01, 2019 at 11:06:53AM +0200, Peter Zijlstra wrote:
>> On Fri, Mar 29, 2019 at 11:20:04AM -0400, Alex Kogan wrote:
>>> diff --git a/kernel/locking/mcs_spinlock.h =
b/kernel/locking/mcs_spinlock.h
>>> index bc6d3244e1af..71ee4b64c5d4 100644
>>> --- a/kernel/locking/mcs_spinlock.h
>>> +++ b/kernel/locking/mcs_spinlock.h
>>> @@ -17,8 +17,18 @@
>>>=20
>>> struct mcs_spinlock {
>>> 	struct mcs_spinlock *next;
>>> +#ifndef CONFIG_NUMA_AWARE_SPINLOCKS
>>> 	int locked; /* 1 if lock acquired */
>>> 	int count;  /* nesting count, see qspinlock.c */
>>> +#else /* CONFIG_NUMA_AWARE_SPINLOCKS */
>>> +	uintptr_t locked; /* 1 if lock acquired, 0 if not, other values =
*/
>>> +			  /* represent a pointer to the secondary queue =
head */
>>> +	u32 node_and_count;	/* node id on which this thread is =
running */
>>> +				/* with two lower bits reserved for =
nesting */
>>> +				/* count, see qspinlock.c */
>>> +	u32 encoded_tail; /* encoding of this node as the main queue =
tail */
>>> +	struct mcs_spinlock *tail;    /* points to the secondary queue =
tail */
>>> +#endif /* CONFIG_NUMA_AWARE_SPINLOCKS */
>>> };
>>=20
>> Please, have another look at the paravirt code, in particular at =
struct
>> pv_node and its usage. This is horrible.
>=20
> Thing is, this turns into a right mess when you also have PV spinlocks
> on.
>=20
> One thing we could maybe do is change locked and count to u8, then =
your
> overlay structure could be something like:
>=20
> struct mcs_spinlock {
> 	struct mcs_spinlock *next;
> 	u8 locked;
> 	u8 count;
> };
I was trying to keep the size of the mcs_spinlock structure for the =
non-NUMA variant unchanged.
If this is not a huge concern, changing the fields as above would indeed =
simplify a few things.

=E2=80=94 Alex=20

>=20
> struct cna_node {
> 	/* struct mcs_spinlock overlay */
> 	struct mcs_spinlock *next;
> 	u8 locked;
> 	u8 count;
>=20
> 	/* our CNA bits, consuming the slack and PV space */
> 	u16 node;
> 	u32 encoded_tail;
> 	struct mcs_spinlock *head;
> 	struct mcs_spinlock *tail;
> };
>=20
> Then you also don't need the first two patches.

