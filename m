Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D895C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1786C233FF
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="PSS6ARUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfH3HQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:16:15 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:49195 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfH3HQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:16:14 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 7WEKOwVZLtxPerzVZsPZA+G/AHqFTyAwOLeI0TyyoXgdB41o/jj0oj5ILcPNTFdnLKLmB440ZW
 yCEBaAsJ62loqXytaMsmA5bWywVWH0X6lLNNzItIsnvte2e612JHCrI357647FRZNG7R2BRvb2
 ibZtA7XC/7JfVrhW6iJLhB1tBqm5XtHUeSZfTNYqX84q0ut59OwxjsCsRNu1olMHoiZ92vL2xW
 mzMe/csJD3MTFlpjn7qWz5v1AM2UgFSuhup3jG0xXc7fzvHxjYlA3oh49z9FYuDwiDphD0LOvS
 Kss=
X-IronPort-AV: E=Sophos;i="5.64,446,1559545200"; 
   d="scan'208";a="48616412"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2019 00:16:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 30 Aug 2019 00:16:12 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 30 Aug 2019 00:16:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJk8tQ6QaPjA2sAYjXaGuqcICQQIqUvadjxTzoPBANBsk7Yk3de/UwSCgPoZGA1DtMC1t9VrEigWBZ1Z0X4roQvBhj6Omls9Dgth8gghVI7xyW5NfCt/+QvfY2AYV1hlZPpr4tKOy7DbZCvMPU/H5Kq0UstDl4Z129bkuObgsVCHOJRfOWXWspYUVWUVcKHTnry9KRavaCQ68nKoHwT7jmczKIFuwSOmD43Ma3uK8y3/uchy8eNFaDbt0eaXLXpuaI+FYP4vx33LkrkfEYksnMtOvosL+STFDjiAe3q9WWFfomsih53AoZWJE+cH+7fAxpcVCeWoNiayZPgyVRbRFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpAKWpWXCgxdYQxCvMFaaQd/99azXb3kIgdnRp7cEFY=;
 b=O+yN6vEid7rKE4FRYU3rwywVjgxwv4eD/bf6nYYUwZv67FF0q4HNZIuLvonlD6v9qn4IWoG86ErQhPGjEmb6tJhMef1x3OKKdwCpPByzJ5rkwNzeI0spknQ82HjHr71p/cCugAp6hyzfy1qqKYXmlCpl/JW5CrEkgZC1ySF4/SC8RuXzeqCYnxJFZz6R0xVxmn2c1orC62pSxIv5rSxxAY+G+VJzVWcgo6ZNG/v+TWQHWWywJgpyj6P/cZjXpbNp3n5+5NHkQYoUMPgG+iDfUmA47BZXA4kEy/qyY3Z17iihryNDvDwcfLXMknRRbQm1dzYXaqFjwQtqBR/8Ewiorg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpAKWpWXCgxdYQxCvMFaaQd/99azXb3kIgdnRp7cEFY=;
 b=PSS6ARUbesd0CurnjvHXt+709H88zCiTh6ncpWnou2bYJpk+xZuyur7SJpI9iMouMCRNJV2r8TvneDDe+lNn3sntwNgzLRgd60Qb1d5v62zecg2zH+YDmy4aJYdzWXXS50Mx4bnmH2C2imCLaSTeIxkkCH5naIL1vqhjRN/xiGw=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3583.namprd11.prod.outlook.com (20.178.250.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Fri, 30 Aug 2019 07:16:10 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Fri, 30 Aug 2019
 07:16:10 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Ashish.Kumar@nxp.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <kuldeep.singh@nxp.com>
Subject: Re: [PATCH v4] mtd: spi-nor: Rename n25q512a to mt25qu512a(n25q512a)
Thread-Topic: [PATCH v4] mtd: spi-nor: Rename n25q512a to mt25qu512a(n25q512a)
Thread-Index: AQHVXmJrKLsGvTkXLUmH+yAw5Ce1FKcTSMuA
Date:   Fri, 30 Aug 2019 07:16:10 +0000
Message-ID: <f8e546e3-c175-33e8-f691-963a75fae2f4@microchip.com>
References: <1567080445-32695-1-git-send-email-Ashish.Kumar@nxp.com>
 <1567080445-32695-2-git-send-email-Ashish.Kumar@nxp.com>
In-Reply-To: <1567080445-32695-2-git-send-email-Ashish.Kumar@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0019.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:d0::29) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8748605-6afb-424e-8d09-08d72d19eef5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3583;
x-ms-traffictypediagnostic: MN2PR11MB3583:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR11MB35835ED5CBA048C6D6540559F0BD0@MN2PR11MB3583.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(376002)(346002)(39860400002)(199004)(189003)(31696002)(99286004)(6486002)(316002)(53546011)(6506007)(36756003)(54906003)(52116002)(31686004)(76176011)(6436002)(53936002)(102836004)(110136005)(2501003)(386003)(64756008)(4326008)(66556008)(66446008)(25786009)(66476007)(66946007)(256004)(14444005)(6512007)(26005)(186003)(229853002)(476003)(6306002)(486006)(8936002)(81166006)(2616005)(11346002)(2201001)(3846002)(6246003)(6116002)(71200400001)(71190400001)(305945005)(4744005)(7416002)(966005)(7736002)(5660300002)(2906002)(86362001)(14454004)(446003)(66066001)(8676002)(478600001)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3583;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nNL4SXdknwuugaA3nEsgvGAZJ4c6ckQFmbwKsU+R/FauZGEUD7gAuYcS1Jdvk3gsDs9RvIQHu5rqkMtqDQ/YfQaTooYkInKg7N2F+NAuPCtpZ+JEPL6MKLc/tPUZXjZ1oHHW84J2kianKf5cbznAnnF9nF8O3qIQ1ssdSc3XQjvSupd4WpSFdVAFDmliQyzocS4rg90ITOGrLo0/i+B7Ry3/y9XuGPSTvDO/Q7mnlQsGrwgVapLQt1BnYMht6DUanNLl4d1jegiqFWGdk/8q+s3vUJVvUbOk3NKPbmPuE3MHRX/x2Zbc43mq8gexUni4h/DEpRCIbgf7/EHmND7FmM2Z+y4+8irR1PdNQcOQnZ74xmfroSX4IddqcvVy54B81TRRNbafCkOeOQwId4k4/l1mcRZwPq8ikPHgBRjBbLQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <560C3BD64ADFEB43AFB83F6A598A5270@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f8748605-6afb-424e-8d09-08d72d19eef5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 07:16:10.3836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IpQt38IJmlje6+0zWtoNB341JPU9+BMFDPLISbGp6kil+bE+S0Mry+0P8R7zHKFmALXiTWJ1Hv7wyXiMXwuP8CaP4/tGXidXRnsdpoqQ9j0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3583
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzI5LzIwMTkgMDM6MDcgUE0sIEFzaGlzaCBLdW1hciB3cm90ZToNCj4gRXh0ZXJu
YWwgRS1NYWlsDQo+IA0KPiANCj4gbXQyNXF1NTEyYSBpcyByZWJyYW5kZWQgYWZ0ZXIgaXRzIHNw
aW5vZmYgZnJvbSBTVE0sIHNvIGl0IGlzDQo+IGRpZmZlcmVudCBvbmx5IGluIHRlcm0gb2Ygb3Bl
cmF0aW5nIGZyZXF1ZW5jeSwgSkVERUMgaWQNCj4gaXMgc2FtZSBhcyB0aGF0IG9mIG4yNXE1MTJh
Lg0KPiBTUElfTk9SXzRCX09QQ09ERVMgaXMgYXBwZW5kZWQgdG8gZmxhc2ggcHJvcGVydHkuDQo+
IFRoaXMgZmxhc2ggaXMgdGVzdGVkIGZvciBTaW5nbGUgSS9PIGFuZCBRVUFEIEkvTyBtb2RlIG9u
IExTMTA0NkZSV1kuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLdWxkZWVwIFNpbmdoIDxrdWxkZWVw
LnNpbmdoQG54cC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFzaGlzaCBLdW1hciA8QXNoaXNoLkt1
bWFyQG54cC5jb20+DQo+IFJldmlld2VkLWJ5OiBWaWduZXNoIFJhZ2hhdmVuZHJhIDx2aWduZXNo
ckB0aS5jb20+DQo+IA0KDQpSZW5hbWVkIGVudHJ5IHRvICJtdDI1cXU1MTJhIChuMjVxNTEyYSki
LCByZXdvcmRlZCBjb21taXQgbWVzc2FnZSwgb3JkZXJlZCBlbnRyeQ0KYnkgc2l6ZSwgZHJvcHBl
ZCBjb21tZW50IGFzIGl0IGxvb2tlZCByZWR1bmRhbnQgYW5kDQpBcHBsaWVkIHRvIGh0dHBzOi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L210ZC9saW51eC5naXQsDQpz
cGktbm9yL25leHQgYnJhbmNoLg0KDQpUaGFua3MsDQp0YQ0KDQo=
