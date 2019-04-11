Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E817C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0893F2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="f3/ydi3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfDKLmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:42:31 -0400
Received: from mail-eopbgr40137.outbound.protection.outlook.com ([40.107.4.137]:52958
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726517AbfDKLmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 07:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFXDviotdjPt/a06P3QY2TYk2tljEBFe2Aul5PVV8VI=;
 b=f3/ydi3O2J0rHFTGOjo447CRjqaeJ9lhqr/C+1k/2Lc8hFpStD+UH8Y5Z04fK7uRaF11tlTqPk5JbYCCxpkwogpDrPtoEhAPggQ5wmFOQokOirk5VgKJBVxOWWhkmy7upBxNrSXDsmNScixdv9OnW6qXzRb3o7HqaBN0h6qtFkQ=
Received: from AM0PR07MB6019.eurprd07.prod.outlook.com (20.178.112.14) by
 AM0PR07MB5218.eurprd07.prod.outlook.com (20.178.16.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.12; Thu, 11 Apr 2019 11:42:28 +0000
Received: from AM0PR07MB6019.eurprd07.prod.outlook.com
 ([fe80::8538:2f6b:1fad:e3e7]) by AM0PR07MB6019.eurprd07.prod.outlook.com
 ([fe80::8538:2f6b:1fad:e3e7%2]) with mapi id 15.20.1792.009; Thu, 11 Apr 2019
 11:42:28 +0000
From:   "Koskinen, Aaro (Nokia - FI/Espoo)" <aaro.koskinen@nokia.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: RE: [RESEND][PATCH v2] firmware/psci: add support for SYSTEM_RESET2
Thread-Topic: [RESEND][PATCH v2] firmware/psci: add support for SYSTEM_RESET2
Thread-Index: AQHU8FISjWdUbTwX5kqSuz7S67NyXaY209/M
Date:   Thu, 11 Apr 2019 11:42:28 +0000
Message-ID: <AM0PR07MB6019AB10C7DD38F7AFECF0E0F42F0@AM0PR07MB6019.eurprd07.prod.outlook.com>
References: <20190411103346.22462-1-sudeep.holla@arm.com>
In-Reply-To: <20190411103346.22462-1-sudeep.holla@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aaro.koskinen@nokia.com; 
x-originating-ip: [131.228.2.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e644f34-6634-4dbf-ac61-08d6be72c653
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR07MB5218;
x-ms-traffictypediagnostic: AM0PR07MB5218:
x-microsoft-antispam-prvs: <AM0PR07MB5218448221B19A9F3F18CD4CF42F0@AM0PR07MB5218.eurprd07.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(136003)(39860400002)(396003)(199004)(189003)(97736004)(106356001)(7736002)(105586002)(305945005)(3846002)(476003)(6506007)(76176011)(7696005)(54906003)(68736007)(186003)(2906002)(229853002)(102836004)(6436002)(446003)(81156014)(8936002)(99286004)(26005)(71200400001)(33656002)(2501003)(8676002)(81166006)(110136005)(6116002)(14454004)(25786009)(5660300002)(6246003)(486006)(53936002)(66066001)(71190400001)(2201001)(4744005)(11346002)(4326008)(9686003)(86362001)(52536014)(55016002)(478600001)(74316002)(316002)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR07MB5218;H:AM0PR07MB6019.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Hbdd836o7YuSNuPOTtSykdY+V8QnrkZhWEC2t8ay6n7uwwtfq4WVyFLFs6HbWEvWOjMcAkZebO5xdAY19PkFoxGQlFmB3p/7Q82h/tPUrU/WIxrGOC9O9bukab7Ba+Pgp4esbZyfHG9Plh6lE117yewdzErkPoCzO0v3xGgBDP6Eik9dpyUPxau7naTo0le8XEueECVuQ0pSEIqfWnzuWSoJRlpigee1Cr5Zcl9/n2y/PjzWgSHrTcQJi3MTGSDssqb22B+ZQqNX4RnhzMXg+YZc8j2o8EegNlGfkKSsOGiucCGQHsFytehyUWikHnwHopvTkSEgOJYxtzqAS9ekxXiCeBtajwAc//IRx+b79y+tgOlLBoCOsseaRykKxW1i2cSLl0PzCu//bX8kZ0FaAZwZ1L0kbdZs4q/QYWRHEaM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e644f34-6634-4dbf-ac61-08d6be72c653
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 11:42:28.1136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB5218
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

From: Sudeep Holla [sudeep.holla@arm.com]:
>  static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd=
)
>  {
> +       if ((reboot_mode =3D=3D REBOOT_WARM || reboot_mode =3D=3D REBOOT_=
SOFT) &&

I would omit the REBOOT_SOFT here.

> +           psci_system_reset2_supported)
> +               /*
> +                * reset_type[31] =3D 0 (architectural)
> +                * reset_type[30:0] =3D 0 (SYSTEM_WARM_RESET)
> +                * cookie =3D 0 (ignored by the implementation)
> +                */
> +               invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2), 0, 0, =
0);
> +
>        invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);

Use else here, so that we fall back to system halt if SYSTEM_RESET2 fails.

A.
