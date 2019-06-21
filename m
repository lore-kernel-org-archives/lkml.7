Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19810C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 22:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD86E2089E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 22:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oK5wx/+n";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zRRJtZps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfFUWbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 18:31:34 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:14764 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfFUWba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 18:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561156290; x=1592692290;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CwTyE5oAojXhA3u6jQqYZFBh1XJD0rLbYRD5s+d6l+g=;
  b=oK5wx/+n/M/HsK9S7nw9R/MPhNKRt+cjZBpa4insQBEdBaVeIbjtDG1g
   6EGeUD7OGRTLeDadTMt0HR4o8JlcBtdjeqVIfiAqTOgXYF9Hnilng2xgE
   tIf4LZ2CGNz3jmv/G71wjEZXTOmW48ctu2ecCR57waQZnilp/xnn4gTfg
   Uu2opLpy7P4goHEIayw2LCltcREM7nCByvY8Yj5lNBJWIokaeoqkF86FD
   jouyTnl7IqKVDsB1Mw/0lqAbbENhxwg+W2ZNwIxbpGPnZSRcf1U7eERLq
   5u9Gw7YoYxXsHOUlongMO59blJPHDkgQLi449ck82ie7FTwpL4UtacQZt
   w==;
X-IronPort-AV: E=Sophos;i="5.63,402,1557158400"; 
   d="scan'208";a="112418534"
Received: from mail-by2nam01lp2050.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.50])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2019 06:31:29 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwTyE5oAojXhA3u6jQqYZFBh1XJD0rLbYRD5s+d6l+g=;
 b=zRRJtZps0xN7icO/bbgp9vv4vZ+DpwoqgPZ2ua8a1oQyM74WtUKFLVNFyVeErlEsgmQe1+8J8uMoH96TR3M1lLJjJ2aRVm2ki8zM2bn3MVF8vxo8v+amyI/z5T51bS4ftJ3J1FskGAvz7h3qurhGr2fRvnZSvmxd4ZPmjfJFKXY=
Received: from BYAPR04MB3782.namprd04.prod.outlook.com (52.135.214.142) by
 BYAPR04MB6056.namprd04.prod.outlook.com (20.178.233.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Fri, 21 Jun 2019 22:31:28 +0000
Received: from BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::65e3:6069:d7d5:90a2]) by BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::65e3:6069:d7d5:90a2%5]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 22:31:28 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rfontana@redhat.com" <rfontana@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jhugo@codeaurora.org" <jhugo@codeaurora.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "morten.rasmussen@arm.com" <morten.rasmussen@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ottosabart@seberm.com" <ottosabart@seberm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 3/7] cpu-topology: Move cpu topology code to common
 code.
Thread-Topic: [PATCH v7 3/7] cpu-topology: Move cpu topology code to common
 code.
Thread-Index: AQHVJT7xIDv/dWmHkUmsJR6AXUgH+qajQP2AgAN2pAA=
Date:   Fri, 21 Jun 2019 22:31:27 +0000
Message-ID: <91559562f2958fa904b53e621e596d6216efa9fb.camel@wdc.com>
References: <20190617185920.29581-1-atish.patra@wdc.com>
         <20190617185920.29581-4-atish.patra@wdc.com>
         <20190619173801.GB20916@kroah.com>
In-Reply-To: <20190619173801.GB20916@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16275102-8761-4c03-078c-08d6f6983390
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB6056;
x-ms-traffictypediagnostic: BYAPR04MB6056:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB6056F3504653162A4ECF3035FAE70@BYAPR04MB6056.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(346002)(39860400002)(376002)(199004)(189003)(6116002)(5660300002)(76116006)(6436002)(76176011)(72206003)(81166006)(66946007)(256004)(99286004)(68736007)(2906002)(102836004)(54906003)(6506007)(3846002)(4744005)(6512007)(14454004)(316002)(478600001)(71190400001)(36756003)(81156014)(229853002)(8936002)(7416002)(73956011)(53936002)(8676002)(6916009)(66556008)(71200400001)(11346002)(476003)(446003)(4326008)(25786009)(26005)(2616005)(6246003)(66476007)(6486002)(66066001)(66446008)(64756008)(486006)(118296001)(86362001)(186003)(7736002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6056;H:BYAPR04MB3782.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bpihA2OFNr62h73iZ0P9jpk7naT/xsUgCEuMtbqqLoDVkS7ut1yKmx7k5/M05DetLwIjsnkuRWpqVN4gG1eT15gXOUhOhlywGAEFiAcsNRdVZAOP2cb6wleyzYMOo6zyIEyVgbBdkbX6VwK/ZTV3BHtFsEkblh7Nzrw7969PBhELT/aZMvf8VxbwrwaXb0U1T6SQVFavyAmT34jNWdoqbkZvOk4ekx5tfaCFu0FIAcxDrSDbcD38GFh7BAGQtYlxVjBZHUjsx1iW41IlccMcMebWMA2xoPeLvfSm+x6RY9Vf2ZiUFbgA3y38BIyHoqnBXVIl7v45TAgQo65lxV1es8IP6JGnYzamQUrM1rRHFEQvjahVOHnI2jddpJHl716o/bEbwOwxSeV2P0w34/4e3VZgasiNf+3vPHjwWXjQTtE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27C05F5F6A9C554FA6F50BCF64D1706A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16275102-8761-4c03-078c-08d6f6983390
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 22:31:27.9153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Atish.Patra@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA2LTE5IGF0IDE5OjM4ICswMjAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IE9uIE1vbiwgSnVuIDE3LCAyMDE5IGF0IDExOjU5OjE2QU0gLTA3MDAsIEF0aXNoIFBh
dHJhIHdyb3RlOg0KPiA+IEJvdGggUklTQy1WICYgQVJNNjQgYXJlIHVzaW5nIGNwdS1tYXAgZGV2
aWNlIHRyZWUgdG8gZGVzY3JpYmUNCj4gPiB0aGVpciBjcHUgdG9wb2xvZ3kuIEl0J3MgYmV0dGVy
IHRvIG1vdmUgdGhlIHJlbGV2YW50IGNvZGUgdG8NCj4gPiBhIGNvbW1vbiBwbGFjZSBpbnN0ZWFk
IG9mIGR1cGxpY2F0ZSBjb2RlLg0KPiA+IA0KPiA+IFRvOiBXaWxsIERlYWNvbiA8d2lsbC5kZWFj
b25AYXJtLmNvbT4NCj4gPiBUbzogQ2F0YWxpbiBNYXJpbmFzIDxjYXRhbGluLm1hcmluYXNAYXJt
LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBdGlzaCBQYXRyYSA8YXRpc2gucGF0cmFAd2RjLmNv
bT4NCj4gPiBbVGVzdGVkIG9uIFFERjI0MDBdDQo+ID4gVGVzdGVkLWJ5OiBKZWZmcmV5IEh1Z28g
PGpodWdvQGNvZGVhdXJvcmEub3JnPg0KPiA+IFtUZXN0ZWQgb24gSnVubyBhbmQgb3RoZXIgZW1i
ZWRkZWQgcGxhdGZvcm1zLl0NCj4gPiBUZXN0ZWQtYnk6IFN1ZGVlcCBIb2xsYSA8c3VkZWVwLmhv
bGxhQGFybS5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IFN1ZGVlcCBIb2xsYSA8c3VkZWVwLmhvbGxh
QGFybS5jb20+DQo+ID4gQWNrZWQtYnk6IFdpbGwgRGVhY29uIDx3aWxsLmRlYWNvbkBhcm0uY29t
Pg0KPiANCj4gQWNrZWQtYnk6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRh
dGlvbi5vcmc+DQoNCkhpIFBhdWwsDQpJIGd1ZXNzIEdyZWcgaGFzIGFja2VkIHRoZSBzZXJpZXMg
YXNzdW1pbmcgdGhhdCBpdCB3aWxsIGdvIHRocm91Z2ggc29tZQ0Kb3RoZXIgdHJlZS4gQ2FuIHlv
dSB0YWtlIGl0IHRocm91Z2ggUklTQy1WIHRyZWUgPw0KDQpTb3JyeSBmb3IgdGhlIGNvbmZ1c2lv
bi4NCg0KTm90ZTogV2UgYXJlIHN0aWxsIHdhaXRpbmcgZm9yIFJNSydzIEFDSyBvbiBhcm0gcGF0
Y2ggYmVmb3JlIGl0IGNhbiBiZQ0Kc2VudCBhcyBhIFBSLg0KDQpSZWdhcmRzLA0KQXRpc2gNCg==
