Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF254C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65F423BE5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RPPCHm7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfFDOQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:16:16 -0400
Received: from mail-eopbgr20081.outbound.protection.outlook.com ([40.107.2.81]:7552
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727287AbfFDOQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mP2uNhqziyf2SrorO4naRi812nTeSt/+EQtEN4LUSBs=;
 b=RPPCHm7yxd0KiASeaJ+bRc/JWDgMD3+mf5fTa+1qlZijP7LT7V00W1LSiw2+GV/LWfgC4hL/hm2bVSK09HkzP0NKCueZRSq0DASl5chIyj7a5YjzcBaZgBshGphHtVcpq1L6OSRPFHr6XZWG/3hnIwOApStJCwmSNwAOV7W4zuE=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
 VI1PR04MB5310.eurprd04.prod.outlook.com (20.177.52.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Tue, 4 Jun 2019 14:16:11 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8d0e:de86:9b49:b40]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8d0e:de86:9b49:b40%7]) with mapi id 15.20.1943.018; Tue, 4 Jun 2019
 14:16:11 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>, Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "noring@nocrew.org" <noring@nocrew.org>,
        "JuergenUrban@gmx.de" <JuergenUrban@gmx.de>
Subject: Re: [PATCH v7 0/5] prerequisites for device reserved local mem rework
Thread-Topic: [PATCH v7 0/5] prerequisites for device reserved local mem
 rework
Thread-Index: AQHVFglQMB1lnLjYnE2Z8bn8+67UAKaB+N+AgAAA+wCAAClrAIADUJmAgAYgLAA=
Date:   Tue, 4 Jun 2019 14:16:11 +0000
Message-ID: <014526bf-e3e9-bd94-a239-0ec1e7feaf72@nxp.com>
References: <20190529102843.13174-1-laurentiu.tudor@nxp.com>
 <20190529113427.GC11952@kroah.com> <20190529113758.GA9399@lst.de>
 <5b8164b3-74a3-9ba4-8c28-61a14ec57a39@nxp.com>
 <20190531164327.GB27525@lst.de>
In-Reply-To: <20190531164327.GB27525@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92d539a7-3fda-4b67-b4a0-08d6e8f7325d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5310;
x-ms-traffictypediagnostic: VI1PR04MB5310:
x-microsoft-antispam-prvs: <VI1PR04MB531006D2B409E43E4F3B9DD2EC150@VI1PR04MB5310.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0058ABBBC7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(396003)(136003)(346002)(189003)(199004)(51914003)(66066001)(4744005)(7736002)(478600001)(66556008)(229853002)(66446008)(64756008)(25786009)(66476007)(26005)(66946007)(14454004)(68736007)(36756003)(6916009)(6486002)(186003)(91956017)(2906002)(31696002)(73956011)(6512007)(76116006)(86362001)(3846002)(8936002)(6116002)(71200400001)(71190400001)(102836004)(4326008)(476003)(2616005)(81156014)(81166006)(53546011)(5660300002)(6506007)(31686004)(305945005)(8676002)(446003)(316002)(11346002)(44832011)(486006)(76176011)(99286004)(256004)(54906003)(6436002)(6246003)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5310;H:VI1PR04MB5134.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IALOywrHg9DS6hVVCmuW0CDKbK2fs5DUTRbfFLFFNaZpKA1lM8Cxd5PUyoSmR3L2pK6lXn7FB1HvNbLlc0IERHy5I7McSV0u0vxlQhvdA39u5wvsyfZW4n7Ga/xwGQlL0f/DbdK5F6voOKysrXKzDLcLHDPb9iZGcPVE5opRgzlA2baSymUN5qBYU+qH5GuhdQ5bkf4myGSgN3AQlzsKi3v7W1LkFbFMWMy4WWXtfe8uL59PF0JuEHO9c9TtpqlyjGQDiFtLl8sAQk2mQqwXv4eZ7WGz2QkGNSyG5N+RMFlScRJU0MWWMniY8P1fn5mTYrclwG9QvkGEfm1UG9bhyBd0Ldh5SZuda4OWGwB6EQQVoHC9bERJoIrUBq9iLC7gPTK9eh0pfftPccHKcxsuxze5QMSxNajRL2x7OOP9p38=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E2FA2478BFDE8439FF33B9FBC3DD2DF@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d539a7-3fda-4b67-b4a0-08d6e8f7325d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2019 14:16:11.7602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: laurentiu.tudor@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5310
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzEuMDUuMjAxOSAxOTo0MywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIFdlZCwg
TWF5IDI5LCAyMDE5IGF0IDAyOjA2OjEyUE0gKzAwMDAsIExhdXJlbnRpdSBUdWRvciB3cm90ZToN
Cj4+IFRoYW5rcywgaG9wZSB0aGlzIHRpbWUgZXZlcnl0aGluZyBpcyBmaW5lLg0KPiANCj4gSSd2
ZSBhcHBsaWVkIGl0IHRvIHRoZSBkbWEtbWFwcGluZyB0cmVlIG5vdy4NCj4gDQo+PiBXaGVuIHlv
dSBnZXQgdGhlIHRpbWUsIHBsZWFzZSBsZXQgbWUga25vdyB5b3VyIGlkZWFzIG9uIHRoZSBuZXh0
IHN0ZXBzLg0KPiANCj4gSSB0aGluayB0aGUgbmV4dCBzdGVwIGlzIHRvIG1vdmUgdGhlIGNhbGwg
dG8NCj4gZG1hX2FsbG9jX2Zyb21fZGV2X2NvaGVyZW50IGZyb20gZG1hX2FsbG9jX2F0dHJzIGlu
dG8gdGhlIC0+YWxsb2MNCj4gaW5zdGFuY2VzLiAgVGhlIG9ubHkgb25jZXMgdGhhdCByZWFsbHkg
bmVlZCBpdCBmb3Igbm93IGFyZSB0aGUNCj4gZ2VuZXJpYyBhbmQgbGVnYWN5IGFybSBkbWEtZGly
ZWN0IGNvZGUsIGFuZCBkcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jDQo+IGFzIHdlbGwgYXMgdGhl
IEFSTSBETUEgQVBJIGNvZGUsIGFzIHRob3NlIGFyZSB0aGUgb25lcyB1c2UgZm9yDQo+IGFyY2hp
dGVjdHVyZXMgdGhhdCBkZWNsYXJlIGNvaGVyZW50IHJlZ2lvbnMuICBUaGUgb3RoZXIgaW9tbXVz
IGFyZQ0KPiBub3QgdXNlZCBvbiBPRiBwbGF0Zm9ybXMgKGF0IGxlYXN0IHRoYXQncyB3aGF0IG15
IGFuYWx5c2lzIHNhaWQgYSB3aGlsZQ0KPiBhZ28sIGZlZWwgZnJlZSB0byBkb3VibGUgY2hlY2sg
aXQpDQoNClRoYW5rcyBmb3IgdGhlIGRldGFpbHMuIEknbGwgYmUgT09PIG5leHQgd2VlayBzbyBw
cm9iYWJseSBJJ2xsIHN0YXJ0IA0KbG9va2luZyBpbnRvIGl0IG5leHQgbmV4dCB3ZWVrLg0KDQot
LS0NCkJlc3QgUmVnYXJkcywgTGF1cmVudGl1
