Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEB6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB9D20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="XgmsI9M9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfCKK7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 06:59:50 -0400
Received: from mail-eopbgr80105.outbound.protection.outlook.com ([40.107.8.105]:4848
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726605AbfCKK7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 06:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QD/tiev8hH1Qd31Kc7mGToPJVU97kH+dwDLV+95vEaM=;
 b=XgmsI9M9Kc0wX7W/MmZH+EvpKrcuTITTS5UkgdBfoMUeB2SEhfX4gwXwbg/EROIydwHS0xQ+FCJDNgXgfLn2AIRK5rJIJGI5pQ41QTxDzdk8Q+M6TtPWH7+hCO0GWFqLaJq7LW9Nc9bYojSL6n9GVgB1rdICECv6EOZP8BgnDOw=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB0752.EURPRD10.PROD.OUTLOOK.COM (10.167.203.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.20; Mon, 11 Mar 2019 10:59:45 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::51c2:2f6a:3148:4a1f]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::51c2:2f6a:3148:4a1f%3]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 10:59:45 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>, Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "Per N. Christensen" <pnc@deif.com>, Thomas Winding <twi@deif.com>
Subject: replacement for CAN_LEDS
Thread-Topic: replacement for CAN_LEDS
Thread-Index: AQHU1/mJxZiRQLZ/JEmSksIg8zngHQ==
Date:   Mon, 11 Mar 2019 10:59:45 +0000
Message-ID: <729bdb48-8253-282a-2e0b-860ec5ff345c@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0015.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::25) To VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e3::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c428b70f-2b90-42b3-b0ed-08d6a610ac12
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB0752;
x-ms-traffictypediagnostic: VI1PR10MB0752:
x-microsoft-antispam-prvs: <VI1PR10MB0752CF34F5FD945B6CB86AD88A480@VI1PR10MB0752.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39850400004)(376002)(366004)(189003)(199004)(6436002)(54906003)(2906002)(31696002)(316002)(106356001)(110136005)(7736002)(486006)(476003)(31686004)(6512007)(305945005)(97736004)(4326008)(53936002)(25786009)(105586002)(6116002)(7116003)(3846002)(6486002)(74482002)(66066001)(478600001)(71200400001)(71190400001)(14454004)(72206003)(44832011)(14444005)(256004)(5660300002)(81156014)(26005)(8676002)(36756003)(8976002)(81166006)(186003)(8936002)(102836004)(68736007)(386003)(6506007)(2616005)(52116002)(42882007)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB0752;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjEwTUIwNzUyOzIzOm9Jd3JYL2lEbGc5RzVhSDd6SlMvenVwVHlh?=
 =?utf-8?B?ZFRMQkQ2OGlIaWhWYVRlampLbE9JcllPQyt5ZEdsMkZ1cXN4bHlpQU8yU3Ex?=
 =?utf-8?B?TVU5TkZ0OW4va1lrZEF0a3UwcXhrVGwwck5jZVl0VzlLazM5bFpmK3Y2aHlV?=
 =?utf-8?B?blFzVDF6TjZ3eG15eWlDQ1Y3SHAzMkx2WEpUT2Fxb1FFNURSS2hxVzdhbW5M?=
 =?utf-8?B?MUU5VUl3VHNBTUNvV0Q1Rzk0Zm54UEJPcXA4S2t1YWRacnlNV25JTHc1b1d0?=
 =?utf-8?B?TVhiSXdnOHdhQ3IyL0kxWGxVK2xCTGdhVGNESlVYK2Q2WEZ4TjRsV1oxam5q?=
 =?utf-8?B?ZnJBZk9WWGRPc0R2WFRyM1V1TXoyS1NpdDV4amJBOUZ2MitlV09uVlJUV05a?=
 =?utf-8?B?aEdUQm11OUozZ3ZIa0phZUEvNG8yd0VsR3NRdE1wNFFkZDJnZHh3SGFZa1RN?=
 =?utf-8?B?eXVJaS9jcHErbHl4U0dWREZGMjI1QWtYeVE4dko0QkZ1d2hFZ0o4WjNicTc3?=
 =?utf-8?B?Nmg1UlhGY0c4UmN5MXh5ZzNGMC80SHJYNkFrRzF6YUpka3pFb2JHRU95K0dp?=
 =?utf-8?B?Q2o4eTErTGM0UThrYVBSS0ZXbzhTaVJJUW1SSHowRm5LdXRnYW5UMERFNlpG?=
 =?utf-8?B?a0x3cFVzWHcvUCs1Yk1LSWh5UkU0cjJlcDJMbjFLQXdpTVVPclNvT1c5d1hx?=
 =?utf-8?B?QVRGUzZ3SExaR3RPRTUrTWU1UUNiZThmTEgxWFBHc255VWNIeTk1Wmx1elUw?=
 =?utf-8?B?aXZVWlFNSWtWNFU4czRySjh4SzA2OVV6Ym1kNU5GVjZIK1p4ZGZQYkpLVmcx?=
 =?utf-8?B?QWh2aWhDRUpTVUhPNEY0NlgzOCtsVzkzelJjdVpralE1bFpGRjQ5V0JlWGVS?=
 =?utf-8?B?b0VyQm90a3dabzl1UDd2SGczYzN1bVlQK3ptM3h3Z3pZTUN4dlpqa2lqZWxz?=
 =?utf-8?B?U1FKWFlYK0o4S3ZwU09HczBWTFlGTzlydEFtSVRSVUJVeFhuMkozUUorQ3JI?=
 =?utf-8?B?czJQWUs5dlRLUUJFNU50aHlCSm1WZUQxaTQ1amNOSWNsTkVOeDg0L01odXc2?=
 =?utf-8?B?SHMreTRJT2ZzdERlandHL2JucGpSODRIK0ZjTFpOc0FpVzBpOXJtWm9UcHk5?=
 =?utf-8?B?aWcrUzNoRC9iQlFFUFhLeks5eWhubXlId0poTWNQSGt6ZkJZK0NULzNhTHlB?=
 =?utf-8?B?d3VReittS3oxZDhkOGJuVzg2bUptUG1wdjl3TytYcEQ2TjR0OGFHV1BLNHNx?=
 =?utf-8?B?L3dmcjhrbXA0YzNBekx5cWtOeEdDNkN4TFJGMy9sNHUzVTROMzV4OGJYV3VJ?=
 =?utf-8?B?S1ZDWWd0aG9LVGw0VTc3YUk1dmRjZnBSSGhwaG1rbWpMTmpiYmZabzh0RUNp?=
 =?utf-8?B?SWNvTEFzSHNNTmZ1RDg3ZnJnSHRRUFdVcFFGQ29Fa1JLSFZVUFpRNkdReVVh?=
 =?utf-8?B?bWJzS1pjb241SjdaTGJSSGVsbkUwZ1N2eS93UndkQjVaL0VoY241dzZnSXJi?=
 =?utf-8?B?QmlKOThDVTFDckQzTitjdTRURWdXRHNZczdCOHdNUDVwUXVQYjZNR1BYV254?=
 =?utf-8?B?ZXNwcUNLSkY5bkY1NktkU0g2YnpNaUFlZkxtSStaeWVBMW8ycjBjVU5ESXB6?=
 =?utf-8?B?cEh2OC9KVlQ1dzJmYjU4a2tRZ0xoVEFQOGRKOWl0SnVuVWFVY1NSOEg1WnhZ?=
 =?utf-8?Q?qBVtE7BA5ZM66PuaN7KOgY0VtPMjT/VpJUHEjAV?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mNwkI3HKW72jR7T+WmCEuhWKZsdgqH009FO3iO0BCL52O8aLKDWYwDnnKMkQbbdq9E2d+Lp6MuBltS0E7rb0Xt5ApnP0qxDkSm3NgYSZjPU+cnYMo7f4ajSs8O/pF4bdrZmQbz/RUEqT3WLWVAchXjt9RIncGeJ6EMpK9qNTQ++0QTRPGZZ/mANcW+v02BV0qIIET6W3Kot9MB04aGjAKlc5HcooYDPTNR03yUoRUEIoqN9qD6ACHJs38nc/fcndqGF4Svw1ivSih44tRB0WR/jPFGUc5fzbYJOEmhGfb1n4M22TNxyGfis5lU7RcP9B5CdHlNmv5sHUwOAAWYTggkE847j7pvBVQWhamwgoyMWSB2MHEPzGLziUkNj08KYTs7AA3KdTGa4NlHz1k+JN6mLhPkdP8+XheaR8swt2s1c=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DEA274D7774CC48BAC6F0672FE6BAF0@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c428b70f-2b90-42b3-b0ed-08d6a610ac12
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 10:59:45.8729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB0752
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCg0KSSdtIGluIHRoZSBwcm9jZXNzIG9mIHVwZ3JhZGluZyBhbiBvbGQgQlNQIHRvIGEgNC4x
OSBrZXJuZWwsIGFuZCBub3RpY2VkDQp0aGF0IENBTl9MRURTIGhhcyBiZWVuIG1hcmtlZCBicm9r
ZW4uIFRoZSBjb21tZW50cyBzYXkgdGhhdCB0aGUgbmV0ZGV2DQp0cmlnZ2VyIGNhbiBkbyBldmVy
eXRoaW5nLCBidXQgZG9lc24ndCBwcm92aWRlIG11Y2ggZ3VpZGFuY2Ugb24gaG93IHRvDQphY3R1
YWxseSBkbyB0aGUgdHJhbnNpdGlvbi4NCg0KSW4gbXkgY2FzZSwgSSB1c2VkIHRvIGhhdmUgYSBk
ZXZpY2UgdHJlZSBub2RlDQoNCiAgICAgICAgICAgICAgICBjYW5iIHsNCiAgICAgICAgICAgICAg
ICAgICAgICAgIGxhYmVsID0gImNhbmI6Z3JlZW46YWN0aXZpdHkiOw0KICAgICAgICAgICAgICAg
ICAgICAgICAgZ3Bpb3MgPSA8JmdwaW8wIDUgMD47DQogICAgICAgICAgICAgICAgICAgICAgICBk
ZWZhdWx0LXN0YXRlID0gIm9mZiI7DQogICAgICAgICAgICAgICAgICAgICAgICBsaW51eCxkZWZh
dWx0LXRyaWdnZXIgPSAiY2FuMS1yeHR4IjsNCiAgICAgICAgICAgICAgICB9Ow0KDQphbmQgaWYg
SSBjaGFuZ2UgdGhlIGRlZmF1bHQtdHJpZ2dlciB0byBuZXRkZXYsIEkgZ2V0IHN5c2ZzIGZpbGVz
IGluDQovc3lzL2NsYXNzL2xlZHMvY2FuYjpncmVlbjphY3Rpdml0eSA7IGlmIEkgdGhlbiBlY2hv
IGNhbjEgdG8gZGV2aWNlX25hbWUNCmFuZCAxIHRvIHJ4LHR4LCBhbmQgbGluaywgSSBnZXQgdGhl
IGJlaGF2aW91ciBJIHVzZWQgdG8gaGF2ZS4NCg0KUXVlc3Rpb25zOiBtdXN0IHRoaXMgc2V0dXAg
YmUgZG9uZSBpbiB1c2Vyc3BhY2UgbGlrZSB0aGlzPyBJcyB0aGVyZSBzb21lDQp1ZGV2IHJ1bGUg
dGVtcGxhdGUgSSBjb3VsZCBjb3B5PyBJIGNhbiBhbHNvIGp1c3QgaGFyZGNvZGUgdGhlIGFib3Zl
DQpkYW5jZSBpbiBzb21lIGluaXQgc2NyaXB0Lg0KDQpJJ2QgYWN0dWFsbHkgcHJlZmVyIGtlZXBp
bmcgdGhlIGVudGlyZSBzZXR1cCBpbiBkZXZpY2UgdHJlZS4gU28gd291bGQgaXQNCmJlIHBvc3Np
YmxlIHRvIGhhdmUgbmV0ZGV2X3RyaWdfYWN0aXZhdGUoKSBsb29rIGZvciBzb21lIHByb3BlcnRp
ZXMgaW4NCnRoZSBEVCBub2RlIGZvciB0aGUgbGVkX2NsYXNzZGV2IGFuZCBwb3B1bGF0ZSAtPmRl
dmljZV9uYW1lIGFuZCAtPm1vZGUNCmJhc2VkIG9uIHRoZW0/DQoNClJhc211cw0K
