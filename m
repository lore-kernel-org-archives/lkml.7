Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4873CC4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214D8216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="dH6hl+p8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfGEPT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 11:19:29 -0400
Received: from mail-eopbgr00048.outbound.protection.outlook.com ([40.107.0.48]:32494
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725497AbfGEPT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 11:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDy6gqBwRfBnEoROp239PykctiHXNqmeRJBnrufS3J8=;
 b=dH6hl+p8+ftt8drEJw6/1bvWjvsQ0y3cVDEvtNjhN71U9i3w1QDC+zE/Lv56N03+CFr2A3PNO/GkLl531rEisI3XmwVOa047LkT03/nOpsHRf/MixqGJPBsT84jnxsKvgjGEc41vdDNPm7SAbYpBhfXkg7+oXRL0a5N18f4MBGw=
Received: from DB6PR05MB4790.eurprd05.prod.outlook.com (10.168.21.139) by
 DB6PR05MB3381.eurprd05.prod.outlook.com (10.170.219.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Fri, 5 Jul 2019 15:19:26 +0000
Received: from DB6PR05MB4790.eurprd05.prod.outlook.com
 ([fe80::e969:37c8:c972:c3cb]) by DB6PR05MB4790.eurprd05.prod.outlook.com
 ([fe80::e969:37c8:c972:c3cb%7]) with mapi id 15.20.2032.019; Fri, 5 Jul 2019
 15:19:26 +0000
From:   Bodong Wang <bodong@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Doug Ledford <dledford@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: linux-next: Fixes tag needs some work in the rdma tree
Thread-Topic: linux-next: Fixes tag needs some work in the rdma tree
Thread-Index: AQHVM0Hvthni0vP1SE2nA18rmcpPiaa8HokAgAAE+IA=
Date:   Fri, 5 Jul 2019 15:19:26 +0000
Message-ID: <ddbbbd7d-3c16-41cb-5df3-87eabb6516b5@mellanox.com>
References: <20190706005705.2e6c268c@canb.auug.org.au>
 <20190705150125.GE31525@mellanox.com>
In-Reply-To: <20190705150125.GE31525@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0030.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::43) To DB6PR05MB4790.eurprd05.prod.outlook.com
 (2603:10a6:6:4d::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bodong@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8afbfa6d-5a48-44c3-a730-08d7015c2a83
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB6PR05MB3381;
x-ms-traffictypediagnostic: DB6PR05MB3381:
x-microsoft-antispam-prvs: <DB6PR05MB3381F029F090B6529527C54AAAF50@DB6PR05MB3381.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:462;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(199004)(53754006)(189003)(53546011)(5660300002)(107886003)(2906002)(99286004)(6246003)(52116002)(486006)(110136005)(305945005)(6436002)(6512007)(6506007)(386003)(53936002)(76176011)(6486002)(64756008)(66556008)(66066001)(54906003)(446003)(7736002)(14454004)(36756003)(11346002)(476003)(73956011)(66946007)(316002)(478600001)(2616005)(66476007)(86362001)(81166006)(4326008)(8676002)(71200400001)(102836004)(66446008)(4744005)(31686004)(8936002)(229853002)(25786009)(31696002)(256004)(26005)(81156014)(6116002)(3846002)(186003)(14444005)(71190400001)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB3381;H:DB6PR05MB4790.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: noeUK8OY1uit/kGxzhSH4JliBGl1YCNoxiCi/kfZsxA7HeGjWEKwSFETiw0FK/4Yi+fl5+y9806XfRBC3h7o5Yu1quJlOIdEPpGytmuTxBKrOfEpwElKQX4j2vboPPzERF2VGbG8SxmgWHGRh45pTQQUK0/2vvvSEUdT95trXCINOSpM+2T50dM9QgbdD9HX82unpBgt5PnWrtcTSs1HF8RvfP5qJEykKSSP3bUUsrl9z8sZacWeMQ2cyeWmpCwUhkAsOdT6l0cvN4Ux/ORjwNiBicLHCm+rr/e2OGGUUGmNKqkgAlVcqTIRgnu2b4UeyiTx9uh0j6Tluco6/CSKmKPEEnpAositkyTmKVRQw9X7s1h5BXfRYEwsn1gmh251OqwyR1hiJWAuYtReWM7Ws/Uow1x4wAtZM67w4OMsD1s=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97360A1B7037914BA5A8C891AFFAF565@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8afbfa6d-5a48-44c3-a730-08d7015c2a83
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 15:19:26.5390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bodong@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB3381
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy81LzIwMTkgMTA6MDEgQU0sIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gU2F0LCBK
dWwgMDYsIDIwMTkgYXQgMTI6NTc6MDVBTSArMTAwMCwgU3RlcGhlbiBSb3Rod2VsbCB3cm90ZToN
Cj4+IEhpIGFsbCwNCj4+DQo+PiBJbiBjb21taXQNCj4+DQo+PiAgICAxNmZmZjk4YTdlODIgKCJu
ZXQvbWx4NTogRS1Td2l0Y2gsIFJlZy91bnJlZyBmdW5jdGlvbiBjaGFuZ2VkIGV2ZW50IGF0IGNv
cnJlY3Qgc3RhZ2UiKQ0KPj4NCj4+IEZpeGVzIHRhZw0KPj4NCj4+ICAgIEZpeGVzOiA2MWZjODgw
ODM5ZTYgKCJuZXQvbWx4NTogRS1Td2l0Y2gsIEhhbmRsZSByZXByZXNlbnRvcnMgY3JlYXRpb24g
aW4gaGFuZGxlciBjb250ZXh0IikNCj4+DQo+PiBoYXMgdGhlc2UgcHJvYmxlbShzKToNCj4+DQo+
PiAgICAtIFRhcmdldCBTSEExIGRvZXMgbm90IGV4aXN0DQo+Pg0KPj4gRGlkIHlvdSBtZWFuDQo+
Pg0KPj4gRml4ZXM6IGFjMzVkY2Q2ZTRiZCAoIm5ldC9tbHg1OiBFLVN3aXRjaCwgSGFuZGxlIHJl
cHJlc2VudG9ycyBjcmVhdGlvbiBpbiBoYW5kbGVyIGNvbnRleHQiKQ0KPiBZb3UgYXJlIGNvcnJl
Y3QsIHVuZm9ydHVuYXRlbHkgdGhlIHRyZWVzIGNhbid0IGJlIHJlYmFzZWQgYXQgdGhpcw0KPiBw
b2ludCB0byBmaXggaXQuDQo+DQo+IFRoYW5rcywNCj4gSmFzb24NCg0KSSB0aGluayBJIGZldGNo
ZWQgdGhlIHRhZyB3aGVuIG9yaWdpbmFsIHBhdGNoIHdhcyBub3QgbWVyZ2VkIHlldC4gTmVlZCAN
CnRvIGZpZ3VyZSBvdXQgYSB3YXkgdG8gZGV0ZWN0IHN1Y2ggbWlzcyBtYXRjaC4NCg0K
