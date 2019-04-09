Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F77DC282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 23:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F7C20857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 23:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ETjcaM0q";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="D3wlItl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfDIXR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 19:17:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56354 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726573AbfDIXR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 19:17:58 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x39N99iI020140;
        Tue, 9 Apr 2019 16:17:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=zEPoCk6fvK2qBKdnj+43HTK6N4kqFuYPjeYXdZlXqV8=;
 b=ETjcaM0qVVJUD7WCqSBMDG8ASbbrU3ewTkdovJdpNkOyrLpI79/8r1wZNtUV55uZhS47
 QpoNcDCR39yQPntFduIjt2WWfoAoO95IwjHcNa9XkQLlJ6dHjILVEtJyRQ08EeS9QOcM
 4fahen6f168oQ4fbsnxlxQzBttrae8hZvJg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rrynxscat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 09 Apr 2019 16:17:34 -0700
Received: from frc-mbx03.TheFacebook.com (2620:10d:c0a1:f82::27) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 9 Apr 2019 16:17:33 -0700
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-mbx03.TheFacebook.com (2620:10d:c0a1:f82::27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 9 Apr 2019 16:17:33 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 9 Apr 2019 16:17:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEPoCk6fvK2qBKdnj+43HTK6N4kqFuYPjeYXdZlXqV8=;
 b=D3wlItl7/Cpehcm1GjQ0dTHXV6CtIDMptUu+Y7C/XkYWzByJeIrh+WrJ9v3aGcCpG1TfRgxI2Ih0zlrZHl1RC1sGpZLvV8cGsIF9O/3+zRckKlr54cLuuNP8VqPQ4xf/OzbBbxnod+fy+jN/TE8pHszaIIL37f+/jodggB2Hw+8=
Received: from CY4PR15MB1366.namprd15.prod.outlook.com (10.172.157.148) by
 CY4PR15MB1559.namprd15.prod.outlook.com (10.172.161.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.19; Tue, 9 Apr 2019 23:17:31 +0000
Received: from CY4PR15MB1366.namprd15.prod.outlook.com
 ([fe80::cdcb:6db:7ea8:1477]) by CY4PR15MB1366.namprd15.prod.outlook.com
 ([fe80::cdcb:6db:7ea8:1477%4]) with mapi id 15.20.1771.016; Tue, 9 Apr 2019
 23:17:31 +0000
From:   Andrey Ignatov <rdna@fb.com>
To:     Kees Cook <keescook@chromium.org>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Roman Gushchin <guro@fb.com>, Kernel Team <Kernel-team@fb.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v3 bpf-next 00/21] bpf: Sysctl hook
Thread-Topic: [PATCH v3 bpf-next 00/21] bpf: Sysctl hook
Thread-Index: AQHU6+bolDbIkvoyBUOpRFUnl6HwHKYvWAQAgAAFWQCABLObAIAAbAeA
Date:   Tue, 9 Apr 2019 23:17:31 +0000
Message-ID: <20190409231729.GB59615@rdna-mbp>
References: <cover.1554485409.git.rdna@fb.com>
 <CAGXu5jJGC1kB-0e3DimBSprcgEBnWRB=i287g-9T5a-RidFqBg@mail.gmail.com>
 <20190406170257.qlptcrfth2rb3rxo@ast-mbp.dhcp.thefacebook.com>
 <CAGXu5jJTCjE6FiqPgnSZbp1rzNs35RV-bXXg=+Nu5bO7v1Ac0g@mail.gmail.com>
In-Reply-To: <CAGXu5jJTCjE6FiqPgnSZbp1rzNs35RV-bXXg=+Nu5bO7v1Ac0g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:300:16::30) To CY4PR15MB1366.namprd15.prod.outlook.com
 (2603:10b6:903:f7::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:6328]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2ff97a6-eb93-4871-4a0d-08d6bd418a6f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:CY4PR15MB1559;
x-ms-traffictypediagnostic: CY4PR15MB1559:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <CY4PR15MB1559558981A4FD561305B728A82D0@CY4PR15MB1559.namprd15.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(7916004)(396003)(136003)(39860400002)(346002)(376002)(366004)(199004)(189003)(1076003)(256004)(2906002)(102836004)(14454004)(5660300002)(93886005)(106356001)(966005)(6916009)(316002)(25786009)(71200400001)(5024004)(86362001)(6512007)(105586002)(446003)(7736002)(478600001)(71190400001)(54906003)(305945005)(4326008)(9686003)(6306002)(53936002)(46003)(6436002)(33656002)(76176011)(486006)(386003)(6246003)(33716001)(6506007)(186003)(11346002)(97736004)(14444005)(6486002)(53546011)(81156014)(8676002)(68736007)(81166006)(476003)(7416002)(99286004)(8936002)(229853002)(52116002)(6116002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1559;H:CY4PR15MB1366.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jJNtYWRkbnr4rus5icT4YDrfkA9WBdpC/mGrVEOV2IDQ1ZjjrLf5H4unYvQwDQcY/musom15g3toWJEIiPRJPkfqPNLc9XHMqf4SEU1WBlgi+ce3EAfB9G/KRWcVtmZcTmxUifgG8WHV0+3DhpN+jjAidT9YXBIxR6wrQ8897SKWJu70Y2ld9r0X14fPbcBRwzpL40AS43+/QAc5ZdYcSs+xWHyW+uK9iJGhoR4ORrqJzIiL1ZFXaMpkHYbH3okmU4u5C1v9iNtU3Cjp9h0c9+C5UeMp0sU84AGYPCHvYL1WNH8INVqyhRzW3Y5c0ZSuqp9FUxYJfsZQrWZQ1gULsnQy0I0KltDny1qPvCOuKCYy0rbnggFUDt4PKMcrH8MbUB1MRvaSSNK2lZ2ABW5E0sRSyqeEmM2CK2eH+JvX+ik=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34253F30DA292D42837CF1622BB19B0F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ff97a6-eb93-4871-4a0d-08d6bd418a6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 23:17:31.6840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1559
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-09_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

S2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+IFtUdWUsIDIwMTktMDQtMDkgMDk6NTEg
LTA3MDBdOg0KPiBPbiBTYXQsIEFwciA2LCAyMDE5IGF0IDEwOjAzIEFNIEFsZXhlaSBTdGFyb3Zv
aXRvdg0KPiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBP
biBTYXQsIEFwciAwNiwgMjAxOSBhdCAwOTo0Mzo1MEFNIC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6
DQo+ID4gPiBPbiBGcmksIEFwciA1LCAyMDE5IGF0IDEyOjM2IFBNIEFuZHJleSBJZ25hdG92IDxy
ZG5hQGZiLmNvbT4gd3JvdGU6DQo+ID4gPiBDYW4gdGhlIEJQRiBiZSByZW1vdmVkIChvciByYXRo
ZXIsDQo+ID4gPiB3aGF0J3MgdGhlIGxpZmV0aW1lIG9mIHN1Y2ggQlBGPykNCj4gPg0KPiA+IHNh
bWUgYXMgYWxsIG90aGVyIGNncm91cC1icGYgaG9va3MuDQo+ID4gRG8geW91IGhhdmUgYSBzcGVj
aWZpYyBjb25jZXJuIG9yIGp1c3QgYXNraW5nIGhvdyBsaWZlIHRpbWUgb2YgcHJvZ3JhbXMNCj4g
PiBpcyBtYW5hZ2VkPw0KPiA+IEhpZ2ggbGV2ZWwgZGVzY3JpcHRpb24gb2YgbGlmZXRpbWUgaXMg
aGVyZToNCj4gPiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0
cHMtM0FfX2ZhY2Vib29rbWljcm9zaXRlcy5naXRodWIuaW9fYnBmX2Jsb2dfMjAxOF8wOF8zMV9v
YmplY3QtMkRsaWZldGltZS5odG1sJmQ9RHdJQmFRJmM9NVZEMFJUdE5sVGgzeWNkNDFiM01VdyZy
PTNqQW9rcEh5R3VDdUo4MzRqLXR0dFEmbT1aSko0UU1YbmtzTDFiNFZQb0JNME5KMGk2T1d5c0dj
Mk9tMjZwY29KcHhBJnM9NmRJWjc4OGhPem9EV1ZpZjVYUS05TXFmOWlqa285TzdUT1dBckx6Ymx4
VSZlPQ0KPiANCj4gSSdtIG1vc3RseSBjdXJpb3VzIGFib3V0IHRoZSBhY2Nlc3MgY29udHJvbCBz
dGFja2luZy4gaS5lLiBjYW4NCj4gaW4tY29udGFpbmVyIHJvb3QgYWRkIG5ldyBlQlBGIHRvIGl0
cyBvd24gY2dyb3VwLCBhbmQgaWYgc28sIGNhbiBpdA0KPiB1bmRvIHRoZSByZXN0cmljdGlvbnMg
YWxyZWFkeSBwcmVzZW50PyAoSSBhc3N1bWUgaXQgY2FuJ3QsIGJ1dCBmaWd1cmVkDQo+IEknZCBh
c2suLi4pDQoNClNpbmNlIEkgYW5zd2VyZWQgc2ltaWxhciBxdWVzdGlvbiBmcm9tIEphbm4gYmVs
b3csIEknbGwgYW5zd2VyIGl0IGhlcmUNCmFzIHdlbGwgKGV2ZW4gdGhvdWdoIGl0IHdhcyBhZGRy
ZXNzZWQgdG8gQWxleGVpKS4NCg0KU3RhY2tpbmcgY2FuIGJlIGNvbnRyb2xsZWQgYnkgYXR0YWNo
IGZsYWdzIChOT05FLCBCUEZfRl9BTExPV19PVkVSUklERSwNCkJQRl9GX0FMTE9XX01VTFRJKSBk
ZXNjcmliZWQgaW4gaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oLg0KDQpCYXNpY2FsbHkgaWYgb25l
IGF0dGFjaGVzIGEgcHJvZ3JhbSB0byBhIGNncm91cCB3aXRoDQpgYnBmX2F0dHIuYXR0YWNoX2Zs
YWdzID0gMGAgKDAgaXMgIk5PTkUiKSwgdGhlbiBub2JvZHkgY2FuIG92ZXJyaWRlIGl0DQpieSB0
aGVpciBvd24gcHJvZ3JhbXMgb2Ygc2FtZSB0eXBlIGluIGFueSBzdWItY2dyb3VwLiBJdCBjYW4g
YmUgaGFyZGVuZWQNCmZ1cnRoZXIgYnkgY2dyb3VwIG5hbWVzcGFjZSBzbyB0aGF0IGluLWNvbnRh
aW5lciByb290IGRvZXNuJ3QgZXZlbiBzZWUNCnBhcnQgb2YgY2dyb3VwIGhpZXJhcmNoeSB3aGVy
ZSBjZ3JvdXAtYnBmIHByb2dyYW0gaXMgYXR0YWNoZWQgdG8gd2l0aA0KYXR0YWNoIGZsYWdzIE5P
TkUuDQoNCg0KLS0gDQpBbmRyZXkgSWduYXRvdg0K
