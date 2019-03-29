Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9563BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 12:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548D52173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 12:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="JP6uAtrW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbfC2MCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 08:02:01 -0400
Received: from mail-eopbgr30086.outbound.protection.outlook.com ([40.107.3.86]:1545
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729434AbfC2MCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 08:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYWtsYZK2d4KlPP7viu+UdAGNHbrWcT0FTNGl0XwEvY=;
 b=JP6uAtrWU4GtiMIyGyckXvb6w9dCL8L9aFRfT8FQmcQ7nxJQirhih/ssfF/e+SFZneUmAnItPzo0NboapQNb7Mh7rjlh1/L4PmL3kHw01MtPYRn1Yc9w+boHD4kzpbDiAUjzGVj2/caoX3h1mXrOHqtBxBTXocmk3KwHILEacHU=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB1688.eurprd08.prod.outlook.com (10.169.226.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Fri, 29 Mar 2019 12:01:56 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::1150:dc18:a9dc:e17f]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::1150:dc18:a9dc:e17f%2]) with mapi id 15.20.1750.017; Fri, 29 Mar 2019
 12:01:56 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>, Sean Paul <sean@poorly.run>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Rob Clark <robdclark@gmail.com>,
        =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH v2] drm: prefix header search paths with $(srctree)/
Thread-Topic: [PATCH v2] drm: prefix header search paths with $(srctree)/
Thread-Index: AQHU5ic0uA1of+s1B0+BwMzAq+HTEA==
Date:   Fri, 29 Mar 2019 12:01:56 +0000
Message-ID: <20190329120149.GA16140@james-ThinkStation-P300>
References: <1553859161-2628-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1553859161-2628-1-git-send-email-yamada.masahiro@socionext.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:203:2e::27) To DB6PR0801MB1990.eurprd08.prod.outlook.com
 (2603:10a6:4:6c::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb5f5f4f-6f44-40cc-2d00-08d6b43e56db
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1688;
x-ms-traffictypediagnostic: DB6PR0801MB1688:
x-ms-exchange-purlcount: 1
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB16881C821719F004EFA77423B35A0@DB6PR0801MB1688.eurprd08.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(376002)(346002)(366004)(136003)(396003)(199004)(189003)(26005)(4326008)(33656002)(6116002)(478600001)(25786009)(229853002)(476003)(102836004)(52116002)(55236004)(6916009)(11346002)(6506007)(386003)(14454004)(446003)(76176011)(186003)(8936002)(71190400001)(71200400001)(1076003)(316002)(486006)(8676002)(3846002)(99286004)(66066001)(966005)(256004)(6306002)(81156014)(6512007)(97736004)(54906003)(6436002)(6246003)(305945005)(6486002)(81166006)(9686003)(2906002)(53936002)(105586002)(86362001)(33716001)(7416002)(68736007)(106356001)(58126008)(7736002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1688;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Pt6BzTL5z1pEa36GU2198+bImorgeMwp0ynEpBjp52ViumtHNgVPco4H0ETiGPeMJD+sIj8EtY2YUH9prScVSBNqVwVX5QCwnatMbTE4EuDArdlEu7Pd1OH/hYm64CbXHDTUFRF3BihZCWlIM9xRraSzzHHKKhTOzTtl/17a/fpoMxgHXnHLjdov1/ys8ZcyFHUjzH0FV3X2FdRx4fx58BtsE/WluPeDukeGtcbkAA7MK6FC3l5NiM9+LCUSXi7GdSI0W+YqZnYQD/3WT2gkeSLLmEcWAvdrch7sq+t+5XEDn2Xc20/dFWoEQa0cXVoinozy77dna11MSgN+G32DytuqOLWX6TOC4VNVHGrituJF1akM68tZBacfzrvWuNnQkpMVgiB+kubYFfzZlL7zwN5w3U9/T1+WE6Dtxnu2VXk=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <865BFCE5FA227C4B89CF3E89C08B15E5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5f5f4f-6f44-40cc-2d00-08d6b43e56db
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 12:01:56.4556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1688
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 08:32:41PM +0900, Masahiro Yamada wrote:
> Currently, the Kbuild core manipulates header search paths in a crazy
> way [1].
>=20
> To fix this mess, I want all Makefiles to add explicit $(srctree)/ to
> the search paths in the srctree. Some Makefiles are already written in
> that way, but not all. The goal of this work is to make the notation
> consistent, and finally get rid of the gross hacks.
>=20
> Having whitespaces after -I does not matter since commit 48f6e3cf5bc6
> ("kbuild: do not drop -I without parameter").
>=20
> [1]: https://patchwork.kernel.org/patch/9632347/
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>=20
> I put all gpu/drm changes into a single patch because
> they are trivial conversion.
>=20
> If you are interested in the big picture of this work,
> the full patch set is available at the following URL.
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git =
build-test
>=20
>=20
> Changes in v2:
>   - fix up the new driver komeda
>   - Add Sam's Reviewed-by
>=20
>  drivers/gpu/drm/amd/amdgpu/Makefile         | 2 +-
>  drivers/gpu/drm/amd/lib/Makefile            | 2 +-
>  drivers/gpu/drm/arm/display/komeda/Makefile | 4 ++--
>  drivers/gpu/drm/i915/gvt/Makefile           | 2 +-
>  drivers/gpu/drm/msm/Makefile                | 6 +++---
>  drivers/gpu/drm/nouveau/Kbuild              | 8 ++++----
>  6 files changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/am=
dgpu/Makefile
> index 466da59..62bf9da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -23,7 +23,7 @@
>  # Makefile for the drm device driver.  This driver provides support for =
the
>  # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
> =20
> -FULL_AMD_PATH=3D$(src)/..
> +FULL_AMD_PATH=3D$(srctree)/$(src)/..
>  DISPLAY_FOLDER_NAME=3Ddisplay
>  FULL_AMD_DISPLAY_PATH =3D $(FULL_AMD_PATH)/$(DISPLAY_FOLDER_NAME)
> =20
> diff --git a/drivers/gpu/drm/amd/lib/Makefile b/drivers/gpu/drm/amd/lib/M=
akefile
> index 6902430..d534992 100644
> --- a/drivers/gpu/drm/amd/lib/Makefile
> +++ b/drivers/gpu/drm/amd/lib/Makefile
> @@ -27,6 +27,6 @@
>  # driver components or later moved to kernel/lib for sharing with
>  # other drivers.
> =20
> -ccflags-y :=3D -I$(src)/../include
> +ccflags-y :=3D -I $(srctree)/$(src)/../include
> =20
>  obj-$(CONFIG_CHASH) +=3D chash.o
> diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/dr=
m/arm/display/komeda/Makefile
> index 1b875e5..a72e30c 100644
> --- a/drivers/gpu/drm/arm/display/komeda/Makefile
> +++ b/drivers/gpu/drm/arm/display/komeda/Makefile
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
> =20
>  ccflags-y :=3D \
> -	-I$(src)/../include \
> -	-I$(src)
> +	-I $(srctree)/$(src)/../include \
> +	-I $(srctree)/$(src)
> =20
>  komeda-y :=3D \
>  	komeda_drv.o \
> diff --git a/drivers/gpu/drm/i915/gvt/Makefile b/drivers/gpu/drm/i915/gvt=
/Makefile
> index 271fb46..ea8324a 100644
> --- a/drivers/gpu/drm/i915/gvt/Makefile
> +++ b/drivers/gpu/drm/i915/gvt/Makefile
> @@ -5,5 +5,5 @@ GVT_SOURCE :=3D gvt.o aperture_gm.o handlers.o vgpu.o tra=
ce_points.o firmware.o \
>  	execlist.o scheduler.o sched_policy.o mmio_context.o cmd_parser.o debug=
fs.o \
>  	fb_decoder.o dmabuf.o page_track.o
> =20
> -ccflags-y				+=3D -I$(src) -I$(src)/$(GVT_DIR)
> +ccflags-y				+=3D -I $(srctree)/$(src) -I $(srctree)/$(src)/$(GVT_DIR)/
>  i915-y					+=3D $(addprefix $(GVT_DIR)/, $(GVT_SOURCE))
> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> index 56a70c7..b7b1ebd 100644
> --- a/drivers/gpu/drm/msm/Makefile
> +++ b/drivers/gpu/drm/msm/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
> -ccflags-y :=3D -Idrivers/gpu/drm/msm
> -ccflags-y +=3D -Idrivers/gpu/drm/msm/disp/dpu1
> -ccflags-$(CONFIG_DRM_MSM_DSI) +=3D -Idrivers/gpu/drm/msm/dsi
> +ccflags-y :=3D -I $(srctree)/$(src)
> +ccflags-y +=3D -I $(srctree)/$(src)/disp/dpu1
> +ccflags-$(CONFIG_DRM_MSM_DSI) +=3D -I $(srctree)/$(src)/dsi
> =20
>  msm-y :=3D \
>  	adreno/adreno_device.o \
> diff --git a/drivers/gpu/drm/nouveau/Kbuild b/drivers/gpu/drm/nouveau/Kbu=
ild
> index ea3035e..4fae728 100644
> --- a/drivers/gpu/drm/nouveau/Kbuild
> +++ b/drivers/gpu/drm/nouveau/Kbuild
> @@ -1,7 +1,7 @@
> -ccflags-y +=3D -I$(src)/include
> -ccflags-y +=3D -I$(src)/include/nvkm
> -ccflags-y +=3D -I$(src)/nvkm
> -ccflags-y +=3D -I$(src)
> +ccflags-y +=3D -I $(srctree)/$(src)/include
> +ccflags-y +=3D -I $(srctree)/$(src)/include/nvkm
> +ccflags-y +=3D -I $(srctree)/$(src)/nvkm
> +ccflags-y +=3D -I $(srctree)/$(src)
> =20
>  # NVKM - HW resource manager
>  #- code also used by various userspace tools/tests
> --=20
> 2.7.4

--=20
Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
