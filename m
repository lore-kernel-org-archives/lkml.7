Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842A3C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50923217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Q4toLZly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfEUKLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:11:23 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:25115 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfEUKLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:11:22 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.60,494,1549954800"; 
   d="scan'208";a="34203048"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 May 2019 03:11:21 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 21 May 2019 03:11:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68M/FY+nUw7WESU5pU5vZ3ng2vQhHkhfsJX4tSNLKcM=;
 b=Q4toLZly0khkWSn439UXBnLsjPI3pUM94rCYYFOtDmBBh/3TD8qYa4ONQ2vHczymE5jnGAEM65CbvZaf+Bp5TUjRKtmWEfkp85Vo0KrFFKAKqLrNEXJsIyzKTQZTAlHMzMs/wgewj+a03VLTBi1WRMcU3NkPV/FmtOmVFhkbRA8=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1949.namprd11.prod.outlook.com (10.175.54.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Tue, 21 May 2019 10:11:19 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4%4]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 10:11:19 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v4 0/4] add slow clock support for SAM9X60
Thread-Topic: [PATCH v4 0/4] add slow clock support for SAM9X60
Thread-Index: AQHVD72I8ZRJakzxaEW9m+CIsi0IRA==
Date:   Tue, 21 May 2019 10:11:18 +0000
Message-ID: <1558433454-27971-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0254.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::26) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12c155bb-6f04-4684-b878-08d6ddd4aac5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR11MB1949;
x-ms-traffictypediagnostic: MWHPR11MB1949:
x-microsoft-antispam-prvs: <MWHPR11MB194929C60E2344A12EE8113C87070@MWHPR11MB1949.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(136003)(39860400002)(346002)(189003)(199004)(66446008)(66556008)(81156014)(486006)(66476007)(102836004)(14454004)(2906002)(64756008)(316002)(73956011)(72206003)(26005)(476003)(68736007)(66066001)(2616005)(186003)(25786009)(99286004)(50226002)(66946007)(52116002)(6636002)(2501003)(81166006)(8936002)(6436002)(86362001)(386003)(7736002)(4326008)(110136005)(54906003)(5660300002)(3846002)(6116002)(6506007)(6512007)(36756003)(107886003)(14444005)(256004)(71200400001)(6486002)(478600001)(53936002)(305945005)(71190400001)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1949;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +4WJX2+fL/B6OMr/u1bZK46DOx4f1XNXb+R5AxMI1oLk4TidjF1/plNmgdAXYtRnbo6H55bo/hKDo9XD+ovmbnkZ+Th8VsxYZ98gWY+mQ/hdNKy3J/zxIb+KUR4uNhghx91jT2VEAq/XHGcu7wo3SI/fGyonh658D+jQxhIcAJy/Uo2TF2koa9TcSRZm4mEXJgjB72O3lcpveE2urIepOH5EDjSwFXjiWSuKe6Q7V8rtb6kEc2ArSfg6SR9/GGXEIsHqyz/dZoKCO//8UnMbNsXbLrv3Ikdi3FlJzuS0LOP5zv++WB32VSkmTy0ZfCWkVwnBjqOEr0kgzCN4ClreNcLOjBG/oEcJ7vuTeotNOKCUVHQiNSZiA1mCwwRjLPLbynxQfriRYWtWR/3iK/K5VvCLej/fkItzCyof5aDx4es=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c155bb-6f04-4684-b878-08d6ddd4aac5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 10:11:18.9555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1949
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
ZGl1IEJlem5lYQ0KDQpDaGFuZ2VzIGluIHY0Og0KLSByZW1vdmUgbWFjcm9zIHdoaWNoIHdlcmUg
dXNlZCB0byBhY2Nlc3MgSVAgc3BlY2lmaWMgYml0cyBmb3IgY29udHJvbA0KICByZWdpc3Rlcg0K
LSBjb2xsZWN0IEFja2VkLWJ5LCBSZXZpZXdlZC1ieSB0YWdzDQoNCkNoYW5nZXMgaW4gdjM6DQot
IGFkZCBwYXRjaCAxLzEgdGhhdCByZW1vdmUgYnlwYXNzIGNvZGUgaW4gdGhlIGNvZGUgc3BlY2lm
aWMgdG8gU0FNQTVENA0KICAodGhlcmUgaXMgbm8gYnlwYXNzIHN1cHBvcnQgb24gU0FNQTVENCkN
Ci0gYWRhcHQgcmV2aWV3IGNvbW1lbnRzDQotIHJlZ2lzdGVyIGNsb2NrIHdpdGggb2ZfY2xrX2h3
X29uZWNlbGxfZ2V0IHRvIGVtcGhhc2l6ZSB0aGF0IHRoaXMgSVAgaGFzDQogIDIgb3V0cHV0IGNs
b2NrcyBNRF9TTEtDIGFuZCBURF9TTENLIChJIGNvbnNpZGVyZWQgbm90IG5lY2Vzc2FyeSB0bw0K
ICBpbnRyb2R1Y2UgbmV3IGNvbnN0YW50cyB0byBiZSBzaGFyZWQgYi93IGRyaXZlciBhbmQgRFQg
YmluZGluZ3M7IGlmDQogIHlvdSBjb25zaWRlciBvdGhlcndpc2UsIGxldCBtZSBrbm93KQ0KLSBh
ZGFwdCBkdC1iaW5kaW5nIHBhdGNoIHdpdGggY2xvY2stY2VsbHMgY2hhbmdlcyAodGh1cyBkaWRu
J3QgaW50cm9kdWNlZA0KICBSZXZpZXdlZC1ieSB0YWcpDQotIHJlbmFtZWQgc3RydWN0IGNsa19z
bG93X29mZnNldHMgdG8gc3RydWN0IGNsa19zbG93X2JpdHMgYW5kIHRoZQ0KICBjb3JyZXNwb25k
aW5nIGluc3RhbmNlcyBvZiBpdA0KDQpDaGFuZ2VzIGluIHYyOg0KLSBzcGxpdCBwYXRjaCAxLzEg
ZnJvbSB2MSBpbiAyIHBhdGNoZXM6IG9uZSBhZGRpbmcgcmVnaXN0ZXIgYml0IG9mZnNldHMNCiAg
c3VwcG9ydCAocGF0Y2ggMS8zIGZyb20gdGhpcyBzZXJpZXMpLCBvbmUgYWRkaW5nIHN1cHBvcnQg
Zm9yIFNBTTlYNjANCiAgKHBhdGNoIDIvMyBmcm9tIHRoaXMgc2VyaWVzKQ0KLSBmaXggY29tcGF0
aWJsZSBzdHJpbmcgZnJvbSAibWljcm9jaGlwLGF0OTFzYW05eDYwLXNja2MiIHRvDQogICJtaWNy
b2NoaXAsc2FtOXg2MC1zY2tjIg0KDQpDbGF1ZGl1IEJlem5lYSAoNCk6DQogIGNsazogYXQ5MTog
c2NrYzogc2FtYTVkNCBoYXMgbm8gYnlwYXNzIHN1cHBvcnQNCiAgY2xrOiBhdDkxOiBzY2tjOiBh
ZGQgc3VwcG9ydCB0byBzcGVjaWZ5IHJlZ2lzdGVycyBiaXQgb2Zmc2V0cw0KICBkdC1iaW5kaW5n
czogY2xrOiBhdDkxOiBhZGQgYmluZGluZ3MgZm9yIFNBTTlYNjAncyBzbG93IGNsb2NrDQogICAg
Y29udHJvbGxlcg0KICBjbGs6IGF0OTE6IHNja2M6IGFkZCBzdXBwb3J0IGZvciBTQU05WDYwDQoN
CiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9hdDkxLWNsb2NrLnR4dCAgICAgICB8ICAg
NyArLQ0KIGRyaXZlcnMvY2xrL2F0OTEvc2NrYy5jICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgMTczICsrKysrKysrKysrKysrKystLS0tLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMTM5IGluc2Vy
dGlvbnMoKyksIDQxIGRlbGV0aW9ucygtKQ0KDQotLSANCjIuNy40DQoNCg==
