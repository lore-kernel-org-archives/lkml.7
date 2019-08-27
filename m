Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE53DC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FF72173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="bc7Mw7Mp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbfH0IyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:54:13 -0400
Received: from mail-eopbgr10131.outbound.protection.outlook.com ([40.107.1.131]:62182
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729493AbfH0IyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:54:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRoTtPBXXVxgSdFEJw0Cr23mUuq944iou+Yo8zuMBPrWXVh9FvtKJvZn3sIy7JqjlQqTcUAFqIqSFx5+Yxu3wLmmNRTb00eogujqJ4BAYGjlP8uJQ3NI0nS33OZDQkrq5cEqQtwO5/p1oI0yUufxc9x4CkEuMTyg60/cVvNSWT+4KBoT+HogX3Pr+a2u00k89ht08ABj2a8kMyNy7VsKwPJtEN48cthVK06rrtDBnA/oOAe1inWbwZuBbVZ6PZ1GpfgQG4zGzsAWHTyvF1d0ZKudwEG1zjm4IVFAJl1QuF8VCEBTqCzhG93ek2NgKdgsSO4Y0MtCdMq+BIYquxMHaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CA9UxYWsS1qXOQkki/BZ8SyIiGseEoKTucceojn20b8=;
 b=Si+ZjadmrTVj5CxWkKd5FlJvrd78KaDaQdo+gd8nh+JcwJC55t3uT78Q65k6DEBBYwKgEo1RJ4seMEW3bNmJTjG6hjmwWHi7mR7UFwsboSCdQm1cgVIFUXYGYoxvy7nTik1wcIzawb90sFoVVEG+vemMh0qOtpS8G3/2U/JzH6451pd/PFlJ/PMmI+Kr5b/6+ehC/ICVth68xmv2R6P6QCbgVTzQA7QxwsoE81HQT0M6jGVvEKyaRaKBOcSuITu41xECkh2MZtokPD83wiTr25pqVn/saDBydXWN8phNg5Ya0GyvzDg/QpMBXksYKgp4rFSZB0Wnx00RAYcgkUvhWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CA9UxYWsS1qXOQkki/BZ8SyIiGseEoKTucceojn20b8=;
 b=bc7Mw7Mp9JzB0tvvcpQBW0pK5o0wKoGpOBGP6d97SryVZAniw3DaLV5hcX7+hAtAn+lHn83V0f57qnb1ETOHZuPb1cs45jEqHnEqGl92njN6+NVCbmkLzXOQnYFXWcBWg361VMf+vPjR6tzWibvjSeOHCA0pYnJKoDI4hNUFNKA=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3580.eurprd02.prod.outlook.com (52.134.66.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 27 Aug 2019 08:54:06 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::a0df:d7d9:f95e:f3ea]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::a0df:d7d9:f95e:f3ea%3]) with mapi id 15.20.2178.023; Tue, 27 Aug 2019
 08:54:06 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 2/3] fbdev: fbmem: allow overriding the number of
 bootup logos
Thread-Topic: [PATCH v2 2/3] fbdev: fbmem: allow overriding the number of
 bootup logos
Thread-Index: AQHVXEiydN7Y70k3jUSZvl39hK1AWacOrIQAgAAE3YA=
Date:   Tue, 27 Aug 2019 08:54:06 +0000
Message-ID: <a31ff144-f037-3580-08b5-aa368572c69d@axentia.se>
References: <20190826195740.29415-1-peda@axentia.se>
 <20190826195740.29415-3-peda@axentia.se>
 <CAMuHMdVx77aOyUVhZ2_N76VAP+AJ3X8w-gdHLjnjUEeRKcZmOA@mail.gmail.com>
In-Reply-To: <CAMuHMdVx77aOyUVhZ2_N76VAP+AJ3X8w-gdHLjnjUEeRKcZmOA@mail.gmail.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1P18901CA0011.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::21) To DB3PR0202MB3434.eurprd02.prod.outlook.com
 (2603:10a6:8:5::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54b059ab-4af2-4046-6376-08d72acc1deb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB3PR0202MB3580;
x-ms-traffictypediagnostic: DB3PR0202MB3580:
x-microsoft-antispam-prvs: <DB3PR0202MB35808DED05F95A6A4F77EE2CBCA00@DB3PR0202MB3580.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(136003)(39830400003)(199004)(189003)(102836004)(8676002)(305945005)(7736002)(99286004)(36756003)(2616005)(14454004)(476003)(6246003)(446003)(486006)(81166006)(53936002)(65956001)(65806001)(66066001)(76176011)(4744005)(81156014)(52116002)(256004)(316002)(66556008)(66476007)(11346002)(58126008)(229853002)(508600001)(5660300002)(66946007)(66446008)(54906003)(64756008)(8936002)(6116002)(3846002)(31696002)(26005)(71190400001)(186003)(6512007)(31686004)(71200400001)(6916009)(6486002)(86362001)(2906002)(6506007)(4326008)(53546011)(386003)(25786009)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3580;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4lTPvLLwKodQW1PJxtAe1mdsULcw6cDNWhrwC6mpvp4YE7bcYNA6waDFLiuAhZO4XYp0PXYOfOrHwHdLDiXhWzmRRDjxHV0wVbuMCjE0M/Ony4aQSqHJj52jlfs2GEQkS+yts9GiYdmwe6/cpiYFTU7/h18Rv9nqpOJ0eLJmO9pKGTdNTQY0eSS75mO5sQMqYBCd1AXQoDVXKwLzOutmD6q31lqm+oFOErwI7v2JTfbOQBVKygWmS9SrU/k90uO+GE4DXxNpyERZB/t02DTlbffvQKdgxD8ZiLkdFU6KNsl7tOBH4QvadXrgaN3PJmZnWOj8X1+BIULs8z4lh4BJj2AhuTZjYncbl4eYUA/JBq+De3MzyoRwh7i5TjbmjnZWWpji2dbr8HvE0v4p1ay6Ql6Jz76zl8JYUHNxbI0Cd38=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC99F81B210C174EBD1C67387B102D1E@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b059ab-4af2-4046-6376-08d72acc1deb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 08:54:06.2253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z2gjiPtT01l1v5+BXluikPdZQ+c2TBc4MX3pDvmufM8cf2UL18Rx7ZiATSn/3iiZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3580
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wOC0yNyAxMDozNiwgR2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlOg0KPiBIaSBQZXRl
ciwNCj4gDQo+IE9uIE1vbiwgQXVnIDI2LCAyMDE5IGF0IDEwOjQ2IFBNIFBldGVyIFJvc2luIDxw
ZWRhQGF4ZW50aWEuc2U+IHdyb3RlOg0KPj4gUHJvYmFibHkgbW9zdCB1c2VmdWwgaWYgeW91IG9u
bHkgd2FudCBvbmUgbG9nbyByZWdhcmRsZXNzIG9mIGhvdyBtYW55DQo+PiBDUFUgY29yZXMgeW91
IGhhdmUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgUm9zaW4gPHBlZGFAYXhlbnRpYS5z
ZT4NCj4gDQo+IFRoYW5rcyBmb3IgeW91ciBwYXRjaCENCj4gDQo+PiAtLS0gYS9Eb2N1bWVudGF0
aW9uL2ZiL2ZiY29uLnJzdA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9mYi9mYmNvbi5yc3QNCj4+
IEBAIC0xNzQsNiArMTc0LDExIEBAIEMuIEJvb3Qgb3B0aW9ucw0KPj4gICAgICAgICBkaXNwbGF5
ZWQgZHVlIHRvIG11bHRpcGxlIENQVXMsIHRoZSBjb2xsZWN0ZWQgbGluZSBvZiBsb2dvcyBpcyBt
b3ZlZA0KPj4gICAgICAgICBhcyBhIHdob2xlLg0KPj4NCj4+ICs5LiBmYmNvbj1sb2dvLWNvdW50
OjxuPg0KPj4gKw0KPj4gKyAgICAgICBUaGUgdmFsdWUgJ24nIG92ZXJyaWRlcyB0aGUgbnVtYmVy
IG9mIGJvb3R1cCBsb2dvcy4gWmVybyBnaXZlcyB0aGUNCj4+ICsgICAgICAgZGVmYXVsdCwgd2hp
Y2ggaXMgdGhlIG51bWJlciBvZiBvbmxpbmUgY3B1cy4NCj4gDQo+IElzbid0IHRoYXQgYSBiaXQg
dW5leHBlY3RlZCBmb3IgdGhlIHVzZXI/DQo+IFdoYXQgYWJvdXQgbWFraW5nIC0xIHRoZSBkZWZh
dWx0IChhdXRvKSwgYW5kIHplcm8gbWVhbmluZyBubyBsb2dvcz8NCg0KSSBqdXN0IG5haXZlbHkg
YXNzdW1lZCB0aGVyZSB3YXMgc29tZSBvdGhlciBtZWNoYW5pc20gdG8gZGlzYWJsZSBpdC4NCg0K
U2lnaCwgSSdsbCB0YWtlIGEgbG9vay4gdjMgY29taW5nIHVwLi4uDQoNCkNoZWVycywNClBldGVy
DQo=
