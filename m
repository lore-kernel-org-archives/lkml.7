Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6406C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75213205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5S6AgW/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfDCROK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:14:10 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:40106 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfDCROJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:14:09 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x33H3hRG154371;
        Wed, 3 Apr 2019 17:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=AMEI3so+eBmfxTU0R6ccc4DLo94luNS9vEBVO3oIV+M=;
 b=5S6AgW/NZ3zO150072DaZjxsLUd/+NHCNhKNsBC+lYsydsr8GkauCA5XITjNF3yDcjiB
 qzFcZYHNaAJ/dEaVrAzqkRjojL6Rj92pCk3TiH9xaUIvIVsGDtq5lAdo+oFCFDSSfBzP
 HIRVGGGTKDHYFv0d0vnK02+g9GJR+pjJVLL3UoXMuq7QJWzQCLmTmKrrxTOhzRkj62We
 etdYiI54DeV8+ZbxVYc/7ItCr2MwprRHgmnaAuxhdytJEuvTg43eE8GEzFQiFoBMFNbR
 B2FKY6Yy0pURjuRE8xawyYYVvMr99BRo+XvoYSenbzG2h3eKs8wWws6gWOIvo7rP6C2D IQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2rhwydajtx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 17:13:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x33HD5LL033428;
        Wed, 3 Apr 2019 17:13:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2rm8f67mcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 17:13:29 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x33HDQNP019113;
        Wed, 3 Apr 2019 17:13:27 GMT
Received: from [10.11.111.157] (/10.11.111.157)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Apr 2019 10:13:26 -0700
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v2 0/5] Add NUMA-awareness to qspinlock
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20190401090943.GG11158@hirez.programming.kicks-ass.net>
Date:   Wed, 3 Apr 2019 13:13:39 -0400
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <6E1DD598-2493-4C81-9CB6-8024E9244574@oracle.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190401090943.GG11158@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3259)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=817
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904030117
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=859 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904030116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Apr 1, 2019, at 5:09 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Fri, Mar 29, 2019 at 11:20:01AM -0400, Alex Kogan wrote:
>> The following locktorture results are from an Oracle X5-4 server
>> (four Intel Xeon E7-8895 v3 @ 2.60GHz sockets with 18 hyperthreaded
>> cores each).=20
>=20
> The other interesting number is on a !NUMA machine. What do these
> patches do there? Remember, most people do not in fact have numa.
I will make sure to include numbers from a !NUMA machine in the next =
revision of the patch.

Regards,
=E2=80=94 Alex=
