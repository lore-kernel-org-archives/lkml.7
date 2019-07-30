Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1605C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8358F2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="O784/Nrq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VIAMaCSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387532AbfG3Ul5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 16:41:57 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59582 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfG3Ul4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564519316; x=1596055316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jqSxVo9BTH/BK7IHa8tVUTQCoecKphTDMxHqGB7egPk=;
  b=O784/Nrq3Vr0wfaIrxuF+hBwFLgA45COLhUGMI0INWv2C6DUFwPbHBLg
   HwdRFZ7Ohz8+rTxg/DpioDypmJEvVg3St3D4aijaNm1UoPBBxvDkMGBiv
   iASsqP8UxAfnmp9KSIKtNPkd+Y1lWqt4+sLibxOSmmzONVXqCHI3oevG7
   U29yZmg0tXN9gZCXmH1J9zUrdN8rZcyoWt10K7U9Kgsh/IrekMEucZrSr
   UI4zmsSb7gw9zk1k/oEZNwDaDs5WpssxofpRMQiTrnRQiuVooaELmwPgR
   0DDOnVQU3TQu6/hQ68XCGaicFgMZePQNlSbDxCY1PrI2Jks8gYXte2DtA
   Q==;
IronPort-SDR: Gb9WrtDQFNKBew75PYaGykl5b2lSmiv8i9/GjSfsgZ/GmgvnbKBbN6GqJM9cdTYr6G0w1Lio8W
 AoV6QERZhePiR32tGgGnkQCoutjBmFLLWf0iKLThHDQS32fOt6xjrJIf5VBt1RjTE1LwEjGOUc
 d6WoUpMm4XyMVpz4003vzNuvqIBMLr2Yr+NArOh804fMnSUFSzmSDFB1rRgNcdWIwzxH0eAVml
 aNJw1cELGNMHMiCYUhfa/BD+DCvFSI7IYcWTpfJYPIllh1/kUqKsMAWzH85RnWUvfXxkDnkqe3
 xgk=
X-IronPort-AV: E=Sophos;i="5.64,327,1559491200"; 
   d="scan'208";a="114527218"
Received: from mail-cys01nam02lp2054.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.54])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jul 2019 04:41:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBaHOwcBd5QF4U3h0UqwWKdzCItHRixuRSiklFO2kQOWAF0hHqrr3xbNuEXx7jo4Yogi9aeKOC6u9ykufFyxB7H4G/a0KcL5emCvkBGkb5qRJwRvu/U+gCGkx/4bR+oXNT8+g90PqFonQ77SAGwdh4uyZ7GoqjOFSyMXwhL4ehPH3HN7ArkLaOEhbcSgnLvRDxsf5zI3PV7rRiXRjFA3jwLDqLH6pzmCpLJ2F1xdbSpw8TpH584njXTS1ueL+MhdfH+XZU84mSh+SW18lObyTsLbqCPnazAKQbA99cTdsoDYBm7+5A55X+xg0zsKtVhVJOJLxcLQ+VTmY5QTnF9VjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqSxVo9BTH/BK7IHa8tVUTQCoecKphTDMxHqGB7egPk=;
 b=DRPVZupOvlJ8AYeFGRTaVnDNApkR7nBif1FYOccb8dmZcW+mptl/3ZnQmwTET56vz8Ljab2Vr381v4lc6eZOf8uwS4Qc/cRIKdqZPx5V8T7/xabDNRUssmUDOcadLpc7DPxQ4ZLLzozK2KNF+D4rQgjL9yhfYyMMt6Y5DsLPfbbr1deGfmtKh5fJn2L+7P06QvdFgVAZ+6uWolmR7g00BXdUoA7XHHOVsaJmpoUq40/+gQPvm7/CAfsUJDywbQPhFCuYB3I4jP//Ni6/hSHUc2Q2KwFQ/Q8twzAXu4/Aorq8MwCLgdfqXPD1mAGzLpItBGsopO+/C2lymMzOPNkwkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqSxVo9BTH/BK7IHa8tVUTQCoecKphTDMxHqGB7egPk=;
 b=VIAMaCSqvYJBZ/BCHZ1frYIEYfinQYBdEq94o8ikktNV+/LKbJdQ7t7UcDAQBMBgk+Ub5nw67mg5hxgvKoE0T/hoBvTUAUtjb+EO48U6zCtXUYfg7L15ZRPfHbSSEtvpQNEJMy4jGexO30JWq2DeWogc1vyqLJtmj97FJe6m46Y=
Received: from BYAPR04MB3782.namprd04.prod.outlook.com (52.135.214.142) by
 BYAPR04MB4919.namprd04.prod.outlook.com (52.135.232.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.14; Tue, 30 Jul 2019 20:41:53 +0000
Received: from BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::ac9a:967e:70a5:e926]) by BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::ac9a:967e:70a5:e926%7]) with mapi id 15.20.2115.005; Tue, 30 Jul 2019
 20:41:53 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "palmer@sifive.com" <palmer@sifive.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "alankao@andestech.com" <alankao@andestech.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "johan@kernel.org" <johan@kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: Re: [PATCH 3/4] RISC-V: Support case insensitive ISA string parsing.
Thread-Topic: [PATCH 3/4] RISC-V: Support case insensitive ISA string parsing.
Thread-Index: AQHVQ+refROWkRWGQ0GJqrWaHX74e6bdXtyAgAAaDYCABRDYAIABHNgA
Date:   Tue, 30 Jul 2019 20:41:52 +0000
Message-ID: <889b697be9eec05c67fea97919b4c814c4a7ef4a.camel@wdc.com>
References: <mhng-540ae5bd-8e5f-4054-9192-4e4e73cbce21@palmer-si-x1e>
In-Reply-To: <mhng-540ae5bd-8e5f-4054-9192-4e4e73cbce21@palmer-si-x1e>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c486f84-c5d5-4ef7-a849-08d7152e5ab7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4919;
x-ms-traffictypediagnostic: BYAPR04MB4919:
x-microsoft-antispam-prvs: <BYAPR04MB4919D4096B71338FBA40CBC5FADC0@BYAPR04MB4919.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(189003)(199004)(68736007)(186003)(2906002)(6486002)(6436002)(8676002)(86362001)(478600001)(316002)(81156014)(81166006)(3846002)(54906003)(2501003)(229853002)(7736002)(1730700003)(6116002)(305945005)(71190400001)(6916009)(66446008)(118296001)(71200400001)(6246003)(64756008)(66556008)(66476007)(99286004)(486006)(2351001)(446003)(66066001)(4326008)(8936002)(14454004)(66946007)(36756003)(76116006)(102836004)(5660300002)(53546011)(476003)(26005)(7416002)(76176011)(256004)(5640700003)(25786009)(53936002)(2616005)(11346002)(6512007)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4919;H:BYAPR04MB3782.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MywKjlj1/f8AlF3mD9usUStEy1HYPW329L8o/t1zHPLIcLeCLEch3J3trQBLAa3ce7iE2QA9No0p3K5S4bhmkcqBt4dtmpjnAhMkSmpaUxGz9TYD8AqLDHXQtMYKCGG7aigju/RujaIqdRUvxprkNC0d7dCJG9BoMDTcNZiM+Kg5oIg1/3c4Db9fQWAFSwWln4eQD2cUTgCXDaThq32OzbAgGmJI02G6UvJVqJdgfYUVi5mhcWS095XEC9zxc7LNc+ODpCxVcibZ15Hhv1vFY3hcqGU/cxd0fgdim6bL8I/a9oHlRguqrMyVGNqtW5dKfl41Er/mQkIypmJ3N7bXwxTDKRfGiICtx+acFtt+NVoVDAD8JEdWy4FJr52JLTrt844328Y4C7+NIqndGIo1nYI3Oo6nxL60l53xormFN34=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDDCCD769E92564CAA6A11F746380A81@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c486f84-c5d5-4ef7-a849-08d7152e5ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 20:41:52.8810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Atish.Patra@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4919
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA3LTI5IGF0IDIwOjQyIC0wNzAwLCBQYWxtZXIgRGFiYmVsdCB3cm90ZToN
Cj4gT24gRnJpLCAyNiBKdWwgMjAxOSAxNToyMDo0NyBQRFQgKC0wNzAwKSwgQXRpc2ggUGF0cmEg
d3JvdGU6DQo+ID4gT24gNy8yNi8xOSAxOjQ3IFBNLCBQYXVsIFdhbG1zbGV5IHdyb3RlOg0KPiA+
ID4gT24gRnJpLCAyNiBKdWwgMjAxOSwgQXRpc2ggUGF0cmEgd3JvdGU6DQo+ID4gPiANCj4gPiA+
ID4gQXMgcGVyIHJpc2N2IHNwZWNpZmljYXRpb24sIElTQSBuYW1pbmcgc3RyaW5ncyBhcmUNCj4g
PiA+ID4gY2FzZSBpbnNlbnNpdGl2ZS4gSG93ZXZlciwgY3VycmVudGx5IG9ubHkgbG93ZXIgY2Fz
ZQ0KPiA+ID4gPiBzdHJpbmdzIGFyZSBwYXJzZWQgZHVyaW5nIGNwdSBwcm9jZnMuDQo+ID4gPiA+
IA0KPiA+ID4gPiBTdXBwb3J0IHBhcnNpbmcgb2YgdXBwZXIgY2FzZSBsZXR0ZXJzIGFzIHdlbGwu
DQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBdGlzaCBQYXRyYSA8YXRpc2gucGF0
cmFAd2RjLmNvbT4NCj4gPiA+IA0KPiA+ID4gSXMgdGhlcmUgYSB1c2UgY2FzZSB0aGF0J3MgZHJp
dmluZyB0aGlzLCBvcg0KPiA+IA0KPiA+IEN1cnJlbnRseSwgd2UgdXNlIGFsbCBsb3dlciBjYXNl
IGlzYSBzdHJpbmcgaW4ga3ZtdG9vbC4gQnV0DQo+ID4gc29tZWJvZHkgY2FuDQo+ID4gaGF2ZSB1
cHBlcmNhc2UgbGV0dGVycyBpbiBmdXR1cmUgYXMgc3BlYyBhbGxvd3MgaXQuDQo+ID4gDQo+ID4g
DQo+ID4gY2FuIHdlIGp1c3Qgc2F5LCAidXNlDQo+ID4gPiBsb3dlcmNhc2UgbGV0dGVycyIgYW5k
IGxlYXZlIGl0IGF0IHRoYXQ/DQo+ID4gPiANCj4gPiANCj4gPiBJbiB0aGF0IGNhc2UsIGl0IHdp
bGwgbm90IGNvbXBseSB3aXRoIFJJU0MtViBzcGVjLiBJcyB0aGF0IG9rYXkgPw0KPiANCj4gV2Ug
Y291bGQgbWFrZSB0aGUgcGxhdGZvcm0gc3BlYyBzYXkgInVzZSBsb3dlcmNhc2UgbGV0dGVycyIg
YW5kIHdpcGUNCj4gb3VyIGhhbmRzDQo+IG9mIGl0IC0tIElJUkMgd2Ugc3RpbGwgb25seSBzdXBw
b3J0IHRoZSBsb3dlciBjYXNlIGxldHRlcnMgaW4gR0NDIGR1ZQ0KPiB0bw0KPiBtdWx0aWxpYiBo
ZWFkYWNoZXMsIHNvIGl0J3Mga2luZCBvZiB0aGUgZGUtZmFjdG8gc3RhbmRhcmQgYWxyZWFkeS4N
Cj4gDQoNClNvdW5kcyBnb29kLiBUaGF0J3Mgd2hhdCBJIHN1Z2dlc3RlZCBpbiBlYXJsaWVyIGVt
YWlsIGFzIHdlbGwuDQpJdCB3b3VsZCBiZSBnb29kIHRvIGFkZCAidXNlIGxvd2VyY2FzZSBsZXR0
ZXJzIiBpbiB5YW1sIGRvY3VtZW50YXRpb24NCmFzIHdlbGwganVzdCB0byBhdm9pZCBhbnkgY29u
ZnVzaW9uIGF0IGFsbC4NCg0KSSB3aWxsIHNlbmQgYSB2MiBzb29uLg0KDQpSZWdhcmRzLA0KQXRp
c2gNCj4gPiA+IC0gUGF1bA0KPiA+ID4gDQoNCg==
