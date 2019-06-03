Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C109C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A7826D41
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="PUlmqQYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfFCSkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 14:40:05 -0400
Received: from mail-eopbgr30121.outbound.protection.outlook.com ([40.107.3.121]:44014
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726190AbfFCSkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fp4wmY8iWqMbJaWMfd2sNzRHyHq51bIhEGqR1fLAjaw=;
 b=PUlmqQYipYOV29DdZKqxMvFMjOyidugaQoHJE7OMgIdKxcKy8Hsx2TFzM1VEiER4rB67rB7rrXKwvbeD/Q4kZ+MLwZqMQSEJmPOxkKdGT4OVZyipHx/zOLUMqJ5ONlttg6L06Nd9MfbFtA6Eyg4aUD+cTWAqAcULF/Bvm4Qmvac=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3547.eurprd02.prod.outlook.com (52.134.72.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.18; Mon, 3 Jun 2019 18:39:58 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::49ac:3a71:a3ec:d6bf]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::49ac:3a71:a3ec:d6bf%5]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 18:39:58 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>
Subject: Re: [RFC PATCH 39/57] drivers: mux: Use class_find_device_by_of_node
 helper
Thread-Topic: [RFC PATCH 39/57] drivers: mux: Use class_find_device_by_of_node
 helper
Thread-Index: AQHVGiRK+afNbt1GvU2kh+pKzFah5qaKPjkA///k/ICAAB/7gA==
Date:   Mon, 3 Jun 2019 18:39:58 +0000
Message-ID: <b1166eea-8bd4-f3ae-5e0a-72e1f507a142@axentia.se>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-40-git-send-email-suzuki.poulose@arm.com>
 <bdfa93d6-a45f-cc26-bc95-42ef21c7e8c6@axentia.se>
 <0c98e540-ae82-4cf8-0936-0d61ae04eac7@arm.com>
In-Reply-To: <0c98e540-ae82-4cf8-0936-0d61ae04eac7@arm.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR02CA0087.eurprd02.prod.outlook.com
 (2603:10a6:7:29::16) To DB3PR0202MB3434.eurprd02.prod.outlook.com
 (2603:10a6:8:5::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de205eaf-d228-4d39-555b-08d6e852e0f7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB3PR0202MB3547;
x-ms-traffictypediagnostic: DB3PR0202MB3547:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB3PR0202MB35470E7A2DFE6F558A16859ABC140@DB3PR0202MB3547.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39840400004)(396003)(376002)(366004)(346002)(199004)(189003)(65826007)(54906003)(4744005)(110136005)(74482002)(64756008)(65806001)(65956001)(316002)(508600001)(58126008)(64126003)(256004)(2501003)(66476007)(66066001)(66446008)(31696002)(86362001)(6512007)(6436002)(53546011)(6506007)(6306002)(386003)(52116002)(99286004)(66946007)(5660300002)(68736007)(102836004)(73956011)(76176011)(7736002)(6246003)(25786009)(6116002)(66556008)(81156014)(81166006)(4326008)(8676002)(305945005)(53936002)(966005)(229853002)(36756003)(2906002)(3846002)(8936002)(6486002)(31686004)(486006)(2616005)(71200400001)(476003)(14454004)(71190400001)(446003)(11346002)(26005)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3547;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pkAnVATG3XR48W1HZ/LpNzr+7DVisK5DGCWGSxVvV8G0IOnPy3Ra6FVDjnU0NHZlzWmvzEmc0VlDbCJHoh/fbZGLHbD3iCHE56LY07kYEnFkspmNAR6AD41HlDNwgAkMH/k1zYwqOeXNjGXGVA7CHnH6A8TmEuWWtyPWFuFpcwOR0mKFenNfwqBiU6pSIoUMSV1GdNQbezb4Qef5pBkCcuVR8UXMA9vaWxHvjYZ9a5Qsd7sBCknDGeCxN5HkRGpMpslkOKPOn7T7TS+sfR1xwVgIPlQ6tDxZeIaleXEYTwhBrt7d+lqPeNJ6bOPNK75tlesj2iGRJ7GsyLCQuW6Hc2aSkngiLp+S4HMfLl875CkBl5W+UVX+v7WVzKsZbHKHwyctm2nLsOoDKqKI655R/7MGylBzdf1GcsdBdQATDTo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F2A5B9FB8B4884FB77EF6244F588FE0@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: de205eaf-d228-4d39-555b-08d6e852e0f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 18:39:58.1660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peda@axentia.se
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3547
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wNi0wMyAxODo0NSwgU3V6dWtpIEsgUG91bG9zZSB3cm90ZToNCj4gSGkgUGV0ZXIs
DQoNCj4gU29ycnkgYWJvdXQgdGhhdC4gVGhlIHJvdXRpbmUgaXMgYSB3cmFwcGVyIHRvIGNsYXNz
X2ZpbmRfZGV2aWNlKCkNCj4gd2hpY2ggdXNlcyBhIGdlbmVyaWMgcm91dGluZSB0byBtYXRjaCB0
aGUgb2Zfbm9kZSwgaW5zdGVhZCBvZiB0aGUNCj4gZHJpdmVyIHNwZWNpZmljIG9mX2Rldl9ub2Rl
X21hdGNoKCkuIFRoZSBzZXJpZXMgYWRkcyBzdWNoIHdyYXBwZXJzIGZvcg0KPiB7YnVzL2RyaXZl
cnMvY2xhc3N9X2ZpbmRfZGV2aWNlKCkuIFVuZm9ydHVuYXRlbHkgSSBkaWRuJ3QgYWRkDQo+IGlu
ZGl2aWR1YWwgZHJpdmVyIG1haW50YWluZXJzIHRvIHRoZSBwYXRjaGVzLCB3aGljaCBhZGQgdGhv
c2Ugd3JhcHBlcnMuDQo+IEZvciB0aGUgbW9tZW50LCBwbGVhc2UgZmluZCB0aGUgbGluayBiZWxv
dyBmb3IgdGhlIHBhdGNoIDoNCj4gDQo+IGh0dHBzOi8vbGttbC5rZXJuZWwub3JnL3IvMTU1OTU3
NzAyMy01NTgtMjktZ2l0LXNlbmQtZW1haWwtc3V6dWtpLnBvdWxvc2VAYXJtLmNvbQ0KPiANCj4g
DQo+IEkgd2lsbCB0cnkgdG8gYWRkcmVzcyBpdCBpbiB0aGUgbmV4dCByZXZpc2lvbi4NCg0KRm9y
IHRoZSByZWNvcmQsIHRoYXQgcGF0Y2ggcmVmZXJlbmNlcyBzb21lIG90aGVyIG5ldyBmdW5jdGlv
bg0KImRldmljZV9tYXRjaF9vZl9ub2RlIiBmb3Igd2hpY2ggSSBkbyBub3QgaGF2ZSBhIGRlZmlu
aXRpb24uIEJ1dCB3aXRoDQp0aGUgYWJvdmUgbGluaywgSSB3YXMgYWJsZSB0byBmaW5kIGl0IHdp
dGhvdXQgdG9vIG11Y2ggZWZmb3J0Lg0KDQpBbGwgbG9va3Mgb2sgdG8gbWUsIHNvLCBpZiB5b3Ug
Zml4IHRoYXQgYmxhbmsgbGluZSB0aGluZywNCg0KUmV2aWV3ZWQtYnk6IFBldGVyIFJvc2luIDxw
ZWRhQGF4ZW50aWEuc2U+DQoNCkNoZWVycywNClBldGVyDQo=
