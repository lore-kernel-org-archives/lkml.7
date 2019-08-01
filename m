Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8F0C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4357620657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nKNSOHsH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mBUDCkSJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390216AbfHAXEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 19:04:31 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:49765 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390169AbfHAXE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564700666; x=1596236666;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MqBQQUd6DHFKduRJ3LeyM7a4nbVQglmWhUtFIbDn14c=;
  b=nKNSOHsH17pqavaVCEIuUjsZXFbvd626tCXYDITAwtiiNV5ibNJ3RnhC
   6lk6ELrEKeVc1Ija0tjxKCT+8K/e0mDnGkiAhNf21U/5NiKe8zQOCZYSh
   Oeyu0CvUjvY1hQfZAWg7lFqtVTtmTIvwYv/TTLs+zR1pQAjBLS/RdrX1L
   lMLTdxF7tAZSBzv0IKAgKDSg7N62EGz1+VoZICdVzsNETpihak9tp7wIz
   QFtJQ1W4Dbh8qg0uGa5whOs8e3eGKXe1br7QQrnWy4TzOvDdAwfNrPD2Y
   pAVFUNIprapwYOB12SU93ZiSb8NUiS90cjzs6iyvdOzl2zpyQuWykHZXS
   g==;
IronPort-SDR: 4GR+qDXklNEjk0+LfsP5tGHPAauGtTUOzKb7trzSqW1L0/3Ec7aAAHhdP0PKCNb7XAt3cz5K/E
 1hOu+Ys967S0VwXjLJr5QeKPIGd5+VZAhQDldz1MlZdJslCMb7muyrC+4dBC2DlHptl4j1BXV0
 EQa6WRb8AHiyIIRv90lqE5StIUZ4BCfVfxA+/F+crkX4lvn06VKuYxOacD9VJv2qnS6xskq1G1
 WHYX1iAWVjkUHZOj3jJCqrwkLNwZR8DqucvXw2Z0sAsh/N8j7f19Tv9LgPkCgo5pn4zd+Put9q
 1Io=
X-IronPort-AV: E=Sophos;i="5.64,336,1559491200"; 
   d="scan'208";a="221220800"
Received: from mail-co1nam05lp2051.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.51])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2019 07:04:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vo7Pfv2sLp4lF9lu4is/0PMz9v9KDydLbAkBZaEdycecbv+hnZUIGQJLGN8brxBDGIu5zZCL3e+DZVTIsgqvzATqmExnBN3WPyQj/vNJARfbjd1PwWjlT3jrFhUNAnuUgDWxrMae3U2N97BVEF0eiiMqT5rVEkHsLcQExUCN2QYVC26wi249Yl2Pt8e9P9dGjkhpW+5Btrg+S1ZBLPi1J6Vlob41JeWW3GXIQ9i3FcU89cSVJkl8LVTpNbd4jDgUlfGDUVwoXQnImhPZplOfm0SLCMJpq7FmuTgK9wZ8pRCeHmQxPeRreynjW2nltlA+lrOuLF2VL+CjM1ior1cI9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqBQQUd6DHFKduRJ3LeyM7a4nbVQglmWhUtFIbDn14c=;
 b=BG4bNEIjCJWNc9BNCkTGc6X33Mw9k6mt0BUTKSCZSmSEQdYwa0RKYaRvzXAen5Kcaz2+zHPqq58PBvEKn77vRaOYRlgOUvLTh+WJxtTUIVebvkXfkkRttuMnrq+2p9MQJH0YKibrldYdQ7CFRxivl5pl5lP3q54l2NGWr00yfhMNXzOtiQ4momqh0KTKFpruBXgKoluMVYg6g1XcBy30fUCgHj/spPMQTRYfwRt9bkPmhAlRuZJBAjBQlexzZTPxWrVwxt1Y9QPrpXe+shp5YdD8fZ+CjmSuDBXeYoonOdg1r/ylcRvd6ga4nm8DBk9g9lUusW+1loFfBKpnAlFRZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqBQQUd6DHFKduRJ3LeyM7a4nbVQglmWhUtFIbDn14c=;
 b=mBUDCkSJj3ndSagfZquUxO54wOzUPjh4+9B2zoej7aqG1c/9RPOtadEmSKQK8/AYJV4v8CTllGtXsnJoTD2SuFUoZxbCXFbtAi7lrfFenHt+dgUTW6fYlYwm2izQ/7l51RUSGq8J6dREuLhFAsrfAcVUa1cpN7zJdckVaF+v1Po=
Received: from BYAPR04MB3782.namprd04.prod.outlook.com (52.135.214.142) by
 BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Thu, 1 Aug 2019 23:04:23 +0000
Received: from BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::ac9a:967e:70a5:e926]) by BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::ac9a:967e:70a5:e926%7]) with mapi id 15.20.2115.005; Thu, 1 Aug 2019
 23:04:23 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "info@metux.net" <info@metux.net>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "johan@kernel.org" <johan@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 4/5] RISC-V: Export few kernel symbols
Thread-Topic: [PATCH v3 4/5] RISC-V: Export few kernel symbols
Thread-Index: AQHVSAREFj9Iszk81EyAA4/1BVByWabmc1iAgAB3iAA=
Date:   Thu, 1 Aug 2019 23:04:23 +0000
Message-ID: <ebeee86fa72f16e9adf6fbec9907a3559a5cb31c.camel@wdc.com>
References: <20190801005843.10343-1-atish.patra@wdc.com>
         <20190801005843.10343-5-atish.patra@wdc.com>
         <20190801155633.GA366@infradead.org>
In-Reply-To: <20190801155633.GA366@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d7c8e1b-89bb-4631-3c2d-08d716d4983c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4901;
x-ms-traffictypediagnostic: BYAPR04MB4901:
x-microsoft-antispam-prvs: <BYAPR04MB4901B53DEB936A889990CBACFADE0@BYAPR04MB4901.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(199004)(189003)(86362001)(54906003)(305945005)(486006)(2501003)(36756003)(76116006)(66476007)(66946007)(2906002)(66066001)(64756008)(4326008)(118296001)(2616005)(3846002)(6116002)(53936002)(66446008)(7416002)(5660300002)(11346002)(68736007)(446003)(476003)(66556008)(4744005)(6916009)(102836004)(76176011)(2351001)(81156014)(81166006)(6506007)(71200400001)(25786009)(478600001)(14454004)(6436002)(6486002)(8676002)(7736002)(71190400001)(1730700003)(6512007)(6246003)(5640700003)(186003)(229853002)(26005)(99286004)(256004)(316002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4901;H:BYAPR04MB3782.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: L0QCVMgO9LJN59ppJLDQuEhkylTtMPdHHypKrwli6M4DSd9SYdMMhfJr42CcLcds4vvVc+48vamJY6YbrrJoPZLH18Mut0WBbiyu9GrTwFfxtdzrMtLqRmLcnSYNepuRrKvYNE5EP2rT3jnL2bCGn2lwtyM+LWG7CDWKojXlOxDtRq21j+zC4JyNIeptbXo3MG0iOTGqQLb9vgMnb094WPTu2O1QriF03PGTYFxgIfIG/5pPeImqgTW/ueiHprxhnGVPVanizF3U4n0Y7jNjgG8osSBdQaf1VV8aNTL7ussMW/jd74q+zKAMXJRrWlc00DIrPTSW0x+P7UpoM3q+feYGpfPai4XnlWsv3Hb87X3PgkrJ8KBEeR05iQ0GzSAXUS7HViY0aI5/exoWw679/GVokvrLaXr6MHTeiA4H+T0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BB21D4A3293A14F80769E546E78DFB2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7c8e1b-89bb-4631-3c2d-08d716d4983c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 23:04:23.7877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Atish.Patra@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4901
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTA4LTAxIGF0IDA4OjU2IC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gV2VkLCBKdWwgMzEsIDIwMTkgYXQgMDU6NTg6NDJQTSAtMDcwMCwgQXRpc2ggUGF0
cmEgd3JvdGU6DQo+ID4gRXhwb3J0IGZldyBzeW1ib2xzIHVzZWQgYnkga3ZtIG1vZHVsZS4gV2l0
aG91dCB0aGlzLCBrdm0gY2FuIG5vdA0KPiA+IGJlIGNvbXBpbGVkIGFzIGEgbW9kdWxlLg0KPiAN
Cj4gUGxlYXNlIGFkZCB0aGlzIHRvIHRoZSBrdm0gc2VyaWVzIGluc3RlYWQgYXMgd2UgZG9uJ3Qg
bWVyZ2UgZXhwb3J0cw0KPiB3aXRob3V0IHRoZWlyIHVzZXJzIGluIHRoZSBzYW1lIHNlcmllcy4N
Cg0KU3VyZS4NCg0KUmVnYXJkcywNCkF0aXNoDQo=
