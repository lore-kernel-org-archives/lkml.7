Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63699C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7482067B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CzumaWKj";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="KZI0Ycmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbfJGQbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:31:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51478 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727801AbfJGQby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:31:54 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x97GJeEX016739;
        Mon, 7 Oct 2019 09:31:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=kkhYNaj+ZdJcy0BrHaWF3OB0j81DTGBarX6WbkH64qM=;
 b=CzumaWKjWsSBXuiASEg+GH8gNG5vfhLNAxm/B2Y3FT+RJo0PRcefcxr2z2aywM2ZaTRv
 MJ2d3j2KJxYUYPr0TWr9KEsfvG95wYjBWEIPT7FeEr1kl3hEwujCYOtcpXrPuOz7dx7z
 IF/ml4KmVkQtCP69RNfVqRQLga4ibuuv3tk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2verpp0q9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 07 Oct 2019 09:31:45 -0700
Received: from ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 7 Oct 2019 09:31:45 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 7 Oct 2019 09:31:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsKIwgTitQzkxzrjwuZvGrCWGYEr3OxQ3uR6LKQyHHvjFYvInLjUE1pnbX/sm7/wOll0azfg0DZYSwskHUXgz3HWbuM5Irmcqs2oBUteeEY/Rw/7Q1lRgzh6DI3cHCilLp+CbGipJgAzjelJFA987Z/bdsFzZArPaL0lLjPxr7FDjD+RxZLMcFEKMvLjpwktHERfgIkBcYvD0KBmjdRoQUQTlRF9tKDt9w+MDLqjN7HQ/gkGd02nv8kB/6glKCyaCjKOflMWL3USvq2vCG4XZ+Fhfrnaqe5T7xS2wbNkZGJJ6A2MyDkYzwEG0IDuCkzH6/uoD0hHqC5rHCPpMVh22Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkhYNaj+ZdJcy0BrHaWF3OB0j81DTGBarX6WbkH64qM=;
 b=Mzzw7qET9RUQhdNGu1P7FCrPUyKvoCdDHpFA19oK1EwsJ36q1whou3FyVI1XIVjuwQs9ZKE/Y48IWa6WoarqKKEhQPjFL1co8T1+7fLFNx1Kpl7Z3jMqqYlv7otIPN/qfp0geEC/RPrADz1PsMeSOD+zaV4Mcb6Qs3+OZi2/m6yQPV5e7R58jA/tjTUEdVzRI7yWuM7SjFm1rgnwCPpq9OHxiiFket4Ib70se1nZ7/5PCJaGgYpbaZyIMc69hNutXAJo1NJ2VVB+9AwIYhEBkRBjdShDBNrUGWklEviKnqBriGVqkhDTvFKXRvp/Cid4L4baL13zgdFCgaf9G3exkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkhYNaj+ZdJcy0BrHaWF3OB0j81DTGBarX6WbkH64qM=;
 b=KZI0Ycmf9ICe498f+JuTq+PQoB3gSBZzermIULgeMw8U7uoVhoKnJ/CVxk9yR0sDB5n0CKky6REYEVA6hx2L8DOwg74vsUAMcMoQmngc+A6bk+1E9j48DFWbCz92agz2J7LAgI7FW2OD60onY4iYt6yobCXMKz7FrfXSRxo3QLs=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1551.namprd15.prod.outlook.com (10.173.228.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Mon, 7 Oct 2019 16:31:37 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2327.025; Mon, 7 Oct 2019
 16:31:37 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Jie Meng <jmeng@fb.com>,
        Hechao Li <hechaol@fb.com>
Subject: Re: [PATCH] perf: rework memory accounting in perf_mmap()
Thread-Topic: [PATCH] perf: rework memory accounting in perf_mmap()
Thread-Index: AQHVY2o7Cb55MgzW70CjSsVfOs8326dEFNqAgAt9sQA=
Date:   Mon, 7 Oct 2019 16:31:37 +0000
Message-ID: <B97C6326-7CA2-4F57-A259-F5FB152E14D1@fb.com>
References: <20190904214618.3795672-1-songliubraving@fb.com>
 <20190930090253.GL4553@hirez.programming.kicks-ass.net>
In-Reply-To: <20190930090253.GL4553@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::1:c5ad]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed412a20-337d-47c6-6304-08d74b43d358
x-ms-traffictypediagnostic: MWHPR15MB1551:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB15519AC55964007165FFF4F9B39B0@MWHPR15MB1551.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(396003)(376002)(366004)(51914003)(189003)(199004)(7736002)(8936002)(6512007)(6246003)(25786009)(71200400001)(14444005)(256004)(54906003)(71190400001)(4326008)(50226002)(8676002)(5660300002)(86362001)(6436002)(4744005)(81166006)(6916009)(305945005)(6486002)(229853002)(486006)(81156014)(2906002)(446003)(46003)(11346002)(316002)(36756003)(102836004)(53546011)(6116002)(2616005)(6506007)(478600001)(476003)(66556008)(66476007)(76176011)(14454004)(33656002)(186003)(76116006)(64756008)(66446008)(66946007)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1551;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QGwPczzxG/gTgW508Fjyl5WIPLHlD4g4JuoNvTuDr2+1usUPFqt5ZHQ0D/wMAYp7qnFIkXTGBABxbiH8GiLKFHK3cdS3QaUncWHRd6ylvaOyNypqznpCZwsuLkmonufFOguCNivcahHoiftcuy8xlz4aIRZ/I2H1tKimUtZz1BhwrVQlqr1uDu/E+avnNYq4ziNzvWHx8FspJcvSvlB6uyavRL7Fsr9649zDNx+f3tHRDz5IodS4StkKblLoijLzBJzFQmkBwyAZjkU8mc88yyTt+xvma+lcp/7hfS1L74r02jOuMMEI4guKNOG2NgmYCbzXnA/5jJ/GMRvdLzkPWubXTRSPmstpZPUkx0Mi4ANFGKNrTCc0dUA8f0E1VMjpswG1ylYrIe0vsll3QaitIO+VcwnCaqTso7dEMLuQJ+w=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A015D35ACDF6814D893638C0BDD57B78@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ed412a20-337d-47c6-6304-08d74b43d358
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 16:31:37.5882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UG3TARshr1tS6/U243zpBMTuvMA/bw7Fy+eKTM9ap9m94vZeKfHgbejDU/uupwnUBYXliOOjVOEEVh/zFPowFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1551
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-07_03:2019-10-07,2019-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910070155
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

> On Sep 30, 2019, at 2:02 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Wed, Sep 04, 2019 at 02:46:18PM -0700, Song Liu wrote:
>> perf_mmap() always increases user->locked_vm. As a result, "extra" could
>> grow bigger than "user_extra", which doesn't make sense. Here is an
>> example case:
>>=20
>> Note: Assume "user_lock_limit" is very small.
>> | # of perf_mmap calls |vma->vm_mm->pinned_vm|user->locked_vm|
>> | 0                    | 0                   | 0             |
>> | 1                    | user_extra          | user_extra    |
>> | 2                    | 3 * user_extra      | 2 * user_extra|
>> | 3                    | 6 * user_extra      | 3 * user_extra|
>> | 4                    | 10 * user_extra     | 4 * user_extra|
>>=20
>> Fix this by maintaining proper user_extra and extra.
>=20
> Aah, indeed.

Thanks for the feedback!

>=20
> Also, this code is unreadable (which is mostly my own fault I suppose)
> :/

How does this patch look to you? Is it ready to merge?

Thanks,
Song
