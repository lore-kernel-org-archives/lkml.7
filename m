Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979C8C06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 10:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D16C218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 10:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kVdjzg7N";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="aPsJJBA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfGDKh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 06:37:26 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:27396 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727385AbfGDKhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 06:37:25 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x64AZ41P026705;
        Thu, 4 Jul 2019 03:37:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=xCvCGwtX95qFHWhkAdmeugVBg4xpRyAdODhU5SpQ5wk=;
 b=kVdjzg7NiZP6ZKCxhaFd9FrvI5zypYyHsPG/jMicf3HVpt0YlrB1RKO8mEy/fAUkf4Xl
 p4IMkSfGceH13nyFldAWwiNjgLFqW2UkbEhye81eDPe/xEeXObs6+EgLUmhA/LB+lSgK
 vOe1sTmwHlznc2IKMbpdk8LfKFATxU6FJoGr1jfh+SbGEWMlBdKyvWJQsK6uwSstfP9z
 NbukgTZ/s7e0Q9b7cKgMwj5vxUg8fbeIIOTb6AhRMPYj9/JF/1hEFwuIjPdzUd9HZU7P
 i0EQ9nK/3pOW8qUk/mLfn0jFfjXNN6tqn/ZntOMaV214BHx/uJeIOWX7K04HyvTGRecX Qw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2th9481k0y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 04 Jul 2019 03:37:04 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 4 Jul
 2019 03:37:02 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.57) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 4 Jul 2019 03:37:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCvCGwtX95qFHWhkAdmeugVBg4xpRyAdODhU5SpQ5wk=;
 b=aPsJJBA97RwUllSG6ahDJ12vTpJg3lz/8O3OQBUu1S4enSmPfJ8yPLVErPtUFzNII94admA2F9vzfs/kKzvfU9AzhR13CO9lURkFgZAJJY6ua+riI5Y2sV05nzds1wwY8XmRdYSVRkuyrsODnxGgK7rgDjqDKpVTtIWh6TyVwRQ=
Received: from MN2PR18MB3055.namprd18.prod.outlook.com (20.178.255.209) by
 MN2PR18MB2384.namprd18.prod.outlook.com (20.179.80.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Thu, 4 Jul 2019 10:36:58 +0000
Received: from MN2PR18MB3055.namprd18.prod.outlook.com
 ([fe80::9574:8e34:cd99:788f]) by MN2PR18MB3055.namprd18.prod.outlook.com
 ([fe80::9574:8e34:cd99:788f%4]) with mapi id 15.20.2032.019; Thu, 4 Jul 2019
 10:36:58 +0000
From:   Shijith Thotton <sthotton@marvell.com>
To:     Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Jayachandran Chandrasekharan Nair" <jnair@marvell.com>,
        Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        Jan Glauber <jglauber@marvell.com>,
        Robert Richter <rrichter@marvell.com>
Subject: Re: [PATCH] genirq: update irq stats from NMI handlers
Thread-Topic: [PATCH] genirq: update irq stats from NMI handlers
Thread-Index: AQHVMiAiVz/XkkYfRk2+vKGjBsT7x6a6C8+AgAA4f4A=
Date:   Thu, 4 Jul 2019 10:36:57 +0000
Message-ID: <a4ce3800-22f4-72dc-6ff8-75dfed1c377b@marvell.com>
References: <1562214115-14022-1-git-send-email-sthotton@marvell.com>
 <6adfb296-50f1-9efb-0840-cc8732b8ebf9@arm.com>
In-Reply-To: <6adfb296-50f1-9efb-0840-cc8732b8ebf9@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:a03:180::18) To MN2PR18MB3055.namprd18.prod.outlook.com
 (2603:10b6:208:ff::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.233.59.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fb5dc59-67b0-4a88-3526-08d7006b8a42
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2384;
x-ms-traffictypediagnostic: MN2PR18MB2384:
x-microsoft-antispam-prvs: <MN2PR18MB2384FAB468FF124168143408D9FA0@MN2PR18MB2384.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(346002)(376002)(366004)(136003)(199004)(189003)(3846002)(4326008)(256004)(6116002)(6512007)(31686004)(486006)(11346002)(68736007)(66556008)(66476007)(66946007)(73956011)(64756008)(66446008)(6246003)(76176011)(186003)(478600001)(99286004)(229853002)(14444005)(25786009)(386003)(6506007)(53546011)(6486002)(14454004)(86362001)(31696002)(6436002)(2906002)(446003)(7736002)(305945005)(71200400001)(66066001)(71190400001)(81156014)(81166006)(8936002)(107886003)(8676002)(36756003)(102836004)(2616005)(476003)(316002)(5660300002)(54906003)(52116002)(26005)(110136005)(53936002)(15650500001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2384;H:MN2PR18MB3055.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5ps7b0H6YW2eH3AS7qvZ2ypdGEuHYqzxFdU72yt15p6G21gmcmTLDLTpUx9JByRVc7WVNPya1HKy8k9eN15Ei56HiKQlsX1RuRM9uAeyH7ZXeNxKC9tm3+Dgi6SSqx1GQiNqFXorQccdIe1Rny+5bF25ifz4vhSbtvyWLh+AWNpItGe6qYuDpbeNVI+tRtT5qfg714Bdvi2H2H7L7d0XB3/cCzP/U3B0kkvUJ9uRoyA0WjyggT0t9XgHktPCxFgaC6FpWNRCjjpid3JsCnSYGKd3s9Nk5q7ZdtJRgHsGSUcWnr5gXPR8Fi9OVP74gz0un4cDRxCxGEmyCXQlw39mlq75LBzVdBXZkgQ7mecxQHb47arItOnlbx2vJ7rTSI7JrG11zYtGT7Hrs3ZhVFupyQOFa8iPYv4A7v+T98IGEfU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <725FCB043436864D9D650E1D4405B889@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb5dc59-67b0-4a88-3526-08d7006b8a42
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 10:36:58.0468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sthotton@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2384
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-04_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBKdWxpZW4sDQoNCk9uIDcvNC8xOSAxMjoxMyBBTSwgSnVsaWVuIFRoaWVycnkgd3JvdGU6
DQo+IE9uIDA0LzA3LzIwMTkgMDU6MjIsIFNoaWppdGggVGhvdHRvbiB3cm90ZToNCj4+IFRoZSBO
TUkgaGFuZGxlcnMgaGFuZGxlX3BlcmNwdV9kZXZpZF9mYXN0ZW9pX25taSgpIGFuZA0KPj4gaGFu
ZGxlX2Zhc3Rlb2lfbm1pKCkgYWRkZWQgYnkgY29tbWl0IDJkY2YxZmJjYWQzNSAoImdlbmlycTog
UHJvdmlkZSBOTUkNCj4+IGhhbmRsZXJzIikgZG8gbm90IHVwZGF0ZSB0aGUgaW50ZXJydXB0IGNv
dW50cy4gRHVlIHRvIHRoYXQgdGhlIE5NSQ0KPj4gaW50ZXJydXB0IGNvdW50IGRvZXMgbm90IHNo
b3cgdXAgY29ycmVjdGx5IGluIC9wcm9jL2ludGVycnVwdHMuDQo+Pg0KPj4gVXBkYXRlIHRoZSBm
dW5jdGlvbnMgdG8gZml4IHRoaXMuIFdpdGggdGhpcyBjaGFuZ2UsIHdlIGNhbiBzZWUgc3RhdHMg
b2YNCj4+IHRoZSBwZXJmIE5NSSBpbnRlcnJ1cHRzIG9uIGFybTY0Lg0KPj4NCj4+IEZpeGVzOiAy
ZGNmMWZiY2FkMzUgKCJnZW5pcnE6IFByb3ZpZGUgTk1JIGhhbmRsZXJzIikNCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBTaGlqaXRoIFRob3R0b24gPHN0aG90dG9uQG1hcnZlbGwuY29tPg0KPj4gLS0t
DQo+PiAgIGtlcm5lbC9pcnEvY2hpcC5jIHwgNCArKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEva2VybmVsL2lycS9jaGlwLmMgYi9r
ZXJuZWwvaXJxL2NoaXAuYw0KPj4gaW5kZXggMjlkNmM3ZDA3MGI0Li44OGQxZTA1NGM2ZWEgMTAw
NjQ0DQo+PiAtLS0gYS9rZXJuZWwvaXJxL2NoaXAuYw0KPj4gKysrIGIva2VybmVsL2lycS9jaGlw
LmMNCj4+IEBAIC03NDgsNiArNzQ4LDggQEAgdm9pZCBoYW5kbGVfZmFzdGVvaV9ubWkoc3RydWN0
IGlycV9kZXNjICpkZXNjKQ0KPj4gICAJdW5zaWduZWQgaW50IGlycSA9IGlycV9kZXNjX2dldF9p
cnEoZGVzYyk7DQo+PiAgIAlpcnFyZXR1cm5fdCByZXM7DQo+PiAgIA0KPj4gKwlrc3RhdF9pbmNy
X2lycXNfdGhpc19jcHUoZGVzYyk7DQo+PiArDQo+IA0KPiBUaGlzIG5lZWRzIHRvIGJlIGNhbGxl
ZCB3aXRoIHRoZSBkZXNjIGxvY2sgdGFrZW4sIG90aGVyd2lzZSB3ZSdyZSBsaWtlbHkNCj4gdG8g
Y29ycnVwdCBkZXNjLT50b3RfY291bnQuDQo+IEJ1dCB0YWtpbmcgdGhlIGRlc2MgbG9jayBpcyBz
b21ldGhpbmcgd2UgY2FuJ3QgZG8gaW4gTk1JIGNvbnRleHQgKA0KPiAqc3Bpbl9sb2NrX2lycSoo
KSB3b24ndCBwcmV2ZW50IGFuIE5NSSBmcm9tIGhhcHBlbmluZykuDQo+IA0KPj4gICAJdHJhY2Vf
aXJxX2hhbmRsZXJfZW50cnkoaXJxLCBhY3Rpb24pOw0KPj4gICAJLyoNCj4+ICAgCSAqIE5NSXMg
Y2Fubm90IGJlIHNoYXJlZCwgdGhlcmUgaXMgb25seSBvbmUgYWN0aW9uLg0KPj4gQEAgLTk2Miw2
ICs5NjQsOCBAQCB2b2lkIGhhbmRsZV9wZXJjcHVfZGV2aWRfZmFzdGVvaV9ubWkoc3RydWN0IGly
cV9kZXNjICpkZXNjKQ0KPj4gICAJdW5zaWduZWQgaW50IGlycSA9IGlycV9kZXNjX2dldF9pcnEo
ZGVzYyk7DQo+PiAgIAlpcnFyZXR1cm5fdCByZXM7DQo+PiAgIA0KPj4gKwlfX2tzdGF0X2luY3Jf
aXJxc190aGlzX2NwdShkZXNjKTsNCj4+ICsNCj4gDQo+IExvb2tpbmcgYXQgaGFuZGxlX3BlcmNw
dV9pcnEoKSwgSSB0aGluayB0aGlzIG1pZ2h0IGJlIGFjY2VwdGFibGUuIEJ1dA0KPiBkb2VzIGl0
IG1ha2Ugc2Vuc2UgdG8gb25seSBoYXZlIGtzdGF0cyBmb3IgcGVyY3B1IE5NSXM/DQo+IA0KDQpJ
dCB3b3VsZCBiZSBiZXR0ZXIgdG8gaGF2ZSBzdGF0cyBmb3IgYm90aC4NCg0KaGFuZGxlX2Zhc3Rl
b2lfbm1pKCkgY2FuIHVzZSBfX2tzdGF0X2luY3JfaXJxc190aGlzX2NwdSgpIGlmIGJlbG93IA0K
Y2hhbmdlIGNhbiBiZSBhZGRlZCB0byBrc3RhdF9pcnFzX2NwdSgpLg0KDQpkaWZmIC0tZ2l0IGEv
a2VybmVsL2lycS9pcnFkZXNjLmMgYi9rZXJuZWwvaXJxL2lycWRlc2MuYw0KaW5kZXggYTkyYjMz
NTkzYjhkLi45NDg0ZTg4ZGFiYzIgMTAwNjQ0DQotLS0gYS9rZXJuZWwvaXJxL2lycWRlc2MuYw0K
KysrIGIva2VybmVsL2lycS9pcnFkZXNjLmMNCkBAIC05NTAsNiArOTUwLDExIEBAIHVuc2lnbmVk
IGludCBrc3RhdF9pcnFzX2NwdSh1bnNpZ25lZCBpbnQgaXJxLCBpbnQgY3B1KQ0KICAgICAgICAg
ICAgICAgICAgICAgICAgICpwZXJfY3B1X3B0cihkZXNjLT5rc3RhdF9pcnFzLCBjcHUpIDogMDsN
CiAgfQ0KDQorc3RhdGljIGJvb2wgaXJxX2lzX25taShzdHJ1Y3QgaXJxX2Rlc2MgKmRlc2MpDQor
ew0KKyAgICAgICByZXR1cm4gZGVzYy0+aXN0YXRlICYgSVJRU19OTUk7DQorfQ0KKw0KICAvKioN
CiAgICoga3N0YXRfaXJxcyAtIEdldCB0aGUgc3RhdGlzdGljcyBmb3IgYW4gaW50ZXJydXB0DQog
ICAqIEBpcnE6ICAgICAgIFRoZSBpbnRlcnJ1cHQgbnVtYmVyDQpAQCAtOTY3LDcgKzk3Miw4IEBA
IHVuc2lnbmVkIGludCBrc3RhdF9pcnFzKHVuc2lnbmVkIGludCBpcnEpDQogICAgICAgICBpZiAo
IWRlc2MgfHwgIWRlc2MtPmtzdGF0X2lycXMpDQogICAgICAgICAgICAgICAgIHJldHVybiAwOw0K
ICAgICAgICAgaWYgKCFpcnFfc2V0dGluZ3NfaXNfcGVyX2NwdV9kZXZpZChkZXNjKSAmJg0KLSAg
ICAgICAgICAgIWlycV9zZXR0aW5nc19pc19wZXJfY3B1KGRlc2MpKQ0KKyAgICAgICAgICAgIWly
cV9zZXR0aW5nc19pc19wZXJfY3B1KGRlc2MpICYmDQorICAgICAgICAgICAhaXJxX2lzX25taShk
ZXNjKSkNCiAgICAgICAgICAgICByZXR1cm4gZGVzYy0+dG90X2NvdW50Ow0KDQogICAgICAgICBm
b3JfZWFjaF9wb3NzaWJsZV9jcHUoY3B1KQ0KDQoNClRob21hcywNClBsZWFzZSBzdWdnZXN0IGEg
YmV0dGVyIHdheSBpZiBhbnkuDQoNClRoYW5rcywNClNoaWppdGgNCg==
