Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354D3C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC0621994
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DImgnqbm";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="K53at5KC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfGZXpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:45:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40244 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727260AbfGZXpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 19:45:19 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6QNiOYH004626;
        Fri, 26 Jul 2019 16:44:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=IjXJt58OQmKJLLz95X4E2W/q0+CgRirWuNUC5Rg1S8E=;
 b=DImgnqbmWDXS10uyXvlapAn4F2xUhnVj9udKnm0yInjyz5ebVYuS1vBk324uLXXyL2Lh
 FITn6MEnqt2QroyRpOaejYBWFrjd2iP0hp8N8aPkPF+p3ej3ZnuEQE2HqQvGlnoMXVdf
 kTIYUwUrAoTg9Gu7Q3mr8M5YgH1MW0ZPWF4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2u08d18n0t-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Jul 2019 16:44:37 -0700
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 26 Jul 2019 16:44:36 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 26 Jul 2019 16:44:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9OkcIT4qMffsavY2LM01CzgVBYEdgTSAs+m3RPfuhFZfBG92RpEUIcJ0ZAbdbXIBGc88BF/PaMt+8PPUHYGCaIgtZHqLxD1jItFLNksS4m149AurxN4zPeEp5yLKWSxQMpZvpyn9rzZEPvWu/rC6nANJdvGCR8geFRlHHWwuuSDGL3g3oH8QY1nKuEuw5kuxY/zPa5irCdK/grPtHq1NQ6h8NyGpVqSVX5k66fTAyBVnX6/qkt1vB6AaFhsZGUIFoO6D1sjmbqqA9ytmXxXGuveU342y2qIq2AiLEGq/UcVShhm/C1WGWa7vG4r0e3LNlVg9vnsTZRSTP0iOqVCSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjXJt58OQmKJLLz95X4E2W/q0+CgRirWuNUC5Rg1S8E=;
 b=PdjKmudbHmGIlc8Io1SzL5atpgcZGxkAhzbr6qzdf2aPtzu9AEpfU6voaMb9BDxgjMQRDcjnmTiSc2QZUe2qc3eUA0UC9eMBLEX/vScEVogaFyaPEo2Y5YpMvHQcGcKLQTJdilFM4ZFJAtAZaaPUWdV8S2/7Xy1nplfRKKO2830Q1dDCa/chtv49EvhtY5Lasapv2Es1IXsl4ziz/oWJVkxDchZgDKlINOv8IwwctQ+bKxtkZBF9yNeVs65bwj4DlpqNAZSpGUpxq27scecgcVdFbcpbWXPfbOc5klczTacjWyISWZpuFNz3ZYmXgUw7waeiARY+hH93J1D7/EnMkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjXJt58OQmKJLLz95X4E2W/q0+CgRirWuNUC5Rg1S8E=;
 b=K53at5KCSMXlp09Ul9i1Jqo1HErTOck3w4RC5+W16ax6MbadFMmY/LQv7a/jIe8MhGDsnwz7ml29S0tDpoqoik6tFkfyVUDoKB8jjdfSZXfdytG8SkyDTZHoRzdrQSquID17B8km3emTtV7tCJ9W717lm0njHML+Pm8MzFA7bBA=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1439.namprd15.prod.outlook.com (10.173.235.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Fri, 26 Jul 2019 23:44:34 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4066:b41c:4397:27b7]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4066:b41c:4397:27b7%7]) with mapi id 15.20.2094.013; Fri, 26 Jul 2019
 23:44:34 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     lkml <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "srikar@linux.vnet.ibm.com" <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v9 4/4] uprobe: use FOLL_SPLIT_PMD instead of FOLL_SPLIT
Thread-Topic: [PATCH v9 4/4] uprobe: use FOLL_SPLIT_PMD instead of FOLL_SPLIT
Thread-Index: AQHVQ3ZlmP2L+/3PqE2yConlr9Gmr6bdhYSAgAALtYA=
Date:   Fri, 26 Jul 2019 23:44:34 +0000
Message-ID: <509AB060-6E17-40AB-A773-DF3FB8EBDB62@fb.com>
References: <20190726054654.1623433-1-songliubraving@fb.com>
 <20190726054654.1623433-5-songliubraving@fb.com>
 <20190726160239.68f538a79913df343308b473@linux-foundation.org>
In-Reply-To: <20190726160239.68f538a79913df343308b473@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::1:bb04]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44653ef3-abe8-4261-1e21-08d712233693
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1439;
x-ms-traffictypediagnostic: MWHPR15MB1439:
x-microsoft-antispam-prvs: <MWHPR15MB1439DAD43321E07A11114DCFB3C00@MWHPR15MB1439.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01106E96F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(366004)(346002)(39860400002)(54534003)(189003)(199004)(486006)(64756008)(6916009)(7736002)(46003)(6486002)(6436002)(57306001)(256004)(4744005)(14454004)(99286004)(14444005)(66946007)(53546011)(66556008)(68736007)(6246003)(4326008)(25786009)(6116002)(66446008)(71190400001)(71200400001)(76176011)(86362001)(305945005)(81166006)(11346002)(2616005)(8676002)(6506007)(446003)(66476007)(76116006)(229853002)(186003)(33656002)(7416002)(36756003)(81156014)(54906003)(316002)(53936002)(50226002)(476003)(6512007)(102836004)(8936002)(5660300002)(478600001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1439;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BDqgwmsfAz1NdKtsWpSFa+LF9pOrkwnO9c1fzeXYLHyBzLPXBAIHeLNF0bw4SrasOdv42JCpixIwfLf5uA5456b6RQ89BELMviOY/t80YiuOH+g3dKjs3ISJQDSEJMzFJgVKchNai+jnoxV0Oqng5OrmbKmze3JlIsPeRE+bbLU/Iw/zU5BlfNR0gBVFTVU05IeiCzMxpU8S3KxWl51aJ/4CFDKf96OHjqS9yTGd0mTvi7R/Rc1qk2LetpocowjHATsBVWFTLPvGjq7Yxxsv2OjtobbweJxXw9MiT5O673H26pZAauAQpb/VONYolyHMUW4B0En81Fmp9bP1TjdBti82O6yYSKO0QE/0cAfFUm2JMSZkqPkTe0jp6rM2BxMvZAkvLnSvlDqZP2GnVP46uqyV10/U2el8bI7IHu+c4zo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E8B2CEF1332099498FA36A82D993CEB1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 44653ef3-abe8-4261-1e21-08d712233693
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 23:44:34.2599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1439
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-26_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=823 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907260267
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 26, 2019, at 4:02 PM, Andrew Morton <akpm@linux-foundation.org> wr=
ote:
>=20
> On Thu, 25 Jul 2019 22:46:54 -0700 Song Liu <songliubraving@fb.com> wrote=
:
>=20
>> This patches uses newly added FOLL_SPLIT_PMD in uprobe. This enables eas=
y
>> regroup of huge pmd after the uprobe is disabled (in next patch).
>=20
> Confused.  There is no "next patch".

That was the patch 5, which was in earlier versions. I am working on=20
addressing Kirill's feedback for it.=20

Do I need to resubmit 4/4 with modified change log?=20

Thanks,
Song=
