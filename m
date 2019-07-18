Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767BEC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C41F21019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="q1d06y03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390030AbfGRL4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 07:56:45 -0400
Received: from mail-eopbgr150082.outbound.protection.outlook.com ([40.107.15.82]:29189
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726715AbfGRL4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 07:56:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WE4ALOVDuJFUyuyBkIte6ArAS7shr0jOmmhN7T9D9dzMFppO5VzRHHrkcq/Nu6AnC3g2tLwg8u3mQUlq2+5R2T1TsHjKC2EEcwFD2bhGoy6bZDpL256qybV7vXc5p0FJ/A50dJemsFfkmQq4OZjolbEnGoqTLQHxAXG+fqYlFOLLqz8h0WYX02SsieyS26VLhyd074YxtPhbkgKcQbam9MN/vofweQCYFfRvwCM4Dy0KMOmUdMfNjYSk7ALklELSJcP+/UkbtFRtMMsahJX1D93etsDGwTmuqywDyq58lY+Ai9bgUIiLCd6Z6a5r/hKarQINPb7JSdW2f0yMGvtdtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7ExNfHtlk5a3KabM+mFANZDnoIpKyvrUB8LZsAFLDs=;
 b=PcqDYCnWyM0Y9Fmcaam38Nc8soIBjoQYoaVCxNnMNk9fsno1/bwmIXY/fSaX5BXvUd3Gq4de2OPvUtiFMxoazM42cqTGJIb0IOleUL0UgY5Tbe52vRiRwOWpszIs1pDfqsFyyBjqSEUqzlyPPgX3DGCsL6TAEZ4bp8VuBVFbUtsCWfdKvcR87PTQFvMp01k/7IYVBswzivnQOZBbGCEirsxIxx1PZqBGuw7U0usLlJHAzSN5N7UT4bN4aYTmFOGqbwfwH4vJG740YjeXwFyf4BYM0r/KoaBGrX4bWoyhe39paGlo61/tk4jUNBBHGPd3Jt0v4fHsEzCr6a0cU1XVWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7ExNfHtlk5a3KabM+mFANZDnoIpKyvrUB8LZsAFLDs=;
 b=q1d06y03ICjTSB/m4s020Os35zO+jBOnl2ywyGklBS7znUVVOdl1GpTB9PH8ugaqwRekXfho+Sth5PIakMBwEcnl8V9EmE9Yf8gg7JBLmfX3oaV4jwfaO4JJMumhpItac1m2AnbL9CX25IyxC+VnwvJE3/Q2EXfui+JZtDGFwhM=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB6244.eurprd04.prod.outlook.com (20.179.35.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Thu, 18 Jul 2019 11:56:40 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::7882:51:e491:8431]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::7882:51:e491:8431%7]) with mapi id 15.20.2073.012; Thu, 18 Jul 2019
 11:56:39 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "=kernel@pengutronix.de" <=kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Paul Olaru <paul.olaru@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: RE: [PATCH v2 2/3] firmware: imx: scu-pd: Add mu13 b side PD range
Thread-Topic: [PATCH v2 2/3] firmware: imx: scu-pd: Add mu13 b side PD range
Thread-Index: AQHVPVMc0qtnnMI0Y0WS697thzHtTKbQRO/A
Date:   Thu, 18 Jul 2019 11:56:39 +0000
Message-ID: <AM0PR04MB4211F835E34473C57C1B7C8480C80@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190718102519.31855-1-daniel.baluta@nxp.com>
 <20190718102519.31855-3-daniel.baluta@nxp.com>
In-Reply-To: <20190718102519.31855-3-daniel.baluta@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fe11c33-7fa3-4496-eab0-08d70b76fe71
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6244;
x-ms-traffictypediagnostic: AM0PR04MB6244:
x-microsoft-antispam-prvs: <AM0PR04MB62449E92AED3AB406320ABDA80C80@AM0PR04MB6244.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(189003)(199004)(9686003)(26005)(2501003)(53936002)(66476007)(2906002)(71200400001)(76176011)(6246003)(11346002)(4326008)(102836004)(7696005)(64756008)(66446008)(76116006)(66556008)(229853002)(6506007)(14454004)(446003)(5660300002)(71190400001)(305945005)(8676002)(66946007)(55016002)(256004)(186003)(86362001)(74316002)(7736002)(6436002)(8936002)(81156014)(66066001)(44832011)(6116002)(110136005)(99286004)(486006)(54906003)(81166006)(68736007)(476003)(52536014)(3846002)(33656002)(4744005)(25786009)(478600001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6244;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RlFNY8c7vuhfUWbDrqlZu9oVcHc+l1rymvglJiqiS9Dng/gCRCAdN0xXVRi3XkPth3LFllUyPd6X5X8LsFMl0Ie3jhUkUlJPL2VSmpHF7efuDuEVNC2kofWTciTU0DlZMjtN1q1cpXqNDB9dB7UnM2hbXOcWPEak3D44fNzodo/CbMBl0CLIVSlO33mNlf1xtXTZ/2OYIzg1ZkGUnBRLnCoJXC+pmVaPXl8GxqfYiL1/3B5G8cDrT+ZIp4aBLH0OTsHBPxVcO2d6yK9bvdMzmFhRlb9TjCfVE0LdbPNAqZpSZyDgQoJst0xLwFY6Dt3jKaCSkZMgsgA9nsfeoFgCmtF2ip2nquv70UdvAuC5WlKw45OkF/vdTowkcZ149DMpeDFzEtE8r8Onf1DQLeWI8cK0ozbiQUwjNbLtioJa4b0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe11c33-7fa3-4496-eab0-08d70b76fe71
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 11:56:39.8599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aisheng.dong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6244
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBEYW5pZWwgQmFsdXRhIDxkYW5pZWwuYmFsdXRhQG54cC5jb20+DQo+IFNlbnQ6IFRo
dXJzZGF5LCBKdWx5IDE4LCAyMDE5IDY6MjUgUE0NCj4gDQo+IExTSU8gc3Vic3lzdGVtIGNvbnRh
aW5zIDE0IE1VIGluc3RhbmNlcy4NCj4gDQo+IDUgTVVzIHRvIGNvbW11bmljYXRlIGJldHdlZW4g
QVAgPC0+IFNDVQ0KPiAgIC0gc2lkZS1BIFBEIHJhbmdlIG1hbmFnZWQgYnkgQVANCj4gICAtIHNp
ZGUtQiBQRCByYW5nZSBtYW5hZ2VkIGJ5IFNDVQ0KPiANCj4gOSBNVXMgdG8gY29tbXVuaWNhdGUg
YmV0d2VlbiBhbGwgY29yZXMgKEFQL000L0RTUCkuDQo+ICAgLSBzaWRlLUEgUEQgcmFuZ2UgbWFu
YWdlZCBieSBjb3JlLUEgKEFQL000L0RTUCkNCj4gICAtIHNpZGUtQiBQRCByYW5nZSBtYW5hZ2Vk
IGJ5IGNvcmUtQiAoQVAvTTQvRFNQKS4NCj4gDQo+IENvbW11bmljYXRpb24gYmV0d2VlbiBBUCA8
LT4gRFNQIGlzIGRvbmUgdGhyb3VnaCB0aGUgYXNzaWduZWQgTVUgbnVtYmVyDQo+IDEzLg0KPiAN
Cj4gU28sIHdlIHBvd2VyIHVwIHNpZGUtQSBieSB0aGUgQVAgYW5kIHdlIGRlY2lkZSB0byBwb3dl
ciB1cCBzaWRlLUIgYWxzbyBmcm9tDQo+IEFQLiBUaGlzIGlzIGJlY2F1c2UgcG93ZXJpbmcgaXQg
dXAgZnJvbSBEU1Agd291bGQgYmUgcGFpbmZ1bC4NCj4gDQo+IFBvd2VyaW5nIHVwIHNpZGUgQiBm
cm9tIERTUCB3b3VsZCByZXF1aXJlIHRoZSBEU1AgdG8gY29tbXVuaWNhdGUgd2l0aCBTQ1UNCj4g
YW5kIHRvIGtlZXAgdGhpbmdzIHNpbXBsZSB3ZSBkb24ndCB3YW50IHRoYXQgbm93Lg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPg0KDQpS
ZXZpZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCg0KUmVnYXJk
cw0KQWlzaGVuZw0K
