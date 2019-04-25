Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B019C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F88206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="glaoCWHO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GrUCNbyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfDYBAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 21:00:50 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:40736 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728625AbfDYBAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 21:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556154048; x=1587690048;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=QA3XTFfMyu3oIJAhWpZFNNcQyxJyUceND3Co3CJkAfc=;
  b=glaoCWHO9YO9dW5aBUE7PhaVh0nMBJtLmJNEQTczgQgyzGj/Wr1rm46h
   biSD5ykDo8ohgFtYP3e8+Y6qATqZatDEww5izj4LWXGysfcV35kAixf2p
   LMYzFJp3+amaPRZcVwK6s66fSZ11kVCZlBvhPqye7Vt/Sd3tQrKlmlkdt
   XDpHMMquJnZ2wvv0uy8oUtPa9D6bJr7kWuT94e0FjSET0SzPfm/Hro/Nm
   9PA3vFdy91b1JeRxMiwe7RYOzSsb1BY+v9sgu6DJDrWsNerEoV8i2/GwB
   Pt/nwPQDqYG8cKo2e3XF3N6csGdAJrPiTM4wzO9zMR3iVQy55Lk2D6VXX
   w==;
X-IronPort-AV: E=Sophos;i="5.60,391,1549900800"; 
   d="scan'208";a="212596866"
Received: from mail-sn1nam01lp2059.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.59])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2019 09:00:48 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6PCxwYvdpJO0o3MWu+/njJD62V0M4rdHv8UnDU2JPs=;
 b=GrUCNbybWR1pAqExZbcXNUKKDtZ/kccPtnCaaUsSv5Kgw9WxlcJbP4DpJMlutMk4Uwewknk6yvH0bUnSJHWHlTM2387Uy8FTB8zWboK2eRfvSOrX7HIgQ8ccfP91IG1z60E6WflAxWTyWJlBkmMmGHmEmV225Gl3MPvJHqYU4YU=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB5376.namprd04.prod.outlook.com (20.178.6.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Thu, 25 Apr 2019 01:00:47 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%3]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 01:00:47 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/3] drivers: nvme: target: core: fix build break
Thread-Topic: [PATCH 1/3] drivers: nvme: target: core: fix build break
Thread-Index: AQHU+olplXurJu077k6x4MM2ZNk77g==
Date:   Thu, 25 Apr 2019 01:00:46 +0000
Message-ID: <SN6PR04MB452772B2864B2074DDB018ED863D0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <1556102081-11820-1-git-send-email-info@metux.net>
 <1556102081-11820-2-git-send-email-info@metux.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9167e2b-7378-4532-f548-08d6c91973a8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB5376;
x-ms-traffictypediagnostic: SN6PR04MB5376:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB537609B4CA111B4ED23ED9DE863D0@SN6PR04MB5376.namprd04.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(136003)(39860400002)(346002)(189003)(199004)(51914003)(3846002)(229853002)(6116002)(2906002)(8676002)(66556008)(53936002)(66946007)(64756008)(52536014)(66446008)(66476007)(73956011)(81166006)(14454004)(91956017)(33656002)(76116006)(81156014)(6436002)(8936002)(1250700005)(2501003)(6246003)(7736002)(55016002)(9686003)(478600001)(97736004)(4326008)(476003)(305945005)(68736007)(71190400001)(316002)(99286004)(7696005)(71200400001)(102836004)(186003)(74316002)(54906003)(26005)(110136005)(446003)(486006)(5660300002)(72206003)(76176011)(14444005)(53546011)(6506007)(25786009)(66066001)(86362001)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5376;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rpzrGDhJlU6FcDRLBUI2rRm9bB0XoKBVgqtBukmhYchiXqbH0rHMHwMcEdRUKHf8iU+ctlNz7c+WLu4a7Zz1JO3seIkzKTJdgaR0gaktuqulHjTBvExco4NOFnUPVXNJDsDdHzdGLfirZjJplEsye1MgkPPHPo+8Fua4HfD8MRHC/qHn4bg/eQmum7PhNdQNJeZJAUMi2wm4zMvfyUpzDhInsgJe42P5DUual0SlKoHjmSH+Tp84dWLhPYMakU7XmuZRqDR1KrXgXu8KUz6JR8QgklYApi3wvUDEVLMpyTI74N30P73pszpmgiWd2eC1z2niRWgn2dx3SPtqAeMq/diGnC4ArO1DpfYxYA60Z92p/mikyhWW+XIS7DgWiQ9pUu1FUk8x44kTlYIKXF6k0w7d2doB9RzHUKj3SImoGJk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9167e2b-7378-4532-f548-08d6c91973a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 01:00:46.9790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5376
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the fix Enrico. I'm still wondering on what platform=0A=
you got this error ?=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 04/24/2019 03:35 AM, Enrico Weigelt, metux IT consult wrote:=0A=
> Build breaks:=0A=
>=0A=
>      drivers/nvme/target/core.c: In function 'nvmet_req_alloc_sgl':=0A=
>      drivers/nvme/target/core.c:939:12: error: implicit declaration of \=
=0A=
> function 'sgl_alloc'; did you mean 'bio_alloc'? \=0A=
> [-Werror=3Dimplicit-function-declaration]=0A=
>        req->sg =3D sgl_alloc(req->transfer_len, GFP_KERNEL, &req->sg_cnt)=
;=0A=
>                  ^~~~~~~~~=0A=
>                  bio_alloc=0A=
>      drivers/nvme/target/core.c:939:10: warning: assignment makes pointer=
 \=0A=
> from integer without a cast [-Wint-conversion]=0A=
>        req->sg =3D sgl_alloc(req->transfer_len, GFP_KERNEL, &req->sg_cnt)=
;=0A=
>                ^=0A=
>      drivers/nvme/target/core.c: In function 'nvmet_req_free_sgl':=0A=
>      drivers/nvme/target/core.c:952:3: error: implicit declaration of \=
=0A=
> function 'sgl_free'; did you mean 'ida_free'? [-Werror=3Dimplicit-functio=
n-declaration]=0A=
>         sgl_free(req->sg);=0A=
>         ^~~~~~~~=0A=
>         ida_free=0A=
>=0A=
> Cause:=0A=
>=0A=
>      1. missing include to <linux/scatterlist.h>=0A=
>      2. SGL_ALLOC needs to be enabled=0A=
>=0A=
> Therefore adding the missing include, as well as Kconfig dependency.=0A=
>=0A=
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>=0A=
> ---=0A=
>   drivers/nvme/target/Kconfig | 1 +=0A=
>   drivers/nvme/target/core.c  | 1 +=0A=
>   2 files changed, 2 insertions(+)=0A=
>=0A=
> diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig=0A=
> index d94f25c..3ef0a4e 100644=0A=
> --- a/drivers/nvme/target/Kconfig=0A=
> +++ b/drivers/nvme/target/Kconfig=0A=
> @@ -3,6 +3,7 @@ config NVME_TARGET=0A=
>   	tristate "NVMe Target support"=0A=
>   	depends on BLOCK=0A=
>   	depends on CONFIGFS_FS=0A=
> +	select SGL_ALLOC=0A=
>   	help=0A=
>   	  This enabled target side support for the NVMe protocol, that is=0A=
>   	  it allows the Linux kernel to implement NVMe subsystems and=0A=
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c=0A=
> index b3e765a..08851f5 100644=0A=
> --- a/drivers/nvme/target/core.c=0A=
> +++ b/drivers/nvme/target/core.c=0A=
> @@ -8,6 +8,7 @@=0A=
>   #include <linux/random.h>=0A=
>   #include <linux/rculist.h>=0A=
>   #include <linux/pci-p2pdma.h>=0A=
> +#include <linux/scatterlist.h>=0A=
>=0A=
>   #include "nvmet.h"=0A=
>=0A=
>=0A=
=0A=
