Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA56CA9ED3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8572080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qYE/tD59";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YOd0PWje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbfKEAjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 19:39:31 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61562 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729607AbfKEAja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 19:39:30 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xA50bKGk002561;
        Mon, 4 Nov 2019 16:39:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=C0t6QsbAdivta8eG8TEIVBUAXPYDxDCLyoSwV0RVde4=;
 b=qYE/tD59EgI2eA3A4SQvkcRilIvFkbr3Hr4sulGrcxTE+Pn6JhCqZHV/moF/ga58W/6e
 wQ+04Q+U+EyEjpWrnw9VMyxtNftBZGIPi8sjYsZXr/Ja37RO82oVWNfR2xlbIQf9DIru
 Lh0MSqMUiPyPJ+Kg4pXUrwGruoN5q6ZWgA4= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2w15fjupyh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 16:39:25 -0800
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 4 Nov 2019 16:39:23 -0800
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 4 Nov 2019 16:39:23 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 4 Nov 2019 16:39:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dv9hgZjuGZLcWghDTu0v4/yPz5OqQJ1pmTOeLsW62B8pWhsHh2PFXRp5wGoLgngd7iHGD/t6t6BsPCM0sR4gsIpYM0mfftyLBsTcMYF3Ba+6XQK/rOsN1Vz6URZ7zHUIHEeWjDvXPAy+msSMEU9qDbpMeOwPyDRafEvQTELoXgrdt5MmGnF6ZiHNBgcZn53iQBM3FVfl9stomflod7dHoYORFnZe1MdYqmt3AXyo5xRDQKU9BdUThoPbTZC+cTKiAmuyFm1BfMSzSy8Q4l5PX2Dy9feOhAX4NgfLh9X0m+FdtTJXZPixMGwJCjnjATpvWiuwVwpHyg0+rQvy6adobg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0t6QsbAdivta8eG8TEIVBUAXPYDxDCLyoSwV0RVde4=;
 b=c0RRHy3nJK+Gmq+nvtp/edCQWOYQVJ8fcyYAkwFSGU1zcbKFbEJWm3YdIPKd8TGjtkXxS9yY3MVBXtasuf+5dL0ikWLwceZglsko4BsZreskCPdOfpqaDHjCJtVQic0zUaX54TkwdopIDRqsGwy0XGT2NXxGZfjRRfJPpBUBOcZYgUHj3AQMS4vT2pQgZw77W6hr7aomLKSZZgJmZwdoH+qq8zfDPb2xWq6ycEfCtFMlrK5ftuI3p9PaemfC3MmTmG/fpCa+42UbEkUH3K0Ue/fCEKsAzc/YvWB5Uh5e14yC5zB6CoG8d1YFkHoffKS6RKuqGQUAheDZM1/Xw8VCeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0t6QsbAdivta8eG8TEIVBUAXPYDxDCLyoSwV0RVde4=;
 b=YOd0PWjejOUlXTJxd4EzHkc/wVnHOq1Cs9HYpCYBgwdDHnmKN79I3LO23c6f0XuLjsIWwFup4pIKTsiaB8TiAsdd8uEn8Oj/6JImxD4ge9JGdP1GLd1aHDS6JhaGM51qAKpYY9cExaLVJ114soNzerbL8nb32hhmpBgRzVG1DZk=
Received: from SN6PR15MB2446.namprd15.prod.outlook.com (52.135.65.158) by
 SN6PR15MB2494.namprd15.prod.outlook.com (52.135.66.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 00:39:21 +0000
Received: from SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::5d9c:c9a8:a074:f902]) by SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::5d9c:c9a8:a074:f902%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 00:39:21 +0000
From:   Chris Mason <clm@fb.com>
To:     Paul Moore <paul@paul-moore.com>
CC:     Eric Paris <eparis@redhat.com>,
        Dave Jones <davej@codemonkey.org.uk>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Kyle McMartin <jkkm@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] audit: set context->dummy even when audit is off
Thread-Topic: [PATCH] audit: set context->dummy even when audit is off
Thread-Index: AQHVkAncrhonQVVxy06vYxt2pY3gVKd1ZVQAgACm2QCABbABgIAABqgA
Date:   Tue, 5 Nov 2019 00:39:21 +0000
Message-ID: <5E08422A-BFE2-4515-A804-3DB42B7D8550@fb.com>
References: <CAHC9VhTyz7fd+iQaymVXUGFe3ZA5Z_WkJeY_snDYiZ9GP6gCOA@mail.gmail.com>
 <20191031163931.1102669-1-clm@fb.com>
 <CAHC9VhRwRSGa5JSL0=cXxG-oOg9jUve9OEYyTCqTxzr=aMdGxg@mail.gmail.com>
 <B63048C4-3158-453B-859A-C5574AACDC36@fb.com>
 <CAHC9VhR92Ade8_d1UnTy4_hJDxmwZPU31eubnrq=ejPBjkTS4w@mail.gmail.com>
In-Reply-To: <CAHC9VhR92Ade8_d1UnTy4_hJDxmwZPU31eubnrq=ejPBjkTS4w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.13r5655)
x-clientproxiedby: BL0PR02CA0090.namprd02.prod.outlook.com
 (2603:10b6:208:51::31) To SN6PR15MB2446.namprd15.prod.outlook.com
 (2603:10b6:805:24::30)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:480::5e73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83541d98-df51-4afb-3f92-08d76188997c
x-ms-traffictypediagnostic: SN6PR15MB2494:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR15MB2494D10E05519E3534A136CED37E0@SN6PR15MB2494.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(366004)(396003)(376002)(346002)(199004)(189003)(51914003)(14454004)(33656002)(66946007)(6436002)(66446008)(64756008)(7736002)(2906002)(5660300002)(478600001)(25786009)(305945005)(54906003)(86362001)(316002)(81166006)(186003)(476003)(8676002)(81156014)(11346002)(486006)(36756003)(6116002)(50226002)(8936002)(446003)(76176011)(102836004)(52116002)(99286004)(6506007)(6916009)(2616005)(6512007)(4326008)(229853002)(71200400001)(71190400001)(66476007)(386003)(256004)(14444005)(66556008)(46003)(53546011)(6246003)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR15MB2494;H:SN6PR15MB2446.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XGCMiCYhSIdeal55YyRSzMoEQyBB/06Uvw8qAVLa5S9lKskHZaXglS4ru0xUcYR4gNhO0IUD4ofzyVClLeatBifrcX58agFe6TrKuvmQL8/L/j2Pg/ihFKqjh7Wenio5fkevmB+rw59VN9/ztdHPkFCkIyANa8/7NbpwRVKT1i9VT0VrQ2m+kd22k/2/N9GbGUD9njj/085R/WbbEJCcc22EHx8WIMT/c89rdrHZhwubTwDKjHLaoDZdJDtvYTg53Gq1Ugtf/SUzQBvceVZp/w0ZV/CDvoEIyVzELxBwpQQMHx8SftnJMfKxHA93equJOWOJd1y0pG7z/MmASjRt1TfYuycXxFIx2P8c8IMnDZA6v29IFZsfHL4AMcHkwQy3jhZOKlApSPuXEBdao9TkHOzlDDHPilNdaYRlMOW6244EbnhCjxBFlh5MNHQZhlTq
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 83541d98-df51-4afb-3f92-08d76188997c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 00:39:21.6346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q2ZXB4/R/Ki2O5Tu9LVd2wA6f5G6o7pvrP0PgKCvNorBOiuQl0RL0/ZPlaC6d1QI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2494
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-04_12:2019-11-04,2019-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 spamscore=0 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911050002
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Nov 2019, at 19:15, Paul Moore wrote:

> On Fri, Nov 1, 2019 at 9:24 AM Chris Mason <clm@fb.com> wrote:
>> On 31 Oct 2019, at 19:27, Paul Moore wrote:
>>> It's been a while, but I thought we suggested Dave try running
>>> 'auditctl -a never,task' to see if that would solve his problem and=20
>>> I
>>> believe his answer was no, which confused me a bit as the
>>> audit_filter_task() call in audit_alloc() should see that rule and
>>> return a state of AUDIT_DISABLED which not only prevents=20
>>> audit_alloc()
>>> from allocating an audit_context (and remember if the audit_context=20
>>> is
>>> NULL then audit_dummy_context() returns true), but it also clears=20
>>> the
>>> TIF_SYSCALL_AUDIT flag (which I'm guessing you also want).
>>
>> Thanks for the reminder on this part, I meant to test it.  Yes,=20
>> auditctl
>> -a never,task does stop the messages, even without my patch applied.
>
> I'm glad to hear that worked, I was going to be *very* confused if you
> came back and said you were still seeing NTP records.
>
> I would suggest that regardless of what happens with audit_enabled you
> likely want to keep this audit rule as part of your boot
> configuration, not only does it squelch the audit records, but it
> should improve performance as well (at the cost of no syscall
> auditing).  A number of Linux distros have this as their default at
> boot.
>

Definitely, we'll be testing auditctl -a never,task internally.  Before=20
we went down that path I wanted to fully understand what was going on,=20
but I think all the big questions have been answered at this point.

I'm happy to try variations on my patch, but if you want to include it,=20
please do remember that I've really only tested it with auditing off.

-chris
