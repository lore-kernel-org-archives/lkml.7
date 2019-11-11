Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AD0C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 06:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4AA21855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 06:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="pPXxx5Bi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfKKGsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 01:48:32 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:18829 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfKKGsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 01:48:31 -0500
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
IronPort-SDR: GvWwhRdk7ZR3lde85jJLPbgSMTA5KyS4wgnpWc9nQU6ZnOknePtqw88aFvNQWD31iwxYO8j8Zz
 B3b74YxiY94D7jE5Ok20BCbUJe80HhmYzTNeKXYNtqVyMcHdDh51tfNmoBcDyGUWi6OHhR+ZL1
 6SbSB2Ayt4N5DW6oeFSWPi5EpQiWvcFziIjqE8uNmSIgSTbT9a5L6PYaqs30J71zJlxg15Q6Q/
 B6glryGsoAASoK3QWHyvTzU/Fuuz7VhBqrCQLceM0QqYheeFGiE7dl7mxCaJfZVYlOSXlmzgJw
 U6Y=
X-IronPort-AV: E=Sophos;i="5.68,291,1569308400"; 
   d="scan'208";a="54904025"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Nov 2019 23:48:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 10 Nov 2019 23:48:30 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 10 Nov 2019 23:48:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xa1hxpBKbK8spcbyxALmXhhSf4pAXjyElJE8r3agKdPQvc67dK22VDcMJP7Vm7NJ6yiH3V39YtgodxH5y6ykxBJ9U42IKLMeEO1uXWzw9h8bQ3pOyTxGAlpvR/1NGoMYpzOHLI6pJf0Udl+zYcW3YbLOLJE2Mfk+xCZ4sGUhuyFQF6UTg5d/qnP/jF5ih43Ob0WmOJj/BCtdiT1mza1RVP2UuS8lkzE8O7kNPMa9c52E1PnFueNUvQzz8PRMcxh8PTyzOswNKrBg11L2DZI7NktYndFNaNDfT1/RM+KaXox1ltOrNrwtezXBp36iJfb9QrPn9et3Hn4tWgL23oMYjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rODKZftnHKkHaD2ufDvMIP6ewt3P7ywFW0FP+3bLS4Y=;
 b=eKmDIU1xJM4mktE3WOjrwS6e/5gKlXT9QGJTosxv0ZaGD+3AU/X2Z5pT96SVEBdL6jQSgjdowXoZoEurT3njqv7vzxFZCqfbLp9jXa/3Wo88Fg5T0FMaYvIdnOTCEqAwk7SEZjqLVVwNHCTjTbtP3cQEqYMqlez8lBil2w1xY99mXWGdTBIPCMoPFpP67tj+NNRL1GQ7EY+3NUZ4GC52tiZif2wUY5CIucoMftDWzBNQWHt9MTaiR98fuzlcs/kwqkVGsbFA3G5Z+SuN9lIeMHO7mVQl4vokgFcPjMz1+dGDpXLICHVhrEpI17Xg5DLhb0iq8jHFG9f640e/t0ms9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rODKZftnHKkHaD2ufDvMIP6ewt3P7ywFW0FP+3bLS4Y=;
 b=pPXxx5Bijd/UHWDsZugJa4e1G2o7QUGtqNPjmB/a9gaRjnACyUlCu0TyHlHS2uKR1z/vX+DGitd1OKRK5WB3E1Td16Qjwm+4oA2nYPjPjHvDl4TRZPbv52KKsqR9KCGHfuSjRqkLO39s/pYpnZyqDkwAnNWq4M9HnKrtRcOUuOU=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4045.namprd11.prod.outlook.com (20.179.149.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.23; Mon, 11 Nov 2019 06:48:28 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2430.023; Mon, 11 Nov 2019
 06:48:28 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <gch981213@gmail.com>, <linux-mtd@lists.infradead.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: add dual and quad read support for w25q128
Thread-Topic: [PATCH] mtd: spi-nor: add dual and quad read support for w25q128
Thread-Index: AQHVl4hH8fBqrsDX9U2dVkJ6Fwz72KeFiMeA
Date:   Mon, 11 Nov 2019 06:48:28 +0000
Message-ID: <797c210f-c82c-af3c-9dc5-07466e7e3892@microchip.com>
References: <20191110053222.22945-1-gch981213@gmail.com>
In-Reply-To: <20191110053222.22945-1-gch981213@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM3PR07CA0085.eurprd07.prod.outlook.com
 (2603:10a6:207:6::19) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73f41986-0c67-4cf6-2d70-08d76673282a
x-ms-traffictypediagnostic: MN2PR11MB4045:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR11MB40450E9CCC196F4BA6A71B37F0740@MN2PR11MB4045.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(136003)(396003)(39860400002)(199004)(189003)(6306002)(2616005)(476003)(2501003)(6512007)(4744005)(11346002)(446003)(66446008)(66066001)(66476007)(66556008)(6506007)(53546011)(64756008)(6486002)(386003)(76176011)(52116002)(66946007)(5660300002)(186003)(229853002)(31686004)(102836004)(6116002)(6436002)(3846002)(99286004)(14444005)(25786009)(256004)(316002)(110136005)(478600001)(26005)(966005)(8936002)(36756003)(14454004)(54906003)(6246003)(31696002)(2906002)(8676002)(7736002)(4326008)(305945005)(71190400001)(486006)(71200400001)(81156014)(81166006)(86362001)(138113003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4045;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AtzFKZfAreOkJszqR5nTpq+8/ZsV27aYKlZ6gsPcN/7hwGUTEbusL0p0OY4BXbFpkPLBpoIpOqggZlVuBqDIqW0keLCZ+tW6D7jFhgWurHvOHX9m6rFfJ8qEL6X8UrR+d/zaV5Gf2OlBzVDH472mOLH0PzPZbHOjDIdiJg5yVT6fdRD2dSBwKQ+BRsYtq52mGzYrjmKYPRg0D1PrZwZDnjgSkxZ0xFZBgqdhnmUTTsarAbxSy6dglhqSHqaifobU9WuPMdFd7+AQfO0MU7UwxjlL8DWjzLBI8rtjmenzC7fxa/bzPPVrehRhzRYNomzUqFP2/M9kVYgM0T7lmtdeZDg0zO6hCw4gA6BvmB1T4ueEeihkMuyDVXmmwluo5NfO9LRc1kjxAatdXcR+FlBy0CBZjN/xJXmNSJsp92cZQqCAU2DjUu4qWyWHTs0z3kWulNEV3eeXe623r5sO3FyqT9ZABchkWM4ahwSQCBCL0Tg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <33D3B44F1AA50741B55C7910C7D249BA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f41986-0c67-4cf6-2d70-08d76673282a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 06:48:28.1666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xxVJYaaYx/yOyQanPiSel+0F/F2VLDvnvax8/FhyjeuYo9hLBV0oRyWr9amiSDdGHQXtB1w2PaZloZm5oahSvmI59WOcQVCEwIvlhBU4IOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDExLzEwLzIwMTkgMDc6MzIgQU0sIENodWFuaG9uZyBHdW8gd3JvdGU6DQo+IFRoZSBv
bmx5IHcyNXExMjggdmFyaWFudCBJIGNvdWxkIGZpbmQgd2l0aCAweGVmNDAxOCBhcyBJRCBpcw0K
PiB3MjVxMTI4ZnYsIHdoaWNoIHN1cHBvcnRzIGJvdGggZHVhbCBhbmQgcXVhZCByZWFkIG1vZGUu
DQo+IEFkZCB0aGVzZSB0d28gZmxhZ3MgaW4gY2hpcCBpbmZvLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQ2h1YW5ob25nIEd1byA8Z2NoOTgxMjEzQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L210ZC9zcGktbm9yL3NwaS1ub3IuYyB8IDUgKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KSGksDQoNClRoaXMgZHVwbGljYXRlcyB0aGUg
Zmlyc3QgcGF0Y2ggaW4NCmh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9saW51
eC1tdGQvbGlzdC8/c2VyaWVzPTEzOTMyNC4gQ2FuIEkgaGF2ZQ0KeW91ciBSZXZpZXdlZC1ieSB0
YWcgb24gdGhvc2UgaW5zdGVhZD8NCg0KVGhhbmtzLA0KdGENCg==
