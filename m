Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFB7C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 07:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E79A2173B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 07:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="d9V5EnP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbfKFHYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 02:24:39 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:47202 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbfKFHYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 02:24:38 -0500
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: opbjD4007lICQUWc2yJRzIuncsLCIxz24/wxGRxLWP2Y5JnuSb7LV4W/6fxRGrVZFsxw7YYDZ2
 8ax6CLGaCIOvCUeYg+oUeYV7955jacVJJ7z3e2ki8DPvDNiHn4gTMU0O2xtkETyOLiiXRpfpBb
 A4p3LSHxV2WF+Hx3Yt4vTTsj6pQJYMkWD9hScEBzsi2iGpc0P7xGBWm+/c7HrHXWPmHtS76myw
 lP1MDXD1yyKNSoYO4g2hqyXaVb4pS0NJHfmSsEOHxKCsxGiw46cQiZy+ZzlN39f9C1m7GoXbAW
 FP4=
X-IronPort-AV: E=Sophos;i="5.68,274,1569308400"; 
   d="scan'208";a="55871209"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2019 00:24:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 6 Nov 2019 00:24:33 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 6 Nov 2019 00:24:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDEnyIP/KDirqD/28ckVNXV5n9qTdzjCGeutb6XdzWsOkXdvsOJ8ZyxNqAVD2R3g+Sx7Fo6q9UkV/v0VGjXTn7GXBiyLDr0BS9oN8JTxYl80ki9dqrZn6L/C+eu6qDlQTnH+zJbejxC9YShiiMiwua1k/KW0WMDw80vNx+/J8zTZgUp6ngjC2DaYuGXR5aCLHkjtS7aKzlsWqHbISX+0e4g3WoeqS0KTHx5/J1HU/h3UQykNe58+E3HnHPOmtWUefwv6OoijxQFczqXsfyX21CX3c+Dsc2XqPYJXHq77l7wg39GDe/bosFhTs1mfHPsObss88sdAFtav82hRBGsMYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yasikDCYe2+tKN55LZw7C/zAbJYlF0buEWSCkzXdCe4=;
 b=YVBa/+qKz9Ek753DFHtpKPLpJe90YVSBLA7KhAsJDbh3sY9fkVvIkLmjjKgE9KkzhGFWLlkzpwXtBJW97bbuQkRYopxMKR+2BKWWEawHPzHKuK1nAmm3n+WKrFmKlsIinupyFn6CbDIjhLXaYHHvC0CqAGNoQ4OE8ZSgy/6LzwmZV98XMei+jP9rICCCVk9TzjHNvuEEaCBtC68R5hfTjV7mKgN5Km8cVhrC5o/1K9Pqr6vUtFNDHhWagMSgDMEnQoqNYTrPAIkHYBZeqRbfo7h5ckygLBi7jU0bRp/jjZZHyC3rPJpbwpOnDseVNDGxqdzD+nbgjIQVArOkhPsNRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yasikDCYe2+tKN55LZw7C/zAbJYlF0buEWSCkzXdCe4=;
 b=d9V5EnP+bLN1m8CJiAaN/4hIPpOl1N6od8F4apIP65kdT/TyZTZRJXkpdomnnFjqwC2L8VN57WIvl/vTtRQkAHw0Tj08w2ikYHR7kjFdOf0DGtLUJ2LiujmUtR7O0py+FJpycjri4v/DLzH1h+KPqaCNjg8gHRCAl0eMHJD1wBM=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3774.namprd11.prod.outlook.com (20.178.254.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 07:24:31 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 07:24:31 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 12/20] mtd: spi-nor: Print debug message when the read
 back test fails
Thread-Topic: [PATCH v4 12/20] mtd: spi-nor: Print debug message when the read
 back test fails
Thread-Index: AQHVkW/82Z42whGzzUysItCyifQ7OKd8iNAAgAE6vQA=
Date:   Wed, 6 Nov 2019 07:24:31 +0000
Message-ID: <5abf94c6-f2bb-b317-4796-3f9ea1fbf55e@microchip.com>
References: <20191102112316.20715-1-tudor.ambarus@microchip.com>
 <20191102112316.20715-13-tudor.ambarus@microchip.com>
 <9474c875-94a1-3d19-ddab-b90d352967a9@ti.com>
In-Reply-To: <9474c875-94a1-3d19-ddab-b90d352967a9@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0078.eurprd09.prod.outlook.com
 (2603:10a6:802:29::22) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b24a3c9-e68c-4593-c179-08d7628a5d84
x-ms-traffictypediagnostic: MN2PR11MB3774:
x-microsoft-antispam-prvs: <MN2PR11MB377451751D5E98EAC937C853F0790@MN2PR11MB3774.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(66446008)(71200400001)(66066001)(31696002)(478600001)(36756003)(99286004)(7736002)(305945005)(4326008)(8676002)(25786009)(4744005)(476003)(66476007)(6246003)(81166006)(81156014)(110136005)(54906003)(31686004)(52116002)(71190400001)(6512007)(86362001)(186003)(14454004)(76176011)(486006)(5660300002)(316002)(2501003)(8936002)(6116002)(15650500001)(386003)(6506007)(446003)(64756008)(2906002)(53546011)(256004)(66556008)(2616005)(11346002)(102836004)(6436002)(3846002)(26005)(6486002)(66946007)(229853002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3774;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C3lJnFhNpV3Eh35jrR7tr3j5D+p6ZcvJkHVMYIcy6HRpGBsoHtRY2MeSjlVCnc8e13yeQ3RSeXRn36qUJW52WGXwvm+D49trpuwWX9EXoCJZaX5mYtaYVfOPB8cIUvwl2B0v6PAJVgWrvaKlenkXpIAV4wbTRwsW2Ut9jyAdE/Bf7C9GEZvRQAgEmZjEdicaiKGxodY3NvcfppT9AQ/sAxrpcvwF/MOE+1UOk8LlG1StF5F+veEiMLG7Gb+4TVT5APGrd+dEf4JsGHwbIdW5WZltzWN7a2fk1f6neoY2A+b1OMrZ4/it6CGxtiIXEHhzFme3jR/TmsGOtGmhar1Q4e2Z89RPzF3k6Kz0Rjzvqt8WvgGkEw/QUceu7rGUc8S0k3yA2CLx7PSqvJ8ruGxY+LXsdvFOU1REzFVMKboGPESJBDWOiX4luBn0MIIKWQMH
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFCCD6AEF84C554082F7C0AF70C9BA57@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b24a3c9-e68c-4593-c179-08d7628a5d84
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 07:24:31.1723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l7Zom7LOJQWPcusdKw2R5yEx5TSxtfmp2pZqMkpGdjHskfkMhobfgSXRrzhtkXZVXvQpTkFqkSycy1+ZXMpY89b7bSiJg+FPYMh6Rz6r6mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3774
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDExLzA1LzIwMTkgMDI6MzcgUE0sIFZpZ25lc2ggUmFnaGF2ZW5kcmEgd3JvdGU6DQo+
IE9uIDAyLzExLzE5IDQ6NTMgUE0sIFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbSB3cm90ZToN
Cj4+IEZyb206IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4+
DQo+PiBEZW15c3RpZnkgd2hlcmUgdGhlIEVJTyBlcnJvciBvY2N1cnMuDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KPj4g
LS0tDQo+IEkgdGhpbmsgdGhpcyBpcyBhIHNtYWxsIGVub3VnaCBjaGFuZ2UgdGhhdCBjYW4gYmUg
c3F1YXNoZWQgaW50byBwcmV2aW91cw0KPiBwYXRjaCBpdHNlbGYNCj4gDQoNCkkgbWFkZSBzZXBh
cmF0ZSBwYXRjaGVzIGJlY2F1c2UgdGhpcyBpcyBhIHNlcGFyYXRlIGxvZ2ljYWwgY2hhbmdlLiBU
aGUgcHJldmlvdXMNCnBhdGNoIGV4dGVuZHMgdGhlIGNoZWNrIG9uIGFsbCBiaXRzIG9mIHRoZSBT
dGF0dXMgUmVnaXN0ZXIsIHdoaWxlIHRoaXMgb25lDQpwcmludHMgYSBkZWJ1ZyBtZXNzYWdlIGlu
IGNhc2Ugb2YgRUlPLiBUaHVzIEkgdHJpZWQgdG8gaGF2ZSBhIHNpbmdsZSBsb2dpY2FsDQpjaGFu
Z2UgY29udGFpbmVkIGluIGEgc2luZ2xlIHBhdGNoLiBJJ20gY2xlYXJseSBubyBleHBlcnQgaW4g
dGhpcyAoQm9yaXMgYXNrZWQNCm1lIGluIHYzIHRvIHNwbGl0IHBhdGNoZXMgYmVjYXVzZSBJIGRp
ZCB0b28gbWFueSB0aGluZ3MgaW4gb25lIHBhdGNoIDopICksIHNvIEkNCndvdWxkIGtlZXAgdGhp
cyBhcyBpcywgYnV0IGlmIHlvdSBzdGlsbCBmZWVsIHRoYXQgaXQgc2hvdWxkIGJlIHNxdWFzaGVk
LCB0aGVuDQpJJ2xsIGRvIGl0LiBQbGVhc2UgbGV0IG1lIGtub3cuDQo=
