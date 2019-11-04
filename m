Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C003CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 23:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE26204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 23:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KEoKhbmb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ygtt5iXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbfKDXHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 18:07:01 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:52984 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbfKDXHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 18:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1572908840; x=1604444840;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ReIx7euwgGmysoA14OOiX7RZqMXlEd29DtQn1yy3KNs=;
  b=KEoKhbmbU21WWTtiMSEawwZqLuxxtx4vLzi75/umtK6IAce6bu5XrT8e
   AuSJwfr6AsAClc2eFxzCmsZkTSI/VEw7vgPe9kAgk6qdIu7chr9N5ARJm
   u1ZPRUGi6FpcQCQM1m/yTSfzTKUh6MUGwYAR4hHvvXFqGI5y5kNeuni7B
   cBrYRd8r6XoXjFSXHdT8MRu5PIPPQdefrfDNlLRS2+vXecw4fprnTMzfr
   D+pdaFP4qdYJKHElKdaNhAbhLDiIMNASjxQ1wIHwE2Zaoq2fT/4BC3oVW
   I85LPCGPcBZV7SfTq0s8V8e3Ev+/CoS4ZyfkN7ieU2ehLuLYi2yVh2ses
   Q==;
IronPort-SDR: jI3Ns0UyeXSQ9lFgtXIuHMHNvmBHSrEguiXOcQhfvjT9VbB1SorkdrW5Ax32k3/kaFrB1ZBieh
 nHbaYxIzZ/oqauB9s2RCcme27BKVH0fS/IHOwC5VCVGoSB0yKSUfcJwamaE682eApSaC6IsjLg
 ny64330pFYEZwawmDfv0RudPi8QQK0EFHH+GNU1QUUq9Nhjy+3sRZizvPglctAG5rhRvqT5HqR
 GzqxLjo8xMUjUBrTV6IExzIsdPMbn5vOiGiz4SoV+mjyIYd6VHz3dQRcVsk9Yx6wdqlM3pEwTX
 UfE=
X-IronPort-AV: E=Sophos;i="5.68,268,1569254400"; 
   d="scan'208";a="223291062"
Received: from mail-co1nam05lp2053.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.53])
  by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2019 07:07:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEtuOjtB2+7BeKjPDiPHtFYjCw5qSytpPf+Im7vVjKMc0I5G3rRT434VFuxvAOcP1dlSFftcsrqQe05PbcLMwGcZd+dd9xIs3x0K9+GHSENNj0WirKgMTtNGPwwhcp5eez+eo8xRLunKEPTEySh0jHyU/E5BXJB7GpDgmipXWIi+8DTA7JRNDR8dxaPh98J22ujfj4IgrL2Kk7/n5NrBCreZTzA9rvtD8Bhfmu5iXd7ogjfhZP4s3OCbtYnMXKV/i5rQXpY09uVc3L0CJAUilFM2FuKxuImGb6aeQ9vwiYl4OilXmUZTZ7BnxEdGLbcNXENFG2cVSZVWUqbNxOkV/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReIx7euwgGmysoA14OOiX7RZqMXlEd29DtQn1yy3KNs=;
 b=FUZIuRrq4hsHLcY8F0gahTFMu2tRPLiCyWrTA+OXWnnunhhbqhTaynPDs4FDj/1F6ETJiuS37FXbdR561PoMmFlhdC+oVghmWnapbky3kPN5ucTv138baZnhbwv3KMXMXeLNoydV0GGHCZ9CVzKR8SK4NK5NzPlQhxdCxMQiyKPeeS/UXtx3KKETxBzOwaYxVBaoBVDEpjduYC9Yw06N/w9ijkhbJ/3TG/Grj/fMXceP3ICbhMqazVjsTX+CURZtAE+kYaLIqIe8epq4edaezoCy/IE4l3wCpeTtfr72yFrdhwYncH8y8Fp2AXbcW8naqmCC/1BaTgYffJi6g2FzkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReIx7euwgGmysoA14OOiX7RZqMXlEd29DtQn1yy3KNs=;
 b=Ygtt5iXP9O+jwK1M7b7639HrixXBo9QFpuOIJJ5H9kP3yiRiTbwPc9fuzhwYPvxoLc9JbMtWJW7AE/Iv0p413M+F2ZCqRo4C9sY73LGQpTLnhgTtcmLiV3gpwQ1k2tlBkPPclNClHx9ed+oHD8/JmPy60IQz6MsN4Tph6qmGW0w=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB4902.namprd04.prod.outlook.com (52.135.232.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 23:06:53 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::9012:2102:b53f:d5f1]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::9012:2102:b53f:d5f1%7]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 23:06:53 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "info@metux.net" <info@metux.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rfontana@redhat.com" <rfontana@redhat.com>,
        "johan@kernel.org" <johan@kernel.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "allison@lohutok.net" <allison@lohutok.net>
Subject: Re: [PATCH v2  2/2] RISC-V: Consolidate isa correctness check
Thread-Topic: [PATCH v2  2/2] RISC-V: Consolidate isa correctness check
Thread-Index: AQHVfu0fDoAFDM4020SNIx23VNFenqdgImCAgACZzQCAAAjDgIAbBkwA
Date:   Mon, 4 Nov 2019 23:06:53 +0000
Message-ID: <f7585738ea71f0dbe46011e3e718e7c3ba065eea.camel@wdc.com>
References: <20191009220058.24964-1-atish.patra@wdc.com>
         <20191009220058.24964-3-atish.patra@wdc.com>
         <alpine.DEB.2.21.9999.1910180142460.21875@viisi.sifive.com>
         <a45f0c0e3db2e852770485bc581d489b6ee7545e.camel@wdc.com>
         <alpine.DEB.2.21.9999.1910181121270.21875@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1910181121270.21875@viisi.sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ac4a04fe-38df-4a8b-fa68-08d7617bae84
x-ms-traffictypediagnostic: BYAPR04MB4902:
x-microsoft-antispam-prvs: <BYAPR04MB4902F455023C6EC73A3AD16BFA7F0@BYAPR04MB4902.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(189003)(199004)(305945005)(6246003)(2351001)(102836004)(5640700003)(6486002)(486006)(2616005)(66066001)(476003)(446003)(8936002)(7416002)(25786009)(8676002)(4001150100001)(2906002)(7736002)(11346002)(81166006)(81156014)(4326008)(86362001)(14454004)(5660300002)(6116002)(3846002)(2501003)(478600001)(71190400001)(71200400001)(118296001)(186003)(6506007)(256004)(6512007)(66556008)(66946007)(6916009)(76116006)(66476007)(64756008)(66446008)(99286004)(76176011)(316002)(26005)(54906003)(229853002)(36756003)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4902;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q7jZJgLOTRKBnkccvxJRCtKJ2f/rclTp4vRuQgmtYUpzbYnXtKRs0HHYk1iFBgqMcRJFShmdDav+SPwRCR9ysjDaHXQD9/hZtQrIPgWCCvZE0h8+P+4CAI/1Uv7Ly1N6xdVhiF7GzC/nNd5EzF+3WGYvI+sadZo0vsf38YOHf91PQ6HPHEQjAVlo4Sf4pifJGbdlgkUWPZ6vbKRA3WG+ZxzSofO7JsXR+f4oqzSRGczoyiS2irEIxLSoNe33vcJGGl/XU5bJvvKWyXJBprwO0n4Ex2nzfB291FOn9qUwLBMHt4aSNl8Fzoa3lx8LFK3dzU5LB3M2Yr+BQJILdzlfWOpM/cAAySNZcUv5nLl14h+G1fstZWC9+S+URfcn6RNtL/JetaXNi5bCeTqOKxd31OW7AzzfgM4nRtbuKMPUSkMrkCf6zBSkvvvgoZprf415
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F38A34D2EF80A14E95A85469AC3F4725@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4a04fe-38df-4a8b-fa68-08d7617bae84
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 23:06:53.1187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wAoRvUHCO8rlpy1wuzWWaJwM6m8yjCCj3v6hA7Yb5EpSBwX7/KqYeNDVKDvFe+I1+jporvRUoTudVn3t+ZwOUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4902
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTEwLTE4IGF0IDExOjI1IC0wNzAwLCBQYXVsIFdhbG1zbGV5IHdyb3RlOg0K
PiBPbiBGcmksIDE4IE9jdCAyMDE5LCBBdGlzaCBQYXRyYSB3cm90ZToNCj4gDQo+ID4gT24gRnJp
LCAyMDE5LTEwLTE4IGF0IDAxOjQzIC0wNzAwLCBQYXVsIFdhbG1zbGV5IHdyb3RlOg0KPiA+ID4g
T24gV2VkLCA5IE9jdCAyMDE5LCBBdGlzaCBQYXRyYSB3cm90ZToNCj4gPiA+IA0KPiA+ID4gPiBD
dXJyZW50bHksIGlzYSBzdHJpbmcgaXMgcmVhZCBhbmQgY2hlY2tlZCBmb3IgY29ycmVjdG5lc3Mg
YXQgDQo+ID4gPiA+IG11bHRpcGxlIHBsYWNlcy4NCj4gPiA+ID4gDQo+ID4gPiA+IENvbnNvbGlk
YXRlIHRoZW0gaW50byBvbmUgZnVuY3Rpb24gYW5kIHVzZSBpdCBvbmx5IGR1cmluZw0KPiA+ID4g
PiBlYXJseSANCj4gPiA+ID4gYm9vdHVwLiBJbiBjYXNlIG9mIGEgaW5jb3JyZWN0IGlzYSBzdHJp
bmcsIHRoZSBjcHUgc2hvdWxkbid0DQo+ID4gPiA+IGJvb3QgYXQgDQo+ID4gPiA+IGFsbC4NCj4g
PiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEF0aXNoIFBhdHJhIDxhdGlzaC5wYXRyYUB3
ZGMuY29tPg0KPiA+ID4gDQo+ID4gPiBMb29rcyBsaWtlIHJpc2N2X3JlYWRfY2hlY2tfaXNhKCkg
aXMgY2FsbGVkIHR3aWNlIGZvciBlYWNoDQo+ID4gPiBoYXJ0LiAgSXMgDQo+ID4gPiB0aGVyZSBh
bnkgd2F5IHRvIGNhbGwgaXQgb25seSBvbmNlIHBlciBoYXJ0Pw0KPiA+ID4gDQo+ID4gDQo+ID4g
SSBoYWQgdG8gYWRkIHRoZSBjaGVjayBpbiByaXNjdl9maWxsX2h3Y2FwKCkgYmVjYXVzZSB0aGF0
IGZ1bmN0aW9uDQo+ID4gaXMNCj4gPiBpdGVyYXRpbmcgb3ZlciBhbGwgY3B1IG5vZGVzIHRvIHNl
dCB0aGUgaHdjYXAuIFRodXMsIHNvbWUgb2YgdGhlDQo+ID4gaGFydHMNCj4gPiB0aGF0IGFyZSBu
b3QgYXZhaWxhYmxlIGR1ZSB0byBpbmNvcnJlY3QgaXNhIHN0cmluZyBjYW4gYWZmZWN0DQo+ID4g
aHdjYXAuDQo+ID4gDQo+ID4gV2UgY2FuIGNoZWNrIGNwdV9wb3NzaWJsZV9tYXNrIHRvIGZpZ3Vy
ZSBvdXQgdGhlIGhhcnRzIHdpdGggaW52YWxpZA0KPiA+IGlzYQ0KPiA+IHN0cmluZ3MgYnV0IHRo
YXQgd2lsbCBwZXJmb3JtIHBvb3JseSBhcyBSSVNDLVYgaGF2ZSBtb3JlIGhhcnRzIGluDQo+ID4g
ZnV0dXJlLg0KPiANCj4gSG93IGFib3V0IGp1c3QgY2FsbGluZyByaXNjdl9yZWFkX2NoZWNrX2lz
YSgpIG9uY2UgZm9yIGFsbCBoYXJ0cyBhbmQgDQo+IGxlYXZpbmcgcmlzY3ZfZmlsbF9od2NhcCgp
IHRoZSB3YXkgaXQgd2FzPyANCj4gIFlvdSdsbCBwcm9iYWJseSBuZWVkIHRvIGhvaXN0IA0KPiB0
aGUgZWFybGllciBjYWxsIG91dCBvZiBzZXR1cF9zbXAoKSwgc28gaXQgc3RpbGwgaXMgY2FsbGVk
IHdoZW4gDQo+ICFDT05GSUdfU01QLg0KDQpDdXJyZW50bHksIGl0IGRvZXNuJ3QgbGV0IGJvb3Qg
YW55IGNwdSB3aXRoIGluY29ycmVjdCBpc2Egc3RyaW5nIGZvcg0Kc21wIHVzZWNhc2UuIFdlIHN0
aWxsIG5lZWQgdG8gcHJlc2VydmUgdGhhdCB1c2VjYXNlLiBJIHRoaW5rDQpzZXR1cF9zbXAoKSB1
c2UgaXMgdW5hdm9pZGFibGUuDQoNCklmIHRoZSBib290IGNwdSBoYXMgaW5jb3JyZWN0IGlzYSBp
bmZvIGZvciAhQ09ORklHX1NNUCwgSSBndWVzcyB3ZQ0Kc2hvdWxkIGhhbHQgdGhlIGJvb3Qgd2l0
aCBCVUdfT04uIFRoaXMgaXMgYSBzZXBhcmF0ZQ0KcmlzY3ZfcmVhZF9jaGVja19pc2EgY2FsbCB3
aXRoIGJvb3QgaGFydCBkZXZpY2Ugbm9kZS4NCg0KVGhpcyBpcyB3aGF0IHdlIGNhbiBkbzoNCg0K
TWFpbnRhaW4gYSBnbG9iYWwgY3B1bWFzayBvZiBoYXJ0cyB3aXRoIGludmFsaWQgaXNhIHN0cmlu
Z3Mgd2hpY2ggd291bGQNCmJlIHNldCBkdXJpbmcgZWFybHkgYm9vdHVwIChiZWZvcmUgc2V0dXBf
c21wKS4gVGhpcyBjcHVtYXNrIHdpbGwgYmUNCnVzZWQgaW4gc2V0dXBfc21wKCkgYW5kIHJpc2N2
X2ZpbGxfaHdjYXAoKSB0byBhdm9pZCB1c2luZyBoYXJ0cyB3aXRoDQppbnZhbGlkIGlzYS4gVGhp
cyB3aWxsIG1ha2Ugc3VyZSB0aGF0IHRoZXJlIGlzIG9ubHkgc2luZ2xlIGludm9jYWl0b24NCm9m
IHJpc2N2X3JlYWRfY2hlY2tfaXNhKCkuIEluIG1vc3QgY2FzZXMsIHRoaXMgY3B1bWFzayB3aWxs
IGJlIGVtcHR5DQphbmQgcGVuYWx0eSBvZiBjcHVtYXNrIGNoZWNrIHdvbid0IG1hdHRlci4NCg0K
SXMgdGhhdCB3aGF0IHlvdSBoYWQgaW4gbWluZCBvciBhbnkgb3RoZXIgYXBwcm9hY2ggdG8gYWRk
cmVzcyBhbGwgMw0KdXNlY2FzZXMgPyANCg0KPiANCj4gLSBQYXVsDQoNCi0tIA0KUmVnYXJkcywN
CkF0aXNoDQo=
