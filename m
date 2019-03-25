Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86034C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534122070D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="IpoWKAXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbfCYV3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:29:18 -0400
Received: from mail-eopbgr150073.outbound.protection.outlook.com ([40.107.15.73]:62318
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730006AbfCYV3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wT/K9NTngom9AJAXZp2v+9UJUav0rMnxhQ8iF0FtSCc=;
 b=IpoWKAXr0Tr77icLb+PVG43jHUue/bgqbkVkpiiLZiliafsHNp7Obf0dQP0gvfnkaFW5Nqv6q38EcEmGphVrYSNbGEfpvR0IKKn+t1y4d7Z5GkvUvfjWZ5Md9vCMDCFNZvHfmm2FsSCd8xI5DDfQvbrWTpryF656tWZ1WuWu7mI=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2558.eurprd05.prod.outlook.com (10.168.136.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Mon, 25 Mar 2019 21:29:13 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59%6]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 21:29:13 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Kirti Wankhede <kwankhede@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Subject: RE: [PATCH 5/8] vfio/mdev: Avoid masking error code to EBUSY
Thread-Topic: [PATCH 5/8] vfio/mdev: Avoid masking error code to EBUSY
Thread-Index: AQHU4QX6UPY3XMRjH0GxvL6hB0Kl8qYcvPiAgAAkNNA=
Date:   Mon, 25 Mar 2019 21:29:13 +0000
Message-ID: <VI1PR0501MB22716A8F5EC6DA2A62D4B2A2D15E0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
 <1553296835-37522-6-git-send-email-parav@mellanox.com>
 <6f990e18-296c-cd33-df2b-c5c4bad7a740@nvidia.com>
In-Reply-To: <6f990e18-296c-cd33-df2b-c5c4bad7a740@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a11e7a06-4052-4286-5bd4-08d6b168ed77
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2558;
x-ms-traffictypediagnostic: VI1PR0501MB2558:
x-microsoft-antispam-prvs: <VI1PR0501MB2558242B7BEE3F10B7E28DABD15E0@VI1PR0501MB2558.eurprd05.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(376002)(136003)(39860400002)(13464003)(189003)(199004)(486006)(2201001)(476003)(110136005)(478600001)(14454004)(86362001)(5660300002)(102836004)(2906002)(186003)(76176011)(7696005)(8936002)(2501003)(53546011)(26005)(6506007)(97736004)(25786009)(33656002)(14444005)(99286004)(106356001)(105586002)(256004)(7736002)(3846002)(68736007)(316002)(6116002)(52536014)(66066001)(6246003)(305945005)(229853002)(81156014)(8676002)(74316002)(11346002)(6436002)(71190400001)(53936002)(71200400001)(446003)(81166006)(55016002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2558;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /yxm3p31O/KvHB1jIHlZaql5TCheGHrCrLMYpzMC8rcO9o8ZIInN7azQFEyyQGl6RJdkVnNdY3U/uf9NTeHu1q7TR/+jm4wONQmnVXypmJFdARlMzHBjdnPCjj+XB0dzX2lKVPuRoCF6g9BUVqEU935qsypF/e8ZgIja9d2wH3gD7mmuTxaEOQ3Zxr0PUSneAk5WRhjV9IGh5FZ65EkYy2hzwY0T3AwkmD1e4SLCEySYRuHdU+IyTURATMtiSu7qtwpvsPNZ9DukRsQFUS4Rw7O3lcV20EhVEz8VLSgoXjkOWZHELGWBHYqiBUAVmvNixSHYCWEeJM9Y2N/jj607zQ2GmfEXe+qPq329agJJu6IbcTyo7yjRMS1xyHnXzVyJKqoXlZc8aEGyeQt3CbprOC8FjBT/ZJuC8Z8NEGIEpME=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a11e7a06-4052-4286-5bd4-08d6b168ed77
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 21:29:13.7020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2558
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2lydGkgV2Fua2hlZGUg
PGt3YW5raGVkZUBudmlkaWEuY29tPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDI1LCAyMDE5IDI6
MTggUE0NCj4gVG86IFBhcmF2IFBhbmRpdCA8cGFyYXZAbWVsbGFub3guY29tPjsga3ZtQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGFsZXgud2lsbGlh
bXNvbkByZWRoYXQuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNS84XSB2ZmlvL21kZXY6IEF2
b2lkIG1hc2tpbmcgZXJyb3IgY29kZSB0byBFQlVTWQ0KPiANCj4gDQo+IA0KPiBPbiAzLzIzLzIw
MTkgNDo1MCBBTSwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPiA+IEluc3RlYWQgb2YgbWFza2luZyBy
ZXR1cm4gZXJyb3IgdG8gLUVCVVNZLCByZXR1cm4gYWN0dWFsIGVycm9yDQo+ID4gcmV0dXJuZWQg
YnkgdGhlIGRyaXZlci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBhcmF2IFBhbmRpdCA8cGFy
YXZAbWVsbGFub3guY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3ZmaW8vbWRldi9tZGV2X2Nv
cmUuYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZmlvL21kZXYvbWRldl9jb3Jl
LmMNCj4gPiBiL2RyaXZlcnMvdmZpby9tZGV2L21kZXZfY29yZS5jIGluZGV4IDNkOTFmNjIuLmFi
MDU0NjQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy92ZmlvL21kZXYvbWRldl9jb3JlLmMNCj4g
PiArKysgYi9kcml2ZXJzL3ZmaW8vbWRldi9tZGV2X2NvcmUuYw0KPiA+IEBAIC0xNDIsNyArMTQy
LDcgQEAgc3RhdGljIGludCBtZGV2X2RldmljZV9yZW1vdmVfb3BzKHN0cnVjdA0KPiBtZGV2X2Rl
dmljZSAqbWRldiwgYm9vbCBmb3JjZV9yZW1vdmUpDQo+ID4gIAkgKi8NCj4gPiAgCXJldCA9IHBh
cmVudC0+b3BzLT5yZW1vdmUobWRldik7DQo+ID4gIAlpZiAocmV0ICYmICFmb3JjZV9yZW1vdmUp
DQo+ID4gLQkJcmV0dXJuIC1FQlVTWTsNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+DQo+ID4gIAlz
eXNmc19yZW1vdmVfZ3JvdXBzKCZtZGV2LT5kZXYua29iaiwgcGFyZW50LT5vcHMtDQo+ID5tZGV2
X2F0dHJfZ3JvdXBzKTsNCj4gPiAgCXJldHVybiAwOw0KPiA+DQo+IA0KPiBJbnRlbnRpb25hbGx5
IHJldHVybmVkIC1FQlVTWSBoZXJlLiBJZiBWTU0gb3IgdXNlcnNwYWNlIGFwcGxpY2F0aW9uIGlz
IHVzaW5nDQo+IHRoaXMgbWRldiBkZXZpY2UsIHZlbmRvciBkcml2ZXIgY2FuIHJldHVybiBlcnJv
ci4NCklmIHZlbmRvciBkcml2ZXIgZGV0ZWN0cyB0aGF0IGl0cyBidXN5LCBpdCBtdXN0IHJldHVy
biBFQlVTWSwgbm90IGFueSBvdGhlciBzdGF0dXMuDQptZGV2IGNvcmUgaXMgbm90IHN1cHBvc2Vk
IHRvIG1hc2sgc29tZSBvdGhlciBlcnJvciB0byBFQlVTWS4NCkhlbmNlIHRoZSBmaXguDQoNCiBJ
biB0aGF0IGNhc2Ugc3lzZnMgaW50ZXJmYWNlDQo+IHNob3VsZCBzZWUgLUVCVVNZIGVycm9yIGlu
ZGljYXRpbmcgZGV2aWNlIGlzIHN0aWxsIGFjdGl2ZS4NCj4gDQo+IFRoYW5rcywNCj4gS2lydGkN
Cg==
