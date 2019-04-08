Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA0EC282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 02:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9F220896
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 02:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GplPV3gX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfDHCHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 22:07:31 -0400
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:7478
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726349AbfDHCHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 22:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BEyDva9w5qOw/GINwJgXa/POe8aYdm/fM1LLr4VpEg=;
 b=GplPV3gXVONUG/JooJQdbEv+BDo2BUkjct7vXYY+iZ5OgutQxv8hOHFVS6GUJHuquF2AcGnBvmZQcAdnDH7lAkfG80ogYTwsG2qaon2E9dr3WrunSSddr81p9SdGop9U1uY64F1D1cHKJUnnAXy9ru0zEnLKHvawC8yAsqO4vow=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3739.eurprd04.prod.outlook.com (52.134.67.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Mon, 8 Apr 2019 02:07:24 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1771.016; Mon, 8 Apr 2019
 02:07:24 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "martink@posteo.de" <martink@posteo.de>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [EXT] Re: [PATCH] iio: accell: mma8452: free iio trigger pointer
 when cleanup
Thread-Topic: [EXT] Re: [PATCH] iio: accell: mma8452: free iio trigger pointer
 when cleanup
Thread-Index: AQHU6ryxEHCPaiVeL06acUetPMat+aYwhu2AgAD/paA=
Date:   Mon, 8 Apr 2019 02:07:24 +0000
Message-ID: <DB3PR0402MB39162CD8C7BF1431C16B378FF52C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1554364635-19653-1-git-send-email-Anson.Huang@nxp.com>
 <20190407113939.0717a6c9@archlinux>
In-Reply-To: <20190407113939.0717a6c9@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f81f791-a62d-42be-e59c-08d6bbc6f15c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3739;
x-ms-traffictypediagnostic: DB3PR0402MB3739:
x-microsoft-antispam-prvs: <DB3PR0402MB373940FDF3A5CBEDB98FEF31F52C0@DB3PR0402MB3739.eurprd04.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(366004)(346002)(189003)(199004)(13464003)(316002)(9686003)(71190400001)(44832011)(33656002)(55016002)(54906003)(25786009)(6246003)(4326008)(53546011)(478600001)(97736004)(45080400002)(53936002)(76176011)(102836004)(106356001)(105586002)(7696005)(8936002)(5024004)(99286004)(81166006)(14444005)(256004)(68736007)(486006)(11346002)(446003)(71200400001)(6436002)(7736002)(6916009)(6506007)(6116002)(26005)(2906002)(3846002)(81156014)(52536014)(86362001)(14454004)(5660300002)(305945005)(8676002)(229853002)(74316002)(186003)(476003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3739;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5GkC4jmciPER3J7mU6XQ155ZheiDEEI0zKiWQXRmjPvD8yAf5CBhjtYsJNVho1yebKNNXvC0fTa6yXnf2ONRHpIWxa0U80bjqKbQeqc6eWnZj12ORi9wP9C/J3ko61DDUTMsF2p1MYj9Nfn4KYW3v/aiJizrL6gwFmmG0pUqL46xgj9OxRP9CWEDTJhHnfxh5/ULNTLaS4j9GGTBUFPW6f90OMuaPKY6/qppezxyxiDssKU8kHVcRgJcGcU6i3yNz1roqYW7iYrwlYmakdePmE1k9efAVk6P06HtFEdG0TMsxUgnFpk6zMH0C0dwzWa7OLptPxNP9E+nur3gAvWltpcvnViA4fAZGuqBoanKCCW6mrhYpnl4yei3Q9VzZtBPK+LM6ejehmDyjSI/myh8zRG24/LdnTmX5yVYuIJF3MQ=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f81f791-a62d-42be-e59c-08d6bbc6f15c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 02:07:24.5088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3739
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEpvbmF0aGFuDQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJvbiBbbWFpbHRvOmppYzIz
QGtlcm5lbC5vcmddDQo+IFNlbnQ6IDIwMTnE6jTUwjfI1SAxODo0MA0KPiBUbzogQW5zb24gSHVh
bmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IENjOiBrbmFhY2suaEBnbXguZGU7IGxhcnNAbWV0
YWZvby5kZTsgcG1lZXJ3QHBtZWVydy5uZXQ7IExlb25hcmQNCj4gQ3Jlc3RleiA8bGVvbmFyZC5j
cmVzdGV6QG54cC5jb20+OyBndXN0YXZvQGVtYmVkZGVkb3IuY29tOw0KPiBtYXJ0aW5rQHBvc3Rl
by5kZTsgcnRyZXNpZGRAZWxlY3Ryb21hZy5jb20uYXU7IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5v
cmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgt
aW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0hdIGlpbzogYWNjZWxsOiBt
bWE4NDUyOiBmcmVlIGlpbyB0cmlnZ2VyIHBvaW50ZXIgd2hlbg0KPiBjbGVhbnVwDQo+IA0KPiBX
QVJOSU5HOiBUaGlzIGVtYWlsIHdhcyBjcmVhdGVkIG91dHNpZGUgb2YgTlhQLiBETyBOT1QgQ0xJ
Q0sgbGlua3Mgb3INCj4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRl
ciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IA0KPiBPbiBUaHUsIDQg
QXByIDIwMTkgMDg6MDI6MDUgKzAwMDANCj4gQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5j
b20+IHdyb3RlOg0KPiANCj4gPiBXaGVuIG1tYTg0NTIgaXMgYnVpbHQgYXMgbW9kdWxlLCBvbmNl
IGl0IGlzIGluc21vZCBhbmQgcm1tb2QsIGJlbG93DQo+ID4ga2VybmVsIGR1bXAgd2lsbCBzaG93
IG91dCwgdGhlIHJvb3QgY2F1c2UgaXMgbW9kdWxlIGJlaW5nIHB1dCB0d2ljZSBpZg0KPiA+IGlp
byB0cmlnZ2VyIHBvaW50ZXIgaXMgTk9UIE5VTEwsIHRoaXMgcGF0Y2ggZnJlZXMgaWlvIHRyaWdn
ZXIgcG9pbnRlcg0KPiA+IGFmdGVyIGlpbyB0cmlnZ2VyIGlzIHVucmVnaXN0ZXJlZCB0byBhdm9p
ZCBiZWxvdyBrZXJuZWwNCj4gPiBkdW1wOg0KPiA+DQo+ID4gLS0tLS0tLS0tLS0tWyBjdXQgaGVy
ZSBdLS0tLS0tLS0tLS0tDQo+ID4gV0FSTklORzogQ1BVOiAzIFBJRDogMjcwIGF0IGtlcm5lbC9t
b2R1bGUuYzoxMTQ1DQo+IG1vZHVsZV9wdXQrMHhkMC8weDE4OA0KPiA+IE1vZHVsZXMgbGlua2Vk
IGluOiBtbWE4NDUyKC0pDQo+ID4gQ1BVOiAzIFBJRDogMjcwIENvbW06IHJtbW9kIE5vdCB0YWlu
dGVkDQo+ID4gNS4xLjAtcmMzLW5leHQtMjAxOTA0MDMtMDAwMjItZzVlZGUwYzktZGlydHkgIzE1
OTYgSGFyZHdhcmUgbmFtZToNCj4gPiBGcmVlc2NhbGUgaS5NWDYgUXVhZC9EdWFsTGl0ZSAoRGV2
aWNlIFRyZWUpIFs8YzAxMTI3MmM+XQ0KPiA+ICh1bndpbmRfYmFja3RyYWNlKSBmcm9tIFs8YzAx
MGQwOTQ+XSAoc2hvd19zdGFjaysweDEwLzB4MTQpDQo+ID4gWzxjMDEwZDA5ND5dIChzaG93X3N0
YWNrKSBmcm9tIFs8YzBiZGMxNjA+XSAoZHVtcF9zdGFjaysweGQ4LzB4MTBjKQ0KPiA+IFs8YzBi
ZGMxNjA+XSAoZHVtcF9zdGFjaykgZnJvbSBbPGMwMTI3NWQ4Pl0gKF9fd2FybisweGY4LzB4MTI0
KQ0KPiA+IFs8YzAxMjc1ZDg+XSAoX193YXJuKSBmcm9tIFs8YzAxMjc3MTQ+XQ0KPiAod2Fybl9z
bG93cGF0aF9udWxsKzB4M2MvMHg0OCkNCj4gPiBbPGMwMTI3NzE0Pl0gKHdhcm5fc2xvd3BhdGhf
bnVsbCkgZnJvbSBbPGMwMWNhNGQwPl0NCj4gPiAobW9kdWxlX3B1dCsweGQwLzB4MTg4KSBbPGMw
MWNhNGQwPl0gKG1vZHVsZV9wdXQpIGZyb20gWzxjMDhhNWJiND5dDQo+ID4gKGlpb19kZXZpY2Vf
dW5yZWdpc3Rlcl90cmlnZ2VyX2NvbnN1bWVyKzB4MTgvMHgyNCkNCj4gPiBbPGMwOGE1YmI0Pl0g
KGlpb19kZXZpY2VfdW5yZWdpc3Rlcl90cmlnZ2VyX2NvbnN1bWVyKSBmcm9tDQo+ID4gWzxjMDhh
MGFiND5dIChpaW9fZGV2X3JlbGVhc2UrMHgyMC8wKSBbPGMwOGEwYWI0Pl0gKGlpb19kZXZfcmVs
ZWFzZSkNCj4gPiBmcm9tIFs8YzA2NWMwZTg+XSAoZGV2aWNlX3JlbGVhc2UrMHgyNC8weDhjKSBb
PGMwNjVjMGU4Pl0NCj4gPiAoZGV2aWNlX3JlbGVhc2UpIGZyb20gWzxjMGJlMTgxMD5dIChrb2Jq
ZWN0X3B1dCsweDc0LzB4ZDQpDQo+ID4gWzxjMGJlMTgxMD5dIChrb2JqZWN0X3B1dCkgZnJvbSBb
PGMwNjY0ZGMwPl0NCj4gPiAocmVsZWFzZV9ub2RlcysweDE2Yy8weDFmMCkgWzxjMDY2NGRjMD5d
IChyZWxlYXNlX25vZGVzKSBmcm9tDQo+ID4gWzxjMDY2MWI4MD5dIChkZXZpY2VfcmVsZWFzZV9k
cml2ZXJfaW50ZXJuYWwrMHhlYy8weDFhMCkNCj4gPiBbPGMwNjYxYjgwPl0gKGRldmljZV9yZWxl
YXNlX2RyaXZlcl9pbnRlcm5hbCkgZnJvbSBbPGMwNjYxYzkwPl0NCj4gPiAoZHJpdmVyX2RldGFj
aCsweDQ0LzB4ODApIFs8YzA2NjFjOTA+XSAoZHJpdmVyX2RldGFjaCkgZnJvbQ0KPiA+IFs8YzA2
NjA5NmM+XSAoYnVzX3JlbW92ZV9kcml2ZXIrMHg0Yy8weGEwKSBbPGMwNjYwOTZjPl0NCj4gPiAo
YnVzX3JlbW92ZV9kcml2ZXIpIGZyb20gWzxjMDFjYzFhND5dIChzeXNfZGVsZXRlX21vZHVsZSsw
eDEzMC8weDFkYykNCj4gPiBbPGMwMWNjMWE0Pl0gKHN5c19kZWxldGVfbW9kdWxlKSBmcm9tIFs8
YzAxMDEwMDA+XQ0KPiAocmV0X2Zhc3Rfc3lzY2FsbCsweDAvMHgyOCkgRXhjZXB0aW9uIHN0YWNr
KDB4ZThkODdmYTggdG8gMHhlOGQ4N2ZmMCkNCj4gPiA3ZmEwOiAgICAgICAgICAgICAgICAgICAw
MDAxZmZjMCAzODYxNmQ2ZCBiZTg3YmJmMCAwMDAwMDg4MCAwMDAwMDAwMCBiZTg3YmU5OA0KPiA+
IDdmYzA6IDAwMDFmZmMwIDM4NjE2ZDZkIDAwMzIzNTM0IDAwMDAwMDgxIDAwMGE5NzQ0IGJlODdi
ZjgxIDAwMGE5NzkwDQo+ID4gMDAwMDAwMDANCj4gPiA3ZmUwOiBiZTg3YmJlOCBiZTg3YmJkOCAw
MDAxZmUxOCBiNmUzODFhMCBpcnEgZXZlbnQgc3RhbXA6IDQwMTcNCj4gPiBoYXJkaXJxcyBsYXN0
ICBlbmFibGVkIGF0ICg0MDM1KTogWzxjMDE4OGEwYz5dDQo+ID4gY29uc29sZV91bmxvY2srMHg0
MDAvMHg2MzAgaGFyZGlycXMgbGFzdCBkaXNhYmxlZCBhdCAoNDA1Mik6DQo+ID4gWzxjMDE4ODY4
Yz5dIGNvbnNvbGVfdW5sb2NrKzB4ODAvMHg2MzAgc29mdGlycXMgbGFzdCAgZW5hYmxlZCBhdA0K
PiA+ICg0MDUwKTogWzxjMDEwMjY5OD5dIF9fZG9fc29mdGlycSsweDQ1OC8weDU1NCBzb2Z0aXJx
cyBsYXN0IGRpc2FibGVkDQo+ID4gYXQgKDQwNjkpOiBbPGMwMTJlZDZjPl0gaXJxX2V4aXQrMHgx
MzAvMHgxODAgLS0tWyBlbmQgdHJhY2UNCj4gPiBhN2JhOGYxODIzYjFlMDczIF0tLS0NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiBH
b29kIGZpbmUsIGJ1dCB0aGUgZml4IGlzIG5vdCBpbiB0aGUgYmVzdCBwbGFjZS4gIFRoZSBrZXkg
dGhpbmcgaXMgdGhhdCBhbnkNCj4gYXNzaWdubWVudCBpbnNpZGUgYSBkcml2ZXIgdG8gaWlvX2Rl
di0+dHJpZyBzaG91bGQgYmUgZG9uZSB3aXRoDQo+IGlpb190cmlnZ2VyX2dldC4NCj4gDQo+IGlu
ZGlvX2Rldi0+dHJpZyA9IGlpb190cmlnZ2VyX2dldCh0cmlnKS4gIFRoZSBpbnRlbnQgaXMgdG8g
YXZvaWQgdGhpcyBleGFjdCBkb3VibGUNCj4gZnJlZSwgYnV0IGFsc28gaGFuZGxlIGl0IGNvcnJl
Y3RseSBpZiB3ZSBhcmUgdXNpbmcgZGV2bV8gZm9yIGFsbCB0aGUgaGFuZGxpbmcuDQo+IA0KPiBJ
IGp1c3QgZGlkIGEgZ3JlcCBhbmQgdGhlcmUgYXJlIHF1aXRlIGEgZmV3IGRyaXZlcnMgbm90IGRv
aW5nIHRoaXMgdGhvdWdoIHNvIGl0J3MNCj4gb25lIHdlIHNob3VsZCBiZSBtb3JlIGNhcmVmdWwg
YWJvdXQuDQo+IA0KPiBIbW0uIEFueW9uZSBmYW5jeSBkb2luZyBhbiBhdWRpdCBvZiBleGlzdGlu
ZyBkcml2ZXJzIGFuZCBjaGVja2luZyB3aGljaA0KPiBvbmVzIGhhdmUgdGhpcyBwcm9ibGVtPyAg
U29tZSBzZWVtIHRvIGRvIGV4YWN0bHkgd2hhdCB5b3UgaGF2ZSBoZXJlLCBidXQNCj4gdGhhdCBp
c24ndCBhIHRoZSBiZXN0IHBhdHRlcm4gdG8gZW5jb3VyYWdlLg0KPiANCj4gRm9yIHRoaXMgb25l
IHdvdWxkIHlvdSBtaW5kIHRyeWluZyB3aXRoIHRoZSBpaW9fdHJpZ2dlcl9nZXQgYXBwcm9hY2gg
YW5kIGlmDQo+IEknbSBub3QgbWlzc2luZyBzb21ldGhpbmcsIHNlbmQgYSB2MiBmaXhpbmcgaXQg
dGhhdCB3YXk/DQoNCldpdGggYmVsb3cgcGF0Y2ggdG8gdXNlIGlpb190cmlnZ2VyX2dldCwgbG9v
a3MgbGlrZSB0cnlfcmVsZWFzZV9tb2R1bGVfcmVmKCkgd2lsbCByZXR1cm4gMQ0KYW5kIGNhdXNl
IHRyeV9zdG9wX21vZHVsZSgpIHJldHVybiBmYWlsIGFuZCB3ZSB3aWxsIHNlZSAiIHJtbW9kOiBj
YW4ndCB1bmxvYWQgJ21tYTg0NTInOiBSZXNvdXJjZSB0ZW1wb3JhcmlseSB1bmF2YWlsYWJsZSAi
LA0KDQpBcyB0aGUgbW9kdWxlIHJlZiBjb3VudCBjaGVjayBpcyBiZWZvcmUgaWlvX2RldmljZV91
bnJlZ2lzdGVyX3RyaWdnZXJfY29uc3VtZXIoKSBpcyBjYWxsZWQgd2hpY2gNCndpbGwgZG8gaWlv
X3RyaWdnZXJfcHV0KCksIHNvIGxvb2tzIGxpa2UgdGhlcmUgaXMgc3RpbGwgc29tZXRoaW5nIHdy
b25nIHdpdGggdGhlIG1vZHVsZSByZWYgY291bnQ/IA0KDQorKysgYi9kcml2ZXJzL2lpby9hY2Nl
bC9tbWE4NDUyLmMNCkBAIC0xNDY4LDE3ICsxNDY4LDE1IEBAIHN0YXRpYyBpbnQgbW1hODQ1Ml90
cmlnZ2VyX3NldHVwKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQogICAgICAgIGlmIChyZXQp
DQogICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCg0KLSAgICAgICBpbmRpb19kZXYtPnRyaWcg
PSB0cmlnOw0KKyAgICAgICBpbmRpb19kZXYtPnRyaWcgPSBpaW9fdHJpZ2dlcl9nZXQodHJpZyk7
DQoNClRoYW5rcywNCkFuc29uLg0KDQo+IA0KPiBUaGFua3MNCj4gDQo+IEpvbmF0aGFuDQo+IA0K
PiANCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9paW8vYWNjZWwvbW1hODQ1Mi5jIHwgNCArKystDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hY2NlbC9tbWE4NDUyLmMgYi9kcml2ZXJzL2lp
by9hY2NlbC9tbWE4NDUyLmMNCj4gPiBpbmRleCAzMDI3ODExLi42YjE4MTc3IDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvaWlvL2FjY2VsL21tYTg0NTIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaWlv
L2FjY2VsL21tYTg0NTIuYw0KPiA+IEBAIC0xNDc1LDggKzE0NzUsMTAgQEAgc3RhdGljIGludCBt
bWE4NDUyX3RyaWdnZXJfc2V0dXAoc3RydWN0IGlpb19kZXYNCj4gPiAqaW5kaW9fZGV2KQ0KPiA+
DQo+ID4gIHN0YXRpYyB2b2lkIG1tYTg0NTJfdHJpZ2dlcl9jbGVhbnVwKHN0cnVjdCBpaW9fZGV2
ICppbmRpb19kZXYpICB7DQo+ID4gLSAgICAgaWYgKGluZGlvX2Rldi0+dHJpZykNCj4gPiArICAg
ICBpZiAoaW5kaW9fZGV2LT50cmlnKSB7DQo+ID4gICAgICAgICAgICAgICBpaW9fdHJpZ2dlcl91
bnJlZ2lzdGVyKGluZGlvX2Rldi0+dHJpZyk7DQo+ID4gKyAgICAgICAgICAgICBpbmRpb19kZXYt
PnRyaWcgPSBOVUxMOw0KPiA+ICsgICAgIH0NCj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRpYyBpbnQg
bW1hODQ1Ml9yZXNldChzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50KQ0KDQo=
