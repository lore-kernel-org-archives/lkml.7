Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584A6C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F82F20883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="DAj4YuqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfDIF0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 01:26:08 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:30457 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfDIF0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 01:26:08 -0400
X-IronPort-AV: E=Sophos;i="5.60,328,1549954800"; 
   d="scan'208";a="29720691"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Apr 2019 22:26:07 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 8 Apr 2019 22:26:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfkU66D2Iep9JERJkEZYFuurHfys/YAxlLHjMrcRWZ8=;
 b=DAj4YuqKmEh+Vvxi3Dz6mi/aDfVFU9udu+66G3DFmKyNkDUL+tDtfpXa/IjKiEErUAV0s4BhMU09XKhIP5f1P2g1sIIMys0WlGGuGLmYqmMbK9RlUX2FuRPqSkqinBJjF+UUvsXr/usCqZEis0HcZPSPmYxOoofvOelNuBG5Fo0=
Received: from BL0PR11MB3329.namprd11.prod.outlook.com (10.167.235.150) by
 BL0PR11MB3122.namprd11.prod.outlook.com (20.177.205.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Tue, 9 Apr 2019 05:26:04 +0000
Received: from BL0PR11MB3329.namprd11.prod.outlook.com
 ([fe80::24e8:ee39:be6e:9336]) by BL0PR11MB3329.namprd11.prod.outlook.com
 ([fe80::24e8:ee39:be6e:9336%2]) with mapi id 15.20.1771.021; Tue, 9 Apr 2019
 05:26:04 +0000
From:   <RaghuramChary.Jallipalli@microchip.com>
To:     <Jisheng.Zhang@synaptics.com>
CC:     <marc.zyngier@arm.com>, <Woojung.Huh@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: lan78xx: fix "enabled interrupts" warninig
Thread-Topic: [PATCH] net: lan78xx: fix "enabled interrupts" warninig
Thread-Index: AQHU7dHV0yp6Fa7I5USr12hPuITf3qYx3ZMggAALEoCAACApYIABBMYAgAA/w9A=
Date:   Tue, 9 Apr 2019 05:26:04 +0000
Message-ID: <BL0PR11MB332928F6078BB4AF41344AFE9F2D0@BL0PR11MB3329.namprd11.prod.outlook.com>
References: <20190408140301.3dcbccdd@xhacker.debian>
        <BL0PR11MB33292EC33542F7D4FE5208469F2C0@BL0PR11MB3329.namprd11.prod.outlook.com>
        <20190408155947.3efcb1eb@xhacker.debian>
        <BL0PR11MB3329824981AAA87127C157C69F2C0@BL0PR11MB3329.namprd11.prod.outlook.com>
 <20190409092753.39961390@xhacker.debian>
In-Reply-To: <20190409092753.39961390@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RaghuramChary.Jallipalli@microchip.com; 
x-originating-ip: [118.185.82.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3301ffd7-f5ad-41a5-547e-08d6bcabdc7a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:BL0PR11MB3122;
x-ms-traffictypediagnostic: BL0PR11MB3122:
x-microsoft-antispam-prvs: <BL0PR11MB312209223A4489C4D569BBF19F2D0@BL0PR11MB3122.namprd11.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(136003)(396003)(376002)(189003)(199004)(93886005)(7696005)(256004)(6916009)(106356001)(3846002)(6116002)(478600001)(486006)(54906003)(81166006)(6436002)(81156014)(316002)(25786009)(8676002)(52536014)(71200400001)(68736007)(66066001)(33656002)(476003)(71190400001)(8936002)(105586002)(76176011)(5660300002)(229853002)(11346002)(446003)(558084003)(72206003)(14454004)(305945005)(102836004)(6506007)(26005)(9686003)(2906002)(186003)(86362001)(97736004)(6246003)(55016002)(74316002)(7736002)(99286004)(53936002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR11MB3122;H:BL0PR11MB3329.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zZv6w5o2qvHA9zLVivp9n8v73il3ilSvOAjm/B85mW6poYExzp0wIL7QmZ5V1mahjUGJzfJzSDJALnnRm+ZrroHZUnNje8+LOpCzfKjmvrUsJX0N0z5/nYFzwtxKPB1TOF+IlmClzhtiSaPaDIxz3jDrSVxpb75hrxZhy9CWmBZ9qhXYDLUty3fou3VXuIeuN2K1bR9fPOLMLZgCBvUp3EWi40WVHccpsTA7R3zXQd06uW3m5usqPjLP7F3C7gLuqZHKUUdSU+e6j3PvtxLkLul6nMdj+FpU7igXdhHYogHa66bqqZVu92sFJLleupXhF2TDz+KRwF0riWT3NLFELyZeT3B+dpqI+t/N9J6pqkH5P3+zI2Si5e1JL7abnzALx/5gCXKzy0oaSkBukpcVs3plILZGSTTDnsky+hHQhCA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3301ffd7-f5ad-41a5-547e-08d6bcabdc7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 05:26:04.3117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3122
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Correct, IRQ domain is generally used in chained irq controllers.
> > Yes, We need to check why irq domain is used in the current driver.
> >
>=20
> It's introduced in the commit cc89c323a30e
>=20
Thanks Jisheng, Will check and get back ASAP.

Thanks
