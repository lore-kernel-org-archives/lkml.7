Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1B7C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C8520882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="QQGP/zhm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfDCKWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:22:47 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:43346 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfDCKWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:22:47 -0400
X-IronPort-AV: E=Sophos;i="5.60,304,1549954800"; 
   d="scan'208";a="29154380"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Apr 2019 03:22:45 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 3 Apr 2019 03:22:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ze5tbr/KvukZoScAp7MnZ77wQP9+mbCMT3i73g/eWHY=;
 b=QQGP/zhmncRt5qSPN4G57nKa/el+0GBJzCZ/y60l4SUcz6SPOaZtho5O9sh4Ujb+T3CqZXKiRTbFLBphVWfS/N2Xg31lsb9RWgRx+az7Gh1sLkeXY/hmorrLJoi3Jsl2owBt05TH90asxOZAf3Kpw2kiMVwTmVY5PXHqy1lRQjM=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1855.namprd11.prod.outlook.com (10.175.53.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.13; Wed, 3 Apr 2019 10:22:42 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::65cd:b698:41:54d6]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::65cd:b698:41:54d6%2]) with mapi id 15.20.1750.017; Wed, 3 Apr 2019
 10:22:42 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <dmaengine@vger.kernel.org>, <vkoul@kernel.org>
CC:     <Ludovic.Desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] dmaengine: at_xdmac: remove BUG_ON macro in
 tasklet
Thread-Topic: [PATCH v2 1/3] dmaengine: at_xdmac: remove BUG_ON macro in
 tasklet
Thread-Index: AQHU6gVwtUcRqFu+zEKuAkxTQuCbfqYqOkUA
Date:   Wed, 3 Apr 2019 10:22:42 +0000
Message-ID: <9b744b6c-7d16-3225-0457-2e1193237954@microchip.com>
References: <20190403100953.26199-1-nicolas.ferre@microchip.com>
In-Reply-To: <20190403100953.26199-1-nicolas.ferre@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0300.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::24) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fcba90e-d037-40ed-a3a6-08d6b81e4e72
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR11MB1855;
x-ms-traffictypediagnostic: MWHPR11MB1855:
x-microsoft-antispam-prvs: <MWHPR11MB18558F54A36ADF34200BB41EE0570@MWHPR11MB1855.namprd11.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39860400002)(396003)(136003)(199004)(189003)(6486002)(229853002)(52116002)(2906002)(6116002)(316002)(3846002)(110136005)(5660300002)(54906003)(99286004)(6436002)(106356001)(105586002)(31686004)(68736007)(97736004)(6512007)(8936002)(2501003)(25786009)(66066001)(4326008)(305945005)(7736002)(81156014)(53936002)(478600001)(8676002)(81166006)(6246003)(72206003)(14454004)(256004)(71190400001)(6506007)(386003)(53546011)(71200400001)(31696002)(186003)(86362001)(36756003)(11346002)(446003)(2616005)(476003)(14444005)(102836004)(76176011)(486006)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1855;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Of0zItKbYB8QbaNF8YA/iayjz8B7NXUYweNXSk7bUglimtvyJt1F1DjfD7r76TMuLEEdZNcsqCYwi2jFFVW7n+Rx0GLC8Pwvsxv8dUoH4xlF0f6swedH79p8nLOKdsydStMjpPmVjBk49mZEuhD1Hsk0VXDNDEOXC0nevvGNfzIrXtttFuGdoTI/DEuFLCtVVAOE/42bgTqI81UUPLbIoLXjVYg/aVPakYz9WJmVB3+JCn0B9Hab9e+eeOrvGMJlib9JRCUD5/lLT74JcYTqLTWBCOkJfRjakG/IMOkIgHH+UM3CNG9kD7yPQ999OHalz+gkn6JgZ3gotfHMmohjl6ORnXQKtDxCSsk3MiflnfKqHLLbXcE990VNjZRCR/DMTYcxsUP+KQVPQwp+FnhKjUPZm6o8jfNNEpmPAs2QyW0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5D0A3AC54B6AA49923633FBD9F7705A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fcba90e-d037-40ed-a3a6-08d6b81e4e72
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 10:22:42.7141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1855
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vmlub2QsDQoNClBsZWFzZSBkaXNyZWdhcmQgdGhpcyBzZXJpZXM6IEknbSBzZW5kaW5nIGEgdjMg
cmlnaHQgbm93LiBTb3JyeSBmb3IgdGhlIA0Kbm9pc2UuDQoNCkJlc3QgcmVnYXJkcywNCiAgIE5p
Y29sYXMNCg0KT24gMDMvMDQvMjAxOSBhdCAxMjowOSwgTmljb2xhcyBGZXJyZSB3cm90ZToNCj4g
RXZlbiBpZiB0aGlzIGNhc2Ugc2hvdWxkbid0IGhhcHBlbiB3aGVuIGNvbnRyb2xsZXIgaXMgcHJv
cGVybHkgcHJvZ3JhbW1lZCwNCj4gaXQncyBzdGlsbCBiZXR0ZXIgdG8gYXZvaWQgZHVtcGluZyBh
IGtlcm5lbCBPb3BzIGZvciB0aGlzLg0KPiBBcyB0aGUgc2VxdWVuY2UgbWF5IGhhcHBlbiBvbmx5
IGZvciBkZWJ1Z2dpbmcgcHVycG9zZXMsIGxvZyB0aGUgZXJyb3IgYW5kDQo+IGp1c3QgZmluaXNo
IHRoZSB0YXNrbGV0IGNhbGwuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBOaWNvbGFzIEZlcnJlIDxu
aWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+DQo+IEFja2VkLWJ5OiBMdWRvdmljIERlc3JvY2hl
cyA8bHVkb3ZpYy5kZXNyb2NoZXNAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+IHYyOiBhZGRlZCBM
dWRvdmljJ3MgdGFnDQo+IA0KPiAgIGRyaXZlcnMvZG1hL2F0X3hkbWFjLmMgfCA2ICsrKysrLQ0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9hdF94ZG1hYy5jIGIvZHJpdmVycy9kbWEvYXRfeGRt
YWMuYw0KPiBpbmRleCBmZTY5ZGNjZmEwYzAuLjM3YTI2OTQyMDQzNSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9kbWEvYXRfeGRtYWMuYw0KPiArKysgYi9kcml2ZXJzL2RtYS9hdF94ZG1hYy5jDQo+
IEBAIC0xNjA2LDcgKzE2MDYsMTEgQEAgc3RhdGljIHZvaWQgYXRfeGRtYWNfdGFza2xldCh1bnNp
Z25lZCBsb25nIGRhdGEpDQo+ICAgCQkJCQlzdHJ1Y3QgYXRfeGRtYWNfZGVzYywNCj4gICAJCQkJ
CXhmZXJfbm9kZSk7DQo+ICAgCQlkZXZfdmRiZyhjaGFuMmRldigmYXRjaGFuLT5jaGFuKSwgIiVz
OiBkZXNjIDB4JXBcbiIsIF9fZnVuY19fLCBkZXNjKTsNCj4gLQkJQlVHX09OKCFkZXNjLT5hY3Rp
dmVfeGZlcik7DQo+ICsJCWlmICghZGVzYy0+YWN0aXZlX3hmZXIpIHsNCj4gKwkJCWRldl9lcnIo
Y2hhbjJkZXYoJmF0Y2hhbi0+Y2hhbiksICJYZmVyIG5vdCBhY3RpdmU6IGV4aXRpbmciKTsNCj4g
KwkJCXNwaW5fdW5sb2NrX2JoKCZhdGNoYW4tPmxvY2spOw0KPiArCQkJcmV0dXJuOw0KPiArCQl9
DQo+ICAgDQo+ICAgCQl0eGQgPSAmZGVzYy0+dHhfZG1hX2Rlc2M7DQo+ICAgDQo+IA0KDQoNCi0t
IA0KTmljb2xhcyBGZXJyZQ0K
