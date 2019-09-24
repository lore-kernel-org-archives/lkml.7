Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99323C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 03:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6193020820
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 03:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NlHd2zes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408947AbfIXDCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 23:02:09 -0400
Received: from mail-eopbgr80085.outbound.protection.outlook.com ([40.107.8.85]:27872
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408922AbfIXDCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 23:02:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCuq2gUeYL0irQnFT0Lm9JWyqI3y9F5vOALAVx6uek9Zn0lXZ3Ub9QLKvb5qqM8W5/zNy3I5aMpAfL/VtqwPRUSziCe39SvRyJhEzEh+qPLFXfDOxkGn7mdDI6pcphZsHQIIiWbRDTbslUHZmahwmMehtD+x1OmLuwhg8ZwED8jAcoPbBi5+AsQcH40SHeB9kwQH4+QHDyBvQbdmJ72Yp5/0vIq+k2KMk0Go188jKP0iYdmO3gkzK/Osm/obqEsBUHPrdIHTjO8hUaHnY9hAa3ZyjfkqEUZ3nI3XJ2D9x90Kmyj5tmsE6DVdLHwCxLEi8HVzcu75RfCNlpEJOe8k9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXbVzX5PRJMtKVmB4l9yNNScAuWyQjIm/ZYweIm1XAA=;
 b=eoB3L8W0atYHPhcGSxemDL9LaBTkFDUV5LvsJjgYTFTae97T+mV8R9MRIwEIKuSaG1WQjOZML3UjDgs7bAMStdE92msmqde2zr3AzECiyPyu6NyOsiYu7iTK2DBYhiPNqtjqbzw5RyGnX+U0qy9DrKDcHe1rwR0VsoYOs52s7Yb3sVOZkCA7FaUzrAEPwv+6TMjk0rzuWgV5nz0vCgIq0BBnEhuGwkuAVj00jCUrlA676KnCCSGDtxDD7J2uiGcFeyYY7DnbxDzjiBveL7eD7kVHgggcJccak3mISBXuZ9co8HHAcHWffHc5E9GK4Jha+4dBTK1ogRiA40AEMJHlkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXbVzX5PRJMtKVmB4l9yNNScAuWyQjIm/ZYweIm1XAA=;
 b=NlHd2zesiIvud8We0ZDKdcajcdqjYuTZ6YyQjxu6SbRPRPSUrROOa83Xo5j/GlDkiGwMop4iQI2xL7b/pn/V8ZCqNM/DAHqtvnYMLDGGVttjLl3hCa8jaAYtIHLq70bHCLpyzh8r13yNwSaaqt3ZxWua8UgGo/6DBdY0h4D7YXo=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB3181.eurprd04.prod.outlook.com (10.170.229.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Tue, 24 Sep 2019 03:02:05 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::fddc:d4ac:5cb9:e1c6]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::fddc:d4ac:5cb9:e1c6%6]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 03:02:04 +0000
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        Jiafei Pan <jiafei.pan@nxp.com>, "Y.b. Lu" <yangbo.lu@nxp.com>,
        Ashish Kumar <ashish.kumar@nxp.com>
Subject: RE: [EXT] Re: [PATCH v5] arm64: dts: ls1028a: Add esdhc node in dts
Thread-Topic: [EXT] Re: [PATCH v5] arm64: dts: ls1028a: Add esdhc node in dts
Thread-Index: AQHVUxqoQEaBy+hS4kKjqkysNZ+Bs6cCeMSAgDfnH5A=
Date:   Tue, 24 Sep 2019 03:02:04 +0000
Message-ID: <VI1PR04MB4158E2E8C626FCABF089E15AE9840@VI1PR04MB4158.eurprd04.prod.outlook.com>
References: <20190815033901.18696-1-yinbo.zhu@nxp.com>
 <20190819131033.GH5999@X250>
In-Reply-To: <20190819131033.GH5999@X250>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e418af38-a1ef-433f-eb41-08d7409b9464
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3181;
x-ms-traffictypediagnostic: VI1PR04MB3181:|VI1PR04MB3181:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB31811ED10306EA611A669EACE9840@VI1PR04MB3181.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(13464003)(86362001)(81156014)(186003)(71190400001)(8676002)(52536014)(81166006)(229853002)(66556008)(66946007)(54906003)(66446008)(33656002)(4326008)(446003)(11346002)(14454004)(66066001)(99286004)(76176011)(25786009)(26005)(478600001)(76116006)(316002)(44832011)(64756008)(8936002)(486006)(66476007)(7736002)(55016002)(6916009)(7696005)(6246003)(476003)(5660300002)(6116002)(6436002)(53546011)(3846002)(256004)(102836004)(74316002)(305945005)(71200400001)(2906002)(6506007)(4744005)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3181;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /ia64vfe6eVqFiY12+GcwfxHsa4MkVZJm7x7SIQjq27xy8eDB5J3/NGPwyciXuRN6AtDug65h0xnz3BdfiQ3dLj5A7mEy58zZ90JfyOC9n0X+zUKoUHCoPzwvAGVB19ZF+whubZmhdKWB37E1g6Xw8xnguuTpaPfuQm5q1olUAwl26p8CaIwfzkLK3dHqT9K5epUmivF7aGtaoBIkVFWh5tnXR0BzGXGwl4qeduQ/IihYYGYUbBAHyoVc+Pn5bMKDtR6aM/5SllU4eLCBky+b+8A/EXW/Jf3hQsfA0SCaOSQlf8qAt7XmVXiTs0iGtq1pV6TZS0zTLQ5LwGjGHB/SUNuY4HF8SV1ocJZZObpPju2RehrzBLk+ndbYP9PHGBlMrzAcTiQ9TU86nuCHUQeagFLBM+6mq5Puw/mFHubqRg=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e418af38-a1ef-433f-eb41-08d7409b9464
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 03:02:04.8955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7jlWdm4BA7Rio3qEQyytU1mQTF+0qdNcXvgoABPg+amHm7w5W6agnhqh2hl3LYfquIL5d2ye2mZpHxyueyt6Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2hhd24gR3VvLA0KDQpJIHNlZSB0aGF0IHlvdSBoYWQgbWVyZ2VkIG15IHBhdGNoLCBidXQg
SSBkb24ndCBzZWUgdGhhdCBpbiANCnVybCA9IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20v
bGludXgva2VybmVsL2dpdC9zaGF3bmd1by9saW51eC5naXQgbWFzdGVyIGJyYW5jaC4NClBsZWFz
ZSBoZWxwIGNoZWNrLg0KDQpSZWdhcmRzLA0KWWluYm8gWmh1DQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPiANClNlbnQ6IDIw
MTnE6jjUwjE5yNUgMjE6MTENClRvOiBZaW5ibyBaaHUgPHlpbmJvLnpodUBueHAuY29tPg0KQ2M6
IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVs
Lm9yZz47IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBYaWFvYm8gWGllIDx4aWFvYm8ueGllQG54cC5jb20+
OyBKaWFmZWkgUGFuIDxqaWFmZWkucGFuQG54cC5jb20+OyBZLmIuIEx1IDx5YW5nYm8ubHVAbnhw
LmNvbT47IEFzaGlzaCBLdW1hciA8YXNoaXNoLmt1bWFyQG54cC5jb20+DQpTdWJqZWN0OiBbRVhU
XSBSZTogW1BBVENIIHY1XSBhcm02NDogZHRzOiBsczEwMjhhOiBBZGQgZXNkaGMgbm9kZSBpbiBk
dHMNCg0KQ2F1dGlvbjogRVhUIEVtYWlsDQoNCk9uIFRodSwgQXVnIDE1LCAyMDE5IGF0IDExOjM5
OjAxQU0gKzA4MDAsIFlpbmJvIFpodSB3cm90ZToNCj4gRnJvbTogQXNoaXNoIEt1bWFyIDxBc2hp
c2guS3VtYXJAbnhwLmNvbT4NCj4NCj4gVGhpcyBwYXRjaCBpcyB0byBhZGQgZXNkaGMgbm9kZSBh
bmQgZW5hYmxlIFNEIFVIUy1JLCBlTU1DIEhTMjAwIGZvciANCj4gbHMxMDI4YXJkYi9sczEwMjhh
cWRzIGJvYXJkLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBBc2hpc2ggS3VtYXIgPEFzaGlzaC5LdW1h
ckBueHAuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5nYm8gTHUgPHlhbmdiby5sdUBueHAuY29t
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBZaW5ibyBaaHUgPHlpbmJvLnpodUBueHAuY29tPg0KDQpBcHBs
aWVkLCB0aGFua3MuDQo=
