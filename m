Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE9BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D00208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IUJqM/7m";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="CyHnaI7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfDXWik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:38:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37458 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726400AbfDXWij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:38:39 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OMbmVq003339;
        Wed, 24 Apr 2019 15:37:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=lIJ2tBjx6Yt48UGcicrq42LZgFiZDkSqaNqg3F4Yiz0=;
 b=IUJqM/7mZ0G9bNKB4ciKliSzjCvPBcH40ZVEkAxOPeTBO7HukHbcx1ivnW6BFkIX5CjB
 r+T0NNLFDJhtMkAp6af13tsBrSMe6C20rOrYMKTfQjUCzJsEnS40fHTYu6bxJ1iqpXR6
 QbOntVMqOHn+W6htD7GmYQef6Nqn2TWnK5A= 
Authentication-Results: fb.com;
        spf=pass smtp.mailfrom=yhs@fb.com
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2s30akr572-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 24 Apr 2019 15:37:49 -0700
Received: from ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 24 Apr 2019 15:37:47 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 24 Apr 2019 15:37:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIJ2tBjx6Yt48UGcicrq42LZgFiZDkSqaNqg3F4Yiz0=;
 b=CyHnaI7yucdXnEwXRsbAmUshNbAYf8iwcoS5pTaJAD4yN0T3SiU7ozwuV1ORL2OTpGLH+j9U6UyDbGB4jlBaDIHRof82gdrhtSHRLzXEb5tDiIot/AGfGnmPgqwxylETB2YrBg0al8vFVdQAIvt/vj3tqxhvGF4N2/mS0xBDSeo=
Received: from BN8PR15MB3380.namprd15.prod.outlook.com (20.179.75.139) by
 BN8PR15MB2788.namprd15.prod.outlook.com (20.179.140.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Wed, 24 Apr 2019 22:37:45 +0000
Received: from BN8PR15MB3380.namprd15.prod.outlook.com
 ([fe80::b5bc:d69:3cf5:db53]) by BN8PR15MB3380.namprd15.prod.outlook.com
 ([fe80::b5bc:d69:3cf5:db53%4]) with mapi id 15.20.1835.010; Wed, 24 Apr 2019
 22:37:45 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Matt Mullins <mmullins@fb.com>, Andrew Hall <hall@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH bpf-next v4 1/5] bpf: add writable context for raw
 tracepoints
Thread-Topic: [PATCH bpf-next v4 1/5] bpf: add writable context for raw
 tracepoints
Thread-Index: AQHU+tD+xSmrHq6KZkGnsI6qYwkFE6ZL5wMA
Date:   Wed, 24 Apr 2019 22:37:45 +0000
Message-ID: <6e1205c8-dd63-8866-9b9a-7db3bd432186@fb.com>
References: <20190424190721.24453-1-mmullins@fb.com>
 <20190424190721.24453-2-mmullins@fb.com>
In-Reply-To: <20190424190721.24453-2-mmullins@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0087.namprd02.prod.outlook.com
 (2603:10b6:301:75::28) To BN8PR15MB3380.namprd15.prod.outlook.com
 (2603:10b6:408:a6::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:5d4c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b64d61b9-9e71-4b00-7f11-08d6c9057844
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BN8PR15MB2788;
x-ms-traffictypediagnostic: BN8PR15MB2788:
x-microsoft-antispam-prvs: <BN8PR15MB278834DC7490EED8D302DF54D33C0@BN8PR15MB2788.namprd15.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(366004)(136003)(376002)(189003)(199004)(66446008)(53546011)(66476007)(66556008)(6506007)(11346002)(2616005)(71190400001)(476003)(81166006)(486006)(36756003)(81156014)(14454004)(2501003)(446003)(2906002)(25786009)(8936002)(8676002)(316002)(54906003)(6512007)(110136005)(64756008)(386003)(76176011)(86362001)(5024004)(256004)(71200400001)(73956011)(4744005)(102836004)(186003)(68736007)(46003)(66946007)(2201001)(97736004)(31696002)(7736002)(478600001)(5660300002)(6486002)(99286004)(52116002)(229853002)(53936002)(31686004)(6246003)(6116002)(4326008)(6436002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2788;H:BN8PR15MB3380.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3+YXLQepqjiFmE+07Ybb+xRlSTr3eRTQQna8U4CZYn025vyP8+iIN0vZ6/E2FSZKc1V1+ec5PpSRVlaN95FsomQhdCJICJ6IHtA7dFbdXoLj6eIVUq3lGrMVOvlL0zf4XJnJi1nf6gM91Y13/9cg3cGxhoWOWJT+hVAfqgotMf/TkkChCLJv74Z0FSM83bwUknb8dt14YcktmIgPc/8IL3YX4cbZgbu1ccXdeTE/xU230Zm+pA04ea+qIChf0qNrwUMD7kc5sE75eJwZU6Ko2IyCx2UCE58p01bnktgVWdebP5mFTQ78KrIIcvGBK1M9fiCSd2poDph2T2okwyVSYYMiCajX41G9F8wP3KTBP5lvP6p6XW4z2KJHsxUU6w2XJtdT24zxf6AE+4FpP7IWFsu5kFiKB8iA+RU33C9dfZw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DC83F8E52CB4F43B6956E0AFB83E63B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b64d61b9-9e71-4b00-7f11-08d6c9057844
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 22:37:45.1269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2788
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=961 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904240155
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDQvMjQvMTkgMTI6MDcgUE0sIE1hdHQgTXVsbGlucyB3cm90ZToNCj4gVGhpcyBpcyBh
biBvcHQtaW4gaW50ZXJmYWNlIHRoYXQgYWxsb3dzIGEgdHJhY2Vwb2ludCB0byBwcm92aWRlIGEg
c2FmZQ0KPiBidWZmZXIgdGhhdCBjYW4gYmUgd3JpdHRlbiBmcm9tIGEgQlBGX1BST0dfVFlQRV9S
QVdfVFJBQ0VQT0lOVCBwcm9ncmFtLg0KPiBUaGUgc2l6ZSBvZiB0aGUgYnVmZmVyIG11c3QgYmUg
YSBjb21waWxlLXRpbWUgY29uc3RhbnQsIGFuZCBpcyBjaGVja2VkDQo+IGJlZm9yZSBhbGxvd2lu
ZyBhIEJQRiBwcm9ncmFtIHRvIGF0dGFjaCB0byBhIHRyYWNlcG9pbnQgdGhhdCB1c2VzIHRoaXMN
Cj4gZmVhdHVyZS4NCj4gDQo+IFRoZSBwb2ludGVyIHRvIHRoaXMgYnVmZmVyIHdpbGwgYmUgdGhl
IGZpcnN0IGFyZ3VtZW50IG9mIHRyYWNlcG9pbnRzDQo+IHRoYXQgb3B0IGluOyB0aGUgcG9pbnRl
ciBpcyB2YWxpZCBhbmQgY2FuIGJlIGJwZl9wcm9iZV9yZWFkKCkgYnkgYm90aA0KPiBCUEZfUFJP
R19UWVBFX1JBV19UUkFDRVBPSU5UIGFuZCBCUEZfUFJPR19UWVBFX1JBV19UUkFDRVBPSU5UX1dS
SVRBQkxFDQo+IHByb2dyYW1zIHRoYXQgYXR0YWNoIHRvIHN1Y2ggYSB0cmFjZXBvaW50LCBidXQg
dGhlIGJ1ZmZlciB0byB3aGljaCBpdA0KPiBwb2ludHMgbWF5IG9ubHkgYmUgd3JpdHRlbiBieSB0
aGUgbGF0dGVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF0dCBNdWxsaW5zIDxtbXVsbGluc0Bm
Yi5jb20+DQoNCkFja2VkLWJ5OiBZb25naG9uZyBTb25nIDx5aHNAZmIuY29tPg0KDQo=
