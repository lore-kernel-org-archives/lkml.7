Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6CFC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 04:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE322087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 04:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="D3w3Zocg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfCAEv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 23:51:29 -0500
Received: from mail-eopbgr150070.outbound.protection.outlook.com ([40.107.15.70]:25859
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbfCAEv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 23:51:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKfCH+nuaaE+/R4fa2qT0VwGZ57zmvKwZ2el7tIafko=;
 b=D3w3Zocg+QwMO5030c3JsA7EdymTwOPjWtOXAopVjVcXqQfzVLVm9FUOMv07xrB27W+KwU4yoTz7WmXmH3VCs7qHgTtP2KDM08ObjR5LPwWBe9JUmRGR3Y4RHrKy2vuOm1tkv/lZQ/KYeACWVWxUZexWWWC1iA4PH/Msxyf/YxE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3915.eurprd04.prod.outlook.com (52.134.71.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Fri, 1 Mar 2019 04:51:21 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 04:51:21 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 1/2] watchdog: imx_sc: Add i.MX system controller
 watchdog support
Thread-Topic: [PATCH V4 1/2] watchdog: imx_sc: Add i.MX system controller
 watchdog support
Thread-Index: AQHUzzuQ+7Ug3zH4/EOjIZQiRro2RaX1TagAgAC439CAACd6AIAACApQ
Date:   Fri, 1 Mar 2019 04:51:21 +0000
Message-ID: <DB3PR0402MB39160F0C0E924DAACCD574D6F5760@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1551340510-2324-1-git-send-email-Anson.Huang@nxp.com>
 <575f5a40-5590-12fc-e117-a97577982844@roeck-us.net>
 <DB3PR0402MB391655BBF367452B7BF6A7CEF5760@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <dcc27575-8191-cfa9-4991-c02b399860df@roeck-us.net>
In-Reply-To: <dcc27575-8191-cfa9-4991-c02b399860df@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ac8dc78-4b45-4d8f-8d7f-08d69e018ce4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3915;
x-ms-traffictypediagnostic: DB3PR0402MB3915:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjNQUjA0MDJNQjM5MTU7MjM6Qi9PVkJKRU1ULzlVOGZpYUZBbHVRQm90?=
 =?utf-8?B?RElOTnJJYUZnUm01eGdvT2JwaldzTDFhdm5vYWZQYWRGL3c4ZWlGc2Fqeitk?=
 =?utf-8?B?Y2x5TXJRN25lK2FhY0RuMndaTnk4c21oSnBjL1lqWmQxdVVnWVhmd2c3eHFF?=
 =?utf-8?B?M0hQWFprUUR4NVlFR1VZR0lBbm9GRk1OekRhQWZiRXQyYWpIei9WVitjRDBa?=
 =?utf-8?B?blJvQUYvVUZuUm9QQXpiY2g1eElwWVNRY2FFTDY5dTNudTgzQ2dyUFNRTHI0?=
 =?utf-8?B?K1EzQWd1ZlhUSlNITVJkbGhRR3FLSWJiUnpXc01heUhWaHlndlNIUGhscTV4?=
 =?utf-8?B?UWtwWHoyUHdqR2lGaWxib3F1dEFlWXZIODNvdVhXaUJNeE9uRmFrcmF5NEpD?=
 =?utf-8?B?SDJpcUxqbkpJTUN1ZVMxb2tValJiUjZBWkxsTGFMZ2EvWTAyWUhKdjZnVWZ6?=
 =?utf-8?B?Z3kxSDcvUEZiQUdoVjByWXU2blVDRzFpVzNMa3hNSUpYOCtYQWh6OXZocHlI?=
 =?utf-8?B?cE9jUlY0Q0dTRHcwZWljYnFvUjFoek5zMHJINHNuRnFpYXBneXVCWFZ2V1B5?=
 =?utf-8?B?WXhDTUtUeVp2Q0pwWWNqNzZ6YVdEMFZ3OVJjVWVVSDVWTi94MlpNaTRySDRW?=
 =?utf-8?B?U2NuQWRBcS95UnFYRllqWTdaYy9lLys3aWhMQkZPdnc0eGxRMm0ybnRRWWRz?=
 =?utf-8?B?TkFQbEd6d2U5TzNxVjNzWGxTR0FGUmZKUy9pNmhhQk1DZkZndzJWTUc0R2xE?=
 =?utf-8?B?OWR0Z01lc1JRWTc5eEVHUTZZVHVUTEt3MVY4RnRILzlRLzg5REE1dG5WYWov?=
 =?utf-8?B?WHVpMURrczdUSjV4T0loOFdrQTEveUo3a1BEL25MSEw4ZkRiOHBaTzQ0bzlo?=
 =?utf-8?B?WmtobGhZNHd1K0VaaXdjSkNrcVJ0c0UzcnE1dWdLVjZmRzNuUXBtWWRnbHFE?=
 =?utf-8?B?dlUvcXJNUndoUjVEZ3NXNWRMSTd5NkdGSC90b0Fsc2pNSmZGSHVjZ0E4b1kr?=
 =?utf-8?B?S25WVmtVVWpDRncrcXpESWNkbFdWaVd1VTNIK1BzNXpZUXpIL3ZvTCsvUEN6?=
 =?utf-8?B?Q3Z0N3NwZ3FnWVhEb1Y4T05NVzNMSFBMRmlCa0dEWjdQejRLQWpITmVoakhi?=
 =?utf-8?B?SXVxNStmK1pSblVPOG9yTzJQZGNtcHlHdlVabHAzcUdGS1hJdkI4TnFYYXF0?=
 =?utf-8?B?ZVl3Vk8xNjM5SHBoMlhqVnFkU21TWXZKTVhLREFiTk5vZzB6UHpIRnl1MDFv?=
 =?utf-8?B?ZHVNNDFQWWozeUx1L0pWRCtzVTV2cUQ2OXB0Yi8xb1BaSjJNbG1GS3Z6YXBS?=
 =?utf-8?B?bWhpRWdlSjFiSCtNT3liV3pBTHpwVzh0Yml6RjM5K0lJTHJHZStEQWVvdjZW?=
 =?utf-8?B?cGtXNzA3bzJBVnpoVm1SeFFYNUVsd1FvMTI3OVE5cVF6ak1meGtQaXozeWpW?=
 =?utf-8?B?c3FNY1RlL1N1aXpXM00ydHlVRlY4dWFGUEZrbWNNVG1wbFg4YmgxTlk3WmxF?=
 =?utf-8?B?akUrNngzS01nM0NsRmhEcGpLYkhOaGlEbW9EeCtJZjdlT3RCTWk0WGhiY2lt?=
 =?utf-8?B?Z2ZmK2REQmRzbEZHWUVHWWZZK2toemFicG1qRWd4dUdxSjZqWlNUUVhDRVFB?=
 =?utf-8?B?QjVNWlJObTR1dFF3bnV5MXdMRFJDNW9yRzRFS1lLVi84dHNZb2ozZHp5bUtl?=
 =?utf-8?B?Vi9KWlpKUWV4bnkyNTdSSWhkdlZFMC9XOWVQOHlRRlNIemRabzdKMnF1SExB?=
 =?utf-8?B?QjNON0djYXJQcjA0dVp1U01vSkgvcGRkR1RXNENzN2xxcnlRcHI0U0t0TnFr?=
 =?utf-8?B?SEEwRkdyWHhuU0oxdjlwSHFDc2VpaTY1YkFNTm1VRUVJT0FoN1RXMjhUeHBq?=
 =?utf-8?B?MGwrUkQ3OVM2Vk9uQ3ovVWQwaWNNMXNERHpQeVZHV05VQ3cySGtUdStCenE4?=
 =?utf-8?Q?tOLg6m6uLmSKuZbAdNv7OTHjzVHlUvGw=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3915A3FCF071AFB52FABDB08F5760@DB3PR0402MB3915.eurprd04.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39860400002)(136003)(396003)(13464003)(189003)(199004)(51874003)(81156014)(81166006)(256004)(478600001)(99286004)(86362001)(55016002)(5660300002)(7736002)(14444005)(66066001)(9686003)(8676002)(305945005)(53936002)(93886005)(486006)(52536013)(2906002)(71190400001)(7696005)(71200400001)(2201001)(68736007)(6246003)(76176011)(26005)(74316002)(229853002)(6506007)(102836004)(53546011)(6436002)(3846002)(25786009)(8936002)(6116002)(14454004)(7416002)(97736004)(4326008)(316002)(33656002)(106356001)(105586002)(11346002)(44832011)(476003)(110136005)(2501003)(186003)(446003)(921003)(15866825006)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3915;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NC160WHAyJeRvnFLKycGnEUSM+O2At/kDcTRimpcZYChqnrvo984Lom8QethKx7e5RfNO+N7gKjzJqnzMUof12Z+C4ilhJA9fumHkMApPkR/N0KBXjHQ1vP4DhXH7L7FvHNRl7R8OAP90Dop3jjoHmhX+nGCBA4fIaT+/8m/gN7LY5zyHoAiorgnXsANhasH2VVzHr/LZNBVknBNFBXWGhNOq+KI6NNfAz+v63xAdhk7C4rqF/h2hHEai4y8MX+nEPCu7mN0pbEaZZafaZN0WUGcPcYKeTPbfXHOAcvtXxtincENQPXlCPNEDIcErJsHd10d9LPqCH6bNrU50QCjPbh4xD+cHGs3K/TsdkmHYRzMu58R66CGZiagu9V55zRMGbliCH5VQ6q7Ydsr5ekiGHz6boloTCg/RKhObGSoyh4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac8dc78-4b45-4d8f-8d7f-08d69e018ce4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 04:51:21.4337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3915
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEd1ZW50ZXINCg0KQmVzdCBSZWdhcmRzIQ0KQW5zb24gSHVhbmcNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHdWVudGVyIFJvZWNrIFttYWlsdG86Z3JvZWNrN0Bn
bWFpbC5jb21dIE9uIEJlaGFsZiBPZiBHdWVudGVyDQo+IFJvZWNrDQo+IFNlbnQ6IDIwMTnlubQz
5pyIMeaXpSAxMjoyMQ0KPiBUbzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+OyBj
YXRhbGluLm1hcmluYXNAYXJtLmNvbTsNCj4gd2lsbC5kZWFjb25AYXJtLmNvbTsgd2ltQGxpbnV4
LXdhdGNoZG9nLm9yZzsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gcy5oYXVlckBwZW5ndXRyb25p
eC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IEFuZHkg
R3Jvc3MgPGFuZHkuZ3Jvc3NAbGluYXJvLm9yZz47IGhlaWtvQHNudGVjaC5kZTsNCj4gaG9ybXMr
cmVuZXNhc0B2ZXJnZS5uZXQuYXU7IGFybmRAYXJuZGIuZGU7IG9sb2ZAbGl4b20ubmV0Ow0KPiBq
YWdhbkBhbWFydWxhc29sdXRpb25zLmNvbTsgYmpvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc7DQo+
IGVucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb207IG1hcmMudy5nb256YWxlekBmcmVlLmZyOyBs
aW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC0NCj4gd2F0Y2hkb2dAdmdlci5rZXJuZWwub3JnDQo+IENjOiBk
bC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFY0
IDEvMl0gd2F0Y2hkb2c6IGlteF9zYzogQWRkIGkuTVggc3lzdGVtIGNvbnRyb2xsZXINCj4gd2F0
Y2hkb2cgc3VwcG9ydA0KPiANCj4gT24gMi8yOC8xOSA3OjQ2IFBNLCBBbnNvbiBIdWFuZyB3cm90
ZToNCj4gPiBIaSwgR3VlbnRlcg0KPiA+DQo+ID4gQmVzdCBSZWdhcmRzIQ0KPiA+IEFuc29uIEh1
YW5nDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogR3Vl
bnRlciBSb2VjayBbbWFpbHRvOmdyb2VjazdAZ21haWwuY29tXSBPbiBCZWhhbGYgT2YgR3VlbnRl
cg0KPiA+PiBSb2Vjaw0KPiA+PiBTZW50OiAyMDE55bm0MuaciDI45pelIDIyOjU4DQo+ID4+IFRv
OiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT47IGNhdGFsaW4ubWFyaW5hc0Bhcm0u
Y29tOw0KPiA+PiB3aWxsLmRlYWNvbkBhcm0uY29tOyB3aW1AbGludXgtd2F0Y2hkb2cub3JnOyBz
aGF3bmd1b0BrZXJuZWwub3JnOw0KPiA+PiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxA
cGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gPj4gQW5keSBHcm9zcyA8YW5k
eS5ncm9zc0BsaW5hcm8ub3JnPjsgaGVpa29Ac250ZWNoLmRlOw0KPiA+PiBob3JtcytyZW5lc2Fz
QHZlcmdlLm5ldC5hdTsgYXJuZEBhcm5kYi5kZTsgb2xvZkBsaXhvbS5uZXQ7DQo+ID4+IGphZ2Fu
QGFtYXJ1bGFzb2x1dGlvbnMuY29tOyBiam9ybi5hbmRlcnNzb25AbGluYXJvLm9yZzsNCj4gPj4g
ZW5yaWMuYmFsbGV0Ym9AY29sbGFib3JhLmNvbTsgbWFyYy53LmdvbnphbGV6QGZyZWUuZnI7IGxp
bnV4LWFybS0NCj4gPj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiA+PiB3YXRjaGRvZ0B2Z2VyLmtlcm5lbC5vcmcNCj4g
Pj4gQ2M6IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+ID4+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggVjQgMS8yXSB3YXRjaGRvZzogaW14X3NjOiBBZGQgaS5NWCBzeXN0ZW0NCj4gPj4g
Y29udHJvbGxlciB3YXRjaGRvZyBzdXBwb3J0DQo+ID4+DQo+ID4+IE9uIDIvMjcvMTkgMTE6NTkg
UE0sIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+Pj4gaS5NWDhRWFAgaXMgYW4gQVJNdjggU29DIHdo
aWNoIGhhcyBhIENvcnRleC1NNCBzeXN0ZW0gY29udHJvbGxlcg0KPiA+Pj4gaW5zaWRlLCB0aGUg
c3lzdGVtIGNvbnRyb2xsZXIgaXMgaW4gY2hhcmdlIG9mIGNvbnRyb2xsaW5nIHBvd2VyLA0KPiA+
Pj4gY2xvY2sgYW5kIHdhdGNoZG9nIGV0Yy4uDQo+ID4+Pg0KPiA+Pj4gVGhpcyBwYXRjaCBhZGRz
IGkuTVggc3lzdGVtIGNvbnRyb2xsZXIgd2F0Y2hkb2cgZHJpdmVyIHN1cHBvcnQsDQo+ID4+PiB3
YXRjaGRvZyBvcGVyYXRpb24gbmVlZHMgdG8gYmUgZG9uZSBpbiBzZWN1cmUgRUwzIG1vZGUgdmlh
DQo+ID4+PiBBUk0tVHJ1c3RlZC1GaXJtd2FyZSwgdXNpbmcgU01DIGNhbGwsIENQVSB3aWxsIHRy
YXAgaW50bw0KPiA+Pj4gQVJNLVRydXN0ZWQtRmlybXdhcmUgYW5kIHRoZW4gaXQgd2lsbCByZXF1
ZXN0IHN5c3RlbSBjb250cm9sbGVyIHRvDQo+ID4+PiBkbyB3YXRjaGRvZyBvcGVyYXRpb24gdmlh
IElQQy4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVh
bmdAbnhwLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gQ2hhbmdlcyBzaW5jZSBWMzoNCj4gPj4+ICAg
ICAgICAgICAtIGFkZCBBUk02NCBkZXBlbmRlbmN5IGZvciB0aGlzIGRyaXZlcjsNCj4gPj4+ICAg
ICAgICAgICAtIGNoYW5nZSBTUERYIGxpY2Vuc2UgdG8gR1BMLTIuMCB0byBtYXRjaCBtb2R1bGUg
bGljZW5zZTsNCj4gPj4+ICAgICAgICAgICAtIHJlZ2lzdGVyIHBsYXRmb3JtIGRldmljZSBpbiBk
cml2ZXIgaW5zdGVhZCBvZiBnZXR0aW5nIGZyb20gZHRzOw0KPiA+Pj4gCS0gcmV0dXJuIGxpbnV4
IGVycm9yIGNvZGUgaW5zdGVhZCBvZiBzeXN0ZW0gY29udHJvbGxlciBmaXJtd2FyZQ0KPiA+Pj4g
ZXJyb3INCj4gPj4gY29kZSBmb3Igd2F0Y2hkb2cgb3BlcmF0aW9uDQo+ID4+PiAJICBmYWlsZWQg
Y2FzZS4NCj4gPj4+IC0tLQ0KPiA+Pj4gICAgZHJpdmVycy93YXRjaGRvZy9LY29uZmlnICAgICAg
fCAgMTMgKysrDQo+ID4+PiAgICBkcml2ZXJzL3dhdGNoZG9nL01ha2VmaWxlICAgICB8ICAgMSAr
DQo+ID4+PiAgICBkcml2ZXJzL3dhdGNoZG9nL2lteF9zY193ZHQuYyB8IDIwMQ0KPiA+PiArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPj4+ICAgIDMgZmlsZXMg
Y2hhbmdlZCwgMjE1IGluc2VydGlvbnMoKykNCj4gPj4+ICAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL3dhdGNoZG9nL2lteF9zY193ZHQuYw0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3dhdGNoZG9nL0tjb25maWcgYi9kcml2ZXJzL3dhdGNoZG9nL0tjb25maWcNCj4gPj4+
IGluZGV4IDY1YzNjNDIuLjhjNjU3NWUgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL3dhdGNo
ZG9nL0tjb25maWcNCj4gPj4+ICsrKyBiL2RyaXZlcnMvd2F0Y2hkb2cvS2NvbmZpZw0KPiA+Pj4g
QEAgLTYyNSw2ICs2MjUsMTkgQEAgY29uZmlnIElNWDJfV0RUDQo+ID4+PiAgICAJICBUbyBjb21w
aWxlIHRoaXMgZHJpdmVyIGFzIGEgbW9kdWxlLCBjaG9vc2UgTSBoZXJlOiB0aGUNCj4gPj4+ICAg
IAkgIG1vZHVsZSB3aWxsIGJlIGNhbGxlZCBpbXgyX3dkdC4NCj4gPj4+DQo+ID4+PiArY29uZmln
IElNWF9TQ19XRFQNCj4gPj4+ICsJdHJpc3RhdGUgIklNWCBTQyBXYXRjaGRvZyINCj4gPj4+ICsJ
ZGVwZW5kcyBvbiAoQVJDSF9NWEMgJiYgQVJNNjQpIHx8IENPTVBJTEVfVEVTVA0KPiA+Pj4gKwlz
ZWxlY3QgV0FUQ0hET0dfQ09SRQ0KPiA+Pj4gKwloZWxwDQo+ID4+PiArCSAgVGhpcyBpcyB0aGUg
ZHJpdmVyIGZvciB0aGUgc3lzdGVtIGNvbnRyb2xsZXIgd2F0Y2hkb2cNCj4gPj4+ICsJICBvbiB0
aGUgTlhQIGkuTVggU29DcyB3aXRoIHN5c3RlbSBjb250cm9sbGVyIGluc2lkZS4NCj4gPj4+ICsJ
ICBJZiB5b3UgaGF2ZSBvbmUgb2YgdGhlc2UgcHJvY2Vzc29ycyBhbmQgd2lzaCB0byBoYXZlDQo+
ID4+PiArCSAgd2F0Y2hkb2cgc3VwcG9ydCBlbmFibGVkLCBzYXkgWSwgb3RoZXJ3aXNlIHNheSBO
Lg0KPiA+Pj4gKw0KPiA+Pj4gKwkgIFRvIGNvbXBpbGUgdGhpcyBkcml2ZXIgYXMgYSBtb2R1bGUs
IGNob29zZSBNIGhlcmU6IHRoZQ0KPiA+Pj4gKwkgIG1vZHVsZSB3aWxsIGJlIGNhbGxlZCBpbXhf
c2Nfd2R0Lg0KPiA+Pj4gKw0KPiA+Pg0KPiA+PiBXaXRoIHRoaXMgcGF0Y2ggYXBwbGllZCwgYWxw
aGE6YWxsbW9kY29uZmlnIGFuZCBhbG1vc3QgYWxsIG90aGVyDQo+ID4+IGFsbG1vZGNvbmZpZy9h
bGx5ZXNjb25maWcgYnVpbGRzIGZhaWwgd2l0aDoNCj4gPj4NCj4gPj4gRVJST1I6ICJfX2FybV9z
bWNjY19zbWMiIFtkcml2ZXJzL3dhdGNoZG9nL2lteF9zY193ZHQua29dDQo+IHVuZGVmaW5lZCEN
Cj4gPj4gc2NyaXB0cy9NYWtlZmlsZS5tb2Rwb3N0OjkyOiByZWNpcGUgZm9yIHRhcmdldCAnX19t
b2Rwb3N0JyBmYWlsZWQNCj4gPj4gbWFrZVsxXTogKioqIFtfX21vZHBvc3RdIEVycm9yIDENCj4g
Pj4gTWFrZWZpbGU6MTI2MDogcmVjaXBlIGZvciB0YXJnZXQgJ21vZHVsZXMnIGZhaWxlZA0KPiA+
Pg0KPiA+PiBhcyBJIHRvbGQgeW91IGJlZm9yZSB3b3VsZCBoYXBwZW4uIEZvciB0aGUgZnV0dXJl
LCBwbGVhc2UgY29uc2lkZXINCj4gPj4gdGhhdCBmb3JjaW5nIG1lIHRvICJwcm92ZSIgc3VjaCBm
YWlsdXJlcyBkb2VzIHRha2UgYSBzaWduaWZpY2FudA0KPiA+PiBhbW91bnQgb2YgdGltZSwgd2hp
Y2ggaXMgbm90IGFsd2F5cyByZWFkaWx5IGF2YWlsYWJsZS4NCj4gPg0KPiA+IFNvcnJ5IGZvciB3
YXN0aW5nIHlvdXIgdGltZSwgaXQgaXMganVzdCBiZWNhdXNlIEkgbWlzdW5kZXJzdGFuZCB5b3Vy
DQo+ID4gcG9pbnQsIE5PVCB0aGF0IEkgZGlkIE5PVCBmb3JjZSB5b3UgdG8gcHJvdmUgaXQuDQo+
ID4NCj4gPiBJIGFtIGEgbGl0dGxlIGNvbmZ1c2UsIHNpbmNlIHRoaXMgaXMgbmV3IHRvIG1lIGFi
b3V0IHRoZXNlIGNvbmZpZ3MsIEkNCj4gPiBsb29rZWQgaW50byBvdGhlciBkcml2ZXJzIHdoaWNo
IGFsc28gdXNlIGFybV9zbWNjY19zbWMsIHRoZXkgZG8gTk9UDQo+ID4gYWRkIHNwZWNpYWwgY29u
ZmlnIGRlcGVuZGVuY3kgZm9yIHRoZSBmYWlsdXJlIGJ1aWxkIGNhdXNlIGFzIHlvdSBzYWlkLA0K
PiA+IGNhbiB5b3UgYmUgbW9yZSBkZXRhaWwgYWJvdXQgdGhpcyBidWlsZCBpc3N1ZSwgSSB0cmll
ZCBiZWxvdyBidWlsZCwNCj4gPiBidXQgdGhlIGZhaWx1cmUgSSBtZXQgaXMgb3RoZXIsIHNvIGNv
dWxkIHlvdSBwbGVhc2UgYWR2aXNlIGhvdyB0byBmaXgNCj4gPiBzdWNoIGRlcGVuZGVuY3kgaXNz
dWUsIGFkZGluZyBkdW1teSBmdW5jdGlvbiBsb29rcyBsaWtlIE5PVCBhIGdvb2Qgd2F5DQo+ID4g
c2luY2UgdGhpcyBhcm1fc21jY2Nfc21jKCkgQVBJIGlzIHdpZGVseSB1c2VkIGluIGtlcm5lbCwg
dGhlcmUgc2hvdWxkIGJlDQo+IHNvbWUgY29tbW9uIHNvbHV0aW9uIGZvciBpdCwgVGhhbmtzIGlu
IGFkdmFuY2VkIGFuZCBhcHByZWNpYXRlIGZvciB5b3VyDQo+IHRpbWUuDQo+ID4NCj4gDQo+IEkg
YW0gcXVpdGUgc3VyZSB0aGF0IHRoZSBvdGhlciBkcml2ZXJzIGNhbGxpbmcgYXJtX3NtY2NjX3Nt
YyBkb24ndCBoYXZlICJ8fA0KPiBDT01QSUxFX1RFU1QiIGFzIGRlcGVuZGVuY3ksIG9yIHRoZXkg
aGF2ZSBhIHNlY29uZGFyeSBkZXBlbmRlbmN5Lg0KPiANCj4gUmFuZG9tbHkgcGlja2luZyBzb21l
DQo+IA0KPiBSVENfRFJWX0lNWF9TQyAtIG5vLg0KPiBBUk1fUkszMzk5X0RNQ19ERVZGUkVRIC0g
bm8uDQo+IFBIWV9NVkVCVV9BMzcwMF9DT01QSFkgLSB5ZXMsIGJ1dCBpdCBhbHNvIGhhcyAiZGVw
ZW5kcyBvbg0KPiBIQVZFX0FSTV9TTUNDQyIgYXMgc2VwYXJhdGUgbGluZSwgbGltaXRpbmcgaXRz
IHNjb3BlLg0KPiANCj4gWW91IGNhbiBlaXRoZXIgZHJvcCAifHwgQ09NUElMRV9URVNUIiBvciBh
ZGQgImRlcGVuZHMgb24NCj4gSEFWRV9BUk1fU01DQ0MiDQo+IGluIGEgc2VwYXJhdGUgbGluZS4g
VGhlcmUgbWF5IGJlIG90aGVyIG9wdGlvbnMsIGJ1dCBJIGRpZCBub3QgZXhwbG9yZSB0aGVtLg0K
DQpNYW55IHRoYW5rcyBmb3IgeW91ciBkZXRhaWwgaW5mbywgSSB3aWxsIGFkZCBkZXBlbmRzIG9u
ICIgSEFWRV9BUk1fU01DQ0MgIg0KaW4gVjUgcGF0Y2ggc2VyaWVzLg0KDQpBbnNvbi4NCg0KPiAN
Cj4gR3VlbnRlcg0K
