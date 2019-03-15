Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20B1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B359121871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nln3hUhR";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Fg5/dsPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfCOTca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 15:32:30 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37358 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726360AbfCOTc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 15:32:29 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x2FJIarq028850;
        Fri, 15 Mar 2019 12:31:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=i4MfscXP0lsV9NCd9pJga9DqwnwEL+0ZLuTPtDgLGXk=;
 b=nln3hUhRAH5t0INOcmWZq3ul+Oip8K9i7EgrPBRFGgwpGr+IW+dyURmmURxcKIajusxi
 A2qhuZBwtE7AXhpR7m6lRioHiY+C+8PE4X1Z5OY2kDWzZLdCND4KzgbJxSKmV38+Jy69
 +WQx42+C+P/Aktal/46OXL0h4MAvLjBarr4= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2r7u1c4whq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 15 Mar 2019 12:31:49 -0700
Received: from prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 15 Mar 2019 12:31:48 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 15 Mar 2019 12:31:47 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 15 Mar 2019 12:31:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4MfscXP0lsV9NCd9pJga9DqwnwEL+0ZLuTPtDgLGXk=;
 b=Fg5/dsPXhri6wEkBHFsWyxvFZaz1XhJV4TIYUUwImRqxmwlqTuorR4uzANELo0H+03B8wjjSCmg8fjEwV1N9eTsSxVbgwkqn7YOyLJyO5/P20/s6yUFHI2Ca2UPMXW1AvoFrwLZnmWLDk58n8kKSHZnwBjXeGYFTdz7GokZp9bA=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1648.namprd15.prod.outlook.com (10.175.139.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Fri, 15 Mar 2019 19:31:45 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f190:6de5:7e3:e065%6]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 19:31:45 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Jiri Olsa" <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        "sdf@fomichev.me" <sdf@fomichev.me>
Subject: Re: [PATCH v9 perf,bpf 09/15] perf, bpf: save btf information as
 headers to perf.data
Thread-Topic: [PATCH v9 perf,bpf 09/15] perf, bpf: save btf information as
 headers to perf.data
Thread-Index: AQHU2JTq1ai9qoaEF0mXPn112Pnh46YIG0yAgAAAkwCAABOYAIAACxUAgAAGdoCABNJSgIAABWUAgAABkAA=
Date:   Fri, 15 Mar 2019 19:31:45 +0000
Message-ID: <6211135B-6A7F-443A-9444-27F61C56A437@fb.com>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190312053051.2690567-10-songliubraving@fb.com>
 <20190312151405.GG4939@kernel.org> <20190312151608.GH4939@kernel.org>
 <61901DA6-47B4-44E0-A0C9-9F2DBD6C34C1@fb.com>
 <20190312170556.GJ4939@kernel.org>
 <97D0A2F1-1F82-4CF0-ACE3-A276784DF7EA@fb.com>
 <20190315190651.GA14938@kernel.org>,<20190315192610.GB14938@kernel.org>
In-Reply-To: <20190315192610.GB14938@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2600:1010:b00c:685f:b9b5:2a03:caa:7d6d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85205208-1f1a-4a51-f359-08d6a97cdc1b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1648;
x-ms-traffictypediagnostic: MWHPR15MB1648:
x-microsoft-antispam-prvs: <MWHPR15MB1648936439C92321EE163CFCB3440@MWHPR15MB1648.namprd15.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(39860400002)(136003)(366004)(189003)(199004)(33656002)(83716004)(53546011)(81156014)(6506007)(478600001)(102836004)(105586002)(186003)(25786009)(14454004)(7416002)(106356001)(4744005)(229853002)(6116002)(71200400001)(71190400001)(82746002)(4326008)(6916009)(256004)(46003)(7736002)(446003)(53936002)(97736004)(305945005)(6512007)(5660300002)(11346002)(486006)(9886003)(476003)(2616005)(68736007)(6436002)(6486002)(99286004)(6246003)(8936002)(36756003)(81166006)(2906002)(8676002)(86362001)(76176011)(316002)(93886005)(54906003)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1648;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iwJQ2Zkz5uxziChaVo2N4JtVe0dOI/1Okj1sw1cKRxhyNgG0wYxxCgtgNHp+ZCaU+TgwemRfeQT+XJGlIOWIAifXZCWpRkwTfvQqlLAi7xkQVcYperl5mxsxLIGSe9cGUEXrQUpdVgh46T1UbdURHR09dg/laFg26HXk8XhPCJcs6KuFvKiudZ5DTxOD4RqxSMkr1xlieSb+6bS4VrGZX/79wztZ4ZVviQ/kxwHxoAtI+g5QKH8yxwXBQJCcrjPk3tAnjmfEvWK+WyognBJwg24Xc7UIMNqX7BorhFnGrGZF5N1eb0LQmmgIWvsSIdYg0sguBK+atCiJiZzAYbmnpjPD8y19tsQ3AOVrs2Gnxezk2UVcL9ALJOUYQ/Uo3ExwKcoX9cjFiqheBjmYZTeZOC5E2WAp9hkFsqw7XDOs9xM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 85205208-1f1a-4a51-f359-08d6a97cdc1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 19:31:45.1350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1648
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-15_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnkgZm9yIHJlcGx5aW5nIGZyb20gdGhlIHBob25lLg0KDQpTZW50IGZyb20gbXkgaVBob25l
DQoNCj4gT24gTWFyIDE1LCAyMDE5LCBhdCAxMjoyNiBQTSwgQXJuYWxkbyBDYXJ2YWxobyBkZSBN
ZWxvIDxhcm5hbGRvLm1lbG9AZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IEVtIEZyaSwgTWFyIDE1
LCAyMDE5IGF0IDA0OjA2OjUxUE0gLTAzMDAsIEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbyBlc2Ny
ZXZldToNCj4+IEFuZCB5ZXMsIHRoZXJlIGFyZSBCUEYgcHJvZ3JhbXMgd2l0aCBCVEYgaW5mb3Jt
YXRpb24gYXNzb2NpYXRlZDoNCj4gDQo+PiBbcm9vdEBxdWFjbyBwZXJmXSMgYnBmdG9vbCBtYXAg
ZHVtcCBwaWRzX2ZpbHRlcmVkDQo+PiBbew0KPj4gICAgICAgICJrZXkiOiAyNTkyLA0KPj4gICAg
ICAgICJ2YWx1ZSI6IHRydWUNCj4+ICAgIH0sew0KPj4gICAgICAgICJrZXkiOiAyMDUxMSwNCj4+
ICAgICAgICAidmFsdWUiOiB0cnVlDQo+PiAgICB9DQo+PiBdDQo+PiBbcm9vdEBxdWFjbyBwZXJm
XSMNCj4gDQo+PiBJLmUuIGJwZnRvb2wgY2FuIGZpbmQgdGhlIEJURiBpbmZvIGFuZCB0aHVzIGlz
IGFibGUgdG8gc2hvdyB0aGUNCj4+ICdwaWRzX2ZpbHRlcmVkJyBtYXAga2V5cyBhbmQgdmFsdWVz
IHByZXR0eSBwcmludGVkLCBub3QganVzdCBhcyBoZXggcmF3DQo+PiBkYXRhLg0KPiANCj4+IEkn
bSB0cnlpbmcgdG8gZmluZCBvdXQgd2h5ICdicGZ0b29sIG1hcCBkdW1wJyBmaW5kcyB0aGUgQlRG
IGluZm8gd2hpbGUNCj4+IHBlcmZfZXZlbnRfX3N5bnRoZXNpemVfb25lX2JwZl9wcm9nKCkgZG9l
c24ndC4NCj4gDQo+IEh1bW0sIHRoZSBCVEYgaW5mbyBhYm92ZSBpcyBmb3IgQlBGIF9tYXBzXyBu
b3QgZm9yIF9wcm9ncmFtc18sIEkgdGhpbmsNCj4geW91IGhhdmVuJ3QgYWRkZWQgQlRGIGluZm8g
Zm9yIG1hcHMgaW4gdGhlIHBlcmYuZGF0YSBoZWFkZXIsIHJpZ2h0Pw0KPiANCj4gLSBBcm5hbGRv
DQoNClRoYXTigJlzIHJpZ2h0LiBXZSBpdGVyYXRlIGFsbCBCUEYgcHJvZ3JhbXMsIGFuZCBmZXRj
aCBCVEYgcmVmZXJyZWQgYnkgdGhlIHByb2dyYW1zLg0KDQpUaGFua3MsDQpTb25n
