Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78C9C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76FDF21655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Jubp7V1D";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XvGiixCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfD2WOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 18:14:18 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:49900 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729418AbfD2WOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 18:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556576057; x=1588112057;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=H6/2My/oBeyEMr8knKbYDg9V3p8RV6oSDaRpUlofUbs=;
  b=Jubp7V1DaeXK/Ea0NRYWZFBjpklbuYTOFVb9j3gsvTAEsZHJyzbwne/n
   4YZXZ0MxWhvaj5nSjWFUb6rHHnRWfKvRA7LPLZVIFPg7uyP1u/RTG4FgZ
   hfyMiuiMlk7feWRvZcUZeAraLwcdZLa3hevoYDUI+cQwOKFZytJQCiJhz
   RP5oh6+ssfxaqTfFBujOvguVbumOGW4OcZRb0FNradX2CkDTJEhfYrhTm
   PDZo0CzRKLQ+UhQPs13Y/ZDZ9aXqOKcsWBy1M4Y+0ZyGrOwLlXcYL8UVq
   +1GqADBybGeIn5j45C6Wmg/LwR0NpHsVRCpqx5kWTVmVr/eU4A/G+1Un/
   w==;
X-IronPort-AV: E=Sophos;i="5.60,411,1549900800"; 
   d="scan'208";a="107111305"
Received: from mail-by2nam03lp2059.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.59])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2019 06:14:17 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZpaWikFzYerIERmLP0LjFEuWIYEN7VdqdPQaRV/5tQ=;
 b=XvGiixCUbgcshpLNI89CwEteCc6k6OmU3YC/ooVqErcpHQAYLYA/TKTCVr3X0QHriIVeUaqk3CH8mfkHOyTtdh2SyoAB6/phkMJpnqEcMuZ9buqDuTZa4RiRJ4jZWSjrVjq5B7wP3kfGRW4v7ydN6XW8OuEfU3k+pcfnKogmEwk=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4319.namprd04.prod.outlook.com (52.135.72.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.15; Mon, 29 Apr 2019 22:14:15 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1835.015; Mon, 29 Apr 2019
 22:14:15 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Minwoo Im <minwoo.im.dev@gmail.com>
CC:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvmet: fix ptr_ret.cocci warnings
Thread-Topic: [PATCH] nvmet: fix ptr_ret.cocci warnings
Thread-Index: AQHU/rUi/X3mcWJFukeNj8Wd9t7TxQ==
Date:   Mon, 29 Apr 2019 22:14:15 +0000
Message-ID: <SN6PR04MB45271D793C898E527914578086390@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <201904300131.gB7Qr2Ik%lkp@intel.com>
 <20190429175734.GA20932@lkp-kbuild08>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 641456d2-10ed-436e-939f-08d6ccf00441
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4319;
x-ms-traffictypediagnostic: SN6PR04MB4319:
x-ms-exchange-purlcount: 1
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4319DC226DCD341472F2E54486390@SN6PR04MB4319.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:327;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(54906003)(72206003)(25786009)(476003)(7696005)(71190400001)(33656002)(99286004)(81156014)(316002)(52536014)(8936002)(6916009)(53936002)(966005)(71200400001)(5660300002)(486006)(2906002)(81166006)(478600001)(6306002)(9686003)(55016002)(66066001)(68736007)(97736004)(76176011)(4326008)(6506007)(102836004)(53546011)(8676002)(6246003)(446003)(66446008)(186003)(6436002)(64756008)(14454004)(74316002)(7736002)(66476007)(76116006)(229853002)(73956011)(66946007)(91956017)(3846002)(305945005)(6116002)(256004)(66556008)(86362001)(14444005)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4319;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0hCbZ+afmIGFj+tbpcvvV+k6ggVxdXgLn2t4rf8WmsS59CR0nKe9/13dLpZ/qIxjPNmIzNsF2mBaO2HhI6QX+CMVQ7BxmOKJudgP3LO8Ig7R/SXeje6ciaHDmnkfhoCp2zB6PraLR9G1Nzq2+/vxF2T/HItEz7ubgoyxS5VZYjZ6/DIztJMz7aoKqg+g1TmlovWRZyaARWeZt6wEhJCOteACOiv8VohPSKLjo5MFa5BEOqixFu5Modp2Boz2mpOYcXbExLMWLAD1jBHhkPbxyNqE3aIJvHkLeFhf+hgdm5Rwh8VTD76GI8bh+C1p6OiHdgYtzobFkJ2Xprvio1mtPNc2i8XwbsZwLakTvEOhUdYaBOcMh07tZp4S8XbKHKDiPhUKYdy8z3IieeqT6CB2+pgB/fr0HYn6lqvAUAURePw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 641456d2-10ed-436e-939f-08d6ccf00441
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 22:14:15.4177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4319
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minwoo,=0A=
=0A=
Can you please resend this patch with the suggested change ?=0A=
=0A=
On 04/29/2019 10:58 AM, kbuild test robot wrote:=0A=
> From: kbuild test robot <lkp@intel.com>=0A=
>=0A=
> drivers/nvme/target/discovery.c:375:1-3: WARNING: PTR_ERR_OR_ZERO can be =
used=0A=
>=0A=
>=0A=
>   Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR=0A=
>=0A=
> Generated by: scripts/coccinelle/api/ptr_ret.cocci=0A=
>=0A=
> Fixes: 6b7e631b927c ("nvmet: return a specified error it subsys_alloc fai=
ls")=0A=
> CC: Minwoo Im <minwoo.im.dev@gmail.com>=0A=
> Signed-off-by: kbuild test robot <lkp@intel.com>=0A=
> ---=0A=
>=0A=
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.g=
it master=0A=
> head:   3d17a1de96a233cf89bfbb5a77ebb1a05c420681=0A=
> commit: 6b7e631b927ca1266b2695307ab71ed7764af75e [9188/10649] nvmet: retu=
rn a specified error it subsys_alloc fails=0A=
>=0A=
>   discovery.c |    4 +---=0A=
>   1 file changed, 1 insertion(+), 3 deletions(-)=0A=
>=0A=
> --- a/drivers/nvme/target/discovery.c=0A=
> +++ b/drivers/nvme/target/discovery.c=0A=
> @@ -372,9 +372,7 @@ int __init nvmet_init_discovery(void)=0A=
>   {=0A=
>   	nvmet_disc_subsys =3D=0A=
>   		nvmet_subsys_alloc(NVME_DISC_SUBSYS_NAME, NVME_NQN_DISC);=0A=
> -	if (IS_ERR(nvmet_disc_subsys))=0A=
> -		return PTR_ERR(nvmet_disc_subsys);=0A=
> -	return 0;=0A=
> +	return PTR_ERR_OR_ZERO(nvmet_disc_subsys);=0A=
>   }=0A=
>=0A=
>   void nvmet_exit_discovery(void)=0A=
>=0A=
=0A=
