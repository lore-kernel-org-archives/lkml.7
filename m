Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06393C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3D12342E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ODjvl20h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfE2OGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 10:06:19 -0400
Received: from mail-eopbgr10044.outbound.protection.outlook.com ([40.107.1.44]:26081
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727056AbfE2OGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 10:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geXcXOklRqydgUESMTOFmhViXuj+TaNfMYLXO1KDqDA=;
 b=ODjvl20h+UKNssizeIAKowbwJpWmCZqCxe+PpO0ajQPlUdfR5HKr3JXNMK/2QceZaH23CP+llXQ3nlPyjmtVBUjuAkhkkmsSjpNQLlk8gn5czxdYjvECfY9s3DqQPh5gmPX8VsXNkSnOKZLifg/pURfMcNhrx91eJVtgqzK8a+k=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
 VI1PR04MB4927.eurprd04.prod.outlook.com (20.177.49.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Wed, 29 May 2019 14:06:12 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8d0e:de86:9b49:b40]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8d0e:de86:9b49:b40%7]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 14:06:12 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>, Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "noring@nocrew.org" <noring@nocrew.org>,
        "JuergenUrban@gmx.de" <JuergenUrban@gmx.de>
Subject: Re: [PATCH v7 0/5] prerequisites for device reserved local mem rework
Thread-Topic: [PATCH v7 0/5] prerequisites for device reserved local mem
 rework
Thread-Index: AQHVFglQMB1lnLjYnE2Z8bn8+67UAKaB+N+AgAAA+wCAAClrAA==
Date:   Wed, 29 May 2019 14:06:12 +0000
Message-ID: <5b8164b3-74a3-9ba4-8c28-61a14ec57a39@nxp.com>
References: <20190529102843.13174-1-laurentiu.tudor@nxp.com>
 <20190529113427.GC11952@kroah.com> <20190529113758.GA9399@lst.de>
In-Reply-To: <20190529113758.GA9399@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b95a83b-5881-4c73-ef93-08d6e43eceda
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB4927;
x-ms-traffictypediagnostic: VI1PR04MB4927:
x-microsoft-antispam-prvs: <VI1PR04MB49271964249C41C427B1A782EC1F0@VI1PR04MB4927.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(366004)(199004)(189003)(36756003)(66446008)(6436002)(6512007)(53936002)(64756008)(66556008)(31686004)(76116006)(73956011)(2906002)(66574012)(5660300002)(316002)(8676002)(81156014)(26005)(86362001)(6246003)(3846002)(4744005)(6116002)(76176011)(53546011)(6506007)(66476007)(44832011)(31696002)(102836004)(478600001)(186003)(25786009)(110136005)(14454004)(54906003)(99286004)(4326008)(256004)(8936002)(71190400001)(229853002)(81166006)(66946007)(68736007)(305945005)(7736002)(71200400001)(486006)(446003)(66066001)(6486002)(476003)(2616005)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4927;H:VI1PR04MB5134.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PzPdfdAE9mkBKiL6fPxlR5v7HEbmTgvv+dUb0J7Y8bE73kd0xlTj+o5aKBGVPvvUKMJA+zn49cyqwg6IrV9ikXButWUlDBamUqplZDmgAxGafv2HV87MuBZAq8p4nQJFpCNzZGrz8sSdWahHdKubSOiRLp4l2gnVT7G+3jammCxCav/NP++GbViBaccGOEiMCCqHZuo6VN2qghtqqjR9qZWv04iu1Q37IYq5iC8EmYLXfQyr35bX1UGxhc4jar+Nki2BX5CL1mgo8chjt6/wzyWhLmhSlmr0rgnblQ5JS7PXRb1ReHW550h86gvhwlUaJNYSEq5zKbVLpZYMdUiAAySMuWQdqL4D+cPcG5U1rNDS/kcQlKPgM7Ws2YmhOQWkOH45ow2idXcvLIZT6TwZxw2Jtx3kNvyPWd1z8NRe5Nc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B85DCE3956045E4FBD46AE8083B95DAA@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b95a83b-5881-4c73-ef93-08d6e43eceda
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 14:06:12.7994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: laurentiu.tudor@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4927
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hyaXN0b3BoLA0KDQpPbiAyOS4wNS4yMDE5IDE0OjM3LCBDaHJpc3RvcGggSGVsbHdpZyB3
cm90ZToNCj4gT24gV2VkLCBNYXkgMjksIDIwMTkgYXQgMDQ6MzQ6MjdBTSAtMDcwMCwgR3JlZyBL
SCB3cm90ZToNCj4+IFJldmlld2VkLWJ5OiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51
eGZvdW5kYXRpb24ub3JnPg0KPj4NCj4+IENocmlzdG9waCwgdGhpcyBpcyBnb2luZyB0aHJvdWdo
IHlvdXIgdHJlZSwgcmlnaHQ/DQo+IA0KPiBZZXMsIEknbGwgcNGWY2sgaXQgdXAuDQo+IA0KDQpU
aGFua3MsIGhvcGUgdGhpcyB0aW1lIGV2ZXJ5dGhpbmcgaXMgZmluZS4NCldoZW4geW91IGdldCB0
aGUgdGltZSwgcGxlYXNlIGxldCBtZSBrbm93IHlvdXIgaWRlYXMgb24gdGhlIG5leHQgc3RlcHMu
DQoNCi0tLQ0KQmVzdCBSZWdhcmRzLCBMYXVyZW50aXU=
