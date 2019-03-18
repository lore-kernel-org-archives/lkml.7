Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EF2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAD42075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="UxnEbKcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfCRHkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 03:40:53 -0400
Received: from mail-eopbgr50103.outbound.protection.outlook.com ([40.107.5.103]:20201
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726135AbfCRHkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 03:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4TewQDdwNiiFmj+zaH0xNeoE1bddFG3vTzkZOV5U6c=;
 b=UxnEbKcdW+QgLFVL4sKSuKJoAPrT4mOgywpuEdlRs5Seqwn4Uc4/q1iVR8jXWjdqFE54NWZ0qzD8SHsbtarVACQ/7Pzj71aSghYC9FsZze1AQuemklaNZsbgIpclqPqot1xMrrA3mzKql138jjX5j3GXZwKBK0r6KaZ7eNFYslY=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB2013.EURPRD10.PROD.OUTLOOK.COM (52.134.28.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Mon, 18 Mar 2019 07:40:49 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cd0:b7e8:6608:b826]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cd0:b7e8:6608:b826%4]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 07:40:49 +0000
From:   Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>
CC:     Thomas Winding <twi@deif.com>, Fabio Estevam <festevam@gmail.com>,
        Per Christensen <pnc@deif.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] can: flexcan: bump FLEXCAN_TIMEOUT_US to 250
Thread-Topic: [PATCH] can: flexcan: bump FLEXCAN_TIMEOUT_US to 250
Thread-Index: AQHU1PaDftXKRmjpAUe9LFJjLfS9raYREd4A
Date:   Mon, 18 Mar 2019 07:40:49 +0000
Message-ID: <1b3e9a9d-50ed-ca75-300a-b4a0cba38e7b@prevas.se>
References: <20190307150024.23628-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20190307150024.23628-1-rasmus.villemoes@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::27) To VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e3::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2d3e9b4-3dfa-4ee8-485c-08d6ab750a5f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2013;
x-ms-traffictypediagnostic: VI1PR10MB2013:
x-microsoft-antispam-prvs: <VI1PR10MB2013B99E1D0F2AB566BCD0F58A470@VI1PR10MB2013.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(136003)(396003)(39850400004)(189003)(199004)(76176011)(86362001)(81156014)(6512007)(6486002)(81166006)(316002)(186003)(72206003)(66066001)(478600001)(36756003)(31686004)(52116002)(74482002)(97736004)(7736002)(3846002)(6116002)(305945005)(68736007)(71190400001)(71200400001)(5660300002)(476003)(6246003)(446003)(11346002)(53936002)(26005)(4326008)(25786009)(102836004)(2906002)(6436002)(2616005)(229853002)(6506007)(486006)(386003)(54906003)(14444005)(256004)(99286004)(106356001)(8936002)(105586002)(110136005)(8676002)(44832011)(31696002)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB2013;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: V0bASvQYwUtmROvkWzNf+LZfIIIdzoTKgt43LgfJhLtA6f9fJ2XwJj4uFOxZmcj0M1S3r7ffQ2u2RhRuUaRk9qSWFwflQuds58vPB9s5zKWVQuWYLDJpHbIs7LM/4EZdcbHb8rEGW87yqpFeMgADyFMpSgIszYJxuK4HN6GuHujjMJZUwQrFoBjzm0wC1r5jskn3ZkPafth1EPNflz4Q+cqDTU5ijtGBCBAr/rcE5lf2egJ+RjYVI0aG37BidluBoV+zOGjuR2sZg/7Cd9qZc/myQZ7m09wdAS86y/UfhwBlw/mZ+UCEI0JyBjyn8agyhaLjEUQruZuKfyBicWBgubvdA9WHj661C2R1DtOIJd914qczSpq55Vk/T8FiDcpuu5drUKUEWptDMmNInaXI9SckW7PbwC6piCZw4aMudNg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68B8D8787FA2ED439AF9B2857098CB0D@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: prevas.se
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d3e9b4-3dfa-4ee8-485c-08d6ab750a5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 07:40:49.7286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cGluZw0KDQpPbiAwNy8wMy8yMDE5IDE2LjAwLCBSYXNtdXMgVmlsbGVtb2VzIHdyb3RlOg0KPiBX
aGlsZSB0cnlpbmcgdG8gYWRkIHN1cHBvcnQgZm9yIHRoZSBGbGV4Y2FuIG1vZHVsZXMgb24gdGhl
IE1QQzgzMDksDQo+IEknbSBoaXR0aW5nIEVUSU1FRE9VVCBpbiBmbGV4Y2FuX2NoaXBfZGlzYWJs
ZSgpLiBXaXRoIHRoaXMsIHByb2JpbmcNCj4gc3VjY2VlZHMuIENoZWNraW5nIHRoZSBsZWZ0b3Zl
ciB2YWx1ZSBvZiB0aW1lb3V0IHdpdGggYSBwcmltaXRpdmUNCj4gDQo+ICAgcHJfZXJyKCIlczog
dGltZW91dD09JWRcbiIsIF9fZnVuY19fLCB0aW1lb3V0KTsNCj4gDQo+IGFmdGVyIHRoZSBsb29w
IGluIGNoaXBfZGlzYWJsZSgpIHR5cGljYWxseSBzaG93cyB2YWx1ZXMgYXJvdW5kIDEyLTE0LA0K
PiBpLmUuIHN1Z2dlc3RpbmcgdGhhdCBpdCB0YWtlcyBhYm91dCAxMTAtMTMwIHVzIGZvciB0aGUg
TFBNX0FDSyBiaXQgdG8NCj4gYXBwZWFyLiBTbyBhIHRpbWVvdXQgdmFsdWUgb2YgYWJvdXQgdHdp
Y2UgdGhhdCBzZWVtcyByZWFzb25hYmxlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFzbXVzIFZp
bGxlbW9lcyA8cmFzbXVzLnZpbGxlbW9lc0BwcmV2YXMuZGs+DQo+IC0tLQ0KPiAgZHJpdmVycy9u
ZXQvY2FuL2ZsZXhjYW4uYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi9mbGV4
Y2FuLmMgYi9kcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jDQo+IGluZGV4IDc1Y2UxMTM5NWVlOC4u
NWYzMjA1M2Y3OGRlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jDQo+
ICsrKyBiL2RyaXZlcnMvbmV0L2Nhbi9mbGV4Y2FuLmMNCj4gQEAgLTE2NSw3ICsxNjUsNyBAQA0K
PiAgI2RlZmluZSBGTEVYQ0FOX01CX0NOVF9MRU5HVEgoeCkJKCgoeCkgJiAweGYpIDw8IDE2KQ0K
PiAgI2RlZmluZSBGTEVYQ0FOX01CX0NOVF9USU1FU1RBTVAoeCkJKCh4KSAmIDB4ZmZmZikNCj4g
IA0KPiAtI2RlZmluZSBGTEVYQ0FOX1RJTUVPVVRfVVMJCSg1MCkNCj4gKyNkZWZpbmUgRkxFWENB
Tl9USU1FT1VUX1VTCQkoMjUwKQ0KPiAgDQo+ICAvKiBGTEVYQ0FOIGhhcmR3YXJlIGZlYXR1cmUg
ZmxhZ3MNCj4gICAqDQo+IA0KDQo=
