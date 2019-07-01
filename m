Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664A2C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365402146F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gr+c9aFM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZNuRTDTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfGAVHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:07:43 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:38610 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGAVHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562015263; x=1593551263;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OEcfdAAwl92AgRful/RQ7qau7q8BcfshjPCUwyM5HXw=;
  b=gr+c9aFMbb8UhhPPof46UIWDBufLF/r7jG6CLr07R5FwwVF7X/Vxx+/3
   gzpX0bMcKpQm2zSDItrpkA8CNn1amUZq5pKszQNu/90q68CjtCL82fMnV
   Wz6jFGySnehgsXs+PzJMC5Vg4f8nJ9A4fATGJJNlvGvl8T4QZNNUS6sOu
   xpaA6oqVwqxm1su9H/Ay76ughtJKd0ZGcp6e+P9uArlHE4pnlTi72tyFT
   v9BGaOgbZ7x+eMgcI6mNhdS5YQDbMYjWTbRjvBC9Q1zaf/KO2KUdPFHJa
   hWfJIYOn3EP2xo8ib07wbHLfDzMUYKbOHmoYy7jyLF18+PCCUs0m1hihi
   A==;
X-IronPort-AV: E=Sophos;i="5.63,440,1557158400"; 
   d="scan'208";a="111990901"
Received: from mail-dm3nam05lp2051.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.51])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2019 05:07:42 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEcfdAAwl92AgRful/RQ7qau7q8BcfshjPCUwyM5HXw=;
 b=ZNuRTDTdoIynOnJr7SbW8g1P1oZiXWqb6a03UDEHhKbmfzhetQJVMjpBfanJ2/pyuVpd85AC8VaxCS2iU8DER2WOX+YP/PguzPSkQuTFTmw+2HD58pLdnu4iYC90bpcVOwegHr1h2gWVMBJQFCZtTHS1pXmL7owpyTCuEKwNiLA=
Received: from BYAPR04MB3782.namprd04.prod.outlook.com (52.135.214.142) by
 BYAPR04MB3847.namprd04.prod.outlook.com (52.135.214.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Mon, 1 Jul 2019 21:07:40 +0000
Received: from BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::65e3:6069:d7d5:90a2]) by BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::65e3:6069:d7d5:90a2%5]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 21:07:40 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "hch@lst.de" <hch@lst.de>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@sifive.com" <palmer@sifive.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/17] riscv: improve the default power off implementation
Thread-Topic: [PATCH 08/17] riscv: improve the default power off
 implementation
Thread-Index: AQHVKk/RVIOKDHCL9keDjqbkd/toiaa2TWeA
Date:   Mon, 1 Jul 2019 21:07:40 +0000
Message-ID: <29b9f4f7e2b28a6131e174f61c528bca98030a95.camel@wdc.com>
References: <20190624054311.30256-1-hch@lst.de>
         <20190624054311.30256-9-hch@lst.de>
In-Reply-To: <20190624054311.30256-9-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.45.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b7c1038-eb70-4b5a-dde8-08d6fe68271e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB3847;
x-ms-traffictypediagnostic: BYAPR04MB3847:
x-microsoft-antispam-prvs: <BYAPR04MB3847C6666E4D24871ECDE138FAF90@BYAPR04MB3847.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(199004)(189003)(99286004)(14454004)(6512007)(4326008)(6486002)(229853002)(25786009)(53936002)(478600001)(316002)(6116002)(3846002)(72206003)(68736007)(66066001)(6506007)(4744005)(102836004)(11346002)(446003)(76176011)(26005)(6436002)(186003)(71200400001)(71190400001)(2201001)(81166006)(81156014)(6246003)(305945005)(86362001)(8676002)(8936002)(2501003)(118296001)(7736002)(2906002)(14444005)(256004)(5660300002)(73956011)(64756008)(66476007)(486006)(66446008)(66556008)(66946007)(76116006)(54906003)(110136005)(2616005)(36756003)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3847;H:BYAPR04MB3782.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YTLkoYGhFeu6yMVyPUCkA58KNXqodN4UviDdtgnCkDMNJ0ZYjs4cUUXNCu86yB4bcFwKmvdE/h6XwTLjHjw3ZO4k1adQskNHbx+eZPee7wTBpGC5pGt/WwcnjmpqI7qe59CzStTINjOKjeS9Z1tSdCCH0OYAiLZQ2PXI90Phocpb6Y9j4sarYErzIllr9Sr4lNc5BepdJ1wN1w610qofTk9nRKt9WQGE6nLOzCF8a3YTL+i0bA3XDvaoHiuogRYBV3HNyBp3gz72g2oltvxqeKXtWO+9r0dbuon/dcrPQFPZuywrxXQLKXEEg+Gb3/dsERIdTmt30N7thVkwc52m0z3wy8AE1gjG+R88Ik2jFE3HsYnoxHC8TysWzRH8XL7TWvlMQ/hzESpF4pgoUvwIAjxRTEKh4W1pydqMy0jZ76w=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7E5C9A44891AF43A954658A01AB9C88@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7c1038-eb70-4b5a-dde8-08d6fe68271e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 21:07:40.4273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Atish.Patra@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3847
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA2LTI0IGF0IDA3OjQzICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT25seSBjYWxsIHRoZSBTQkkgY29kZSBpZiB3ZSBhcmUgbm90IHJ1bm5pbmcgaW4gTSBt
b2RlLCBhbmQgaWYgd2UNCj4gZGlkbid0DQo+IGRvIHRoZSBTQkkgY2FsbCwgb3IgaXQgZGlkbid0
IHN1Y2NlZWQgY2FsbCB3ZmkgaW4gYSBsb29wIHRvIGF0IGxlYXN0DQo+IHNhdmUgc29tZSBwb3dl
ci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0K
PiAtLS0NCj4gIGFyY2gvcmlzY3Yva2VybmVsL3Jlc2V0LmMgfCA1ICsrKystDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvYXJjaC9yaXNjdi9rZXJuZWwvcmVzZXQuYyBiL2FyY2gvcmlzY3Yva2VybmVsL3Jlc2V0LmMN
Cj4gaW5kZXggZDBmZTYyM2JmYjhmLi4yZjVjYTM3OTc0N2UgMTAwNjQ0DQo+IC0tLSBhL2FyY2gv
cmlzY3Yva2VybmVsL3Jlc2V0LmMNCj4gKysrIGIvYXJjaC9yaXNjdi9rZXJuZWwvcmVzZXQuYw0K
PiBAQCAtOCw4ICs4LDExIEBADQo+ICANCj4gIHN0YXRpYyB2b2lkIGRlZmF1bHRfcG93ZXJfb2Zm
KHZvaWQpDQo+ICB7DQo+ICsjaWZuZGVmIENPTkZJR19NX01PREUNCj4gIAlzYmlfc2h1dGRvd24o
KTsNCj4gLQl3aGlsZSAoMSk7DQo+ICsjZW5kaWYNCj4gKwl3aGlsZSAoMSkNCj4gKwkJd2FpdF9m
b3JfaW50ZXJydXB0KCk7DQo+ICB9DQo+ICANCj4gIHZvaWQgKCpwbV9wb3dlcl9vZmYpKHZvaWQp
ID0gZGVmYXVsdF9wb3dlcl9vZmY7DQoNClJldmlld2VkLWJ5OiBBdGlzaCBQYXRyYSA8YXRpc2gu
cGF0cmFAd2RjLmNvbT4NCg0KUmVnYXJkcywNCkF0aXNoDQo=
