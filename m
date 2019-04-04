Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65952C10F06
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3461F2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dEDWnRjC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfDDDPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:15:32 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:38334 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfDDDPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:15:31 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3438nhh029446;
        Thu, 4 Apr 2019 03:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=ev4JYAe/Q0vIlfaGhqPQ2LV4sWXILDC0f+vPUYFRkxg=;
 b=dEDWnRjC6WyyH7bJPqB/3fTabWgII3FCPaOMwyLlB/HKQU1wv4NANdBcabMr62mPszgP
 TNJAuM+IEiLRX+99/0aP4huQjnOUVeJTyDI1n6Ig3fAwSTAwDLVWS2gVsGYBAb6G2f8G
 pOBy2ZzCdz23alLzeZ+wqNC+5O9tifAcR97ioeLGS2PfXlBb/TX2gaJUzgQ5gCbYnhR8
 K2edCiydSFSPTT2bMqaausudzoJUwFLwBcIvNYoZ8qm4OvTe4wf/dEUY3nC03rkjkQ36
 OFHPvxUp/n0TdTXOvF6ML62p4WIoCXaqaGlrNcIxLALF+GxH+Xa4VofL1aOWbctx3jIC dw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2rhwydcp62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 03:14:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x343EPcj077920;
        Thu, 4 Apr 2019 03:14:41 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2rm8f5eeyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 03:14:41 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x343EZmI004109;
        Thu, 4 Apr 2019 03:14:35 GMT
Received: from [10.39.240.180] (/10.39.240.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Apr 2019 20:14:34 -0700
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <5ac2fb0e-744b-3bb5-133a-ac684e061d17@huawei.com>
Date:   Wed, 3 Apr 2019 23:14:49 -0400
Cc:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, dave.dice@oracle.com,
        rahul.x.yadav@oracle.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <C74425B5-3006-4721-8BEF-55E86830C13D@oracle.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <5ac2fb0e-744b-3bb5-133a-ac684e061d17@huawei.com>
To:     Hanjun Guo <guohanjun@huawei.com>
X-Mailer: Apple Mail (2.3259)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=755
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904040021
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=796 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904040021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hanjun.=20

> On Apr 3, 2019, at 10:02 PM, Hanjun Guo <guohanjun@huawei.com> wrote:
>=20
> Hi Alex,
>=20
> On 2019/3/29 23:20, Alex Kogan wrote:
>> +
>> +static __always_inline void cna_init_node(struct mcs_spinlock *node, =
int cpuid,
>> +					  u32 tail)
>> +{
>> +	if (decode_numa_node(node->node_and_count) =3D=3D -1)
>> +		store_numa_node(node, numa_cpu_node(cpuid));
>=20
> How about using cpu_to_node() here and #include <linux/topology.h> in =
this
> file, then the code can be reused for other architectures such as =
ARM64?
Good point. Thanks!

=E2=80=94 Alex

>=20
> Thanks
> Hanjun
>=20

