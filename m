Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44D0C47404
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 00:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA3B2054F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 00:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XAAlKTaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbfJHAs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 20:48:28 -0400
Received: from mail-eopbgr130052.outbound.protection.outlook.com ([40.107.13.52]:14917
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729285AbfJHAs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 20:48:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hvk20YeFxyAQo4dKHf5OFuiMEz3FRZSmmAlK0SuDjxxj/4i5BLzXT5vA+dZH4nd5JS6VLPJa63zDcINLymIPb2h6rn+ZM6x/RHPYGl33rh5r3Fxg0baspZqr57Oxer8KDoHuHYBI8tpLhFK5YV7QqOHRXkxh8ggPw3f+QVPl2yRf3FGlCNUGg3qq/kgF/zZgT66j3LLwBzBsnrQY87g0efkfrVdQXGHONnfHedns3tQYGcGl+x83q83F1RT4dGdDM08svAuFl4eJRhDSqfmnzRDiQG6wL53zXHFdGGfPjBwnNqXzneaMR+hWHNAD3Aec35sAh2koFT2I/iuO8WfXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWlhy7Ulay98BBvb22/jVbUVVDCr90rZBWYDSeMv0Kg=;
 b=je7yMFkwauS06zhhFMaSs518Nw8PH7N2xvAl0UglRW5FlMtf7GfZR3BYpwgTLoGurIFwpv/zqC84L3jRwd7zL86Y9Tlt/wFZ2nlHMnCXckGfEdy4zt3mNi2Q/1uwj7Hdw8oh07bn4Ji9zKpuB6eLS/Svo0Uy4diDG99W4XfLtTyFT3yrmROLvoV7QheWyvpLSn2rMmgEkM9gWQLlt4EkzaV38dOKwR2clRFrPGwrnmPIiFqKwitM7P5YfnJP72+Dd2vlmC1J+Xinf+TgfTTHrcBrAuwu++CdUwrIMD7qF9Lz83Xd4ZWEs6EjZNe0IvfrG+abpgDRgqfyn3gU4LHvog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWlhy7Ulay98BBvb22/jVbUVVDCr90rZBWYDSeMv0Kg=;
 b=XAAlKTaMcp/2QJ0sFMtBlY8wqDYUxKdYkcJoxxhoBIbaxKPKXBoLPPRQKqtH1FKwk1GhdWM0VlIXp6NyLb3Z0EiwrlCmHNWwILafea7SAUUFinxkQia4zcZPqiiUhsXFSuKohu+iMvCBt7pNBavgr7ypVYXkgzeE91xuZbEc5zg=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3446.eurprd04.prod.outlook.com (52.133.19.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Tue, 8 Oct 2019 00:48:24 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::b0c2:4fbb:fae7:991]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::b0c2:4fbb:fae7:991%5]) with mapi id 15.20.2327.026; Tue, 8 Oct 2019
 00:48:24 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] firmware: imx: Skip return value check for some
 special SCU firmware APIs
Thread-Topic: [PATCH V2] firmware: imx: Skip return value check for some
 special SCU firmware APIs
Thread-Index: AQHVfK0Yhw8grvoW2E2n3r70yUmdBKdO0YaAgAEYy6A=
Date:   Tue, 8 Oct 2019 00:48:24 +0000
Message-ID: <AM6PR0402MB39118DABDE62496539D7EE6DF59A0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <1570410959-32563-1-git-send-email-Anson.Huang@nxp.com>
 <20191007080135.4e5ljhh6z2rbx5bw@pengutronix.de>
In-Reply-To: <20191007080135.4e5ljhh6z2rbx5bw@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 057eeed9-b4f4-4b60-e071-08d74b89398a
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM6PR0402MB3446:|AM6PR0402MB3446:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0402MB3446F1749864E1B70AC0EACAF59A0@AM6PR0402MB3446.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(189003)(199004)(14454004)(26005)(6306002)(66066001)(71190400001)(4326008)(55016002)(71200400001)(229853002)(81166006)(8936002)(81156014)(966005)(6916009)(8676002)(2906002)(86362001)(7736002)(52536014)(6116002)(74316002)(3846002)(305945005)(9686003)(186003)(54906003)(76116006)(5660300002)(446003)(478600001)(316002)(66476007)(66556008)(6436002)(66446008)(66946007)(64756008)(11346002)(6506007)(7696005)(76176011)(53546011)(25786009)(102836004)(476003)(44832011)(256004)(33656002)(45080400002)(99286004)(486006)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3446;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kAfxKOvzP5C/0Ym4qRlEHhOfRVlj/YHJZylYbQzi6B7+I5gG72e5L+s4qHkNA0JHNWfmoMFRwKgM54DW13Mqt528qhFDpd7peCbDBKXrR8iu8kVa0NzuW6gjEm395ckCnzlnC+K+kv/RyfPfHMNmOdhHAcv5ntIY82j6EPf68KemvFhM0nE7MrtqkgFefG0AJRFsTd0K45M8pkB8ZYqxJJ0eebZwMzaxNjM/cW5oxR+vb0ty3g6CTlyFAx4Y2uzuTovd8E6YdVvtol5CVqSpuZyRltDUJy9z9F6IXHl9s5mo09w5eAyP3uJEBNbsaXZOnzSjcD5troADQ2yeonp37LkxgafxYVHuZqRhpVE7ISYwYOzMceHkubBaOeWeMMx4xUNqb9BiStwVe60lsXvYQIb+TkPI2htvvNli6grXmf4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 057eeed9-b4f4-4b60-e071-08d74b89398a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 00:48:24.3680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RCtNaPTX+M3ESGvT+5xjVoWxRND4OvmR+L+NvGKBTl53i1EgU43iMVdgXxi6CKamhInm2pUN2wLeIWQ8zXKhRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3446
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1hcmNvDQoNCj4gT24gMTktMTAtMDcgMDk6MTUsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+
IFRoZSBTQ1UgZmlybXdhcmUgZG9lcyBOT1QgYWx3YXlzIGhhdmUgcmV0dXJuIHZhbHVlIHN0b3Jl
ZCBpbiBtZXNzYWdlDQo+ID4gaGVhZGVyJ3MgZnVuY3Rpb24gZWxlbWVudCBldmVuIHRoZSBBUEkg
aGFzIHJlc3BvbnNlIGRhdGEsIHRob3NlDQo+ID4gc3BlY2lhbCBBUElzIGFyZSBkZWZpbmVkIGFz
IHZvaWQgZnVuY3Rpb24gaW4gU0NVIGZpcm13YXJlLCBzbyB0aGV5DQo+ID4gc2hvdWxkIGJlIHRy
ZWF0ZWQgYXMgcmV0dXJuIHN1Y2Nlc3MgYWx3YXlzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
QW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBz
aW5jZSBWMToNCj4gPiAJLSBVc2UgZGlyZWN0IEFQSSBjaGVjayBpbnN0ZWFkIG9mIGNhbGxpbmcg
YW5vdGhlciBmdW5jdGlvbiB0byBjaGVjay4NCj4gPiAJLSBUaGlzIHBhdGNoIGlzIGJhc2VkIG9u
DQo+ID4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJs
PWh0dHBzJTNBJTJGJTJGcGF0Yw0KPiA+DQo+IGh3b3JrLmtlcm5lbC5vcmclMkZwYXRjaCUyRjEx
MTI5NTUzJTJGJmFtcDtkYXRhPTAyJTdDMDElN0NhbnNvbi4NCj4gaHVhbmclDQo+ID4NCj4gNDBu
eHAuY29tJTdDMmRlMGE2YmU2OWI3NGNjMjQ5YWQwOGQ3NGFmYzk3MzAlN0M2ODZlYTFkM2JjMmI0
YzZmDQo+IGE5MmNkOTkNCj4gPg0KPiBjNWMzMDE2MzUlN0MwJTdDMCU3QzYzNzA2MDMyMTA0NjI0
NzA0MCZhbXA7c2RhdGE9Uk1GQWRMS0dLYjYNCj4gbUVkaHljcnpIWA0KPiA+IFIwM0U2UXI1cFd5
UmM4Wms2RXJsQmMlM0QmYW1wO3Jlc2VydmVkPTANCj4gDQo+IFRoYW5rcyBmb3IgdGhpcyB2Mi4g
SXQgd291bGQgYmUgZ29vZCB0byBjaGFuZ2UgdGhlIGNhbGxlcnMgd2l0aGluIHRoaXMgc2VyaWVz
Lg0KDQpOT1QgcXVpdGUgdW5kZXJzdGFuZCB5b3VyIHBvaW50LCB0aGUgY2FsbGVycyBkb2VzIE5P
VCBuZWVkIHRvIGJlIGNoYW5nZWQsIHRob3NlDQoyIHNwZWNpYWwgQVBJcyBjYWxsZXJzIGFyZSBh
bHJlYWR5IGZvbGxvd2luZyB0aGUgcmlnaHQgd2F5IG9mIGNhbGxpbmcgdGhlIEFQSXMuDQoNCkFu
c29uDQo=
