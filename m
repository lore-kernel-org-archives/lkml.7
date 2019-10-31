Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DC7CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 06:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3FAF2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 06:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="seSAw14T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfJaG5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 02:57:39 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:5943 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfJaG5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 02:57:38 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: z1MMMfP0zXsHchObOUpt5bCl9aMNs1ERM0orhsmB4d46iH8CZm+Kteg2YUEMxnNKFbofuP2qfY
 Vzuzt82tESom2Ceqolaw4giHu886OEo+3jd3NT7NJCyLGSjzkxXUtneNhRpP7eRet5Iac530nd
 qDBki1d27wY8W/yVEtt0IoP0iFPAOr1KFPgNLy05YAns6bfwuRZyFn9ucoy5izk/MJHL9IvN8r
 t0vop5mOVteiRqIEC7oCVgZCNJ2wpmQnoy2fK8D7bUS8t3i5uETwM1kPZNRy5wVWO4xFnV0oEL
 KK4=
X-IronPort-AV: E=Sophos;i="5.68,250,1569308400"; 
   d="scan'208";a="55099711"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Oct 2019 23:57:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 30 Oct 2019 23:57:35 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 30 Oct 2019 23:57:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bga/UFWTVVK7Pv/GBkH3LxoPTHUkFYIT7hp4I3RjeCDR3cmcUOTRXLLEEDmD56t0bYEk8OGZaNwZT3rh9tRwJ1rE4PT1AYBFHk+5dW7tFDVVKAB6jF+bKtYEs99/TTrHkJgnjKgcD6ZRuPdRvDYeFo0oKoAxG+rtJ7Xwd9wEB735ShWxzxXnpZQl0P/S5Temt2tAga+MTf3d2IMgTIx0LEa8ey0ULmSdS0DCGtVP5zxMx+96wWx/P3Z18HZez5v6wdFmKwfToMp9la58vKTjzcf8iLNw1WYV6KK6fJMCb52bY61+8wyNJMOLHW/1f0IOUHGpYSI/9BwliDIif3fVbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEfq6xiMnM2BenQGQqEXViaFIhugorfmHfTxDciUfEk=;
 b=m30mEsaD2Fot3Cpz07rOZz4zkUNScAGbbOloGxZiC7614gFBUheFW9Z4HYHALNdzoL4l7UanuunSvnEm4osyr3WzNPO457CLeytWqyfOCg+N0C6DVHl4oi6eZckceaMbog578BvqQ+u1VNOCtQ5T2R3cHO8JYPDkmA9vdFSnxzLatQYFwfSHbdQgohHL7SSpxN1w1FlsrR7atSjnd2zTILRbK6k8t3H8PSb+3z4RMPwGXuB9yO9ZkSrjmREdSWBYQl6kLKhu4mdYHI0UqCPc9RpLfGbIPFFQcpAuvG+3vVI2moCWGiq4TO4cRTO3oOc97Q5vZNhTYQWr5gbqV1RV0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEfq6xiMnM2BenQGQqEXViaFIhugorfmHfTxDciUfEk=;
 b=seSAw14TAY7Q5uCC3RLpNrmbM/g+of0hErDrjf6EQFbJJ45wWyNQprTcJsFi2RnB4/Y/KNXpUjW9qc2J57ZJuVL2EPs0k+YlJhDaKu6z8Wqu50baU7m0JxKLzmDCmSeDMIYFpSIWwjk8oxbipIAUAjfFBVHzaNz8FRmTQ5cZWoE=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3758.namprd11.prod.outlook.com (20.178.253.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Thu, 31 Oct 2019 06:57:29 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.018; Thu, 31 Oct 2019
 06:57:29 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 15/32] mtd: spi-nor: Check for errors after each
 Register Operation
Thread-Topic: [PATCH v3 15/32] mtd: spi-nor: Check for errors after each
 Register Operation
Thread-Index: AQHVjkppKS3wm6HFREK56+6iD+phXKd0VEwA
Date:   Thu, 31 Oct 2019 06:57:29 +0000
Message-ID: <91a9b400-df16-8b9d-6503-a67b9f23205a@microchip.com>
References: <20191029111615.3706-1-tudor.ambarus@microchip.com>
 <20191029111615.3706-16-tudor.ambarus@microchip.com>
In-Reply-To: <20191029111615.3706-16-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0256.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::23) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16adad27-0090-4f4c-e446-08d75dcf983d
x-ms-traffictypediagnostic: MN2PR11MB3758:
x-microsoft-antispam-prvs: <MN2PR11MB375871337D47BDACC2868804F0630@MN2PR11MB3758.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(346002)(366004)(39860400002)(189003)(199004)(66066001)(2906002)(386003)(31686004)(66446008)(36756003)(6486002)(71200400001)(8936002)(99286004)(6436002)(6512007)(4744005)(8676002)(305945005)(71190400001)(2201001)(7736002)(86362001)(31696002)(25786009)(81166006)(81156014)(66946007)(64756008)(14454004)(6246003)(66476007)(2501003)(256004)(478600001)(66556008)(53546011)(102836004)(76176011)(6116002)(26005)(316002)(54906003)(486006)(476003)(6506007)(5660300002)(3846002)(186003)(11346002)(446003)(2616005)(52116002)(110136005)(4326008)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3758;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KE7B8DTUMEnhnM5DxhgAT1xCfIudQfPW8b4rbm/9BGUyYr1nAoos/eJzQqrWaxhH1boliHl+b80x+KGlZ0yAiwBnFEN8WMo2nkk7R6H0C52vJTgOIELsDXfFMWeomFpFtBGp9sC6JNsnLxjCgYkZBgkfypEUyMmI8jMAvT+fgDNWnBCcnnmjSioALzQ+Bw4F0Kg7oWWqQkUjZbVWQTdIBk3454FzI9McMj4J0XDXZBUf20zprpARgHYU2rRf0RTXlt3paCPy5Gkicxx7Qx5/BV3GSK6BE/wE0OmciNCOms0eFWcXwCa+eOcyqSJaOeeQhXG/b+vAw/sqQuH0J05BlovJRKrjZKnDCCnBW/XAreET6mt5o8TFMW7SUwc89sn9wu/lJi9Ff9fOo+TLyBFXjA/YdGVgOBFolQSW4cPhYOMa/QlkH+YNpB2UNaZ8xTXN
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFFFAB3609821B4688F975E2D0CE49DD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 16adad27-0090-4f4c-e446-08d75dcf983d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 06:57:29.2949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KLya4kW+8q/GJOrX9RuvOYHXZQbFbzLbrma/orHiftaecgmgP0yE7SrtYYuRBLiEqAGiMiiPKsPl7GvY55E5Pe3z9orYrCTVXok0TFCiJvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3758
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzI5LzIwMTkgMDE6MTcgUE0sIFR1ZG9yIEFtYmFydXMgLSBNMTgwNjQgd3JvdGU6
DQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+IEBAIC01OTUsMTEgKzU5
NSwxNSBAQCBzdGF0aWMgaW50IHN0X21pY3Jvbl9zZXRfNGJ5dGUoc3RydWN0IHNwaV9ub3IgKm5v
ciwgYm9vbCBlbmFibGUpDQo+ICB7DQo+ICAJaW50IHJldDsNCj4gIA0KPiAtCXNwaV9ub3Jfd3Jp
dGVfZW5hYmxlKG5vcik7DQo+ICsJcmV0ID09IHNwaV9ub3Jfd3JpdGVfZW5hYmxlKG5vcik7DQoN
CnRoZXJlJ3MgYSB0eXBvIGhlcmUsIGl0IHNob3VsZCBoYXZlIGJlZW4gaW5pdGlhbGl6YXRpb24u
IFdpbGwgcmVzcGluIGlmIG90aGVyDQpjb21tZW50cyB3aWxsIGFyaXNlLg0K
