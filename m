Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65407C10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFC820675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l0YNqfZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfCGMWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:22:39 -0500
Received: from mail-eopbgr00066.outbound.protection.outlook.com ([40.107.0.66]:49377
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726101AbfCGMWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:22:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDY9mWFir6pHVK3C+uANOmpelRA/nTnusr5qj/yMV8c=;
 b=l0YNqfZvWnUqTQitiXaP/cS18CBwlAOTpSLfx8d9Uqzdytm7U9XUHaeHYsa1O/kuXXUhUAjl5IXASQmV/QEivke9UPHapiPZbp+7vkcizCo99i9DxKpg7sEFR86BTcZ+nb2vNBATVt85Ac5uQmirvcfUYEC0qZtS6MHpwljWhac=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4323.eurprd04.prod.outlook.com (52.134.91.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.16; Thu, 7 Mar 2019 12:22:32 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79%2]) with mapi id 15.20.1686.018; Thu, 7 Mar 2019
 12:22:32 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Rob Herring <robh@kernel.org>, Anson Huang <anson.huang@nxp.com>
CC:     Guenter Roeck <linux@roeck-us.net>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        Andy Gross <andy.gross@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "olof@lixom.net" <olof@lixom.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog binding
Thread-Topic: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog
 binding
Thread-Index: AQHUx1azZw5wqQrc00um4LsJoxWck6XsQYyAgAFkewCAAKasgIAABF6AgAGDOQCAAtMPAIANhsqA
Date:   Thu, 7 Mar 2019 12:22:32 +0000
Message-ID: <AM0PR04MB4211EAEA6F03465D372B0B4F804C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
 <1550472539-16590-2-git-send-email-Anson.Huang@nxp.com>
 <20190222195217.GA22194@bogus>
 <bb19470c-1590-f8dd-72e6-b382444d7902@roeck-us.net>
 <DB3PR0402MB3916912A64AF0837A9649913F5790@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <96932b3e-87f1-d8f2-95bc-0e9a8d5d45ed@roeck-us.net>
 <DB3PR0402MB391659B6A466B1D85114E9C9F57A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAL_JsqJV9NxpOJi3Jh2Uk-TOmOL4rWwqZp3sodxsRinAHZ3m3w@mail.gmail.com>
In-Reply-To: <CAL_JsqJV9NxpOJi3Jh2Uk-TOmOL4rWwqZp3sodxsRinAHZ3m3w@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38284674-80eb-431d-f4e6-08d6a2f7930c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4323;
x-ms-traffictypediagnostic: AM0PR04MB4323:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtBTTBQUjA0TUI0MzIzOzIzOkVXYStnTy9Qc21LTWZhdjB5Z1paVTM5QWVi?=
 =?utf-8?B?bFFmQ3VZbVVaYi9aRURGd2p1YzlNa29VYWZyY1ptZWxzcUNXeGpOemtZU3Br?=
 =?utf-8?B?ZUlqakVUUTVJQTNXNEJ0Rng5azBKcGtHMXZnS1VVMjRuaVRKSFNGTkVHMEVT?=
 =?utf-8?B?N0lucGJSWkRMWXpRZ21yTGwzMGwzTlIrZFRFeThjQXQ4UkFhNHBDUTRjem9Y?=
 =?utf-8?B?eXdBMlB2emkvNlhLcEs0VXh5V3kra09jS29SdDJoZUJzaXJMMXdUR3NCcGhQ?=
 =?utf-8?B?dDdNUVpMSjVqdjl0d1k0L3liNktPaE0xd1lQUzRZTW1EWU4xV2NOcDh6bURU?=
 =?utf-8?B?NDhYWjBBNTN1cXo3cDdWdzRJcHBSTXhmMFl4UzA2MGQvb0hEUlc1cnRXYXpV?=
 =?utf-8?B?NzhTOGxuQWt1MDB4ZVBkVjMwTHFid1lYeTNCMkpxSGw3aW1WVU5ZclNuYmM4?=
 =?utf-8?B?bmE3Z0hvZ2JmNmdCRFl5SllBRWhraXBJU0NPaXJTNVZPWGtoMVp3TnkrY2pw?=
 =?utf-8?B?SVgrOFhFN2xXeE84bStvR0hFbFJnWTdRTFRNd3ZYL1JacjVlZ2syTEFUUENB?=
 =?utf-8?B?TkpRRGlNUW9MRXFCaGVRTTNnTDZlTUtVVDBUNEdhTnJhWklQNnd1KzFra2sv?=
 =?utf-8?B?TFcvcVpJNEkwZEtBVzlaMGpDdERUVjlNL1lSVXJGdHRBVTdkY0lNbnd6RzZN?=
 =?utf-8?B?U3lNblNHZy9CT20ycy9qUkFpaU4zS0QzaWRkTTlzRllHZkNIazNMZ3A2Rkh2?=
 =?utf-8?B?ay8zMmYwSFp2NnB6ZXV2MS9uY2VRdUVGYm9ELyt1bTBYTHRsUVNKM1gyKzJB?=
 =?utf-8?B?Z2MrNFUzZWhhVU1PN1ZlcGpXTE9ha3hFTkx1U1NHZmZPVTBQODhlZHErRGFa?=
 =?utf-8?B?TzNFMHFha0dIRTJiWURhVno1SGllZkE2aGRHK2QvYkN5VlF1algrNklZN0JF?=
 =?utf-8?B?dUdGWnkxdFA4cDF5QjRsRVRETk50WFJtaFplL2JZQklhbmhPekhBTWdTMlVh?=
 =?utf-8?B?V1lxcktvN1FtSkVVbGpPRitOV1FWZVlxSVRrWnJicmlrSk1mazF5ZTVBZ0dL?=
 =?utf-8?B?NUtVUmErVWM2czFyZkNaYW9oUWpZNjlINGJCazBHWFA5QWQvVDMxQmtsaEdw?=
 =?utf-8?B?TEtGQVV4T0RtczAvZ1E4M0dvaFllaW5GbDAyZTh0U3dIZjJOd1NlTk93aS9U?=
 =?utf-8?B?enpLbFpZV3h0WXhlcmtYQUR1TzFSWU5mSGZLby9TVHBXR1lwcTgwS21qci9O?=
 =?utf-8?B?OE9hKzJWWUtmVzFFN0s0N2pnTERFYStaZTFucGIvYXcxN3dvd3FxRnFqNitP?=
 =?utf-8?B?dktJQUtDdU5laithcDRhdGpVM2RlU3dCZEhwVW1kaUMzZ2kyLzYvZkh5NnU2?=
 =?utf-8?B?VUtVL3BVSWhDK1RqT1FsU2FHZ2hObTlXMzVRNHpJamZ2V2Q3UkNSQ0U1Slds?=
 =?utf-8?B?YXdJNCs3OWdCbEtjc3Z4SXlEanRpZFk4SjRrL2ZoZFUzbW44QTdjSnM5Qkc5?=
 =?utf-8?B?Umo1R3ZQU0tCY2V2eWhXVExEWHhqM1Uzb1d4eldzN3FQbjBxSnlPaThvVURo?=
 =?utf-8?B?dFFHNTdGTXJBZnY3NkxZdUszVVNnTUsrNTEzdURJQnpPcTAvcUVoZFNzZFVk?=
 =?utf-8?B?ZU8rRDlTc1FoU3JnQWdDeU80UXQ3NHlZVU5wL1ptME5IT3ppKytGbXpUdDNn?=
 =?utf-8?B?Ylg0SUYzYUIzMUpHK20rK2o0dXUwdGFMWHQxWjY5SThBemxrQmFKeCtKVlI4?=
 =?utf-8?Q?+rqRJSyPKlSveG6NN6Gl6sRLXqh6H6ISV6218=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB4323F9F9ADF918587D203F16804C0@AM0PR04MB4323.eurprd04.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(366004)(136003)(189003)(199004)(68736007)(53936002)(55016002)(7416002)(6636002)(9686003)(316002)(33656002)(54906003)(110136005)(97736004)(86362001)(71200400001)(229853002)(71190400001)(93886005)(6116002)(256004)(14444005)(3846002)(44832011)(25786009)(186003)(66066001)(476003)(7696005)(11346002)(81166006)(446003)(478600001)(5660300002)(8676002)(7736002)(6436002)(305945005)(52536013)(81156014)(8936002)(76176011)(4326008)(99286004)(74316002)(102836004)(6506007)(26005)(6246003)(486006)(105586002)(2906002)(14454004)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4323;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lCYSbQMshGVUMhLw8CqsygBc/+diiJ5vPsxUhEZLpWMn4gaD6Vd2MeTRBTnyL04WWkEW9qLB8eHIleBMAykd/FSjpAoDQab9O7QX8s02x6s7lNxIa3XBIz7s7jRigk2wkNDI4v9LuiEPpZVnOGNhi1QU1sX7ptsFFLEgiPmfDhLTu9cCQbjQXbXytDtw7URgAGg2LFOSIL20iUD7jVO/jq9qjBFGX5NckOq4vux3CCeVwuUcTGvbCUZzvp1Bp0qYeujJNndjKv9w4PN4JxLoWVVmPZuneqhxhjN8lcai2H489mRVptAoQMhb7Pw7CPRRiRKxj2ab93kF+oTJG6OUOA7e5kxXT6yIV6K2fyUCifBzjJQhB2S/owzxTV3Oc/aHZZs1Kdz95PR0+neT6vQRb9NqX4R8PQpHKy4fOacXVbk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38284674-80eb-431d-f4e6-08d6a2f7930c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 12:22:32.5994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQo+ID4gPiBJIHRoaW5rIFJvYiBzdWdnZXN0ZWQgdGhhdCB0aGUgU0NVIHBhcmVu
dCBkcml2ZXIgc2hvdWxkIGluc3RhbnRpYXRlDQo+ID4gPiB0aGUgd2F0Y2hkb2cgd2l0aG91dCBl
eHBsaWNpdCB3YXRjaGRvZyBub2RlLiBUaGF0IHdvdWxkIGJlIHBvc3NpYmxlLA0KPiA+ID4gYnV0
IGl0IGN1cnJlbnRseSB1c2VzDQo+ID4gPiBkZXZtX29mX3BsYXRmb3JtX3BvcHVsYXRlKCkgdG8g
ZG8gdGhlIGluc3RhbnRpYXRpb24sIGFuZCBjaGFuZ2luZw0KPiA+ID4gdGhhdCB3b3VsZCBiZSBh
IG1lc3MuIEJlc2lkZXMsIGl0IGRvZXMgc2VtIHRvIG1lIHRoYXQgeW91ciBzdWdnZXN0ZWQNCj4g
PiA+IG5vZGUgd291bGQgZGVzY3JpYmUgdGhlIGhhcmR3YXJlLCBzbyBJIGFtIG5vdCBzdXJlIEkg
dW5kZXJzdGFuZCB0aGUNCj4gcmVhc29uaW5nLg0KPiANCj4gSXQgd291bGQganVzdCBiZSBhIGNh
bGwgdG8gY3JlYXRlIGEgcGxhdGZvcm0gZGV2aWNlIGluc3RlYWQuIEhvdyBpcyB0aGF0IGEgbWVz
cz8NCj4gDQo+IEl0J3MgZGVzY3JpYmluZyBmaXJtd2FyZS4gV2UgaGF2ZSBEVCBmb3IgZGVzY3Jp
YmluZyBoL3cgd2UndmUgZmFpbGVkIHRvIG1ha2UNCj4gZGlzY292ZXJhYmxlLiBXZSBzaG91bGQg
bm90IHJlcGVhdCB0aGF0IGFuZCBqdXN0IGRlc2NyaWJlIGZpcm13YXJlIGluIERULg0KPiBNYWtl
IHRoZSBmaXJtd2FyZSBkaXNjb3ZlcmFibGUhIFRob3VnaCB0aGVyZSBhcmUgY2FzZXMgbGlrZSBm
aXJtd2FyZQ0KPiBwcm92aWRlZCBjbG9ja3Mgd2hlcmUgd2Ugc3RpbGwgbmVlZCBzb21ldGhpbmcg
aW4gRFQsIGJ1dCB0aGlzIGlzIG5vdCBvbmUgb2YNCj4gdGhlbS4NCj4gDQoNClRoZSB3YXRjaGRv
ZyBub2RlIGhlcmUgaW4gcXVlc3Rpb24gYWN0dWFsbHkgaXMgbm90IHVzaW5nIFNDVSBmaXJtd2Fy
ZSBjYWxsLg0KRHVlIHRvIHNlY3VyaXR5IHJlcXVpcmVtZW50IGJ5IFNDVSwgd2F0Y2hkb2cgY2Fu
IG9ubHkgYmUgYWNjZXNzZWQgaW4NCnNlY3VyaXR5IG1vZGUsIGZvciBJTVggY2FzZSwgdmlhIEFS
TSBUcnVzdCBGaXJtd2FyZS4gVGhhdCBtZWFucyB0aGUNCndhdGNoZG9nIHVzZWQgaW4gTGludXgg
YWN0dWFsbHkgaXMgdXNpbmcgQVJNIFNNQyBjYWxsIGFuZCBkb2VzIG5vdA0KZGVwZW5kIFNDVSBk
cml2ZXIuIFNvIEl0IHdvdWxkIGJlIHN0cmFuZ2UgZm9yIFNDVSBkcml2ZXIgdG8gaW5zdGFudGlh
dGUgaXQuDQoNCkZvciB0aGlzIHNpdHVhdGlvbiwgZG8geW91IHRoaW5rIHdlIGNhbiBtb3ZlIHdh
dGNoZG9nIG91dCBvZiBzY3Ugbm9kZT8NCk1heWJlIHJlbmFtZSB0aGUgY29tcGF0aWJsZSBzdHJp
bmcgbGlrZSAiZnNsLGlteDhxeHAtc2lwLXdhdGNoZG9nIg0KYmVjYXVzZSBpdCdzIGFjdHVhbGx5
IGEgd2F0Y2hkb2cgc2VydmljZWQgYnkgQVRGIGZpcm13YXJlLg0KDQpSZWdhcmRzDQpEb25nIEFp
c2hlbmcNCg==
