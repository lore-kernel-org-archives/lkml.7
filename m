Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60AAC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B8C206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="O3zpShDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbfDQIoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:44:21 -0400
Received: from mail-eopbgr10098.outbound.protection.outlook.com ([40.107.1.98]:14561
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726895AbfDQIoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+/YQNE86Lny+B1hjorj5SP2hln2htXzuU0aBz4H9bA=;
 b=O3zpShDt9+VrpfEbGbzHa8YTG+WFXkW/cpS43tV5hZfYJy71jjyu7N3RfbG9hB13dkuhkGcotzjkEGFGV8Fak0jSIBJiSA3oWhQoT0LN7b5zJPXEpAUztTofzf5YJaSafEtIvsjTgJxrW36OyO/fz0ZDKDycyfFq39NJvDfZpwo=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB1230.eurprd02.prod.outlook.com (10.163.164.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.18; Wed, 17 Apr 2019 08:44:16 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::2891:d814:7bff:fbc7]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::2891:d814:7bff:fbc7%4]) with mapi id 15.20.1792.018; Wed, 17 Apr 2019
 08:44:16 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Pankaj Bansal <pankaj.bansal@nxp.com>, Leo Li <leoyang.li@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] drivers: mux: Add Generic regmap bitfield-based
 multiplexer in mmio-mux
Thread-Topic: [PATCH v6 2/2] drivers: mux: Add Generic regmap bitfield-based
 multiplexer in mmio-mux
Thread-Index: AQHUz275QZqjoupIjEuwhpk/3maVg6ZATkAAgAAGVwA=
Date:   Wed, 17 Apr 2019 08:44:16 +0000
Message-ID: <08105e66-f3a5-f2db-2d3e-66ab45959fc2@axentia.se>
References: <20190228193206.30594-1-pankaj.bansal@nxp.com>
 <20190228193206.30594-2-pankaj.bansal@nxp.com>
 <VI1PR0401MB249650C901662DC8F6B51B9EF1250@VI1PR0401MB2496.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0401MB249650C901662DC8F6B51B9EF1250@VI1PR0401MB2496.eurprd04.prod.outlook.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR05CA0233.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::33) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7fa31acf-17db-494e-d694-08d6c310df9e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600140)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR02MB1230;
x-ms-traffictypediagnostic: VI1PR02MB1230:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR02MB123052FDFABFC9F26330E7D5BC250@VI1PR02MB1230.eurprd02.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(136003)(346002)(39830400003)(52314003)(199004)(189003)(6436002)(256004)(966005)(14454004)(66066001)(229853002)(508600001)(71190400001)(71200400001)(6486002)(65806001)(65956001)(65826007)(105586002)(106356001)(5660300002)(76176011)(74482002)(81166006)(8676002)(31696002)(8936002)(7736002)(4744005)(97736004)(305945005)(11346002)(81156014)(52116002)(110136005)(64126003)(6116002)(486006)(476003)(31686004)(2906002)(386003)(6506007)(53546011)(6246003)(2616005)(25786009)(99286004)(36756003)(86362001)(446003)(316002)(26005)(3846002)(4326008)(6306002)(53936002)(186003)(6512007)(58126008)(102836004)(68736007)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB1230;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Hghsan9PKA1y8Z61/a6G9tgQI68KTTEHjnbXkgaFShmc4SFo8T7nkbzR2LvWQqbQ3HYgOHzKQ+QkL6n/kVnNKSi1HKDJfpcOfyVWcMGAEPjRe8/8SxWDqadnaiOEgteuW/+dXfAluQSjJjWNle8+9xD57tH+zhaupPI00rL2dsFpsU/kZ67ZNmQFM05uOF+JM4gtp7qSqvVSJzbfVhjVlEcSnUH7SXzacpme7cpukSS0lVmvGTICANSnkLWoe1W6OmY6xaZcbHbvrEDpk+pAEwwzLxYTqwITkQerjX3adA394TAKuoWB9pAYLIz37ycFAVFmR5rumj0z6I6xvFozVwRIJ1NhETvT+qWz41bYronRoTFNxFwJZl8tf7awEcKS2MziTixqIlfOEPoECud4jmzNQXDCWM8kAY3bgfaqh2o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6157D7FE020C64E993DD250A7FDB674@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa31acf-17db-494e-d694-08d6c310df9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 08:44:16.0917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB1230
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wNC0xNyAxMDoyMSwgUGFua2FqIEJhbnNhbCB3cm90ZToNCj4gSEkgUGV0ZXIsDQo+
IA0KPiBIYXZlIHRoZXNlIGNoYW5nZXMgYmVlbiBhcHBsaWVkIGluIGFueSBsaW51eCBicmFuY2g/
IEkgZGlkIG5vdCBzZWUgdGhlc2UgY2hhbmdlcyBpbiBodHRwczovL2VsaXhpci5ib290bGluLmNv
bS9saW51eC92NS4xLXJjNS9zb3VyY2UvZHJpdmVycy9tdXgvbW1pby5jI0w0Ng0KPiANCg0KSGks
DQoNCk5vIHRoZXkgaGF2ZSBub3QsIEkndmUgYmVlbiBidXN5IHdpdGggb3RoZXIgc3R1ZmYuLi4g
SG93ZXZlciwgSSBkb24ndCB0aGluaw0KdGhlc2UgcGF0Y2hlcyBhcmUgLXJjWCBtYXRlcmlhbCBh
bmQgeW91IG1pc3NlZCB0aGUgbGFzdCBtZXJnZSB3aW5kb3cgd2hpY2gNCmlzIHdoeSB0aGlzIGhh
dmUgdGFrZW4gc28gbG9uZy4gSXQgd2FzIHNpbXBseSBiYWQgdGltaW5nLiBBbnl3YXksIG15IHBs
YW4NCmlzIHRvIGdldCB0aGVtIGludG8gbGludXgtbmV4dCBzb29uaXNoIGFuZCB0aGVuIGludG8g
dGhpcyBtZXJnZSB3aW5kb3cgZm9yDQo1LjItcmMxLiBJIHdpbGwgQ2MgeW91IHdoZW4gSSBwdXNo
IGl0IHRvIG15IHVwc3RyZWFtIChHcmVnKS4NCg0KVGhhbmtzIGZvciB5b3VyIHBhdGllbmNlIQ0K
DQpDaGVlcnMsDQpQZXRlcg0K
