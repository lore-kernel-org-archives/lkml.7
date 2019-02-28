Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2676BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 00:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B889021850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 00:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ApZMP19K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbfB1AsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 19:48:04 -0500
Received: from mail-eopbgr50042.outbound.protection.outlook.com ([40.107.5.42]:37856
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730139AbfB1AsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 19:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2SZzDFxV4BZuhu6QABd4iXHLg/HkdaS4qlwG6MsN2Y=;
 b=ApZMP19K8AtC4gjbICk6uwJpzDpar58q+beH1vGzcdKEL6lpwbw9BzO3PJ5OOdkfhGsteLq/7wz9itgagusofL0SMapW+FEo1JGp71WnxQ9Ym2RFYmTuDN3+vxoXxxihQwbCdsS7UHyMdNU/2wrzHGrYjz+PloheGmVSOpjenaE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3721.eurprd04.prod.outlook.com (52.134.67.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Thu, 28 Feb 2019 00:47:56 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Thu, 28 Feb 2019
 00:47:56 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V10 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Topic: [PATCH V10 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Index: AQHUznjp1VM2Vv0vQ0qLNAgNlgUeAaX0UrqAgAALZRA=
Date:   Thu, 28 Feb 2019 00:47:56 +0000
Message-ID: <DB3PR0402MB391673518C43A0ABE9BDB55FF5750@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1551256894-21954-1-git-send-email-Anson.Huang@nxp.com>
 <20190227235455.GA15211@bogus>
In-Reply-To: <20190227235455.GA15211@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d99cd8df-d846-4585-1e9e-08d69d166145
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3721;
x-ms-traffictypediagnostic: DB3PR0402MB3721:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtEQjNQUjA0MDJNQjM3MjE7MjM6NnFTMXFuZlRWdnE2OElHeGlhZXRxVURu?=
 =?gb2312?B?RXBrMmNUSXZXblpTSExzQWxDNGJvUjBXelVTU1FhQStWZjhLZzlIMXlFdHdS?=
 =?gb2312?B?VWJsbFEzVGtpcXFxL2E2YjlwbHhZV0R6dnJndU53aGxZemVFUEovQVRqdjlm?=
 =?gb2312?B?Y2lJVElQMW9JNEpCMHZNejNTdlVialk0c1B1TGMvRUcxNnNMUElzQVQ3QjNV?=
 =?gb2312?B?R3Jocys1eCtocG04UjdPTWdtUTY5NjZnaGowSUxPL3dVVmRuU1ZqWGt1d0F5?=
 =?gb2312?B?MjF5Ym93VXdJeTRyTno1ZFppeHlzeExsOFNPMS82OGZMSHk3MVZkb0R1TkNO?=
 =?gb2312?B?MUhuZ0h3MkF6VGdNWVhYanIyN2hjeGt3R1ZwbUwzM2MyZjZWVWYySmpHSDZT?=
 =?gb2312?B?RUpBbUdrZ2ZSaGtWOTBQVnl3RUhkZDlpWWdoTEE1Q0ZuQUdiM0FZU2dpcU9N?=
 =?gb2312?B?S1lFSUJKNC9vY1BiWGkwejBnYmM3WmVndy83S01vSEh5NEdLMEErOG43MUdz?=
 =?gb2312?B?NkV3amlRUEtObXFZRmxsWnVPb0FVdXdLV1VWYytadFgxb0VTUUtOaGlhNmFX?=
 =?gb2312?B?cUVySGxzRTJaZ1lTeU1ITHlNT3FYZ0VoOEVyMGpuc3Qrem1ncTJQTEQ3R2ox?=
 =?gb2312?B?aEhLYVA1VTU5WkZPemVtVjVFclNaWjJVSm15WUJ2bkhTdVZ6TmJZaDJRNEJK?=
 =?gb2312?B?amMyTEMrTUtLWUZ1d2k2YURpMmoxWnhxUEgrM0dqdi9nV3hITVV5dFIzMTN2?=
 =?gb2312?B?K25iSlJ1ZjVqS0prYU9WWkY1TUN6dU9uY0RsTUpBMDRPd0JXM3ZycTBCYUh2?=
 =?gb2312?B?TFpvNlZkQnZlck41NXlJcnpoRlNncmdBcnV2QWpzNFJJdWprWjZwRm5DVy9m?=
 =?gb2312?B?blFPbWJ4QWZvVW9pMm9BQVBqWlRybFFZMjJ1aDBibE00Mjd5TTg0KzY0c0Fv?=
 =?gb2312?B?QXFxSG9rTy9XbVZJRVRONGdVWDVuWXlITHFuc3RvZlNEV3FTMG5xK0F3bGtC?=
 =?gb2312?B?Njg2MHAwcVZjczZ2cjZyUDhXUGNuQitHcWh0cmRqK2VrUGhGem52NW1SOEEz?=
 =?gb2312?B?SjhtQlVsaitKVVo2cWNpb0pGUTdEMnlqQVp3L01RWS91WFRMQTk3ckl1RE1t?=
 =?gb2312?B?WTBVL3Y4dkZKblMyVUNvQ3hzVDR6aXVmam5USGF0WnppQk1qZnZMZG9GbTZz?=
 =?gb2312?B?bWxJa2MycFZlRjRNV0ZQUndzM2xSVHFLVm1qd0JSdHJFZXpkYVIvSldKYzBD?=
 =?gb2312?B?Y25pc24za2l5ZmtXYVkwdzh1aFRrcExBWDh1RTJnRnljWXBybDROOG14Z0lh?=
 =?gb2312?B?ZHd6QkttS2EyWGpFR09GU01relpnamp0VWkrV2p1bHlJK1ZJaXRjQUI4QjRH?=
 =?gb2312?B?T05iVmNpbUUyT21aU3orQ0tiMlhRUHB5OW15T3A2SHVrK2NkVFdSRTJGL1g1?=
 =?gb2312?B?bElwNXZXL2huWm84N0JZRm5qWkRUSFFtMGtBeDBtY3NoSWtLUjMzbkdMYkdU?=
 =?gb2312?B?NDBHd3Y4bGZFZ08zSDJwMkR1VzRkcmZvSFArN0N2Mkt3OEpCYTFJTDV6MHls?=
 =?gb2312?B?SDBqakRiWjdwTEkxRnBXZW1SWm5MQjREVFFSMGNGYjdxT1NlZjMzb3hKMXZu?=
 =?gb2312?B?UmtudDBJeFhzeWkvdSs2RzdUdi9XdDlhQThUUGhBNmNoRXdmVDlPZHlrUTVV?=
 =?gb2312?B?Rkdkbko2VzgwUkFzWUFobWRBV1J0bVdDRVVKTlhZUklLRytRR2hnbjNTOVlZ?=
 =?gb2312?B?b1BBcEEyQjR0WlROT25ZTzNmbzBndHMrc0RnVmtld2NPZ29WK21vV0g3dE9F?=
 =?gb2312?Q?4bFd/H0Le6ZtrAe?=
x-microsoft-antispam-prvs: <DB3PR0402MB37217C8D67EA8A3ED4677C0CF5750@DB3PR0402MB3721.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(346002)(376002)(199004)(189003)(13464003)(6246003)(54906003)(486006)(68736007)(11346002)(476003)(446003)(25786009)(2906002)(316002)(478600001)(4326008)(14454004)(229853002)(256004)(102836004)(76176011)(55016002)(6346003)(9686003)(44832011)(6436002)(8936002)(81166006)(3846002)(6116002)(81156014)(99286004)(8676002)(53546011)(7736002)(6506007)(305945005)(7696005)(53936002)(74316002)(66066001)(97736004)(26005)(105586002)(186003)(106356001)(7416002)(33656002)(86362001)(52536013)(71200400001)(6916009)(71190400001)(5660300002)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3721;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Qa7+1DZjPopldk35W+jiWfopsat0MVHcoPU5I12e5iIo8KcRXF0E6d0JKf5wMy/SDfqBKGPZYZI56blz0FMeVGhsVAWQgeBGlnopPUPavuK1vXkb57S6EZw8N+GI5eXfS72sjiuF2LGdWut5bQ2ZeUBpnW++u9BDn7XrMvKoMiTIm+rxq2vpkajC20PkVuLtBjRv1LcwwH0PlS/0w8irKgvyOq7xqDZfDFuL2lyc7xQqehjIKTi44L/h2GPFWq+t7mIysMirsxHuZtMeeCpsYMKjUF29G7f+heczcil2b6rAtQQLIj/VKZVvETPZBwZFEKakeI3du0UZh926RsGVUiyt3Q7UD8UOMRbL8CsZ00ICzyl1ZgH3YVJvvd4wUD5ZCnh9q4jRj7ve3a2stvB4thY0LIJrf40IoIXnxruqpnw=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d99cd8df-d846-4585-1e9e-08d69d166145
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 00:47:56.4173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3721
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJvYg0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJyaW5nIFttYWlsdG86cm9iaEBrZXJuZWwub3Jn
XQ0KPiBTZW50OiAyMDE5xOoy1MIyOMjVIDc6NTUNCj4gVG86IEFuc29uIEh1YW5nIDxhbnNvbi5o
dWFuZ0BueHAuY29tPg0KPiBDYzogbWFyay5ydXRsYW5kQGFybS5jb207IHNoYXduZ3VvQGtlcm5l
bC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsg
ZmVzdGV2YW1AZ21haWwuY29tOw0KPiBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsgd2lsbC5kZWFj
b25AYXJtLmNvbTsgcnVpLnpoYW5nQGludGVsLmNvbTsNCj4gZWR1YmV6dmFsQGdtYWlsLmNvbTsg
ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZzsgQWlzaGVuZyBEb25nDQo+IDxhaXNoZW5nLmRvbmdA
bnhwLmNvbT47IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7IHNib3lkQGtlcm5lbC5vcmc7DQo+IERh
bmllbCBCYWx1dGEgPGRhbmllbC5iYWx1dGFAbnhwLmNvbT47IEFuZHkgR3Jvc3MNCj4gPGFuZHku
Z3Jvc3NAbGluYXJvLm9yZz47IGhvcm1zK3JlbmVzYXNAdmVyZ2UubmV0LmF1OyBoZWlrb0BzbnRl
Y2guZGU7DQo+IGFybmRAYXJuZGIuZGU7IG1heGltZS5yaXBhcmRAYm9vdGxpbi5jb207IGJqb3Ju
LmFuZGVyc3NvbkBsaW5hcm8ub3JnOw0KPiBqYWdhbkBhbWFydWxhc29sdXRpb25zLmNvbTsgZW5y
aWMuYmFsbGV0Ym9AY29sbGFib3JhLmNvbTsNCj4gbWFyYy53LmdvbnphbGV6QGZyZWUuZnI7IG9s
b2ZAbGl4b20ubmV0OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBs
aW51eC0NCj4gcG1Admdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYxMCAxLzRdIGR0LWJpbmRpbmdzOiBmc2w6IHNj
dTogYWRkIHRoZXJtYWwgYmluZGluZw0KPiANCj4gT24gV2VkLCBGZWIgMjcsIDIwMTkgYXQgMDg6
NDY6MjFBTSArMDAwMCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gTlhQIGkuTVg4UVhQIGlzIGFu
IEFSTXY4IFNvQyB3aXRoIGEgQ29ydGV4LU00IGNvcmUgaW5zaWRlIGFzIHN5c3RlbQ0KPiA+IGNv
bnRyb2xsZXIsIHRoZSBzeXN0ZW0gY29udHJvbGxlciBpcyBpbiBjaGFyZ2Ugb2Ygc3lzdGVtIHBv
d2VyLCBjbG9jaw0KPiA+IGFuZCB0aGVybWFsIHNlbnNvcnMgZXRjLiBtYW5hZ2VtZW50LCBMaW51
eCBrZXJuZWwgaGFzIHRvIGNvbW11bmljYXRlDQo+ID4gd2l0aCBzeXN0ZW0gY29udHJvbGxlciB2
aWEgTVUgKG1lc3NhZ2UgdW5pdCkgSVBDIHRvIGdldCB0ZW1wZXJhdHVyZQ0KPiA+IGZyb20gdGhl
cm1hbCBzZW5zb3JzLCB0aGlzIHBhdGNoIGFkZHMgYmluZGluZyBkb2MgZm9yIGkuTVggc3lzdGVt
DQo+ID4gY29udHJvbGxlciB0aGVybWFsIGRyaXZlci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMg
c2luY2UgVjk6DQo+ID4gCS0gY2hhbmdlICN0aGVybWFsLXNlbnNvci1jZWxscyB2YWx1ZSBpbiBl
eGFtcGxlIHRvIDEsIHNpbmNlIHRoZXJlIGFyZQ0KPiBvdGhlcg0KPiA+IAkgIHRoZXJtYWwgc2Vu
c29ycyBpbnNpZGUgc3lzdGVtIGNvbnRyb2xsZXIsIGl0IGlzIGp1c3QgYmVjYXVzZSB0aGVyZSBh
cmUNCj4gc3RpbGwNCj4gPiAJICBzb21lIGlzc3VlLCBzbyBzeXN0ZW0gY29udHJvbGxlciBkb2Vz
IE5PVCBleHBvc2UgdGhlbSBmb3Igbm93LA0KPiB0aGV5IGNvdWxkDQo+ID4gCSAgYmUgZXhwb3Nl
ZCBsYXRlciwgc28gaXQgc2hvdWxkIGJlIDEgZnJvbSBIVyBwZXJzcGVjdGl2ZS4NCj4gPiAtLS0N
Cj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dCAg
IHwgMjENCj4gKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMSBp
bnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dA0KPiA+IGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQNCj4g
PiBpbmRleCA3MmQ0ODFjLi44NTUyNzBiIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0DQo+ID4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50
eHQNCj4gPiBAQCAtMTIyLDYgKzEyMiwyMSBAQCBSVEMgYmluZGluZ3MgYmFzZWQgb24gU0NVIE1l
c3NhZ2UgUHJvdG9jb2wNCj4gPiBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ICAtIGNvbXBhdGli
bGU6IHNob3VsZCBiZSAiZnNsLGlteDhxeHAtc2MtcnRjIjsNCj4gPg0KPiA+ICtUaGVybWFsIGJp
bmRpbmdzIGJhc2VkIG9uIFNDVSBNZXNzYWdlIFByb3RvY29sDQo+ID4gKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICsNCj4g
PiArUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiArLSBjb21wYXRpYmxlOgkJCVNob3VsZCBiZSA6
DQo+ID4gKwkJCQkgICJmc2wsaW14OHF4cC1zYy10aGVybWFsIg0KPiA+ICsJCQkJZm9sbG93ZWQg
YnkgImZzbCxpbXgtc2MtdGhlcm1hbCI7DQo+ID4gKw0KPiA+ICstICN0aGVybWFsLXNlbnNvci1j
ZWxsczoJU2VlDQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90aGVybWFsL3Ro
ZXJtYWwudHh0DQo+ID4gKwkJCQlmb3IgYSBkZXNjcmlwdGlvbi4NCj4gPiArDQo+ID4gKy0gaW14
LHNlbnNvci1yZXNvdXJjZS1pZDogCUEgc2luZ2xlIGludGVnZXIgZm9yIHNpbmdsZSB0aGVybWFs
IHpvbmUncw0KPiByZXNvdXJjZSBJRCBvcg0KPiA+ICsJCQkJYW4gYXJyYXkgb2YgaW50ZWdlcnMg
dG8gc3BlY2lmeSBlYWNoIHRoZXJtYWwNCj4gem9uZSdzIHNlbnNvcg0KPiA+ICsJCQkJcmVzb3Vy
Y2UgSUQuDQo+IA0KPiBDYW4ndCB5b3UgcHV0IHRoZSByZXNvdXJjZSBpZHMgaW4gdGhlIHRoZXJt
YWwtc2Vuc29yIGNlbGxzPyBXaHkgZG8geW91IG5lZWQNCj4gdG8gbGlzdCB0aGVtIGhlcmU/DQoN
CkZvciB0aGUgdGhlcm1hbC1zZW5zb3IgY2VsbHMsIGlmIHlvdSBtZWFudCB0aGUgYXJndW1lbnQg
b2YgdHNlbnMgcGhhbmRsZSwgdGhlbg0KdGhlIHJlYXNvbiBpcyB0aGF0IGFyZ3VtZW50IGlzIGZv
ciBzZW5zb3IgaW5kZXggc3RhcnRpbmcgZnJvbSAwLCBwcmV2aW91cyBJIHVzZQ0KaXQgZm9yIG91
ciByZXNvdXJjZSBJRCwgYnV0IGl0IGxvb2tzIGNvbmZ1c2VkLCBzaW5jZSB1c2VyIHdpbGwgdGhp
bmsgdGhlcmUgYXJlIG1hbnkNCnNlbnNvcnMgdGhlcmUgcGVyIEVkdWFyZG8ncyBjb21tZW50Lg0K
DQorCQkJdGhlcm1hbC1zZW5zb3JzID0gPCZ0c2VucyAwPjsNCg0KSWYgeW91IG1lYW50IHB1dHRp
bmcgaXQgaW4gZWFjaCB0aGVybWFsIHNlbnNvciBub2RlIGluc3RlYWQgb2YgInRzZW5zIiBub2Rl
LCB0aGVuDQppbiBwcmV2aW91cyBwYXRjaCBzZXJpZXMsIEkgcHV0IHRoaXMgIiBpbXgsc2Vuc29y
LXJlc291cmNlLWlkICIgcHJvcGVydHkgaW4gZWFjaCB0aGVybWFsDQpzZW5zb3Igbm9kZSwgYnV0
IHRoZSB0aGVybWFsIHNlbnNvciBub2RlcyBhcmUgcGFyc2VkIGJ5IGNvbW1vbiB0aGVybWFsIGZy
YW1ld29yaywNCnRoZXJtYWwgZHJpdmVyIHdpbGwgbmVlZCB0byBmaW5kIHRoZSB0aGVybWFsIHpv
bmUgbm9kZSBhbmQgZ28gdGhyb3VnaCBldmVyeSBjaGlsZCBub2RlDQp0byBnZXQgdGhlIHJlc291
cmNlIGlkIGFnYWluLCBzbyBFZHVhcmRvIHN1Z2dlc3RlZCB0byBwdXQgaXQgaW4gb3VyIHBsYXRm
b3JtIHRzZW5zIG5vZGUsIHRoYXQgbWFrZXMNCm91ciB0aGVybWFsIGRyaXZlciBjb2RlIG11Y2gg
bW9yZSBzaW1wbGUuDQoNClRoYW5rcywNCkFuc29uLg0KDQo+IA0KPiBSb2INCg==
