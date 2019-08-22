Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8A7C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 04:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B062173E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 04:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TfccMPnj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="i29054aY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfHVECj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 00:02:39 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:29075 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfHVECj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 00:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566446559; x=1597982559;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ND1nGQ8bqpkMIG0pvJdhmSnmm9KRShiJey+RKhXNddg=;
  b=TfccMPnjaazoYuS+3ZJf3xWlKZWVLmrKAdEkfwsdpWlpxAzbT3BCiZj9
   uhBi1t8A+IStoCnfrbLD5ztS//9EM9mK8mMI+gIPZc60d1zLWX5wLt2P2
   i2LAhNg2WUBzCWeu82rdLV/IsCYxOTuxd6gPgeyWgze6CwTPUmrHV145T
   4o5zJkRmiCFOzMUQM82JL2vyx7lDxt01AjPYJulH7uffiNa2Gr24uU/9w
   ArScYMPrbAQID+uCBTRrHa2Nv2rUTmJ4HtYe8/MWqvTjWd9wnSm5zorqX
   38x0WAHzHcFxMeXxtvjco7Wbzoy4MLyHgAGg15t7Dr9D66ky8+vVpTDG7
   Q==;
IronPort-SDR: aWZ3kVPGkGe8UxUvAhTq0y/+wHCzLSgJ7T8NrCTIoYhvTGbNLXB4Ya7dUuxngHjYebI9IaSKo9
 B0eABniUwjhuZMQZTyAcr7gsgVN9LEQF5a6R+oc2WaGUqBlH57Xa5oSvh2gEU80Qa5mg8D0BRS
 zmevCBIdbfkqvySVkfyKt3rUll8Cbw4iFhl4UW/9QmWzLdG3TiDihXKMExhdmQAhbvyX9ub/rc
 AVDIbxTzqm/leU7xLwZ9HdfCfEA8tTIZWY6fR85/Nx5E1h2XrzIqv2NnYrf+l8Z2z/oGwwLFNW
 Itk=
X-IronPort-AV: E=Sophos;i="5.64,415,1559491200"; 
   d="scan'208";a="117983718"
Received: from mail-by2nam05lp2050.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.50])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2019 12:02:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBOWKlwNrCTfK5GDfk+OYdBOoiOXSLkgnjnszGn4ka5FOHwretMLxsIPdx4O7th045g7XG3QZCcgdK3iSNpk31OFf//6nK0C+2WLEjbF+xl2eKKYbIL4tHv9fzxA6CVOfz2ekn8MRRZWUV8rOO2rrFbQMWMpLr2mLKkggfX/KT+7IDVZSxICC6bj84Qnc3tXPE+DJrZqgCCROMjhmXzMO6yFSTX/Oy4Y6iQyqrryAggpgK6hiwGkZJuKiMH9S2tffWYwIavryM0yRCOEnDEsuMEUlxP9ASIy8yivVRM/Y8fOKS2FT4Ihhx26q+UowPumhqDcMFuRKwb3yl/A4r1Bkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ND1nGQ8bqpkMIG0pvJdhmSnmm9KRShiJey+RKhXNddg=;
 b=QlGpQVoaGyOAjuoh29lzPsg5IyT6aFsWGRtAFBBfnG1VdoFuETpK/neK3htzwUBZCRT+OHOqfdtszJo6PNblVUXq07Iix7tqQ9JoKK30Jd5uvMd7F68F9GWgSBlvv/tz37xdlSoAFpsFMlI4LZXZ3NFcZ2OkJkX+GSAYbE0qmvyuLYwjDdTsJ6Q2TIG6kHNNKspw5EIksVbJ3eHzLsWK1oQqIerlbEXd9UNn5pqQ/ufCAVhBpn3oveX3prVof3tUK+yX/qVAVW332qinTh1GP66AZ2xbhlf/F4MRU1rj8wmpX5QA7UcIsonx73H98YZg+wUN/duhaxwCaXefBVh8gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ND1nGQ8bqpkMIG0pvJdhmSnmm9KRShiJey+RKhXNddg=;
 b=i29054aYh44dNc4wVx7+luqomc6GOqEY5DQUzJoT5iYZB1/wvAJFZtGPJLcR9DKiCnzlSIL9D/OmCGeQQ3+BUs3LZXHCEccozIDfONY3FSt00XVCEOojf72W0IqQsWy220ryeXoYUfXaoCKhKWBUWVqmRIfmQJwXRQIlmhIK1hs=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB4327.namprd04.prod.outlook.com (20.176.251.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Thu, 22 Aug 2019 04:02:37 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e%4]) with mapi id 15.20.2178.018; Thu, 22 Aug 2019
 04:02:37 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "schwab@linux-m68k.org" <schwab@linux-m68k.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v3 2/3] RISC-V: Issue a tlb page flush if possible
Thread-Topic: [PATCH v3 2/3] RISC-V: Issue a tlb page flush if possible
Thread-Index: AQHVWIMWqGgK8YbL3kacpUgQ7SWAx6cGZuqAgAAk7AA=
Date:   Thu, 22 Aug 2019 04:02:37 +0000
Message-ID: <410fd58810a91a62869c639bed38fdd671eec5a6.camel@wdc.com>
References: <20190822004644.25829-1-atish.patra@wdc.com>
         <20190822004644.25829-3-atish.patra@wdc.com>
         <20190822015027.GB11922@lst.de>
In-Reply-To: <20190822015027.GB11922@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [2601:646:8280:fdf0:69be:1cca:a557:65ea]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69b22063-aa4b-468d-d816-08d726b59201
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4327;
x-ms-traffictypediagnostic: BYAPR04MB4327:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4327BDB255B3A6546EA1C8B9FAA50@BYAPR04MB4327.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(6916009)(6486002)(46003)(2616005)(66556008)(305945005)(7736002)(66946007)(6512007)(4744005)(6506007)(5660300002)(66446008)(64756008)(476003)(6436002)(5640700003)(446003)(11346002)(76116006)(486006)(36756003)(66476007)(102836004)(118296001)(316002)(186003)(53936002)(229853002)(8936002)(76176011)(86362001)(2351001)(6246003)(4326008)(1730700003)(81166006)(81156014)(25786009)(99286004)(8676002)(478600001)(256004)(71200400001)(54906003)(2906002)(14454004)(71190400001)(6116002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4327;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Li3ciGRtyPi2FXmhKS9VS+z/DWDuB5dsLwIYRipiifKKu9xE3w1FEVl8p9jiLopkubMVbryL2AgnIcIXzrSXjd6A+5I3j7Vso62wgeLvVhVMq3lUeVY7Y4bYRJdcC4sVp9p/js8MLuVUq+4s9EQjaUNuYkb/pPpTzgvQAqzkjVbSSvhRm/Dha8FsqAnYxkSnEYwyQE5ByqYxSb5bD1lftv59kO3KMUeH4ZNVKhjKTRI06LAJatsf+2P1LOHkQwVjYHz1lCEos3RHg03V+wwK9Kuf/CERa08p4Mh07GQEzfcCCUJaFJ3jWcPCKPNx1ARApL6brR7E7Rd2X/htgsZFGGOclz/pU4pafA58F4pWr5q74wQC8ZKWp6UwLjPMwUnlfKwL+upa7CLU4616JqMauRMr8yz9uhDyT2DHeYHKmPA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E457A02CA41D4D4780412E445645B654@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b22063-aa4b-468d-d816-08d726b59201
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 04:02:37.5325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vJq7gGyIWTK8RBrdMhMi/QUTh4QrHTNbdTXYQ0GPsVKTpXB2VlbH9rt8DVjMirO1LUdMAYzbvjC2ctd2ldCPpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4327
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTA4LTIyIGF0IDAzOjUwICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gV2VkLCBBdWcgMjEsIDIwMTkgYXQgMDU6NDY6NDNQTSAtMDcwMCwgQXRpc2ggUGF0
cmEgd3JvdGU6DQo+ID4gKwkJaWYgKHNpemUgPD0gUEFHRV9TSVpFICYmIHNpemUgIT0gLTEpDQo+
ID4gKwkJCWxvY2FsX2ZsdXNoX3RsYl9wYWdlKHN0YXJ0KTsNCj4gPiArCQllbHNlDQo+ID4gKwkJ
CWxvY2FsX2ZsdXNoX3RsYl9hbGwoKTsNCj4gDQo+IEFzIEFuZHJlYXMgcG9pbnRlZCBvdXQgKHVu
c2lnbmVkIGxvbmcpLTEgaXMgYWN0dWFsbHkgbGFyZ2VyIHRoYW4NCj4gUEFHRV9TSVpFLCBzbyB3
ZSBkb24ndCBuZWVkIHRoZSBleHRyYSBjaGVjay4NCg0KQWhoIHllcy4gU29ycnkgSSBtaXNzZWQg
aGlzIGNvbW1lbnQgaW4gdGhlIGVhcmxpZXIgZW1haWwuIEZpeGVkIGl0Lg0KDQotLSANClJlZ2Fy
ZHMsDQpBdGlzaA0K
