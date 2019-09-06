Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3A0C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41DC2067D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="NpxPO6xF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733080AbfIFPKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:10:44 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:19299 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfIFPKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:10:42 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: DAk/L6SSebespZNlsGdz1NH/xSRIIqRI1WBh6x8lKKQNfmDPXutg5lmS7O5nW9EozdlR9ul4uj
 T3SkirDlqwYgW/5pnN9jqUtgkSdCVDAg3c73h651oQBYoviLLj2bbHEGHivaRO7ndWfcwAQBG3
 Vjk6pmrWF8IIUJsVRcJYEkJVPHMzWFFKUlJoszP3B+zwzVonqqu5QITkfl5K09HI4p8GYS+51l
 epgr0y8wOUz3WS21eTzGtHosf9eUdYiv+wMLPFyIlxPTRIsY0200Kwey0ae7qIQWXkV6n/O9AJ
 myk=
X-IronPort-AV: E=Sophos;i="5.64,473,1559545200"; 
   d="scan'208";a="46511055"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Sep 2019 08:10:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 6 Sep 2019 08:10:38 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 6 Sep 2019 08:10:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeg5m2fMAe38Jn28/m/m3+IH/TgXM070j1xw54SmNIdYgmaXhdCiCRmXQBwzi6enw2Tutkz8ZA0fRt38FGhGTqhOlMk6yQE5IDwwtdpsWYqXVkfH4OMaeTyjrp9j/BeqbniyVJn1P76QYmles2OHDIGAmPz1aRk1amajp+596W0z07gxo4GDTG4jUnOQ34jkwUMGb70Bf8N/JXHKJEs/pgmWhkIQAbl+D8wjnerXRnxbvqy/F+SjcEimCW7EaDGXSaMxcQ3utFYuqi2zvaRnaz5YaoqunR4KYO3wKfkbMxtQ8mDcK5fBIPKPpboqlxvK9hKpNXhizhc29hPUgpMLLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0u2eTlLq1mFFgzRtjealeYUTQnH/Y2Y8v4pMrte1mNM=;
 b=RrC74kmFskwIyM2DPPiwDjzc8dSAOHqyF7AAdGVE15ounxqAwg0cvqgAYtCp/shSrUO3dC84Epfj6p44zP7psOrzIX5UfaILtYww53uTaxBjX9CmNrJWltgICXOLaNxjmJ1OlEmT0EgasUVbt/yzNbE+ZuGOaCdjq0V3bj7wQ3p2uDO2iLL5Gdd9MbW+0Y2CKj371yec+IBK4YAUiw22hyYD/r4bv3nAGEfQuQu5gKd9trVPpidn6IaOI7fXsbd5B3Hy5SeJ8nNmAV/TvIfjtIcBErFztfXFKVMx/on4XSSVAHSNA45lkuq3Hv7YsNpCw/sxwgmZIaqhgB0KQdEp+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0u2eTlLq1mFFgzRtjealeYUTQnH/Y2Y8v4pMrte1mNM=;
 b=NpxPO6xF/aNSFAM2nwgcEnRQNlHaVAo7tWVvZ2Nh4w6vaAq1x6SjY0m6pbL/xb1Lf+TlzEedxmQF0Ub6sW2MB/ARCuXSN5ULXPN0I8mjUYFt3IC6wRvwf5MVqL+eFHL6pBssbaH6+/wbrS+JWBTfPS6l/sDhc5b052cMzjy8EnM=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3567.namprd11.prod.outlook.com (20.178.251.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Fri, 6 Sep 2019 15:10:36 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2220.024; Fri, 6 Sep 2019
 15:10:36 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <corbet@lwn.net>, <john.garry@huawei.com>
CC:     <mchehab+samsung@kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <frieder.schrempf@kontron.de>
Subject: Re: [PATCH] docs: mtd: Update spi nor reference driver
Thread-Topic: [PATCH] docs: mtd: Update spi nor reference driver
Thread-Index: AQHVTHFBYGyfjvOGF0mQIXams2iiIqce7HEAgAAB0ICAAAFTgIAAAfMA
Date:   Fri, 6 Sep 2019 15:10:36 +0000
Message-ID: <2dc3eed5-95fd-b144-5cee-676b1c95d5b4@microchip.com>
References: <1565107583-68506-1-git-send-email-john.garry@huawei.com>
 <20190906085212.79ec917c@lwn.net>
 <9110efc4-35e6-ff04-1a6d-d5d9f93927de@huawei.com>
 <20190906090325.330a5945@lwn.net>
In-Reply-To: <20190906090325.330a5945@lwn.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0123.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::25) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1187d6d2-795e-4bb6-ec9f-08d732dc5f02
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3567;
x-ms-traffictypediagnostic: MN2PR11MB3567:
x-microsoft-antispam-prvs: <MN2PR11MB35675E8EE6E467FDDFAE9294F0BA0@MN2PR11MB3567.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(346002)(366004)(396003)(199004)(189003)(86362001)(6436002)(71190400001)(71200400001)(305945005)(31696002)(7736002)(14454004)(478600001)(4744005)(2906002)(25786009)(81156014)(8676002)(81166006)(4326008)(6116002)(3846002)(6512007)(53936002)(6246003)(8936002)(446003)(2616005)(486006)(11346002)(66446008)(66946007)(64756008)(66476007)(66556008)(476003)(36756003)(26005)(66066001)(256004)(5660300002)(31686004)(110136005)(102836004)(76176011)(52116002)(53546011)(386003)(99286004)(6506007)(54906003)(6486002)(229853002)(316002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3567;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: babtXVLRQDysNVtvenh3toVYjITyhbNeN1F97WTW1knqO2AQ/VmWWSMGX6i4i/k08QypzM1od4QGMuwXXs+SwWUZBgkRCWg2LhpO6hZl/hj0nTQ1icGGD6qm//kNjl47Hx8vYGKkE7z0xBfiTWX0VoOEaTsW1dIVxu71DGHIPHQCZqJJ6wm3L9PBHuAGFCv01xMuswtjuLfnerZgBd2I8iYbuNdf4lNF4Z9ykhifOr2GdORlyynEp/oHz9OdONR+CL7STgwAwsQoptjpEakYjq//RNyz4uXf229oYJ1F01Vq8Zn5s8qvuVeCx2Q1Q7o77NTHOOyL/Zretn8nns9OLETlQ63ti6Q2PKSe4ex9bhvaZ4MRM6JZt8K0bnevwnCi0VJ4cxZq3/WFjX+4mXAXVef8VAQoQy+ZCvD7k/dYvZs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A2E6BE809684E4BA98F5FD647A61305@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1187d6d2-795e-4bb6-ec9f-08d732dc5f02
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 15:10:36.5984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GAOOXUS6rJIvc/6jE67YiUzDlieZ1946xKzDwjkCOHPTHAKTwa6OU8PtyDTeoheFJICWnnF47AH3ocy1TwNVHMMCgoKa6cC/13r7WIjuZMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3567
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA5LzA2LzIwMTkgMDY6MDMgUE0sIEpvbmF0aGFuIENvcmJldCB3cm90ZToNCj4gT24g
RnJpLCA2IFNlcCAyMDE5IDE1OjU4OjQxICswMTAwDQo+IEpvaG4gR2FycnkgPGpvaG4uZ2FycnlA
aHVhd2VpLmNvbT4gd3JvdGU6DQo+IA0KPj4gSSBkb24ndCB0aGluayB0aGF0IGl0IHdhcyBhcHBy
b3ByaWF0ZSB0byBhcHBseSB0aGlzIHBhdGNoIGluIHRoZSBlbmQgLSANCj4+IG1heWJlIHRoaXMg
Y291bGQgaGF2ZSBiZWVuIGNvbW11bmljYXRlZCBiZXR0ZXIuIElmIHlvdSBjaGVjayB0aGUgDQo+
PiBzdWJzZXF1ZW50IGRpc2N1c3Npb24gaW4gdGhpcyB0aHJlYWQsIGl0IHNlZW1zIHRoYXQgY29t
cGxldGVseSBuZXcgDQo+PiBkb2N1bWVudGF0aW9uIGlzIHJlcXVpcmVkOg0KPj4NCj4+ICJBY3R1
YWxseSBpdCBzZWVtcyBsaWtlIHRoZSB3aG9sZSBmaWxlIGlzIG9ic29sZXRlIGFuZCBuZWVkcyB0
byBiZQ0KPj4gcmVtb3ZlZCBvciByZXBsYWNlZCBieSBwcm9wZXIgZG9jdW1lbnRhdGlvbiBvZiB0
aGUgU1BJIE1FTSBBUEkuIg0KPj4NCj4+IEJ1dCBub3RoaW5nIHNlZW1zIHRvIGJlIGhhcHBlbmlu
ZyB0aGVyZS4uLg0KPiANCj4gQWgsIE9LLCBJIGxvc3QgdHJhY2sgb2YgdGhhdCBzb21ld2hlcmUg
YWxvbmcgdGhlIHdheS4NCj4gDQo+IFVubGVzcyB5b3Ugb2JqZWN0IEknbGwgbGVhdmUgaXQgYXBw
bGllZCwgaXQncyBub3QgZ29pbmcgdG8gZG8gYW55IGhhcm0sDQo+IG1ldGhpbmtzLg0KPiANCg0K
V2UgY2FuIHJld29yayB0aGUgZG9jdW1lbnRhdGlvbiBvbiB0b3Agb2YgdGhpcywgbm8gd29ycmll
cy4NCg0KQ2hlZXJzLA0KdGENCg==
