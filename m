Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA3AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E399233FF
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="D70hMhPG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfH3HRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:17:01 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:28475 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfH3HRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:17:01 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: uES41UNVBYn0NkA/p72tRdDxQxovhjetXZN0goIPct6fB56db0jWhjbm+4y9YFk7Zc5GAHZpTE
 GoGKtjc5/a4VoDwp3zIYLrhjyO5iCv59/tsdblcinp+ErL1I5zN/StwMsxvVV8ApJMREugwmrT
 Av+1yIQ9arPW6UyH897Qio+6XANjl0zZgEc0p7nK6LGojyI38j9mZ47ikRw8AvUNGS92Z2V4Xa
 ft0wTmtmPZalI0BQKoepjsfXPShLC8cuMzSXkakMr5mn6OkfCwuwvuU6ip9wRViMSqc0pxLGmm
 2kc=
X-IronPort-AV: E=Sophos;i="5.64,446,1559545200"; 
   d="scan'208";a="44277616"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2019 00:16:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 30 Aug 2019 00:16:56 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 30 Aug 2019 00:16:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0r7LhBd7XCqBwYlC7C7pCP2+IJCfOSVwekiYA1QsYkDyE8Qd8KvX93qhNyvSEFAzq1nh0A9Dx1iQtZ0zK52QH8h6s1OosSWs/2suzT+l9RLPx30PjTY2rxt+3ZEtHzmWYXOC8CjTXWgwlzy8xOn0q7fZ6QmbQOI1xz97xlDUHRfBS7rUIyCWiCk4w+ahPHvs2QirKslrVpxvqCKb4SbRl1pgI5SbA6TranLktnW1PXEEBzTvQp1l0xN6ST5HvEWNaCcj8nXTjtrzopXAk6cb0zzP/RTRZzTgMU3vLZleUpzdxCT9nYh3PO5BYsFqPO14ODRBRv780akDRlxY1wqCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pL+n2whFQElgLivMJ+y5T74W2065B93bo9TXigQh1E=;
 b=bPWYuo/hElF/iKfdZ/35ouM18+AOPSHpFQ5Dw+tthNX7v8C8M692S1gS9luWqMsxT0k+GjQMR2mEnZSjFYB0uirraGXC2z2q/Rnrm1vwcLXMr9JY0GIvMEzqg8MqYyoFVZWevCBmzMjL3oMGOTScmkguW/AT20MD0HAJGnuLdiNccqIXuzIXIgPZtBqC9dTBwCHPVjTTsd8Ft3dMvJPyDZZA7MXm6xZmcpczPs9MmWYoVW6MJaqOdqdZjIHB8q/qGFtA+uAD2mQoVUyA7n+PA/19dL0LiQ5OKfuAYXKc6xa9BMzF3kDDHzvWo+wfA00JQw7YThw++GAsOCOqeuOW+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pL+n2whFQElgLivMJ+y5T74W2065B93bo9TXigQh1E=;
 b=D70hMhPGxRDr5QujZ6JTiOE2MohcFNGSgVDK7T8WcJfQilThoUlY80n+ipBYCcCx0kzzrxoygDpgX/Z/p7y7D3QjjIg3DaVVI22jiicdDo8HyV75lqDZ9cFNHBk1bOFVANmFjpsHtuW2Pb7dKKFy6DFrss8nOW5Qvu14iRyIY8M=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3583.namprd11.prod.outlook.com (20.178.250.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Fri, 30 Aug 2019 07:16:54 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Fri, 30 Aug 2019
 07:16:54 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Ashish.Kumar@nxp.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <kuldeep.singh@nxp.com>
Subject: Re: [PATCH v4] mtd: spi-nor: Add flash property for mt35xu02g
Thread-Topic: [PATCH v4] mtd: spi-nor: Add flash property for mt35xu02g
Thread-Index: AQHVXmJpZKL/9l+9A0Se9yorPWMbi6cTSP2A
Date:   Fri, 30 Aug 2019 07:16:54 +0000
Message-ID: <cda62665-3ed4-b309-9f40-452b12539354@microchip.com>
References: <1567080445-32695-1-git-send-email-Ashish.Kumar@nxp.com>
In-Reply-To: <1567080445-32695-1-git-send-email-Ashish.Kumar@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0502CA0011.eurprd05.prod.outlook.com
 (2603:10a6:803:1::24) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e2613aa-aa69-43e4-cce8-08d72d1a091d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3583;
x-ms-traffictypediagnostic: MN2PR11MB3583:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR11MB3583748E20CEF3AACA016FAFF0BD0@MN2PR11MB3583.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:207;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(376002)(346002)(39860400002)(199004)(189003)(31696002)(99286004)(6486002)(316002)(53546011)(6506007)(36756003)(54906003)(52116002)(31686004)(76176011)(6436002)(53936002)(102836004)(110136005)(2501003)(386003)(64756008)(4326008)(66556008)(66446008)(25786009)(66476007)(66946007)(256004)(14444005)(6512007)(26005)(186003)(229853002)(476003)(6306002)(486006)(8936002)(81166006)(2616005)(11346002)(2201001)(3846002)(6246003)(6116002)(71200400001)(71190400001)(305945005)(4744005)(7416002)(966005)(7736002)(5660300002)(2906002)(86362001)(14454004)(446003)(66066001)(8676002)(478600001)(81156014)(138113003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3583;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: P7LFpMKWrTz1fdpPMqs2Bdt3DakXDe4iQrXnAgpZaamyJ+oTifXMcbwDmP76H7vd4Cmwvx8hI/0MMmwpsHJLsXmcSDksTP466ECpqGkdbT9LsmExn1WF87IwOgWBlKHB8oaCfe3MwSgbd0+R3VV0l0g8L2NdawnImNE3EkyHSlwfKOURWJGd/Z6rclK7IUkorKYhxwoy9XBEpymknhwOCB/wel03DnxQrUUjhSJDZHhZcwGoq3sDhUUCt+KN6gffcJZoLnlIgVtivyIZcwsJ4aH4Dt1M6IATRyXsL/Yji5JpbahC5mAQ5Cxkk0Wmr3fdnpp+tvQhN57YROGfYZ3NPuZa5x/IytW4336PGYWFG6cgzBpozAq7YI4ryGe0M4eAJID5yGV69NJTVGC86sWWpXKhppT6xHnpRFvd+9tHjpM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D31C825D0120C4689030AFD56C205D2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2613aa-aa69-43e4-cce8-08d72d1a091d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 07:16:54.2831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leSmhKREUnVhKu1IrAu9OEpzYkcbwzK9K7JhGvhNA6oLwakb1AJGD5F+McCawk6gbTIBovycUWsqwgRSC6p2TK21H67zqoaJ21tpvnRKHZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3583
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzI5LzIwMTkgMDM6MDcgUE0sIEFzaGlzaCBLdW1hciB3cm90ZToNCj4gRXh0ZXJu
YWwgRS1NYWlsDQo+IA0KPiANCj4gbXQzNXh1MDJnIGlzIE9jdGFsIGZsYXNoIHN1cHBvcnRpbmcg
U2luZ2xlIEkvTyBhbmQgUUNUQUwgSS9PDQo+IGFuZCBpdCBoYXMgYmVlbiB0ZXN0ZWQgb24gTFMx
MDI4QVJEQg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS3VsZGVlcCBTaW5naCA8a3VsZGVlcC5zaW5n
aEBueHAuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBc2hpc2ggS3VtYXIgPGFzaGlzaC5rdW1hckBu
eHAuY29tPg0KPiBSZXZpZXdlZC1ieTogVmlnbmVzaCBSYWdoYXZlbmRyYSA8dmlnbmVzaHJAdGku
Y29tPg0KPiAtLS0NCj4gdjQ6DQo+IHNwbGl0IGludG8gc2VwZXJhdGUgcGF0Y2gNCj4gdjM6DQo+
IHYyOg0KPiBkaWQgbm90IGV4aXN0DQo+IA0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9y
LmMgfCAzICsrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiANCg0KUmV3
b3JkZWQgY29tbWl0IG1lc3NhZ2UgYW5kDQpBcHBsaWVkIHRvIGh0dHBzOi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L210ZC9saW51eC5naXQsDQpzcGktbm9yL25leHQg
YnJhbmNoLg0KDQpUaGFua3MsDQp0YQ0K
