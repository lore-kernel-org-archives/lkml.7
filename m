Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2447FC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C8922D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GBHIjHSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbfHURgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 13:36:48 -0400
Received: from mail-eopbgr780099.outbound.protection.outlook.com ([40.107.78.99]:27568
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728535AbfHURgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:36:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQBGDaGKxLfJZqeATgrgkSvdbdi+wWSbz+OYIN5GN4I0jp0otoWvrvMrrCVt7Qm8ZGtt33TxiZYDBs+MChOL20K3SF7uLj3EZHwRYv2caK/iGb+uZ+c+ruYc12siEQRFis9IW3ZzxYjBsqLO/NqJpPi4ErK53jrVBGoQn2ejUOoxQgJYu8N+yugNzccwm6JkayWCe9f9Aoo9MyTwuSSuhfvMKo6dUeVDI8CNl6Ht5UQesPWpwMiXPWO0P8ilAJ3pod30PrQlg7sIpKM20Lu5c28vYbaRUti8pbd5J+271gTtgd/MZhfXZLPZk7ZtuZYZ6322LMps5h/tBJ3clVXrZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyHF+YuyJQKQvfycVCgI08ZW71S32xgDYTmIN7PIkxM=;
 b=czmlcILYLePFqHjk7AwuXXQu6ZTx3QhRSsXV/ifx7UMjBirXfsLjC9/KLDuhLcWO8AARMtLPEaApEqnoJwZhaExfiC5nCUerlV9moTMJhR9Ne8hgwbLIwIjofU45xcqvaGCw6jFCZbcac/8cU6GY3io+mkYrgJL+r9euql8fWreURa1kCe92mrRtm137PrqUM6iGcLKJhEkVJgxgmFU/4C+UfQqW+aTCegnxpRZHDp2ZTt+5XwE/WIldzjVCuGHoAM3sMgZWGUvTFayAugFlxnl1FgrpCDHYt2GzjL+adO4BxRf4TwK4DRfl5a+iFJ8pWs6U7+2qVSlPtcXsIxQWAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyHF+YuyJQKQvfycVCgI08ZW71S32xgDYTmIN7PIkxM=;
 b=GBHIjHSBnMqD/GOXf1r5pkJor3fBG+fZyZX9uTgV1tslU45Nvg3YzFdz4TNvPBYiN5kKUaaKGa+D/E+xjIDgqqDSXJ/tXs+gUEFl++/keQMPnFEqkLA/VgyVs4XfKJ/H1m2tlia/wwxjJWCP3ND2B0dXEN5r30t/4qVmh7Sd9WY=
Received: from CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) by
 CY4PR21MB0693.namprd21.prod.outlook.com (10.175.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.4; Wed, 21 Aug 2019 17:36:37 +0000
Received: from CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::2c62:5380:9ed8:496d]) by CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::2c62:5380:9ed8:496d%11]) with mapi id 15.20.2220.000; Wed, 21 Aug
 2019 17:36:37 +0000
From:   Long Li <longli@microsoft.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] nvme: complete request in work queue on CPU with
 flooded interrupts
Thread-Topic: [PATCH 3/3] nvme: complete request in work queue on CPU with
 flooded interrupts
Thread-Index: AQHVVx6V8EslWtuw80WR9kecrOlyh6cETI8AgAD8sjCAAJQMgA==
Date:   Wed, 21 Aug 2019 17:36:37 +0000
Message-ID: <CY4PR21MB074141B895C9FE0D390F590ACEAA0@CY4PR21MB0741.namprd21.prod.outlook.com>
References: <1566281669-48212-1-git-send-email-longli@linuxonhyperv.com>
 <1566281669-48212-4-git-send-email-longli@linuxonhyperv.com>
 <2a30a07f-982c-c291-e263-0cf72ec61235@grimberg.me>
 <CY4PR21MB0741E77B05835E1192415943CEAA0@CY4PR21MB0741.namprd21.prod.outlook.com>
In-Reply-To: <CY4PR21MB0741E77B05835E1192415943CEAA0@CY4PR21MB0741.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:7:ede6:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a45ffb50-4e3e-4123-b387-08d7265e1ea5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600158)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0693;
x-ms-traffictypediagnostic: CY4PR21MB0693:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <CY4PR21MB06933CC827B2B676A55C008BCEAA0@CY4PR21MB0693.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(51914003)(189003)(199004)(11346002)(446003)(2501003)(14444005)(46003)(8676002)(33656002)(102836004)(8936002)(71200400001)(71190400001)(81166006)(6506007)(81156014)(478600001)(6116002)(10090500001)(186003)(486006)(305945005)(8990500004)(7736002)(74316002)(2940100002)(476003)(66446008)(25786009)(66946007)(64756008)(76116006)(66556008)(10290500003)(14454004)(5660300002)(99286004)(256004)(2201001)(7696005)(66476007)(76176011)(2906002)(53936002)(6436002)(22452003)(110136005)(229853002)(6306002)(55016002)(52536014)(86362001)(316002)(6246003)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0693;H:CY4PR21MB0741.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Qf7FpjKEyffOHNujO8GcKxNIvz32d4WEXRP0vtw4KGr/Ra+W3I+jv7NiJD9+o3X10JLkmmDW28ABP1wm5yiViWTD/MBQqrFdIqt3KezKoPbClJKE6sjccvCp90wechwEUK1/xIqMcmHFpS2kBBmUt+OvFrWPi4rmc41aa5cSOcCRnlcYMEF36uwTVM8WP7hO+wVWySZtoDS5MO6FenkzBw2daUkXyozfPtgHuURosBIOyuR96XdVfOd2HDKUhXMH7YQUzKal5aP1SYQPH2GJj0DfEp8Mj+BTmgbW+Hs6jx8Ivb6b3pmkdwWpdddEaGkxw3aUpSaqalavYAritsF807AK0GA8EjD1oztRGQ2xjHZa9A4VvPg4knDou2Y3fxnLPuf1rh1H2Dq+UBXdiW4YgXYQZXtr1LYo7m5iWwvf3mQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a45ffb50-4e3e-4123-b387-08d7265e1ea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 17:36:37.7962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Dh6dDnRySEJvazZzj0ZpMXD0fv8jGEUYx1aIWew+52CYF1C+pQryuuTSmKmEHMPuv6OmMHNB/VE1CnaMMokxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0693
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4+U3ViamVjdDogUkU6IFtQQVRDSCAzLzNdIG52bWU6IGNvbXBsZXRlIHJlcXVlc3QgaW4gd29y
ayBxdWV1ZSBvbiBDUFUNCj4+PndpdGggZmxvb2RlZCBpbnRlcnJ1cHRzDQo+Pj4NCj4+Pj4+PlN1
YmplY3Q6IFJlOiBbUEFUQ0ggMy8zXSBudm1lOiBjb21wbGV0ZSByZXF1ZXN0IGluIHdvcmsgcXVl
dWUgb24NCj4+PkNQVQ0KPj4+Pj4+d2l0aCBmbG9vZGVkIGludGVycnVwdHMNCj4+Pj4+Pg0KPj4+
Pj4+DQo+Pj4+Pj4+IEZyb206IExvbmcgTGkgPGxvbmdsaUBtaWNyb3NvZnQuY29tPg0KPj4+Pj4+
Pg0KPj4+Pj4+PiBXaGVuIGEgTlZNZSBoYXJkd2FyZSBxdWV1ZSBpcyBtYXBwZWQgdG8gc2V2ZXJh
bCBDUFUgcXVldWVzLCBpdCBpcw0KPj4+Pj4+PiBwb3NzaWJsZSB0aGF0IHRoZSBDUFUgdGhpcyBo
YXJkd2FyZSBxdWV1ZSBpcyBib3VuZCB0byBpcyBmbG9vZGVkIGJ5DQo+Pj4+Pj4+IHJldHVybmlu
ZyBJL08gZm9yIG90aGVyIENQVXMuDQo+Pj4+Pj4+DQo+Pj4+Pj4+IEZvciBleGFtcGxlLCBjb25z
aWRlciB0aGUgZm9sbG93aW5nIHNjZW5hcmlvOg0KPj4+Pj4+PiAxLiBDUFUgMCwgMSwgMiBhbmQg
MyBzaGFyZSB0aGUgc2FtZSBoYXJkd2FyZSBxdWV1ZSAyLiB0aGUgaGFyZHdhcmUNCj4+Pj4+Pj4g
cXVldWUgaW50ZXJydXB0cyBDUFUgMCBmb3IgSS9PIHJlc3BvbnNlIDMuIHByb2Nlc3NlcyBmcm9t
IENQVSAxLCAyDQo+Pj4+Pj4+IGFuZA0KPj4+Pj4+PiAzIGtlZXAgc2VuZGluZyBJL09zDQo+Pj4+
Pj4+DQo+Pj4+Pj4+IENQVSAwIG1heSBiZSBmbG9vZGVkIHdpdGggaW50ZXJydXB0cyBmcm9tIE5W
TWUgZGV2aWNlIHRoYXQgYXJlIEkvTw0KPj4+Pj4+PiByZXNwb25zZXMgZm9yIENQVSAxLCAyIGFu
ZCAzLiBVbmRlciBoZWF2eSBJL08gbG9hZCwgaXQgaXMgcG9zc2libGUNCj4+Pj4+Pj4gdGhhdCBD
UFUgMCBzcGVuZHMgYWxsIHRoZSB0aW1lIHNlcnZpbmcgTlZNZSBhbmQgb3RoZXIgc3lzdGVtDQo+
Pj4+Pj4+IGludGVycnVwdHMsIGJ1dCBkb2Vzbid0IGhhdmUgYSBjaGFuY2UgdG8gcnVuIGluIHBy
b2Nlc3MgY29udGV4dC4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gVG8gZml4IHRoaXMsIENQVSAwIGNhbiBz
Y2hlZHVsZSBhIHdvcmsgdG8gY29tcGxldGUgdGhlIEkvTyByZXF1ZXN0DQo+Pj4+Pj4+IHdoZW4g
aXQgZGV0ZWN0cyB0aGUgc2NoZWR1bGVyIGlzIG5vdCBtYWtpbmcgcHJvZ3Jlc3MuIFRoaXMgc2Vy
dmVzDQo+Pj4+Pj4+IG11bHRpcGxlDQo+Pj4+Pj5wdXJwb3NlczoNCj4+Pj4+Pj4NCj4+Pj4+Pj4g
MS4gVGhpcyBDUFUgaGFzIHRvIGJlIHNjaGVkdWxlZCB0byBjb21wbGV0ZSB0aGUgcmVxdWVzdC4g
VGhlIG90aGVyDQo+Pj4+Pj4+IENQVXMgY2FuJ3QgaXNzdWUgbW9yZSBJL09zIHVudGlsIHNvbWUg
cHJldmlvdXMgSS9PcyBhcmUgY29tcGxldGVkLg0KPj4+Pj4+PiBUaGlzIGhlbHBzIHRoaXMgQ1BV
IGdldCBvdXQgb2YgTlZNZSBpbnRlcnJ1cHRzLg0KPj4+Pj4+Pg0KPj4+Pj4+PiAyLiBUaGlzIGFj
dHMgYSB0aHJvdHRsaW5nIG1lY2hhbmlzdW0gZm9yIE5WTWUgZGV2aWNlcywgaW4gdGhhdCBpdA0K
Pj4+Pj4+PiBjYW4gbm90IHN0YXJ2ZSBhIENQVSB3aGlsZSBzZXJ2aWNpbmcgSS9PcyBmcm9tIG90
aGVyIENQVXMuDQo+Pj4+Pj4+DQo+Pj4+Pj4+IDMuIFRoaXMgQ1BVIGNhbiBtYWtlIHByb2dyZXNz
IG9uIFJDVSBhbmQgb3RoZXIgd29yayBpdGVtcyBvbiBpdHMNCj4+PnF1ZXVlLg0KPj4+Pj4+DQo+
Pj4+Pj5UaGUgcHJvYmxlbSBpcyBpbmRlZWQgcmVhbCwgYnV0IHRoaXMgaXMgdGhlIHdyb25nIGFw
cHJvYWNoIGluIG15IG1pbmQuDQo+Pj4+Pj4NCj4+Pj4+PldlIGFscmVhZHkgaGF2ZSBpcnFwb2xs
IHdoaWNoIHRha2VzIGNhcmUgcHJvcGVyIGJ1ZGdldGluZyBwb2xsaW5nDQo+Pj4+Pj5jeWNsZXMg
YW5kIG5vdCBob2dnaW5nIHRoZSBjcHUuDQo+Pj4+Pj4NCj4+Pj4+PkkndmUgc2VudCByZmMgZm9y
IHRoaXMgcGFydGljdWxhciBwcm9ibGVtIGJlZm9yZSBbMV0uIEF0IHRoZSB0aW1lDQo+Pj4+Pj5J
SVJDLCBDaHJpc3RvcGggc3VnZ2VzdGVkIHRoYXQgd2Ugd2lsbCBwb2xsIHRoZSBmaXJzdCBiYXRj
aCBkaXJlY3RseQ0KPj4+Pj4+ZnJvbSB0aGUgaXJxIGNvbnRleHQgYW5kIHJlYXAgdGhlIHJlc3Qg
aW4gaXJxcG9sbCBoYW5kbGVyLg0KPj4+DQo+Pj5UaGFua3MgZm9yIHRoZSBwb2ludGVyLiBJIHdp
bGwgdGVzdCBhbmQgcmVwb3J0IGJhY2suDQoNClNhZ2ksDQoNCkhlcmUgYXJlIHRoZSB0ZXN0IHJl
c3VsdHMuDQoNCkJlbmNobWFyayBjb21tYW5kOg0KZmlvIC0tYnM9NGsgLS1pb2VuZ2luZT1saWJh
aW8gLS1pb2RlcHRoPTY0IC0tZmlsZW5hbWU9L2Rldi9udm1lMG4xOi9kZXYvbnZtZTFuMTovZGV2
L252bWUybjE6L2Rldi9udm1lM24xOi9kZXYvbnZtZTRuMTovZGV2L252bWU1bjE6L2Rldi9udm1l
Nm4xOi9kZXYvbnZtZTduMTovZGV2L252bWU4bjE6L2Rldi9udm1lOW4xIC0tZGlyZWN0PTEgLS1y
dW50aW1lPTkwIC0tbnVtam9icz04MCAtLXJ3PXJhbmRyZWFkIC0tbmFtZT10ZXN0IC0tZ3JvdXBf
cmVwb3J0aW5nIC0tZ3RvZF9yZWR1Y2U9MQ0KDQpXaXRoIHlvdXIgcGF0Y2g6IDE3MjBrIElPUFMN
CldpdGggdGhyZWFkZWQgaW50ZXJydXB0czogMTMyMGsgSU9QUw0KV2l0aCBqdXN0IGludGVycnVw
dHM6IDM3MjBrIElPUFMNCg0KSW50ZXJydXB0cyBhcmUgdGhlIGZhc3Rlc3QgYnV0IHdlIG5lZWQg
dG8gZmluZCBhIHdheSB0byB0aHJvdHRsZSBpdC4NCg0KVGhhbmtzDQoNCkxvbmcNCg0KDQo+Pj4N
Cj4+Pj4+Pg0KPj4+Pj4+WzFdOg0KPj4+Pj4+aHR0cHM6Ly9uYW0wNi5zYWZlbGlua3MucHJvdGVj
dGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZsDQo+Pj5pc3RzLg0KPj4+Pj4+aW5m
cmFkZWFkLm9yZyUyRnBpcGVybWFpbCUyRmxpbnV4LW52bWUlMkYyMDE2LQ0KPj4+Pj4+T2N0b2Jl
ciUyRjAwNjQ5Ny5odG1sJmFtcDtkYXRhPTAyJTdDMDElN0Nsb25nbGklNDBtaWNyb3NvZnQuY28N
Cj4+Pm0lDQo+Pj4+Pj43QzBlYmYzNmVmZjE1YzQxODIxMTY2MDhkNzI1OTQ4YjkzJTdDNzJmOTg4
YmY4NmYxNDFhZjkxYWIyZDdjZDANCj4+PjExZA0KPj4+Pj4+YjQ3JTdDMSU3QzAlN0M2MzcwMTkx
OTIyNTQyNTAzNjEmYW1wO3NkYXRhPWZKJTJGa2M4SExTbWZ6YVkNCj4+PjNCWQ0KPj4+Pj4+RTY2
emxaS0Q2RmpjWGdNSlp6VkdDVnFJJTJGVSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPj4+Pj4+DQo+Pj4+
Pj5Ib3cgYWJvdXQgc29tZXRoaW5nIGxpa2UgdGhpcyBpbnN0ZWFkOg0KPj4+Pj4+LS0NCj4+Pj4+
PmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9wY2kuYyBiL2RyaXZlcnMvbnZtZS9ob3N0
L3BjaS5jIGluZGV4DQo+Pj4+Pj43MTEyN2EzNjZkM2MuLjg0YmYxNmQ3NTEwOSAxMDA2NDQNCj4+
Pj4+Pi0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jDQo+Pj4+Pj4rKysgYi9kcml2ZXJzL252
bWUvaG9zdC9wY2kuYw0KPj4+Pj4+QEAgLTI0LDYgKzI0LDcgQEANCj4+Pj4+PiAgI2luY2x1ZGUg
PGxpbnV4L2lvLTY0LW5vbmF0b21pYy1sby1oaS5oPg0KPj4+Pj4+ICAjaW5jbHVkZSA8bGludXgv
c2VkLW9wYWwuaD4NCj4+Pj4+PiAgI2luY2x1ZGUgPGxpbnV4L3BjaS1wMnBkbWEuaD4NCj4+Pj4+
PisjaW5jbHVkZSA8bGludXgvaXJxX3BvbGwuaD4NCj4+Pj4+Pg0KPj4+Pj4+ICAjaW5jbHVkZSAi
dHJhY2UuaCINCj4+Pj4+PiAgI2luY2x1ZGUgIm52bWUuaCINCj4+Pj4+PkBAIC0zMiw2ICszMyw3
IEBADQo+Pj4+Pj4gICNkZWZpbmUgQ1FfU0laRShxKSAgICAgKChxKS0+cV9kZXB0aCAqIHNpemVv
ZihzdHJ1Y3QgbnZtZV9jb21wbGV0aW9uKSkNCj4+Pj4+Pg0KPj4+Pj4+ICAjZGVmaW5lIFNHRVNf
UEVSX1BBR0UgIChQQUdFX1NJWkUgLyBzaXplb2Yoc3RydWN0IG52bWVfc2dsX2Rlc2MpKQ0KPj4+
Pj4+KyNkZWZpbmUgTlZNRV9QT0xMX0JVREdFVF9JUlEgICAyNTYNCj4+Pj4+Pg0KPj4+Pj4+ICAv
Kg0KPj4+Pj4+ICAgKiBUaGVzZSBjYW4gYmUgaGlnaGVyLCBidXQgd2UgbmVlZCB0byBlbnN1cmUg
dGhhdCBhbnkgY29tbWFuZA0KPj4+Pj4+ZG9lc24ndCBAQCAtMTg5LDYgKzE5MSw3IEBAIHN0cnVj
dCBudm1lX3F1ZXVlIHsNCj4+Pj4+PiAgICAgICAgIHUzMiAqZGJidWZfY3FfZGI7DQo+Pj4+Pj4g
ICAgICAgICB1MzIgKmRiYnVmX3NxX2VpOw0KPj4+Pj4+ICAgICAgICAgdTMyICpkYmJ1Zl9jcV9l
aTsNCj4+Pj4+PisgICAgICAgc3RydWN0IGlycV9wb2xsIGlvcDsNCj4+Pj4+PiAgICAgICAgIHN0
cnVjdCBjb21wbGV0aW9uIGRlbGV0ZV9kb25lOyAgfTsNCj4+Pj4+Pg0KPj4+Pj4+QEAgLTEwMTUs
NiArMTAxOCwyMyBAQCBzdGF0aWMgaW5saW5lIGludCBudm1lX3Byb2Nlc3NfY3Eoc3RydWN0DQo+
Pj4+Pj5udm1lX3F1ZXVlICpudm1lcSwgdTE2ICpzdGFydCwNCj4+Pj4+PiAgICAgICAgIHJldHVy
biBmb3VuZDsNCj4+Pj4+PiAgfQ0KPj4+Pj4+DQo+Pj4+Pj4rc3RhdGljIGludCBudm1lX2lycXBv
bGxfaGFuZGxlcihzdHJ1Y3QgaXJxX3BvbGwgKmlvcCwgaW50IGJ1ZGdldCkgew0KPj4+Pj4+KyAg
ICAgICBzdHJ1Y3QgbnZtZV9xdWV1ZSAqbnZtZXEgPSBjb250YWluZXJfb2YoaW9wLCBzdHJ1Y3QN
Cj4+Pj4+Pitudm1lX3F1ZXVlLA0KPj4+Pj4+aW9wKTsNCj4+Pj4+PisgICAgICAgc3RydWN0IHBj
aV9kZXYgKnBkZXYgPSB0b19wY2lfZGV2KG52bWVxLT5kZXYtPmRldik7DQo+Pj4+Pj4rICAgICAg
IHUxNiBzdGFydCwgZW5kOw0KPj4+Pj4+KyAgICAgICBpbnQgY29tcGxldGVkOw0KPj4+Pj4+Kw0K
Pj4+Pj4+KyAgICAgICBjb21wbGV0ZWQgPSBudm1lX3Byb2Nlc3NfY3EobnZtZXEsICZzdGFydCwg
JmVuZCwgYnVkZ2V0KTsNCj4+Pj4+PisgICAgICAgbnZtZV9jb21wbGV0ZV9jcWVzKG52bWVxLCBz
dGFydCwgZW5kKTsNCj4+Pj4+PisgICAgICAgaWYgKGNvbXBsZXRlZCA8IGJ1ZGdldCkgew0KPj4+
Pj4+KyAgICAgICAgICAgICAgIGlycV9wb2xsX2NvbXBsZXRlKCZudm1lcS0+aW9wKTsNCj4+Pj4+
PisgICAgICAgICAgICAgICBlbmFibGVfaXJxKHBjaV9pcnFfdmVjdG9yKHBkZXYsIG52bWVxLT5j
cV92ZWN0b3IpKTsNCj4+Pj4+PisgICAgICAgfQ0KPj4+Pj4+Kw0KPj4+Pj4+KyAgICAgICByZXR1
cm4gY29tcGxldGVkOw0KPj4+Pj4+K30NCj4+Pj4+PisNCj4+Pj4+PiAgc3RhdGljIGlycXJldHVy
bl90IG52bWVfaXJxKGludCBpcnEsIHZvaWQgKmRhdGEpDQo+Pj4+Pj4gIHsNCj4+Pj4+PiAgICAg
ICAgIHN0cnVjdCBudm1lX3F1ZXVlICpudm1lcSA9IGRhdGE7IEBAIC0xMDI4LDEyICsxMDQ4LDE2
IEBADQo+Pj4+Pj5zdGF0aWMgaXJxcmV0dXJuX3QgbnZtZV9pcnEoaW50IGlycSwgdm9pZCAqZGF0
YSkNCj4+Pj4+PiAgICAgICAgIHJtYigpOw0KPj4+Pj4+ICAgICAgICAgaWYgKG52bWVxLT5jcV9o
ZWFkICE9IG52bWVxLT5sYXN0X2NxX2hlYWQpDQo+Pj4+Pj4gICAgICAgICAgICAgICAgIHJldCA9
IElSUV9IQU5ETEVEOw0KPj4+Pj4+LSAgICAgICBudm1lX3Byb2Nlc3NfY3EobnZtZXEsICZzdGFy
dCwgJmVuZCwgLTEpOw0KPj4+Pj4+KyAgICAgICBudm1lX3Byb2Nlc3NfY3EobnZtZXEsICZzdGFy
dCwgJmVuZCwNCj4+Pk5WTUVfUE9MTF9CVURHRVRfSVJRKTsNCj4+Pj4+PiAgICAgICAgIG52bWVx
LT5sYXN0X2NxX2hlYWQgPSBudm1lcS0+Y3FfaGVhZDsNCj4+Pj4+PiAgICAgICAgIHdtYigpOw0K
Pj4+Pj4+DQo+Pj4+Pj4gICAgICAgICBpZiAoc3RhcnQgIT0gZW5kKSB7DQo+Pj4+Pj4gICAgICAg
ICAgICAgICAgIG52bWVfY29tcGxldGVfY3Flcyhudm1lcSwgc3RhcnQsIGVuZCk7DQo+Pj4+Pj4r
ICAgICAgICAgICAgICAgaWYgKG52bWVfY3FlX3BlbmRpbmcobnZtZXEpKSB7DQo+Pj4+Pj4rICAg
ICAgICAgICAgICAgICAgICAgICBkaXNhYmxlX2lycV9ub3N5bmMoaXJxKTsNCj4+Pj4+PisgICAg
ICAgICAgICAgICAgICAgICAgIGlycV9wb2xsX3NjaGVkKCZudm1lcS0+aW9wKTsNCj4+Pj4+Pisg
ICAgICAgICAgICAgICB9DQo+Pj4+Pj4gICAgICAgICAgICAgICAgIHJldHVybiBJUlFfSEFORExF
RDsNCj4+Pj4+PiAgICAgICAgIH0NCj4+Pj4+Pg0KPj4+Pj4+QEAgLTEzNDcsNiArMTM3MSw3IEBA
IHN0YXRpYyBlbnVtIGJsa19laF90aW1lcl9yZXR1cm4NCj4+Pj4+Pm52bWVfdGltZW91dChzdHJ1
Y3QgcmVxdWVzdCAqcmVxLCBib29sIHJlc2VydmVkKQ0KPj4+Pj4+DQo+Pj4+Pj4gIHN0YXRpYyB2
b2lkIG52bWVfZnJlZV9xdWV1ZShzdHJ1Y3QgbnZtZV9xdWV1ZSAqbnZtZXEpICB7DQo+Pj4+Pj4r
ICAgICAgIGlycV9wb2xsX2Rpc2FibGUoJm52bWVxLT5pb3ApOw0KPj4+Pj4+ICAgICAgICAgZG1h
X2ZyZWVfY29oZXJlbnQobnZtZXEtPmRldi0+ZGV2LCBDUV9TSVpFKG52bWVxKSwNCj4+Pj4+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICh2b2lkICopbnZtZXEtPmNxZXMsIG52bWVx
LT5jcV9kbWFfYWRkcik7DQo+Pj4+Pj4gICAgICAgICBpZiAoIW52bWVxLT5zcV9jbWRzKQ0KPj4+
Pj4+QEAgLTE0ODEsNiArMTUwNiw3IEBAIHN0YXRpYyBpbnQgbnZtZV9hbGxvY19xdWV1ZShzdHJ1
Y3QgbnZtZV9kZXYNCj4+Pj4+PipkZXYsIGludCBxaWQsIGludCBkZXB0aCkNCj4+Pj4+PiAgICAg
ICAgIG52bWVxLT5kZXYgPSBkZXY7DQo+Pj4+Pj4gICAgICAgICBzcGluX2xvY2tfaW5pdCgmbnZt
ZXEtPnNxX2xvY2spOw0KPj4+Pj4+ICAgICAgICAgc3Bpbl9sb2NrX2luaXQoJm52bWVxLT5jcV9w
b2xsX2xvY2spOw0KPj4+Pj4+KyAgICAgICBpcnFfcG9sbF9pbml0KCZudm1lcS0+aW9wLCBOVk1F
X1BPTExfQlVER0VUX0lSUSwNCj4+Pj4+Pm52bWVfaXJxcG9sbF9oYW5kbGVyKTsNCj4+Pj4+PiAg
ICAgICAgIG52bWVxLT5jcV9oZWFkID0gMDsNCj4+Pj4+PiAgICAgICAgIG52bWVxLT5jcV9waGFz
ZSA9IDE7DQo+Pj4+Pj4gICAgICAgICBudm1lcS0+cV9kYiA9ICZkZXYtPmRic1txaWQgKiAyICog
ZGV2LT5kYl9zdHJpZGVdOw0KPj4+Pj4+LS0NCg==
