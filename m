Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE4DC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A6B2339E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Ggu1XxpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfHUIXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 04:23:15 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:51071 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfHUIXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 04:23:14 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: dsh5QPBYQVrf0OwAHESPQmPZydB3hUG49C3GumX1zA+/ZIjym3yy6XjtsII6dY//HZSeJsf2Kz
 6HJlVji1y75kCFx7Yck0yScGP6mWCSqT+8KLRvLarN4ph3MWWkGoLBRBbE8jHYw6y2XsG4fjOE
 /8QDMuVnrjaXx7O03N6Nx22kkVQskwCajXrIj2hajufcu3QRa0IhaxCXB+AGzh2lP+k+6ephSv
 kkDhdS+LAy1w1noC/vcRyMKbUHVupQLDhJjwuY2mx3q+3L7oJ4xW1Ejy6nKT9ArZZ6RNmEMfui
 adg=
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="45065054"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Aug 2019 01:23:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 21 Aug 2019 01:23:11 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 21 Aug 2019 01:23:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZouI1wrlnc1WNgU1irslGI1lGMkdmyFZ/k8B8r+8ewfUuz++Kv88v4rqIYtkoftgWUxWFJesXjr8nlPpLuEdrZTLvJrZIZXBbKcs6N5Tm6Poy6doUHqZjXVn8VyAvpyTzQeYY0s6ZYZbxEX5txIuAvhZFAqb95iy35RLP3laRSVbfuhBtQvopz6CQavjuzV1PyYmwfK0M57Jf+eE3FXjAi6i4nACKnPAJ/aawtlzCGWcvAcxpsriHNvzH5DWsYi37yA+2/Vo2C4Fpf8NvJFASKUHHkxlbzuOGkWXrvN665lHX30TwYl+Fd/rSJlUt6kDYaUo63tdmEYZxn4QBMAblg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2ZIilzwuhVvvCMlTv00QyCAJm7o/8pb3I5Pr7iV37k=;
 b=mVAT2VCFpYrMTypqLNSo3XvISh7Abfdc9RAd/lSSgWLBtHE++T77fipZod4jSXoZazRD0F+8i7xUGNQ/BKfYpEhkXLJbCSNsQvF5Pq4x+/2ON2G13OnxSRTIVwTKRi56MjidF7Uwp1NolteyTQ0TBa87ymEcty4StaVGaNDns4m2Db5VdCX3IFWWjcuwjwHyNQhbpHmW+yLc9FZbgjMb7Y0r4TqKvNOJfT44gKUmgwt6hFPvj7AYftdVf8xQBZpmOh+23bdzBWws7dlqxcKcB3g2cJeMnlsbGk7saU+G1IhtbSEnsMkZ7tXNBI9dn/oXEtxpSCsSxVMOcm96F7zZTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2ZIilzwuhVvvCMlTv00QyCAJm7o/8pb3I5Pr7iV37k=;
 b=Ggu1XxpKlI5LQK5INm9HRLVq85YNagqFHSUzNuvVOb423ZIjG0jbdZL+hy4vccjeiqnMNiyLwYuq5fIJchvJyHweHX4eRBdChVNvJb+5bKMfQ5hEejlF1X2IUwJWr/iHyQOmlU9sNl7XXrOlCdod6VQYF/5pMSTxtZxR/XA1Odk=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3918.namprd11.prod.outlook.com (10.255.180.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 21 Aug 2019 08:23:09 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 08:23:09 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <wenwen@cs.uga.edu>
CC:     <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: spi-nor: fix a memory leak bug
Thread-Topic: [PATCH v2] mtd: spi-nor: fix a memory leak bug
Thread-Index: AQHVVrHa0wRKD5wwWEKewRQkNp25zacFReEA
Date:   Wed, 21 Aug 2019 08:23:09 +0000
Message-ID: <806348cd-2b4e-7ec8-3c32-889904c37200@microchip.com>
References: <1566234960-3226-1-git-send-email-wenwen@cs.uga.edu>
In-Reply-To: <1566234960-3226-1-git-send-email-wenwen@cs.uga.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0401CA0010.eurprd04.prod.outlook.com
 (2603:10a6:800:4a::20) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c206c96-df7a-4b4c-a3a1-08d72610ccc0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3918;
x-ms-traffictypediagnostic: MN2PR11MB3918:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR11MB391874EBA2E9F699393CEDA9F0AA0@MN2PR11MB3918.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(396003)(346002)(376002)(199004)(189003)(66446008)(66476007)(64756008)(102836004)(486006)(52116002)(8936002)(36756003)(446003)(2616005)(81156014)(316002)(81166006)(8676002)(6116002)(3846002)(31686004)(2906002)(26005)(966005)(11346002)(54906003)(76176011)(186003)(478600001)(71200400001)(71190400001)(14454004)(25786009)(66946007)(6306002)(53936002)(2171002)(6246003)(229853002)(99286004)(4326008)(476003)(5660300002)(6506007)(6486002)(386003)(6916009)(53546011)(256004)(66066001)(86362001)(6436002)(305945005)(7736002)(14444005)(4744005)(6512007)(66556008)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3918;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3GiAglKV2vvpJrVK17CvzuEUBzxr6/xg07k0C+4Vqq6LMqhc1U++AaYkXl1Y33HBIRKzFpgfhbQUtguFBn7CMQEuVskpTyyBpmuSjo9HYhhYY3tiQTV1CN7/9mQ4/6qFYwhNl2YU4U2kQJbP6uwLhF+6gjZCd6O+3SPscjysYyTSqefO273+beofny4ILF7+I+ou0o23nXCfu6/hCMX/EhkBcUa0udjPGae7GWFcedi/SNZdSWH9gL2f+MzBUNWEddj1k5r92vYYbpZ2YMJEmGH8unHR6z4CJEwohgpRa5LNx7DKpEq0Q1+IR4DayKVMWg23hKAzgwdwbaxXW2hNZGYyYrosyrAVMitSxIaTpmTDIYGm6vYdmPk/sQc3R/UrxvYTtTvWklGq1IuCGtgKOXWOlvpH3pD2GFQ8lNz4Y44=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A0357C8BA65A44A82D948A517426BCD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c206c96-df7a-4b4c-a3a1-08d72610ccc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 08:23:09.4932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4IIDUZBUdpVRunvz8kAdbfPfsBcA2vlbrBPOaM0iHyLKK4HP/CBYtnC7vejskGsj7pnuc0S/fMJK7/P6cBHtrtxHrZL+JC0Z52zuvQMhtsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3918
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzE5LzIwMTkgMDg6MTYgUE0sIFdlbndlbiBXYW5nIHdyb3RlOg0KPiBFeHRlcm5h
bCBFLU1haWwNCj4gDQo+IA0KPiBJbiBzcGlfbm9yX3BhcnNlXzRiYWl0KCksICdkd29yZHMnIGlz
IGFsbG9jYXRlZCB0aHJvdWdoIGttYWxsb2MoKS4gSG93ZXZlciwNCj4gaXQgaXMgbm90IGRlYWxs
b2NhdGVkIGluIHRoZSBmb2xsb3dpbmcgZXhlY3V0aW9uIGlmIHNwaV9ub3JfcmVhZF9zZmRwKCkN
Cj4gZmFpbHMsIGxlYWRpbmcgdG8gYSBtZW1vcnkgbGVhay4gVG8gZml4IHRoaXMgaXNzdWUsIGZy
ZWUgJ2R3b3JkcycgYmVmb3JlDQo+IHJldHVybmluZyB0aGUgZXJyb3IuDQo+IA0KPiBGaXhlczog
ODE2ODczZWFlZWM2ICgibXRkOiBzcGktbm9yOiBwYXJzZSBTRkRQIDQtYnl0ZSBBZGRyZXNzIElu
c3RydWN0aW9uDQo+IFRhYmxlIikNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFdlbndlbiBXYW5nIDx3
ZW53ZW5AY3MudWdhLmVkdT4NCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3Iu
YyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQ0KPiANCg0KDQpTaW5jZSB0aGUgYnVnIHdhcyBub3QgaW50cm9kdWNlZCBpbiB0aGUgcHJldmlv
dXMgcmVsZWFzZSBhbmQgd2UgYXJlIHF1aXRlIGxhdGUNCmZvciBtdGQvZml4ZXMsDQoNCkFwcGxp
ZWQgdG8gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbXRk
L2xpbnV4LmdpdCwNCnNwaS1ub3IvbmV4dCBicmFuY2guDQoNClRoYW5rcywNCnRhDQo=
