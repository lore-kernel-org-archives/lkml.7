Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75ACC32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 09:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76E2217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 09:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JxRuNX+a";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="g9dW4xPU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfHJJVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 05:21:54 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1947 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfHJJVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 05:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565428916; x=1596964916;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nq80LNW7DhXGMCAdXpekJAQrq2OMYlB12qsUM0dKL9Y=;
  b=JxRuNX+atbBID65Oc1WWvDGT0RnyUvXQa3FOMjZ9ypurq3RRKc2mTKIk
   sGlm5npsPVuTGYazql/ErCX3aN5H40pt7aO6UQbvWDPC9U9IFhrP1hXgu
   tUZzRahgHKPuLdxwJU1oS8joGIdoYtJ4v1S5E6DawZla6nSPeUMnS00ZD
   R9hipaqlCzpk6ng31XkH/8fcRQrJ7oD/B/ZId99aHAf0oMEd9XxMP7Z67
   inAM6tmA6JgcnDoEIZXAe5pmIqKgOcLYktHLI2aXKvRHZlT8fus58Ytbm
   tsEktvLsEfUHoNIaOQAVBtquR4FjVGEyen9g1bQHRzhkhkofvbj5bj8fD
   Q==;
IronPort-SDR: g89YXIAn96sf/RKAY8xBjSUonlnIPZksY40oLBeR9AQIrKP7SWlK5qu97iLNi8Hh4Vi9N+So1+
 fYG7dHNxTN8D/NUHtnTRnOAiaxQYB4V5anLDLEZm7xD7Car94fVYe+tHNSEtclR736psDiRZKs
 OooYHJCuluE2brz7vfiFm8tLkoV+UBBh5Fbp6N4FiFrKKXeGR0m5XptFbIOL08zueQ51q4G5Y1
 oSt/NOYJeGZT0V/Na/2iFL0/B0xlMHUu3g0Bc3gC1b47cZNS5IKdgVobS4Lc1ZPZ+CZAmnEzps
 fw8=
X-IronPort-AV: E=Sophos;i="5.64,368,1559491200"; 
   d="scan'208";a="215858319"
Received: from mail-co1nam05lp2052.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.52])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2019 17:22:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8/SlA6culrJWRXxkBnxGNsYJooa++I9sJl//VJSfGyZKEt+M03Cag9vyM/sMxCFGpMt6Sbs3y6DPPQuloTUltEHIjLGRvt3cOs85F3aOI8lk3s2TdpFUPa/LpkMM7rIqkMXdTf8dqieC40e8Ex4UGgWWeYmlmsqVIIHdDWnm6cusrzhDG4jnTGhAflFvrKt97k0gWBFKOIJdLkrKpVwodlcarKvhij9SFrH35/XaXX1KPURHxTJeyjCczSKKhsz64JgqWAvpmRqAqc6h0mH6138darFX0vWbmDbScC7ATRg6V+QWj/rr38dVIxRfcBP9eMR9/f1bFiAcjsAwcTtYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nq80LNW7DhXGMCAdXpekJAQrq2OMYlB12qsUM0dKL9Y=;
 b=OtW0IBHSWbggTyBB1HpMKnOThdWdFD/C9b5yf8/+ZXUf/ZkWotofuRfq1gd4B8hXZNAcjzMpYUdwyhAfxwgmo3Hr2SoohJ2UD4rZxCemduQOUdjqAYT5/xqj/BgsERwRXWuF/+vKmiPCx/DDD2eTiup9bvtWnuiySksAgwP3IK2laLxdy5vQO7ipLEoFOExoTQROLDJuiceZiu4IGPXu82zJ0bcgnlIMurDsio1jHtHFpgO1FViY4MuTfqT5Aaquy/pp4JX80tIZMYFRhl4vXoMjDNmH+FrhRUDGZ2TIJs8VqayAHEMoVbt/T7SfpKF/Dlx40AUpLKvt4HC4O2hbfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nq80LNW7DhXGMCAdXpekJAQrq2OMYlB12qsUM0dKL9Y=;
 b=g9dW4xPUlHUCh0HjOw/zQWKufUMfvVHyMIVVW8FRRa9oKSmIG8UPQcbA2pdz007cyGTYE0F3VeFAb3wr8wz8gapgmd4F3KxU/xmdQ5TiZggQ4Wqvyk9p5uQox/MWMZtcCZhaJCVJnMDCAiFoiURsVp1rQu3+KWgw3aG7yfLlfSY=
Received: from BYAPR04MB3782.namprd04.prod.outlook.com (52.135.214.142) by
 BYAPR04MB4744.namprd04.prod.outlook.com (52.135.240.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.13; Sat, 10 Aug 2019 09:21:46 +0000
Received: from BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::ac9a:967e:70a5:e926]) by BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::ac9a:967e:70a5:e926%7]) with mapi id 15.20.2115.005; Sat, 10 Aug 2019
 09:21:46 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: Re: [PATCH] RISC-V: Issue a local tlb flush if possible.
Thread-Topic: [PATCH] RISC-V: Issue a local tlb flush if possible.
Thread-Index: AQHVTxz5XkoGRRVrekixM0/zCIcSeKbzpnuA
Date:   Sat, 10 Aug 2019 09:21:45 +0000
Message-ID: <4427A786-AFC7-4A62-B07B-2EB6C76A24F2@wdc.com>
References: <20190810014309.20838-1-atish.patra@wdc.com>
In-Reply-To: <20190810014309.20838-1-atish.patra@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [2601:646:8280:fdf0:e052:7623:d31b:9c5c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc163db8-c831-4eee-7afe-08d71d742a84
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4744;
x-ms-traffictypediagnostic: BYAPR04MB4744:
x-microsoft-antispam-prvs: <BYAPR04MB47446DF19DD52C448F885606FAD10@BYAPR04MB4744.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 012570D5A0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(199004)(189003)(102836004)(6486002)(486006)(33656002)(2501003)(71200400001)(86362001)(6436002)(6512007)(446003)(478600001)(71190400001)(46003)(6916009)(8676002)(6116002)(256004)(2616005)(53936002)(5660300002)(5640700003)(2351001)(476003)(11346002)(186003)(66476007)(66946007)(76116006)(8936002)(6246003)(66446008)(14454004)(99286004)(54906003)(7736002)(305945005)(81166006)(81156014)(36756003)(316002)(2906002)(25786009)(229853002)(76176011)(4326008)(64756008)(6506007)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4744;H:BYAPR04MB3782.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BTssZcmF6IHEAtkVc9OQdddVugtcrhG+rMFQYssFhmWeQulRIHQuu/XdOJrEV1HTByNt+SbKN/EyGnHyQ7YcPuaTLNZb7IAbkN44OE0HdDZYaDI8dqoNvCR29VzC3OmI3qo6CHj4H2tj/0KewzF1EKmrgyhlWxmCL6Ox15imMroZeemBiP5+CNQCp9e8RIS1cwjQLafZE6NzlKWC8sLlyklFkGwpST5c4cAEe4mOuKI5epf2pyod0mIE8kqqE8Z/uewwcVvf/oew6K8PvOQ4xg+MPHpQLKiZAGVqPci4OtyYc1Xcee7jZeG6SVuSeL1ecazVSjMGwT+1b3fvc6hz2O7GH4lFZl1vPLBlXpxzqJpOjmlaF+Qx3xZuqBOXtU//FWvXiV0T5LUlNBdggODntvYr7jwhgXeO4q5I3Jj2PZw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43DC406DD858764FA09A7A924DB2B90A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc163db8-c831-4eee-7afe-08d71d742a84
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2019 09:21:46.0123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Atish.Patra@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDgvOS8xOSwgNjo0MyBQTSwgIkF0aXNoIFBhdHJhIiA8QXRpc2guUGF0cmFAd2Rj
LmNvbT4gd3JvdGU6DQoNCiAgICBJbiBSSVNDLVYsIHRsYiBmbHVzaCBoYXBwZW5zIHZpYSBTQkkg
d2hpY2ggaXMgZXhwZW5zaXZlLg0KICAgIElmIHRoZSB0YXJnZXQgY3B1bWFzayBjb250YWlucyBh
IGxvY2FsIGhhcnRpZCwgc29tZSBjb3N0DQogICAgY2FuIGJlIHNhdmVkIGJ5IGlzc3VpbmcgYSBs
b2NhbCB0bGIgZmx1c2ggYXMgd2UgZG8gdGhhdA0KICAgIGluIE9wZW5TQkkgYW55d2F5cy4NCiAg
ICANCiAgICBTaWduZWQtb2ZmLWJ5OiBBdGlzaCBQYXRyYSA8YXRpc2gucGF0cmFAd2RjLmNvbT4N
CiAgICAtLS0NCiAgICAgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS90bGJmbHVzaC5oIHwgMzMgKysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KICAgICAxIGZpbGUgY2hhbmdlZCwgMjkgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCiAgICANCiAgICBkaWZmIC0tZ2l0IGEvYXJjaC9y
aXNjdi9pbmNsdWRlL2FzbS90bGJmbHVzaC5oIGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS90bGJm
bHVzaC5oDQogICAgaW5kZXggNjg3ZGQxOTczNWE3Li5iMzJiYTRmYTU4ODggMTAwNjQ0DQogICAg
LS0tIGEvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS90bGJmbHVzaC5oDQogICAgKysrIGIvYXJjaC9y
aXNjdi9pbmNsdWRlL2FzbS90bGJmbHVzaC5oDQogICAgQEAgLTgsNiArOCw3IEBADQogICAgICNk
ZWZpbmUgX0FTTV9SSVNDVl9UTEJGTFVTSF9IDQogICAgIA0KICAgICAjaW5jbHVkZSA8bGludXgv
bW1fdHlwZXMuaD4NCiAgICArI2luY2x1ZGUgPGxpbnV4L3NjaGVkLmg+DQogICAgICNpbmNsdWRl
IDxhc20vc21wLmg+DQogICAgIA0KICAgICAvKg0KICAgIEBAIC00NiwxNCArNDcsMzggQEAgc3Rh
dGljIGlubGluZSB2b2lkIHJlbW90ZV9zZmVuY2Vfdm1hKHN0cnVjdCBjcHVtYXNrICpjbWFzaywg
dW5zaWduZWQgbG9uZyBzdGFydCwNCiAgICAgCQkJCSAgICAgdW5zaWduZWQgbG9uZyBzaXplKQ0K
ICAgICB7DQogICAgIAlzdHJ1Y3QgY3B1bWFzayBobWFzazsNCiAgICArCXN0cnVjdCBjcHVtYXNr
IHRtYXNrOw0KICAgICsJaW50IGNwdWlkID0gc21wX3Byb2Nlc3Nvcl9pZCgpOw0KICAgICANCiAg
ICAgCWNwdW1hc2tfY2xlYXIoJmhtYXNrKTsNCiAgICAtCXJpc2N2X2NwdWlkX3RvX2hhcnRpZF9t
YXNrKGNtYXNrLCAmaG1hc2spOw0KICAgIC0Jc2JpX3JlbW90ZV9zZmVuY2Vfdm1hKGhtYXNrLmJp
dHMsIHN0YXJ0LCBzaXplKTsNCiAgICArCWNwdW1hc2tfY2xlYXIoJnRtYXNrKTsNCiAgICArDQog
ICAgKwlpZiAoY21hc2spDQogICAgKwkJY3B1bWFza19jb3B5KCZ0bWFzaywgY21hc2spOw0KICAg
ICsJZWxzZQ0KICAgICsJCWNwdW1hc2tfY29weSgmdG1hc2ssIGNwdV9vbmxpbmVfbWFzayk7DQog
ICAgKw0KICAgICsJaWYgKGNwdW1hc2tfdGVzdF9jcHUoY3B1aWQsICZ0bWFzaykpIHsNCiAgICAr
CQkvKiBTYXZlIHRyYXAgY29zdCBieSBpc3N1aW5nIGEgbG9jYWwgdGxiIGZsdXNoIGhlcmUgKi8N
CiAgICArCQlpZiAoKHN0YXJ0ID09IDAgJiYgc2l6ZSA9PSAtMSkgfHwgKHNpemUgPiBQQUdFX1NJ
WkUpKQ0KICAgICsJCQlsb2NhbF9mbHVzaF90bGJfYWxsKCk7DQogICAgKwkJZWxzZSBpZiAoc2l6
ZSA9PSBQQUdFX1NJWkUpDQogICAgKwkJCWxvY2FsX2ZsdXNoX3RsYl9wYWdlKHN0YXJ0KTsNCiAg
ICArCQljcHVtYXNrX2NsZWFyX2NwdShjcHVpZCwgJnRtYXNrKTsNCiAgICArCX0gZWxzZSBpZiAo
Y3B1bWFza19lbXB0eSgmdG1hc2spKSB7DQogICAgKwkJLyogY3B1bWFzayBpcyBlbXB0eS4gU28g
anVzdCBkbyBhIGxvY2FsIGZsdXNoICovDQogICAgKwkJbG9jYWxfZmx1c2hfdGxiX2FsbCgpOw0K
ICAgICsJCXJldHVybjsNCiAgICArCX0NCiAgICArDQogICAgKwlpZiAoIWNwdW1hc2tfZW1wdHko
JnRtYXNrKSkgew0KICAgICsJCXJpc2N2X2NwdWlkX3RvX2hhcnRpZF9tYXNrKCZ0bWFzaywgJmht
YXNrKTsNCiAgICArCQlzYmlfcmVtb3RlX3NmZW5jZV92bWEoaG1hc2suYml0cywgc3RhcnQsIHNp
emUpOw0KICAgICsJfQ0KICAgICB9DQogICAgIA0KICAgIC0jZGVmaW5lIGZsdXNoX3RsYl9hbGwo
KSBzYmlfcmVtb3RlX3NmZW5jZV92bWEoTlVMTCwgMCwgLTEpDQogICAgLSNkZWZpbmUgZmx1c2hf
dGxiX3BhZ2Uodm1hLCBhZGRyKSBmbHVzaF90bGJfcmFuZ2Uodm1hLCBhZGRyLCAwKQ0KICAgICsj
ZGVmaW5lIGZsdXNoX3RsYl9hbGwoKSByZW1vdGVfc2ZlbmNlX3ZtYShOVUxMLCAwLCAtMSkNCiAg
ICArI2RlZmluZSBmbHVzaF90bGJfcGFnZSh2bWEsIGFkZHIpIGZsdXNoX3RsYl9yYW5nZSh2bWEs
IGFkZHIsIChhZGRyKSArIFBBR0VfU0laRSkNCg0KSSBkaWQgbm90IHNlZSBQYXVsJ3MgcGF0Y2gg
dG8gZml4IHRoaXMuIEkgd2lsbCByZW1vdmUgdGhpcyBpbiB2MiBhbmQgcmViYXNlIG9uIHRvcCBv
ZiBQYXVsJ3MgcGF0Y2guDQoNClJlZ2FyZHMsDQpBdGlzaA0KICAgICAjZGVmaW5lIGZsdXNoX3Rs
Yl9yYW5nZSh2bWEsIHN0YXJ0LCBlbmQpIFwNCiAgICAgCXJlbW90ZV9zZmVuY2Vfdm1hKG1tX2Nw
dW1hc2soKHZtYSktPnZtX21tKSwgc3RhcnQsIChlbmQpIC0gKHN0YXJ0KSkNCiAgICAgI2RlZmlu
ZSBmbHVzaF90bGJfbW0obW0pIFwNCiAgICAtLSANCiAgICAyLjIxLjANCiAgICANCiAgICANCg0K
