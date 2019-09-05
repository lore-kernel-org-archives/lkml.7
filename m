Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80142C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 06:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0B82145D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 06:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="m1934IDY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ps3KsSys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731539AbfIEGVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 02:21:12 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:22625 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731095AbfIEGVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 02:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1567664471; x=1599200471;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JzndiPsjMZDobhc6IsEFGhRIFcASWkXnm8leedOg6+Y=;
  b=m1934IDYV0WxxdwUrpjT1L2rAw7F0HSlAU5SHE4DA1KGqUF7bmfg8fgG
   3uXe1mfG8qS3cB0vRAVagVqeOUu1X9Zv+w9MLAs60iH8cXf4xFaORG3Db
   VG2KOSzPp5beO2U9274jsj6nFuwDs/7J4ho+eqj93y7CCfrvU814cuAn8
   nEIaMV3bRJk3kGSSaDazbICkFd6zgavSH/CDX58x7iXFricvUtf9P/wdl
   ES6LDMp378gCJODIFr9MEHC2JrptwZD27NlzrmrJ9ghXv6J/Nwvlw1XLU
   2F6fjVDiBkHc6GDJsTnMqbOFJyMKteHIFncOfyihSugP2BwG9kv6H2cAm
   A==;
IronPort-SDR: bSYgU5uliINj3AdarGoniuv/S5LiFgsaeRjH6onPH+2J6eBP0FJfQMve/t4uJP+FigH2oVKrgg
 R1MN1ktPXOOaXTr6K488JhLLjBvwtGrHGZAenRyUa205WzZwajKdNoUggqZpVJ9Aw/dKOCI+iu
 MOKV5ZbmhgdFb6vA0U6yd8ByU3uUyZVvcUYR8OY3UDunDqQZQ6q5c92xxUfcxVntPJwk9M6Mw8
 qE8qO2+VTynZa6QxLxW/e/yYQiAC3QUewmMUH8KSmBRWN6vYeffrolxZ+xfp02wX5aeTPxs094
 LmI=
X-IronPort-AV: E=Sophos;i="5.64,469,1559491200"; 
   d="scan'208";a="118406040"
Received: from mail-co1nam04lp2054.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.54])
  by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2019 14:21:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEKwqp0u4bmt5z+fFUjEvhG6fflRSJRgQYvEIkn2rVcqylhWRHeC4ZmXtP83w1bOHGVvNbfPGn1iOEoUNr+R/FuOqggRoxpgYaOMzIampRg8ubM5Ljvpa+z1Hn4jcnCcONj2sTx9jTvUmRnU0Tgv8ButeocJLotXKKYBRbGQCZxb9w6AhN1mrfq95XhMSnH2m3uKJrGTCreEUHfTyta2vNWJEhlGyC4sqODaQFAEkdt7UunABaJjS8W4wyS3Kyo6Mh3n5nKWK4mc8z1Qa/4dP7MyAEHKyZruW96DDhBE+Ze4rUrksCUWD9Owntk1ktWLmpstIEQ2oTuApDi8lEgUzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzndiPsjMZDobhc6IsEFGhRIFcASWkXnm8leedOg6+Y=;
 b=g7JiXw0u8dVBEIT6KSonEQYBXF891QRqWaULrbGjyhze0xA1a9S3xvjLlscxjOk2tnp0nybJCqRDcSLew8/YtPj37UdxOHgXJYZs5SzuGKu6Cp0A35jJmbEQMJEnXg6+Bl2KRG5xNra2kDLa/fhWJzucBfl/34Qjl2cW/5Wnpmall0hy/jAiu1tRSf8qZZS1lKw1RLcseiBQ+LCFK6JuduCggb7v0Qqin0ueCzOvmYW6XpqBen8w/VWAozXaC1dGnO8qiAM03sM1SYm2xhPZtomUtaoyWi9aQfPTpapvDs2/ANWzioXBSk/cDHMRhR/Jyuy7YsftagP8mYcRgkTS+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzndiPsjMZDobhc6IsEFGhRIFcASWkXnm8leedOg6+Y=;
 b=Ps3KsSys7ISl4GftQeF8i0WvgAYjPWv1C2zEI/aYvIQnjLsEyimWNcOREz3ARdspq3R7c5qSRFekNxTQzzaG+Mf/bZ7B/hTGpG+PX2vLgxT/RPwKsIrxXscWEufU6815cbHNdPGK9uCK4hLL4+xelyzvPBVfL+vhIaWUQxGH9ck=
Received: from MN2PR04MB6991.namprd04.prod.outlook.com (10.186.144.209) by
 MN2PR04MB6013.namprd04.prod.outlook.com (20.178.246.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Thu, 5 Sep 2019 06:21:07 +0000
Received: from MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::9c2b:ac1b:67b8:f371]) by MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::9c2b:ac1b:67b8:f371%2]) with mapi id 15.20.2220.022; Thu, 5 Sep 2019
 06:21:07 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Chaotian Jing <chaotian.jing@mediatek.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        YueHaibing <yuehaibing@huawei.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ming Lei <ming.lei@redhat.com>, Chris Boot <bootc@bootc.net>,
        Zachary Hays <zhays@lexmark.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>
Subject: RE: [PATCH 2/2] mmc: block: add CMD13 polling for ioctl() cmd with
 R1B response
Thread-Topic: [PATCH 2/2] mmc: block: add CMD13 polling for ioctl() cmd with
 R1B response
Thread-Index: AQHVYvYWr7zFcN7xD0GIE0WcESsTdacbjhBAgADWzACAADk94A==
Date:   Thu, 5 Sep 2019 06:21:07 +0000
Message-ID: <MN2PR04MB6991B08ECDBC4021AEFDD06EFCBB0@MN2PR04MB6991.namprd04.prod.outlook.com>
References: <20190904075444.2163-1-chaotian.jing@mediatek.com>
         <20190904075444.2163-3-chaotian.jing@mediatek.com>
         <MN2PR04MB6991F51F6DDCA28FC23D02FEFCB80@MN2PR04MB6991.namprd04.prod.outlook.com>
 <1567652136.11483.1.camel@mhfsdcap03>
In-Reply-To: <1567652136.11483.1.camel@mhfsdcap03>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 510bf163-0fda-4a89-a62c-08d731c93ce2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR04MB6013;
x-ms-traffictypediagnostic: MN2PR04MB6013:
x-microsoft-antispam-prvs: <MN2PR04MB60139125FB24DEE42304DBC2FCBB0@MN2PR04MB6013.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(189003)(199004)(7696005)(6916009)(8676002)(71200400001)(186003)(81166006)(81156014)(66066001)(6506007)(74316002)(9686003)(71190400001)(4744005)(6246003)(26005)(86362001)(54906003)(33656002)(8936002)(256004)(478600001)(14444005)(7416002)(66556008)(66476007)(229853002)(486006)(5660300002)(53936002)(64756008)(11346002)(316002)(476003)(2906002)(66446008)(76116006)(102836004)(7736002)(76176011)(446003)(14454004)(55016002)(3846002)(6116002)(305945005)(52536014)(6436002)(66946007)(99286004)(4326008)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6013;H:MN2PR04MB6991.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UK7u3aP7762IqznTlVJE7b9oqTe9+3sPYTZC2ahN4fYm9qGytOUAl5l6Ojtx14XJL3CUVTbyCJX+bt9d2XxrnPfRgFXFtRCDMRZnXX6i8P67akrnayL2TvzuIjQos1r5ALejgIFtMLVkwW+lXZknP+HZ3pAqU8q27F2wG+uxrcORYuUjaIgrnbrEEaK0Mlbg2KxWby/Jox6hjfsWmGXEcEA6VbCnLO2ynCd+xSKPdDHni+qWTbnCCLFLlzX477Bb981+JH8CFUmXdcS3P+7uCoLLFK88dWEEEfR9IkO8zdO1GAUACxycKx8LHGDarFU1JnVUNcyLx7uDftZ9fIj31PJFwNhD44mBud/LXukS1MIvB+eTLTfhv05DySAoI0erxeB8NQaAwiOcEQ7mR2JNSNFFoDYDe6Rr0AwCcNqsRO8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510bf163-0fda-4a89-a62c-08d731c93ce2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 06:21:07.4027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AP+mBR+snI8ts7umKQ5HKNsDYJgFDzRE+4XeeHIxvXknh3SabjC1Ub9hd9SgQcKi1I0+VBjzeirCrP+mUSqksg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiBPbiBXZWQsIDIwMTktMDktMDQgYXQgMTQ6MTEgKzAwMDAsIEF2cmkgQWx0bWFuIHdyb3Rl
Og0KPiA+ID4gIHN0YXRpYyBpbnQgX19tbWNfYmxrX2lvY3RsX2NtZChzdHJ1Y3QgbW1jX2NhcmQg
KmNhcmQsIHN0cnVjdA0KPiA+ID4gbW1jX2Jsa19kYXRhICptZCwNCj4gPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgbW1jX2Jsa19pb2NfZGF0YSAqaWRhdGEpDQo+ID4g
PiAgew0KPiA+ID4gQEAgLTYyMyw2ICs2NzUsOSBAQCBzdGF0aWMgaW50IF9fbW1jX2Jsa19pb2N0
bF9jbWQoc3RydWN0DQo+IG1tY19jYXJkDQo+ID4gPiAqY2FyZCwgc3RydWN0IG1tY19ibGtfZGF0
YSAqbWQsDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19m
dW5jX18sIHN0YXR1cywgZXJyKTsNCj4gPiA+ICAgICAgICAgfQ0KPiA+ID4NCj4gPiA+ICsgICAg
ICAgaWYgKCFlcnIgJiYgKGNtZC5mbGFncyAmIE1NQ19SU1BfUjFCKSkNCj4gPiA+ICsgICAgICAg
ICAgICAgICBlcnIgPSBjYXJkX2J1c3lfZGV0ZWN0KGNhcmQsIE1NQ19CTEtfVElNRU9VVF9NUywN
Cj4gTlVMTCk7DQo+ID4gPiArDQo+ID4gPiAgICAgICAgIHJldHVybiBlcnI7DQo+ID4gPiAgfQ0K
PiA+IFlvdSBoYXZlIGJvdGggdGhlIFIxQiBmbGFnIGNoZWNrLCBhbmQgc3RhdHVzIHBvbGwgKGZv
ciBycG1iKSBmZXcgbGluZQ0KPiBhYm92ZS4NCj4gPiBNYXliZSB5b3UgY291bGQgcmUtdXNlIGl0
Lg0KPiA+IEl0IHdpbGwgYm90aCBzaW1wbGlmeSB0aGlzIHBhdGNoLCBhbmQgc2F2ZSB0aGUgdGFk
IG9wdGltaXphdGlvbiBvZiB5b3VyDQo+IGZpcnN0IHBhdGNoLg0KPiA+DQo+ID4gVGhhbmtzLA0K
PiA+IEF2cmkNCj4gDQo+IFNvIHRoYXQgd2UgY2FuIGRyb3AgdGhlIGlvY3RsX3JwbWJfY2FyZF9z
dGF0dXNfcG9sbCgpIGFzIGl0IGRvIGFsbW9zdA0KPiB0aGUgc2FtZSB0aGluZyB3aXRoIGNhcmRf
YnVzeV9kZXRlY3QoKS4NCj4gDQpyaWdodA0K
