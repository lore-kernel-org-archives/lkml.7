Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E95C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CAB221916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="E/IqbNgy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbfCUSLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:11:07 -0400
Received: from mail-eopbgr690042.outbound.protection.outlook.com ([40.107.69.42]:59532
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727829AbfCUSLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZT3fjJRkJXKU9CRsZaIvhv6cloJxWtqO16jwPLK+OP4=;
 b=E/IqbNgy/u8FPa2zCrMnW2KBkKZ8WeHAIHO6MMeRVIS5UMSLjfWJD3JftSBAxhjp81Nzw2jfYYH5ayrvC00kv+IolpoYhkMJSo8P5mm36eoOp4VrPXooRkPHbcNZxlmuo4KR9BAz8BW/VY30HnvLsnDsK1VtOxKRnamGH5ZGWNg=
Received: from BN8PR10MB3540.namprd10.prod.outlook.com (20.179.78.205) by
 BN8PR10MB3105.namprd10.prod.outlook.com (20.179.136.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Thu, 21 Mar 2019 18:11:04 +0000
Received: from BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::18aa:cf18:b8d3:d77f]) by BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::18aa:cf18:b8d3:d77f%5]) with mapi id 15.20.1709.015; Thu, 21 Mar 2019
 18:11:04 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "richard@nod.at" <richard@nod.at>
CC:     "nsekhar@ti.com" <nsekhar@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "masonccyang@mxic.com.tw" <masonccyang@mxic.com.tw>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "sergei.shtylyov@cogentembedded.com" 
        <sergei.shtylyov@cogentembedded.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [RFC PATCH v2 1/5] mtd: cfi_cmdset_0002: Add support for polling
 status register
Thread-Topic: [RFC PATCH v2 1/5] mtd: cfi_cmdset_0002: Add support for polling
 status register
Thread-Index: AQHU4A390EDhLD8/jkyjBXiay9/acKYWYsWA
Date:   Thu, 21 Mar 2019 18:11:04 +0000
Message-ID: <f92362a0678b07d22ccc0f271fe3483dc77364a9.camel@infinera.com>
References: <20190321174548.9288-1-vigneshr@ti.com>
         <20190321174548.9288-2-vigneshr@ti.com>
In-Reply-To: <20190321174548.9288-2-vigneshr@ti.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ac5cbd8-fa3a-4198-3b4c-08d6ae28950f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN8PR10MB3105;
x-ms-traffictypediagnostic: BN8PR10MB3105:
x-microsoft-antispam-prvs: <BN8PR10MB31054D7C477CDE4E5A5091F2F4420@BN8PR10MB3105.namprd10.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(39860400002)(396003)(346002)(199004)(189003)(4326008)(25786009)(36756003)(99286004)(6512007)(2501003)(76176011)(186003)(102836004)(26005)(6506007)(2616005)(2201001)(476003)(11346002)(5660300002)(486006)(71190400001)(71200400001)(446003)(66066001)(14454004)(86362001)(256004)(7416002)(54906003)(81156014)(305945005)(3846002)(81166006)(8936002)(2906002)(72206003)(68736007)(6116002)(7736002)(8676002)(478600001)(316002)(110136005)(6436002)(106356001)(229853002)(53936002)(6486002)(6246003)(118296001)(97736004)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR10MB3105;H:BN8PR10MB3540.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ygGuIjdEisGKx4CzonjOmdNZAJvYWpE6W3tvar1czxyaXGXgKCplaXy4xcdpjk1VwdkOtZOBELZ8K0dDPqkBe7MHA4Sz1DGAJWFSAoZ4A//Sumzj/qijTy3/tZcJDPgfIy7g3LJo//LmzJnESDPkvywU3XHcsaOxkJIAXlFMLgz9bl4aC5QftlYg3R5ekcQt6N5K0XZKQ1pwJVXQErGNm65+5Xh8lHSzXJeo/BfDDFtPKgTZKB6ctaDQ4oG3AcC/OvIdOowkRj86wrQ6FgkHTC48Xfl6Tw+oPhDIbV//ckI7IRX6jh1WRDlXs7/YnQzHbekfqLRtNQP212PVouAotUpp9jxHwIUObq+3hOLzRlKAYkzEIUbFiXg8pFhR18GqBHgKbqjOV20CUpBPeG9oZ13oVyJcK3a0VEKgtlh5t9w=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58BC4D51F4B1384CB30D55481DDC2F6C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac5cbd8-fa3a-4198-3b4c-08d6ae28950f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 18:11:04.0731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTAzLTIxIGF0IDIzOjE1ICswNTMwLCBWaWduZXNoIFJhZ2hhdmVuZHJhIHdy
b3RlOg0KPiANCj4gSHlwZXJGbGFzaCBkZXZpY2VzIGFyZSBjb21wbGlhbnQgd2l0aCBDRkkgQU1E
L0Z1aml0c3UgRXh0ZW5kZWQgQ29tbWFuZA0KPiBTZXQoMHgwMDAyKSBmb3IgZmxhc2ggb3BlcmF0
aW9ucywgdGhlcmVmb3JlIGRyaXZlcnMvbXRkL2NoaXBzL2NmaV9jbWRzZXRfMDAwMi5jDQo+IGNh
biBiZSB1c2UgYXMgaXMuIEJ1dCB0aGVzZSBkZXZpY2VzIGRvIG5vdCBzdXBwb3J0IERRIHBvbGxp
bmcgbWV0aG9kIG9mDQo+IGRldGVybWluaW5nIGNoaXAgcmVhZHkvZ29vZCBzdGF0dXMuIFRoZXNl
IGZsYXNoZXMgcHJvdmlkZSBTdGF0dXMNCj4gUmVnaXN0ZXIgd2hvc2UgYml0cyBjYW4gYmUgcG9s
bGVkIHRvIGtub3cgc3RhdHVzIG9mIGZsYXNoIG9wZXJhdGlvbi4NCj4gDQo+IEN5cHJlc3MgSHlw
ZXJGbGFzaCBkYXRhc2hlZXQgaGVyZVsxXSwgdGFsa3MgYWJvdXQgQ0ZJIEFtZC9GdWppdHN1DQo+
IEV4dGVuZGVkIFF1ZXJ5IHZlcnNpb24gMS41LiBCaXQgMCBvZiAiU29mdHdhcmUgRmVhdHVyZXMg
c3VwcG9ydGVkIiBmaWVsZA0KPiBvZiBDRkkgUHJpbWFyeSBWZW5kb3ItU3BlY2lmaWMgRXh0ZW5k
ZWQgUXVlcnkgdGFibGUgaW5kaWNhdGVzDQo+IHByZXNlbmNlL2Fic2VuY2Ugb2Ygc3RhdHVzIHJl
Z2lzdGVyIGFuZCBCaXQgMSBpbmRpY2F0ZXMgd2hldGhlciBvciBub3QNCj4gRFEgcG9sbGluZyBp
cyBzdXBwb3J0ZWQuIFVzaW5nIHRoZXNlIGJpdHMsIGl0cyBwb3NzaWJsZSB0byBkZXRlcm1pbmUN
Cj4gd2hldGhlciBmbGFzaCBzdXBwb3J0cyBEUSBwb2xsaW5nIG9yIG5lZWQgdG8gdXNlIFN0YXR1
cyBSZWdpc3Rlci4NCj4gDQo+IEFkZCBzdXBwb3J0IGZvciBwb2xsaW5nIHN0YXR1cyByZWdpc3Rl
ciB0byBrbm93IGRldmljZSByZWFkeS9zdGF0dXMgb2YNCj4gZXJhc2Uvd3JpdGUgb3BlcmF0aW9u
cyB3aGVuIERRIHBvbGxpbmcgaXMgbm90IHN1cHBvcnRlZC4NCg0KSXNuJ3QgdGhpcyBuZXcgU3Rh
dHVzIHNjaGVtZSBqdXN0IGEgY29weSBvZiBJbnRlbHMoY21kc2V0XzAwMDEpPw0KSWYgc28gSSB0
aGluayB0aGUgbmV3IHN0YXR1cyBpbXBsLiBpbiAwMDAyIHNob3VsZCBib3Jyb3cgZnJvbSAwMDAx
IGFzIHRoaXMgaXMgYQ0KaGFyZGVuZWQgYW5kIGJhdHRsZSB0ZXN0ZWQgaW1wbC4NCg0KSSBrbm93
IG90aGVyIG1vZGVybiAwMDAyIGNoaXBzIHN1cHBvcnRzIGJvdGggb2xkIGFuZCBuZXcgaW1wbC4g
b2YgU3RhdHVzIGFuZCBJIHdvcmxkDQpndWVzcyB0aGF0IHdlIHdpbGwgc2VlIG1vcmUgY2hpcHMg
d2l0aCBuZXcgU3RhdHVzIG9ubHkuDQoNCiBKb2NrZQ0K
