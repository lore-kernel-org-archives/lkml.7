Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37760C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2AEA2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jVYkJbg1";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Zb2EOwHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbfG3T3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:29:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20942 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727169AbfG3T3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:29:19 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6UJSaIj030764;
        Tue, 30 Jul 2019 12:28:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=iAQeK4vhpOhEmfSO/1buu81VKec6Baim9m4h+DFtpRI=;
 b=jVYkJbg13+R3yR92Ccibv9lhmiYewrV4YCLMuxhvx6V3RhCiOD66q2VV5wMcPvPtJvOT
 Ug+4xqhVyxguh8WJvf5XCJ4Ne2JxiKX5A6s5PkmXyrfOSUTrrm9V8VZJgbej0R0qhE39
 3MzhOReghOF+qP7hK16Bom8ovkPvWsOLOJE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2u2uhtg43e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 30 Jul 2019 12:28:36 -0700
Received: from ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 30 Jul 2019 12:28:33 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 30 Jul 2019 12:28:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vg1A/8C9YHt8QNQN80ugP/MfFu7QZxDh4OjGcMVRbnra2694KFwJkUSEcrAOiBT/Gltwq4z48DsAvJhyX56AgvvgXoDkbJCf5TKUYUTDmpZN5GampGD589V3ntO+PB63OIk3nc0LVI+oi8Y2n8PrNt8gk0405VMF01+lxR4fR0CTD4Hxx6A+QX7tBG+PkXhge1MhroJC38RyI4DKoMVNhzFROc7zPcoI+F7LvUWX09nrBLL3jvw1cQVQrw5kJnBAzXRZE8Ih1fdoKo2T89gN7JKVU1Tahz3qGPUZCPBnNzDPaqWfwkglRagjX0wqxhV7UzbWGKyLeWZ0U/FqsRXDvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAQeK4vhpOhEmfSO/1buu81VKec6Baim9m4h+DFtpRI=;
 b=DpYJ5z2ch2O5SB4P1O+lLgcPp77/+Q9gqYetltWeAS8LGcJAzDrunCz6HSoKI2MBds9hTaI8ILRSbUzo+FrXjUTcJ1/i+vTlSclzJHoHzc6aaAM/rJvA2krCRaLjpDcbkfVEjbZ0BLq0FKPRiWxm8gGj/mUaj3HEOjuJ3YKEohYC7/ms6mwS6BRlw3yP+1V3q1clrcAnX0mXbuXWWhAxwl85B6mF343qtVHVyeH7b/UfrzBGrEuCV5+RP9frlf64s3w6AOc48LiCdhrkMAGaaNDu5yAXuV/1bRPrK/4hlnenFcXAgYW/Im7nwQlXHceE0ztVOifaBZFrVtsTTcgc9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAQeK4vhpOhEmfSO/1buu81VKec6Baim9m4h+DFtpRI=;
 b=Zb2EOwHSJ7nB95+KlCEoHkMhKcCwkxwDBDQo+xBHYzkP5Eu7CCIJVT6izYlu1TLE9MJsbrhQ/jz59jjNmUic9LuzqCMqUZeFMY/E7ttvthIWy/ZxjWF8x6QnCDF2KZlrWuViGyuz3Vgtbb4HBS9W39kPUlqk90Z2E58KrG4rIx8=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1344.namprd15.prod.outlook.com (10.175.2.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Tue, 30 Jul 2019 19:28:32 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::d4fc:70c0:79a5:f41b]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::d4fc:70c0:79a5:f41b%2]) with mapi id 15.20.2115.005; Tue, 30 Jul 2019
 19:28:32 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Oleg Nesterov <oleg@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: + uprobe-use-original-page-when-all-uprobes-are-removed.patch
 added to -mm tree
Thread-Topic: + uprobe-use-original-page-when-all-uprobes-are-removed.patch
 added to -mm tree
Thread-Index: AQHVRAZeDd93yJdBykiPoGv83wMqwKbhth4AgAAhFoCAAbe+gIAAAvKA
Date:   Tue, 30 Jul 2019 19:28:32 +0000
Message-ID: <09F0B68C-7E67-4913-8C5D-865717E10016@fb.com>
References: <20190726230333.drvM6x-wz%akpm@linux-foundation.org>
 <20190729150539.GB11349@redhat.com>
 <40C3ABEE-B1D1-445B-9637-A2BD5ED9C316@fb.com>
 <20190730121759.41b4ddf25eb887fafa27fb28@linux-foundation.org>
In-Reply-To: <20190730121759.41b4ddf25eb887fafa27fb28@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::3:5cb8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7534faf6-a338-442d-f864-08d715241bd7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1344;
x-ms-traffictypediagnostic: MWHPR15MB1344:
x-microsoft-antispam-prvs: <MWHPR15MB1344015904F9B6377B9ABCE6B3DC0@MWHPR15MB1344.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(136003)(376002)(366004)(189003)(199004)(7736002)(76176011)(46003)(6506007)(91956017)(81156014)(2616005)(6116002)(11346002)(476003)(446003)(229853002)(66446008)(66556008)(50226002)(6512007)(256004)(6246003)(66946007)(102836004)(33656002)(4744005)(186003)(6486002)(25786009)(14454004)(4326008)(76116006)(486006)(5660300002)(6436002)(53546011)(66476007)(86362001)(316002)(57306001)(36756003)(54906003)(6916009)(71200400001)(71190400001)(64756008)(8936002)(68736007)(8676002)(99286004)(53936002)(478600001)(81166006)(305945005)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1344;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KWTvVjw8hL1DU0Op5VfsFItRI33pN5KoKoNUDCw2CpmHo6e7rpXhv+Ph+NGYBQhZabHNZFkKqdOHF64wLis7gOmMSRI+VjMcXxvOzvvJQT7Bs7LheGbXWtUYvGDs8bYk1t/eicGZKxvCjQJpW9eDeq5n+ra/x6j5pXGQiaF8OmXWDz1cTub3ngO+UeOC3y7hDWWDPGVSesHHrWbOuFsh7s/Kb4DACh5RDbTdNNuj5ybCkYFYNv2eOkcVJ7e4fhi4MaoePO+FohynxXff2P0xxcMq7WM6+lXOB7t4OZr0gDDu9j6r6ibJUGDSDL6cW7fOHplfs1qfCbbt3ZXsyPFHPDtVYhUPGtOrk/VmTYf0l6u95F35D88Y3YjrquX0nppZvAlTTK8JHAtsNcTG/4Y8ZWTkwzz3gHK/V2avgxwx+Q8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4169362104E4D84282E0D17412708F1C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7534faf6-a338-442d-f864-08d715241bd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 19:28:32.4217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1344
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-30_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907300197
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 30, 2019, at 12:17 PM, Andrew Morton <akpm@linux-foundation.org> w=
rote:
>=20
> On Mon, 29 Jul 2019 17:04:05 +0000 Song Liu <songliubraving@fb.com> wrote=
:
>=20
>>> this assumes that __replace_page() can't fail, but it can. I think you
>>> should move this into into __replace_page().
>>=20
>> Good catch! Let me fix it.=20
>>=20
>> Hi Andrew,
>>=20
>> Do you prefer a whole v10 (1/4 to 4/4) or just newer version of this=20
>> one (2/4)?
>=20
> Either is OK.  I guess just a new 2/4 is sufficient, if the difference
> is minor.

I sent v10 last night. Then Oleg found some issue with 3/4 (thanks!) Let
me resend 2/4 (with change in commit log) and 3/4 (with code change).=20

Thanks,
Song=
