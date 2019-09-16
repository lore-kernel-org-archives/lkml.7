Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0950C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 20:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37EC20665
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 20:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NZlH08CD";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="EPA874AW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732972AbfIPUKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 16:10:42 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1322 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730467AbfIPUKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 16:10:42 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x8GK7r8i011126;
        Mon, 16 Sep 2019 13:10:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=d6lLv4CQcuqPMEg/JaLwRKQ57jFBy6XFkjAvXWBifok=;
 b=NZlH08CD3Q6K2St0eXpyL7Fxm9PpdUaZN/Qp1wATM3goY7w+0s4qVXhgFxIg7h9EzMZV
 UdzVulphtFVHISNzQg1yZj0PqC3oe4ggud9glZ9CYIpkLyVVdJLJEVOZxXFSuwPDzde4
 Hf+NO+qBLZpdBx0Qpjd1MiLg5Ef81jZcHBA= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2v21jpbjxu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 16 Sep 2019 13:10:31 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 16 Sep 2019 13:10:26 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 16 Sep 2019 13:10:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dR7Hu1xzT15EapEX0Zy/JCy+HkFvvIvL5Hr56wSPc9r00DoP800d6qUbbdb50ZHP2FUB5jJBMlSFPFVUOUTaU6p+HWYOe9Dwcw5IES3asN6mPn3h15AH9N9dezr4Nlc9JzK90uXlNURzD1+uO0NqRjxN1A1b2GN8uvvQctevHASpcCZiINnSR6M4FQFv4xzHteoB0MYMRqX/7OJPis0X0AhIgOwYy47CTwTFOGNh7a5NW2f2jkZ2pQ2Thpzikg2vEFgwWeRmXP4R7K0XXhIAn0nn4X2M8HO3bokhwcARxPWM9gfsXX9gJIkM+dBCv7DgT6o3yMRQ3rlfC9/Wo9Va3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6lLv4CQcuqPMEg/JaLwRKQ57jFBy6XFkjAvXWBifok=;
 b=YETY8p5lJE+GWz4JCC1Xv95Isbi2l45r4bOEWeRSlJWnlBdxeMrhed5N9b6NZkXk0DJ3+p++svzPOkdLOKVFyW44OWUYh1JOq3yv8VWCO1WwV5MwPFcNs8xqXVkPU+5DcuvtUfbLYWTsLGZ0XzKYAUm3LDehJ+bCdnZj3fCttXxS0kRMNhoROnl7MANcKWxyVKs4ZNgaQdXifCd6sqXAJWjp3sDeUhuMj+jMcgpyEHofwTmv7WSnPpHyMTwUv2oM9R9NeqqR3lIqF3WniVzvnuVKBGbkcQYhoPklR90Wh57iGXvfiD3FH177RShnPDkUXwQgsCTm1R3hjpbx9+GhZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6lLv4CQcuqPMEg/JaLwRKQ57jFBy6XFkjAvXWBifok=;
 b=EPA874AW2+560Vu3BQ7/CYt+hsxf+pNbhiYqr0Bl1z1zCKeTpPFYUnop9i6GuHb2OAAiiGCh+vSGahr1uB91m4qWE6gv4ZSPi4EqNopYed2PPhPCwNRXeXq1tSdzzPfO6X5CtfYljNGpQNa9rYMU0I3rnfPogU2922DSJH8orr0=
Received: from BYAPR15MB2968.namprd15.prod.outlook.com (20.178.237.149) by
 BYAPR15MB3511.namprd15.prod.outlook.com (20.179.59.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Mon, 16 Sep 2019 20:10:24 +0000
Received: from BYAPR15MB2968.namprd15.prod.outlook.com
 ([fe80::ed08:6100:33b6:520a]) by BYAPR15MB2968.namprd15.prod.outlook.com
 ([fe80::ed08:6100:33b6:520a%4]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 20:10:24 +0000
From:   Hechao Li <hechaol@fb.com>
To:     Song Liu <songliubraving@fb.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel Team <Kernel-team@fb.com>, Jie Meng <jmeng@fb.com>
Subject: Re: [PATCH] perf: rework memory accounting in perf_mmap()
Thread-Topic: [PATCH] perf: rework memory accounting in perf_mmap()
Thread-Index: AQHVY2o7Cb55MgzW70CjSsVfOs8326cuxyMAgAAHkYA=
Date:   Mon, 16 Sep 2019 20:10:24 +0000
Message-ID: <20190916201021.GA99598@hechaol-mbp.dhcp.thefacebook.com>
References: <20190904214618.3795672-1-songliubraving@fb.com>
 <D0AB9FA0-B99D-4BE4-82FF-E3098EFFB208@fb.com>
In-Reply-To: <D0AB9FA0-B99D-4BE4-82FF-E3098EFFB208@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO1PR15CA0043.namprd15.prod.outlook.com
 (2603:10b6:101:1f::11) To BYAPR15MB2968.namprd15.prod.outlook.com
 (2603:10b6:a03:f8::21)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:85fc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53b6c5c6-19d2-4550-beec-08d73ae1e8c2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR15MB3511;
x-ms-traffictypediagnostic: BYAPR15MB3511:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB351129FB5D4B86D81DBFDEF7D58C0@BYAPR15MB3511.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(199004)(189003)(4326008)(476003)(5660300002)(4744005)(2906002)(486006)(6512007)(9686003)(76176011)(1076003)(64756008)(66556008)(66476007)(66946007)(52116002)(81156014)(8676002)(66446008)(6436002)(46003)(33656002)(498600001)(14454004)(86362001)(446003)(11346002)(229853002)(81166006)(6862004)(71190400001)(71200400001)(25786009)(6486002)(6246003)(53936002)(6116002)(14444005)(6636002)(8936002)(54906003)(99286004)(6506007)(7736002)(386003)(305945005)(53546011)(186003)(102836004)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3511;H:BYAPR15MB2968.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FTYIWHARKB+vZsyR/GPZKWdR4Zk5G7kMPW7uLEKWXqS9mtCTShGc6Hea6wgEOQBcsBrtIjhbvnTNl67Y1DUVJ1PmRpzc1VFZy++T67cqFiyw8bUwZSFn62BZUfILmnTF5T0rZLWLd+HDzdJj8jF+N9yeS6R7MEF8uaxosN6BFxTKV1HiQVIt0wst1mTbviu/N8SZl2sdfKb3qJ9fF/oxdpok/yxktDYoitr+j5bTLrUUpalTe1WxgO34TG0BNwtF8HPlXM/cuM+FDQXI/uw8GiLrlv0SkSoeknysRghZ2vZ6fLxfQVjWjrPDiJ6cQ1cJ7NvF0SSQk3tlcnfR3aZsWTVUiOJpmIWjBuRD+jYcErpg88cwH7PpfzOi+n3+RPTSlufPipFt66dXPdGecpfFGFfUo9tcAFPcGyeEHJ+K0v4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C96D1D8D35690F4E9135B643F356DB68@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b6c5c6-19d2-4550-beec-08d73ae1e8c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 20:10:24.6372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bJPhf5xcqQiyv1NK43FI3QxgDyYPL73uycAjFPlVqpLrtVQCi2WjKzbIpLjaEsCU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3511
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-16_07:2019-09-11,2019-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 clxscore=1011 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1909160197
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Song Liu <songliubraving@fb.com> wrote on Mon [2019-Sep-16 12:43:16 -0700]:
> Hi Peter,
>=20
> > On Sep 4, 2019, at 2:46 PM, Song Liu <songliubraving@fb.com> wrote:
> >=20
> > perf_mmap() always increases user->locked_vm. As a result, "extra" coul=
d
> > grow bigger than "user_extra", which doesn't make sense. Here is an
> > example case:
> >=20
> > Note: Assume "user_lock_limit" is very small.
> > | # of perf_mmap calls |vma->vm_mm->pinned_vm|user->locked_vm|
> > | 0                    | 0                   | 0             |
> > | 1                    | user_extra          | user_extra    |
> > | 2                    | 3 * user_extra      | 2 * user_extra|
> > | 3                    | 6 * user_extra      | 3 * user_extra|
> > | 4                    | 10 * user_extra     | 4 * user_extra|
> >=20
> > Fix this by maintaining proper user_extra and extra.
> >=20
> > Reported-by: Hechao Li <hechaol@fb.com>
> > Cc: Jie Meng <jmeng@fb.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Song Liu <songliubraving@fb.com>
>=20
> Could you please share your feedbacks/comments on this one?
>=20
> Thanks,
> Song

The change looks good to me. Thanks, Song.

Reviewed-By: Hechao Li <hechaol@fb.com>

Hechao
