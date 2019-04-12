Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C264EC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3442084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="lpeRzrMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfDLOeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:34:36 -0400
Received: from mail-eopbgr00136.outbound.protection.outlook.com ([40.107.0.136]:23705
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726711AbfDLOeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+WqfrOAislkhUoZM0QEfI0S8r+OmO5pJLjhndfEnSA=;
 b=lpeRzrMq6MdXh9hDhfWsFqE5DtlMNltzLsPL5E0KWoJVsaXNGipiG4M5vENjFV+3qN8302549mmTfiMSKNXSMOLljP4FA2uXa0voTUUy2fKUvX/FewOcBcVFBFm11ZQz4HzdcYx/BUtxS5MhA5uQU3yfdGeX31fSshOIxaPJxs8=
Received: from AM0PR07MB6019.eurprd07.prod.outlook.com (20.178.112.14) by
 AM0PR07MB5779.eurprd07.prod.outlook.com (20.178.116.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.8; Fri, 12 Apr 2019 14:34:33 +0000
Received: from AM0PR07MB6019.eurprd07.prod.outlook.com
 ([fe80::8538:2f6b:1fad:e3e7]) by AM0PR07MB6019.eurprd07.prod.outlook.com
 ([fe80::8538:2f6b:1fad:e3e7%2]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 14:34:33 +0000
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
Subject: RE: [PATCH v3] firmware/psci: add support for SYSTEM_RESET2
Thread-Topic: [PATCH v3] firmware/psci: add support for SYSTEM_RESET2
Thread-Index: AQHU8Rbce2uNzvNaY0W8EWKrD5QHSqY4lx9e
Date:   Fri, 12 Apr 2019 14:34:33 +0000
Message-ID: <AM0PR07MB60191CB0EC392AAEBD90E3B0F4280@AM0PR07MB6019.eurprd07.prod.outlook.com>
References: <20190412100227.15024-1-sudeep.holla@arm.com>
In-Reply-To: <20190412100227.15024-1-sudeep.holla@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aaro.koskinen@nokia.com; 
x-originating-ip: [131.228.2.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77811c3e-1513-4c32-a029-08d6bf53fb05
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR07MB5779;
x-ms-traffictypediagnostic: AM0PR07MB5779:
x-microsoft-antispam-prvs: <AM0PR07MB5779298000B3F4D16C2DED8DF4280@AM0PR07MB5779.eurprd07.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(136003)(346002)(189003)(199004)(7736002)(25786009)(8676002)(102836004)(316002)(305945005)(106356001)(71200400001)(71190400001)(6436002)(508600001)(33656002)(229853002)(2201001)(105586002)(86362001)(2501003)(66066001)(99286004)(7696005)(256004)(97736004)(74316002)(52536014)(76176011)(110136005)(486006)(6506007)(4744005)(186003)(68736007)(5660300002)(6246003)(53936002)(11346002)(3846002)(54906003)(26005)(446003)(2906002)(476003)(4326008)(55016002)(6116002)(81156014)(81166006)(9686003)(8936002)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR07MB5779;H:AM0PR07MB6019.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 27eDZigWwNDkXNMmnXTPkiOzsk4HcAAgQyn30hfkWlujrBKZWljvPrCd0FAs71Jnhta369yQFHGhU+XWl2NOcc3sz8YOthJlO4n2xRpUiUZoo0dcuY/Vxv/dWMzicqZvueEs8zehniUWofqGrvDeu9oFzS4ZXawd42gHSGdeb9arP8qOaf7/4eChmA11PJIYH6y2/B814ID/5WallCY935FmCbjp3DVNZHyVmifxoFS31mzTagqyW6J9ftG0slcf1+kzcOZe8/9EBqQarGaFKOsyUnhu69RhwyKqO8TrEeg3UWPK5wbKPR6eSdGnEsCo8aNUWleYnmcTFeyxPXskqSsaBlNc2vapiOhESG9dAw5d5MRmG8/JPac4kJFhCQtiAgJUW4k8u9ouzV2mhz9LWQOnq7fpv3cKJLnpkvz3NL0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77811c3e-1513-4c32-a029-08d6bf53fb05
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 14:34:33.3674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB5779
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

From: Sudeep Holla [sudeep.holla@arm.com]:
> PSCI v1.1 introduced SYSTEM_RESET2 to allow both architectural resets
> where the semantics are described by the PSCI specification itself as
> well as vendor-specific resets. Currently only system warm reset
> semantics is defined as part of architectural resets by the specification=
.
>
> This patch implements support for SYSTEM_RESET2 by making using of
> reboot_mode passed by the reboot infrastructure in the kernel.
>=20
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Tested-by: Aaro Koskinen <aaro.koskinen@nokia.com>

Thanks,

A.
