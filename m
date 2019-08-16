Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9683AC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B8F20665
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J2BMIKbH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pjQjbUfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfHPR5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:57:34 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8611 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfHPR5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565978254; x=1597514254;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Dy5Yqge4KkvCJQhmp2QJeUtrMRLk+5xARxZ8XVHcUjQ=;
  b=J2BMIKbHxtDYR9fGd+CCBWHqugZ9KjkvkYdvCw6Oi7xeEWVpsqSihmWh
   MBt+9CxvNhri2GKGvwCaIHQKyJUkfhLsal87aLeDytm/7jSSM4qEdIQqk
   H7K5JZCx5gIDSLUMp7/MoUTlJHrN/1DRiTXCnrG22t/I6K70ERKP9hQpu
   B/Kuy3zZyl7u7u3900MqQSfq+VHuj00wSGzZsyC44SAA15TwTsbKz7TVA
   o8byBk6uNHM3z/AUr5Wen3lGE2ozHVUdKU9B/f82scQsdm0t+75QAk1X3
   W9a1b/JdtN8CJE9HRC/GnZnjeaQJaqe9BOxg53i7/8l7WUGh++w4uT2PD
   g==;
IronPort-SDR: Ai5mxqGrhOItb8wmXvjiWqOBKt8oztJSJgi7O/R2+KR5Q7jAnn6OLoB1MEPdwH1kuH0xV6+qt+
 kluRo4D7P9iVXJeLF7GWXxjfQ8SA9Jn3nvO9Tu6ptE9Q+iymioza8h8Tt2xxkH+z8PFkrvmKVD
 qJG9A+W7MSC7PXBWYX0+ZGNrt1YFPngRGeTwr79JVexC/y+PQleiWWvyRNQVNQdXLV2NT323Kc
 HLMlmSt14D3VwfmXEOrfhoNa+L1CHw+tZZ3bt3J2Ff+H7R0iiqqThq/vJpMafJMEtGW5Di91Zu
 +NU=
X-IronPort-AV: E=Sophos;i="5.64,394,1559491200"; 
   d="scan'208";a="120610122"
Received: from mail-dm3nam03lp2057.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.57])
  by ob1.hgst.iphmx.com with ESMTP; 17 Aug 2019 01:57:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AejPJKtYZyhDdXm0+6LKfdG9dqCKdOM7lQewK8A3uqQCAFphk1VEebznZh9nsI3CfNFPvRya2QA4CWjPbcGy7xWDmpeYlVhFGQO+vJJCgOnr10duu5DHEqhwnHu58yMl4oJ7Lt6V4LmR3IWPZqWznIk0N/vugiMLPdNk4MvYmYXQcdZHXPg3/6p/F/jc3t5NC8Yrym6pAXwHZ+g7NTuDwLZpQut1yk0fCH9q/IjvfoW4GsseIOO74qwbE5WWYHeatCmaky5EjFNOoNeUXOkPukHscAyHW4qrckd5V5mgit2v0E5p//oVd8l4dFToPrghA/jLQecwUl/vnJknBDFtMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dy5Yqge4KkvCJQhmp2QJeUtrMRLk+5xARxZ8XVHcUjQ=;
 b=O6i8me838Vnz6ZcA6lSYb5Z7xcf9tSNN77T00fT+ACRi52EWXPKmTV8JByl70II5FMmD9Ipd3KdOV/n/H+k3151bGZG7e18wzuGx1K99NUQSq9nXZ+CX6Wjq+rb3nR9YaFOIVO5GQvm8UKNTZWruOAwFVNy8ptiQArWSYYYV7LIFwrWdlb4WVzBhyv7Mrq9tpeDXeQnEb0XDYqnhNISNjq1aAKlD27ZfOL4fTYWrfygOdoj/6ar+gJcOjzHw++0eYSqzIQ3evWY6QD6NRwz+zhs3Hkt++1ewEi9JdFv5SD9HfnUI5UrHEw38H6PZcRYqt7nO+XxLnLVjqlQAHRUWVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dy5Yqge4KkvCJQhmp2QJeUtrMRLk+5xARxZ8XVHcUjQ=;
 b=pjQjbUfgDaEuE7+Usf89JG5LN6q1VnX3THhRN5niQQvzvxYbTjBa7+XPqnDeXr8G8SKq+l4w43SCcw+WKIhWmLl+SWLFMlwrXL+1IqN5F+nNY0xO598kKr5k2opEg/05yEpkAVNr08D0EMvuDDbDtoNvGT5XiPeLMAV8BnINps4=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
 BYAPR04MB4885.namprd04.prod.outlook.com (52.135.232.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Fri, 16 Aug 2019 17:57:30 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::702b:2326:3cee:c07a]) by BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::702b:2326:3cee:c07a%2]) with mapi id 15.20.2157.022; Fri, 16 Aug 2019
 17:57:30 +0000
From:   Alistair Francis <Alistair.Francis@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>
CC:     "anup@brainfault.org" <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: Fix FIXMAP area corruption on RV32 systems
Thread-Topic: [PATCH] RISC-V: Fix FIXMAP area corruption on RV32 systems
Thread-Index: AQHVVCiwkrMhoC888UyZ9cBEv4GnHKb+DtkA
Date:   Fri, 16 Aug 2019 17:57:29 +0000
Message-ID: <4c4831bc93995c54c8df0de14da23b85975f62f8.camel@wdc.com>
References: <20190816114915.4648-1-anup.patel@wdc.com>
In-Reply-To: <20190816114915.4648-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alistair.Francis@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2654ce52-9291-4a5a-d725-08d7227334e2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4885;
x-ms-traffictypediagnostic: BYAPR04MB4885:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB488563E9FD1639D9A64EE9ED90AF0@BYAPR04MB4885.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(199004)(189003)(2906002)(118296001)(25786009)(99286004)(76176011)(256004)(5660300002)(6512007)(6636002)(6116002)(3846002)(316002)(71200400001)(81166006)(2501003)(81156014)(14444005)(6436002)(71190400001)(110136005)(8676002)(54906003)(36756003)(305945005)(2616005)(66476007)(446003)(53936002)(86362001)(229853002)(14454004)(66946007)(64756008)(476003)(478600001)(76116006)(486006)(102836004)(6246003)(7736002)(186003)(4326008)(6506007)(6486002)(8936002)(11346002)(66446008)(66066001)(26005)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4885;H:BYAPR04MB4901.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: f2cNn9lY+IuDvcy0oXkFJJ4q3+KR6LLalg1FuePL4ltyYZcB6+/FDkvFHKyZlS9Iv4CwPaLd7FtttetsAeOXJ7AyhvAKN3QuG+ZRRv2LUho83zm/W5j7m+Su7qH/Vq3ZdRnZz2W1nOXHeBYEZnhgVQji/KzqrnyyLfJyct/lM9uhPzlMdOIXyJ5CqexIElL3mlh/VZcPTAhlEaEIuNI/R8lr9qd4okJrhZldYJa4yFE2I/w2erFRtV1G/i75PaW1IE04x3RzlIw0/+cxzwOnNaHKMIwz0IQSgkQqyYOZXKg0j8Nwu5rvh9aYZ8bBig8a0gmvkQ0jNtQG2F4tygYKcU2Mz+08MBteZTANtv0OnkESNYbDkcWr4fM1KeJ7ZCRZraQNe/4FcAUqFlBJQ1au31tmDlCgrAaLndHvqBBlKGE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF16C60106E8D8428F4B63AFA42C7915@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2654ce52-9291-4a5a-d725-08d7227334e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 17:57:29.8970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3NQV+iKsRMxL8JZOHg7eAvQXRh0uLiUiECt6e6+3mw08m2Joy4AHwbSAjzCzUfRJPAv5utb/sIDDL+kM+hu5IYa9GOw6NEZ+vkxqOCwYcco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4885
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA4LTE2IGF0IDExOjQ5ICswMDAwLCBBbnVwIFBhdGVsIHdyb3RlOg0KPiBD
dXJyZW50bHksIHRoZSBvcmRlciBvZiB2YXJpb3VzIHZpcnR1YWwgbWVtb3J5IGFyZWFzIGluIGlu
Y3JlYXNpbmcNCj4gb3JkZXIgb2YgdmlydHVhbCBhZGRyZXNzZXMgaXMgYXMgZm9sbG93czoNCj4g
MS4gVXNlciBzcGFjZSBhcmVhDQo+IDIuIEZJWE1BUCBhcmVhDQo+IDMuIFZNQUxMT0MgYXJlYQ0K
PiA0LiBLZXJuZWwgYXJlYQ0KPiANCj4gVGhlIHVzZXIgc3BhY2UgYXJlYSBzdGFydHMgYXQgMHgw
IGFuZCBpdCdzIG1heGltdW0gc2l6ZSBpcw0KPiByZXByZXNlbnRlZA0KPiBieSBUQVNLX1NJWkUu
DQo+IA0KPiBPbiBSVjMyIHN5c3RlbXMsIFRBU0tfU0laRSBpcyBkZWZpbmVkIGFzIFZNQUxMT0Nf
U1RBUlQgd2hpY2ggY2F1c2VzDQo+IHRoZQ0KPiB1c2VyIHNwYWNlIGFyZWEgdG8gb3ZlcmxhcCB0
aGUgRklYTUFQIGFyZWEuIFRoaXMgYWxsb3dzIHVzZXIgc3BhY2UNCj4gYXBwcw0KPiB0byBwb3Rl
bnRpYWxseSBjb3JydXB0IHRoZSBGSVhNQVAgYXJlYSBhbmQga2VybmVsIE9GIEFQSXMgd2lsbCBj
cmFzaA0KPiB3aGVuZXZlciB0aGV5IGFjY2VzcyBjb3JydXB0ZWQgRkRUIGluIHRoZSBGSVhNQVAg
YXJlYS4NCj4gDQo+IE9uIFJWNjQgc3lzdGVtcywgVEFTS19TSVpFIGlzIHNldCB0byBmaXhlZCAy
NTZHQiBhbmQgbm8gb3RoZXIgYXJlYXMNCj4gaGFwcGVuIHRvIG92ZXJsYXAgc28gd2UgZG9uJ3Qg
c2VlIGFueSBGSVhNQVAgYXJlYSBjb3JydXB0aW9ucy4NCj4gDQo+IFRoaXMgcGF0Y2ggZml4ZXMg
RklYTUFQIGFyZWEgY29ycnVwdGlvbiBvbiBSVjMyIHN5c3RlbXMgYnkgc2V0dGluZw0KPiBUQVNL
X1NJWkUgdG8gRklYQUREUl9TVEFSVC4gV2UgYWxzbyBtb3ZlIEZJWEFERFJfVE9QLCBGSVhBRERS
X1NJWkUsDQo+IGFuZCBGSVhBRERSX1NUQVJUIGRlZmluZXMgdG8gYXNtL3BndGFibGUuaCBzbyB0
aGF0IHdlIGNhbiBhdm9pZA0KPiBjeWNsaWMNCj4gaGVhZGVyIGluY2x1ZGVzLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQW51cCBQYXRlbCA8YW51cC5wYXRlbEB3ZGMuY29tPg0KDQpUaGlzIGZpeGVz
IHRoZSBSVjMyIGlzc3VlLg0KDQpUZXN0ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWly
LmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gIGFyY2gvcmlzY3YvaW5j
bHVkZS9hc20vZml4bWFwLmggIHwgIDQgLS0tLQ0KPiAgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9w
Z3RhYmxlLmggfCAxMiArKysrKysrKysrLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2lu
Y2x1ZGUvYXNtL2ZpeG1hcC5oDQo+IGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9maXhtYXAuaA0K
PiBpbmRleCA5YzY2MDMzYzNhNTQuLjE2MWYyOGQwNGEwNyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9y
aXNjdi9pbmNsdWRlL2FzbS9maXhtYXAuaA0KPiArKysgYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNt
L2ZpeG1hcC5oDQo+IEBAIC0zMCwxMCArMzAsNiBAQCBlbnVtIGZpeGVkX2FkZHJlc3NlcyB7DQo+
ICAJX19lbmRfb2ZfZml4ZWRfYWRkcmVzc2VzDQo+ICB9Ow0KPiAgDQo+IC0jZGVmaW5lIEZJWEFE
RFJfU0laRQkJKF9fZW5kX29mX2ZpeGVkX2FkZHJlc3NlcyAqIFBBR0VfU0laRSkNCj4gLSNkZWZp
bmUgRklYQUREUl9UT1AJCShWTUFMTE9DX1NUQVJUKQ0KPiAtI2RlZmluZSBGSVhBRERSX1NUQVJU
CQkoRklYQUREUl9UT1AgLSBGSVhBRERSX1NJWkUpDQo+IC0NCj4gICNkZWZpbmUgRklYTUFQX1BB
R0VfSU8JCVBBR0VfS0VSTkVMDQo+ICANCj4gICNkZWZpbmUgX19lYXJseV9zZXRfZml4bWFwCV9f
c2V0X2ZpeG1hcA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9wZ3RhYmxl
LmgNCj4gYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3BndGFibGUuaA0KPiBpbmRleCBhMzY0YWJh
MjNkNTUuLjlkZDA4YTAwNmEyOCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9yaXNjdi9pbmNsdWRlL2Fz
bS9wZ3RhYmxlLmgNCj4gKysrIGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9wZ3RhYmxlLmgNCj4g
QEAgLTQyMCwxNCArNDIwLDIyIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBwZ3RhYmxlX2NhY2hlX2lu
aXQodm9pZCkNCj4gICNkZWZpbmUgVk1BTExPQ19FTkQgICAgICAoUEFHRV9PRkZTRVQgLSAxKQ0K
PiAgI2RlZmluZSBWTUFMTE9DX1NUQVJUICAgIChQQUdFX09GRlNFVCAtIFZNQUxMT0NfU0laRSkN
Cj4gIA0KPiArI2RlZmluZSBGSVhBRERSX1RPUCAgICAgIChWTUFMTE9DX1NUQVJUKQ0KPiArI2lm
ZGVmIENPTkZJR182NEJJVA0KPiArI2RlZmluZSBGSVhBRERSX1NJWkUgICAgIFBNRF9TSVpFDQo+
ICsjZWxzZQ0KPiArI2RlZmluZSBGSVhBRERSX1NJWkUgICAgIFBHRElSX1NJWkUNCj4gKyNlbmRp
Zg0KPiArI2RlZmluZSBGSVhBRERSX1NUQVJUICAgIChGSVhBRERSX1RPUCAtIEZJWEFERFJfU0la
RSkNCj4gKw0KPiAgLyoNCj4gLSAqIFRhc2sgc2l6ZSBpcyAweDQwMDAwMDAwMDAgZm9yIFJWNjQg
b3IgMHhiODAwMDAwIGZvciBSVjMyLg0KPiArICogVGFzayBzaXplIGlzIDB4NDAwMDAwMDAwMCBm
b3IgUlY2NCBvciAweDlmYzAwMDAwIGZvciBSVjMyLg0KPiAgICogTm90ZSB0aGF0IFBHRElSX1NJ
WkUgbXVzdCBldmVubHkgZGl2aWRlIFRBU0tfU0laRS4NCj4gICAqLw0KPiAgI2lmZGVmIENPTkZJ
R182NEJJVA0KPiAgI2RlZmluZSBUQVNLX1NJWkUgKFBHRElSX1NJWkUgKiBQVFJTX1BFUl9QR0Qg
LyAyKQ0KPiAgI2Vsc2UNCj4gLSNkZWZpbmUgVEFTS19TSVpFIFZNQUxMT0NfU1RBUlQNCj4gKyNk
ZWZpbmUgVEFTS19TSVpFIEZJWEFERFJfU1RBUlQNCj4gICNlbmRpZg0KPiAgDQo+ICAjaW5jbHVk
ZSA8YXNtLWdlbmVyaWMvcGd0YWJsZS5oPg0K
