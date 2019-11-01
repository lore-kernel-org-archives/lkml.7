Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E83CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D2E208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="MJuMnWIJ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="fsjEuzKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbfKAPzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 11:55:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63816 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727123AbfKAPzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 11:55:12 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xA1FC9Vs008674;
        Fri, 1 Nov 2019 08:55:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=b1Ut5JeF+VjUGuO0wgupuI+eNPRftFhH4GDFOfs7xAA=;
 b=MJuMnWIJckfprYoGGaXlVkiVTEFPPJQtxN8LlQZJX6glBPGRbJQxTdIQVNBGWXYbAqw2
 mnLzAx8pGZkH1Hd4vXcjdItEfzGw8jtUHEgao0L4RTj9U9K9bj/jMHzQlcBEJ2NHvBc5
 gFaN7rWUPLC6Y0um3y6iRUdwgT9T5S1vRa4= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2w0c4v38fa-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 01 Nov 2019 08:55:07 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 1 Nov 2019 08:55:03 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 1 Nov 2019 08:55:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwMhYra336esGJwjRjmGyd+H9Rdcfj0b7vxtintA+wFX8IO9e6BXmVOhsoiwp+VP4n5LXAblwue+2t6f4UilmeUz1osBvzKxphslGUMb+4i6YN+joL/J249dizXo8e0QVuOdU0r8eLjPkxQv0Ayz5WQqhcdduHEbA3J4MW8WuQPriWEF1wCoUZD0MLiSNzGWUvYliJ3pXXRMW14akXlDGm/7RIi7iU5GJFRCjjyWVFBRI6qtoDrOGCa5yM5FUSMNSFsK5v39jUq4F2YicVOpIdSjqSyFpH2Binf4Wmm6uHARIY4mYlJo1B/M+ETELKB5nsaLBLdl0z76pc3orjeFow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1Ut5JeF+VjUGuO0wgupuI+eNPRftFhH4GDFOfs7xAA=;
 b=DH6wAnC3Mp+KNCCsRFHVjG7FrmDS0fZaBTvEdQN0WGHWPyBDMKuZq7qhBmhG//6CNeN3o9G15C0I7GEJKGKSeYWo3UyUdHLVGiApYzRCNidVfU6kYOytHYJSF0XryDOGIYZP2ORiM8S2TLxbv/jSW9b3sxXFfFIbwhdeY53mx90+MjBhdYZ5DtknCHp5gfEBlR+d2OrjBSGcW6Q72T6DBRh6bisB/YLeWFT/SH6sVVzYjyF2LlZwjRCbuXc18DIpKuP6mLBEmupoDpYPLuOCuDH7LeZ/EylpjFyPNDpBovRKZQg5RAy2OZAo26+/6y/Zh34kbWVjNiDZNf/WB2QFag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1Ut5JeF+VjUGuO0wgupuI+eNPRftFhH4GDFOfs7xAA=;
 b=fsjEuzKgiXEBdBa+Bq2A3h35A+nlmWHpg2xaslCbpgMns2Q/6BrX9XcRvVYjYsWGgpGKLUhmsW+eVNJx7kWwHZbP9prNYjKzBJ1LnVIa48dkYr/6x7j9iodCSZe7k/QCUp9IRkLCwwA/DTesDnBWBPo6gLrIJXgxbdbkW8WW/Z4=
Received: from SN6PR15MB2446.namprd15.prod.outlook.com (52.135.65.158) by
 SN6PR15MB2463.namprd15.prod.outlook.com (52.135.66.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Fri, 1 Nov 2019 15:55:02 +0000
Received: from SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::5d9c:c9a8:a074:f902]) by SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::5d9c:c9a8:a074:f902%7]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 15:55:02 +0000
From:   Chris Mason <clm@fb.com>
To:     Steve Grubb <sgrubb@redhat.com>
CC:     "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Dave Jones <davej@codemonkey.org.uk>,
        Kyle McMartin <jkkm@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] audit: set context->dummy even when audit is off
Thread-Topic: [PATCH] audit: set context->dummy even when audit is off
Thread-Index: AQHVkAncrhonQVVxy06vYxt2pY3gVKd1ZVQAgACm2QCAAFHHAIAAG16A
Date:   Fri, 1 Nov 2019 15:55:02 +0000
Message-ID: <EE4EBB7B-B3CA-4CFC-9B14-843ADDB9F2EA@fb.com>
References: <CAHC9VhTyz7fd+iQaymVXUGFe3ZA5Z_WkJeY_snDYiZ9GP6gCOA@mail.gmail.com>
 <CAHC9VhRwRSGa5JSL0=cXxG-oOg9jUve9OEYyTCqTxzr=aMdGxg@mail.gmail.com>
 <B63048C4-3158-453B-859A-C5574AACDC36@fb.com> <3063279.ZKBa9cPvsK@x2>
In-Reply-To: <3063279.ZKBa9cPvsK@x2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.13r5655)
x-clientproxiedby: BN7PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:408:20::25) To SN6PR15MB2446.namprd15.prod.outlook.com
 (2603:10b6:805:24::30)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:480::5594]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8c78441-4227-491f-76e0-08d75ee3daff
x-ms-traffictypediagnostic: SN6PR15MB2463:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR15MB2463B2C54DBD4D6E974196B7D3620@SN6PR15MB2463.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(39860400002)(396003)(366004)(346002)(189003)(199004)(7736002)(5660300002)(8676002)(8936002)(2906002)(46003)(2616005)(446003)(476003)(11346002)(6512007)(305945005)(256004)(81156014)(64756008)(66476007)(486006)(66446008)(81166006)(66556008)(386003)(186003)(6506007)(53546011)(102836004)(6116002)(6916009)(52116002)(76176011)(50226002)(66946007)(316002)(6246003)(14454004)(71190400001)(6436002)(36756003)(25786009)(478600001)(33656002)(54906003)(4326008)(99286004)(71200400001)(6486002)(86362001)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR15MB2463;H:SN6PR15MB2446.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T0kOr1XP8OlxAnOva0zpvB+6rnQkKof5JlS2thiuRE782C4JUwafGXY8csDBScAsnXZDPjJQ09FRW4s4nniD51vxa/s9sbxH6UMAWHvTUGHPXGQzF6jGDQ6CE/soUdFi/YJ7DoHWoAm488sGl7AQ/hNXffkU9PH9ut2Do05sWyaeibvE6b3nXEeN+2hHPyrGyBQpxoLTQAqT3sAomBffD5YF1BPm+4TKfLEv7zIDXzCZDNseVc9mkxyyKK+OgGUasbfZuk//h0lYtmjV1j/FUfk9LTEgmUZKjK5MKGWQpXDvIT1k4l+bulU8QxVNATY5rHrBbuaWjSmjAMMLDXjGedzFFIZiuTCXS1jz3oKDFrkeVIyVUQOypxndcFfA3GiLzaIaV2pslVBYT067AcBs91cDuymkjyL98AW5pcddBTnySnYT5j7Q0SemK1ERwJWx
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c78441-4227-491f-76e0-08d75ee3daff
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 15:55:02.2725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hxU1jac83L3MTeqqHAz5kv6KfsBByAFdyyU2Pax5AkudAk3wdevIOUMGNzrwN1hd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2463
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-31_08:2019-10-30,2019-10-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1011 mlxscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911010024
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Nov 2019, at 10:16, Steve Grubb wrote:

> On Friday, November 1, 2019 9:24:17 AM EDT Chris Mason wrote:
>> On 31 Oct 2019, at 19:27, Paul Moore wrote:
>>> On Thu, Oct 31, 2019 at 12:40 PM Chris Mason <clm@fb.com> wrote:
>>> [ ... ]
>>> Hi Chris,
>>>
>>> This is a rather hasty email as I'm at a conference right now, but I
>>> wanted to convey that I'm not opposed to making sure that the NTP
>>> records obey the audit configuration (that was the original intent
>>> after all), I think it is just that we are all a little confused as=20
>>> to
>>> why you are seeing the NTP records *and*only* the NTP records.
>>
>> This part is harder to nail down because there's a window during boot
>> where journald has enabled audit but chef hasn't yet run in and=20
>> turned
>> it off, so we get a lot of logs early and then mostly ntp after that.
>
> This is the root of the problem. Journald should never turn on audit=20
> since it
> has no idea if auditd even has rules to load. What if the end user=20
> does not
> want auditing? By blindly enabling audit without knowing if its=20
> wanted, it
> causes a system performance hit even with no rules loaded. It would be=20
> best
> if journald leaves audit alone. If it wants to listen on the multicast
> socket, so be it. It should just listen and not try to alter the=20
> system.
>
> Back to ntp, it sounds like the ntp record needs to check for=20
> audit_enabled
> rather than the dummy context.

I'm not against sprinkling more audit_enabled checks, but we'd have to=20
change audit_inode() and a bunch of the other callers of=20
audit_dummy_context() as well.

-chris
