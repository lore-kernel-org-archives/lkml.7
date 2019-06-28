Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545A1C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD202070D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="qZVZNieA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfF1IVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:21:03 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:65101 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfF1IVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:21:02 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,427,1557212400"; 
   d="scan'208";a="40779477"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2019 01:21:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex01.mchp-main.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 28 Jun 2019 01:20:56 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 28 Jun 2019 01:20:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=PZiQvDsj7OxNL8jj7R4fKuuFnW0kW++t/LdUHhKiXvOEG2nRMh9/6Y1XwiscpdtEa1oFo25cYJIgHzvoS0H++m/0VKvcNU15Rs5GbNIPi8FOZ21B95wlpOzCl1fb1vD7nnAklgWZaB4ErXW1Igw0VQxGfL1vWDh9uwEoyaaEC64=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXj7lt7FywYayGHzhv9MEAbAQKqweESvOQ35lgEw2Z8=;
 b=IaEIqwcCVZauYLkJShH4VCSSJdKK4IPuCtbCX/0I+GfrY0fd+r0vxSUZjKvvSgfpIc6w80hWw5ypP9QxkSDueEEKDC/ZvzfwoPH5hSI5L3vnMDIAEuSBIEpneLuijVKX19lh4oq+Z+rJbTCkHqjvnI81OeMtCIZqyNtUEIsNHaU=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXj7lt7FywYayGHzhv9MEAbAQKqweESvOQ35lgEw2Z8=;
 b=qZVZNieArpgbaNVTP7kTnvwoGBenAA6O+qtJ4UHDT4aoPCXpwtfwx2k9gbGDhZQpBt9pTKqB3TiXNrUtG2mTOG8H7yJfRpg00wnqTvfXy2InJKcKSAqzOnFYpOGvslRiHQ5makOxqTdq1hyqFpIgV7ghY8+lUFWyWfIUNRN1lX4=
Received: from DM5PR11MB1850.namprd11.prod.outlook.com (10.175.91.11) by
 DM5PR11MB2010.namprd11.prod.outlook.com (10.168.107.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 28 Jun 2019 08:20:54 +0000
Received: from DM5PR11MB1850.namprd11.prod.outlook.com
 ([fe80::5025:6c13:b07d:501e]) by DM5PR11MB1850.namprd11.prod.outlook.com
 ([fe80::5025:6c13:b07d:501e%6]) with mapi id 15.20.2008.017; Fri, 28 Jun 2019
 08:20:54 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <liu.xiang6@zte.com.cn>,
        <linux-mtd@lists.infradead.org>
CC:     <richard@nod.at>, <liuxiang_1999@126.com>,
        <linux-kernel@vger.kernel.org>, <marek.vasut@gmail.com>,
        <miquel.raynal@bootlin.com>, <computersforpeace@gmail.com>,
        <dwmw2@infradead.org>
Subject: Re: [PATCH v4] mtd: spi-nor: fix nor->addr_width when its value
 configured from SFDP does not match the actual width
Thread-Topic: [PATCH v4] mtd: spi-nor: fix nor->addr_width when its value
 configured from SFDP does not match the actual width
Thread-Index: AQHVKqYRRlZLW5Viykq22MnKUCXhb6avgZaAgAE94AA=
Date:   Fri, 28 Jun 2019 08:20:54 +0000
Message-ID: <32340066-402a-0067-8694-91e34e7a7480@microchip.com>
References: <1561392046-10487-1-git-send-email-liu.xiang6@zte.com.cn>
 <792b5942-9aca-b0f2-dd92-cb8f96cd8027@ti.com>
In-Reply-To: <792b5942-9aca-b0f2-dd92-cb8f96cd8027@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0131.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::33) To DM5PR11MB1850.namprd11.prod.outlook.com
 (2603:10b6:3:112::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e139229-bde5-4a32-631e-08d6fba189f7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR11MB2010;
x-ms-traffictypediagnostic: DM5PR11MB2010:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM5PR11MB2010CF82006CE13B34212192F0FC0@DM5PR11MB2010.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(396003)(376002)(136003)(199004)(189003)(8676002)(36756003)(6506007)(102836004)(386003)(6116002)(66066001)(229853002)(478600001)(2501003)(3846002)(4744005)(7736002)(6436002)(76176011)(71200400001)(26005)(6486002)(8936002)(81166006)(5660300002)(68736007)(305945005)(81156014)(73956011)(66946007)(186003)(66446008)(2906002)(53936002)(66556008)(66476007)(64756008)(52116002)(110136005)(71190400001)(6306002)(486006)(6246003)(966005)(446003)(25786009)(2616005)(476003)(11346002)(31686004)(53546011)(4326008)(14444005)(31696002)(256004)(316002)(99286004)(72206003)(7416002)(14454004)(54906003)(6512007)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB2010;H:DM5PR11MB1850.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1mVehLBSPYBB8CtESv9HhEgtDwIV8LQM68DJel9soYjxZdhvfhxV0tA0Q4VkxiknN2X8wII1d+wxHYyPNIpDEhJLWXBRwj0xjhtHZtBiqwwncyfVEhqT6zqQ1YQPyZZx81r10p64ilSliqp+sfU6Q+taiS1butyKK1eL51DLh7P1MHaPsFF63YRrgtp8GtTC6mbcQdP9SYNpdEFw0YFlefbbgqRpV7vke2Ybg1oht/Rg1t3fqKzHEmJ7q7vV0pz5qTIoRxOuBGVXF5wgudsHKiWwR+IBU76m/oykJcDDcVK9G0O9+IsLoDpi1aLhsRtuBdZNd7RxDjDQ5Q7gjH7/0Na6DncYyDuvn0S+hPjkQJ9MDHsFj4SXgVhzPGPCVB/9vSrDcLmBbqUw2/VB8URMxCPWRKUamQ6hmUCVV+ttwNI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBAC5FDEFA254A488EE131B366395DFB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e139229-bde5-4a32-631e-08d6fba189f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 08:20:54.6615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB2010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA2LzI3LzIwMTkgMDQ6MjMgUE0sIFZpZ25lc2ggUmFnaGF2ZW5kcmEgd3JvdGU6DQo+
IEV4dGVybmFsIEUtTWFpbA0KPiANCj4gDQo+IA0KPiBPbiAyNC8wNi8xOSA5OjMwIFBNLCBMaXUg
WGlhbmcgd3JvdGU6DQo+PiBJUzI1TFAyNTYgZ2V0cyBCRlBUX0RXT1JEMV9BRERSRVNTX0JZVEVT
XzNfT05MWSBmcm9tIEJGUFQgdGFibGUgZm9yDQo+PiBhZGRyZXNzIHdpZHRoLiBCdXQgaW4gYWN0
dWFsIGZhY3QgdGhlIGZsYXNoIGNhbiBzdXBwb3J0IDQtYnl0ZSBhZGRyZXNzLg0KPj4gVXNlIGEg
cG9zdCBiZnB0IGZpeHVwIGhvb2sgdG8gb3ZlcndyaXRlIHRoZSBhZGRyZXNzIHdpZHRoIGFkdmVy
dGlzZWQgYnkNCj4+IHRoZSBCRlBULg0KPj4NCj4+IFN1Z2dlc3RlZC1ieTogVHVkb3IgQW1iYXJ1
cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQpkcm9wcGVkIFN1Z2dlc3RlZC1ieSB0
YWcsIHlvdSBjYW4ndCBhZGQgdGhpcyB0YWcgZm9yIGVhY2ggY2hhbmdlIHJlcXVlc3QuIFlvdQ0K
c2hvdWxkIGFkZCBpdCBvbmx5IHdoZW4gc29tZW9uZSBnaXZlcyB5b3UgdGhlIGdlbmVyYWwgaWRl
YSBvbiBob3cgdG8gZG8gdGhlIHBhdGNoLg0KDQo+PiBTaWduZWQtb2ZmLWJ5OiBMaXUgWGlhbmcg
PGxpdS54aWFuZzZAenRlLmNvbS5jbj4NCj4+DQo+IA0KPiBSZXZpZXdlZC1ieTogVmlnbmVzaCBS
YWdoYXZlbmRyYSA8dmlnbmVzaHJAdGkuY29tPg0KPiANCj4gUmVnYXJkcw0KPiBWaWduZXNoDQo+
IA0KPj4gLS0tDQo+Pg0KPj4gQ2hhbmdlcyBpbiB2NDoNCj4+ICB1cGRhdGUgdGhlIGNvbW1lbnQg
c3VnZ2VzdGVkIGJ5IFR1ZG9yLg0KPj4gLS0tDQo+PiAgZHJpdmVycy9tdGQvc3BpLW5vci9zcGkt
bm9yLmMgfCAyNSArKysrKysrKysrKysrKysrKysrKysrKystDQo+PiAgMSBmaWxlIGNoYW5nZWQs
IDI0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQoNCkFwcGxpZWQgdG8gaHR0cHM6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbXRkL2xpbnV4LmdpdCwN
CnNwaS1ub3IvbmV4dCBicmFuY2guDQoNClRoYW5rcywNCnRhDQo=
