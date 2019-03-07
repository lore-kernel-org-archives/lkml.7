Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBEDC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F3920663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d8zeyP7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfCGAqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:46:34 -0500
Received: from mail-eopbgr140055.outbound.protection.outlook.com ([40.107.14.55]:26182
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726120AbfCGAqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:46:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ts44rZGVt1qJ9SfBNwtimLxyTz1RTzaJnkzkoOud5gc=;
 b=d8zeyP7R5oCUaWs+M9ZYPGXF1SyR5vL/BELJ6TbryOlWAxW3BjCoGXbX3sM6qs/wAqWE6zxbVnAgt+IkLXhxfgo1sA5gAjKWgGzm7QoHfOteNzG+jmThAx4zMHa3TzdmTIKvywLAIYiKx/QVeHYN8Sa6GcHZmv/mr9brwLmUceg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3770.eurprd04.prod.outlook.com (52.134.73.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Thu, 7 Mar 2019 00:46:26 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1686.018; Thu, 7 Mar 2019
 00:46:26 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V7 3/3] firmware: imx: imx-scu: register build-in child
 devices
Thread-Topic: [PATCH V7 3/3] firmware: imx: imx-scu: register build-in child
 devices
Thread-Index: AQHU07jXrMvH/zwkr0CO9FJmEedWMKX+xWmAgACQ3JA=
Date:   Thu, 7 Mar 2019 00:46:26 +0000
Message-ID: <DB3PR0402MB3916DF9AD3B596C269775820F54C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1551834095-19950-1-git-send-email-Anson.Huang@nxp.com>
 <1551834095-19950-3-git-send-email-Anson.Huang@nxp.com>
 <90ff94d9-6f15-5353-c5a1-f2ec5ee744ad@roeck-us.net>
In-Reply-To: <90ff94d9-6f15-5353-c5a1-f2ec5ee744ad@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5622786-6f7b-4780-9e2f-08d6a2965489
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3770;
x-ms-traffictypediagnostic: DB3PR0402MB3770:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjNQUjA0MDJNQjM3NzA7MjM6YSthTHVISmd0cG14anhuYlVpTXdQbXFu?=
 =?utf-8?B?VEhVUTl0SjdHaEJ3QXgwMDlwQms0ZmdhRFVnQVRBUFRweHhKb3FXZ0Z6Mm53?=
 =?utf-8?B?MS9TT0MrSndYTnlTMzhZbjUyMHhqUGlWRmlCSEcxS1NxaE9nU01uSzVFUWl2?=
 =?utf-8?B?UVlVUE5OUllOczV2bVdaUWNXNGpLYTB6ZUNjaUdKbmZiWEhydlVyVGYyYytv?=
 =?utf-8?B?WnUweFF3ZHR2TmJQYXNBR211SjRWUWRtN1V2blZKREV3bFRtYU15WG12YjdU?=
 =?utf-8?B?VnVhQVQxV1ptSDJlSGI4UTFnMmZLdEEyNkc4TStVTUtaUE8waUxwdUhsU0Yx?=
 =?utf-8?B?QUU4MENUYnBFa3dIVnFKeUFnNzYrNlJBbVNQRTQ2MkNmUWg3dGJOc0t2NTJ4?=
 =?utf-8?B?OWNMaHl1S2dlOVRKejhlNkZjTnAyL0JCeEVLZmZIQTJzd1Q0aGFDU3hKcUlk?=
 =?utf-8?B?SHZFK3JwMnQ3bVp3YmtCaHN3OG9YOFBmUE95aTZhNWJkc3ZPcXc3Rnp6blVM?=
 =?utf-8?B?UkJhMDlxbmpVdCtudVRYNXpSV3A0N05wcjZndDZNYkhueFJZL2xrbWRNdytV?=
 =?utf-8?B?aVFlcUZFR0pZbGtmaC9mNFEwZThVTFBncUR1MlgyUWZQaVYzZE5BZGk0cXg3?=
 =?utf-8?B?bTk1eUwyV3F0blFpM1JFR2t6R214ODJBOHoySXB4MWFOREhzUnFrVGJYaXhT?=
 =?utf-8?B?aEdPdnBVKzd3QkpTMW5ZT0gwTXAzUjZidTE3VHNOUHNEZ2xER3hiaFpvU015?=
 =?utf-8?B?eFZRTGZUZ09PUVh2T2thQXdLQmVkY0JIWWdGdWtUT2d0S2tNZUxvbmtRZFNJ?=
 =?utf-8?B?b3VWajVTcGp1Uy9pbEphMjE2UUw1emRvQTY1V05CN1RhUnh0RzIrN3RaTTJP?=
 =?utf-8?B?bVM4MkwyZm9zRVoxRXdKL0lrc2NPNytkaDBDVmY0cU5JRFFueVk5UG05Ry9w?=
 =?utf-8?B?Z3FEU25kWUtwNm1sNzdoQWVDVkRlczdvYTROdGRhN2FUWUlOUUZYZFFPby9N?=
 =?utf-8?B?NkdCNEVsaGtlTGNwNTJ1WGtLOVlFZndGSkgwTnlXUmZaTHN0dythTUpSNmtU?=
 =?utf-8?B?MkQ4VEM3OGlSTVhZTlNUaUx5b3IzVVUrT2dZaXdXTHk2RW4zNjloNkkyekxP?=
 =?utf-8?B?QURGajZmM0M5cGxWSjZxZ0V1cVB3Mk1VSm1ZRmxTbHYzZlNzS2l1OWpyRkIy?=
 =?utf-8?B?NG5yQ3Rja0RNdjlqYXFJTU5hajdFbGE3MUJiY0F0cUJKeklCcmllK1FRVlda?=
 =?utf-8?B?NGRsSlhTM2F5UVZmdEpnaFVWM3RYL0pQOCsxNytOcm1RbUhjTmtaVmxrbVZB?=
 =?utf-8?B?c2dSLzV3OXVGU1dlZ2JHdVltVmxGRDhhRnVaOEFwK1FNdkZ4OE5ONSthTXNW?=
 =?utf-8?B?VFVNanBPeHlGTDNVOWhDQlRaR0ZySCtQQkpsa3FJL3FVZzRZRlV4dGZJQ2hB?=
 =?utf-8?B?eHllMkU2aHE4cTFpZUtSVG5BRkxNcFJVaXpFOTZEcUJwMFZSMklIeTZqdjZi?=
 =?utf-8?B?Z0lkY2RqTVZzcE9OZmRIaGE3Yzc5ZDIxSUpEeGplUVJGclUwa1E3ZEQxNjE5?=
 =?utf-8?B?SFZTb3BrZnRqZzBBYkMvNG1ZaWRDRVFIVmdXaVBLbjlyMW1SUDJkUlJYSEZn?=
 =?utf-8?B?NzhnQWFMRTJteE1uT2RWLzBFUWdUbFM0ZnljL0o2bmhnMHdBekRjOG5rSU9q?=
 =?utf-8?B?NC9xMXM1L0xKUmN5dFFBQStEdHZsTlI3K1F6cFh6TkkveHUzSVkrU3ZNMlJs?=
 =?utf-8?B?L0l1dXhscnFZWEJLaUp6UUhEMXFDVGlyQXVqMXdBemVmUXJFalZ5c3ZMeWpt?=
 =?utf-8?B?eUFwNWNaVU50UmJ5V0gwdzJWM2RybnBHZk0wV3MvUFQ5RXpNK3lSM0M3WUZC?=
 =?utf-8?Q?hSEV2Nv15UR2w=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3770A11835B692C2E0C254BAF54C0@DB3PR0402MB3770.eurprd04.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(396003)(136003)(346002)(13464003)(199004)(189003)(86362001)(66066001)(2501003)(9686003)(97736004)(44832011)(2201001)(55016002)(486006)(6116002)(3846002)(105586002)(11346002)(106356001)(7416002)(229853002)(71200400001)(186003)(71190400001)(6436002)(26005)(102836004)(2906002)(68736007)(110136005)(6506007)(53546011)(478600001)(6246003)(256004)(52536013)(76176011)(74316002)(305945005)(7736002)(316002)(7696005)(4326008)(99286004)(446003)(8676002)(53936002)(81156014)(8936002)(5660300002)(81166006)(14454004)(33656002)(25786009)(476003)(921003)(1121003)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3770;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r20QHa9Ei74a8N4eXkxvuGolCLhWvE0tfyl2bWV6kSaVimrgH2616Xc9FTZR5aCUzUMRcgL6Sqyz/9o1BOpEW46dwJlt24q6RADvKqcmKsQTg2OUvzZvW9MxBL5v/g6CxhcNSI2O1cOOso5J8puc3hELNqHNwyezsxCPVCoe5PDpPpRWXOmhxb1qQ9SjBR4OIK9Ht3ujddvcWIKuY5GQq9YsgLrJoa9kMmqusxAuv6YYGvcb7ejM6dgle/Of/FTkKzqp7qCSdxplocO/JfXpNAN8iEarj3fvvCUtqFXxh8DPhv4OLiR7KthRp7dEoUy3v8vYuemjS6R+8FdGRJsoCZTsLWdSDQf8PRwWrxwgRo0O4wzdmQSwt1WUI4GK50iv7ccmmksoNapsec9WOBnCD+1W/sg2BRkvX4z39VeFAuo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5622786-6f7b-4780-9e2f-08d6a2965489
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 00:46:26.5352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3770
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEd1ZW50ZXINCg0KQmVzdCBSZWdhcmRzIQ0KQW5zb24gSHVhbmcNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHdWVudGVyIFJvZWNrIFttYWlsdG86Z3JvZWNrN0Bn
bWFpbC5jb21dIE9uIEJlaGFsZiBPZiBHdWVudGVyDQo+IFJvZWNrDQo+IFNlbnQ6IDIwMTnlubQz
5pyIN+aXpSAwOjA2DQo+IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT47IGNh
dGFsaW4ubWFyaW5hc0Bhcm0uY29tOw0KPiB3aWxsLmRlYWNvbkBhcm0uY29tOyBzaGF3bmd1b0Br
ZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXgu
ZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgd2ltQGxpbnV4LXdhdGNoZG9nLm9yZzsNCj4gQW5keSBH
cm9zcyA8YW5keS5ncm9zc0BsaW5hcm8ub3JnPjsgaGVpa29Ac250ZWNoLmRlOw0KPiBob3Jtcyty
ZW5lc2FzQHZlcmdlLm5ldC5hdTsgYXJuZEBhcm5kYi5kZTsNCj4gbWF4aW1lLnJpcGFyZEBib290
bGluLmNvbTsgamFnYW5AYW1hcnVsYXNvbHV0aW9ucy5jb207DQo+IGJqb3JuLmFuZGVyc3NvbkBs
aW5hcm8ub3JnOyBlbnJpYy5iYWxsZXRib0Bjb2xsYWJvcmEuY29tOw0KPiBtYXJjLncuZ29uemFs
ZXpAZnJlZS5mcjsgb2xvZkBsaXhvbS5uZXQ7IEFpc2hlbmcgRG9uZw0KPiA8YWlzaGVuZy5kb25n
QG54cC5jb20+OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0K
PiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC13YXRjaGRvZ0B2Z2VyLmtlcm5lbC5vcmcN
Cj4gQ2M6IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggVjcgMy8zXSBmaXJtd2FyZTogaW14OiBpbXgtc2N1OiByZWdpc3RlciBidWlsZC1pbiBj
aGlsZA0KPiBkZXZpY2VzDQo+IA0KPiBIaSwNCj4gDQo+IE9uIDMvNS8xOSA1OjA2IFBNLCBBbnNv
biBIdWFuZyB3cm90ZToNCj4gPiBGb3Igc29tZSBkZXZpY2VzIHdoaWNoIGFyZSBjb250cm9sbGVk
IGJ5IHN5c3RlbSBjb250cm9sbGVyLCB0aGV5IGFyZQ0KPiA+IE5PVCBwcmVzZW50IGluIGRldmlj
ZSB0cmVlIHNpbmNlIG5vIGhhcmR3YXJlIGluZm8gbmVlZGVkLCBqdXN0DQo+ID4gcmVnaXN0ZXIg
dGhlc2UgZGV2aWNlcyBhcyBjaGlsZHJlbiBvZiBTQ1UgZGV2aWNlLg0KPiA+IFRoaXMgcGF0Y2gg
cmVnaXN0ZXJzIGkuTVggc3lzdGVtIGNvbnRyb2xsZXIgd2F0Y2hkb2cgcGxhdGZvcm0gZGV2aWNl
DQo+ID4gYXMgY2hpbGQgZGV2aWNlIG9mIFNDVS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFu
c29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+IE5vIGNoYW5nZXMu
DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2Zpcm13YXJlL2lteC9pbXgtc2N1LmMgfCA4ICsrKysr
KysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9pbXgvaW14LXNjdS5jDQo+ID4gYi9kcml2ZXJzL2Zp
cm13YXJlL2lteC9pbXgtc2N1LmMgaW5kZXggMmJiMWExOS4uZGY3NWVhZCAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2Zpcm13YXJlL2lteC9pbXgtc2N1LmMNCj4gPiArKysgYi9kcml2ZXJzL2Zp
cm13YXJlL2lteC9pbXgtc2N1LmMNCj4gPiBAQCAtMTk2LDYgKzE5Niw3IEBAIEVYUE9SVF9TWU1C
T0woaW14X3NjdV9jYWxsX3JwYyk7DQo+ID4NCj4gPiAgIHN0YXRpYyBpbnQgaW14X3NjdV9wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAgew0KPiA+ICsJc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqY2hpbGRfcGRldjsNCj4gPiAgIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAm
cGRldi0+ZGV2Ow0KPiA+ICAgCXN0cnVjdCBpbXhfc2NfaXBjICpzY19pcGM7DQo+ID4gICAJc3Ry
dWN0IGlteF9zY19jaGFuICpzY19jaGFuOw0KPiA+IEBAIC0yNDgsNiArMjQ5LDEzIEBAIHN0YXRp
YyBpbnQgaW14X3NjdV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ID4gKnBkZXYpDQo+
ID4NCj4gPiAgIAlkZXZfaW5mbyhkZXYsICJOWFAgaS5NWCBTQ1UgSW5pdGlhbGl6ZWRcbiIpOw0K
PiA+DQo+ID4gKwkvKiByZWdpc3RlciBTQ1UgY2hpbGQgZGV2aWNlcyB3aGljaCBhcmUgTk9UIGlu
IGRldmljZSB0cmVlICovDQo+ID4gKwljaGlsZF9wZGV2ID0gcGxhdGZvcm1fZGV2aWNlX3JlZ2lz
dGVyX2RhdGEoZGV2LCAiaW14LXNjLXdkdCIsDQo+ID4gKwkJCQlQTEFURk9STV9ERVZJRF9OT05F
LCBOVUxMLCAwKTsNCj4gPiArCWlmIChJU19FUlIoY2hpbGRfcGRldikpDQo+ID4gKwkJZGV2X3dh
cm4oZGV2LCAiZmFpbGVkIHRvIHJlZ2lzdGVyIHNjdSB3YXRjaGRvZw0KPiBkZXZpY2UgJWxkIVxu
IiwNCj4gPiArCQkJIFBUUl9FUlIoY2hpbGRfcGRldikpOw0KPiA+ICsNCj4gDQo+IEkganVzdCBy
ZWFsaXplZCAuLi4gc2luY2UgdGhpcyBpcyBub3QgYSBkZXZtXyBmdW5jdGlvbiwgd2Ugbm93IGFs
c28gbmVlZCBlcnJvcg0KPiBoYW5kbGluZyAoaWYgZGV2bV9vZl9wbGF0Zm9ybV9wb3B1bGF0ZSgp
IGZhaWxzKSBhbmQgYSByZW1vdmUgZnVuY3Rpb24uDQo+IFNvcnJ5IGZvciB0aGF0IC0gSSBzaG91
bGQgaGF2ZSBub3RpY2VkIGVhcmxpZXIuDQoNClRoYW5rcywgSSB3aWxsIGFkZCBlcnJvciBoYW5k
bGluZyBoZXJlIG9uY2Ugd2UgbWFrZSBkZWNpc2lvbiBvZiBwdXR0aW5nIGRldmljZSByZWdpc3Rl
cg0KaGVyZSwgd2UgaGF2ZSBvdGhlciBzY2VuYXJpb3MgbWF5IG5lZWQgdG8gaGF2ZSB3YXRjaGRv
ZyBub2RlIGluIERULCBpZiBSb2IgYWdyZWUNCnRvIGhhdmUgaXQgaW4gRFQsIHRoaXMgcGF0Y2gg
d2lsbCBiZSBkaXNjYXJkZWQuDQoNCkFuc29uLg0KDQo+IA0KPiBHdWVudGVyDQo+IA0KPiA+ICAg
CXJldHVybiBkZXZtX29mX3BsYXRmb3JtX3BvcHVsYXRlKGRldik7DQo+ID4gICB9DQo+ID4NCj4g
Pg0KDQo=
