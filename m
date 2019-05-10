Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60974C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9E3216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qYz8ng8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfEJPMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 11:12:16 -0400
Received: from mail-eopbgr30078.outbound.protection.outlook.com ([40.107.3.78]:31719
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727346AbfEJPMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQ2yySLpUu+rgX3R/tA8BziKACc1JJtT+cg0otofrdc=;
 b=qYz8ng8Fn+tmd3s2+m6ckpJHliTlrE7ICgEbsEoCUgu63d35gllllFudiZIoVsqQ72jupfu3p4PmUNelPPNJQQwPARCSfSy34eH0BwxR+htNrhJ3q9325GVVMtEJgP0ek1WKgV15jVq2SWBUnVCRTo2N90RfcSnP92eLkXU323Q=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
 VI1PR04MB5551.eurprd04.prod.outlook.com (20.178.122.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Fri, 10 May 2019 15:12:09 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8942:6d16:631:413]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8942:6d16:631:413%4]) with mapi id 15.20.1856.012; Fri, 10 May 2019
 15:12:09 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Robin Murphy <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>
CC:     Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 0/3] prerequisites for device reserved local mem
 rework
Thread-Topic: [RFC PATCH 0/3] prerequisites for device reserved local mem
 rework
Thread-Index: AQHVB0CaXlf8LkCelkGo7xOGpcRI/KZkdJWAgAABkYA=
Date:   Fri, 10 May 2019 15:12:09 +0000
Message-ID: <VI1PR04MB513477794F2A46DB095FDD50EC0C0@VI1PR04MB5134.eurprd04.prod.outlook.com>
References: <20190510145646.10078-1-laurentiu.tudor@nxp.com>
 <e6410453-9ca3-4bdc-3c74-654333f2806f@arm.com>
In-Reply-To: <e6410453-9ca3-4bdc-3c74-654333f2806f@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a2f0722-3da9-47f5-2258-08d6d559df7c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5551;
x-ms-traffictypediagnostic: VI1PR04MB5551:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB5551976B267C9801F8739645EC0C0@VI1PR04MB5551.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(136003)(376002)(396003)(13464003)(199004)(189003)(305945005)(53936002)(186003)(74316002)(4326008)(3846002)(66946007)(7736002)(66476007)(64756008)(76116006)(66446008)(66556008)(6116002)(2906002)(2171002)(81156014)(81166006)(8676002)(44832011)(71190400001)(71200400001)(5660300002)(8936002)(446003)(26005)(6246003)(25786009)(476003)(11346002)(478600001)(45080400002)(486006)(54906003)(9686003)(66066001)(73956011)(256004)(316002)(86362001)(110136005)(102836004)(966005)(2501003)(2201001)(68736007)(14454004)(52536014)(55016002)(229853002)(76176011)(6506007)(53546011)(7696005)(6306002)(6436002)(99286004)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5551;H:VI1PR04MB5134.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yHmqqmKocl3QuqNl1LzP+oeOqc9Bqmgl8Gl/7leEO/5JWEtZk9Ru+dqBM3CvkaoKurxFJ+RFPFq5esQxLKRIfNd2qdiu/UIs1fTDbDZSm1Dr1tvVOKdIX2uUv4JqYlCwoEP/aOqHw/sDGoBOuxSYd12hvKc5hJXJoJs2kCnzkWtEecohu8nhjQnrZae3mGzYcGDoOQM2PvGdPMGQ7lfX0ioG1I4iioQuoy60d8uKtiPkLPFiyLbjsZBIsBjnyc4QLOJb8HueaxNAcnRvjdqw3A87j+S4g2bwihphIc4UUjSjyEe7AXAcMiLsqNVXgUl+fUxTmkLp80PHFucRoMjW/cZfAjWaCVA7MWJS2kOJ+KZA7/llYb0NGssMugAaBQRAFA5AIthc8Uuxa2W9Pj2hlYT2gT8q3ZAafMCyQ8yCi5M=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2f0722-3da9-47f5-2258-08d6d559df7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 15:12:09.6523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5551
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iaW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4g
TXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4NCj4gU2VudDogRnJpZGF5LCBNYXkgMTAsIDIw
MTkgNjowNCBQTQ0KPiANCj4gSGkgTGF1cmVudGl1LA0KPiANCj4gT24gMTAvMDUvMjAxOSAxNTo1
NiwgIHdyb3RlOg0KPiA+IEZyb206IExhdXJlbnRpdSBUdWRvciA8bGF1cmVudGl1LnR1ZG9yQG54
cC5jb20+DQo+ID4NCj4gPiBGb3IgSENzIHRoYXQgaGF2ZSBsb2NhbCBtZW1vcnksIHJlcGxhY2Ug
dGhlIGN1cnJlbnQgRE1BIEFQSSB1c2FnZQ0KPiA+IHdpdGggYSBnZW5hbGxvYyBnZW5lcmljIGFs
bG9jYXRvciB0byBtYW5hZ2UgdGhlIG1hcHBpbmdzIGZvciB0aGVzZQ0KPiA+IGRldmljZXMuDQo+
ID4gVGhpcyBpcyBpbiBwcmVwYXJhdGlvbiBmb3IgZHJvcHBpbmcgdGhlIGV4aXN0aW5nICJjb2hl
cmVudCIgZG1hDQo+ID4gbWVtIGRlY2xhcmF0aW9uIEFQSXMuIEN1cnJlbnQgaW1wbGVtZW50YXRp
b24gd2FzIHJlbHlpbmcgb24gYSBzaG9ydA0KPiA+IGNpcmN1aXQgaW4gdGhlIERNQSBBUEkgdGhh
dCBpbiB0aGUgZW5kLCB3YXMgYWN0aW5nIGFzIGFuIGFsbG9jYXRvcg0KPiA+IGZvciB0aGVzZSB0
eXBlIG9mIGRldmljZXMuDQo+ID4NCj4gPiBPbmx5IGNvbXBpbGVkIHRlc3RlZCwgc28gYW55IHZv
bHVudGVlcnMgd2lsbGluZyB0byB0ZXN0IGFyZSBtb3N0IHdlbGNvbWUuDQo+IA0KPiBCYXNlZCBv
biBteSBkaWdnaW5ncyBpbnRvIHRoaXMgaW4gdGhlIHBhc3QsIEkgd291bGQgZXhwZWN0IHRoYXQg
eW91IG5lZWQNCj4gdG8gZG8gc29tZXRoaW5nIGFib3V0IGhjZF9hbGxvY19jb2hlcmVudCgpIGFz
IHdlbGwuDQoNCkluZGVlZCBsb29rcyBsaWtlIGl0LiBUaGFua3MgYSBsb3QgZm9yIHRoZSBwb2lu
dGVyLCBJJ2xsIGRpZyBpbnRvIGl0Lg0KDQotLS0NCkJlc3QgUmVnYXJkcywgTGF1cmVudGl1DQoN
Cj4gDQo+ID4NCj4gPiBUaGFuayB5b3UhDQo+ID4NCj4gPiBGb3IgY29udGV4dCwgc2VlIHRocmVh
ZCBoZXJlOg0KPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29t
Lz91cmw9aHR0cHMlM0ElMkYlMkZsa21sLm9yZw0KPiAlMkZsa21sJTJGMjAxOSUyRjQlMkYyMiUy
RjM1NyZhbXA7ZGF0YT0wMiU3QzAxJTdDbGF1cmVudGl1LnR1ZG9yJTQwbnhwLmNvbQ0KPiAlN0Mx
YWQ0YzM3N2QxMDk0MTkxMjFiODA4ZDZkNTU4YjBiMCU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5
YzVjMzAxNjM1JTdDMA0KPiAlN0MwJTdDNjM2OTMwOTc0MjU3NTgxNjE0JmFtcDtzZGF0YT1wTlJQ
UElvQm1aN1VCZmlwJTJGalJCWWlNZ0dUM3BmMXJpV0xuMg0KPiBEUyUyRm90bDQlM0QmYW1wO3Jl
c2VydmVkPTANCj4gPg0KPiA+IExhdXJlbnRpdSBUdWRvciAoMyk6DQo+ID4gICAgb2hjaS1oY2Q6
IHVzZSBnZW5hbGxvYyBmb3IgVVNCIEhDcyB3aXRoIGxvY2FsIG1lbW9yeQ0KPiA+ICAgIHVzYjog
aG9zdDogb2hjaS1zbTUwMTogaW5pdCBnZW5hbGxvYyBmb3IgbG9jYWwgbWVtb3J5DQo+ID4gICAg
dXNiOiBob3N0OiBvaGNpLXRtaW86IGluaXQgZ2VuYWxsb2MgZm9yIGxvY2FsIG1lbW9yeQ0KPiA+
DQo+ID4gICBkcml2ZXJzL3VzYi9ob3N0L29oY2ktaGNkLmMgICB8IDIxICsrKysrKysrKy0tLQ0K
PiA+ICAgZHJpdmVycy91c2IvaG9zdC9vaGNpLXNtNTAxLmMgfCA2MyArKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAgZHJpdmVycy91c2IvaG9zdC9vaGNpLXRtaW8uYyAg
fCAyMyArKysrKysrKy0tLS0tDQo+ID4gICBkcml2ZXJzL3VzYi9ob3N0L29oY2kuaCAgICAgICB8
ICAzICsrDQo+ID4gICA0IGZpbGVzIGNoYW5nZWQsIDY5IGluc2VydGlvbnMoKyksIDQxIGRlbGV0
aW9ucygtKQ0KPiA+DQo=
