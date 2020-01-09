Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C0CC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BB82072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="S/8njTB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbgAIM3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 07:29:35 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:62202 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729237AbgAIM3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 07:29:35 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: Jw2Yac/RHQRu+fSVQd4/IVshS6pjnlskp8KJ/L6ZSMtnBC9v0P/tYt58cuaaVCT/Y5G0QZLWIc
 d1DtO4gbLVp+Y8DMGvHhZmeEm5z/3u94EgKtMzlHneOCLrNI9sTa1Oj5UAmapWP3pPiOJO0lfP
 rrzyZH8y478w7nMiQPtwpvzmPvt3n/EoNcAHaMjis1o9msGexEisLPWF5u5j8dlYD1KTwTyiVI
 DuhfcuKuQQYspoRUOu67kuZf5lKqIopMHddmaFPjEiOp9xPpVhcl/UQtZNegAKYLE8ShMNibxO
 Nkg=
X-IronPort-AV: E=Sophos;i="5.69,413,1571727600"; 
   d="scan'208";a="64169416"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jan 2020 05:29:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 9 Jan 2020 05:29:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 9 Jan 2020 05:29:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfT/0OIJF/gP9DjuuOWT8WWsREQjOnM9BH1NT3XKODAyoRaR82OZ4uLn3nj/BQ8KYOTvd5FujXUG0q/Eq9gb9quGEBBtbuNvx+CKFsUR6aRinftelbY5y3rHXHM4iaiGJAAguEwpq4fapezXp02g3HVgYbs158fXVvGzHRvg0DrIOTVQ52/fn+B3b34lqq6DW2DT0ZwLDcgrtlIZ7RVs2Wcd13ZJWqc6058Rm2/eVf2ewP9++GM/JfNUuCD2CyCPzCOAM+VM1BCK5xJutrsv2ZfuTjHnkR2Yxfy/Rl9398TXGN1Dp4nT7+OAS+C1v3aU3Dt1tjsXyel9UsGdsMYiEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4BkpyPeJGcWfRs9+X2nhlkINnvhWoruQiAcdhZ9be8=;
 b=BpIW7DggGNCOP7oAhKGcrJHT/zuAmfsrVvh50PMMZBXpvMirSysd37VhAaok9LJyXnm4nGb0l93SJPAufthpO+4zKZh6ViP6OH3edh1SbbL+jne8ieAJ/LpIqjFAs7WfDLgmERrzYTpOb1WBQi1WTeoMEKUeKU5q383u+S7A1i53OmdKUNwrJHknURw/jZft1FA7OKeG400eDo8+9LjwHfQ/bbZcsjho1Ybr/r4FX3oAIwTxLq2wHv9VXUJcqbCn/ixDOweApHqbrypHly4hsy959P8rYMHuJt1MUSq5uVxeMSkofqeW65S2R/HBSeKJb9aOlT2/6qfcHTITroyB5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4BkpyPeJGcWfRs9+X2nhlkINnvhWoruQiAcdhZ9be8=;
 b=S/8njTB0yrrhhEnp+wtA2K8eXpUxgZ0jDrFr8wN3W5HVY2D9uOl3fvO1fRvps3ddqEbfEPH9cXPN/wr+ipm4BsNErj181T/ayhEcjEs9oOWdVX/65AMUlDPBWTPyMmifcHjmMr/MV3H+eTxHUQS/e7X/x6J8GIUmUjGBcbSoZl4=
Received: from DM6PR11MB3225.namprd11.prod.outlook.com (20.176.120.224) by
 DM6PR11MB4361.namprd11.prod.outlook.com (52.132.250.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 9 Jan 2020 12:29:32 +0000
Received: from DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::106f:424f:ac54:1dbb]) by DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::106f:424f:ac54:1dbb%7]) with mapi id 15.20.2623.008; Thu, 9 Jan 2020
 12:29:32 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clocksource/drivers/timer-microchip-pit64b: fix sparse
 warning
Thread-Topic: [PATCH] clocksource/drivers/timer-microchip-pit64b: fix sparse
 warning
Thread-Index: AQHVxuhw55hpJ7sylE+omp5VUHJiIg==
Date:   Thu, 9 Jan 2020 12:29:32 +0000
Message-ID: <4e71d1f3-f28a-1c34-3869-bc24b7caad32@microchip.com>
References: <1578304688-14882-1-git-send-email-claudiu.beznea@microchip.com>
 <362407a3-036a-c38d-1dc4-2730d616592b@linaro.org>
In-Reply-To: <362407a3-036a-c38d-1dc4-2730d616592b@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dee9539b-9200-4ece-d9a5-08d794ff9465
x-ms-traffictypediagnostic: DM6PR11MB4361:
x-microsoft-antispam-prvs: <DM6PR11MB43611F226ECBAB67ECAF24BF87390@DM6PR11MB4361.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:220;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(39860400002)(136003)(189003)(199004)(6506007)(53546011)(478600001)(66556008)(64756008)(66476007)(76116006)(66946007)(2906002)(36756003)(91956017)(66446008)(6486002)(4326008)(81156014)(81166006)(8676002)(6512007)(8936002)(316002)(31686004)(110136005)(2616005)(31696002)(86362001)(186003)(5660300002)(71200400001)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB4361;H:DM6PR11MB3225.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k8rYPlrVe2BlgjlfOYoZXNOuEpLw+hnROLjf+fkuMwYHhOY9yy6/iCUL/z1NJetjXuqfF6rL3kGnYkNS+MQ2NZoNYnRVYxo0RYsiyDSlE6TMfsbXvcvR2u4ruyjHv3xli1+wuGnbyIeDc7ccGQXkE9NsgONUSrypNCBbQ6WL7RCLAMnuYPejMUHAj8kH0qg+BXhsJMOxCUw3hjec/vAJoerFGUp3eN3MlBOvnVqMSV8gFwAdDgIcipfbl93+7YPy7ne8QlxNvl5y1AC/QMr1ozljs7n2G9ufPRwfQQBAdJDnNcMbtptyTXpcY3lCTPkCFGuVM5btiB2mQrFZNPicdBViZOwaX74nOgoqUaVYy1OFgOePn+1iZ5E1sJywomjfIdqZmBkeYNU1BJG++n0a9Ig6rZBrUIxwavyg0BSr2+ut96vloAwCRNvOi0foaSy+gl6crWh/wCcwh3j2UKQUoa5oRj6hLWObt3rj2TaW5hca3ud4Q3XluZaPOddHUrxP6/G7A/l7QhhXPW9IZs28ng==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA96E6D9B07F5E4C9E792AD45C3B3489@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dee9539b-9200-4ece-d9a5-08d794ff9465
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 12:29:32.2909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ONNtdIBNAYzGpXLB+Nh5VKc8l7gEcEwCVWdD+mIwfre1QewRmpH7lDCc9crKt1hnUwN9JCrNsM9Fig+VI4I81sjyoCZNOB/ElVgWhXDs9ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4361
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA5LjAxLjIwMjAgMTM6NTksIERhbmllbCBMZXpjYW5vIHdyb3RlOg0KPiBPbiAwNi8w
MS8yMDIwIDEwOjU4LCBDbGF1ZGl1IEJlem5lYSB3cm90ZToNCj4+IEZpeCBzcGFyc2Ugd2Fybmlu
Zy4NCj4gDQo+IE1pbmQgdG8gZ2l2ZSB0aGUgd2FybmluZz8NCg0KU29ycnksIGlzIHRoaXMgb25l
OiAid2FybmluZzogVXNpbmcgcGxhaW4gaW50ZWdlciBhcyBOVUxMIHBvaW50ZXIiLg0KDQpXb3Vs
ZCB5b3UgbGlrZSBtZSB0byBzZW5kIHYyIHVwZGF0aW5nIGl0IHdpdGggdGhlIHdhcm5pbmc/DQoN
ClRoYW5rIHlvdSwNCkNsYXVkaXUgQmV6bmVhDQoNCj4gDQo+PiBSZXBvcnRlZC1ieToga2J1aWxk
IHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJl
em5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMv
Y2xvY2tzb3VyY2UvdGltZXItbWljcm9jaGlwLXBpdDY0Yi5jIHwgNCArKystDQo+PiAgMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLW1pY3JvY2hpcC1waXQ2NGIuYyBiL2RyaXZl
cnMvY2xvY2tzb3VyY2UvdGltZXItbWljcm9jaGlwLXBpdDY0Yi5jDQo+PiBpbmRleCAyN2EzODlh
N2UwNzguLmJkNjNkMzQ4NDgzOCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvY2xvY2tzb3VyY2Uv
dGltZXItbWljcm9jaGlwLXBpdDY0Yi5jDQo+PiArKysgYi9kcml2ZXJzL2Nsb2Nrc291cmNlL3Rp
bWVyLW1pY3JvY2hpcC1waXQ2NGIuYw0KPj4gQEAgLTI0OCw2ICsyNDgsOCBAQCBzdGF0aWMgaW50
IF9faW5pdCBtY2hwX3BpdDY0Yl9pbml0X21vZGUoc3RydWN0IG1jaHBfcGl0NjRiX3RpbWVyICp0
aW1lciwNCj4+ICAgICAgIGlmICghcGNsa19yYXRlKQ0KPj4gICAgICAgICAgICAgICByZXR1cm4g
LUVJTlZBTDsNCj4+DQo+PiArICAgICB0aW1lci0+bW9kZSA9IDA7DQo+PiArDQo+PiAgICAgICAv
KiBUcnkgdXNpbmcgR0NMSy4gKi8NCj4+ICAgICAgIGdjbGtfcm91bmQgPSBjbGtfcm91bmRfcmF0
ZSh0aW1lci0+Z2NsaywgbWF4X3JhdGUpOw0KPj4gICAgICAgaWYgKGdjbGtfcm91bmQgPCAwKQ0K
Pj4gQEAgLTM2MCw3ICszNjIsNyBAQCBzdGF0aWMgaW50IF9faW5pdCBtY2hwX3BpdDY0Yl9kdF9p
bml0X3RpbWVyKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSwNCj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgY2xrZXZ0KQ0KPj4gIHsNCj4+ICAgICAgIHUz
MiBmcmVxID0gY2xrZXZ0ID8gTUNIUF9QSVQ2NEJfREVGX0NFX0ZSRVEgOiBNQ0hQX1BJVDY0Ql9E
RUZfQ1NfRlJFUTsNCj4+IC0gICAgIHN0cnVjdCBtY2hwX3BpdDY0Yl90aW1lciB0aW1lciA9IHsg
MCB9Ow0KPj4gKyAgICAgc3RydWN0IG1jaHBfcGl0NjRiX3RpbWVyIHRpbWVyOw0KPj4gICAgICAg
dW5zaWduZWQgbG9uZyBjbGtfcmF0ZTsNCj4+ICAgICAgIHUzMiBpcnEgPSAwOw0KPj4gICAgICAg
aW50IHJldDsNCj4+DQo+IA0KPiANCj4gLS0NCj4gIDxodHRwOi8vd3d3LmxpbmFyby5vcmcvPiBM
aW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MNCj4gDQo+IEZv
bGxvdyBMaW5hcm86ICA8aHR0cDovL3d3dy5mYWNlYm9vay5jb20vcGFnZXMvTGluYXJvPiBGYWNl
Ym9vayB8DQo+IDxodHRwOi8vdHdpdHRlci5jb20vIyEvbGluYXJvb3JnPiBUd2l0dGVyIHwNCj4g
PGh0dHA6Ly93d3cubGluYXJvLm9yZy9saW5hcm8tYmxvZy8+IEJsb2cNCj4gDQo+IA==
