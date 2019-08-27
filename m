Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE06C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5D52077B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R7xHX2zR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xZPDxari"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbfH0Uhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:37:31 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:22051 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfH0Uhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566938251; x=1598474251;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YfzbCvOMEV5XGepibRq4aIUh+PTyodJnSlxTf7cfkzs=;
  b=R7xHX2zRtEKKE406OhgHW6UoikSj4OFGYKYE+CxNHQtLBU8vd4vHRX6R
   nvdavzOD5rYI2UTdDCP3h4N4iolG2PzLJgCWCq7I40hPJnqQ5WwflyQXW
   Yyjt/g2MDJZazhJWcNYLlxdV6PZE6fMokPc02pIsQK77wcgXvzCaHpIiL
   bogRpjLHKMnpNpJptQ8HgnjAzpiQ5yMLZtV/heSg4cmyAwEYcsnRvvtnB
   wxGkRFPT+Zh5gONVsfA9WdG9UwcqUJkWe7Vff8LyIl8zihtd781aH7H2N
   yAkm6QaLrjtZOL4OlfUlKwyF0Fl8Hv+YkF2SqWK4y68dS13sFAUY/SvsP
   A==;
IronPort-SDR: DNmIRAcO0zEPMnJnP94r1BXCZWQBR//t/PJ3JDZQNsyOkKkDpDIMxxqa276NBauoiVUCsqhLmI
 Rxf3tOmca9eZkxqMvqs1NMYcItjViY7EXZJ68kfrOozAuSLJ3pWkbWxvbjRvDFB1G8Up2C8LSq
 clgBJ8WndYy1ZL1uC5RQVcJAm/jWpVOMkYz6aOpoR52w992Zfzcf2QweUclVRXFddtLNADy9Nv
 3qWkFCsombTilactM4+ztV3/9aMkpTKL/jDF5/hpeajhDLJ2D7DnjJt6PvbCYrkplQ/8jDa699
 FvY=
X-IronPort-AV: E=Sophos;i="5.64,438,1559491200"; 
   d="scan'208";a="223454885"
Received: from mail-dm3nam05lp2051.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.51])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2019 04:37:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIk5cbVZ7/Zxc+sA4C+okUuUyQrAce9BOjzy7eCgJ1UusCAX7hyJV3p43tsWosoGg5AVEgk3BQPPjN5sgQhlUcY6u/qzCbo+m7GZ1PlEZ6mPpb4RpSyxxYaRM0dIXJQzqTWNKB+h9fYYBKjYbrL48+nT3S3ww66dYyVXdCy9I7TKrJh/B3U5TsccxcndUlQZqS34eHa+Ha9QfFjOr9AbEV9JsyGjhFSWTv9klwTm7P7O+sYVvaycLQ6GtyL71fjMrKBV9UcCL7+oyiP5MHtMshIyLLEKQTIMdwxNdgYE2jFD7AbHRwiNH6k6JNMazEgJpj/t2FA9lXHjB4E/8dRUJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfzbCvOMEV5XGepibRq4aIUh+PTyodJnSlxTf7cfkzs=;
 b=HNuMg/E3tnmfqxjiTx2e8j0B7S6o1/lGU5+VrUoLI0TSk8GWxKJiot3NoLC1yON6O+KDnBe0Lv07nRNeKLXxzCv0PWfwRGBibpAaGfDzKW0REoWvkTT8cClBk1OSYLRmPuKdzC4etZLSnM39U2oaxKkLQ9/OoYC8DAIZqOQRpo5KGGt8xrXgxWBHJ5PG3LwW6gq5LmLT+083YbzLe78q3qpcE04qHw4Hldl1++Pv+NJHndYgiVWs2GYenT/7s5pjcOCsBCCpk/ykYWBaK/L37gge/VjJgxI57mVO36SC6hqLOWmxsn1Ghp8i+8zEWddmX04/xywALaln+Qul9Fl9+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfzbCvOMEV5XGepibRq4aIUh+PTyodJnSlxTf7cfkzs=;
 b=xZPDxariGFtv/6VUDZU0D/X4SZyFm7ilUfT6SoaZaaSb3JDlgRoZ3W2TjYX1DmeIgPKFxNk+RFker23dRmDmb7IhVyXGXu1NqQWcctUqzQ9KVUMnBAqDnVN2/3No33cidSE9xl1v1F6DH4hAs8Rn7PeEDHK8/39xIJZ06D9azr4=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB5079.namprd04.prod.outlook.com (52.135.235.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Tue, 27 Aug 2019 20:37:28 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e%4]) with mapi id 15.20.2178.020; Tue, 27 Aug 2019
 20:37:28 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "alankao@andestech.com" <alankao@andestech.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "palmer@sifive.com" <palmer@sifive.com>
Subject: Re: [RFC PATCH 1/2] RISC-V: Mark existing SBI as legacy SBI.
Thread-Topic: [RFC PATCH 1/2] RISC-V: Mark existing SBI as legacy SBI.
Thread-Index: AQHVXGawW0XtdcDDakm9TmNp3/W3LacPB3wAgABuMYA=
Date:   Tue, 27 Aug 2019 20:37:27 +0000
Message-ID: <ac3cfe4502090354a7c49fae277adb757ad900d5.camel@wdc.com>
References: <20190826233256.32383-1-atish.patra@wdc.com>
         <20190826233256.32383-2-atish.patra@wdc.com>
         <20190827140304.GA21855@infradead.org>
In-Reply-To: <20190827140304.GA21855@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8021e8da-861b-4715-cdf8-08d72b2e6070
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5079;
x-ms-traffictypediagnostic: BYAPR04MB5079:
x-microsoft-antispam-prvs: <BYAPR04MB5079680F22780F89A79DF2EEFAA00@BYAPR04MB5079.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(189003)(199004)(66946007)(5640700003)(2616005)(53936002)(6436002)(6116002)(3846002)(11346002)(446003)(76176011)(66556008)(316002)(229853002)(66476007)(66066001)(118296001)(7736002)(102836004)(6506007)(2351001)(6916009)(76116006)(478600001)(305945005)(6512007)(476003)(186003)(6246003)(36756003)(486006)(26005)(66446008)(64756008)(54906003)(2906002)(256004)(14454004)(25786009)(7416002)(86362001)(6486002)(8936002)(71190400001)(8676002)(71200400001)(1730700003)(81166006)(81156014)(5660300002)(99286004)(4326008)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5079;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: moHSN5wxX+oVwXiIMMb1VIBUa2E1EtofZdpZ+KZsG3KcQnfsAxSVYAUf/j4WWzMk+Bfg0tq7NfvmhHQvAXxmCOjwVLuNefLfUTcJE5HTA2AmyIqr5qHv+25eFMo9fmOzt1YyT244br88ZA5bY4qsxQhSbOFM9JYVbeNWBn8NfTzbB3c2P7mvDuYJwl1Yfv7QRzLElfR4iWJdGc2SeHhfY636xBOyhiIWyNNnCzOHaaJiJZkEawJWnsklyE5Ct/Lw87dAHSYLyW/WGkVyNCRr6CPMohbAWKsIrBsJ4y9XfeyU5t5ZQBiwUDVDLq/FxYUmurwYp3L1o3qXXLc/nu8IxqdW1FW9MVQiyu2TYnef7lCRLPaszND0W9znn0mAC+Ku2kHVLe9Z4xD3PR/C8zgJfNDNlCYLTS2ByLzKlP9nIaU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B08E5436C8E48840B970D5DF82DD8722@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8021e8da-861b-4715-cdf8-08d72b2e6070
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 20:37:27.9991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kZDeexZVHJ1tFVtPKh7fZ3pFZthKakuPKDMc+ZW+EFfbUYjXrKdV9y2SWPzJUVzjICyz73eAC3W6oLGmwyInfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTI3IGF0IDA3OjAzIC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gPiArI2RlZmluZSBTQklfRVhUX0xFR0FDWV9TRVRfVElNRVIgMHgwDQo+ID4gKyNkZWZp
bmUgU0JJX0VYVF9MRUdBQ1lfQ09OU09MRV9QVVRDSEFSIDB4MQ0KPiA+ICsjZGVmaW5lIFNCSV9F
WFRfTEVHQUNZX0NPTlNPTEVfR0VUQ0hBUiAweDINCj4gPiArI2RlZmluZSBTQklfRVhUX0xFR0FD
WV9DTEVBUl9JUEkgMHgzDQo+ID4gKyNkZWZpbmUgU0JJX0VYVF9MRUdBQ1lfU0VORF9JUEkgMHg0
DQo+ID4gKyNkZWZpbmUgU0JJX0VYVF9MRUdBQ1lfUkVNT1RFX0ZFTkNFX0kgMHg1DQo+ID4gKyNk
ZWZpbmUgU0JJX0VYVF9MRUdBQ1lfUkVNT1RFX1NGRU5DRV9WTUEgMHg2DQo+ID4gKyNkZWZpbmUg
U0JJX0VYVF9MRUdBQ1lfUkVNT1RFX1NGRU5DRV9WTUFfQVNJRCAweDcNCj4gPiArI2RlZmluZSBT
QklfRVhUX0xFR0FDWV9TSFVURE9XTiAweDgNCj4gDQo+IEFzIE1pa2Ugc2FpZCBsZWdhY3kgaXMg
YSBiaXQgb2YgYSB3ZWlyZCBuYW1lLiAgSSB0aGluayB0aGlzIHNob3VsZA0KPiBiZSBTQkkwMV8q
IG9yIHNvLiAgQW5kIHBsZWFlIGFsaWduIHRoZSBudW1lcmljIHZhbHVlcyBhbmQgbWF5YmUgdXNl
DQo+IGFuIGVudW0uDQo+IA0KV2lsbCBkby4NCg0KPiA+ICsNCj4gPiArI2RlZmluZSBTQklfQ0FM
TF9MRUdBQ1kod2hpY2gsIGFyZzAsIGFyZzEsIGFyZzIsIGFyZzMpDQo+ID4gKHsgICAgICAgICAg
ICAgXA0KPiA+ICAJcmVnaXN0ZXIgdWludHB0cl90IGEwIGFzbSAoImEwIikgPSAodWludHB0cl90
KShhcmcwKTsJXA0KPiA+ICAJcmVnaXN0ZXIgdWludHB0cl90IGExIGFzbSAoImExIikgPSAodWlu
dHB0cl90KShhcmcxKTsJXA0KPiA+ICAJcmVnaXN0ZXIgdWludHB0cl90IGEyIGFzbSAoImEyIikg
PSAodWludHB0cl90KShhcmcyKTsJXA0KPiANCj4gSW5zdGVhZCBvZiB0aGUgd2VpcmQgaW5saW5l
IGFzc2VtYmx5IHdpdGggZm9yY2VkIHJlZ2lzdGVyIGFsbG9jYXRpb24sDQo+IHdoeSBub3QgbW92
ZSB0aGlzIHRvIHB1cmUgYXNzZW1ibHk/ICBBRkFJQ3MgdGhpcyBpcyB0aGUgd2hvbGUNCj4gYXNz
ZW1ibHkNCj4gY29kZSB3ZSdkIG5lZWQ6DQo+IA0KPiBFTlRSWShzYmkwMV9jYWxsKQ0KPiAgICAg
ICAgIGVjYWxsDQo+IEVORChzYmkwMV9jYWxsKQ0KPiANCg0KVGhhdCB3b3VsZCBzcGxpdCB0aGUg
aW1wbGVtZW50YXRpb24gYmV0d2VlbiBDIGZpbGUgJiBhc3NlbWJseSBmaWxlIGZvcg0Kbm8gZ29v
ZCByZWFzb24uDQoNCkhvdyBhYm91dCBtb3ZpbmcgZXZlcnl0aGluZyBpbiBzYmkuYyBhbmQganVz
dCB3cml0ZSBldmVyeXRoaW5nIGlubGluZQ0KYXNzZW1ibHkgdGhlcmUuDQoNCj4gPiAgLyogTGF6
eSBpbXBsZW1lbnRhdGlvbnMgdW50aWwgU0JJIGlzIGZpbmFsaXplZCAqLw0KPiA+IC0jZGVmaW5l
IFNCSV9DQUxMXzAod2hpY2gpIFNCSV9DQUxMKHdoaWNoLCAwLCAwLCAwLCAwKQ0KPiA+IC0jZGVm
aW5lIFNCSV9DQUxMXzEod2hpY2gsIGFyZzApIFNCSV9DQUxMKHdoaWNoLCBhcmcwLCAwLCAwLCAw
KQ0KPiA+IC0jZGVmaW5lIFNCSV9DQUxMXzIod2hpY2gsIGFyZzAsIGFyZzEpIFNCSV9DQUxMKHdo
aWNoLCBhcmcwLCBhcmcxLA0KPiA+IDAsIDApDQo+ID4gLSNkZWZpbmUgU0JJX0NBTExfMyh3aGlj
aCwgYXJnMCwgYXJnMSwgYXJnMikgXA0KPiA+IC0JCVNCSV9DQUxMKHdoaWNoLCBhcmcwLCBhcmcx
LCBhcmcyLCAwKQ0KPiA+IC0jZGVmaW5lIFNCSV9DQUxMXzQod2hpY2gsIGFyZzAsIGFyZzEsIGFy
ZzIsIGFyZzMpIFwNCj4gPiAtCQlTQklfQ0FMTCh3aGljaCwgYXJnMCwgYXJnMSwgYXJnMiwgYXJn
MykNCj4gPiArI2RlZmluZSBTQklfQ0FMTF9MRUdBQ1lfMCh3aGljaCkgU0JJX0NBTExfTEVHQUNZ
KHdoaWNoLCAwLCAwLCAwLA0KPiA+IDApDQo+ID4gKyNkZWZpbmUgU0JJX0NBTExfTEVHQUNZXzEo
d2hpY2gsIGFyZzApIFNCSV9DQUxMX0xFR0FDWSh3aGljaCwNCj4gPiBhcmcwLCAwLCAwLCAwKQ0K
PiA+ICsjZGVmaW5lIFNCSV9DQUxMX0xFR0FDWV8yKHdoaWNoLCBhcmcwLCBhcmcxKSBcDQo+ID4g
KwkJU0JJX0NBTExfTEVHQUNZKHdoaWNoLCBhcmcwLCBhcmcxLCAwLCAwKQ0KPiA+ICsjZGVmaW5l
IFNCSV9DQUxMX0xFR0FDWV8zKHdoaWNoLCBhcmcwLCBhcmcxLCBhcmcyKSBcDQo+ID4gKwkJU0JJ
X0NBTExfTEVHQUNZKHdoaWNoLCBhcmcwLCBhcmcxLCBhcmcyLCAwKQ0KPiA+ICsjZGVmaW5lIFNC
SV9DQUxMX0xFR0FDWV80KHdoaWNoLCBhcmcwLCBhcmcxLCBhcmcyLCBhcmczKSBcDQo+ID4gKwkJ
U0JJX0NBTExfTEVHQUNZKHdoaWNoLCBhcmcwLCBhcmcxLCBhcmcyLCBhcmczKQ0KPiANCj4gV2hl
biB5b3UgdG91Y2ggdGhpcyBhbnl3YXkgSSdkIHN1Z2dlc3QgeW91IGtpbGwgdGhlc2UgcmF0aGVy
DQo+IHBvaW50bGVzcyB3cmFwcGVycyBhcyB3ZWxsIGFzIHRoZSBjb21tZW50IGFib3ZlIHRoZW0u
DQoNClN1cmUuIEkgZGlkIG5vdCB3YW50IG1ha2UgYmlnZ2VyIGNoYWduZXMgaW4gMXN0IFJGQyBw
YXRjaGVzLiBCdXQNCmxvb2tpbmcgYXQgdGhlIGNvbW1lbnRzLCBJIGZlZWwgaXQgd2FzIG5vdCBh
IGdvb2QgZGVjaXNzaW9uLg0KDQpJIHdpbGwgZ2V0IHJpZCBvZiB0aGVzZSB3cmFwcGVycyBhbmQg
bW92ZSBuZWNlc3Nhcnkgb25lcyB0byBzYmkuYw0KDQotLSANClJlZ2FyZHMsDQpBdGlzaA0K
