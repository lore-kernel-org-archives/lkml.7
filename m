Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31F2C06511
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A242320663
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ryh4E/vG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PExM+9fk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfGASxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 14:53:25 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:30165 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfGASxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 14:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562007204; x=1593543204;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=evVuCAwmXg1QqUkbarEdoN4jfzFm166bDjRUSetUjpg=;
  b=ryh4E/vGRe/ASy4lbJ9nxTpzKqpwnjwdodwgTMb5qdjY3tvHvwGpHNiO
   8msT1FWjhtuX/RIbWTU331Mx2AddXYLxD9VSiXZkD9N7/6OebcYfblYeT
   TsvF8lZ1wHTG44FxvO7RajBnUcrKSr2qI8e3t27lw6wLNZTmtIlO2lrna
   3V5c69punjtflEPZzfc9yzBKa2GjWQZZxtK/aNus0ON3TqUwX6guJNVDM
   /pZMSIFxnbhnV1Cp6cMkXcQ199ehtRSA4nupzwHPqJYjg8fnur9oLiGH8
   aMUnl4VK3tz+5x4ZgH74iE7jTRioXDhDwIxTSYVhbS/bmTNXBihYHBW0a
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,440,1557158400"; 
   d="scan'208";a="111983828"
Received: from mail-bn3nam01lp2054.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.54])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2019 02:53:22 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evVuCAwmXg1QqUkbarEdoN4jfzFm166bDjRUSetUjpg=;
 b=PExM+9fkw1voOn+ON77ypgP02gM9oIeCA2yYU4UyKsJzlq7Uj+ssotRcFVqDdPKkBctKBqEGFIpZducMCWJXlavy6IZQRSkkTvOhFNI4LW2RuWVArm2d4qoZGvoJyoKuUs7BkFG4R7wfhLsUBevygTa7zCXSL13VVta2sYIIno8=
Received: from BYAPR04MB3782.namprd04.prod.outlook.com (52.135.214.142) by
 BYAPR04MB5573.namprd04.prod.outlook.com (20.178.232.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Mon, 1 Jul 2019 18:53:21 +0000
Received: from BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::65e3:6069:d7d5:90a2]) by BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::65e3:6069:d7d5:90a2%5]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 18:53:21 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "hch@lst.de" <hch@lst.de>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@sifive.com" <palmer@sifive.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/17] riscv: use CSR_SATP instead of the legacy sptbr
 name in switch_mm
Thread-Topic: [PATCH 05/17] riscv: use CSR_SATP instead of the legacy sptbr
 name in switch_mm
Thread-Index: AQHVKk/HYDuvVX0qL0ugJmd5Wg5v96a2J+AA
Date:   Mon, 1 Jul 2019 18:53:21 +0000
Message-ID: <3cc7a8734991bbb3b7576b34b7038ca9bc67c0c0.camel@wdc.com>
References: <20190624054311.30256-1-hch@lst.de>
         <20190624054311.30256-6-hch@lst.de>
In-Reply-To: <20190624054311.30256-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 502cacdf-aa01-4012-a6f6-08d6fe55637f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5573;
x-ms-traffictypediagnostic: BYAPR04MB5573:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5573E06A4306B18719AB0804FAF90@BYAPR04MB5573.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(189003)(199004)(73956011)(99286004)(53936002)(76116006)(476003)(229853002)(66066001)(486006)(316002)(71190400001)(256004)(71200400001)(14444005)(81156014)(66946007)(6512007)(4326008)(36756003)(6506007)(110136005)(446003)(66556008)(11346002)(66476007)(54906003)(14454004)(7736002)(26005)(2501003)(66446008)(118296001)(68736007)(2616005)(64756008)(478600001)(6246003)(72206003)(186003)(8936002)(2906002)(305945005)(2201001)(76176011)(102836004)(6436002)(6116002)(3846002)(6486002)(86362001)(81166006)(8676002)(25786009)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5573;H:BYAPR04MB3782.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: C/evsz1NDFa2mXkBgH+HXTPqoIOES4+eFVrV7XBQftYME7zweKQwxZf8fVvwJF3pBiMAoFX2k0VABYboVKJvNB30TDRoAGMOgHCDKd1labC3X4BIH6eeByKIJcuQu+f7phhY/p6curGh5nS2BssK1Ef1zYyTXi9HIxgpr6QmivcH3RXpL9XJZZigpJrkeqLOO/wJNaxSs4BX2cUSXnUyvvm2e5xRih0oxBIijJ/1wAfhi8IrcGXxW1F7nP0MhHpzgOhORshZxu1TiR5xgwIYJmFkh/hM4woMl/RAjVoZIXFLvXxdFyY5IFlYTcuuU+T4/QzR+ECyVjdVFVOspIwvX0GEd1AqXExWnMOhT4AZkFb5K5mUT04Ttg4tB8X2MvKu/tTFgW8OCmcHxxHDD+blLzHb0gN8n6o9FNIA1fNC0EQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F69301522B3BE54987C4AF4105C0689F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 502cacdf-aa01-4012-a6f6-08d6fe55637f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 18:53:21.3359
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

T24gTW9uLCAyMDE5LTA2LTI0IGF0IDA3OjQyICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gU3dpdGNoIHRvIG91ciBvd24gY29uc3RhbnQgZm9yIHRoZSBzYXRwIHJlZ2lzdGVyIGlu
c3RlYWQgb2YgdXNpbmcNCj4gdGhlIG9sZCBuYW1lIGZyb20gYSBsZWdhY3kgdmVyc2lvbiBvZiB0
aGUgcHJpdmlsZWdlZCBzcGVjLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3
aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KPiAgYXJjaC9yaXNjdi9tbS9jb250ZXh0LmMgfCA3ICst
LS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNiBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L21tL2NvbnRleHQuYyBiL2FyY2gvcmlzY3Yv
bW0vY29udGV4dC5jDQo+IGluZGV4IDg5Y2ViM2NiZTIxOC4uYmVlYjVkN2Y5MmVhIDEwMDY0NA0K
PiAtLS0gYS9hcmNoL3Jpc2N2L21tL2NvbnRleHQuYw0KPiArKysgYi9hcmNoL3Jpc2N2L21tL2Nv
bnRleHQuYw0KPiBAQCAtNTcsMTIgKzU3LDcgQEAgdm9pZCBzd2l0Y2hfbW0oc3RydWN0IG1tX3N0
cnVjdCAqcHJldiwgc3RydWN0DQo+IG1tX3N0cnVjdCAqbmV4dCwNCj4gIAljcHVtYXNrX2NsZWFy
X2NwdShjcHUsIG1tX2NwdW1hc2socHJldikpOw0KPiAgCWNwdW1hc2tfc2V0X2NwdShjcHUsIG1t
X2NwdW1hc2sobmV4dCkpOw0KPiAgDQo+IC0JLyoNCj4gLQkgKiBVc2UgdGhlIG9sZCBzcGJ0ciBu
YW1lIGluc3RlYWQgb2YgdXNpbmcgdGhlIGN1cnJlbnQgc2F0cA0KPiAtCSAqIG5hbWUgdG8gc3Vw
cG9ydCBiaW51dGlscyAyLjI5IHdoaWNoIGRvZXNuJ3Qga25vdyBhYm91dCB0aGUNCj4gLQkgKiBw
cml2aWxlZ2VkIElTQSAxLjEwIHlldC4NCj4gLQkgKi8NCj4gLQljc3Jfd3JpdGUoc3B0YnIsIHZp
cnRfdG9fcGZuKG5leHQtPnBnZCkgfCBTQVRQX01PREUpOw0KPiArCWNzcl93cml0ZShDU1JfU0FU
UCwgdmlydF90b19wZm4obmV4dC0+cGdkKSB8IFNBVFBfTU9ERSk7DQo+ICAJbG9jYWxfZmx1c2hf
dGxiX2FsbCgpOw0KPiAgDQo+ICAJZmx1c2hfaWNhY2hlX2RlZmVycmVkKG5leHQpOw0KDQpSZXZp
ZXdlZC1ieTogQXRpc2ggUGF0cmEgPGF0aXNoLnBhdHJhQHdkYy5jb20+DQoNCi0tIA0KUmVnYXJk
cywNCkF0aXNoDQo=
