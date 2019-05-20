Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4693EC072A4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0848420656
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="KfWyVWkl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731599AbfETIye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:54:34 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:7700 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfETIyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:54:33 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.60,491,1549954800"; 
   d="scan'208";a="32166388"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 May 2019 01:54:33 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 20 May 2019 01:54:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kym2ucJTB00u/0r5PK5KuwaYL68HfMmqgeANTDlnHCs=;
 b=KfWyVWklExTNcdhxkhJVN1ZuxM5KHzgnEg74iq0++LpCL5zaNzZVuzRvzKZeLF6chSGwsq+jWJznOT2o+B/xKsjpYSclnciA1BfEbMovTq+UdhQlMunyqDt6i7kGrXXUOXQ5DMI+arv/o1iPdbC/JvCqZm/bgilMvAlacK9JH0k=
Received: from CY4PR11MB1543.namprd11.prod.outlook.com (10.172.70.22) by
 CY4PR11MB1800.namprd11.prod.outlook.com (10.175.62.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Mon, 20 May 2019 08:54:24 +0000
Received: from CY4PR11MB1543.namprd11.prod.outlook.com
 ([fe80::ada3:81b8:4954:9722]) by CY4PR11MB1543.namprd11.prod.outlook.com
 ([fe80::ada3:81b8:4954:9722%4]) with mapi id 15.20.1900.010; Mon, 20 May 2019
 08:54:24 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] clk: at91: sckc: add support to specify registers
 bit offsets
Thread-Topic: [PATCH v3 2/4] clk: at91: sckc: add support to specify registers
 bit offsets
Thread-Index: AQHVByLMz9Q/0hn5ekyMa2w9MKbUHaZk4YYAgAiN1ACAAm0oAIAD6GMA
Date:   Mon, 20 May 2019 08:54:24 +0000
Message-ID: <8900ba46-7166-2b5e-961b-3786121c845f@microchip.com>
References: <1557487388-32098-1-git-send-email-claudiu.beznea@microchip.com>
 <1557487388-32098-3-git-send-email-claudiu.beznea@microchip.com>
 <20190510213242.GE7622@piout.net>
 <b99b1782-30be-b6b9-0df2-f14125be22ac@microchip.com>
 <20190517211336.GB7685@piout.net>
In-Reply-To: <20190517211336.GB7685@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0267.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::15) To CY4PR11MB1543.namprd11.prod.outlook.com
 (2603:10b6:910:c::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190520115408312
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4bc19ab6-07b4-436e-0df7-08d6dd00c15c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:CY4PR11MB1800;
x-ms-traffictypediagnostic: CY4PR11MB1800:
x-microsoft-antispam-prvs: <CY4PR11MB18000F61532B379B8F72805B87060@CY4PR11MB1800.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(346002)(396003)(136003)(52314003)(199004)(189003)(81166006)(81156014)(7736002)(8676002)(305945005)(68736007)(4326008)(66946007)(66476007)(31696002)(66556008)(73956011)(64756008)(186003)(26005)(66446008)(3846002)(6116002)(53936002)(36756003)(6246003)(6512007)(99286004)(66066001)(6436002)(31686004)(6486002)(446003)(316002)(6916009)(8936002)(102836004)(229853002)(54906003)(76176011)(52116002)(486006)(25786009)(53546011)(11346002)(2616005)(2906002)(476003)(6506007)(386003)(14454004)(14444005)(256004)(478600001)(71200400001)(71190400001)(72206003)(86362001)(5660300002)(4744005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1800;H:CY4PR11MB1543.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: W5Z+npApKFj2jjjVwZYP/pR3I+kyuhPWDuJDyxX2iBt3SwzTZ/QMCwAasIpU9zBzQg9GbLfE+oSb39JdCOGExHoRDLVS57YNS84g8bapOD8w9zByZpBk9wgcUrcVVkpZo0jFxCkJ/45TJOKhBJzyJ8wxyBw742djUxBGh+xrMR/udf3fhZoyuLWHZ/hZm4kc3E2CfDZ6T8CEvZ3LXFEngo/YpjXcda2C3aNUrHgJJFbtfroObhkwDCW3ii39yH2L67zKSNOV4s0bQTz9bWs5K9Vj+iIjDAelXC/rph+xo/G3ci9d2OQdaRBxJSuU7nMCwqFiwL5zUK+WikIdXG/UCw/7LmEeEUTaLG9RqMLCg9f21dL7fyRfss7lw0o0Yud6ygwLEam62W9QC1bCAeBdFlWSwAxf/OsxeE5+7Qp9kQw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17043DB5617E724DA7B445DF92546F4F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc19ab6-07b4-436e-0df7-08d6dd00c15c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 08:54:24.5868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1800
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE4LjA1LjIwMTkgMDA6MTMsIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiBFeHRl
cm5hbCBFLU1haWwNCj4gDQo+IA0KPiBPbiAxNi8wNS8yMDE5IDA4OjEwOjM0KzAwMDAsIENsYXVk
aXUuQmV6bmVhQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pj4+IEBAIC02OSwxMCArODAsMTEgQEAg
c3RhdGljIGludCBjbGtfc2xvd19vc2NfcHJlcGFyZShzdHJ1Y3QgY2xrX2h3ICpodykNCj4+Pj4g
IAl2b2lkIF9faW9tZW0gKnNja2NyID0gb3NjLT5zY2tjcjsNCj4+Pj4gIAl1MzIgdG1wID0gcmVh
ZGwoc2NrY3IpOw0KPj4+PiAgDQo+Pj4+IC0JaWYgKHRtcCAmIChBVDkxX1NDS0NfT1NDMzJCWVAg
fCBBVDkxX1NDS0NfT1NDMzJFTikpDQo+Pj4+ICsJaWYgKHRtcCAmIChBVDkxX1NDS0NfT1NDMzJC
WVAob3NjLT5iaXRzKSB8DQo+Pj4+ICsJCSAgIEFUOTFfU0NLQ19PU0MzMkVOKG9zYy0+Yml0cykp
KQ0KPj4+DQo+Pj4gSSBzdGlsbCBmaW5kIHRoYXQ6DQo+Pj4NCj4+PiAJaWYgKHRtcCAmIChvc2Mt
PmJpdHMtPmNyX29zYzMyYnlwIHwgb3NjLT5iaXRzLT5jcl9vc2MzMmVuKSkNCj4+Pg0KPj4+IHdv
dWxkIGJlIHNob3J0ZXIgYW5kIGVhc2llciB0byByZWFkIGFuZCBzdGlsbCBmaXRzIG9uIG9uZSBs
aW5lLg0KPj4NCj4+IEFncmVlLCBidXQgSSB0aG91Z2h0IHRvIHVzZSB0aGUgc2FtZSBpbnRlcmZh
Y2UgZXZlcnl3aGVyZS4gQW55d2F5LCB0ZWxsIG1lDQo+PiBpZiB5b3Ugd2FudCB0byByZXNlbmQg
d2l0aCB0aGVzZSBjaGFuZ2VzLg0KPj4NCj4gTXkgY29tbWVudCBhcHBsaWVzIHRvIGFsbCB0aGUg
QVQ5MV9TQ0tDXy4qKCkgbWFjcm9zLiBJIGRvbid0IGZlZWwgdGhhdA0KPiB0aGUgbWFjcm9zIG1h
a2UgdGhlIGNvZGUgY2xlYXJlciwgYWNjZXNzaW5nIGJpdHMtPmNyXy4qIGlzIHNlbGYNCj4gZG9j
dW1lbnRpbmcgZW5vdWdoIChhbmQgbWFrZXMgdGhlIGNvZGUgc2hvcnRlcikuDQoNCk9LLCBJJ2xs
IHNlbmQgYSBuZXcgdmVyc2lvbiB0YWtpbmcgdGhpcyBpbnRvIGNvbnNpZGVyYXRpb24uDQoNCj4g
DQo=
