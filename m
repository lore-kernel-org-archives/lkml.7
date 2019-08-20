Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E431C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 21:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C4E22DD6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 21:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PdpNpwOU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QV4RKzbl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbfHTVHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 17:07:38 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34519 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730430AbfHTVHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 17:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566335257; x=1597871257;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lg2eiHbNdu35tpKjborwPu56J3ZKSwTjSK72KMsv+yM=;
  b=PdpNpwOU/HMUt8bQFCW4lktPGBEFXm1Q6Fm0KvYvH0WPuZEyeiJfRDmW
   zU/4KoLLp8z+WZUJREBzXQiPKHMv8LAaOKcZaT2a/eiK2uuqyL87FGnKn
   VdPNJUIkPuLI7BzSyQeNgDjoqAxpjtKeOOF7GQFj/rVD0dH4CADAaX4kv
   WCoP/DzP7VMdU0BChKpzJ7vtI3ZhdeAMCj4K5//D2lJFH7jffxE4euCHJ
   S+P7Vj+gDzRmROrXmcYmiHRM2pjvmbj8QRSRQdaPevkZU1N7m3EN4s1WV
   qTTj/rnWnI5ykSb0TgafIpEM+bpyQSK4FuDJlV4O1uZdwR7poqS0Yne25
   w==;
IronPort-SDR: bhq1LvUR0eko0vF2Gmb57cAo6BFJQZk/lV7k4v8QuFijh9rcvPIbudkNu8mUEGU0sLnIAJyRQH
 h2aD3y7e9DHHy7y3thHN7Iy/51Apxxb5ub7I+tW7xG97T25B5GVwtYwRkRISFjavMqgXlVYH02
 +Xdu2vUsAURncqmRgccdEhQBqSBen/Bvkw2HVOgbwszzzsjo+UTSeCW5YY8/1aZcVAJfeo/3Xu
 pLR0+wbTCOWBEE+eHARVKYGQTWh3ojgKAcQWf4/G8JlObnC1WWGKygfZ/FlMob1z3b0VpzRFFW
 TDk=
X-IronPort-AV: E=Sophos;i="5.64,410,1559491200"; 
   d="scan'208";a="117213749"
Received: from mail-cys01nam02lp2053.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.53])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2019 05:07:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0fvXDcr190O92OgE9jDCpxrZnpc/ZOWu2pndvzokJveU42sJaXEnHHbSbSOC7II/nWz/HQt5K9QNHxLjrFuhXsbX6xutc6iUGD7PL6XI2ZiTF5M42aG3o+vZt1sqUgLvhk7FW+LqprjrWd03iAZx1h7z4KoVvhYzlhvAftJETEuMW4K0VUUS4XgEFofd77L2vjZHPbwrsBbXkVQAmoF0Bcv84gPAMqDSc1/88EZ0pKE2v4qmNokMrK7VRnW4nKB45+2ha+CFddOFCtJsyPUJagv/ocso3wJbn+ASxd2LpZNRt4YEp4jZhneqQeP5MGPYQp8f6F8Cc07OFyhPKfK2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lg2eiHbNdu35tpKjborwPu56J3ZKSwTjSK72KMsv+yM=;
 b=Eu6UUvBFMD+HzfCrocwcS6lZpkoQ/iJHLM+Cy204L35eehRUK0h55FFbj+bcPX5Q1TX0u0EOwUYZzTQTgZmVGy3DhagGbQHA6gPtginSzCVDVfMsiWPcpfd7EfiO6pIL4EN6wTLdxkAam685TlrdV/a2mFu4EmasTF55yIvPi4jrPUU7X0xXdt1pFrw+vv5E4EP2F/2ckAlbo7tV2IiQUqnQbxaJ2PMfb6kCU+NR1pYe6NK+1fVfSYGpDGmCGWtA1Iv7MBx4hQEJtBxOSRAHGWU3MeVlEUOi65LNAsQWGgrWGRjIgCEO4zhSBJDvB3C4jblpDxULUrjvszUQq5Op/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lg2eiHbNdu35tpKjborwPu56J3ZKSwTjSK72KMsv+yM=;
 b=QV4RKzbljOmpxMzzAuBJ7s4aEqFrZqVsn0Fa+9bW94DNpeAuZPVOvBWm4PMoAW4N1coTujdTGX9JkZG0ygi0whS90H55w+aPgCP+WsLyxRnUWUlyiTGqb4ntv/7dOvroILwB5CN0ODtetFWO5ceUyIgWHWhOhQV0KpbQz05DKbc=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB5558.namprd04.prod.outlook.com (20.178.232.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Tue, 20 Aug 2019 21:07:35 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e%4]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 21:07:35 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "hch@lst.de" <hch@lst.de>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@sifive.com" <palmer@sifive.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 15/15] riscv: disable the EFI PECOFF header for M-mode
Thread-Topic: [PATCH 15/15] riscv: disable the EFI PECOFF header for M-mode
Thread-Index: AQHVUe6heiXEpXRItkaw7Sqy5taBjacEkrUA
Date:   Tue, 20 Aug 2019 21:07:35 +0000
Message-ID: <2c27e4f4a551720e2ca029743109eb02fe7d88e4.camel@wdc.com>
References: <20190813154747.24256-1-hch@lst.de>
         <20190813154747.24256-16-hch@lst.de>
In-Reply-To: <20190813154747.24256-16-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d1818a6-0ab6-4f00-ab59-08d725b26ca6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB5558;
x-ms-traffictypediagnostic: BYAPR04MB5558:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB555818EFE9CDA2AD0A43C408FAAB0@BYAPR04MB5558.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(199004)(189003)(66066001)(14454004)(76176011)(2201001)(2501003)(6246003)(36756003)(86362001)(54906003)(66556008)(66946007)(110136005)(66476007)(81166006)(64756008)(66446008)(4744005)(99286004)(81156014)(316002)(53936002)(6116002)(76116006)(3846002)(71200400001)(8676002)(4326008)(71190400001)(229853002)(118296001)(256004)(186003)(6506007)(8936002)(486006)(476003)(478600001)(7736002)(5660300002)(6436002)(6486002)(6512007)(25786009)(11346002)(26005)(305945005)(102836004)(446003)(2906002)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5558;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Eu7abcfyO3uqGUko29N1+/V07+FEGsqCa50YriCtKrzVdGXHd4LnMLqDFUqMOmDz3zPwWIA7vyOPTSBzwlQZW9go+ntuYhKLq33mU49MUBs+1HLmyUFc/ouIgQW+2Sk9suycnaPeFKhbHqqIyFIS9Br4XD8011g0yCyZL/mKWXgGvo2TAp0gOFebW/U586wJfwZVy+RZPMtqqgSN3yJUyDwuVjZSihON58pT6D0gQcC8M94xdpdzuPauJHIIVau0iexVJFP1viZxf/AHdd5hUasAd9A/855IZLMJ7TCF2lucC2neceSCLA0J6bO12/2sxu7XDmQjaSRRtC37RFeBOxGfG70hKSUZj3CP72smRmPzvyFNWubDD4Bx5EJsSk0nx9Xit0YHsZRKtHm94baUdooZKTSQhbYAFs3g43jqNFA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01F1EF9B1A69A748996005328B675529@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1818a6-0ab6-4f00-ab59-08d725b26ca6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 21:07:35.2503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ppivzroo3wAEijcPx/8IBtKHyx+oZDCN+TZePDKbojDiGDOiOBkEfVoAM5v6yzt7SX/Q8nCdf0chJ/ItT/aYRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5558
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTEzIGF0IDE3OjQ3ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gTm8gcG9pbnQgaW4gYmxvYXRpbmcgdGhlIGtlcm5lbCBpbWFnZSB3aXRoIGEgYm9vdGxv
YWRlciBoZWFkZXIgaWYNCj4gd2UgcnVuIGJhcmUgbWV0YWwuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gLS0tDQo+ICBhcmNoL3Jpc2N2L2tl
cm5lbC9oZWFkLlMgfCAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9rZXJuZWwvaGVhZC5TIGIvYXJjaC9yaXNjdi9r
ZXJuZWwvaGVhZC5TDQo+IGluZGV4IDY3MGU1Y2FjYjI0ZS4uMDlmY2YzZDAwMGMwIDEwMDY0NA0K
PiAtLS0gYS9hcmNoL3Jpc2N2L2tlcm5lbC9oZWFkLlMNCj4gKysrIGIvYXJjaC9yaXNjdi9rZXJu
ZWwvaGVhZC5TDQo+IEBAIC0xNiw2ICsxNiw3IEBADQo+ICANCj4gIF9fSU5JVA0KPiAgRU5UUlko
X3N0YXJ0KQ0KPiArI2lmbmRlZiBDT05GSUdfTV9NT0RFDQo+ICAJLyoNCj4gIAkgKiBJbWFnZSBo
ZWFkZXIgZXhwZWN0ZWQgYnkgTGludXggYm9vdC1sb2FkZXJzLiBUaGUgaW1hZ2UNCj4gaGVhZGVy
IGRhdGENCj4gIAkgKiBzdHJ1Y3R1cmUgaXMgZGVzY3JpYmVkIGluIGFzbS9pbWFnZS5oLg0KPiBA
QCAtNDcsNiArNDgsNyBAQCBFTlRSWShfc3RhcnQpDQo+ICANCj4gIC5nbG9iYWwgX3N0YXJ0X2tl
cm5lbA0KPiAgX3N0YXJ0X2tlcm5lbDoNCj4gKyNlbmRpZiAvKiBDT05GSUdfTV9NT0RFICovDQo+
ICAJLyogTWFzayBhbGwgaW50ZXJydXB0cyAqLw0KPiAgCWNzcncgQ1NSX1hJRSwgemVybw0KPiAg
CWNzcncgQ1NSX1hJUCwgemVybw0KDQpSZXZpZXdlZC1ieTogQXRpc2ggUGF0cmEgPGF0aXNoLnBh
dHJhQHdkYy5jb20+DQoNCi0tIA0KUmVnYXJkcywNCkF0aXNoDQo=
