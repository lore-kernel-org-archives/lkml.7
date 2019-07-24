Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F64AC41514
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D430229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="W8Xl7ku6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfGXQmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:42:39 -0400
Received: from mail-eopbgr680086.outbound.protection.outlook.com ([40.107.68.86]:23525
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726316AbfGXQmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:42:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzVuK9KLGbmb5Nq+4rBZb6yvjH9ghN7CXGUzz6E8LK+48Rx9EGHPOds1Iv8rQDRcOueEBk4SoWEmuzlpZlj9bdcaEbc6RIZf5pT7IOqw4noO1Vh1OxExbV1cL/wGDpmvFQR+0aHAhn3wUEYBPs3ywBV3UTSe/ygLBNXZT+LY9ZM0SkQkk4HPLFHt7/3Ii8GGL8pwDUFA5hrHXlcqofW0yfmfewaifyuvwM56s5XFpRzfqCSdnzhI4sc7tBEy1zZlPY1SUGFgK47AaND/GmShLaYH6WMBosEbLIKcT/EllHDfg3teXfiLeqOdBsAFi7aqOTaLOG2IiSVRwwFGPBocWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95v9hTjNjX05jPmYXWrCEZIxgJzaaYNopRlP6dA/qes=;
 b=JXv15IGK98hLsoc36l2+G9hqHVzy7OI4oszaZUfTv16BJNFWiMkVEFGUGtObY/7kSOtqfyudxdNXWNQJjCz9GCCpqPYlhHLC/vgaieuBj/Cp9ybg5sGTU0VK42KQ2vG++mLVquu3LssAE4iAfEeIso2N3nowHSE5F/nciZ2Lebzc2+v6QMCtojokSXy+GxW0Thi9wF814R6obd3gmIEnLzGSN9MsgrOVM7fm4+c/wOaob/sUehS+Z6WcKsfnbvHH/rCRoQy+CC/ApCQV9bnL9d0esSdLBJjQ03Gr6qAQ1gVCRZHslvksIQaKHRVnlPJXBNGH3UAWMPw/vzX5GKeNVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95v9hTjNjX05jPmYXWrCEZIxgJzaaYNopRlP6dA/qes=;
 b=W8Xl7ku6sijOylU8auT/ekXEWG6niGXDND2oyzoozam6IrD24Mcev0CCiyM5TU1dAS0J0vB03EkHk+RzLSgWb7mxXIL9IgcxGs6alWQNTa3h9s0teEH2yZpfH1kjJiDo3t1H9LWFmvWaIrp2vgN0ic3EcUMXwhmJ6zw37TyPq1k=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB2763.namprd12.prod.outlook.com (20.176.118.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Wed, 24 Jul 2019 16:42:35 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2094.013; Wed, 24 Jul 2019
 16:42:35 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Lianbo Jiang <lijiang@redhat.com>
Subject: Re: [PATCH] dma-direct: Force unencrypted DMA under SME for certain
 DMA masks
Thread-Topic: [PATCH] dma-direct: Force unencrypted DMA under SME for certain
 DMA masks
Thread-Index: AQHVN1HbhkVejMp04kW0O/tJG/K57qbaAcwAgAANJYA=
Date:   Wed, 24 Jul 2019 16:42:35 +0000
Message-ID: <acee0a74-77fc-9c81-087b-ce55abf87bd4@amd.com>
References: <10b83d9ff31bca88e94da2ff34e30619eb396078.1562785123.git.thomas.lendacky@amd.com>
 <20190724155530.hlingpcirjcf2ljg@box>
In-Reply-To: <20190724155530.hlingpcirjcf2ljg@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR06CA0022.namprd06.prod.outlook.com
 (2603:10b6:805:8e::35) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c94b40c5-ca89-499c-79a2-08d71055ee70
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB2763;
x-ms-traffictypediagnostic: DM6PR12MB2763:
x-microsoft-antispam-prvs: <DM6PR12MB2763A765B507273CEA56144AECC60@DM6PR12MB2763.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0108A997B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(189003)(199004)(5660300002)(6486002)(66476007)(53546011)(229853002)(386003)(4326008)(66556008)(66946007)(6506007)(14454004)(6116002)(26005)(8936002)(3846002)(6512007)(71190400001)(71200400001)(102836004)(54906003)(6916009)(186003)(316002)(66446008)(81156014)(81166006)(64756008)(6246003)(256004)(52116002)(68736007)(31696002)(31686004)(25786009)(53936002)(8676002)(2906002)(7736002)(7416002)(305945005)(2616005)(476003)(36756003)(486006)(478600001)(6436002)(11346002)(66066001)(99286004)(86362001)(446003)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2763;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OE6o+gTZ3ZmQ+ZfSYJD7cCDH3ZAON0wW+wyat2P0i01aBOgD1Z98zyNguVWa6AbnIYMfyl9jiYPWnOg9yLRKxAPR+lYCjo0ekxEPxTQVVzSKEWvEAaX8QRfuX751MSR/rWDc7VsmIlPQQuoBZzQm6RuhvvQTjnrT1fVHJ6eYyHpapaxPIbW+E6hx6xSugdewvssJNRHTbPgriKuirKaG1n7169cAdZKTX3lS4/S1/O8fEANilSwS9qs3pZNkEa1gnmHK01ib/x2+mTzXE531u1HHRBuOU7e+VJtg2SnYAGcg4Re25BXsXwEiK5BlW4NeWCkIpk15SaYRdshegQlrb3EH3RJIvzrLtUTxqZLdBgjdGgfnQa30q7WN2Ck8jJ12k0vBkJQCd3AzA262HZuhb5EzwGkp2D46aZyeAtRFFq4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D055E53CB3BCD94DB631418512E4999B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94b40c5-ca89-499c-79a2-08d71055ee70
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2019 16:42:35.6746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2763
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8yNC8xOSAxMDo1NSBBTSwgS2lyaWxsIEEuIFNodXRlbW92IHdyb3RlOg0KPiBPbiBXZWQs
IEp1bCAxMCwgMjAxOSBhdCAwNzowMToxOVBNICswMDAwLCBMZW5kYWNreSwgVGhvbWFzIHdyb3Rl
Og0KPj4gQEAgLTM1MSw2ICszNTUsMzIgQEAgYm9vbCBzZXZfYWN0aXZlKHZvaWQpDQo+PiAgfQ0K
Pj4gIEVYUE9SVF9TWU1CT0woc2V2X2FjdGl2ZSk7DQo+PiAgDQo+PiArLyogT3ZlcnJpZGUgZm9y
IERNQSBkaXJlY3QgYWxsb2NhdGlvbiBjaGVjayAtIEFSQ0hfSEFTX0ZPUkNFX0RNQV9VTkVOQ1JZ
UFRFRCAqLw0KPj4gK2Jvb2wgZm9yY2VfZG1hX3VuZW5jcnlwdGVkKHN0cnVjdCBkZXZpY2UgKmRl
dikNCj4+ICt7DQo+PiArCS8qDQo+PiArCSAqIEZvciBTRVYsIGFsbCBETUEgbXVzdCBiZSB0byB1
bmVuY3J5cHRlZCBhZGRyZXNzZXMuDQo+PiArCSAqLw0KPj4gKwlpZiAoc2V2X2FjdGl2ZSgpKQ0K
Pj4gKwkJcmV0dXJuIHRydWU7DQo+PiArDQo+PiArCS8qDQo+PiArCSAqIEZvciBTTUUsIGFsbCBE
TUEgbXVzdCBiZSB0byB1bmVuY3J5cHRlZCBhZGRyZXNzZXMgaWYgdGhlDQo+PiArCSAqIGRldmlj
ZSBkb2VzIG5vdCBzdXBwb3J0IERNQSB0byBhZGRyZXNzZXMgdGhhdCBpbmNsdWRlIHRoZQ0KPj4g
KwkgKiBlbmNyeXB0aW9uIG1hc2suDQo+PiArCSAqLw0KPj4gKwlpZiAoc21lX2FjdGl2ZSgpKSB7
DQo+PiArCQl1NjQgZG1hX2VuY19tYXNrID0gRE1BX0JJVF9NQVNLKF9fZmZzNjQoc21lX21lX21h
c2spKTsNCj4+ICsJCXU2NCBkbWFfZGV2X21hc2sgPSBtaW5fbm90X3plcm8oZGV2LT5jb2hlcmVu
dF9kbWFfbWFzaywNCj4+ICsJCQkJCQlkZXYtPmJ1c19kbWFfbWFzayk7DQo+PiArDQo+PiArCQlp
ZiAoZG1hX2Rldl9tYXNrIDw9IGRtYV9lbmNfbWFzaykNCj4+ICsJCQlyZXR1cm4gdHJ1ZTsNCj4g
DQo+IEhtLiBXaGF0IGlzIHdyb25nIHdpdGggdGhlIGRldiBtYXNrIGJlaW5nIGVxdWFsIHRvIGVu
YyBtYXNrPyBJSVVDLCBpdA0KPiBtZWFucyB0aGF0IGRldmljZSBtYXNrIGlzIHdpZGUgZW5vdWdo
IHRvIGNvdmVyIGVuY3J5cHRpb24gYml0LCBkb2Vzbid0IGl0Pw0KDQpOb3QgcmVhbGx5Li4uICBp
dCdzIHRoZSB3YXkgRE1BX0JJVF9NQVNLIHdvcmtzIHZzIGJpdCBudW1iZXJpbmcuIExldCdzIHNh
eQ0KdGhhdCBzbWVfbWVfbWFzayBoYXMgYml0IDQ3IHNldC4gX19mZnM2NCByZXR1cm5zIDQ3IGFu
ZCBETUFfQklUX01BU0soNDcpDQp3aWxsIGdlbmVyYXRlIGEgbWFzayB3aXRob3V0IGJpdCA0NyBz
ZXQgKDB4N2ZmZmZmZmZmZmZmKS4gU28gdGhlIGNoZWNrDQp3aWxsIGNhdGNoIGFueXRoaW5nIHRo
YXQgZG9lcyBub3Qgc3VwcG9ydCBhdCBsZWFzdCA0OC1iaXQgRE1BLg0KDQpUaGFua3MsDQpUb20N
Cg0KPiANCj4+ICsJfQ0KPj4gKw0KPj4gKwlyZXR1cm4gZmFsc2U7DQo+PiArfQ0KPiANCg==
