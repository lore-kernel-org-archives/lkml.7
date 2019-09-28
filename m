Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE74C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 04:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16FC520815
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 04:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jzumBZiz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tgroT4rl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbfI1EXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 00:23:31 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:15368 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbfI1EXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 00:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1569644610; x=1601180610;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=U8KL3APBC5+OlPCDlY2NzvjdXwQWYeVuz/KBqn0i68M=;
  b=jzumBZizwfkyZDrCYvfAmgDrcXMQPLMJCpHpK+Xl8lW6kLMSLxqbijp0
   Gxr/2r88i1YEOgYJ578hSZo+15ToeoF0mXdGCXdZiJckl8ABeWTlBDzja
   i29htS76asHmnUVC6N57rVRGTmHwx/q16M/+Xz2BLzq5CBLyOji0uwFtT
   g33AowO5Q8OdD8p37fzd2N6C8jVETl8FXokxjVdmdvhTArVRxqh0OJ+oh
   ZjFYu2HXq/zXoCQbAGUClVx+MUzZiEaq69iZ0Rtk4BfRFCNA+K2C1992I
   SxGhyNnzyvsbJ97FEequsBffmSd7t12a55NIjS/KpHbiLFJBwbGKz2l4S
   A==;
IronPort-SDR: Rpqi1y6k656gaf687pzySQoblYNqro/qa6ghfPz1e9xSaJyDF3P2eFSBtQ9G6BQej5owHEBp25
 BXLX3GLts/ZLJj6AKRPCfpx+jQQrnxFuCcb69GQAUWo2wZwyEdi8nDlkSWH+BYCeO4Db+pz5Pz
 mjZybkz0muQ9sOeBZf+7MG/b1I7gFyViUT+ieVGUqxbmzG3AzqXtIN5vqT68VzANv+YbKUodme
 3UXD+xzES0TabOKi27F/atFQnrpnfhhqHs78lvgNJWFRDKqecNJHsEFO8yGFvd6c5wVMoIvakW
 GYs=
X-IronPort-AV: E=Sophos;i="5.64,557,1559491200"; 
   d="scan'208";a="123776365"
Received: from mail-by2nam05lp2052.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.52])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2019 12:23:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9m6APx2dlh7W5COm4cuVxtZ2DtwcMmcZ7IhmmUj2BnOYzjQt959MeeEjE53zsDbADGS+DeICb7xoXTu8pVr6rz0LtgmUO0bEMa8A4foKsVXJSotD0/iYw4bFZ8kyxwxjii2f80dPe6MKUgyposfutI0HEHP5VohFGFYlnLR1J60XN7hr6AgI0Px11H7b5sWdwVLp/xVRp2OJihcMS+O5BAFl6qIDSGERDDcmrYYUl6Yb2C420nYnySv72h6JATGyDUZv1r0EJrVqT1o1fGl7B17awCbU3b6I91/caFXF62bvQPYauhxT1ylfdpwCbBHx40DNK+dPs7jpH3xny5j4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8KL3APBC5+OlPCDlY2NzvjdXwQWYeVuz/KBqn0i68M=;
 b=YYRi8tJPkm0MCQ0QJm4MsrTgpePCmS5f+dbGcyPEkbWCgZaeaV8h9LKMMWWTrng3GFF552bJ7LJH+QB2dIpVSyMsNJVYJvenQvlZdLvqR6sw86oTEmfgxsL92ul18OKMaxCZtlS0mJ8koGJkb5XnpaeHNvH+WIEP6Jsp8BZmTpOyTCEK1kCKInJX4780979gEHI2QX4/vB9KgRD7GeYx3T3HsHSNTXsOGkPP4p1BEmu0i0UuDeNHsykN4pqug1DOORkw/7XfO+70IRkedqhJRBfeTnf9pCb5YJMlEQ8jIwxNtKyFZ+sD3ByfcAAXvyHPtS1owtLnWTreEpb7c+Ir7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8KL3APBC5+OlPCDlY2NzvjdXwQWYeVuz/KBqn0i68M=;
 b=tgroT4rla6Wiu+m2sOyO4s6wpJJCCeX10vpxLGSgqk4x+A85Zgr/k6q5GuZDNLQMaUD0bXctU2fmnCEhZR8deRt/WewAF/K76cH2DuJBragZ/QvUO2P3Bf5C2xRu/kDqkPUeQl/MpU2gorZqJJ6c7XITiLaaYyOsPOXSDOwuTbU=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB5989.namprd04.prod.outlook.com (20.178.233.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Sat, 28 Sep 2019 04:23:28 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::a50d:40a0:cd7b:acbc]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::a50d:40a0:cd7b:acbc%5]) with mapi id 15.20.2284.023; Sat, 28 Sep 2019
 04:23:28 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
CC:     "hch@lst.de" <hch@lst.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "palmer@sifive.com" <palmer@sifive.com>
Subject: Re: [PATCH v4 0/3] Optimize tlbflush path
Thread-Topic: [PATCH v4 0/3] Optimize tlbflush path
Thread-Index: AQHVWL967ZZ9b4+26kS/tTJYa+paEqcUnDiAgCwbPIA=
Date:   Sat, 28 Sep 2019 04:23:28 +0000
Message-ID: <3bd071e32ef564c91eed9e921423a95a092ec111.camel@wdc.com>
References: <20190822075151.24838-1-atish.patra@wdc.com>
         <alpine.DEB.2.21.9999.1908301939300.16731@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1908301939300.16731@viisi.sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [2601:646:8280:fdf0:69be:1cca:a557:65ea]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bf65256-ca7a-4bcb-edaf-08d743cb9cf5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB5989;
x-ms-traffictypediagnostic: BYAPR04MB5989:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5989C87E31DFC91527BF9111FA800@BYAPR04MB5989.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0174BD4BDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(189003)(199004)(64756008)(66476007)(66446008)(46003)(2616005)(102836004)(5660300002)(6512007)(2351001)(5640700003)(11346002)(81156014)(6306002)(14444005)(256004)(316002)(71190400001)(186003)(76176011)(54906003)(8936002)(966005)(71200400001)(118296001)(8676002)(14454004)(7736002)(446003)(486006)(476003)(2906002)(76116006)(66946007)(25786009)(6916009)(81166006)(478600001)(6506007)(99286004)(305945005)(66556008)(229853002)(36756003)(6436002)(86362001)(2501003)(6486002)(6116002)(4326008)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5989;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YJ04+G45hAvImM2reYzz9y5e5JcOFA+13TRnH7cACyGlInCYugq6SeAoVhMcqPAewV0UcfsMuUkYpigcXsBPSwBfXsY3/cXixq8+43q6Ayk0asYDOWqvK5Gs7R19wAMqSDoBySD2O0/nFGgGMJYWXQinFjCqzzlal78In3ntNsscxtfElH7aVscQBmmOKXYKTvLSShhs5HuD4TDCA5shZewjoYdx54rn0bNiyTSBoZCBRtOnlCRmgK5wPpjS/x3YbRFlWuEoe36QnPyTfIpy1qlkVbBCLAQeGQaBPJFdKATxo2rqrHWCcViUtO7vsCk6Ruy82mAAqTQ5EXS+Kx9bi6Zj81fkGTgrR/HtnmcvTTeVaLAjezsaYRK9mdSU5ubJcFoQTqD7WX8Q5QI9gFe/ikMGqFWl8CUbt6EWIhhDuoA6KeEdXLdRUQjIiLNZh75CaetqbTMpc7G/GrI4WZe6Fw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC093F696131314099EAF53920F7D38A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf65256-ca7a-4bcb-edaf-08d743cb9cf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2019 04:23:28.6139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g7Rgk3dOHY6ZComn89552GwoG0JOrArmz12N+4LzWLWqWTIiy5F/nlGBaDP9qGu/htzD8ECWtgcecJvLXqLACA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5989
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA4LTMwIGF0IDE5OjUwIC0wNzAwLCBQYXVsIFdhbG1zbGV5IHdyb3RlOg0K
PiBIaSBBdGlzaCwNCj4gDQo+IE9uIFRodSwgMjIgQXVnIDIwMTksIEF0aXNoIFBhdHJhIHdyb3Rl
Og0KPiANCj4gPiBUaGlzIHNlcmllcyBhZGRzIGZldyBvcHRpbWl6YXRpb25zIHRvIHJlZHVjZSB0
aGUgdHJhcCBjb3N0IGluIHRoZQ0KPiA+IHRsYg0KPiA+IGZsdXNoIHBhdGguIFdlIHNob3VsZCBv
bmx5IG1ha2UgU0JJIGNhbGxzIHRvIHJlbW90ZSB0bGIgZmx1c2ggb25seQ0KPiA+IGlmDQo+ID4g
YWJzb2x1dGVseSByZXF1aXJlZC4gDQo+IA0KPiBUaGUgcGF0Y2hlcyBsb29rIGdyZWF0LiAgTXkg
dW5kZXJzdGFuZGluZyBpcyB0aGF0IHRoZXNlIG9wdGltaXphdGlvbiANCj4gcGF0Y2hlcyBtYXkg
YWN0dWFsbHkgYmUgYSBwYXJ0aWFsIHdvcmthcm91bmQgZm9yIHRoZSBUTEIgZmx1c2hpbmcgYnVn
DQo+IHRoYXQgDQo+IHdlJ3ZlIGJlZW4gbG9va2luZyBhdCBmb3IgdGhlIGxhc3QgbW9udGggb3Ig
c28sIHdoaWNoIGNhbiBjb3JydXB0DQo+IG1lbW9yeSANCj4gb3IgY3Jhc2ggdGhlIHN5c3RlbS4N
Cj4gDQo+IElmIHRoYXQncyB0aGUgY2FzZSwgbGV0J3MgZmlyc3Qgcm9vdC1jYXVzZSB0aGUgdW5k
ZXJseWluZw0KPiBidWcuICBPdGhlcndpc2UgDQo+IHdlJ2xsIGp1c3QgYmUgcGFwZXJpbmcgb3Zl
ciB0aGUgYWN0dWFsIGlzc3VlLCB3aGljaCBwcm9iYWJseSBjb3VsZA0KPiBzdGlsbCANCj4gb2Nj
dXIgZXZlbiB3aXRoIHRoaXMgc2VyaWVzLCBjb3JyZWN0PyAgU2luY2UgaXQgY29udGFpbnMgbm8g
ZXhwbGljaXQgDQo+IGZpeGVzPw0KPiANCj4gDQpJIGhhdmUgdmVyaWZpZWQgdGhlIGdsaWJjIGxv
Y2FsZSBpbnN0YWxsIGlzc3VlIGJvdGggaW4gUWVtdSBhbmQNClVubGVhc2hlZC4gSSBkb24ndCBz
ZWUgYW55IGlzc3VlIHdpdGggT3BlblNCSSBtYXN0ZXIgKyBMaW51eCB2NS4zDQprZXJuZWwuDQoN
CkFzIHBlciBvdXIgaW52ZXN0aWdhdGlvbiwgaXQgbG9va3MgbGlrZSBhIGhhcmR3YXJlIGVycmF0
YSB3aXRoDQpVbmxlYXNoZWQgYm9hcmQgYXMgdGhlIG1lbW9yeSBjb3JydXB0aW9uIGlzc3VlIG9u
bHkgaGFwcGVucyBpbiBjYXNlIG9mDQp0bGIgcmFuZ2UgZmx1c2guIEluIFJJU0MtViwgc2ZlbmNl
LnZtYSBjYW4gb25seSBiZSBpc3N1ZWQgYXQgcGFnZQ0KYm91bmRhcnkuIElmIHRoZSByYW5nZSBp
cyBsYXJnZXIgdGhhbiB0aGF0LCBPcGVuU0JJIGhhcyB0byBpc3N1ZQ0KbXVsdGlwbGUgc2ZlbmNl
LnZtYSBjYWxscyBiYWNrIHRvIGJhY2sgbGVhZGluZyB0byBwb3NzaWJsZSBtZW1vcnkNCmNvcnJ1
cHRpb24uDQoNCkN1cnJlbnRseSwgT3BlblNCSSBoYXMgYSBwbGF0Zm9ybSBmZWF0dXJlIGkuZS4g
InRsYl9yYW5nZV9mbHVzaF9saW1pdCINCnRoYXQgYWxsb3dzIHRvIGNvbmZpZ3VyZSB0bGIgZmx1
c2ggdGhyZXNob2xkIHBlciBwbGF0Zm9ybS4gQW55IHRsYg0KZmx1c2ggcmFuZ2UgcmVxdWVzdCBn
cmVhdGVyIHRoYW4gdGhpcyB0aHJlc2hvbGQsIGlzIGNvbnZlcnRlZCB0byBhIGZ1bGwNCmZsdXNo
LiBDdXJyZW50bHksIGl0IGlzIHNldCB0byB0aGUgZGVmYXVsdCB2YWx1ZSA0SyBmb3IgZXZlcnkN
CnBsYXRmb3JtWzFdLiBHbGliYyBsb2NhbGUgaW5zdGFsbCBtZW1vcnkgY29ycnVwdGlvbiBvbmx5
IGhhcHBlbnMgaWYNCnRoaXMgdGhyZXNob2xkIGlzIGNoYW5nZWQgdG8gYSBoaWdoZXIgdmFsdWUg
aS5lLiAxRy4gVGhpcyBkb2Vzbid0DQpjaGFuZ2UgYW55dGhpbmcgaW4gT3BlblNCSSBjb2RlIHBh
dGggZXhjZXB0IHRoZSBmYWN0IHRoYXQgaXQgd2lsbCBpc3N1ZQ0KbWFueSBzZmVuY2Uudm1hIGlu
c3RydWN0aW9ucyBiYWNrIHRvIGJhY2sgaW5zdGVhZCBvZiBvbmUuIA0KDQpJZiB0aGUgaGFyZHdh
cmUgdGVhbSBhdCBTaUZpdmUgY2FuIGxvb2sgaW50byB0aGlzIGFzIHdlbGwsIGl0IHdvdWxkIGJl
DQpncmVhdC4NCg0KVG8gY29uY2x1ZGUsIHdlIHRoaW5rIHRoaXMgaXNzdWUgbmVlZCB0byBiZSBp
bnZlc3RpZ2F0ZWQgYnkgaGFyZHdhcmUNCnRlYW0gYW5kIHRoZSBrZXJuZWwgcGF0Y2ggY2FuIGJl
IG1lcmdlZCB0byBnZXQgdGhlIHBlcmZvcm1hbmNlIGJlbmVmaXQuDQoNClsxXSANCmh0dHBzOi8v
Z2l0aHViLmNvbS9yaXNjdi9vcGVuc2JpL2Jsb2IvbWFzdGVyL2luY2x1ZGUvc2JpL3NiaV9wbGF0
Zm9ybS5oI0w0MA0KDQoNCg0KPiAtIFBhdWwNCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fDQo+IGxpbnV4LXJpc2N2IG1haWxpbmcgbGlzdA0KPiBs
aW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcmlzY3YNCg0KLS0gDQpSZWdhcmRzLA0KQXRpc2gN
Cg==
