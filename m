Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6300C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 22:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EBA2077B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 22:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="j4ICwYIH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="fyUSvwlX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgAIWqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 17:46:13 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:59142 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725807AbgAIWqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 17:46:13 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 586EDC00CA;
        Thu,  9 Jan 2020 22:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1578609972; bh=g1jFenhPGD/4ktFw2GNxkxeRPkh+RNtM4PX6cTw7uJE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=j4ICwYIHTitEdxe4r/FbJI06I0/nBS00GLTdMX5K9G4d3iKwKXJfBg3t4AVkabw+2
         rNSK7Lybjjp9Bp1QkY3LaNeiDOsuWtHgdJ6IJHgUPj0LF84JzEm2DJVXXFIlWB9d5a
         dEYBIt6kXuqhZiTZAuEN/8/HB847ppbc/LqVdS7G71yLrhXmPrG9r0BIwk/NjPX5zr
         eLW0c7mne/tXtuIIyDEmt8reAW4z3CNrRFZJV06XpddG82ugBD60mPx00y4hB73JuK
         Cy3IpTDLq22K50Ry+gEeb1X2OnYXsg7fU+ih4ewnvRazleKkD36LHLJ0EsmJoOKFXU
         dV5WV9S+lNFqg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A8FAEA007F;
        Thu,  9 Jan 2020 22:46:11 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 9 Jan 2020 14:46:11 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 9 Jan 2020 14:46:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbXEygndnUW+SN77FFvyOBQqndJi0+YwXyaQBXS+pb1QIV38jUarzpSIBZhh63Y4GZkKv4gY2wtWMvh2ylg5AFgg+SfFkh1OjpMa1VbrlCKaC3kCZjLKuaLWiQFtJjSj117+yhZY7mGeZRvkAWX3gTWDDirgL7YhnX3w0lhdUM40piJlVxCBRa1CXMhJB1yNyCedBDUnEXqbz9BG4P5i5cCEpztnJ0SLroCmfrBZGq/whD7ThtiBux+20fF1zCSqegDKFZWsqFEnZocaL0bxm/kdFjL8n6Jjb/5mhAF8InJFz7V/zw5HEntfpKpZ1+2rgwULBsAX775voBa5dXGilw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1jFenhPGD/4ktFw2GNxkxeRPkh+RNtM4PX6cTw7uJE=;
 b=g9G18cUS5blEkTykKM27fuCvzWj/3XMAHPqjv7b+Q9WX7UP7cF8yOiIRTWoEh3kMqOZeyvZD/5d5qtE7ZSTLmc4kefTPMPwy+mscbB38wvBqdJzClx4BDseopAqvn+x38cj787m+2Dul7t9iV2bn1Apl616TJTfZLItfYu6/JUhh2hllbkv/88XCc+pvW53JXp4TTRuLwJQiJcDAMjBw6iZN29a9rV+R7GVoyICbdpDrjhWKtXF+2nrMZMP6EN8luh2Gj5XGU+9JvptSGCrMOwxpvqrP23Rtdb+ZqHGUsifGVsBSVM/eKQOp0V/zW5H5lhEbqpFRo2sol97whfZYYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1jFenhPGD/4ktFw2GNxkxeRPkh+RNtM4PX6cTw7uJE=;
 b=fyUSvwlXFdmcthzJsIYUGZnG7ejv8p3HbY6mMAwYKMiyLYLOIcX86dWgUQHnLIOQLJ8/QKvfRzaFKJpjDLQ1YXIAWTU6dH3SLwRAw3/flWIQGXmgj+FQ/OG/GZUXzrWlFxHRDiZp0Ts0MnzfuvpQgf0HeTN52rJ2n3Vaxb+CFiQ=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (20.178.54.89) by
 BYAPR12MB2871.namprd12.prod.outlook.com (20.179.94.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 9 Jan 2020 22:46:10 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333%6]) with mapi id 15.20.2623.008; Thu, 9 Jan 2020
 22:46:09 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
CC:     lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH 4/5] ARC: add support for DSP-enabled userspace
 applications
Thread-Topic: [PATCH 4/5] ARC: add support for DSP-enabled userspace
 applications
Thread-Index: AQHVvOAMSI6VRGHN00GBtEUk/fXvJafflg0AgAMurQCAAD6yAA==
Date:   Thu, 9 Jan 2020 22:46:09 +0000
Message-ID: <2bc415e2-b6fe-f00b-9715-10a58f8b7a00@synopsys.com>
References: <20191227180347.3579-1-Eugeniy.Paltsev@synopsys.com>
 <20191227180347.3579-5-Eugeniy.Paltsev@synopsys.com>
 <a3890ccb-e948-6ad6-c2ea-5b77b9d3a289@synopsys.com>
 <BY5PR12MB403419E2722BE80E329D3409DE390@BY5PR12MB4034.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB403419E2722BE80E329D3409DE390@BY5PR12MB4034.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-originating-ip: [24.7.46.224]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97acbae2-2c60-4f7a-c332-08d79555b897
x-ms-traffictypediagnostic: BYAPR12MB2871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2871C0A2E0FF21526176D50FB6390@BYAPR12MB2871.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(346002)(39860400002)(376002)(189003)(199004)(66476007)(66446008)(478600001)(64756008)(76116006)(66556008)(2906002)(316002)(107886003)(36756003)(53546011)(81156014)(4326008)(6512007)(6486002)(6636002)(8676002)(6862004)(81166006)(66946007)(6506007)(37006003)(8936002)(31686004)(54906003)(186003)(71200400001)(2616005)(86362001)(31696002)(5660300002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR12MB2871;H:BYAPR12MB3592.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zWtY+fhcbVPZhCdNaNd347zgpLC6Md6V+OE0LWf5s6Ge2UxTeUjH416d9VjaWyATVdZpz8qWiT353MC3d3+K+XgbaoC3+tXp2YMFH96WTrzU85p9+Buiolf6e/Dw4C84JTYsp5swyCLv1vJj+qD/TQeT3udKZPHgBnm5osRmR4C9VbOQRh9UCn0fPsAzzAQiAXUYPWnTNs1YF7yOE4i8PtYOUoN5aPmUqD/klnK8yrHSnXh+oFiBkMse4xCVAd+jTOSeXB9vjca0E2xQXQJCw1Drz+smKIFlEh7US3M3cKoq/gcWZsf/4iTwJfKvMm3arn7ew/fFzdN5m65FDezgM/tsJfie7WX32q83I+3Fv67RvO0q6UnleirooR8Zde+Vz5ujZ/iRTqZc5IhbUCaPVAd8aXxnaNHz7WaxoZtQywmbh0Rzrw9fwFk86TLjhGt8
Content-Type: text/plain; charset="utf-8"
Content-ID: <A45F658D956F754396938B16032F9B9B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 97acbae2-2c60-4f7a-c332-08d79555b897
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 22:46:09.4069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BOotnvfcUfbSNZviCJzGr+o8hwvMDplTuzzLsRoSAQfiBk4LYy/w5WBd4OxUdsclYuY+KdU3TIxHjg5s1HosXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2871
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS85LzIwIDExOjAxIEFNLCBFdWdlbml5IFBhbHRzZXYgd3JvdGU6DQo+IEhpIFZpbmVldCwN
Cj4NCj4+IEZyb206IFZpbmVldCBHdXB0YSA8dmd1cHRhQHN5bm9wc3lzLmNvbT4NCj4+IE9uIDEy
LzI3LzE5IDEwOjAzIEFNLCBFdWdlbml5IFBhbHRzZXYgd3JvdGU6DQo+Pj4gVG8gYmUgYWJsZSB0
byBydW4gRFNQLWVuYWJsZWQgdXNlcnNwYWNlIGFwcGxpY2F0aW9ucyB3ZSBuZWVkIHRvDQo+Pj4g
c2F2ZSBhbmQgcmVzdG9yZSBmb2xsb3dpbmcgRFNQLXJlbGF0ZWQgcmVnaXN0ZXJzOg0KPj4+IEF0
IElSUS9leGNlcHRpb24gZW50cnkvZXhpdDoNCj4+PiAgKiBBQ0MwX0dMTywgQUNDMF9HSEksIERT
UF9DVFJMDQo+Pj4gICogQUNDMF9MTywgQUNDMF9ISSAod2UgYWxyZWFkeSBzYXZlIHRoZW0gYXMg
cjU4LCByNTkgcGFpcikNCj4+PiBBdCBjb250ZXh0IHN3aXRjaDoNCj4+PiAgKiBEU1BfQkZMWTAs
IERTUF9GRlRfQ1RSTA0KPiBbc25pcF0NCj4+PiArDQo+Pj4gKyNpZm5kZWYgX19BU1NFTUJMWV9f
DQo+Pj4gKw0KPj4+ICsvKiBzb21lIGRlZmluZXMgdG8gc2ltcGxpZnkgY29uZmlnIHNhbml0aXpl
IGluIGtlcm5lbC9zZXR1cC5jICovDQo+Pj4gKyNpZiBkZWZpbmVkKENPTkZJR19BUkNfRFNQX0tF
Uk5FTCkgICAgfHwgXA0KPj4+ICsgICAgZGVmaW5lZChDT05GSUdfQVJDX0RTUF9VU0VSU1BBQ0Up
DQo+Pj4gKyNkZWZpbmUgQVJDX0RTUF9IQU5ETEVEICAgICAgICAgICAgICAgICAgICAgIDENCj4+
PiArI2Vsc2UNCj4+PiArI2RlZmluZSBBUkNfRFNQX0hBTkRMRUQgICAgICAgICAgICAgICAgICAg
ICAgMA0KPj4+ICsjZW5kaWYNCj4+IFRoaXMgaXMgYSByZWFsbHkgYmFkIGlkZWEgLSB1IHIgaW50
cm9kdWNpbmcgZXhwbGljaXQgaW5jbHVkZSBkZXBlbmRlbmNpZXMgd2hpY2gNCj4+IGNhbiBjaGFu
Z2UgZXZlbiBvdXRzaWRlIG9mIGFyY2ggY2hhbmdlcyAhDQo+PiBXZSd2ZSBkZWFsdCB3aXRoIGVu
b3VnaCBvZiB0aGVzZSBwcm9ibGVtcyB3aXRoIGN1cnJlbnQuaCwgc28gYmVzdCB0byBhdm9pZCwg
ZXZlbg0KPj4gaWYgdGhlcmUgaXMgc29tZSBjb2RlIGNsdXR0ZXIuDQo+IEhtbSwgd291bGQgaXQg
YmUgT0sgaWYgSSBhZGQgdGhpcyBvcHRpb24gYXMgYSBwcml2YXRlIGtjb25maWcgb3B0aW9uPw0K
PiBJLkUgKGZvciBBUkNfRFNQX0hBTkRMRUQpOg0KDQpZZXMgdGhhdCB3b3VsZCBiZSBnb29kLg0K
DQotVmluZWV0DQoNCg==
