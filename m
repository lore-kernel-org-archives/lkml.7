Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D261CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF45214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="FmGGSx7o";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="FmGGSx7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfJUNuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:50:40 -0400
Received: from mail-eopbgr60051.outbound.protection.outlook.com ([40.107.6.51]:33862
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729004AbfJUNuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNQw4MAh1vWfmkMrOkpsYy90frDzjVUAtuDV5qPFGZI=;
 b=FmGGSx7oHP+VPW6cTSVki2X5QUhTe/x57CuDmIeXsPC5yHnk4xFDuPFPM/AbKG23WaI5mRmwzeQoPev9Dd0K/KM4NRpSzfCyoE+JBKo5I23tsk4gT+9tnod6N36qOFjsQstj5ohpmhQxqlF37SeXEP4egRO9ua87Dn4CjzmL2bc=
Received: from VI1PR08CA0114.eurprd08.prod.outlook.com (2603:10a6:800:d4::16)
 by DB7PR08MB3244.eurprd08.prod.outlook.com (2603:10a6:5:17::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.19; Mon, 21 Oct
 2019 13:50:30 +0000
Received: from VE1EUR03FT063.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::203) by VI1PR08CA0114.outlook.office365.com
 (2603:10a6:800:d4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2367.20 via Frontend
 Transport; Mon, 21 Oct 2019 13:50:30 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT063.mail.protection.outlook.com (10.152.18.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 21 Oct 2019 13:50:28 +0000
Received: ("Tessian outbound 0939a6bab6b1:v33"); Mon, 21 Oct 2019 13:50:22 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 02b31e81f56a8ffb
X-CR-MTA-TID: 64aa7808
Received: from c1a923bf249d.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.6.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D4774A2B-14BA-4A6A-88B9-7CD8D0178220.1;
        Mon, 21 Oct 2019 13:50:16 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2053.outbound.protection.outlook.com [104.47.6.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c1a923bf249d.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 21 Oct 2019 13:50:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzQ/jYqBx+9uwD53na4vlCy5RcoCmUWEEJSWXWzv7MmallS8afL0zc12R9FQuJCEToR+02DtfittfaQ/dutCzxVDO7xH2pRtVadulJV2RethX5EC5TCkwZvmq0qdmesQqxrbrORFQO5eJjk5sFtneDGWAYNX+kqrn/PnFTOalhXUt/ru10oX8w+xo2UniVfypJi/QNTK4d8TpQajgegDK249qQVpMFAK/BF03zKLgFgXX4r1DTayWIWQOXw/9yuTJpWEzlkmLwLqodMSqP2fshBsgTpfAbyCSlPI5iZJF4fnmPgcMRxqXIlPv7SyVaLLhSOOsn61xrgESobYDwP+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNQw4MAh1vWfmkMrOkpsYy90frDzjVUAtuDV5qPFGZI=;
 b=lyAOs3FcH9LwUf7DMxO9xDxjCIAKk4nepvvQoTqLjopv+lg8Q0lVQnyNx9OiALG63GVkdp7togg5I8XeXXFxoEYe61DO1fjJdEGrT6aEd0fzKUfdc4qMIIGkW9bdRIAHI6v6+pbSGbw/eikNjL3ECC1yB8VlVgOS4mKUuE4LdAkofVIc3o8IWLc6+knsWWiNCOgZ1UL4j+Bu6OOZzJ2tUP6cSeFTuksmCBBFxeTEIXknJujT4uKHrbAU5jBTQGgEqG8Tl8rSPj885ny/v+kGw7T+x1PoCRyyRRsuhj8SAgjjn16MO13nJxg5cW4MsnjG/nFvu5z31MRtPenCOFXPfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNQw4MAh1vWfmkMrOkpsYy90frDzjVUAtuDV5qPFGZI=;
 b=FmGGSx7oHP+VPW6cTSVki2X5QUhTe/x57CuDmIeXsPC5yHnk4xFDuPFPM/AbKG23WaI5mRmwzeQoPev9Dd0K/KM4NRpSzfCyoE+JBKo5I23tsk4gT+9tnod6N36qOFjsQstj5ohpmhQxqlF37SeXEP4egRO9ua87Dn4CjzmL2bc=
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com (52.132.215.213) by
 AM0PR08MB4561.eurprd08.prod.outlook.com (20.178.119.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.19; Mon, 21 Oct 2019 13:50:14 +0000
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::f009:c530:6569:cf6f]) by AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::f009:c530:6569:cf6f%4]) with mapi id 15.20.2367.021; Mon, 21 Oct 2019
 13:50:14 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        Sean Paul <sean@poorly.run>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH 1/2] drm/arm: Factor out generic afbc helpers
Thread-Topic: [PATCH 1/2] drm/arm: Factor out generic afbc helpers
Thread-Index: AQHVgCWk2PTQa3ML1Uqc0tbSduIYPqdlLKCA
Date:   Mon, 21 Oct 2019 13:50:14 +0000
Message-ID: <20191021135013.GA16072@arm.com>
References: <20191011111813.20851-1-andrzej.p@collabora.com>
 <20191011111813.20851-2-andrzej.p@collabora.com>
In-Reply-To: <20191011111813.20851-2-andrzej.p@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0057.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::21) To AM0PR08MB5345.eurprd08.prod.outlook.com
 (2603:10a6:208:18c::21)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.53]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 7a4136a1-fbe7-4502-31d7-08d7562da201
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM0PR08MB4561:|AM0PR08MB4561:|DB7PR08MB3244:
X-MS-Exchange-PUrlCount: 3
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB3244911A310B8A255ED38BA9E4690@DB7PR08MB3244.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;OLM:7691;
x-forefront-prvs: 0197AFBD92
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(66556008)(66446008)(6306002)(64756008)(66946007)(66476007)(3846002)(2616005)(6116002)(446003)(486006)(4326008)(44832011)(476003)(6246003)(2906002)(86362001)(11346002)(26005)(8936002)(6486002)(229853002)(5660300002)(6436002)(6512007)(81166006)(102836004)(81156014)(8676002)(1076003)(30864003)(36756003)(6506007)(386003)(14444005)(966005)(316002)(99286004)(478600001)(76176011)(256004)(54906003)(14454004)(52116002)(6916009)(186003)(66066001)(71200400001)(71190400001)(33656002)(305945005)(7736002)(25786009)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4561;H:AM0PR08MB5345.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: fwdZ5v698MYD6Lq9SXc0zqqNXyH9Z6YGuUoI/SBKmna+ZHHFx7Mcj2DlcMYZ+fjst1QTs8kQgCg+B9f1T+b4ylgIWn4Vkw+L6+rjCZV3byloEs+jkRY8S6jT+j9+oguLpdDCL/6bWOdLAvsL3jNH4pi9ZUXtDHcsCECKrnNUKOhCdUsoL6I8ZOD7t4IRR3WfQzh3s/1xqGlr/kibymPVTX+zRAcakZ7mobHlwcY4V8OIG6MoHVCzBjUmQm+goIPah1mBlwCnGcXHk8xDNedr8a5mkcUmnsfGhoRfP2Q4G5DMj+Y34NHAetz0iBZgDk05jwnDcjUFlZdmhZGl1m8zPzqKlQ6scfZ220+3vWZx9zi8kl0TdZjIp7vcdl4QEDG/682k/i66zcu+jy5zDA2xYrq9U02kCzViXHetppw0VwYbROI4KP2+pWNVJ/n0rxeOjLjAwSrS/U3LnhSx1arp+eEP4SVJpVacamO63yySNOU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B9786950CDE45D469A6CD62AB01D9560@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4561
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT063.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(136003)(189003)(199004)(86362001)(8676002)(30864003)(14454004)(26826003)(478600001)(70206006)(70586007)(8746002)(14444005)(8936002)(76130400001)(966005)(6512007)(6306002)(2906002)(4326008)(1076003)(6246003)(25786009)(36756003)(81166006)(46406003)(33656002)(81156014)(99286004)(126002)(356004)(6486002)(47776003)(97756001)(305945005)(486006)(229853002)(54906003)(76176011)(446003)(22756006)(23726003)(7736002)(316002)(36906005)(5660300002)(50466002)(3846002)(26005)(6862004)(186003)(66066001)(6506007)(102836004)(386003)(336012)(2616005)(63350400001)(6116002)(476003)(11346002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3244;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 04ec1194-78a1-40ca-9306-08d7562d9920
NoDisclaimer: True
X-Forefront-PRVS: 0197AFBD92
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lCMzLwkvTQtKhkSjgafg/dPzB4YoFk/VaFhPPGJkJVRlqQbg7yCAsCIRvr21vgMBaG+K1+l6J6GzzJifEy3UwXypzDR1DpHKxiJXNzfrCOcfhyDl6u+XSIUi/0rZH3uIxjDMN0nUEDYbcJH6ZeauRwNTJ7woXruWJDfa4vrEEeG3Ic1cLKcb8mYi0IP666cwco83z5ZPeKWJvP6gIuLKTkBUURgm8Tr17jT9ybdmesCvvf8EofocYcInb0so8+9WlZKciCm4EdQDsKQjvlrpM4xEijTIOcEuGIWVAcSEHP0rVkpxiYIfqj9w5jVpLvTIxRRbASTRyg0mO6QYSrsFI0ZW9wPbOJTOlNmrzRIMjQtrGqSlXRUIqfa4oAo0cphDQ6VTrodT5RaEJTpXey5CvDtZAv9BfKsrof8xnbTF40TH6lWbtJO73WgZtVQ+wWV3jdTsZ5EVOjFCNtDUJNT32w==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2019 13:50:28.6317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4136a1-fbe7-4502-31d7-08d7562da201
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3244
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 01:18:10PM +0200, Andrzej Pietrasiewicz wrote:
> These are useful for other users of afbc, e.g. rockchip.
>=20
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

Hi Andrzej,

Thanks a lot for doing this. Much appreciated. :)
It was on our TODO list for a long time.

I have cc-ed james.qian.wang@arm.com, Mihail.Atanassov@arm.com for
their comments as well.

> ---
>  drivers/gpu/drm/Kconfig          |   4 ++
>  drivers/gpu/drm/Makefile         |   1 +
>  drivers/gpu/drm/arm/Kconfig      |   1 +
>  drivers/gpu/drm/arm/malidp_drv.c |  58 ++--------------
>  drivers/gpu/drm/drm_afbc.c       | 114 +++++++++++++++++++++++++++++++
>  include/drm/drm_afbc.h           |  25 +++++++
>  6 files changed, 149 insertions(+), 54 deletions(-)
>  create mode 100644 drivers/gpu/drm/drm_afbc.c
>  create mode 100644 include/drm/drm_afbc.h
>=20
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 3c88420e3497..00e3f90557f4 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -195,6 +195,10 @@ config DRM_SCHED
>  	tristate
>  	depends on DRM
> =20
> +config DRM_AFBC
> +	tristate
> +	depends on DRM
Adding a 'help' would be great here. Stealing the first line from
https://www.kernel.org/doc/html/latest/gpu/afbc.html

"AFBC is a proprietary lossless image compression protocol and format.
It provides fine-grained random access and minimizes the amount of
data transferred between IP blocks."

> +
>  source "drivers/gpu/drm/i2c/Kconfig"
> =20
>  source "drivers/gpu/drm/arm/Kconfig"
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 9f0d2ee35794..55368b668355 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -31,6 +31,7 @@ drm-$(CONFIG_OF) +=3D drm_of.o
>  drm-$(CONFIG_AGP) +=3D drm_agpsupport.o
>  drm-$(CONFIG_DEBUG_FS) +=3D drm_debugfs.o drm_debugfs_crc.o
>  drm-$(CONFIG_DRM_LOAD_EDID_FIRMWARE) +=3D drm_edid_load.o
> +drm-$(CONFIG_DRM_AFBC) +=3D drm_afbc.o
> =20
>  drm_vram_helper-y :=3D drm_gem_vram_helper.o \
>  		     drm_vram_helper_common.o \
> diff --git a/drivers/gpu/drm/arm/Kconfig b/drivers/gpu/drm/arm/Kconfig
> index a204103b3efb..25c3dc408cda 100644
> --- a/drivers/gpu/drm/arm/Kconfig
> +++ b/drivers/gpu/drm/arm/Kconfig
> @@ -29,6 +29,7 @@ config DRM_MALI_DISPLAY
>  	select DRM_KMS_HELPER
>  	select DRM_KMS_CMA_HELPER
>  	select DRM_GEM_CMA_HELPER
> +	select DRM_AFBC
>  	select VIDEOMODE_HELPERS
>  	help
>  	  Choose this option if you want to compile the ARM Mali Display
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malid=
p_drv.c
> index f25ec4382277..a67b69e08f63 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -16,6 +16,7 @@
>  #include <linux/debugfs.h>
> =20
>  #include <drm/drmP.h>
> +#include <drm/drm_afbc.h>
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_crtc.h>
> @@ -33,8 +34,6 @@
>  #include "malidp_hw.h"
> =20
>  #define MALIDP_CONF_VALID_TIMEOUT	250
> -#define AFBC_HEADER_SIZE		16
> -#define AFBC_SUPERBLK_ALIGNMENT		128
> =20
>  static void malidp_write_gamma_table(struct malidp_hw_device *hwdev,
>  				     u32 data[MALIDP_COEFFTAB_NUM_COEFFS])
> @@ -275,24 +274,8 @@ malidp_verify_afbc_framebuffer_caps(struct drm_devic=
e *dev,
>  					mode_cmd->modifier[0]) =3D=3D false)
>  		return false;
> =20
> -	if (mode_cmd->offsets[0] !=3D 0) {
> -		DRM_DEBUG_KMS("AFBC buffers' plane offset should be 0\n");
> -		return false;
> -	}
> -
> -	switch (mode_cmd->modifier[0] & AFBC_SIZE_MASK) {
> -	case AFBC_SIZE_16X16:
> -		if ((mode_cmd->width % 16) || (mode_cmd->height % 16)) {
> -			DRM_DEBUG_KMS("AFBC buffers must be aligned to 16 pixels\n");
> -			return false;
> -		}
> -		break;
> -	default:
> -		DRM_DEBUG_KMS("Unsupported AFBC block size\n");
> -		return false;
> -	}
> -
> -	return true;
> +	return drm_afbc_check_offset(dev, mode_cmd) &&
> +	       drm_afbc_check_size_align(dev, mode_cmd);
>  }
> =20
>  static bool
> @@ -300,53 +283,20 @@ malidp_verify_afbc_framebuffer_size(struct drm_devi=
ce *dev,
>  				    struct drm_file *file,
>  				    const struct drm_mode_fb_cmd2 *mode_cmd)
>  {
> -	int n_superblocks =3D 0;
>  	const struct drm_format_info *info;
>  	struct drm_gem_object *objs =3D NULL;
> -	u32 afbc_superblock_size =3D 0, afbc_superblock_height =3D 0;
> -	u32 afbc_superblock_width =3D 0, afbc_size =3D 0;
>  	int bpp =3D 0;
> =20
> -	switch (mode_cmd->modifier[0] & AFBC_SIZE_MASK) {
> -	case AFBC_SIZE_16X16:
> -		afbc_superblock_height =3D 16;
> -		afbc_superblock_width =3D 16;
> -		break;
> -	default:
> -		DRM_DEBUG_KMS("AFBC superblock size is not supported\n");
> -		return false;
> -	}
> -
>  	info =3D drm_get_format_info(dev, mode_cmd);
> -
> -	n_superblocks =3D (mode_cmd->width / afbc_superblock_width) *
> -		(mode_cmd->height / afbc_superblock_height);
> -
>  	bpp =3D malidp_format_get_bpp(info->format);
> =20
> -	afbc_superblock_size =3D (bpp * afbc_superblock_width * afbc_superblock=
_height)
> -				/ BITS_PER_BYTE;
> -
> -	afbc_size =3D ALIGN(n_superblocks * AFBC_HEADER_SIZE, AFBC_SUPERBLK_ALI=
GNMENT);
> -	afbc_size +=3D n_superblocks * ALIGN(afbc_superblock_size, AFBC_SUPERBL=
K_ALIGNMENT);
> -
> -	if ((mode_cmd->width * bpp) !=3D (mode_cmd->pitches[0] * BITS_PER_BYTE)=
) {
> -		DRM_DEBUG_KMS("Invalid value of (pitch * BITS_PER_BYTE) (=3D%u) "
> -			      "should be same as width (=3D%u) * bpp (=3D%u)\n",
> -			      (mode_cmd->pitches[0] * BITS_PER_BYTE),
> -			      mode_cmd->width, bpp);
> -		return false;
> -	}
> -
>  	objs =3D drm_gem_object_lookup(file, mode_cmd->handles[0]);
>  	if (!objs) {
>  		DRM_DEBUG_KMS("Failed to lookup GEM object\n");
>  		return false;
>  	}
> =20
> -	if (objs->size < afbc_size) {
> -		DRM_DEBUG_KMS("buffer size (%zu) too small for AFBC buffer size =3D %u=
\n",
> -			      objs->size, afbc_size);
> +	if (!drm_afbc_check_fb_size(dev, mode_cmd, objs, bpp)) {
>  		drm_gem_object_put_unlocked(objs);
>  		return false;
>  	}
Also can you do the code refactoring for komeda driver as well.
specifically komeda_fb_afbc_size_check(). I will let
james.qian.wang@arm.com and Mihail.Atanassov@arm.com have their
opinion on this.

> diff --git a/drivers/gpu/drm/drm_afbc.c b/drivers/gpu/drm/drm_afbc.c
> new file mode 100644
> index 000000000000..3e8a9225fd2e
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_afbc.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) 2019 Collabora Ltd.
> + *
> + * author: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> + *
> + */
> +#include <linux/module.h>
> +
> +#include <drm/drm_afbc.h>
> +#include <drm/drm_device.h>
> +#include <drm/drm_fourcc.h>
> +#include <drm/drm_gem.h>
> +#include <drm/drm_mode.h>
> +#include <drm/drm_print.h>
> +
> +#define AFBC_HEADER_SIZE		16
> +#define AFBC_SUPERBLK_ALIGNMENT		128
> +
> +bool drm_afbc_check_offset(struct drm_device *dev,
> +			   const struct drm_mode_fb_cmd2 *mode_cmd)
> +{
> +	if (mode_cmd->offsets[0] !=3D 0) {
> +		DRM_DEBUG_KMS("AFBC buffers' plane offset should be 0\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(drm_afbc_check_offset);
> +
> +bool drm_afbc_check_size_align(struct drm_device *dev,
> +			       const struct drm_mode_fb_cmd2 *mode_cmd)
> +{
> +
> +	switch (mode_cmd->modifier[0] & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK) {
> +	case AFBC_FORMAT_MOD_BLOCK_SIZE_16x16:
> +		if ((mode_cmd->width % 16) || (mode_cmd->height % 16)) {
> +			DRM_DEBUG_KMS(
> +				"AFBC buffer must be aligned to 16 pixels\n"
> +			);
> +			return false;
> +		}
> +		break;
> +	case AFBC_FORMAT_MOD_BLOCK_SIZE_32x8:
> +		/* fall through */
> +	case AFBC_FORMAT_MOD_BLOCK_SIZE_64x4:
> +		/* fall through */
> +	case AFBC_FORMAT_MOD_BLOCK_SIZE_32x8_64x4:
> +		/* fall through */
> +	default:
> +		DRM_DEBUG_KMS("Unsupported AFBC block size\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(drm_afbc_check_size_align);
> +
> +bool drm_afbc_check_fb_size(struct drm_device *dev,
> +			    const struct drm_mode_fb_cmd2 *mode_cmd,
> +			    struct drm_gem_object *objs, int bpp)
> +{
> +	int n_superblocks =3D 0;
> +	u32 afbc_superblock_size =3D 0, afbc_superblock_height =3D 0;
> +	u32 afbc_superblock_width =3D 0, afbc_size =3D 0;
> +
> +	switch (mode_cmd->modifier[0] & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK) {
> +	case AFBC_FORMAT_MOD_BLOCK_SIZE_16x16:
> +		afbc_superblock_height =3D 16;
> +		afbc_superblock_width =3D 16;
> +		break;
> +	case AFBC_FORMAT_MOD_BLOCK_SIZE_32x8:
Copying from
https://cgit.freedesktop.org/drm/drm-tip/tree/drivers/gpu/drm/arm/display/k=
omeda/komeda_framebuffer.c#n60
                afbc_superblock_width =3D 32;
                afbc_superblock_height =3D 8;
> +		/* fall through */
> +	case AFBC_FORMAT_MOD_BLOCK_SIZE_64x4:
> +		/* fall through */
> +	case AFBC_FORMAT_MOD_BLOCK_SIZE_32x8_64x4:
> +		/* fall through */
> +	default:
> +		DRM_DEBUG_KMS("AFBC superblock size is not supported\n");
> +		return false;
> +	}
Can you combine the two switch - case confitions (from this function
and the one in drm_afbc_check_size_align()) and put it in a separate
function (say drm_afbc_get_superblock_dimensions()) of its own ?
This will help to avoid code repetition.

> +
> +	n_superblocks =3D (mode_cmd->width / afbc_superblock_width) *
> +		(mode_cmd->height / afbc_superblock_height);
> +
> +	afbc_superblock_size =3D
> +		(bpp * afbc_superblock_width * afbc_superblock_height)
> +			/ BITS_PER_BYTE;
> +
> +	afbc_size =3D ALIGN(n_superblocks * AFBC_HEADER_SIZE,
> +			  AFBC_SUPERBLK_ALIGNMENT);
> +	afbc_size +=3D n_superblocks *
> +		ALIGN(afbc_superblock_size, AFBC_SUPERBLK_ALIGNMENT);
> +
> +	if ((mode_cmd->width * bpp) !=3D (mode_cmd->pitches[0] * BITS_PER_BYTE)=
) {
> +		DRM_DEBUG_KMS("Invalid value of (pitch * BITS_PER_BYTE) (=3D%u) should=
 be same as width (=3D%u) * bpp (=3D%u)\n",
> +			mode_cmd->pitches[0] * BITS_PER_BYTE,
> +			mode_cmd->width, bpp
> +		);
> +		return false;
> +	}
> +
> +	if (objs->size < afbc_size) {
> +		DRM_DEBUG_KMS("buffer size (%zu) too small for AFBC buffer size =3D %u=
\n",
> +			objs->size, afbc_size
> +		);
> +
> +		return false;
> +	}
> +
> +	return true;
> +}
> +EXPORT_SYMBOL(drm_afbc_check_fb_size);
> diff --git a/include/drm/drm_afbc.h b/include/drm/drm_afbc.h
> new file mode 100644
> index 000000000000..ce39c850217b
> --- /dev/null
> +++ b/include/drm/drm_afbc.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * (C) 2019 Collabora Ltd.
> + *
> + * author: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> + *
> + */
> +#ifndef __DRM_AFBC_H__
> +#define __DRM_AFBC_H__
> +
> +struct drm_device;
> +struct drm_mode_fb_cmd2;
> +struct drm_gem_object;
> +
> +bool drm_afbc_check_offset(struct drm_device *dev,
> +			   const struct drm_mode_fb_cmd2 *mode_cmd);
> +
> +bool drm_afbc_check_size_align(struct drm_device *dev,
> +			       const struct drm_mode_fb_cmd2 *mode_cmd);
> +
> +bool drm_afbc_check_fb_size(struct drm_device *dev,
> +			    const struct drm_mode_fb_cmd2 *mode_cmd,
> +			    struct drm_gem_object *objs, int bpp);
> +
> +#endif /* __DRM_AFBC_H__ */
> --
> 2.17.1
>=20
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
