Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57823C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139CD2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Gx2NZyoV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ordI57cS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbfDBPkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:40:37 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:51762 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729322AbfDBPkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1554219640; x=1585755640;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WzFhpxT4zNMJZ9ZOzqX8lDh2qmQwssfszQk/kTCh5oY=;
  b=Gx2NZyoV39xBNVb3sQsKIkfdgTO8CoXJ/bVDE0wBDyLOvMNbahIkVPMl
   nuoQE9w/0j3QPn9CTWOQvUIdRnCKkU82skmma97n+lz1412z3BRHNxPHs
   Z0bqTXRQArLC3TB4rd7ZO05MYS7QisPt4T7mZpQnuczFucMEITjL0UsZW
   e8ptSkDvPKbro6/8uTMzOYdFxl9qYboBi4W258Juwz80xDukIvwgRFzXn
   pFcviYT5CCo9MM6PJrQ/j6vXykSBBDIaISzmR/TrWJSGf8Y3pTQ4dFCa/
   O9G0FnHTKPlhrJSIMCCefZwowF/degG0WRmA3MM8iAchUhndbaVWxDrAk
   w==;
X-IronPort-AV: E=Sophos;i="5.60,301,1549900800"; 
   d="scan'208";a="203678239"
Received: from mail-sn1nam04lp2058.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.58])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2019 23:40:39 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzFhpxT4zNMJZ9ZOzqX8lDh2qmQwssfszQk/kTCh5oY=;
 b=ordI57cSSQuQErhnt6IA/MRthGh8pDPNIdDc0Ht0zySJPH1SG9mBycu3StLX5ztlT6R7pkXrlhYgT1PhL1Y9AWDx1XlPOnSygGIJXWqsnwtFhowZf1fBeiuGwUNiUn1kr/TVeAEBR2F3SvYWYJ9DanDcuq6ESawVG1wJT/lWSxM=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB5134.namprd04.prod.outlook.com (52.135.116.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.22; Tue, 2 Apr 2019 15:40:34 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::f4d4:a300:2010:195a]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::f4d4:a300:2010:195a%3]) with mapi id 15.20.1750.017; Tue, 2 Apr 2019
 15:40:34 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Martin Petersen <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
CC:     SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: correcting incorrect peripheral device type 0x0
Thread-Topic: correcting incorrect peripheral device type 0x0
Thread-Index: AQHU6WWBxWIvHAc/ikWG8Iy8lFyBPaYpAP5w
Date:   Tue, 2 Apr 2019 15:40:34 +0000
Message-ID: <SN6PR04MB4925C5CD48062BA0DE8DEFF3FC560@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <ab8d589f-db76-9a95-1b55-3e906ad89487@free.fr>
In-Reply-To: <ab8d589f-db76-9a95-1b55-3e906ad89487@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [129.253.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc6855d5-fa7a-4bf1-eede-08d6b7818bc5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR04MB5134;
x-ms-traffictypediagnostic: SN6PR04MB5134:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB5134EFD2500CA90CB5852D6AFC560@SN6PR04MB5134.namprd04.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(346002)(376002)(39860400002)(199004)(189003)(13464003)(97736004)(2906002)(66066001)(14444005)(72206003)(256004)(33656002)(102836004)(6506007)(53546011)(76176011)(68736007)(6436002)(6116002)(3846002)(229853002)(14454004)(71190400001)(71200400001)(478600001)(25786009)(7696005)(9686003)(105586002)(106356001)(476003)(446003)(74316002)(11346002)(86362001)(4326008)(26005)(8676002)(186003)(316002)(6246003)(52536014)(55016002)(110136005)(81156014)(54906003)(5660300002)(7736002)(99286004)(305945005)(8936002)(81166006)(53936002)(486006)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5134;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WYun0DpyOjzSb6QP9zAPx/SUJBaDwy2cSTN3sPGwgLCLDPkHTT4xDqxugLhXCgfG7ZDvZ1d/f7Pt3oa89KCy9sNxu7+b6uw9FiriH7RVDsB4ezBSVE8XtBly74rlS4RUyJy1CuKy1I1qyVb320ksfzogcZkNcSsyKDFR3MBipkxvtJiLvqpxUkU1GwjyJUwqSw5ShA/U5EaQW5DV6eWnZMjtYXNg/klhM9lkgTEk2fSuwxctibRKoK1FmTtNaeeuMHq0jIImIDCEzGk3gUU/vnMN5M9fTfzZeuy5MWYXmmO/OlIGik+1PpHUE98YvWZjtfVmIxVWmViB6oGU7yt4j2oILhBV92nTIcH672pY+a1thEStjeEJyBiYQzE5xvjVvPpe75AGyfPU9aQaJlSLDm2YI1LpzniL5iZQuMsEtt4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6855d5-fa7a-4bf1-eede-08d6b7818bc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 15:40:34.2182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQpMb29raW5nIHdoZXJlIHRoaXMgd2FybmluZyBpcyBjb21pbmcgZnJvbSwNClNjc2kgaXMg
anVzdCBmb3JjaW5nIHNkZXYtPnR5cGUgPSBUWVBFX1dMVU4gZm9yIHdsdW5zLg0KQXMgbm8gb3Ro
ZXIgZHJpdmVyIHNldHMgaXQgYnkgaXRzZWxmIC0gSSB3b3VsZG4ndCBsb3NlIHNsZWVwIG92ZXIg
aXQuDQpUaGFua3MsDQpBdnJpDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBNYXJjIEdvbnphbGV6IDxtYXJjLncuZ29uemFsZXpAZnJlZS5mcj4NCj4gU2VudDogVHVl
c2RheSwgQXByaWwgMDIsIDIwMTkgNjowNSBQTQ0KPiBUbzogTWFydGluIFBldGVyc2VuIDxtYXJ0
aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbT47IEF2cmkgQWx0bWFuDQo+IDxBdnJpLkFsdG1hbkB3ZGMu
Y29tPjsgQWxpbSBBa2h0YXIgPGFsaW0uYWtodGFyQHNhbXN1bmcuY29tPg0KPiBDYzogU0NTSSA8
bGludXgtc2NzaUB2Z2VyLmtlcm5lbC5vcmc+OyBMS01MIDxsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnPg0KPiBTdWJqZWN0OiBjb3JyZWN0aW5nIGluY29ycmVjdCBwZXJpcGhlcmFsIGRldmlj
ZSB0eXBlIDB4MA0KPiANCj4gSGVsbG8sDQo+IA0KPiBJbiBteSBib290IGxvZywgd2hlbiBVRlMg
aXMgZW5hYmxlZCwgSSBnZXQgdGhlIGZvbGxvd2luZyB3YXJuaW5nczoNCj4gDQo+IHNjc2kgMDow
OjA6NDk0ODg6IHNjc2lfYWRkX2x1bjogY29ycmVjdGluZyBpbmNvcnJlY3QgcGVyaXBoZXJhbCBk
ZXZpY2UgdHlwZQ0KPiAweDAgZm9yIFctTFVOIDB4ICAgICAgICAgICAgYzE1MGhODQo+IHNjc2kg
MDowOjA6NDk0ODg6IFdlbGwta25vd24gTFVOICAgIFNBTVNVTkcgIEtMVUNHNEoxRUItQjBCMSAg
MDIwMCBQUToNCj4gMCBBTlNJOiA2DQo+IHNjc2kgMDowOjA6NDk0NzY6IHNjc2lfYWRkX2x1bjog
Y29ycmVjdGluZyBpbmNvcnJlY3QgcGVyaXBoZXJhbCBkZXZpY2UgdHlwZQ0KPiAweDAgZm9yIFct
TFVOIDB4ICAgICAgICAgICAgYzE0NGhODQo+IHNjc2kgMDowOjA6NDk0NzY6IFdlbGwta25vd24g
TFVOICAgIFNBTVNVTkcgIEtMVUNHNEoxRUItQjBCMSAgMDIwMCBQUToNCj4gMCBBTlNJOiA2DQo+
IHNjc2kgMDowOjA6NDk0NTY6IHNjc2lfYWRkX2x1bjogY29ycmVjdGluZyBpbmNvcnJlY3QgcGVy
aXBoZXJhbCBkZXZpY2UgdHlwZQ0KPiAweDAgZm9yIFctTFVOIDB4ICAgICAgICAgICAgYzEzMGhO
DQo+IHNjc2kgMDowOjA6NDk0NTY6IFdlbGwta25vd24gTFVOICAgIFNBTVNVTkcgIEtMVUNHNEox
RUItQjBCMSAgMDIwMCBQUToNCj4gMCBBTlNJOiA2DQo+IA0KPiBJcyB0aGVyZSBzb21ldGhpbmcg
SSBjYW4vc2hvdWxkIGRvIHRvIGZpeCB0aGVzZSBpc3N1ZXM/DQo+IE9yIG1heSB0aGV5IGJlIHNh
ZmVseSBpZ25vcmVkPw0KPiANCj4gUmVnYXJkcy4NCg==
