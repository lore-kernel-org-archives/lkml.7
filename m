Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1F3C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3FF214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BV69ZQR1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="JGv61Hxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392992AbfETRn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:43:57 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:57720 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389405AbfETRn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:43:57 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DE199C00FD;
        Mon, 20 May 2019 17:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1558374243; bh=fea6R/84Hn9bthGL4ye6DFQyNX2PQSA7+Dg2byhnzTI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=BV69ZQR1NjtcVNGuztTaDZGFe6QeDxnyQGNYEhXwXXk82BiYaq4fP/io6paYcFQrK
         4wshr4UcAgP3G6KDLhka6jK+ttKQWwRP27eOCAOrdYP8wOHErlvXylMs/lc4h2l1cr
         4ZXHN88f+2Lw5NMhaOcZX8YJLIJPdRsqtPQjVV6xQHgk3wA65qi4vEbhAi02jJSbq8
         4ZVYvdh9bvjrR0rjb7HkbEbzevuqTJPkNY43OwUBs8Oa8p/j9nrW5NRsZjna9wqzuQ
         LOwrDoaYeWUuqgWhaR5vBLp58VCWVzAhZ4E/aTn+nORV5E+2AF5945aazFbDcN2/U8
         POVYrU/4GC4Wg==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id DA0EAA0067;
        Mon, 20 May 2019 17:43:55 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 20 May 2019 10:43:55 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 20 May 2019 10:43:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fea6R/84Hn9bthGL4ye6DFQyNX2PQSA7+Dg2byhnzTI=;
 b=JGv61HxcfqjV27xWJdePF8h4xXtXPggdpmQ/86PcjGeIjFjoYXxvK414Leevd52gqYYCly+IvJt8FmQ+Pc7QeuBOt7LRiI94AYdOimcg3FPow1Y+oIuHjHuFHUB7IRi1YUlnrblmHlu8/DgTFzxdx6E4LvorLJx/zrq0LH5U9Q0=
Received: from MWHPR12MB1632.namprd12.prod.outlook.com (10.172.56.21) by
 MWHPR12MB1421.namprd12.prod.outlook.com (10.169.206.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Mon, 20 May 2019 17:43:53 +0000
Received: from MWHPR12MB1632.namprd12.prod.outlook.com
 ([fe80::c5dc:3b4:6ab8:4dc6]) by MWHPR12MB1632.namprd12.prod.outlook.com
 ([fe80::c5dc:3b4:6ab8:4dc6%2]) with mapi id 15.20.1900.019; Mon, 20 May 2019
 17:43:53 +0000
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH 2/2] ARC: [plat-hsdk]: Add missing FIFO size entry in GMAC
 node
Thread-Topic: [PATCH 2/2] ARC: [plat-hsdk]: Add missing FIFO size entry in
 GMAC node
Thread-Index: AQHVDxIIRoZwe4Rm4UaSw1XpE1MntqZ0SQeA
Date:   Mon, 20 May 2019 17:43:53 +0000
Message-ID: <1558374231.3147.2.camel@synopsys.com>
References: <cover.1558359611.git.joabreu@synopsys.com>
         <cdd9b9c36ff1ac3a3b56dff4a90e9bfd89b48866.1558359611.git.joabreu@synopsys.com>
In-Reply-To: <cdd9b9c36ff1ac3a3b56dff4a90e9bfd89b48866.1558359611.git.joabreu@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paltsev@synopsys.com; 
x-originating-ip: [84.204.78.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 593033a8-3d31-4061-3d2d-08d6dd4ab9df
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR12MB1421;
x-ms-traffictypediagnostic: MWHPR12MB1421:
x-microsoft-antispam-prvs: <MWHPR12MB1421950CD1DB5AEF93CB95DEDE060@MWHPR12MB1421.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:386;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(136003)(396003)(39850400004)(199004)(189003)(2501003)(76116006)(73956011)(64756008)(66946007)(36756003)(66446008)(5660300002)(66556008)(66476007)(91956017)(2906002)(305945005)(6506007)(76176011)(102836004)(110136005)(66066001)(54906003)(7736002)(3846002)(446003)(6486002)(8936002)(81156014)(186003)(81166006)(486006)(229853002)(8676002)(11346002)(6116002)(4744005)(476003)(2616005)(6436002)(256004)(6512007)(26005)(316002)(86362001)(478600001)(14454004)(103116003)(71200400001)(71190400001)(4326008)(6246003)(107886003)(68736007)(25786009)(99286004)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR12MB1421;H:MWHPR12MB1632.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HHfnJuPFUSfwgd0brUPC8fWzZgsTS9TYU0iEg98JFmfY1rEFGottaP/t8C8CDThaBld4c05T90nGIzDAyQvxTyC6GG3Elrha6iBEuDJrJ8G4XKXbQRPA7oxrM3h27xhx3wY40RdLO/N2CLmD9NitTcV3jKaGATgprLxMQH3kwNXrggeDaHH8xV9f3n/6tmBNLiWDpcAxJEk7G3GEt5bWMr2UO5zl3X99mFEiK66ASwFNg9bSO8hkiO7kWPgsg4U+R1MX8br9Tl292LdNRoagfPFJt1Wo8EOJivjR1paTfj6KX3GpXC++bHgSzP3FpoyH9DVGgMNUOSu/98DqeR7cFdOLWR1vBpmT9O2B1drmF3gg/TVL/9WNZxgzY2dz6+yyIfRP4vQIgDyqTS1qFiX7HJXh51h8MdTHLEXaA8Ysh/k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7399C40F4EB674BB424CB89D4E99781@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 593033a8-3d31-4061-3d2d-08d6dd4ab9df
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 17:43:53.3956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1421
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9zZSwNCg0KVGVzdGVkLWJ5OiBFdWdlbml5IFBhbHRzZXYgPEV1Z2VuaXkuUGFsdHNldkBz
eW5vcHN5cy5jb20+DQoNCg0KT24gTW9uLCAyMDE5LTA1LTIwIGF0IDE1OjQzICswMjAwLCBKb3Nl
IEFicmV1IHdyb3RlOg0KPiBBZGQgdGhlIGJpbmRpbmcgZm9yIFJYL1RYIGZpZm8gc2l6ZSBvZiBH
TUFDIG5vZGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKb3NlIEFicmV1IDxqb2FicmV1QHN5bm9w
c3lzLmNvbT4NCj4gQ2M6IEpvYW8gUGludG8gPGpwaW50b0BzeW5vcHN5cy5jb20+DQo+IENjOiBS
b2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPg0KPiBDYzogTWFyayBSdXRsYW5kIDxtYXJr
LnJ1dGxhbmRAYXJtLmNvbT4NCj4gQ2M6IFZpbmVldCBHdXB0YSA8dmd1cHRhQHN5bm9wc3lzLmNv
bT4NCj4gQ2M6IEV1Z2VuaXkgUGFsdHNldiA8RXVnZW5peS5QYWx0c2V2QHN5bm9wc3lzLmNvbT4N
Cj4gQ2M6IEFsZXhleSBCcm9ka2luIDxhYnJvZGtpbkBzeW5vcHN5cy5jb20+DQo+IC0tLQ0KPiAg
YXJjaC9hcmMvYm9vdC9kdHMvaHNkay5kdHMgfCAzICsrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJjL2Jvb3QvZHRzL2hzZGsu
ZHRzIGIvYXJjaC9hcmMvYm9vdC9kdHMvaHNkay5kdHMNCj4gaW5kZXggYjBmMDU5Mzc3YWIwLi4z
YmNkMWVkYzRkY2MgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJjL2Jvb3QvZHRzL2hzZGsuZHRzDQo+
ICsrKyBiL2FyY2gvYXJjL2Jvb3QvZHRzL2hzZGsuZHRzDQo+IEBAIC0xOTYsNiArMTk2LDkgQEAN
Cj4gIAkJCW1hYy1hZGRyZXNzID0gWzAwIDAwIDAwIDAwIDAwIDAwXTsgLyogRmlsbGVkIGluIGJ5
IFUtQm9vdCAqLw0KPiAgCQkJZG1hLWNvaGVyZW50Ow0KPiAgDQo+ICsJCQl0eC1maWZvLWRlcHRo
ID0gPDQwOTY+Ow0KPiArCQkJcngtZmlmby1kZXB0aCA9IDw0MDk2PjsNCj4gKw0KPiAgCQkJbWRp
byB7DQo+ICAJCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ICAJCQkJI3NpemUtY2VsbHMgPSA8
MD47DQotLSANCiBFdWdlbml5IFBhbHRzZXY=
