Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE43C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A5A206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kYGAoyVC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RfqzLov5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfGASvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 14:51:48 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:30374 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGASvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 14:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562007107; x=1593543107;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wsFMrpFkypitlxZTPfuvrvWi2NGHfqSRrPvaLJ+D9eg=;
  b=kYGAoyVC8Nv7hTt18o2gjmAHGshLQeZ2OPyN+1GOrDFEOy+7rcpUfiRh
   bfxhNF4KA92sywV6dT8tcGDLByVS41kejU7c/HEzHuEoXpttLZI2xIr58
   SP26joNgJnXTyvwW63lXejRznnZMlsOZ4sM3/ur8aV1+5CEOlKKvAuyqJ
   ViceMsWlpatzAhnVU7cvx7IiLIXpUuKWywznAmhMcWZEF7xnWssqsPY+A
   3R66F7pzZ9DJ0Ms30uiRJDN7RMZbb2D1/9UQHdeYZfdsb03U8ergsQA8k
   J4B4g8cIZk2COaKy76WfT/SPbIL9WzNaqXneAwPdsC6ZlGZRr3ssU/t5O
   g==;
X-IronPort-AV: E=Sophos;i="5.63,440,1557158400"; 
   d="scan'208";a="113181740"
Received: from mail-dm3nam05lp2056.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.56])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2019 02:51:44 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsFMrpFkypitlxZTPfuvrvWi2NGHfqSRrPvaLJ+D9eg=;
 b=RfqzLov5NarLkM8BxjVMolrawSzZ7kxcMuH4T2bEZWPiciRW50zB0SlovdIj0CESN6p6JBqw6h40OWfHNQH7MSu6XR6bV6Nuo37FzXTdbd9x8C0FrhJgcR2lVkqg/HS5Kvc6x0muW1IX7d5d3ASy83QbIGjKMqqq2s0e06xF1Z0=
Received: from BYAPR04MB3782.namprd04.prod.outlook.com (52.135.214.142) by
 BYAPR04MB5573.namprd04.prod.outlook.com (20.178.232.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Mon, 1 Jul 2019 18:51:43 +0000
Received: from BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::65e3:6069:d7d5:90a2]) by BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::65e3:6069:d7d5:90a2%5]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 18:51:43 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "morten.rasmussen@arm.com" <morten.rasmussen@arm.com>,
        "ottosabart@seberm.com" <ottosabart@seberm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "johan@kernel.org" <johan@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 0/7] Unify CPU topology across ARM & RISC-V
Thread-Topic: [PATCH v8 0/7] Unify CPU topology across ARM & RISC-V
Thread-Index: AQHVLSJGz+hI7exIqkGm7p6W+lzWB6a2H8CAgAACBYA=
Date:   Mon, 1 Jul 2019 18:51:42 +0000
Message-ID: <5f31cb3c576bdbd89665614582af66d04ece8f29.camel@wdc.com>
References: <20190627195302.28300-1-atish.patra@wdc.com>
         <alpine.DEB.2.21.9999.1907011143520.3867@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1907011143520.3867@viisi.sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13061295-fae4-4586-376b-08d6fe5528e2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5573;
x-ms-traffictypediagnostic: BYAPR04MB5573:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB55733C91F6FA52B2049E51D1FAF90@BYAPR04MB5573.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(189003)(199004)(73956011)(99286004)(53936002)(76116006)(476003)(229853002)(66066001)(486006)(316002)(71190400001)(256004)(71200400001)(81156014)(66946007)(6512007)(4326008)(36756003)(6506007)(446003)(66556008)(11346002)(6916009)(66476007)(54906003)(14454004)(7736002)(26005)(2501003)(66446008)(118296001)(68736007)(2351001)(2616005)(64756008)(478600001)(6246003)(72206003)(186003)(8936002)(5640700003)(558084003)(2906002)(305945005)(7416002)(76176011)(102836004)(6436002)(6116002)(3846002)(6486002)(86362001)(81166006)(8676002)(25786009)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5573;H:BYAPR04MB3782.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IF9yspacXgspoXBZOzePbf2cN0MuQl7fXZl5Jtw8FqSwpsLOjcIpk+GqwhGBqkNTCJrFcPv25KNNuBwQHOhrcfuRKS/z2yz5jr7IdakI4L8EmH0E/TRoZ+PThfdzNqrmilooHS4vFSjEeEVh/dol9E2vtXuAFmJOi6LxcUpuKJt3mh5skEXZ5ifOKIPh0rbe/C/lhO7ALP4+k2qQeIRh8Tbmw9cEX44LIEhkXB6XFm4ze+HKYVnXfdkUqkmKTwR2OdSCzLWXAeVrIrQYJxaBA8372tH3lOjphjDHF14637IzEb5STCFGQ8e/BYM4t/0Jsip3uFSO+jPXCW3kXPExjUMtG/XtUS8BsGQPj6VzUrBUVp/902X5i6aGbw5L7dhpo8GiWUUH2vVRwUKKjsgPd3RNjf4vAES0gO9W1qgQs4c=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7966FEDC0A0FA4DAA6BF6422A399875@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13061295-fae4-4586-376b-08d6fe5528e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 18:51:42.8544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Atish.Patra@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5573
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA3LTAxIGF0IDExOjQ0IC0wNzAwLCBQYXVsIFdhbG1zbGV5IHdyb3RlOg0K
PiBIaSBBdGlzaA0KPiANCj4gTG9va3MgbGlrZSBwYXRjaGVzIDEsIDYsIGFuZCA3IGFyZSBtaXNz
aW5nIHlvdXIgU2lnbmVkLW9mZi1ieTouICBDYW4NCj4gSSBhZGQgDQo+IHRob3NlPw0KPiANClN1
cmUuIA0KDQpJcyBpdCBhIGNvbW1vbiBwcmFjdGljZSB0byBhZGQgIlNpZ25lZC1vZmYtYnk6IiB0
aGUgc2VuZGVyIGV2ZW4gaWYgdGhlDQpzZW5kZXIgaGFzIG5vdCB0b3VjaGVkIHRoZSBwYXRjaCBh
dCBhbGw/DQoNClJlZ2FyZHMsDQpBdGlzaA0KPiANCj4gLSBQYXVsDQoNCg==
