Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95C3ECE58E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 01:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940782084C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 01:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GtegFQke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfJLBF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 21:05:29 -0400
Received: from mail-eopbgr60067.outbound.protection.outlook.com ([40.107.6.67]:46878
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727345AbfJLBF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 21:05:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NO18Jb/+dN+WzFBM8BGxCau4qUof8rAKKofOlv0fYBE751biz0+yp3EClAVHzKZUbrP4OwZ372azIghSp+S78d+ESMRrivcsryB+42TfaVzWaVsWaXvQUGDKBBaMWtGB1UQ58cyhh7c54dzcwPjFpnNFqwsqXJ0YDfO+BNiRIeI/2ztPtYVEY0UWK6pRn3hjtJsLhcBuM5ksT0lCxUKathI4V21Y42AKkYKjJx6GFx7ljmYOH0x9zYV8I0JXyZ3DvWOp20T5COzw9Qhstcz00NlsLP8VL7qnDI4Mky3JgZkVSlSPB39cg7SjYmsS96UCes/jiFhIkypBTwkK3PGA9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWo4faJzEkT4GxWZ5n7/NhOplHUymKJep8C7lPGIWIM=;
 b=CRbs/LUaXO+UauLXiX6TK7YJdZPjMOpshR3ailDq9r7slVkv3Hz/BlbQnhf7fUd+5Lxw4+Z2BDJxtn0VbgTr/o4dh4sR9DfwqxYZmr4BIlxXXQI0yDv2vaGM6ZL+WVyXtmuuK7fPcwSEzNqZ82ZMsofsWqbl4jckfkmW7cCIvaAwOgivHDXpM3ZF3VZjObI2yt46FRdnonjRjpfWK9fF6EjK3ZLyDFKdWaHUUEPZQh6aSDsKOFEx8+P8DOiAgXnRr4uupMFQ4dTtpwCdcpUiBOTsooa58OJfTMQwrhkfD6aU3GH1ImXO6g006T3p8Pi/28n8cWCKVH2KPlIiKQsw8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWo4faJzEkT4GxWZ5n7/NhOplHUymKJep8C7lPGIWIM=;
 b=GtegFQkea/vrhmLCDhTA5ch1fSz+BpWuulxYIk/vpPCMVM0gY/80aMbGxdFA7MOop/ME+qEwwic+SSqJPiXQJLu5az8W+hIzUJoZ9RaXs93sj15n8nLS1C7RawbFWg4jjIitwUkiFYAwfAmHyv4Icc3pSWZcV2G4sJabzlZ9dCg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3883.eurprd04.prod.outlook.com (52.134.71.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Sat, 12 Oct 2019 01:05:25 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0%6]) with mapi id 15.20.2347.021; Sat, 12 Oct 2019
 01:05:24 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] clk: imx7ulp: Correct system clock source option #7
Thread-Topic: [PATCH] clk: imx7ulp: Correct system clock source option #7
Thread-Index: AQHVgA9ej3vynbgG3Uu6u/KcnrPRNKdVSf+AgADmv2A=
Date:   Sat, 12 Oct 2019 01:05:24 +0000
Message-ID: <DB3PR0402MB391628A077B9D689469D38E3F5960@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1570783006-28099-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5DUVv_cT59pTBmfa60TM0E9=6rFdpDw71g_6cQidOPW+A@mail.gmail.com>
In-Reply-To: <CAOMZO5DUVv_cT59pTBmfa60TM0E9=6rFdpDw71g_6cQidOPW+A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9920703-6c63-4c1d-4b5a-08d74eb04385
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DB3PR0402MB3883:|DB3PR0402MB3883:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3883D8C6ABBE58EC051E0683F5960@DB3PR0402MB3883.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0188D66E61
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(189003)(199004)(5660300002)(44832011)(53546011)(6506007)(3846002)(7696005)(76116006)(102836004)(186003)(26005)(99286004)(4326008)(66446008)(64756008)(66556008)(66476007)(66946007)(256004)(81156014)(81166006)(8936002)(6916009)(7736002)(6116002)(52536014)(305945005)(4744005)(71190400001)(71200400001)(7416002)(8676002)(76176011)(74316002)(229853002)(55016002)(14444005)(9686003)(1411001)(86362001)(476003)(6436002)(33656002)(2906002)(478600001)(446003)(486006)(54906003)(11346002)(66066001)(14454004)(316002)(25786009)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3883;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uDuBE67wUVwlO6HbLi8kDGMKwH5nNI7XdsN9we4SUJjqjl/JKhe7LkVOMFmCUtX+tsRJnQUAaAuImDB1lI4l2+FluEhrNUlkFz3yGr7rVUKJGOeDJupEwCqt7gYH+nYoyojbtYu+6En8+mEPVnPq6OJAt3+Y8NoL2Bw0AA/i/wxvgJpeM6E6XiD4MKNWJ350bbHz1CrqrKj7QgO2H0BHMAk/RbztuXWFssMOQKtd8lp4RJ81uAOQS2DF1GJTqDcGvm7Hb/upWelAkdmELP5QFUeo7UgUED5K/66SgCzqQ/2kvqCucaYMt8MuyKv7fwZOEs1GYtE0GNG3foyqiSoh6NywxfbEBbMglYgowlzm1tT3YXh6J8xk59tlzMc9Mu8xSDc4QcouOnDPGWJL0wU02lUNWxr2aygXpNUMKV0m1FY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9920703-6c63-4c1d-4b5a-08d74eb04385
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2019 01:05:24.6916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FSHlgT2NV1NUMZzGKGQ4jNvT/IGKhpzNBCjzbmlimkHWKbiyh2B5hWP9qveUywknV5LSWJGYPAngVV5zZbTlOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3883
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEZhYmlvDQoNCj4gT24gRnJpLCBPY3QgMTEsIDIwMTkgYXQgNTozOSBBTSBBbnNvbiBIdWFu
ZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBJbiB0aGUgbGF0ZXN0
IHJlZmVyZW5jZSBtYW51YWwgUmV2LjAsMDYvMjAxOSwgdGhlIFNDRzEncyBzeXN0ZW0NCj4gDQo+
IFRoaXMgc2hvdWxkIGJlIFNDUyBpbnN0ZWFkIG9mIFNDRzEuDQoNClRoZSByZWZlcmVuY2Ugc3Rh
dGVzIFNDRyBzeXN0ZW0gY2xvY2ssIFNDUyBzdGFuZHMgZm9yIHN5c3RlbSBjbG9jayBzb3VyY2Us
IHNvIEkgdGhpbmsNCml0IGlzIGFjdHVhbGx5IG1lYW5pbmcgU0NHMSdzIHN5c3RlbSBjbG9jayBz
b3VyY2Xwn5iKIA0KDQpTZWxlY3RzIHRoZSBTQ0cgc3lzdGVtIGNsb2NrLg0KMDAwMGIgLSBSZXNl
cnZlZA0KMDAwMWIgLSBTeXN0ZW0gT1NDIChTT1NDX0NMSykNCjAwMTBiIC0gU2xvdyBJUkMgKFNJ
UkNfQ0xLKQ0KMDAxMWIgLSBGYXN0IElSQyAoRklSQ19DTEspDQowMTAwYiAtIFJlc2VydmVkDQow
MTAxYiAtIEF1eGlsaWFyeSBQTEwgKEFQTExfQ0xLKQ0KMDExMGIgLSBTeXN0ZW0gUExMIChTUExM
X0NMSykNCjAxMTFiIC0gUmVzZXJ2ZWQNCg0KPiANCj4gPiBjbG9jayBzb3VyY2Ugb3B0aW9uICM3
IGlzIG5vIGxvbmdlciBmcm9tIHVwbGwsIGl0IGlzIHJlc2VydmVkLCB1cGRhdGUNCj4gPiBjbG9j
ayBkcml2ZXIgYWNjb3JkaW5nbHkuDQo+ID4NCj4gPiBGaXhlczogYjEyNjAwNjdhYzNkICgiY2xr
OiBpbXg6IGFkZCBpbXg3dWxwIGNsayBkcml2ZXIiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29u
IEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IEZhYmlvIEVz
dGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4NCg0KVGhhbmtzLA0KQW5zb24NCg==
