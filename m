Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2486CC4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 05:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40BA21670
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 05:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="OTx9Nohw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392450AbfIQF7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 01:59:54 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:26585 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbfIQF7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 01:59:53 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: nfOkmiVO6pbt4I/bs2EkRIiW+8l1TnNxunJZiit8ja9NN3RvmKap0LTaeJxq0Lej95Ak9fQEQX
 KgfPSy875lPJWVWW0rulz8XWCiruC9zGo5dYbozGrFXFZyOd4Qqyd/coYrNtYIcTzHn1o9cJcC
 xuGKUejo0Rm8BO0TzjeQEgXQ0Hexi8f7U7b95TTqvI3r0j+ae6fylr+LeX+Fz5M0uYMWe4WZEx
 5/IC6PrCAMr2UcPIZEC7GEEUsrWBFOt3it79dIXiv2ivss0zBnm4xjJ4DyfNcK++dVDOfQif6o
 omk=
X-IronPort-AV: E=Sophos;i="5.64,515,1559545200"; 
   d="scan'208";a="47748416"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2019 22:59:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 16 Sep 2019 22:59:21 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 16 Sep 2019 22:59:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1jBJZE5wux5hg+EerKgo7s97B8QNfi6zfna0PnvVDklJXK8c7KvDnmyEPs5aNzn0y/YUSyhUcx4NqWESm7Y9Pf5Kd+HyKX3sItyatnVZs31UiJupqh1crnMvDzaJpbgVWjxxP2B0uTSjEGfwYv7MLtFf6/CTIc4SpBxXJyG4JjixGGgPDQlo2MMJ8bKMhVsnwmWvDI9BnT757+RorTWhweKXnTTv3hfGYSzJAXXpOQEFVlqdE5SPt/1bhWbvKAv3ZYcxv+7LH+YM0xuXbg4S6w00AKeQwZkyCzL1MnPCT9nWwboON3BsEKHdaS0vuAHK1hgg+KPh5/i+bTAVGVEOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQdSV+TV47ffXhcwBGGOQ+AmEsHtpqsHoXMlhVUyDz8=;
 b=G9EzO7RXiLe+bxSJ447nwrW2qWE0a9kuE4chQ86vzfVhrw4yPAPZXLDBkBJnYfafOlun1uHLgN/mPiHSNa/rTI6yCsZn8vEsfG0El/QO1pSrTbSQHLEpS22zaSlwHuSoHz9iSx5jiWf8FMolfOUX9wsEoAI6cXleFPI+W1bV3WyM4zBtXNqMCrk0NvT+W7/YR1rDzX2Mh8G35V1kZDKdo7LPtYXkeYDvdCI9NW4dvWRGFx9VfMGIkljq1xrCro3AQ24UYHYXebbX8x4gcGgJBRhNI7fBnI+BqCi7jEskk6ZDvBHRA4np47mebZr12JK8GHBgvPDtXVrKwJOx18mwtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQdSV+TV47ffXhcwBGGOQ+AmEsHtpqsHoXMlhVUyDz8=;
 b=OTx9Nohw55HOiH1QAN/ciibCw4dXFbFmOcQSz/WJw7AObFVcexDeQg+lf5Atokd5cNl9wLjbW0kxufVScbH4/TnvW9rwlj1M4gkNVYQMVLZkr6zN5tx87T2ZmS20jGc6YZlYmSc/s5KsJ1BSd0H06a6b7LkCvwJWk3v/yyn+ANA=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB2028.namprd11.prod.outlook.com (10.168.104.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Tue, 17 Sep 2019 05:59:19 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::a141:1974:9668:fbe2]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::a141:1974:9668:fbe2%12]) with mapi id 15.20.2263.023; Tue, 17 Sep
 2019 05:59:18 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <sboyd@kernel.org>, <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mturquette@baylibre.com>
CC:     <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH] clk: at91: allow 24 Mhz clock as input for PLL
Thread-Topic: [PATCH] clk: at91: allow 24 Mhz clock as input for PLL
Thread-Index: AQHVaGukjPTRbry/ckGMFC3Lf3IeQKcuv8aAgACn8IA=
Date:   Tue, 17 Sep 2019 05:59:18 +0000
Message-ID: <dcae9812-5ae7-567f-0e84-b6166a7f7400@microchip.com>
References: <1568183622-7858-1-git-send-email-eugen.hristev@microchip.com>
 <20190916195246.CAE5C206C2@mail.kernel.org>
In-Reply-To: <20190916195246.CAE5C206C2@mail.kernel.org>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0130.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::23) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190917085349902
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c67d17a-35b2-41c0-27b7-08d73b342d99
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR11MB2028;
x-ms-traffictypediagnostic: DM5PR11MB2028:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB20288AD15618E0DB320D6B54E88F0@DM5PR11MB2028.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(39860400002)(396003)(376002)(189003)(199004)(66476007)(8676002)(5660300002)(81156014)(81166006)(66556008)(102836004)(66446008)(64756008)(229853002)(52116002)(66946007)(66066001)(476003)(4326008)(11346002)(14444005)(256004)(86362001)(386003)(2906002)(8936002)(6512007)(6506007)(71190400001)(71200400001)(76176011)(25786009)(2501003)(478600001)(6486002)(14454004)(186003)(3846002)(107886003)(4744005)(53546011)(2616005)(6436002)(446003)(6246003)(6116002)(316002)(31696002)(7736002)(305945005)(99286004)(110136005)(486006)(2201001)(36756003)(26005)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB2028;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CvAtTPr4oevRh2bh1bZnIOMIF+yy3wCZGhSSoRdOI4qsP2Aaj8Nyx6opVg9AMDJtSQzXTF4vdibqA+ucwwMqcx5PJsusDJxQ72zcRLeNekq7whJTYCDNEimonsFn661c8P2BOZquzzrkjEwRZfBArBl68Lr+WeVQ/ggx6a+RzWnO1PVa4GYppvnZ5PlavNNSMAgxTintVLRudEly7qLHnt9KWOklw+0s4caEi1tw4UEuoGPT4VcsioVxlLeQW8miLnuQESFW1kZLNkgsR2/p6tFZM4jIAHaZ00MxcoCgdpeIenZkebGMcRukxG9+W9LUBwLSTamJ7Y49IRt4MrqFcJu5pRQAj5aqpOuncI/oMIqriCEIvObuOzUefohExzoWzLMu5q+ex9yDS7aNKLtxVE8frnbetub3D27aQ6JGVsc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4200A97683E0924CB8E43E43A25EBC99@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c67d17a-35b2-41c0-27b7-08d73b342d99
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 05:59:18.8523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B1x8ZcXp/X7ouSknIbbQseoe6kD97S2/mrgjs3NiLBmyH5TUTLYwixraA3U11CLdLc4qfsd/JcCWnr6VbzMumg7UNVyEVqiE3SvJjrRx01Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB2028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE2LjA5LjIwMTkgMjI6NTIsIFN0ZXBoZW4gQm95ZCB3cm90ZToNCg0KPiBRdW90aW5n
IEV1Z2VuLkhyaXN0ZXZAbWljcm9jaGlwLmNvbSAoMjAxOS0wOS0xMCAyMzozOToyMCkNCj4+IEZy
b206IEV1Z2VuIEhyaXN0ZXYgPGV1Z2VuLmhyaXN0ZXZAbWljcm9jaGlwLmNvbT4NCj4+DQo+PiBU
aGUgUExMIGlucHV0IHJhbmdlIG5lZWRzIHRvIGJlIGFibGUgdG8gYWxsb3cgMjQgTWh6IGNyeXN0
YWwgYXMgaW5wdXQNCj4+IFVwZGF0ZSB0aGUgcmFuZ2UgYWNjb3JkaW5nbHkgaW4gcGxsYSBjaGFy
YWN0ZXJpc3RpY3Mgc3RydWN0DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogRXVnZW4gSHJpc3RldiA8
ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+IA0KPiBJcyB0aGVyZSBhIEZp
eGVzOiB0YWcgZm9yIHRoaXM/IFNlZW1zIGxpa2UgaXQgd2FzIGFsd2F5cyB3cm9uZz8NCj4gDQoN
CkhpIFN0ZXBoZW4sDQoNCkF0IHRoZSBpbml0aWFsIGRlc2lnbiAsIHRoZSAxMiBNaHogd2FzIHRo
ZSBvbmx5IHBvc3NpYmlsaXR5IGZvciB0aGUgDQpib2FyZHMgdGhlbXNlbHZlcy4gQnV0LCB3aXRo
IHRoZSBjb21taXQgd2hvIGFkZGVkIHRoaXM6DQoNCkZpeGVzOiBjNTYxZTQxY2U0ZDIgKCJjbGs6
IGF0OTE6IGFkZCBzYW1hNWQyIFBNQyBkcml2ZXIiKQ0KDQpFdWdlbg0K
