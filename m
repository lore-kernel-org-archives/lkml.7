Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9068CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54748218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="JMGb3i82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfCUOev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:34:51 -0400
Received: from mail-eopbgr00106.outbound.protection.outlook.com ([40.107.0.106]:53632
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727823AbfCUOeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFckyKr0GZUT0VoNjaTtUXdgkxm9jeT9v9SudambvE0=;
 b=JMGb3i82ehdYEwbzChjwcpqEWJhtp0VW/I6JQKecJCG7bs6pP1HjPUkJpMyTXC7xTisZbdMrXv7wLhAiffP/xn0aMDXcRfpc+IQlllLkfC7FGTOU2HMGierwPIxAnpqL4cxAgAMVQELTx9STyWLrNmngdosLpI4EoYJa3F7kHHM=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB2142.EURPRD10.PROD.OUTLOOK.COM (20.177.60.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Thu, 21 Mar 2019 14:34:41 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cd0:b7e8:6608:b826]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cd0:b7e8:6608:b826%5]) with mapi id 15.20.1730.013; Thu, 21 Mar 2019
 14:34:41 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     Thomas Winding <twi@deif.com>, Fabio Estevam <festevam@gmail.com>,
        Per Christensen <pnc@deif.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] can: flexcan: bump FLEXCAN_TIMEOUT_US to 250
Thread-Topic: [PATCH] can: flexcan: bump FLEXCAN_TIMEOUT_US to 250
Thread-Index: AQHU1PaDftXKRmjpAUe9LFJjLfS9raYUlMMAgAGnvAA=
Date:   Thu, 21 Mar 2019 14:34:41 +0000
Message-ID: <5615c217-8ba6-e452-1aaa-1e3b32eb4cca@prevas.dk>
References: <20190307150024.23628-1-rasmus.villemoes@prevas.dk>
 <a418bbc9-186c-174a-20d8-18cedeaf0089@pengutronix.de>
In-Reply-To: <a418bbc9-186c-174a-20d8-18cedeaf0089@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0013.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::23) To VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e3::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc3a0c37-76f7-4576-1948-08d6ae0a5a7f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2142;
x-ms-traffictypediagnostic: VI1PR10MB2142:
x-microsoft-antispam-prvs: <VI1PR10MB2142264AEAE12754F3A0BD2D8A420@VI1PR10MB2142.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39850400004)(366004)(376002)(189003)(199004)(53936002)(81166006)(25786009)(6512007)(26005)(14454004)(81156014)(6486002)(97736004)(8676002)(102836004)(478600001)(6436002)(42882007)(72206003)(186003)(2906002)(71200400001)(71190400001)(68736007)(66066001)(6246003)(44832011)(31686004)(4326008)(105586002)(5660300002)(256004)(36756003)(6116002)(76176011)(3846002)(74482002)(7736002)(229853002)(53546011)(110136005)(386003)(8936002)(446003)(31696002)(486006)(305945005)(99286004)(52116002)(11346002)(8976002)(6506007)(476003)(54906003)(316002)(2616005)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB2142;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dhscIpAQkhKeOc159TLtJR48E1W64brvUUNjB9VqbGzhbWgftLRNlwcoVy4D55flwNEF3rP38+NDicvSCwzNqHoTUyXrpZCtyQnEb5xS4lU/idIYR47Db3fwQ+k5sApts93Fq+qG7QPinJSsgbyisfXeQIH8BGxc/L78xTCbstSQtWS3NPydiFoliNTnK3MCMfLnQ+3SyXKNoZojDe/qjlGXEAWtMQ1YFW6M0So9rID42udp1OToKoTv3Nv4t4zhHCnYT/TE6WshB0dYyujsm9NaoiUNdVpzJsjR8BddzFZpf0H3veORE4WvfBEnnjM+DRoNGOa5hHe/KHfcqUsVvvLvXn/yP3Uyk5bc4v3K32TUVTn92lt30H+4O4HfBkSLYqyzrGz/SLGYIMR+wW8lo3FgLTkyWFWhCkUppE53UIk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F68A1F9DC47EEB4E847DE7374D31F5DE@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3a0c37-76f7-4576-1948-08d6ae0a5a7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 14:34:41.3150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAvMDMvMjAxOSAxNC4xOCwgTWFyYyBLbGVpbmUtQnVkZGUgd3JvdGU6DQo+IE9uIDMvNy8x
OSA0OjAwIFBNLCBSYXNtdXMgVmlsbGVtb2VzIHdyb3RlOg0KPj4gV2hpbGUgdHJ5aW5nIHRvIGFk
ZCBzdXBwb3J0IGZvciB0aGUgRmxleGNhbiBtb2R1bGVzIG9uIHRoZSBNUEM4MzA5LA0KPj4gSSdt
IGhpdHRpbmcgRVRJTUVET1VUIGluIGZsZXhjYW5fY2hpcF9kaXNhYmxlKCkuIFdpdGggdGhpcywg
cHJvYmluZw0KPj4gc3VjY2VlZHMuIENoZWNraW5nIHRoZSBsZWZ0b3ZlciB2YWx1ZSBvZiB0aW1l
b3V0IHdpdGggYSBwcmltaXRpdmUNCj4+DQo+PiAgIHByX2VycigiJXM6IHRpbWVvdXQ9PSVkXG4i
LCBfX2Z1bmNfXywgdGltZW91dCk7DQo+Pg0KPj4gYWZ0ZXIgdGhlIGxvb3AgaW4gY2hpcF9kaXNh
YmxlKCkgdHlwaWNhbGx5IHNob3dzIHZhbHVlcyBhcm91bmQgMTItMTQsDQo+PiBpLmUuIHN1Z2dl
c3RpbmcgdGhhdCBpdCB0YWtlcyBhYm91dCAxMTAtMTMwIHVzIGZvciB0aGUgTFBNX0FDSyBiaXQg
dG8NCj4+IGFwcGVhci4gU28gYSB0aW1lb3V0IHZhbHVlIG9mIGFib3V0IHR3aWNlIHRoYXQgc2Vl
bXMgcmVhc29uYWJsZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBSYXNtdXMgVmlsbGVtb2VzIDxy
YXNtdXMudmlsbGVtb2VzQHByZXZhcy5kaz4NCj4gDQo+IEkndmUgc2NoZWR1bGVkIHRoZSBwYXRj
aCBieSBKb2FraW0gWmhhbmc6DQo+IA0KPiAgICAgOWRhZWQ4OWFlOGEzIGNhbjogZmxleGNhbjog
Zml4IHRpbWVvdXQgd2hlbiBzZXQgc21hbGwgYml0cmF0ZQ0KPiANCj4gdGhhdCBkb3VibGVzIHRo
ZSB0aW1lb3V0IHRvIDEwMC4NCg0KRWgsIG9rLCBidXQgdGhhdCdzIG5vdCBzdWZmaWNpZW50IGZv
ciB0aGUgTVBDODMwOSAoSSB0cmllZCB3aXRoIDEwMCBhdA0KZmlyc3QsIGJ1dCBhcyBJIHdyaXRl
IHRoZSBtaW5pbWFsbHkgd29ya2luZyB0aW1lb3V0IHZhbHVlIHR1cm5zIG91dCB0bw0KYmUgYWJv
dXQgMTQwIHVzKS4gRG8geW91IHdhbnQgbWUgdG8gc2VuZCBhbm90aGVyIHBhdGNoIG9uIHRvcCBv
Zg0KOWRhZWQ4OWFlOGEzLCBvciBob3cgc2hvdWxkIEkgaW50ZXJwcmV0IHRoZSBhYm92ZT8NCg0K
VGhhbmtzLA0KUmFzbXVzDQo=
