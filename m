Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43940C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 18:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EAF321019
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 18:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="I3Sp4fEP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="P2SuC4TS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfEFST1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 14:19:27 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:51940 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726175AbfEFST1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 14:19:27 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 83258C01B4;
        Mon,  6 May 2019 18:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557166761; bh=QtJyrHd1kqFiZBvKEbAd5xX72dDlbRtHAwVPExvEW6A=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=I3Sp4fEPPA3ef3oVOMH4WQCUtNOkvZO6ESx3XdCc3xpf+CWutYaRryD/xXQXbYb2b
         mYjz6FXkZtDjZyu2ESfADn9yw782b7aLa3VIs/qszEScwQfzHmk7ZCAvYsWEvk4kUL
         I1iSCzHbFIi7hIc7m0MrWEyGqCKWc4wk+aboC5EN+k0P77lCaEqq/2u6NQmC4w9PyH
         7vQad/BBOwOB3AD7IYz2LUQLQbPZHxmunu6IADiWdMzeQzhZ3ZdizH1t6iPxNaQ0lF
         lb9pqzsYg++yaW2p2GRuN0gPLz1wNbFHMTAIOHs4teWp46q7YH063zpRsyuGAs/U/m
         IdN4WZJKlDVgQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 51933A0095;
        Mon,  6 May 2019 18:19:23 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 6 May 2019 11:19:23 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 6 May 2019 11:19:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtJyrHd1kqFiZBvKEbAd5xX72dDlbRtHAwVPExvEW6A=;
 b=P2SuC4TSIw7HPekAWtT1Lkozqod+7Zh7dYfUZmvFLpm47y/7OV0beYnslcnR6XM/td5E37Jh7l4ErJR4+2Kpwk2Tu1iA+rIFVof0i7LBpZgSQSQK4HLNhHSdeOS3IWs11oyOxChehLlwRZMaJr65c7G3Ly4c7rmIBRYsYy2zGSk=
Received: from MWHPR12MB1632.namprd12.prod.outlook.com (10.172.56.21) by
 MWHPR12MB1775.namprd12.prod.outlook.com (10.175.55.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Mon, 6 May 2019 18:19:20 +0000
Received: from MWHPR12MB1632.namprd12.prod.outlook.com
 ([fe80::c5dc:3b4:6ab8:4dc6]) by MWHPR12MB1632.namprd12.prod.outlook.com
 ([fe80::c5dc:3b4:6ab8:4dc6%2]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 18:19:20 +0000
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     "Jose.Abreu@synopsys.com" <Jose.Abreu@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH] ARC: [plat-hsdk]: Add missing multicast filter bins
 number to GMAC node
Thread-Topic: [PATCH] ARC: [plat-hsdk]: Add missing multicast filter bins
 number to GMAC node
Thread-Index: AQHVAPmYu+SP3l/OT0e8rqST5fDlGKZX+TEAgAZ1TIA=
Date:   Mon, 6 May 2019 18:19:20 +0000
Message-ID: <1557166759.17021.9.camel@synopsys.com>
References: <7f36bbadc0df4c93c396690dab59f34775de3874.1556788240.git.joabreu@synopsys.com>
         <56933076-879c-78a0-4bae-2613203b93b1@synopsys.com>
In-Reply-To: <56933076-879c-78a0-4bae-2613203b93b1@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paltsev@synopsys.com; 
x-originating-ip: [84.204.78.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db93fc10-3909-4230-81fd-08d6d24f5be6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR12MB1775;
x-ms-traffictypediagnostic: MWHPR12MB1775:
x-microsoft-antispam-prvs: <MWHPR12MB17754AF42F8FA4F933A446C7DE300@MWHPR12MB1775.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39850400004)(376002)(346002)(396003)(189003)(199004)(54906003)(8676002)(8936002)(110136005)(316002)(102836004)(66066001)(256004)(76176011)(186003)(81156014)(86362001)(81166006)(53546011)(2501003)(478600001)(229853002)(5660300002)(53936002)(6512007)(6506007)(2201001)(14454004)(6486002)(6116002)(107886003)(66476007)(66556008)(64756008)(66446008)(68736007)(76116006)(66946007)(446003)(2906002)(11346002)(73956011)(476003)(91956017)(6246003)(6436002)(2616005)(486006)(4326008)(305945005)(7736002)(99286004)(26005)(71190400001)(71200400001)(3846002)(36756003)(103116003)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR12MB1775;H:MWHPR12MB1632.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LtCLXwsLT6co9xynGg2JZ11/j1E7fGTC0Xi2nPeZ7e7BLLFQUnc4qGD3ION2nngr4kcOZcpC8/r0UnEhQItdm4BCamGeLxn7kOQDi0Ro1ByuFhpKGjuuHeTqHubd4LlFL18W8odPBP939pgt+Uz7DBMGxbcgD1zaRC6dIR2KhdMHyDG3OfzULlO1oIrPCK3QUlVVMvJ1FKUsJK24wsqbhed0Mf+qOnY7bW7PENr2ThfftGxgGOZdRGSmeU+DlOG/7nLySukFyxNX8MZFqiT2ULHlQcDfz/mTReHyo/COaCg3h7Hbvv/wJ+jO2TDuafCKfgkm1ElkaNJgJhLwAUSC0wa3mqRbS0/+rNqk0i+VRPjmcwiS2ilwawpOC4v+jyU4hPo78AcVGll/YVZZfXeeuRjrFYW85aLhQbvjYaQpYBI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A823811A20DAA43B211A7AB42CD65C2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: db93fc10-3909-4230-81fd-08d6d24f5be6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 18:19:20.3634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1775
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkknbGwgY2hlY2sgdGhpcyBpbiB0aGUgbmV4dCBmZXcgZGF5cy4NCg0KT24gVGh1LCAy
MDE5LTA1LTAyIGF0IDA4OjQxIC0wNzAwLCBWaW5lZXQgR3VwdGEgd3JvdGU6DQo+ICtDQyBBbGV4
ZXksIEV1Z2VuaXkgd2hvIG1haW50YWluIGhzZGsgc3VwcG9ydCAhDQo+IA0KPiBPbiA1LzIvMTkg
ODoxMiBBTSwgSm9zZSBBYnJldSB3cm90ZToNCj4gPiBHTUFDIGNvbnRyb2xsZXIgb24gSFNESyBi
b2FyZHMgc3VwcG9ydHMgMjU2IEhhc2ggVGFibGUgc2l6ZSBzbyB3ZSBuZWVkIHRvDQo+ID4gYWRk
IHRoZSBtdWx0aWNhc3QgZmlsdGVyIGJpbnMgcHJvcGVydHkuIFRoaXMgYWxsb3dzIGZvciB0aGUg
SGFzaCBmaWx0ZXINCj4gPiB0byB3b3JrIHByb3Blcmx5IHVzaW5nIHN0bW1hYyBkcml2ZXIuDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSm9zZSBBYnJldSA8am9hYnJldUBzeW5vcHN5cy5jb20+
DQo+ID4gQ2M6IEpvYW8gUGludG8gPGpwaW50b0BzeW5vcHN5cy5jb20+DQo+ID4gQ2M6IFJvYiBI
ZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+DQo+ID4gQ2M6IE1hcmsgUnV0bGFuZCA8bWFyay5y
dXRsYW5kQGFybS5jb20+DQo+ID4gQ2M6IFZpbmVldCBHdXB0YSA8dmd1cHRhQHN5bm9wc3lzLmNv
bT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcmMvYm9vdC9kdHMvaHNkay5kdHMgfCAxICsNCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJjL2Jvb3QvZHRzL2hzZGsuZHRzIGIvYXJjaC9hcmMvYm9vdC9kdHMvaHNkay5kdHMNCj4g
PiBpbmRleCA2OWJjMWM5ZThlNTAuLmIwZjA1OTM3N2FiMCAxMDA2NDQNCj4gPiAtLS0gYS9hcmNo
L2FyYy9ib290L2R0cy9oc2RrLmR0cw0KPiA+ICsrKyBiL2FyY2gvYXJjL2Jvb3QvZHRzL2hzZGsu
ZHRzDQo+ID4gQEAgLTE4Nyw2ICsxODcsNyBAQA0KPiA+ICAJCQlpbnRlcnJ1cHQtbmFtZXMgPSAi
bWFjaXJxIjsNCj4gPiAgCQkJcGh5LW1vZGUgPSAicmdtaWkiOw0KPiA+ICAJCQlzbnBzLHBibCA9
IDwzMj47DQo+ID4gKwkJCXNucHMsbXVsdGljYXN0LWZpbHRlci1iaW5zID0gPDI1Nj47DQo+ID4g
IAkJCWNsb2NrcyA9IDwmZ21hY2Nsaz47DQo+ID4gIAkJCWNsb2NrLW5hbWVzID0gInN0bW1hY2V0
aCI7DQo+ID4gIAkJCXBoeS1oYW5kbGUgPSA8JnBoeTA+Ow0KPiA+IA0KPiANCj4gDQotLSANCiBF
dWdlbml5IFBhbHRzZXY=
