Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BB0C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774C620656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PWAkq5Yi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="T3Qtpe/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfEHKqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 06:46:42 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:34430 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbfEHKql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 06:46:41 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 198BFC00FC;
        Wed,  8 May 2019 10:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557312404; bh=Mgi6Ub30bU6C1uBLJImyqwJIDRatyud17SSVb9zoyMA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=PWAkq5YivkFrfmDPQtOMJTGwza/FK43q82WoimdpzzvZ8iimootkseYiJAfmgMrX9
         aNZQz8jinB0+ES8NOOOvaYgk2mB3Pr5iNQF3tp6Zlg/cmFUbfuPVDZ986G4via6GU3
         +I9iILYjpDxxG+tx5QdUMWE6pzzkOHUppVNpJjjbm/6iUMzm25RpcLjvNWK53pvp3P
         wizIHSphE5Nd/WFC2Ate+0bLOvZcAWtU+kL2JP7SrPFpo5tLQViT4IrOa6RhhFkpAT
         kSpOg7dUXBRStoSTOdv0tGejgglrAOku6FlEzxSkTqjMAb5Q+Z8mM84YkaUfsaWWw+
         Qp+dnl2NFR7zg==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4958EA0085;
        Wed,  8 May 2019 10:46:40 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 8 May 2019 03:46:40 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 8 May 2019 03:46:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mgi6Ub30bU6C1uBLJImyqwJIDRatyud17SSVb9zoyMA=;
 b=T3Qtpe/+92m6W0cY4K9l1zdzVLB8AH7cHGTaqv9TA7zZ20POpyl0ppUk1yVdiMdpZ9G0+Gtuo9OonYKE9MCmAwxVWwXqNqyGsgX1WnVhzlGAht4AxNoRoA4ImPfot/oWGiXZf+w4x2SLOBndhZTZcIr13vL6D2vgikFfGFOVB20=
Received: from CY4PR1201MB0120.namprd12.prod.outlook.com (10.172.78.14) by
 CY4PR1201MB0006.namprd12.prod.outlook.com (10.172.117.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Wed, 8 May 2019 10:46:37 +0000
Received: from CY4PR1201MB0120.namprd12.prod.outlook.com
 ([fe80::ac77:1c39:d9eb:ee9a]) by CY4PR1201MB0120.namprd12.prod.outlook.com
 ([fe80::ac77:1c39:d9eb:ee9a%4]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 10:46:37 +0000
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     Jose Abreu <Jose.Abreu@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "Jose.Abreu@synopsys.com" <Jose.Abreu@synopsys.com>
CC:     "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: RE: [PATCH] ARC: [plat-hsdk]: Add missing multicast filter bins
 number to GMAC node
Thread-Topic: [PATCH] ARC: [plat-hsdk]: Add missing multicast filter bins
 number to GMAC node
Thread-Index: AQHVAPmTtgBcK4O0F0yjr7qr2E730qZX+TEAgAZ1TgCAAm7ygIAANxpQ
Date:   Wed, 8 May 2019 10:46:36 +0000
Message-ID: <CY4PR1201MB01206801C1C2B8272ABE9B17A1320@CY4PR1201MB0120.namprd12.prod.outlook.com>
References: <7f36bbadc0df4c93c396690dab59f34775de3874.1556788240.git.joabreu@synopsys.com>
         <56933076-879c-78a0-4bae-2613203b93b1@synopsys.com>
 <1557166759.17021.9.camel@synopsys.com>
 <78EB27739596EE489E55E81C33FEC33A0B478870@DE02WEMBXB.internal.synopsys.com>
In-Reply-To: <78EB27739596EE489E55E81C33FEC33A0B478870@DE02WEMBXB.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abrodkin@synopsys.com; 
x-originating-ip: [188.243.7.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a263a289-e37e-4531-ed9e-08d6d3a2720b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:CY4PR1201MB0006;
x-ms-traffictypediagnostic: CY4PR1201MB0006:
x-microsoft-antispam-prvs: <CY4PR1201MB00067A50EF89C64D35107638A1320@CY4PR1201MB0006.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39850400004)(366004)(346002)(376002)(189003)(199004)(13464003)(66946007)(66476007)(6116002)(3846002)(6436002)(4744005)(64756008)(66556008)(25786009)(186003)(478600001)(7696005)(26005)(256004)(55016002)(76116006)(52536014)(2906002)(99286004)(14454004)(5660300002)(73956011)(9686003)(54906003)(316002)(110136005)(4326008)(76176011)(53936002)(71190400001)(229853002)(71200400001)(66446008)(86362001)(102836004)(6246003)(305945005)(53546011)(8676002)(6506007)(66066001)(2501003)(8936002)(81156014)(81166006)(11346002)(476003)(7736002)(6636002)(486006)(74316002)(446003)(33656002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1201MB0006;H:CY4PR1201MB0120.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iiKNVJ42Axl6VBQT0LSERz8lbVYikSUgxtpWPOKDWCmB+raX8wKnU3NYpmelPKU5xFlCCsljI3Rt+A05/l76mvIT4dBgN5LiBvc1DU58JzzHk0FdZfhK08C7sQPtyqyuqcLdB4ohjfqZrvCDxMwOdclXOvG6S6lU6E3ok/JJs3Q6qNk6PUFYM23OhM2S67DdCw1a6YYcQrIYu4avGkjKGvYMa39E0n1bR5LEsqIhrT4CbkiONRWneUapDOrjFctyiWf7xVduR6UAZR8F1q4CCOq9WDNsqlTrbvWP7CNc6z/ZwWlzhtEWU31semo8E5S0z0vbtJpt3JZk4mAZkl6OA47yHdgRF9GCP0rzrvnEC2fUpiQ1SfJf2WpqvIKi10It3QQ9T1JwooAl/ihB4yqBkScC4CyDmF0aoVL5RiuBl2k=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a263a289-e37e-4531-ed9e-08d6d3a2720b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 10:46:36.9679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0006
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9zZSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb3NlIEFi
cmV1IDxqb2FicmV1QHN5bm9wc3lzLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXkgOCwgMjAx
OSAxMDoyOSBBTQ0KPiBUbzogRXVnZW5peSBQYWx0c2V2IDxwYWx0c2V2QHN5bm9wc3lzLmNvbT47
IEpvc2UuQWJyZXVAc3lub3BzeXMuY29tOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0K
PiBWaW5lZXQgR3VwdGEgPHZndXB0YUBzeW5vcHN5cy5jb20+OyBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtc25wcy1hcmNAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBDYzogSm9hby5Q
aW50b0BzeW5vcHN5cy5jb207IFZpbmVldC5HdXB0YTFAc3lub3BzeXMuY29tOyBFdWdlbml5LlBh
bHRzZXZAc3lub3BzeXMuY29tOyBBbGV4ZXkgQnJvZGtpbg0KPiA8YWJyb2RraW5Ac3lub3BzeXMu
Y29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIXSBBUkM6IFtwbGF0LWhzZGtdOiBBZGQgbWlzc2lu
ZyBtdWx0aWNhc3QgZmlsdGVyIGJpbnMgbnVtYmVyIHRvIEdNQUMgbm9kZQ0KPiANCj4gRnJvbTog
RXVnZW5peSBQYWx0c2V2IDxwYWx0c2V2QHN5bm9wc3lzLmNvbT4NCj4gRGF0ZTogTW9uLCBNYXkg
MDYsIDIwMTkgYXQgMTk6MTk6MjANCj4gDQo+ID4gSGksDQo+ID4NCj4gPiBJJ2xsIGNoZWNrIHRo
aXMgaW4gdGhlIG5leHQgZmV3IGRheXMuDQo+ID4NCj4gDQo+IEkgYWxzbyBub3RpY2VkIHRoYXQg
RklGTyBzaXplIGVudHJ5IGlzIG1pc3NpbmcuIERXTUFDMTAwMCBkb2VzIG5vdA0KPiBzdXBwb3J0
IGF1dG9tYXRpYyBGSUZPIHNpemUgZGV0ZWN0aW9uIHNvIHRoaXMgZW50cnkgbmVlZHMgdG8gYmUg
YWRkZWQuDQoNCkNvdWxkIHlvdSBwbGVhc2UgcHJvcG9zZSBhIHBhdGNoPw0KDQotQWxleGV5DQoN
Cg==
