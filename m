Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CB0C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BAA4208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="FhFitQfE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbfFGEyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 00:54:23 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:64448 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFGEyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 00:54:23 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,562,1557212400"; 
   d="scan'208";a="34772477"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jun 2019 21:54:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex03.mchp-main.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 6 Jun 2019 21:54:21 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 6 Jun 2019 21:54:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MOfrxpcLloTDFR+GlMIfx0ID92W6ANeQcMXQWwoxHY=;
 b=FhFitQfEZPAS/tVmoXbF/KHz478+zK3X65pX/gdNYSTOWN8ea4671SM/VAb9qpVKeBgotefXGdc7fC7hD/tqID6rLApXqndCuviQZjEp9T3IH6HChRsDeBrIM9gtvIg8xJULa5s30wXcr0Ls8PTBzGOjdOxM31RdGm2UW6JSppA=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1905.namprd11.prod.outlook.com (10.175.97.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Fri, 7 Jun 2019 04:54:19 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::e581:f807:acdc:cb36]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::e581:f807:acdc:cb36%9]) with mapi id 15.20.1943.018; Fri, 7 Jun 2019
 04:54:19 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <ludovic.Barre@st.com>, <marek.vasut@gmail.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <bbrezillon@kernel.org>, <richard@nod.at>,
        <alexandre.torgue@st.com>, <robh+dt@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] mtd: spi-nor: stm32: remove the driver as it was replaced
 by spi-stm32-qspi.c
Thread-Topic: [PATCH] mtd: spi-nor: stm32: remove the driver as it was
 replaced by spi-stm32-qspi.c
Thread-Index: AQHVBLY5V09e/skhoEu+jgD24Fu8MKaP0KoA
Date:   Fri, 7 Jun 2019 04:54:19 +0000
Message-ID: <2940804e-2df7-066c-c9da-2e842ec74a04@microchip.com>
References: <1557220598-18531-1-git-send-email-ludovic.Barre@st.com>
In-Reply-To: <1557220598-18531-1-git-send-email-ludovic.Barre@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0230.eurprd07.prod.outlook.com
 (2603:10a6:802:58::33) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.241.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 086421dd-569a-4559-d8c9-08d6eb0432f7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1905;
x-ms-traffictypediagnostic: BN6PR11MB1905:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN6PR11MB1905AD034E89C817EBDD7B51F0100@BN6PR11MB1905.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(376002)(396003)(136003)(199004)(189003)(66946007)(71190400001)(66556008)(8676002)(6116002)(486006)(316002)(53546011)(446003)(6246003)(102836004)(99286004)(6436002)(52116002)(36756003)(6512007)(2906002)(54906003)(110136005)(3846002)(6306002)(6486002)(476003)(5660300002)(2616005)(11346002)(186003)(4326008)(81166006)(386003)(71200400001)(305945005)(73956011)(6506007)(4744005)(86362001)(66476007)(76176011)(229853002)(7736002)(31696002)(68736007)(53936002)(31686004)(8936002)(81156014)(7416002)(66066001)(478600001)(256004)(64756008)(25786009)(14444005)(966005)(66446008)(72206003)(14454004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1905;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yrAZQ2rbvTCn3NTYRro74GSl+hcVuUpQiQAEYcJ2EmZgx7SEypl/Axs5f7dNbeoEkGuZFykcE+Z+YtMBF/WZdqQ2teZ3TRiJin0GRMQWwPMIphoXulBQhGxO3kOyDmnAv9R+8OS/8qKxF4A0xRkR7PnWE1FqQjpTByXz2Om30DYtyQlDyI/kM7BfhAxmsShXrLdjz39Z32X9pcARfppzhltdhXXGXuxdNCVi6N2uoeYhEkVyz6OG4c5WW6/+qrLwFcRAF65qBnwuGvf9XYm2y8cY8v1Uk3Oq7a7exPE1nBuQMUIoBGrfy37zuCeRUUWFInm71Qfzxb+VVzeqSJu940xhgN+VJUmOstrB7Ao7OacFlV+7aolf6yDU6xXUnN8q9Vq5edge9SBi7ktanlwZsEEC5uvF/a3z4jHTr+wQjBE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1FDC19070F3C5438494749CC8BEED4D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 086421dd-569a-4559-d8c9-08d6eb0432f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 04:54:19.4570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1905
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA1LzA3LzIwMTkgMTI6MTYgUE0sIEx1ZG92aWMgQmFycmUgd3JvdGU6DQo+IEZyb206
IEx1ZG92aWMgQmFycmUgPGx1ZG92aWMuYmFycmVAc3QuY29tPg0KPiANCj4gVGhlcmUncyBhIG5l
dyBkcml2ZXIgdXNpbmcgdGhlIFNQSSBtZW1vcnkgaW50ZXJmYWNlIG9mIHRoZQ0KPiBTUEkgZnJh
bWV3b3JrIGF0IHNwaS9zcGktc3RtMzItcXNwaS5jLCB3aGljaCBjYW4gYmUgdXNlZA0KPiB0b2dl
dGhlciB3aXRoIG0yNXA4MC5jIHRvIHJlcGxhY2UgdGhlIGZ1bmN0aW9uYWxpdHkgb2YNCj4gdGhp
cyBTUEkgTk9SIGRyaXZlci4NCj4gDQo+IFRoZSAibmV3IiBkcml2ZXIgdXNlcyB0aGUgc2FtZSBk
dCBwcm9wZXJ0aWVzIGFuZCBub3QgYWZmZWN0cw0KPiB0aGUgbGVnYWN5IGNvbXBhdGliaWxpdHku
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMdWRvdmljIEJhcnJlIDxsdWRvdmljLmJhcnJlQHN0LmNv
bT4NCj4gLS0tDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvc3RtMzItcXVhZHNwaS50
eHQgICAgICB8ICA0MyAtLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9LY29uZmlnICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgIDcgLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9NYWtlZmlsZSAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIDEgLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9zdG0z
Mi1xdWFkc3BpLmMgICAgICAgICAgICAgICAgfCA3MjAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+
ICA0IGZpbGVzIGNoYW5nZWQsIDc3MSBkZWxldGlvbnMoLSkNCj4gIGRlbGV0ZSBtb2RlIDEwMDY0
NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL3N0bTMyLXF1YWRzcGkudHh0
DQo+ICBkZWxldGUgbW9kZSAxMDA2NDQgZHJpdmVycy9tdGQvc3BpLW5vci9zdG0zMi1xdWFkc3Bp
LmMNCg0KQXBwbGllZCB0byBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC9tdGQvbGludXguZ2l0LA0Kc3BpLW5vci9uZXh0IGJyYW5jaC4NCg0KVGhhbmtzLA0K
dGENCg==
