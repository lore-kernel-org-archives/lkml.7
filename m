Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7220C04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC942175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="eMUFDcm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfEJLXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 07:23:35 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:61924 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfEJLXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 07:23:35 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.60,453,1549954800"; 
   d="scan'208";a="32481275"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 May 2019 04:23:33 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 10 May 2019 04:23:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1O0LlmyDZYkM6Z73Frz1BVNUWeFkBXK/TsGcKsV4eH4=;
 b=eMUFDcm6gRQb7Y4S68HMpLmAzugSdlgBNfF9LLwBwcXU2BSD0JjnDiC4HnYmcHQUTyJ8yeL8m5EUtDVWf9j229CgONeQdpOS0CRgVOfC5psu7Qu7vPNNiRPvvhhY9zJtMPtr6Sd2dV6oY5pxrg1BhrvgRgnCBEkmtJPsDzSqw9s=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1935.namprd11.prod.outlook.com (10.175.54.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Fri, 10 May 2019 11:23:24 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4%4]) with mapi id 15.20.1878.022; Fri, 10 May 2019
 11:23:24 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 0/4] add slow clock support for SAM9X60
Thread-Topic: [PATCH v3 0/4] add slow clock support for SAM9X60
Thread-Index: AQHVByLHeJKlvNrK60qOrSCn+DEu0Q==
Date:   Fri, 10 May 2019 11:23:23 +0000
Message-ID: <1557487388-32098-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0031.eurprd07.prod.outlook.com
 (2603:10a6:800:90::17) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e7c9a22-cb5e-4e77-35df-08d6d539e9e3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR11MB1935;
x-ms-traffictypediagnostic: MWHPR11MB1935:
x-microsoft-antispam-prvs: <MWHPR11MB193550D7E90626DF7C4BCE98870C0@MWHPR11MB1935.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(136003)(366004)(376002)(199004)(189003)(256004)(52116002)(478600001)(3846002)(99286004)(72206003)(68736007)(26005)(5660300002)(6116002)(66446008)(110136005)(107886003)(2906002)(4326008)(186003)(386003)(6506007)(66476007)(64756008)(66946007)(102836004)(66556008)(54906003)(2501003)(14454004)(6512007)(73956011)(6436002)(2616005)(6486002)(7736002)(305945005)(53936002)(66066001)(25786009)(316002)(71200400001)(71190400001)(86362001)(8676002)(81166006)(50226002)(36756003)(81156014)(476003)(8936002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1935;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Yg6Sde9l5p1RhWndYADdDoAk/qCUmCeE9yvNw8Vc/ZnxWkVbyxv82YC7E8durjDDqDSJ+bUb4IYAyd2o1DcXukcur+77qv17Mlj6Ay10kOLXaxpPu1KXPMkeYC2nXQsNpzvDB/GBEIYpFYPypD7NQEJcX44jx+c+Wl72DsGzavWIYiR4XcLLQlbH6jN3fgugkAyWDozq5UkkW2SyDl2lxFj8myVjghNUscGlpmGByf5Ger33v2LLC0VOOBDSHtviVfEXvR+9wuBzRIZVFoKuV/0h8tiRjwTKry8fh0EjxcF0apXOK8YBXJAQPmgsx1YjoGjlusVdOHg/S2HVmaUO+UXDaPWOj9nq4JO34B0GiupnKL3QilQcOg23GUy5a5FZfDP9OuIBY2ItIlTnebWM0hjmopzdMFNC/rnROI9tZsU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7c9a22-cb5e-4e77-35df-08d6d539e9e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 11:23:23.9392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1935
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCkhp
LA0KDQpUaGlzIHNlcmllcyBhZGQgc2xvdyBjbG9jayBzdXBwb3J0IGZvciBTQU05WDYwLiBBcGFy
dCBmcm9tIHByZXZpb3VzIElQcywgdGhpcw0Kb25lIHVzZXMgZGlmZmVyZW50IG9mZnNldHMgaW4g
Y29udHJvbCByZWdpc3RlciBmb3IgZGlmZmVyZW50IGZ1bmN0aW9uYWxpdGllcy4NClRoZSBzZXJp
ZXMgYWRhcHQgY3VycmVudCBkcml2ZXIgdG8gd29yayBmb3IgYWxsIElQcyB1c2luZyBwZXIgSVAN
CmNvbmZpZ3VyYXRpb25zIGluaXRpYWxpemVkIGF0IHByb2JlLg0KDQpUaGFuayB5b3UsDQpDbGF1
ZGl1IEJlem5lYQ0KDQpDaGFuZ2VzIGluIHYzOg0KLSBhZGQgcGF0Y2ggMS8xIHRoYXQgcmVtb3Zl
IGJ5cGFzcyBjb2RlIGluIHRoZSBjb2RlIHNwZWNpZmljIHRvIFNBTUE1RDQNCiAgKHRoZXJlIGlz
IG5vIGJ5cGFzcyBzdXBwb3J0IG9uIFNBTUE1RDQpDQotIGFkYXB0IHJldmlldyBjb21tZW50cw0K
LSByZWdpc3RlciBjbG9jayB3aXRoIG9mX2Nsa19od19vbmVjZWxsX2dldCB0byBlbXBoYXNpemUg
dGhhdCB0aGlzIElQIGhhcw0KICAyIG91dHB1dCBjbG9ja3MgTURfU0xLQyBhbmQgVERfU0xDSyAo
SSBjb25zaWRlcmVkIG5vdCBuZWNlc3NhcnkgdG8NCiAgaW50cm9kdWNlIG5ldyBjb25zdGFudHMg
dG8gYmUgc2hhcmVkIGIvdyBkcml2ZXIgYW5kIERUIGJpbmRpbmdzOyBpZg0KICB5b3UgY29uc2lk
ZXIgb3RoZXJ3aXNlLCBsZXQgbWUga25vdykNCi0gYWRhcHQgZHQtYmluZGluZyBwYXRjaCB3aXRo
IGNsb2NrLWNlbGxzIGNoYW5nZXMgKHRodXMgZGlkbid0IGludHJvZHVjZWQNCiAgUmV2aWV3ZWQt
YnkgdGFnKQ0KLSByZW5hbWVkIHN0cnVjdCBjbGtfc2xvd19vZmZzZXRzIHRvIHN0cnVjdCBjbGtf
c2xvd19iaXRzIGFuZCB0aGUNCiAgY29ycmVzcG9uZGluZyBpbnN0YW5jZXMgb2YgaXQNCg0KQ2hh
bmdlcyBpbiB2MjoNCi0gc3BsaXQgcGF0Y2ggMS8xIGZyb20gdjEgaW4gMiBwYXRjaGVzOiBvbmUg
YWRkaW5nIHJlZ2lzdGVyIGJpdCBvZmZzZXRzDQogIHN1cHBvcnQgKHBhdGNoIDEvMyBmcm9tIHRo
aXMgc2VyaWVzKSwgb25lIGFkZGluZyBzdXBwb3J0IGZvciBTQU05WDYwDQogIChwYXRjaCAyLzMg
ZnJvbSB0aGlzIHNlcmllcykNCi0gZml4IGNvbXBhdGlibGUgc3RyaW5nIGZyb20gIm1pY3JvY2hp
cCxhdDkxc2FtOXg2MC1zY2tjIiB0bw0KICAibWljcm9jaGlwLHNhbTl4NjAtc2NrYyINCg0KQ2xh
dWRpdSBCZXpuZWEgKDQpOg0KICBjbGs6IGF0OTE6IHNja2M6IHNhbWE1ZDQgaGFzIG5vIGJ5cGFz
cyBzdXBwb3J0DQogIGNsazogYXQ5MTogc2NrYzogYWRkIHN1cHBvcnQgdG8gc3BlY2lmeSByZWdp
c3RlcnMgYml0IG9mZnNldHMNCiAgZHQtYmluZGluZ3M6IGNsazogYXQ5MTogYWRkIGJpbmRpbmdz
IGZvciBTQU05WDYwJ3Mgc2xvdyBjbG9jaw0KICAgIGNvbnRyb2xsZXINCiAgY2xrOiBhdDkxOiBz
Y2tjOiBhZGQgc3VwcG9ydCBmb3IgU0FNOVg2MA0KDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3Mv
Y2xvY2svYXQ5MS1jbG9jay50eHQgICAgICAgfCAgIDcgKy0NCiBkcml2ZXJzL2Nsay9hdDkxL3Nj
a2MuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDE4MCArKysrKysrKysrKysrKysrLS0t
LS0NCiAyIGZpbGVzIGNoYW5nZWQsIDE0NSBpbnNlcnRpb25zKCspLCA0MiBkZWxldGlvbnMoLSkN
Cg0KLS0gDQoyLjcuNA0KDQo=
