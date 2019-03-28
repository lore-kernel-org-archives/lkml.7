Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D95BC10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5086320823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="h88E6O+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfC1Sh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:37:59 -0400
Received: from mail-eopbgr810114.outbound.protection.outlook.com ([40.107.81.114]:6458
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726047AbfC1Sh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsq0P9bLQNdDYF+3M/FnOd1fBxzsULhkiUUMcNzuRU0=;
 b=h88E6O+x+cMZHNV8goMMErAddbIycJ+Q3EGgwI49IZUMELi2TLNImEP/Ub4ydPGE/HtOeeJQA6PCxByqqZSBbema7DLSTNHY/WUGr1eOt2oDuq11YgJwTJVzWjg5UQYXMCgT2xGGCmE9AjLIbRKNgUzE/TarnszVJ+bIe3c+yT8=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.214.23) by
 CY4PR2201MB1398.namprd22.prod.outlook.com (10.171.210.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Thu, 28 Mar 2019 18:37:56 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::3814:18cc:d558:6039]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::3814:18cc:d558:6039%11]) with mapi id 15.20.1730.019; Thu, 28 Mar
 2019 18:37:56 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: SGI-IP27: Fix use of unchecked pointer in
  shutdown_bridge_irq
Thread-Topic: [PATCH] MIPS: SGI-IP27: Fix use of unchecked pointer in
  shutdown_bridge_irq
Thread-Index: AQHU5ZVcQXmZ6dVAt0GJm/JFIR16Vw==
Date:   Thu, 28 Mar 2019 18:37:56 +0000
Message-ID: <CY4PR2201MB12724CF36EA5944BF43631F3C1590@CY4PR2201MB1272.namprd22.prod.outlook.com>
References: <20190328133745.26506-1-tbogendoerfer@suse.de>
In-Reply-To: <20190328133745.26506-1-tbogendoerfer@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::35) To CY4PR2201MB1272.namprd22.prod.outlook.com
 (2603:10b6:910:6e::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2601:647:4100:4687:76db:7cfe:65a3:6aea]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3fb1db1-e63c-4f00-5ea1-08d6b3ac7e83
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1398;
x-ms-traffictypediagnostic: CY4PR2201MB1398:
x-microsoft-antispam-prvs: <CY4PR2201MB1398FA5D56A031B9906E7007C1590@CY4PR2201MB1398.namprd22.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(346002)(366004)(39840400004)(199004)(189003)(33656002)(6246003)(11346002)(46003)(102836004)(4326008)(446003)(386003)(6506007)(186003)(256004)(105586002)(53936002)(106356001)(42882007)(4744005)(9686003)(81166006)(81156014)(316002)(76176011)(68736007)(97736004)(54906003)(8676002)(55016002)(44832011)(229853002)(7696005)(71190400001)(99286004)(71200400001)(52116002)(8936002)(14454004)(6116002)(478600001)(7736002)(5660300002)(52536014)(74316002)(25786009)(476003)(6436002)(2906002)(486006)(305945005)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1398;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qucgHavAAvnxg3t5/7tp6wSqgfabHVaMPT82lIrmkfSPEn38NU8EDmwn5gEY/OUgMUwUaYVlXB/fZR5uBVcQB4X/Y06/waGrlwD5K4U5+0sTJ1I7g0VNAw+eV9p8mNgBnsWUW9zM9DYuEKfhB+9XUZOddXzCoJklAoAQfJrLlP8VkYv0B20KUZZyb/sD3RUPPcC+FH8oeEkgToqdKbzxDmqm9/wtwXVzkIPa91Hh+gtSoKbbOhZz0lD08wU0tpcO+E8+01NRgAZozSHKTmk95DH7I6v5rkU5plc234lCMgS//LbBzAwMcIcoYxliTZCGM9ZdUnq7CVF6z8A40HBORHjHq/eDuo1sBOK1ZpiCcp08sCuQ9VUEK1tUqGfXN5nt+r0sHarPdkIHud7czF17Sa76ddHTxdURV1wT7mZPFsg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fb1db1-e63c-4f00-5ea1-08d6b3ac7e83
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 18:37:56.0521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1398
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thomas Bogendoerfer wrote:
> smatch complaint:
>=20
> arch/mips/sgi-ip27/ip27-irq.c:123 shutdown_bridge_irq()
> warn: variable dereferenced before check 'hd' (see line 121)
>=20
> Fix it by removing local variable and use hd->pin directly.
>=20
> Fixes: 69a07a41d908 ("MIPS: SGI-IP27: rework HUB interrupts")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
