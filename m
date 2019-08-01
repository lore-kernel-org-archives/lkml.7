Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0FAC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51BC2087E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MHhOTdcf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbfHAPpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:45:02 -0400
Received: from mail-eopbgr790059.outbound.protection.outlook.com ([40.107.79.59]:5698
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726467AbfHAPpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:45:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXbyvv8O6mgL/uSzvkpky2X4uwa3Ambz30I1P/ueCYYq+165LR2+Hazze26yBnOeSfwS6duyRrBkRScbf7BjxsQyW4pBYLpM4Ng4X4jb0WHIXkAPRq9QvFJGuINOHT6MjPcQQmRFSyIQ72WttUlooDumy1E4EeyD5/aFdYMAFl35ik108ZBsGCy0Ygg4gWdH4mq1gL3iW6i4EfLjEVbOx6z7IyZrYiaTweAiT9mY4yG5UWfGsIIMlDy84Mn/yvtRJIeT+OIh7xFz9t1T9GdGIKkyYpeMyZvhQC7CsMeOwRwOE9FRCh3gby3F2v58LfGRMliUH+wsP5yYUF7+aRg9qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9NOpEBblRV7ONaRdq28jU2OAowTCZGUQ/vzCku6AYU=;
 b=DD+xA/p1HpP9tt3SSfYJ4JMUidsDIAU84akCzi+PxOb6btjaL4AUOVj0K1vpWpy0Jl/g85uD45DRFIcA/60IpT7LlDDVAE1wblq3GemWpc/n1kBzeGLb5dosvJI1L8d8zZ2PkOUQd5NsSVKC3jnZw93aTKokf2cO7otc+EaHl5x3ljRIirm7tlrkqVappgg3Z/VVrqEMrXBlvWTdGoLuJbRpWxNIoJBRJvTDeP1aNN7ot+3MuFiXy4ZB5oL/Q1HOjY2cXx1jnbDFfPHQboHyCzL6CHbnUtu7g2EjP+cUZc/vKRhavlX50QxipBgGfGN555cGdNaYHKw6RDASwZZORw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9NOpEBblRV7ONaRdq28jU2OAowTCZGUQ/vzCku6AYU=;
 b=MHhOTdcfgAo5olrqbt/sWERrDKcEDanYpBUAA8gRZEl2TsV5aLdtwpNAnvcIFTfkkq9sBhtdk0h/rYTXaVtKwPBpo+ujJQTrFG2/xLVpyZ4V6I8XESQWajVaek9HCVNyVDGhA0xwPh5Oj/Ks1ugc6DuYY0t9xVDvdpu6CeLZZjY=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3162.namprd12.prod.outlook.com (20.179.104.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Thu, 1 Aug 2019 15:44:19 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 15:44:19 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>
CC:     Aubrey Li <aubrey.intel@gmail.com>,
        Daniel Drake <drake@endlessm.com>,
        "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: setup_boot_APIC_clock() NULL dereference during early boot on
 reduced hardware platforms
Thread-Topic: setup_boot_APIC_clock() NULL dereference during early boot on
 reduced hardware platforms
Thread-Index: AQHVSDHageyJLuj1e02we0A4NQI8qKbl4bwAgAAFR4CAAAXXgIAABMSAgAACPYCAAB85AIAAXHyA
Date:   Thu, 1 Aug 2019 15:44:19 +0000
Message-ID: <3d14b0cc-3cca-1874-3521-4ee2ec52141d@amd.com>
References: <CAD8Lp448i7jOk9C5NJtC2wHMaGuRLD4pxVqK17YqRCuMVXhsOA@mail.gmail.com>
 <CAERHkruxfBc8DqNUr=fbYuQWrXrHC7cK6HnVR3xp0iLA9QtxiQ@mail.gmail.com>
 <alpine.DEB.2.21.1908010931550.1788@nanos.tec.linutronix.de>
 <CAERHkrtaVAQHDU1cj2_GLL59LPjp7E=3X0Zna0spfFB=Ve5__w@mail.gmail.com>
 <alpine.DEB.2.21.1908011011250.1788@nanos.tec.linutronix.de>
 <81666b28-d029-56c3-8978-90abc219d1b7@linux.intel.com>
 <alpine.DEB.2.21.1908011054210.1965@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908011054210.1965@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0030.namprd05.prod.outlook.com
 (2603:10b6:803:40::43) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3564a64-e56c-4ff9-b685-08d716971e0f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3162;
x-ms-traffictypediagnostic: DM6PR12MB3162:
x-microsoft-antispam-prvs: <DM6PR12MB31627C3B5A6F1D6FB6B450D6ECDE0@DM6PR12MB3162.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(199004)(189003)(53936002)(7736002)(71200400001)(6246003)(6512007)(71190400001)(6486002)(52116002)(6436002)(54906003)(26005)(102836004)(186003)(4326008)(386003)(6506007)(76176011)(53546011)(14454004)(305945005)(2906002)(81156014)(81166006)(229853002)(36756003)(8676002)(31686004)(6116002)(66066001)(68736007)(8936002)(478600001)(256004)(86362001)(316002)(446003)(11346002)(3846002)(66446008)(64756008)(5660300002)(66946007)(99286004)(110136005)(486006)(476003)(2616005)(25786009)(31696002)(66476007)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3162;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gmpO+CM9CmHbP40EQO/fO03a4GHzEnvgHMtVaG3qcyB4x1NO1ybgG0+o1QmK//HH8l7ve8fpBmbAUPXqCY6PftO+hoFf5PAD+C3luXvzIc2f7W1o3Y5Haw+bJdldbOBcApIgj9CTg7wRfkl6e/Ijva1UePH86kVqUdT9TOr/F66PWib1pRmw8Gtsg4/kZdd+vY4LJIVO1HJ1NTEO3sqy0k0B6MDPTVTx9ElJGStvSWfmf2/0vKTdIOcz3eG0NpcJWA2D8wOE6W59hYXuXGipdEcVkgoj++yn9VPOhTlIU3itOoCLpcqxWTmamSfh5q0yT/94eujcieC+aP4hu+/vi1iqH1BzKZffO6qA3hWuaNua/hr2OBXaROFuFn2KJ73PAgHJhWVwkGkByOhqowUZBPAETb9ZJlD/EbT+heZLMUU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0A70CE6AF4D3749BD35B63528FB4D4D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3564a64-e56c-4ff9-b685-08d716971e0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 15:44:19.8232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8xLzE5IDU6MTMgQU0sIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4gT24gVGh1LCAxIEF1
ZyAyMDE5LCBMaSwgQXVicmV5IHdyb3RlOg0KPj4gT24gMjAxOS84LzEgMTY6MTMsIFRob21hcyBH
bGVpeG5lciB3cm90ZToNCj4+PiBUaGUgcG9pbnQgaXMgdGhhdCBpdCBkb2VzIG5vdCBtYXR0ZXIg
d2hpY2ggdmVuZG9yIGEgQ1BVIGNvbWVzIGZyb20uIFRoZQ0KPj4+IGtlcm5lbCBkb2VzIHN1cHBv
cnQgbGVnYWN5bGVzcyBib290IHdoZW4gdGhlIGZyZXF1ZW5jaWVzIGFyZSBrbm93bi4gV2hldGhl
cg0KPj4+IHRoYXQncyBjdXJyZW50bHkgcG9zc2libGUgb24gdGhhdCBwYXJ0aWN1bGFyIENQVSBp
cyBhIGRpZmZlcmVudCBxdWVzdGlvbi4NCj4+Pg0KPj4gWWVhaCwgSSBzaG91bGQgc3BlY2lmeSwg
RGFuaWVsLCB5b3VyIHBsYXRmb3JtIG5lZWRzIGEgZ2xvYmFsIGNsb2NrIGV2ZW50LCA7LSkNCj4g
DQo+IENhcmUgdG8gbG9vayBhdCB0aGUgbWFudWFscyBiZWZvcmUgbWFraW5nIGFzc3VtcHRpb25z
Pw0KPiANCj4gICAyLjEuOSBUaW1lcnMNCj4gDQo+ICAgIEVhY2ggY29yZSBpbmNsdWRlcyB0aGUg
Zm9sbG93aW5nIHRpbWVycy4gVGhlc2UgdGltZXJzIGRvIG5vdCB2YXJ5IGluDQo+ICAgIGZyZXF1
ZW5jeSByZWdhcmRsZXNzIG9mIHRoZSBjdXJyZW50IFAtc3RhdGUgb3IgQy1zdGF0ZS4NCj4gDQo+
ICAgICogQ29yZTo6WDg2OjpNc3I6OlRTQzsgdGhlIFRTQyBpbmNyZW1lbnRzIGF0IHRoZSByYXRl
IHNwZWNpZmllZCBieSB0aGUNCj4gICAgICBQMCBQc3RhdGUuIFNlZSBDb3JlOjpYODY6Ok1zcjo6
UFN0YXRlRGVmLg0KPiANCj4gICAgKiBUaGUgQVBJQyB0aW1lciAoQ29yZTo6WDg2OjpBcGljOjpU
aW1lckluaXRpYWxDb3VudCBhbmQNCj4gICAgICBDb3JlOjpYODY6OkFwaWM6OlRpbWVyQ3VycmVu
dENvdW50KSwgd2hpY2ggaW5jcmVtZW50cyBhdCB0aGUgcmF0ZSBvZg0KPiAgICAgIDJ4Q0xLSU47
IHRoZSBBUElDIHRpbWVyIG1heSBpbmNyZW1lbnQgaW4gdW5pdHMgb2YgYmV0d2VlbiAxIGFuZCA4
Lg0KPiANCj4gVGhlIFJ5emVucyB1c2UgYSAxMDBNSHogaW5wdXQgY2xvY2sgZm9yIHRoZSBBUElD
IG5vcm1hbGx5LCBidXQgSSdtIG5vdCBzdXJlDQo+IHdoZXRoZXIgdGhpcyBpcyBzdWJqZWN0IHRv
IG92ZXJjbG9ja2luZy4gSWYgc28gdGhlbiBpdCBzaG91bGQgYmUgcG9zc2libGUNCj4gdG8gZmln
dXJlIHRoYXQgb3V0IHNvbWVob3cuIFRvbT8NCg0KTGV0IG1lIGNoZWNrIHdpdGggdGhlIGhhcmR3
YXJlIGZvbGtzIGFuZCBJJ2xsIGdldCBiYWNrIHRvIHlvdS4NCg0KVGhhbmtzLA0KVG9tDQoNCj4g
DQo+IFRoYW5rcywNCj4gDQo+IAl0Z2x4DQo+IA0K
