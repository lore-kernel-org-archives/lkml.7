Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D6BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D0A20851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nvB9b12C";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="haQ1ZLD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfCGXsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 18:48:11 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60252 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726172AbfCGXsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 18:48:10 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x27NZ852017386;
        Thu, 7 Mar 2019 15:47:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=0GgDR47nCstH9IqPrpbEFIxvdNOiUDqLAJoF4HvXYaA=;
 b=nvB9b12CkPMcQ85yWBTKgfFIFFjSrc1Z3/5Zxtzz8lLZltqX4BFlwTqjXMC+DKuIZOj3
 WjOkdHqj8IsYl4mWMk5lR8z1LSBQUdR3FAC46eqrvfcGCu75CazOVIORRV7zox1WS76c
 rck1YY1qjxCqWu3PrLkwNgf/VVPUA41HYXk= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r3bw2r9b4-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 07 Mar 2019 15:47:31 -0800
Received: from frc-hub01.TheFacebook.com (2620:10d:c021:18::171) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 7 Mar 2019 15:47:19 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 7 Mar 2019 15:47:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GgDR47nCstH9IqPrpbEFIxvdNOiUDqLAJoF4HvXYaA=;
 b=haQ1ZLD/Nlb9JL9qgLERLq/BVNhzB8Eaz+IHqV3/Z09O+HZFKUlBSR0UPWwjPvuzMz0x2Z5LWD0BfBfsIBg/X5kozIirrttLRdcrHzRdlhnVV796n5x+SqReOYVacARc5cq6E+4uT6bjgrL3NCEM6a3IqKleABoX6PgnZbAYvAs=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1376.namprd15.prod.outlook.com (10.173.234.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Thu, 7 Mar 2019 23:47:02 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1665.021; Thu, 7 Mar 2019
 23:47:02 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Stanislav Fomichev <sdf@fomichev.me>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Kernel Team" <Kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v7 perf,bpf 11/15] perf: add -lopcodes to feature-libbfd
Thread-Topic: [PATCH v7 perf,bpf 11/15] perf: add -lopcodes to feature-libbfd
Thread-Index: AQHU1Q95Afw72a5BokiECT48mwt8tKYA0EWAgAAFuoA=
Date:   Thu, 7 Mar 2019 23:47:02 +0000
Message-ID: <2D05DAB2-F16D-4310-9497-BC2C7CEF5B61@fb.com>
References: <20190307175810.249857-1-songliubraving@fb.com>
 <20190307175810.249857-12-songliubraving@fb.com>
 <20190307232631.GA5481@mini-arch.hsd1.ca.comcast.net>
In-Reply-To: <20190307232631.GA5481@mini-arch.hsd1.ca.comcast.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::3:415b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 586af9cd-9c61-421a-c7b3-08d6a3573264
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1376;
x-ms-traffictypediagnostic: MWHPR15MB1376:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1376;20:VdFYXUbDBvOIVImLH92NZ7EjrUKhmKP7d9uhc4oI8xYkpJErusxUZFo45CkSg2XyiQrh9i+BppZk4v29YBnNw2leA3uI7+N3dvyro06Ej06JbFv6564MfFBWRlRiZSzlwd5Wi/bF1BX8mvFLKlRIi+xFilR2D1Yu2PRX0I100uI=
x-microsoft-antispam-prvs: <MWHPR15MB137663203242A3D6B0128F8EB34C0@MWHPR15MB1376.namprd15.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(136003)(39860400002)(189003)(199004)(81166006)(476003)(14454004)(57306001)(46003)(2906002)(2616005)(4326008)(11346002)(82746002)(7736002)(81156014)(446003)(53936002)(305945005)(8676002)(14444005)(256004)(478600001)(97736004)(25786009)(6916009)(6512007)(7416002)(8936002)(36756003)(186003)(71200400001)(71190400001)(6436002)(50226002)(68736007)(6486002)(99286004)(53546011)(5660300002)(102836004)(316002)(229853002)(83716004)(54906003)(76176011)(6506007)(6116002)(486006)(6246003)(86362001)(33656002)(105586002)(106356001)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1376;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 54Y4UpRyK3WYQwBYJ+mex8lcilxoLdsWhvKz8QcDzI97Cy66hcU9qPexMnp1MXlkPhoAygLCZo+xjjrrtg67oXrnaMsnUrgpieTCsNhKEcz1pN44u80XmVDlxpKIWpj3mWMA2IhjrzQ27FU68+P6qODqtCs6/KtilTrsSMy8hE9XD/ftMRRKNfAyrH34rYRMIawqBecEk1w/SIHWOt3Al01oXyYB+D4rVK9HAphzlrizhb9OjbBV/pgVkIYch0IMhvFQ92Ys/HeidALHS+5S0Qzr3eakHmMfOjB7YTNpug+Y5mnAOACO0vBt7RyI0nbXb0OOogu+trdQXKUpLD7gQ6ejPHTGc4gP2NYEItO3p6+fARkGiXQQPLYirMUyLQ0mwWT4VX0+22GpgKqxG+EypobK8YvPHKXc8bOPdutf/FI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <37D2E46342A8DC4BA0AA71AA6BB18281@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 586af9cd-9c61-421a-c7b3-08d6a3573264
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 23:47:02.0510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1376
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-07_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 7, 2019, at 3:26 PM, Stanislav Fomichev <sdf@fomichev.me> wrote:
>=20
> On 03/07, Song Liu wrote:
>> Both libbfd and libopcodes are distributed with binutil-dev/devel. When
>> libbfd presents, it is OK to assume libopcodes also presents. This has
>> been a safe assumption for bpftool.
>>=20
>> This patch adds -lopcodes to perf/Makefile.config. libopcodes will be
>> used in the next commit for bpf annotation.
>>=20
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> tools/perf/Makefile.config | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
>> index b441c88cafa1..e0bafbc273af 100644
>> --- a/tools/perf/Makefile.config
>> +++ b/tools/perf/Makefile.config
>> @@ -701,7 +701,7 @@ else
>> endif
>>=20
>> ifeq ($(feature-libbfd), 1)
>> -  EXTLIBS +=3D -lbfd
>> +  EXTLIBS +=3D -lbfd -lopcodes
> I think you need to add -lopcodes to the other feature checks as
> well (to work on the systems which require -liberty and/or -lz for
> libfd):
>=20
> --
>=20
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index b441c88cafa1..3fa2f5d7d54f 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -701,7 +701,7 @@ else
> endif
>=20
> ifeq ($(feature-libbfd), 1)
> -  EXTLIBS +=3D -lbfd
> +  EXTLIBS +=3D -lbfd -lopcodes
> else
>   # we are on a system that requires -liberty and (maybe) -lz
>   # to link against -lbfd; test each case individually here
> @@ -712,10 +712,10 @@ else
>   $(call feature_check,libbfd-liberty-z)
>=20
>   ifeq ($(feature-libbfd-liberty), 1)
> -    EXTLIBS +=3D -lbfd -liberty
> +    EXTLIBS +=3D -lbfd -lopcodes -liberty
>   else
>     ifeq ($(feature-libbfd-liberty-z), 1)
> -      EXTLIBS +=3D -lbfd -liberty -lz
> +      EXTLIBS +=3D -lbfd -lopcodes -liberty -lz
>     endif
>   endif
> endif

Good point! I will fix it in next version.=20

Thanks,
Song

>=20
>> else
>>   # we are on a system that requires -liberty and (maybe) -lz
>>   # to link against -lbfd; test each case individually here
>> --=20
>> 2.17.1

