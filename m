Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC131C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D80623402
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4dMywhym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389249AbfHVOf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:35:26 -0400
Received: from mail-eopbgr750089.outbound.protection.outlook.com ([40.107.75.89]:7310
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725886AbfHVOfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:35:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PITHN499Cn3KI61lAUBxbNcC6VhiNWKHsD/1MBESvMnkprAw9b8VBkpyJ1s2VW05iZS3Vif6VSy62+n58fP+yg2dRyQDDV1Wdh63IH9ePfb2HyD/ya5YfBGEzSrTRrBee1ZGmRFy+9j0FdIK0yz/pq2rCtyGdOyQrU4VkH6yi+1VlNx/fyn+QovCUwW0UQi/fnd2vww7QwttI1fkxdwcTODL6+ONGRmVxoOmVbztYESiG98Pz2xbwhfq20MIHCvnlg7W9pgH6jisAU8wvpe1jfTAEzxomDKJqKtuDHBHafSiZ+mYZTHJ24MEsjim8oO4U0fiT3BcKxtE8I1wbboNMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/0DJoXZjTR3mRdbNaCsipnQ9elS8IPLlkuaDahYjKY=;
 b=DaNkSUxXk0K8ZqtLQyysCEVwW+3rZlUj2W6rnGa/XOgcyM7Zktsqov0wRBQPEd4/CZYtQ6pk9RkHiC5m6m7j5ugW4VvgWK0RU/HihvCcjLTNSFfWdP1jYKsOEqKvIB2fSV6mcvl2UGKQdxqV9aZ8fscBzq+GmrnSo+4UgQS7W94gZanjXKulHw5jmSRFnr9JfqCTjGRbDFzkdLmeINShgsRb8eKNbjIwD8wkIrjgdvYIfHDDMxtTxYTkUtsvKEbpbSMfn6KRtBM2Uu/GiatXflRCoUVAoYlCIQH1kM/LYdtJg68Q2VMqwbzXRFvhfmiHTRNyvW79Vt818M6/MaW87w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/0DJoXZjTR3mRdbNaCsipnQ9elS8IPLlkuaDahYjKY=;
 b=4dMywhym/5tw4eDWYEORs8yvowmXZgoUYCXzrOBXZ2tMBdQkB4hWbEZUuwcyKRIv/fN8DROi49XkLmWPpyQe4eif1lO6gLBGKKPwbgt9Ie3kt08a9r5voNAHYq/FZuP+06Ozdntw6h+SzOTivSb5yoGLofejKcYJ57LXsCisnkY=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3484.namprd12.prod.outlook.com (20.178.199.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Thu, 22 Aug 2019 14:35:22 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::585:2d27:6e06:f9b0]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::585:2d27:6e06:f9b0%7]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 14:35:22 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Kairui Song <kasong@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH] x86/kdump: Reserve extra memory when SME or SEV is active
Thread-Topic: [PATCH] x86/kdump: Reserve extra memory when SME or SEV is
 active
Thread-Index: AQHVWJUTadUWR5JbS0WLM6x20OSCiqcHPHqA
Date:   Thu, 22 Aug 2019 14:35:21 +0000
Message-ID: <ff049b95-92a3-52ab-7ee8-01051a597cff@amd.com>
References: <20190822025328.17151-1-kasong@redhat.com>
In-Reply-To: <20190822025328.17151-1-kasong@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0089.namprd04.prod.outlook.com
 (2603:10b6:805:f2::30) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2c29484-90a0-409d-fb89-08d7270df655
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR12MB3484;
x-ms-traffictypediagnostic: DM6PR12MB3484:
x-microsoft-antispam-prvs: <DM6PR12MB348448D90A62B1A001C1D6BDECA50@DM6PR12MB3484.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(189003)(199004)(71200400001)(2906002)(76176011)(99286004)(11346002)(446003)(52116002)(316002)(54906003)(486006)(476003)(66066001)(478600001)(305945005)(14454004)(110136005)(86362001)(81166006)(8676002)(7416002)(31686004)(6116002)(3846002)(81156014)(8936002)(71190400001)(2616005)(4326008)(5660300002)(6512007)(53546011)(186003)(7736002)(256004)(66476007)(102836004)(2501003)(26005)(66446008)(66556008)(66946007)(36756003)(6246003)(53936002)(25786009)(6486002)(229853002)(386003)(6506007)(64756008)(6436002)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3484;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HlzSflvLgtv2Zj9tVT276/8kL9wNs3Gl4CEoSGFzIDqjzPvtthXOaDV41OeSlL9cMuMbmiOuW5bBG8VMN6VONKc6kSvD2n9Ar+6wv8gZRS6TNVAUE0yjB5LI+Barul/2CtXkHlOiHii7EEqgRGm7rB2bN0Kk8F9qXyrEzHlZz1BNBslUfxR8nT2ne6S/KXbMmaRTWiN7G9S5ove4RKX014lRxNijvQS94GKyTzVDlA/IiKiOvFaKkC6Lj3DW7HLgPsQ4CF3+L4QywcNCiWEaaYeHNoqhqWlF1Kv6A0f3XQpMcwsQXUHmKLiJbFRpbTJJ5AXYyQsGqVfouGmfYJumzjtlf/f51wIo6qu0nL5Lro94jG2xWMGeN8e1u6wYaiakv45i0oJaHsDYSfY4twtP7G5cFlOm6bBkDoiXIyoBfqQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEDAE35B32F9CC4B801F6354AE021080@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c29484-90a0-409d-fb89-08d7270df655
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 14:35:22.0980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9UnZqChvfv2UDVGSD9452/f5denRvI1kF6/wg8+2lR1s4OoHtWJZ4ZpvtcakV55sJljuU8ZrtX4+nPoeKoNxrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3484
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8yMS8xOSA5OjUzIFBNLCBLYWlydWkgU29uZyB3cm90ZToNCj4gU2luY2UgY29tbWl0IGM3
NzUzMjA4YTk0YyAoIng4Niwgc3dpb3RsYjogQWRkIG1lbW9yeSBlbmNyeXB0aW9uIHN1cHBvcnQi
KSwNCj4gU1dJT1RMQiB3aWxsIGJlIGVuYWJsZWQgZXZlbiBpZiB0aGVyZSBpcyBsZXNzIHRoYW4g
NEcgb2YgbWVtb3J5IHdoZW4gU01FDQo+IGlzIGFjdGl2ZSwgdG8gc3VwcG9ydCBETUEgb2YgZGV2
aWNlcyB0aGF0IG5vdCBzdXBwb3J0IGFkZHJlc3Mgd2l0aCB0aGUNCj4gZW5jcnlwdCBiaXQuDQo+
IA0KPiBBbmQgY29tbWl0IGFiYTJkOWE2Mzg1YSAoImlvbW11L2FtZDogRG8gbm90IGRpc2FibGUg
U1dJT1RMQiBpZiBTTUUgaXMNCj4gYWN0aXZlIikgbWFrZSB0aGUga2VybmVsIGtlZXAgU1dJT1RM
QiBlbmFibGVkIGV2ZW4gaWYgdGhlcmUgaXMgYW4gSU9NTVUuDQo+IA0KPiBUaGVuIGNvbW1pdCBk
N2I0MTdmYTA4ZDEgKCJ4ODYvbW06IEFkZCBETUEgc3VwcG9ydCBmb3IgU0VWIG1lbW9yeQ0KPiBl
bmNyeXB0aW9uIikgd2lsbCBhbHdheXMgZm9yY2UgU1dJT1RMQiB0byBiZSBlbmFibGVkIHdoZW4g
U0VWIGlzIGFjdGl2ZQ0KPiBpbiBhbGwgY2FzZXMuDQo+IA0KPiBOb3csIHdoZW4gZWl0aGVyIFNN
RSBvciBTRVYgaXMgYWN0aXZlLCBTV0lPVExCIHdpbGwgYmUgZm9yY2UgZW5hYmxlZCwNCj4gYW5k
IHRoaXMgaXMgYWxzbyB0cnVlIGZvciBrZHVtcCBrZXJuZWwuIEFzIGEgcmVzdWx0IGtkdW1wIGtl
cm5lbCB3aWxsDQo+IHJ1biBvdXQgb2YgYWxyZWFkeSBzY2FyY2UgcHJlLXJlc2VydmVkIG1lbW9y
eSBlYXNpbHkuDQo+IA0KPiBTbyB3aGVuIFNNRS9TRVYgaXMgYWN0aXZlLCByZXNlcnZlIGV4dHJh
IG1lbW9yeSBmb3IgU1dJT1RMQiB0byBlbnN1cmUNCj4ga2R1bXAga2VybmVsIGhhdmUgZW5vdWdo
IG1lbW9yeSwgZXhjZXB0IHdoZW4gImNyYXNoa2VybmVsPXNpemVbS01HXSxoaWdoIg0KPiBpcyBz
cGVjaWZpZWQgb3IgYW55IG9mZnNldCBpcyB1c2VkLiBBcyBmb3IgdGhlIGhpZ2ggcmVzZXJ2YXRp
b24gY2FzZSwgYW4NCj4gZXh0cmEgbG93IG1lbW9yeSByZWdpb24gd2lsbCBhbHdheXMgYmUgcmVz
ZXJ2ZWQgYW5kIHRoYXQgaXMgZW5vdWdoIGZvcg0KPiBTV0lPVExCLiBFbHNlIGlmIHRoZSBvZmZz
ZXQgZm9ybWF0IGlzIHVzZWQsIHVzZXIgc2hvdWxkIGJlIGZ1bGx5IGF3YXJlDQo+IG9mIGFueSBw
b3NzaWJsZSBrZHVtcCBrZXJuZWwgbWVtb3J5IHJlcXVpcmVtZW50IGFuZCBoYXZlIHRvIG9yZ2Fu
aXplIHRoZQ0KPiBtZW1vcnkgdXNhZ2UgY2FyZWZ1bGx5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
S2FpcnVpIFNvbmcgPGthc29uZ0ByZWRoYXQuY29tPg0KPiAtLS0NCj4gIGFyY2gveDg2L2tlcm5l
bC9zZXR1cC5jIHwgMjYgKysrKysrKysrKysrKysrKysrKysrKystLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAyMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2FyY2gveDg2L2tlcm5lbC9zZXR1cC5jIGIvYXJjaC94ODYva2VybmVsL3NldHVwLmMNCj4gaW5k
ZXggYmJlMzViZjg3OWY1Li5lZDkxZmE5ZDlmNmUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tl
cm5lbC9zZXR1cC5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9zZXR1cC5jDQo+IEBAIC01Mjgs
NyArNTI4LDcgQEAgc3RhdGljIGludCBfX2luaXQgcmVzZXJ2ZV9jcmFzaGtlcm5lbF9sb3codm9p
ZCkNCj4gIA0KPiAgc3RhdGljIHZvaWQgX19pbml0IHJlc2VydmVfY3Jhc2hrZXJuZWwodm9pZCkN
Cj4gIHsNCj4gLQl1bnNpZ25lZCBsb25nIGxvbmcgY3Jhc2hfc2l6ZSwgY3Jhc2hfYmFzZSwgdG90
YWxfbWVtOw0KPiArCXVuc2lnbmVkIGxvbmcgbG9uZyBjcmFzaF9zaXplLCBjcmFzaF9iYXNlLCB0
b3RhbF9tZW0sIG1lbV9lbmNfcmVxOw0KPiAgCWJvb2wgaGlnaCA9IGZhbHNlOw0KPiAgCWludCBy
ZXQ7DQo+ICANCj4gQEAgLTU1MCw2ICs1NTAsMTcgQEAgc3RhdGljIHZvaWQgX19pbml0IHJlc2Vy
dmVfY3Jhc2hrZXJuZWwodm9pZCkNCj4gIAkJcmV0dXJuOw0KPiAgCX0NCj4gIA0KPiArCS8qDQo+
ICsJICogV2hlbiBTTUUvU0VWIGlzIGFjdGl2ZSwgaXQgd2lsbCBhbHdheXMgcmVxdWlyZWQgYW4g
ZXh0cmEgU1dJT1RMQg0KPiArCSAqIHJlZ2lvbi4NCj4gKwkgKi8NCj4gKwlpZiAoc21lX2FjdGl2
ZSgpIHx8IHNldl9hY3RpdmUoKSkgew0KDQpZb3UgY2FuIHVzZSBtZW1fZW5jcnlwdF9hY3RpdmUo
KSBoZXJlIGluIHBsYWNlIG9mIHRoZSB0d28gY2hlY2tzLg0KDQo+ICsJCW1lbV9lbmNfcmVxID0g
QUxJR04oc3dpb3RsYl9zaXplX29yX2RlZmF1bHQoKSwgU1pfMU0pOw0KPiArCQlwcl9pbmZvKCJN
ZW1vcnkgZW5jcnlwdGlvbiBpcyBhY3RpdmUsIGNyYXNoa2VybmVsIG5lZWRzICVsZE1CIGV4dHJh
IG1lbW9yeVxuIiwNCj4gKwkJCQkodW5zaWduZWQgbG9uZykobWVtX2VuY19yZXEgPj4gMjApKTsN
Cg0KVGhlcmUgaXMgYSBwb2ludCBiZWxvdyB3aGVyZSB5b3UgemVybyBvdXQgdGhpcyB2YWx1ZSwg
c28gc2hvdWxkIHRoaXMNCmJlIGlzc3VlZCBsYXRlciBvbmx5IGlmIG1lbV9lbmNfcmVxIGlzIG5v
bi16ZXJvPw0KDQpBbHNvLCBsb29rcyBsaWtlIG9uZSB0b28gbWFueSB0YWJzLg0KDQo+ICsJfSBl
bHNlDQoNClNpbmNlIHlvdSB1c2VkIGJyYWNlcyBvbiB0aGUgaWYgcGF0aCwgeW91IG5lZWQgYnJh
Y2VzIG9uIHRoZSBlbHNlIHBhdGguDQoNClRoYW5rcywNClRvbQ0KDQo+ICsJCW1lbV9lbmNfcmVx
ID0gMDsNCj4gKw0KPiAgCS8qIDAgbWVhbnM6IGZpbmQgdGhlIGFkZHJlc3MgYXV0b21hdGljYWxs
eSAqLw0KPiAgCWlmICghY3Jhc2hfYmFzZSkgew0KPiAgCQkvKg0KPiBAQCAtNTYzLDExICs1NzQs
MTkgQEAgc3RhdGljIHZvaWQgX19pbml0IHJlc2VydmVfY3Jhc2hrZXJuZWwodm9pZCkNCj4gIAkJ
aWYgKCFoaWdoKQ0KPiAgCQkJY3Jhc2hfYmFzZSA9IG1lbWJsb2NrX2ZpbmRfaW5fcmFuZ2UoQ1JB
U0hfQUxJR04sDQo+ICAJCQkJCQlDUkFTSF9BRERSX0xPV19NQVgsDQo+IC0JCQkJCQljcmFzaF9z
aXplLCBDUkFTSF9BTElHTik7DQo+IC0JCWlmICghY3Jhc2hfYmFzZSkNCj4gKwkJCQkJCWNyYXNo
X3NpemUgKyBtZW1fZW5jX3JlcSwNCj4gKwkJCQkJCUNSQVNIX0FMSUdOKTsNCj4gKwkJLyoNCj4g
KwkJICogRm9yIGhpZ2ggcmVzZXJ2YXRpb24sIGFuIGV4dHJhIGxvdyBtZW1vcnkgZm9yIFNXSU9U
TEIgd2lsbA0KPiArCQkgKiBhbHdheXMgYmUgcmVzZXJ2ZWQgbGF0ZXIsIHNvIG5vIG5lZWQgdG8g
cmVzZXJ2ZSBleHRyYQ0KPiArCQkgKiBtZW1vcnkgZm9yIG1lbW9yeSBlbmNyeXB0aW9uIGNhc2Ug
aGVyZS4NCj4gKwkJICovDQo+ICsJCWlmICghY3Jhc2hfYmFzZSkgew0KPiArCQkJbWVtX2VuY19y
ZXEgPSAwOw0KPiAgCQkJY3Jhc2hfYmFzZSA9IG1lbWJsb2NrX2ZpbmRfaW5fcmFuZ2UoQ1JBU0hf
QUxJR04sDQo+ICAJCQkJCQlDUkFTSF9BRERSX0hJR0hfTUFYLA0KPiAgCQkJCQkJY3Jhc2hfc2l6
ZSwgQ1JBU0hfQUxJR04pOw0KPiArCQl9DQo+ICAJCWlmICghY3Jhc2hfYmFzZSkgew0KPiAgCQkJ
cHJfaW5mbygiY3Jhc2hrZXJuZWwgcmVzZXJ2YXRpb24gZmFpbGVkIC0gTm8gc3VpdGFibGUgYXJl
YSBmb3VuZC5cbiIpOw0KPiAgCQkJcmV0dXJuOw0KPiBAQCAtNTgzLDYgKzYwMiw3IEBAIHN0YXRp
YyB2b2lkIF9faW5pdCByZXNlcnZlX2NyYXNoa2VybmVsKHZvaWQpDQo+ICAJCQlyZXR1cm47DQo+
ICAJCX0NCj4gIAl9DQo+ICsJY3Jhc2hfc2l6ZSArPSBtZW1fZW5jX3JlcTsNCj4gIAlyZXQgPSBt
ZW1ibG9ja19yZXNlcnZlKGNyYXNoX2Jhc2UsIGNyYXNoX3NpemUpOw0KPiAgCWlmIChyZXQpIHsN
Cj4gIAkJcHJfZXJyKCIlczogRXJyb3IgcmVzZXJ2aW5nIGNyYXNoa2VybmVsIG1lbWJsb2NrLlxu
IiwgX19mdW5jX18pOw0KPiANCg==
