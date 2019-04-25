Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9DDC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE0420811
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fBN5zXpm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfDYLa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:30:58 -0400
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:59011
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727218AbfDYLa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 07:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vcd3L1QPNSwk5NsNneEVBZx0mhsJQL7y0KMeVYuHDOk=;
 b=fBN5zXpm4OIkkIPYdy5dHl+xre5tOXu0GIfOzcyHIG+UC+JSbaeV7GTn04cL71LeJiZpVy7PqrqWv9dscw/KbjA6W3/xjbES7NkH/gbj6nGASk1n9KO1t99lp9AAzAarB5VnWGrqyasCu8ZdWBAke6m+pBVQCCKGeb/T5Lr3GOk=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
 VI1PR04MB5742.eurprd04.prod.outlook.com (20.178.127.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Thu, 25 Apr 2019 11:30:54 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::81d8:f74b:f91e:f071]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::81d8:f74b:f91e:f071%6]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 11:30:54 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] dma-mapping: create iommu mapping for newly allocated
 dma coherent mem
Thread-Topic: [RFC PATCH] dma-mapping: create iommu mapping for newly
 allocated dma coherent mem
Thread-Index: AQHU+SuhzP7n9rkWMk6epTxwq855uaZIeyMAgAHQb4CAAR4MgIABWJQA
Date:   Thu, 25 Apr 2019 11:30:54 +0000
Message-ID: <b9f2b425-dde9-f9a1-b8fa-b7710e764b16@nxp.com>
References: <20190422165125.21704-1-laurentiu.tudor@nxp.com>
 <20190422181100.GB32490@lst.de>
 <VI1PR04MB513407A66107759EC0DFE175EC230@VI1PR04MB5134.eurprd04.prod.outlook.com>
 <20190424145705.GB21480@lst.de>
In-Reply-To: <20190424145705.GB21480@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9efaa0ed-af9c-44e0-6dc1-08d6c9717a97
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5742;
x-ms-traffictypediagnostic: VI1PR04MB5742:
x-microsoft-antispam-prvs: <VI1PR04MB574294BDBD6817E2786A1E96EC3D0@VI1PR04MB5742.eurprd04.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(376002)(396003)(346002)(199004)(189003)(8936002)(478600001)(4326008)(97736004)(6246003)(66066001)(6486002)(81156014)(6436002)(81166006)(71200400001)(71190400001)(8676002)(256004)(6116002)(3846002)(229853002)(36756003)(54906003)(316002)(11346002)(476003)(2616005)(486006)(44832011)(6916009)(5660300002)(2906002)(66946007)(66446008)(64756008)(66556008)(76176011)(76116006)(7736002)(305945005)(73956011)(68736007)(26005)(6506007)(186003)(53546011)(99286004)(102836004)(446003)(66476007)(31686004)(31696002)(93886005)(53936002)(86362001)(25786009)(14454004)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5742;H:VI1PR04MB5134.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3qlcUcjzUEFjHGfOOWWpa9IGk1mwUS5fLKHYrpNF7G//Owsr88hjnShhckMLU7GM+7sZCcxcR39/sLaeLl8Zi2prcvnmnmAvtgFcIBkB5AM4nUivoq/icqzTfj+pHUFUORVKhRK2erfCL3hB4E0hJmcDLfsNvGMcd+ztolPtDsOYk3BcUo3UKItSLa332LUNTfAd3XIt0yc9Zo6RFqeA8Gv0qSom2SPjy2vkysBpgrPBjoxT9HoT25k+CBSnDXANMV2YcihMmUDf8T+cJWnzlYSzsmCs5zNb3hnCvysVA+W1PNuFXsPXWMw4wfIHZiiuVaoml+7248YKnhKNbgYbLFRHPYPHLeL8OBxjOi+TWBmp7ogzgrH/z2RAylMNsLUU46QwP7KA2ntiXkqtUsgbg9+No40szz0+v0X/2wBdPbs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3DAFF8A2E6710478B0D4E110DCF3AE3@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efaa0ed-af9c-44e0-6dc1-08d6c9717a97
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 11:30:54.3194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5742
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hyaXN0b3BoLA0KDQpPbiAyNC4wNC4yMDE5IDE3OjU3LCBDaHJpc3RvcGggSGVsbHdpZyB3
cm90ZToNCj4gSSdkIGJlIGhhcHB5IHRvIG9mZmxvYWQgYWxsIG9mIHRoZSBtZW50aW9uZWQgdGFz
a3MgdG8geW91IGlmIHlvdQ0KPiB2b2x1bnRlZXIuDQoNCkFscmlnaHQsIEkgdGhpbmsgSSBtb3N0
bHkgZ290IGl0IGFuZCBjYW4gc3RhcnQgd2l0aCB0aGUgdHdvIHVzYiBkcml2ZXJzIA0KeW91IG1l
bnRpb25lZC4gSnVzdCBuZWVkIGEgZmV3IGNsYXJpZmljYXRpb25zLCBwbGVhc2Ugc2VlIGlubGlu
ZS4NCg0KPiBJIHRoaW5rIHRoZSBmaXJzdCBzdGVwIGlzIHRvIG1vdmUgdGhlIHR3byBVU0IgY29u
dHJvbGxlciB0aGF0IGNhbiBvbmx5DQo+IERNQSB0byB0aGVpciBvd24gQkFSIG9mZiB0aGUgZXhp
c3RpbmcgRE1BIGNvaGVyZW50IGluZnJhc3RydWN0dXJlLiAgVGhlDQo+IGNvbnRyb2xsZXJzIGFy
ZSBhbHJlYWR5IGlkZW50aWZpZWQgdXNpbmcgdGhlIEhDRF9MT0NBTF9NRU0gZmxhZywgc28gd2UN
Cj4ganVzdCBuZWVkIHRvIGtleSBvZmYgdGhhdCBpbiB0aGUgaGNkX2J1ZmZlcl8qIHJvdXRpbmVz
IGFuZCBjYWxsIGludG8gYQ0KDQpTbyBpZiBIQ0RfTE9DQUxfTUVNIGlzIHNldCBJIHNob3VsZCBj
YWxsIGludG8gdGhlIGdlbl9wb29sIGFwaSBpbnN0ZWFkIA0Kb2YgZXhpc3RpbmcgZG1hX3thbGxv
YyxmcmVlfV9jb2hlcmVudCgpLg0KDQo+IGdlbmFsbG9jIHRoYXQgaGFzIGJlZW4gZmVkIHVzaW5n
IHRoZSBiYXIsIHJlcGxhY2luZyB0aGUgY3VycmVudA0KPiBkbWFfZGVjbGFyZV9jb2hlcmVudCB1
c2FnZS4gIFRha2UgYSBsb29rIGF0IGRyaXZlcnMvcGNpL3AycGRtYS5jDQo+IGZvciBhbm90aGVy
IGV4YW1wbGUgb2YgYWxsb2NhdGluZyBiaXRzIG9mIGEgQkFSIHVzaW5nIGdlbmFsbG9jLg0KDQpX
aGVyZSBzaG91bGQgSSBwbGFjZSB0aGUgcmVmZXJlbmNlIHRvIHRoZSBnZW5fcG9vbD8gSG93IGRv
ZXMgbG9jYWxfcG9vbCANCmluICdzdHJ1Y3QgaGNkX3VzYicgc291bmQ/DQoNCi0tLQ0KVGhhbmtz
ICYgQmVzdCBSZWdhcmRzLCBMYXVyZW50aXU=
