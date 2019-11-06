Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687BAC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2979A2084D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="EoH4goC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731425AbfKFIl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 03:41:27 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:41540 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbfKFIl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 03:41:26 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: bt1bkR4cd6wVAPnygKYvNClABxwEU8e4xNc88ti2aTjUCiUgPfTRAg8ejxR/076Q5jWAY+ObTR
 q7AQ1lH8C5Day64Hlzi2KU5mZyuwTG3oesJwNBfKPmSfnub9UCS9nM+eaHW2BPzH4hrKyPrJ/z
 F5fIW3oJ+7nXscYGv4M61LYYBIx4xAPsjk03lKjXnYWum9+fzk4r3vhe8q7Y+Paxxo4x9E95pN
 KAAdK5uRBdSrrKP7zKfbWbksN8OF9oDaQPBYdAK4quSRlaHbRMsdN80VeC35glQh/17pBTywem
 EC8=
X-IronPort-AV: E=Sophos;i="5.68,274,1569308400"; 
   d="scan'208";a="53080507"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2019 01:41:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 6 Nov 2019 01:41:18 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 6 Nov 2019 01:41:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zt+izzKesNvIY3sRkFVGnT+Jis1hNev3Zk86Kij1wYvkxaJAuQEtrYnpvy9OTxqzEp/tKZl+FaP00sg6BmM8RG/+TX7EioKXUHBXuOuotBLqXLrp0HRKVHvRqB0s98mNgcVQjr/qILcg2zQahgAhnhF4iEKOYLX/6L0SyAeLCZD3mbxpe57H0FC+eIWyfNmihhQJbsQhZmAEHgY6gGOy/x9+F9WD3pgYBxS5B0vOg44KF/qFiX1OyfAFTfQLf1nzwOcLQF/Fpqxa/jWZGaoXRO9krYOjGXvBC4ZSdo9F6fYX2Chw5Ak/IspBif2XgS9nnYnq2jlyfwVkeMFkWwJrxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzkPIGw1LC/yS1YUaUeqVxqg5nzAiaiDhCt03X+/B1s=;
 b=SGEd8CSD/vVLoURR3M1urq/jfzXoQSS0/uzlRtfcWoreC4wkmrM7hwtRWIgPIw3bYdfqbcdDDwI/NS9H7+3pSn7gzX/PZqdkCNm6cQqlJdj+WxLqylzvLsFTMxDbCN+7d37HqOeJFtHLuanNnbljrlAfnFo7uC9Vbn3ovf5D7KkLDEB4WINYKnthV3NSQZ4rGSmM9KfqLc2TUBUKduko0suqi+OqKMxTUuQW1CfSP0uZLY66R6GIF7ayV/h2ruTmI5+FFAZnIMW067A1SxY5IJXG87yg49gc0GHJBFGSsDRlkjHhZMYlh+RQU1iYip6gxVyWfng+QNZeA5I6kU6c3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzkPIGw1LC/yS1YUaUeqVxqg5nzAiaiDhCt03X+/B1s=;
 b=EoH4goC3k+S6Hlz9xT9XOI0hVg96RyqTzqoDLwb7eJ1KfxewsJlQl7QjgXmxpah+KbtjMuDlyAN699rsqi98jfPf/cfCSZ+LKVDCYz10q3D6UsngtMFEarBzwfQrERgGbfugLdu3hTckcM/UB5LWQMfphXlCItCF2fzOAqORqg8=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3630.namprd11.prod.outlook.com (20.178.253.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 08:41:17 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 08:41:17 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>
CC:     <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v4 15/20] mtd: spi-nor: Extend the QE Read Back test to
 both SR1 and SR2
Thread-Topic: [PATCH v4 15/20] mtd: spi-nor: Extend the QE Read Back test to
 both SR1 and SR2
Thread-Index: AQHVkXAAobnx9/kxgESK6sIIzhHB/qd8wv4AgAEV+oA=
Date:   Wed, 6 Nov 2019 08:41:17 +0000
Message-ID: <a16ea803-e605-0367-6c54-1b890e11d5aa@microchip.com>
References: <20191102112316.20715-1-tudor.ambarus@microchip.com>
 <20191102112316.20715-16-tudor.ambarus@microchip.com>
 <b9a4e491-d081-1325-1532-b392f55fcaf9@ti.com>
In-Reply-To: <b9a4e491-d081-1325-1532-b392f55fcaf9@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0118.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::47) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc24ed08-6d61-4389-f35a-08d762951715
x-ms-traffictypediagnostic: MN2PR11MB3630:
x-microsoft-antispam-prvs: <MN2PR11MB363064888A0F1CCFDA36234AF0790@MN2PR11MB3630.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(366004)(136003)(199004)(189003)(446003)(6512007)(110136005)(5660300002)(6116002)(66946007)(54906003)(31696002)(2616005)(6486002)(6246003)(11346002)(3846002)(71190400001)(71200400001)(26005)(186003)(102836004)(305945005)(7736002)(66066001)(256004)(229853002)(31686004)(486006)(476003)(386003)(66556008)(316002)(6436002)(66476007)(86362001)(4744005)(14454004)(8936002)(81166006)(36756003)(6506007)(2501003)(53546011)(81156014)(25786009)(99286004)(2906002)(52116002)(4326008)(76176011)(478600001)(64756008)(66446008)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3630;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hhpAKz9qufvpGWGfaR+NX9ibS1snCcreOkE0lXcgzAdU8hFfSR61U9/Uw3IJXzjOyRPrmV/Xr7JE1F9E5Pg+aBioPt47doOiz97lpWcxwQ3/0x/piZJdovol0ZGZT31dymFddKYoLuKBzk/TktW+MrteXcFLMdEPklZSxuiCVd9S9nHg47AQgUDAqXCPticFz4nS862QfP2xkxAn3nnc6DblLO+fYtt/D4Tdi8MWGLjMCAtlp6PUrKsMsr2ZHF0pFdd6N/qQaambVztgsFUQB1b/iLI5+MUKoKpK6ibGv9/ljgDlaj+Q7VDCytIz5Qi9Gi6FUn7zVjMw2xeUru+GjNaepwKsRJppkTl76YZYAYASM6XEeX16AJbqjNh1Cev3piQULWWEXT4uyJfaadnab77sUTX8K5YKcDPXHuWu8xIZGEKoAwH+qolzJxSPV7a7
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <54E5E9C94F1AA748A556F9A3E39F6704@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bc24ed08-6d61-4389-f35a-08d762951715
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 08:41:17.5247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mNEojUGLp8Jv1kK9FhioMw+mRj0puEFtGoe7YNaCZpfQ3PCxoUap4OQvQppE8BiqehdMhyHLem0YKqupnmz+BQERGCcwwoocYOuUyPdWXoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3630
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDExLzA1LzIwMTkgMDY6MDYgUE0sIFZpZ25lc2ggUmFnaGF2ZW5kcmEgd3JvdGU6DQo+
PiBGcm9tOiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+Pg0K
Pj4gSW4gY2FzZSBvZiAxNi1iaXQgV3JpdGUgU3RhdHVzIFJlZ2lzdGVyLCBjaGVjayB0aGF0IGJv
dGggU1IxIGFuZA0KPj4gU1IyIHdlcmUgd3JpdHRlbiBjb3JyZWN0bHkuDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KPj4g
LS0tDQo+IFRoaXMgY2FuIGJlIG1lcmdlZCB3aXRoIHByZXZpb3VzIHBhdGNoIGFzIGNoYW5nZXMg
YXJlIHF1aXRlIHNpbWlsYXINCg0KT2ssIEknbGwgcmVuYW1lIHRoZSBzcXVhc2hlZCBwYXRjaCB0
byAiRXh0ZW5kIHRoZSBTUiByZWFkIGJhY2sgdGVzdCIuDQoNClRoYW5rcyENCg==
