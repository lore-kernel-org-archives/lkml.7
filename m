Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EBCC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E2A2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rO2SoqUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfDCRHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:07:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36634 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCRHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:07:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x33H3gTb148904;
        Wed, 3 Apr 2019 17:06:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=18jsAKrm+I67hogv6dRp6LwocjCgPIU6h3J3TMxV0Fo=;
 b=rO2SoqUw3cCjVMMU4DE/QsE3rr3wadT1JGVACYIrw26ErfOc9DM7QPddYiwXjscm9Pmk
 9T/z/vAwuHuXa36Pjw10aWf/7hlkGDnW4iKFtY2vkDLM5L7CbVDYGcIHNspOUzkWFi7X
 sUjyJR8ocxzNqXmEgSR+ZBVMu4QQFPRJx6PlAaz5Nb6uuvNvTpQj44btKNjl1tP8L987
 N7HveERH0I5yORDJEtmfj+RWbVhgnQjbFhv1wicRDfaLqOHbXEOwYfnTv+4AfrW14o2a
 j/MBi5fcV7k9CaQP1+v6SfFzbr95bRX9QxI9tuRRHpyQkCfqXQo/rHn2aXvl2Gf0XGqi SA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2rhyvtacuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 17:06:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x33H6CZh009551;
        Wed, 3 Apr 2019 17:06:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2rm8f57gws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 17:06:12 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x33H5xZr015244;
        Wed, 3 Apr 2019 17:05:59 GMT
Received: from [10.11.111.157] (/10.11.111.157)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Apr 2019 10:05:59 -0700
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v2 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20190402103750.GN11158@hirez.programming.kicks-ass.net>
Date:   Wed, 3 Apr 2019 13:06:12 -0400
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com, tytso@mit.edu
Content-Transfer-Encoding: quoted-printable
Message-Id: <AC118CEC-7394-44F7-BCA9-BFA321AF3E09@oracle.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-5-alex.kogan@oracle.com>
 <20190402103750.GN11158@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3259)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904030116
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904030116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Apr 2, 2019, at 6:37 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Fri, Mar 29, 2019 at 11:20:05AM -0400, Alex Kogan wrote:
>> @@ -25,6 +29,18 @@
>>=20
>> #define MCS_NODE(ptr) ((struct mcs_spinlock *)(ptr))
>>=20
>> +/* Per-CPU pseudo-random number seed */
>> +static DEFINE_PER_CPU(u32, seed);
>> +
>> +/*
>> + * Controls the probability for intra-node lock hand-off. It can be
>> + * tuned and depend, e.g., on the number of CPUs per node. For now,
>> + * choose a value that provides reasonable long-term fairness =
without
>> + * sacrificing performance compared to a version that does not have =
any
>> + * fairness guarantees.
>> + */
>> +#define INTRA_NODE_HANDOFF_PROB_ARG 0x10000
>> +
>> static inline __pure int decode_numa_node(u32 node_and_count)
>> {
>> 	int node =3D (node_and_count >> _Q_NODE_OFFSET) - 1;
>> @@ -102,6 +118,35 @@ static struct mcs_spinlock =
*find_successor(struct mcs_spinlock *me)
>> 	return NULL;
>> }
>>=20
>> +/*
>> + * xorshift function for generating pseudo-random numbers:
>> + * =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__en.wikipedia.org_wi=
ki_Xorshift&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3D=
Hvhk3F4omdCk-GE1PTOm3Kn0A7ApWOZ2aZLTuVxFK4k&m=3DbtYIeJJfSDAM0UloKh-zrG4-Pg=
dCMjQMKnvDIqPuEQk&s=3D1UYM9Qd5nozlImYHub0yqRmQCja5hJtnzbHuudtz-nM&e=3D
>=20
> Cute; so clearly you've read that page, but then you provide us a
> variant that isn't actually listed there.
>=20
> Your naming is also non-standard in that it does not relay the period.
> The type seems to suggest 32bit, so the name should then have been:
>=20
>  xorshift32()
>=20
> Now, where did you get those parameters from; is this a proper
> xorshift32 ?
Apologies for the confusion.
We are using one of the shift tuples from the Xorshift paper =
(https://www.jstatsoft.org/v08/i14/paper), which is referenced by the =
wiki page.
Those tuples happen to be different from the ones on the wiki page =
itself.
I do not think we care much, though =E2=80=94 if we keep using xorshift =
(see below), we will switch to the variant from the wiki to avoid any =
confusion.

>=20
> Now, you've read that page and you know there's 'trivial' improvements
> on the pure xorshift, why not pick one of those? xorwow seems cheap
> enough, or that xorshift128plus() one.
Xorshift seems to be working well enough for our purposes, while those =
other variants are slightly more expensive and have a larger state.

>=20
>> +
>> +/*
>> + * Return false with probability 1 / @range.
>> + * @range must be a power of 2.
>> + */
>> +static bool probably(unsigned int range)
>> +{
>> +	return xor_random() & (range - 1);
>> +}
>=20
> Uhh, you sure that's what it does? The only way for that to return =
false
> is when all @range bits are 0, which happens once (2^32/range)-1 =
times,
> or am I mistaken?

probably() would return 0 if and only if xor_random() returns 0 in the =
lowest log_2(range) bits,
which should happen with probability of 1/(2^log_2(range))=3D1/range.

>=20
> Also, linux/random.h includes next_pseudo_random32(), should we be =
using
> that? Arguably that's more expensive on a number of platforms due to =
the
> multiplication.
We will check the impact of using next_pseudo_random32().

> Also, we actually have xorshift32 already in tree in
> lib/test_hash.c.
I see that now. We can certainly use this function instead.=20
If we end up doing that, any suggestion where it should be moved to be =
called from multiple places (the original lib/test_hash.c and our CNA =
code)?

Thanks,
=E2=80=94 Alex=
