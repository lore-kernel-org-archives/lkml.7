Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F46C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 07:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB76420842
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 07:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="q6F1+fOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbfI3HnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 03:43:00 -0400
Received: from mail-eopbgr60053.outbound.protection.outlook.com ([40.107.6.53]:25670
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbfI3Hm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 03:42:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mat9aCpGkf8oOZf9vztchxB/4obU/BAa2YWGUK1OOIxrRVsJHD/0/e2RJlqgGj2w24xfXCGyTNpF8foyu+I9nNH/i7nW9t+k93OQXG0gK1NXPXGZA5RTkyVECyHp7qaYKEv2dh5R4G4YHyEfAkEGdvO9uEWVCBXxirbzGPgIOxfd/EKIQ7nL5ztoCQfkzdprz1Bk1CAjQFZrOUFYhDueElUTAXVG7MwLn9u/3sAPKBlJx11H/vsxnLHXnRUjU4K3GDRdMv6JuiduJXK/EyBDCl5qklBESapMUzzVGlMjAk47zWT24stYSktdp2IupYQJbLLYHuhvMe6P+W7K+jRTgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztC8OOKd11OEEpj6Kd+/o51IBmm1whnhylBv0wqYAhw=;
 b=cKf+d3ZXfDsj+0ypMc1ddU7wSGCH3NTgmuFWWIHcxS4EJss11fvok8y01S9nb6SLGliUhi9YMx2YbwBycazP64kMyqEXYdoxUdZrhjqNkGIKRVPyaijyyJb0QWMVJpkTzH339APe2KifG7FuDbwDSKeH9QXMBZykL0d+hanNXidyJDIKWcdXSkASSEHwzm2plIUS8+kwOrgZ1qU89rC4K3KFlgDqTr/Vq0oAdS18VAW6Kgbj6RsEJGZxX074gFR7WT9qHGZPUOuJBuKX3imiVERwBbsis3picEHguRVmhI7FNH/FDSSGbTMLQp9RrH4A2TBpkfjq3PXG4mHU5i9P1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztC8OOKd11OEEpj6Kd+/o51IBmm1whnhylBv0wqYAhw=;
 b=q6F1+fOFzlCUktgs5AlltiysVuNB+hrO0rtjaa4Uq3M/4CDH31bIKMa2Vh5PorirVt0pyWR29AJev8bwR+H2jJIxIMufcEZlVwKkG+AywGrpugpNnFPwPfx2gD/mqN6H6wUVkmH9xlcSe6ZFIFfHjR6KszqKytQzOgmEiq6oWNs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3724.eurprd04.prod.outlook.com (52.134.66.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Mon, 30 Sep 2019 07:42:54 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0%6]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 07:42:53 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] firmware: imx: Skip return value check for some special
 SCU firmware APIs
Thread-Topic: [PATCH] firmware: imx: Skip return value check for some special
 SCU firmware APIs
Thread-Index: AQHVc4lT/ErvPybCJUCbZ2x7mLGjsqdD3Bbw
Date:   Mon, 30 Sep 2019 07:42:53 +0000
Message-ID: <DB3PR0402MB39169BC7E8DB3525A309034EF5820@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1569406066-16626-1-git-send-email-Anson.Huang@nxp.com>
 <20190926075914.i7tsd3cbpitrqe4q@pengutronix.de>
 <DB3PR0402MB391683202692BEAE4D2CD9C1F5860@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190926100558.egils3ds37m3s5wo@pengutronix.de>
 <VI1PR04MB702336F648EA1BF0E4AC584BEE860@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <DB3PR0402MB391675F9BF6FCA315B124BEBF5810@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <VI1PR04MB702322F2F020A527AD2F8DDEEE820@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB702322F2F020A527AD2F8DDEEE820@VI1PR04MB7023.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d64775b6-04de-4499-e611-08d74579cd59
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DB3PR0402MB3724:|DB3PR0402MB3724:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB372425D047A8F351CACC016EF5820@DB3PR0402MB3724.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(199004)(189003)(8676002)(44832011)(66066001)(86362001)(71200400001)(14454004)(6506007)(53546011)(74316002)(81156014)(5660300002)(76176011)(102836004)(81166006)(305945005)(66446008)(6116002)(3846002)(2906002)(476003)(76116006)(66946007)(66556008)(64756008)(66476007)(486006)(4326008)(478600001)(446003)(11346002)(71190400001)(7736002)(54906003)(186003)(6246003)(9686003)(256004)(55016002)(229853002)(33656002)(25786009)(316002)(110136005)(99286004)(6636002)(6436002)(8936002)(7696005)(26005)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3724;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DPg1vHzn3k5mvtjjV/qsbwuD1NaX59/JTGwLciFb1tS8g466zxG6OYeMupzn9pZEQxSqO5hgGjMDn+prfqswSLWmAOnMEpux04jk6UVz+0bgxDefNCbkNLvuZnA+hfGzd21ga6mVaPxVAnwB4nWQbOLeAaI/99qjSSWsarGz2jqHH9TUHp5DpIdfdxTVff0mAuE6CJxcfuK71xpEqlv3Ns40gkcUpk2Jt0WiPKxawFmPrXdRDIXIkVjghXI8d1BJ16VbW2UyAulKqP1YOxWZP95hObCX/twGYYr/Zy2weH3vcFVPHGo8dQdVbMfPwo2lcTI8+w3ShC5adClDvIL6wb80Flpp3sx28zT+en+0TqS+xEvv6y0d64xxL3+8jUNxcT/WSMYUwfR0mhwnILGe2gLwGGS7+RA8fkO9jEwL9JM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d64775b6-04de-4499-e611-08d74579cd59
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 07:42:53.3675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GeinievhZ/i0/nhONHnDeGBG2ev1JlXSxhHSop4lrqKyfbNkXkLFUISgyxdTy/0VqwbEqqjIRLYO/8ze5TF3/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3724
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIExlb25hcmQNCg0KPiBPbiAyMDE5LTA5LTI3IDQ6MjAgQU0sIEFuc29uIEh1YW5nIHdyb3Rl
Og0KPiA+PiBPbiAyMDE5LTA5LTI2IDE6MDYgUE0sIE1hcmNvIEZlbHNjaCB3cm90ZToNCj4gPj4+
IE9uIDE5LTA5LTI2IDA4OjAzLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4gPj4+Pj4gT24gMTktMDkt
MjUgMTg6MDcsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+Pj4+Pj4gVGhlIFNDVSBmaXJtd2FyZSBk
b2VzIE5PVCBhbHdheXMgaGF2ZSByZXR1cm4gdmFsdWUgc3RvcmVkIGluDQo+ID4+Pj4+PiBtZXNz
YWdlIGhlYWRlcidzIGZ1bmN0aW9uIGVsZW1lbnQgZXZlbiB0aGUgQVBJIGhhcyByZXNwb25zZSBk
YXRhLA0KPiA+Pj4+Pj4gdGhvc2Ugc3BlY2lhbCBBUElzIGFyZSBkZWZpbmVkIGFzIHZvaWQgZnVu
Y3Rpb24gaW4gU0NVIGZpcm13YXJlLA0KPiA+Pj4+Pj4gc28gdGhleSBzaG91bGQgYmUgdHJlYXRl
ZCBhcyByZXR1cm4gc3VjY2VzcyBhbHdheXMuDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gK3N0YXRpYyBj
b25zdCBzdHJ1Y3QgaW14X3NjX3JwY19tc2cgd2hpdGVsaXN0W10gPSB7DQo+ID4+Pj4+PiArCXsg
LnN2YyA9IElNWF9TQ19SUENfU1ZDX01JU0MsIC5mdW5jID0NCj4gPj4+Pj4gSU1YX1NDX01JU0Nf
RlVOQ19VTklRVUVfSUQgfSwNCj4gPj4+Pj4+ICsJeyAuc3ZjID0gSU1YX1NDX1JQQ19TVkNfTUlT
QywgLmZ1bmMgPQ0KPiA+Pj4+Pj4gK0lNWF9TQ19NSVNDX0ZVTkNfR0VUX0JVVFRPTl9TVEFUVVMg
fSwgfTsNCj4gPj4+Pj4NCj4gPj4+Pj4gSXMgdGhpcyBnb2luZyB0byBiZSBleHRlbmRlZCBpbiB0
aGUgbmVhciBmdXR1cmU/IEkgc2VlIHNvbWUNCj4gPj4+Pj4gdXBjb21pbmcgcHJvYmxlbXMgaGVy
ZSBpZiBzb21lb25lIHVzZXMgYSBkaWZmZXJlbnQgc2N1LWZ3PC0+a2VybmVsDQo+ID4+Pj4+IGNv
bWJpbmF0aW9uIGFzIG54cCB3b3VsZCBzdWdnZXN0Lg0KPiA+Pj4+DQo+ID4+Pj4gQ291bGQgYmUs
IGJ1dCBJIGNoZWNrZWQgdGhlIGN1cnJlbnQgQVBJcywgT05MWSB0aGVzZSAyIHdpbGwgYmUgdXNl
ZA0KPiA+Pj4+IGluIExpbnV4IGtlcm5lbCwgc28gSSBPTkxZIGFkZCB0aGVzZSAyIEFQSXMgZm9y
IG5vdy4NCj4gPj4+DQo+ID4+PiBPa2F5Lg0KPiA+Pj4NCj4gPj4+PiBIb3dldmVyLCBhZnRlciBy
ZXRoaW5rLCBtYXliZSB3ZSBzaG91bGQgYWRkIGFub3RoZXIgaW14X3NjX3JwYyBBUEkNCj4gPj4+
PiBmb3IgdGhvc2Ugc3BlY2lhbCBBUElzPyBUbyBhdm9pZCBjaGVja2luZyBpdCBmb3IgYWxsIHRo
ZSBBUElzDQo+ID4+Pj4gY2FsbGVkIHdoaWNoDQo+ID4+IG1heSBpbXBhY3Qgc29tZSBwZXJmb3Jt
YW5jZS4NCj4gPj4+PiBTdGlsbCB1bmRlciBkaXNjdXNzaW9uLCBpZiB5b3UgaGF2ZSBiZXR0ZXIg
aWRlYSwgcGxlYXNlIGFkdmlzZSwgdGhhbmtzIQ0KPiA+Pg0KPiA+PiBNeSBzdWdnZXN0aW9uIGlz
IHRvIHJlZmFjdG9yIHRoZSBjb2RlIGFuZCBhZGQgYSBuZXcgQVBJIGZvciB0aGUgdGhpcw0KPiA+
PiAibm8gZXJyb3IgdmFsdWUiIGNvbnZlbnRpb24uIEludGVybmFsbHkgdGhleSBjYW4gY2FsbCBh
IGNvbW1vbg0KPiA+PiBmdW5jdGlvbiB3aXRoIGZsYWdzLg0KPiA+DQo+ID4gSWYgSSB1bmRlcnN0
YW5kIHlvdXIgcG9pbnQgY29ycmVjdGx5LCB0aGF0IG1lYW5zIHRoZSBsb29wIGNoZWNrIG9mDQo+
ID4gd2hldGhlciB0aGUgQVBJIGlzIHdpdGggIm5vIGVycm9yIHZhbHVlIiBmb3IgZXZlcnkgQVBJ
IHN0aWxsIE5PVCBiZQ0KPiA+IHNraXBwZWQsIGl0IGlzIGp1c3QgcmVmYWN0b3JpbmcgdGhlIGNv
ZGUsIHJpZ2h0Pw0KPiANCj4gVGhlcmUgd291bGQgYmUgbm8gImxvb3AiIGFueXdoZXJlOiB0aGUg
cmVzcG9uc2liaWxpdHkgd291bGQgZmFsbCBvbiB0aGUgY2FsbA0KPiB0byBjYWxsIHRoZSByaWdo
dCBSUEMgZnVuY3Rpb24uIEluIHRoZSBjdXJyZW50IGxheWVyaW5nIHNjaGVtZSAoZHJpdmVycyAt
PiBSUEMgLT4NCj4gbWFpbGJveCkgdGhlIFJQQyBsYXllciB0cmVhdHMgYWxsIGNhbGxzIHRoZSBz
YW1lIGFuZCBpdCdzIHVwIHRoZSB0aGUgY2FsbGVyIHRvDQo+IHByb3ZpZGUgaW5mb3JtYXRpb24g
YWJvdXQgY2FsbGluZyBjb252ZW50aW9uLg0KPiANCj4gQW4gZXhhbXBsZSBpbXBsZW1lbnRhdGlv
bjoNCj4gKiBSZW5hbWUgaW14X3NjX3JwY19jYWxsIHRvIF9faW14X3NjX3JwY19jYWxsX2ZsYWdz
DQo+ICogTWFrZSBhIHRpbnkgaW14X3NjX3JwY19jYWxsIHdyYXBwZXIgd2hpY2gganVzdCBjb252
ZXJ0cyByZXNwL25vcmVzcCB0byBhDQo+IGZsYWcNCj4gKiBNYWtlIGdldCBidXR0b24gc3RhdHVz
IGNhbGwgX19pbXhfc2NfcnBjX2NhbGxfZmxhZ3Mgd2l0aCB0aGUNCj4gX0lNWF9TQ19SUENfTk9F
UlJPUiBmbGFnDQo+IA0KPiBIb3BlIHRoaXMgbWFrZXMgbXkgc3VnZ2VzdGlvbiBjbGVhcmVyPyBQ
dXNoaW5nIHRoaXMgdG8gdGhlIGNhbGxlciBpcyBhIGJpdCB1Z2x5DQo+IGJ1dCBJIHRoaW5rIGl0
J3Mgd29ydGggcHJlc2VydmluZyB0aGUgZmFjdCB0aGF0IHRoZSBpbXggcnBjIGNvcmUgdHJlYXRz
IHNlcnZpY2VzDQo+IGluIGFuIHVuaWZvcm0gd2F5Lg0KDQpJdCBpcyBjbGVhciBub3csIHNvIGVz
c2VudGlhbGx5IGl0IGlzIHNhbWUgYXMgMiBzZXBhcmF0ZSBBUElzLCBzdGlsbCBuZWVkIHRvIGNo
YW5nZSB0aGUNCmJ1dHRvbiBkcml2ZXIgYW5kIHVpZCBkcml2ZXIgdG8gdXNlIHRoZSBzcGVjaWFs
IGZsYWcsIG1lYW53aGlsZSwgbmVlZCB0byBjaGFuZ2UgdGhlDQp0aGlyZCBwYXJhbWVudCBvZiBp
bXhfc2NfcnBjX2NhbGwoKSBmcm9tIGJvb2wgdG8gdTMyLg0KDQpJZiBubyBvbmUgb3Bwb3NlcyB0
aGlzIGFwcHJvYWNoLCBJIHdpbGwgcmVkbyB0aGUgcGF0Y2ggdG9nZXRoZXIgd2l0aCB0aGUgYnV0
dG9uIGRyaXZlcg0KYW5kIHVpZCBkcml2ZXIgYWZ0ZXIgaG9saWRheS4NCg0KQW5zb24NCg==
