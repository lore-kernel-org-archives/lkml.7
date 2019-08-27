Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7B7C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81242070B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="O5+oIS0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfH0NnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:43:15 -0400
Received: from mail-eopbgr680048.outbound.protection.outlook.com ([40.107.68.48]:42048
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbfH0NnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:43:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THpqOUKAoPP66a8ST3kVCrgamTO2wQlPzpUPRDzITSPMiNTGYv1o7omeOxW31drhn8KoLNW4vtqLsHQmWTf6ka5v61+reMwef4IZnjibHBAelQ/S3JWd8ozfX/qLNr2MSqGQ7TjmydvppjhraZ65qe9lb5U9YhmBrk5rGZPz5VOYPDFHVzxjumd8UDkZqOxwqwcYgcDh9OWSKsgcOoYPVI9EgyeE1bcm3c8c/163HJzmzG9HDbKUwQDo7Gp7DzHGmthkDrmtEgs3wv+KvQA69jy4E+r/EmsGO9ffJpT2GvtsemcbBzr5JlQRnbLzojR/OW1u2tJpWMRXkrl8OuWJsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8cJtD6NtXhA2AXQd5uLKNOKR3IJuEKELYrG/D2oADo=;
 b=UtDdRu5iVX6J7oqakjDPmCSHvYttsifKgi5pBU1jd/1OT6aQ2cCZQ4HZ9itP9V98+OETiaZtJT2TCTbR1y5Fj02xOHc85rtwWzqo1HXlWABPRDb3TiuFm8zyZqwM7vnpKbB1iNrdgtEg86CZy1eTaYU5XlXxLFh4kKezGYEVOiIaKn5HOc903fs2yE7b/uJPWTEygxydbzQP4E78TPxzexItQVDyTD4etKC80rzsXr66xmzkC/6VYIAkIO4Ai+42fz99rpOh/ukRsB5+jVHvrLU4S0KwtjU+pO4BSx3Dl+MSTSzoMdw+TQ/e4kKAM5X5DX0A+umhVTp6g3Wc/0+ygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8cJtD6NtXhA2AXQd5uLKNOKR3IJuEKELYrG/D2oADo=;
 b=O5+oIS0Wec31B/Srw92r3rLfUUsKyNH29b2z7RHFL2OaXeZdwflCujgmgCOPB2iOr5Xjgpi36D8vIyMm5AXVkHNJRWV7tmq2Q0zvdSz05f8IFJbSelcwO/lqv+fSlHez49H2C3q6EtFwvZd/0UhZAxH6gJ0u7xvhg6aHSnfPlr0=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB2876.namprd12.prod.outlook.com (20.179.71.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Tue, 27 Aug 2019 13:43:10 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::585:2d27:6e06:f9b0]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::585:2d27:6e06:f9b0%7]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 13:43:10 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Kairui Song <kasong@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH v2] x86/kdump: Reserve extra memory when SME or SEV is
 active
Thread-Topic: [PATCH v2] x86/kdump: Reserve extra memory when SME or SEV is
 active
Thread-Index: AQHVW8kp9JVn6hQ7UE6olQKKwzsq7acPAyUA
Date:   Tue, 27 Aug 2019 13:43:10 +0000
Message-ID: <dfb623dd-6c68-14a9-7ef5-ea8c6b5a2567@amd.com>
References: <20190826044535.9646-1-kasong@redhat.com>
In-Reply-To: <20190826044535.9646-1-kasong@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0083.namprd05.prod.outlook.com
 (2603:10b6:803:22::21) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73b46839-5ab8-43b8-2d04-08d72af47ffe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB2876;
x-ms-traffictypediagnostic: DM6PR12MB2876:
x-microsoft-antispam-prvs: <DM6PR12MB2876EACA38571768DF2A24E0ECA00@DM6PR12MB2876.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(199004)(189003)(478600001)(4326008)(8936002)(14444005)(256004)(186003)(6486002)(2501003)(102836004)(6512007)(6246003)(476003)(31686004)(66066001)(305945005)(31696002)(53546011)(446003)(2906002)(86362001)(76176011)(6116002)(6436002)(8676002)(64756008)(110136005)(66556008)(66476007)(26005)(66446008)(66946007)(6506007)(316002)(7736002)(386003)(81156014)(25786009)(52116002)(81166006)(71190400001)(71200400001)(36756003)(14454004)(486006)(53936002)(3846002)(5660300002)(7416002)(11346002)(99286004)(2616005)(229853002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2876;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JSb186GUdXs2sWQHD7SZzYV048xwpmbhnJhkIuH318zwO3b4OjcMYtuMas8U/1IWWX1iZPlx7DOWspPH9wy+GobQXYIttZBA30+SxgaTrH/CLI/jNyA/FlALZdBpqLwhyy4ylIsRZbzaUmYTnTe3wOGIvVT9DY2L1bx0t66VnpoBJrkCc70wvqz/D1s/llaZoMgySsJXtyRAv3BgM/x6H0VKCJ2/9mFmoeP2t7czvDXFq9WXtcyImG3+1o8jxn6fuURwnoJQ7s1cv+F+ahNjpfgygiI2uvAev/hsoZKbiY8LvnvW+BLsMA1XR5iabAZ+qzY0VVjRVElq0/aGH0SBMsMdJCWUutyGk8c40op9yDkFVzbVH1jLWJIe5CfY34QsnA5kb5OUSb9fdecMr34zqp+gCsRWl5agALnujIFFRNI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DC00BA7C27A87489CB7E42FBC4B6659@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b46839-5ab8-43b8-2d04-08d72af47ffe
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 13:43:10.5434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GoqKnIr8MvgNgG4c76G/XYUCMg7fMMWfLecLjj40nxPP4UULDem20vNl5g0ogdOtbh5yufaIZ4rEZhuWAqdmHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2876
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8yNS8xOSAxMTo0NSBQTSwgS2FpcnVpIFNvbmcgd3JvdGU6DQo+IFNpbmNlIGNvbW1pdCBj
Nzc1MzIwOGE5NGMgKCJ4ODYsIHN3aW90bGI6IEFkZCBtZW1vcnkgZW5jcnlwdGlvbiBzdXBwb3J0
IiksDQo+IFNXSU9UTEIgd2lsbCBiZSBlbmFibGVkIGV2ZW4gaWYgdGhlcmUgaXMgbGVzcyB0aGFu
IDRHIG9mIG1lbW9yeSB3aGVuIFNNRQ0KPiBpcyBhY3RpdmUsIHRvIHN1cHBvcnQgRE1BIG9mIGRl
dmljZXMgdGhhdCBub3Qgc3VwcG9ydCBhZGRyZXNzIHdpdGggdGhlDQo+IGVuY3J5cHQgYml0Lg0K
PiANCj4gQW5kIGNvbW1pdCBhYmEyZDlhNjM4NWEgKCJpb21tdS9hbWQ6IERvIG5vdCBkaXNhYmxl
IFNXSU9UTEIgaWYgU01FIGlzDQo+IGFjdGl2ZSIpIG1ha2UgdGhlIGtlcm5lbCBrZWVwIFNXSU9U
TEIgZW5hYmxlZCBldmVuIGlmIHRoZXJlIGlzIGFuIElPTU1VLg0KPiANCj4gVGhlbiBjb21taXQg
ZDdiNDE3ZmEwOGQxICgieDg2L21tOiBBZGQgRE1BIHN1cHBvcnQgZm9yIFNFViBtZW1vcnkNCj4g
ZW5jcnlwdGlvbiIpIHdpbGwgYWx3YXlzIGZvcmNlIFNXSU9UTEIgdG8gYmUgZW5hYmxlZCB3aGVu
IFNFViBpcyBhY3RpdmUNCj4gaW4gYWxsIGNhc2VzLg0KPiANCj4gTm93LCB3aGVuIGVpdGhlciBT
TUUgb3IgU0VWIGlzIGFjdGl2ZSwgU1dJT1RMQiB3aWxsIGJlIGZvcmNlIGVuYWJsZWQsDQo+IGFu
ZCB0aGlzIGlzIGFsc28gdHJ1ZSBmb3Iga2R1bXAga2VybmVsLiBBcyBhIHJlc3VsdCBrZHVtcCBr
ZXJuZWwgd2lsbA0KPiBydW4gb3V0IG9mIGFscmVhZHkgc2NhcmNlIHByZS1yZXNlcnZlZCBtZW1v
cnkgZWFzaWx5Lg0KPiANCj4gU28gd2hlbiBTTUUvU0VWIGlzIGFjdGl2ZSwgcmVzZXJ2ZSBleHRy
YSBtZW1vcnkgZm9yIFNXSU9UTEIgdG8gZW5zdXJlDQo+IGtkdW1wIGtlcm5lbCBoYXZlIGVub3Vn
aCBtZW1vcnksIGV4Y2VwdCB3aGVuICJjcmFzaGtlcm5lbD1zaXplW0tNR10saGlnaCINCj4gaXMg
c3BlY2lmaWVkIG9yIGFueSBvZmZzZXQgaXMgdXNlZC4gQXMgZm9yIHRoZSBoaWdoIHJlc2VydmF0
aW9uIGNhc2UsIGFuDQo+IGV4dHJhIGxvdyBtZW1vcnkgcmVnaW9uIHdpbGwgYWx3YXlzIGJlIHJl
c2VydmVkIGFuZCB0aGF0IGlzIGVub3VnaCBmb3INCj4gU1dJT1RMQi4gRWxzZSBpZiB0aGUgb2Zm
c2V0IGZvcm1hdCBpcyB1c2VkLCB1c2VyIHNob3VsZCBiZSBmdWxseSBhd2FyZQ0KPiBvZiBhbnkg
cG9zc2libGUga2R1bXAga2VybmVsIG1lbW9yeSByZXF1aXJlbWVudCBhbmQgaGF2ZSB0byBvcmdh
bml6ZSB0aGUNCj4gbWVtb3J5IHVzYWdlIGNhcmVmdWxseS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEthaXJ1aSBTb25nIDxrYXNvbmdAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFRvbSBMZW5k
YWNreSA8dGhvbWFzLmxlbmRhY2t5QGFtZC5jb20+DQoNCj4gDQo+IC0tLQ0KPiBVcGRhdGUgZnJv
bSBWMToNCj4gLSBVc2UgbWVtX2VuY3J5cHRfYWN0aXZlKCkgaW5zdGVhZCBvZiAic21lX2FjdGl2
ZSgpIHx8IHNldl9hY3RpdmUoKSINCj4gLSBEb24ndCByZXNlcnZlIGV4dHJhIG1lbW9yeSB3aGVu
ICIsaGlnaCIgb3IgIkBvZmZzZXQiIGlzIHVzZWQsIGFuZA0KPiAgIGRvbid0IHByaW50IHJlZHVu
ZGFudCBtZXNzYWdlLg0KPiAtIEZpeCBjb2Rpbmcgc3R5bGUgcHJvYmxlbQ0KPiANCj4gIGFyY2gv
eDg2L2tlcm5lbC9zZXR1cC5jIHwgMzEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3NldHVwLmMgYi9hcmNoL3g4Ni9rZXJuZWwv
c2V0dXAuYw0KPiBpbmRleCBiYmUzNWJmODc5ZjUuLjIyMWJlYjEwYzU1ZCAxMDA2NDQNCj4gLS0t
IGEvYXJjaC94ODYva2VybmVsL3NldHVwLmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL3NldHVw
LmMNCj4gQEAgLTUyOCw3ICs1MjgsNyBAQCBzdGF0aWMgaW50IF9faW5pdCByZXNlcnZlX2NyYXNo
a2VybmVsX2xvdyh2b2lkKQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBfX2luaXQgcmVzZXJ2ZV9jcmFz
aGtlcm5lbCh2b2lkKQ0KPiAgew0KPiAtCXVuc2lnbmVkIGxvbmcgbG9uZyBjcmFzaF9zaXplLCBj
cmFzaF9iYXNlLCB0b3RhbF9tZW07DQo+ICsJdW5zaWduZWQgbG9uZyBsb25nIGNyYXNoX3NpemUs
IGNyYXNoX2Jhc2UsIHRvdGFsX21lbSwgbWVtX2VuY19yZXE7DQo+ICAJYm9vbCBoaWdoID0gZmFs
c2U7DQo+ICAJaW50IHJldDsNCj4gIA0KPiBAQCAtNTUwLDYgKzU1MCwxNSBAQCBzdGF0aWMgdm9p
ZCBfX2luaXQgcmVzZXJ2ZV9jcmFzaGtlcm5lbCh2b2lkKQ0KPiAgCQlyZXR1cm47DQo+ICAJfQ0K
PiAgDQo+ICsJLyoNCj4gKwkgKiBXaGVuIFNNRS9TRVYgaXMgYWN0aXZlLCBpdCB3aWxsIGFsd2F5
cyByZXF1aXJlZCBhbiBleHRyYSBTV0lPVExCDQo+ICsJICogcmVnaW9uLg0KPiArCSAqLw0KPiAr
CWlmIChtZW1fZW5jcnlwdF9hY3RpdmUoKSkNCj4gKwkJbWVtX2VuY19yZXEgPSBBTElHTihzd2lv
dGxiX3NpemVfb3JfZGVmYXVsdCgpLCBTWl8xTSk7DQo+ICsJZWxzZQ0KPiArCQltZW1fZW5jX3Jl
cSA9IDA7DQo+ICsNCj4gIAkvKiAwIG1lYW5zOiBmaW5kIHRoZSBhZGRyZXNzIGF1dG9tYXRpY2Fs
bHkgKi8NCj4gIAlpZiAoIWNyYXNoX2Jhc2UpIHsNCj4gIAkJLyoNCj4gQEAgLTU2MywxMSArNTcy
LDE5IEBAIHN0YXRpYyB2b2lkIF9faW5pdCByZXNlcnZlX2NyYXNoa2VybmVsKHZvaWQpDQo+ICAJ
CWlmICghaGlnaCkNCj4gIAkJCWNyYXNoX2Jhc2UgPSBtZW1ibG9ja19maW5kX2luX3JhbmdlKENS
QVNIX0FMSUdOLA0KPiAgCQkJCQkJQ1JBU0hfQUREUl9MT1dfTUFYLA0KPiAtCQkJCQkJY3Jhc2hf
c2l6ZSwgQ1JBU0hfQUxJR04pOw0KPiAtCQlpZiAoIWNyYXNoX2Jhc2UpDQo+ICsJCQkJCQljcmFz
aF9zaXplICsgbWVtX2VuY19yZXEsDQo+ICsJCQkJCQlDUkFTSF9BTElHTik7DQo+ICsJCS8qDQo+
ICsJCSAqIEZvciBoaWdoIHJlc2VydmF0aW9uLCBhbiBleHRyYSBsb3cgbWVtb3J5IGZvciBTV0lP
VExCIHdpbGwNCj4gKwkJICogYWx3YXlzIGJlIHJlc2VydmVkIGxhdGVyLCBzbyBubyBuZWVkIHRv
IHJlc2VydmUgZXh0cmENCj4gKwkJICogbWVtb3J5IGZvciBtZW1vcnkgZW5jcnlwdGlvbiBjYXNl
IGhlcmUuDQo+ICsJCSAqLw0KPiArCQlpZiAoIWNyYXNoX2Jhc2UpIHsNCj4gKwkJCW1lbV9lbmNf
cmVxID0gMDsNCj4gIAkJCWNyYXNoX2Jhc2UgPSBtZW1ibG9ja19maW5kX2luX3JhbmdlKENSQVNI
X0FMSUdOLA0KPiAgCQkJCQkJQ1JBU0hfQUREUl9ISUdIX01BWCwNCj4gIAkJCQkJCWNyYXNoX3Np
emUsIENSQVNIX0FMSUdOKTsNCj4gKwkJfQ0KPiAgCQlpZiAoIWNyYXNoX2Jhc2UpIHsNCj4gIAkJ
CXByX2luZm8oImNyYXNoa2VybmVsIHJlc2VydmF0aW9uIGZhaWxlZCAtIE5vIHN1aXRhYmxlIGFy
ZWEgZm91bmQuXG4iKTsNCj4gIAkJCXJldHVybjsNCj4gQEAgLTU3NSw2ICs1OTIsNyBAQCBzdGF0
aWMgdm9pZCBfX2luaXQgcmVzZXJ2ZV9jcmFzaGtlcm5lbCh2b2lkKQ0KPiAgCX0gZWxzZSB7DQo+
ICAJCXVuc2lnbmVkIGxvbmcgbG9uZyBzdGFydDsNCj4gIA0KPiArCQltZW1fZW5jX3JlcSA9IDA7
DQo+ICAJCXN0YXJ0ID0gbWVtYmxvY2tfZmluZF9pbl9yYW5nZShjcmFzaF9iYXNlLA0KPiAgCQkJ
CQkgICAgICAgY3Jhc2hfYmFzZSArIGNyYXNoX3NpemUsDQo+ICAJCQkJCSAgICAgICBjcmFzaF9z
aXplLCAxIDw8IDIwKTsNCj4gQEAgLTU4Myw2ICs2MDEsMTMgQEAgc3RhdGljIHZvaWQgX19pbml0
IHJlc2VydmVfY3Jhc2hrZXJuZWwodm9pZCkNCj4gIAkJCXJldHVybjsNCj4gIAkJfQ0KPiAgCX0N
Cj4gKw0KPiArCWlmIChtZW1fZW5jX3JlcSkgew0KPiArCQlwcl9pbmZvKCJNZW1vcnkgZW5jcnlw
dGlvbiBpcyBhY3RpdmUsIGNyYXNoa2VybmVsIG5lZWRzICVsZE1CIGV4dHJhIG1lbW9yeVxuIiwN
Cj4gKwkJCSh1bnNpZ25lZCBsb25nKShtZW1fZW5jX3JlcSA+PiAyMCkpOw0KPiArCQljcmFzaF9z
aXplICs9IG1lbV9lbmNfcmVxOw0KPiArCX0NCj4gKw0KPiAgCXJldCA9IG1lbWJsb2NrX3Jlc2Vy
dmUoY3Jhc2hfYmFzZSwgY3Jhc2hfc2l6ZSk7DQo+ICAJaWYgKHJldCkgew0KPiAgCQlwcl9lcnIo
IiVzOiBFcnJvciByZXNlcnZpbmcgY3Jhc2hrZXJuZWwgbWVtYmxvY2suXG4iLCBfX2Z1bmNfXyk7
DQo+IA0K
