Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121CFC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD05E20842
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="B6P+/3QU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389225AbfJAOnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:43:20 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:11872 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727083AbfJAOnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:43:19 -0400
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x91Ee3Nu022902;
        Tue, 1 Oct 2019 10:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=uG3gCt0GACwoQj/YW+nHfdm0eFe8Az6uRYqs2X8dCvw=;
 b=B6P+/3QUK6Zwzy4bj1n190CSwrJC/CGWUIe6uIPSJj40C6iqJuzkye5Y4KiXz9IRWo3J
 iBoq5EfNhq+zHH89RGCU2L5VFI7kADVPSkDnS7QQix+Vp75oJdz2x0wSZA6eHwS5XP5x
 hT+ICR4bHQDG6jPNPjtePxeOJUEW1KiJ7kpIQsQLfidub4mZrSlhJOmoKdZZ6bLVLWBA
 lDvoJ45KziGz1clgpSOj8ZPsOV8253ltkj3D7WcDOxR7h5YFCuBhqMUWRT+EBAI27H09
 Bgo2E/Qr70NNzQ61T+EhZtto86Fq1+beOVs65NApVoQU9ggf/Ne9IhHkCHAWIix53mpe 4A== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2va2nynw4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Oct 2019 10:43:18 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x91EbqAE193826;
        Tue, 1 Oct 2019 10:43:17 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0a-00154901.pphosted.com with ESMTP id 2vc2rup0a0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 10:43:17 -0400
X-LoopCount0: from 10.166.132.134
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="429771745"
From:   <Mario.Limonciello@dell.com>
To:     <mika.westerberg@linux.intel.com>, <linux-usb@vger.kernel.org>
CC:     <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
        <YehezkelShB@gmail.com>, <rajmohan.mani@intel.com>,
        <nicholas.johnson-opensource@outlook.com.au>, <lukas@wunner.de>,
        <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
        <anthony.wong@canonical.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 22/22] thunderbolt: Do not start firmware unless asked
 by the user
Thread-Topic: [RFC PATCH 22/22] thunderbolt: Do not start firmware unless
 asked by the user
Thread-Index: AQHVeEzP00v40G7xFkaR9Ok+Xa9iBadF18vQ
Date:   Tue, 1 Oct 2019 14:43:15 +0000
Message-ID: <10cccc5a8d1a43fd9769ab6c4b53aeba@AUSX13MPC105.AMER.DELL.COM>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-23-mika.westerberg@linux.intel.com>
In-Reply-To: <20191001113830.13028-23-mika.westerberg@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-10-01T14:43:12.4612150Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-01_07:2019-10-01,2019-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910010132
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 bulkscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910010132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> Sent: Tuesday, October 1, 2019 6:39 AM
> To: linux-usb@vger.kernel.org
> Cc: Andreas Noever; Michael Jamet; Mika Westerberg; Yehezkel Bernat; Rajm=
ohan
> Mani; Nicholas Johnson; Lukas Wunner; Greg Kroah-Hartman; Alan Stern;
> Limonciello, Mario; Anthony Wong; linux-kernel@vger.kernel.org
> Subject: [RFC PATCH 22/22] thunderbolt: Do not start firmware unless aske=
d by the
> user
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> Since now we can do pretty much the same thing in the software
> connection manager than the firmware would do, there is no point
> starting it by default. Instead we can just continue using the software
> connection manager.
>=20
> Make it possible for user to switch between the two by adding a module
> pararameter (start_icm) which is by default false. Having this ability
> to enable the firmware may be useful at least when debugging possible
> issues with the software connection manager implementation.

If the host system firmware didn't start the ICM, does that mean SW connect=
ion
manager would just take over even on systems with discrete AR/TR controller=
s?

>=20
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/thunderbolt/icm.c | 14 +++++++++++---
>  drivers/thunderbolt/tb.c  |  4 ----
>  2 files changed, 11 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
> index 9c9c6ea2b790..c4a2de0f2a44 100644
> --- a/drivers/thunderbolt/icm.c
> +++ b/drivers/thunderbolt/icm.c
> @@ -11,6 +11,7 @@
>=20
>  #include <linux/delay.h>
>  #include <linux/mutex.h>
> +#include <linux/moduleparam.h>
>  #include <linux/pci.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/platform_data/x86/apple.h>
> @@ -43,6 +44,10 @@
>  #define ICM_APPROVE_TIMEOUT		10000	/* ms */
>  #define ICM_MAX_LINK			4
>=20
> +static bool start_icm;
> +module_param(start_icm, bool, 0444);
> +MODULE_PARM_DESC(start_icm, "start ICM firmware if it is not running (de=
fault:
> false)");
> +
>  /**
>   * struct icm - Internal connection manager private data
>   * @request_lock: Makes sure only one message is send to ICM at time
> @@ -1353,13 +1358,16 @@ static bool icm_ar_is_supported(struct tb *tb)
>  {
>  	struct pci_dev *upstream_port;
>  	struct icm *icm =3D tb_priv(tb);
> +	u32 val;
>=20
>  	/*
>  	 * Starting from Alpine Ridge we can use ICM on Apple machines
>  	 * as well. We just need to reset and re-enable it first.

This comment doesn't really seem as relevant anymore.  The meaning of it
has nothing to do with Apple anymore.

> +	 * However, only start it if explicitly asked by the user.
>  	 */
> -	if (!x86_apple_machine)
> -		return true;
> +	val =3D ioread32(tb->nhi->iobase + REG_FW_STS);
> +	if (!(val & REG_FW_STS_ICM_EN) && !start_icm)
> +		return false;

This code is already in icm_firmware_start.  Maybe split it to a small func=
tion
So you can just have the more readable

If (!icm_firmware_running(tb) && !start_icm))

>=20
>  	/*
>  	 * Find the upstream PCIe port in case we need to do reset
> @@ -2224,7 +2232,7 @@ struct tb *icm_probe(struct tb_nhi *nhi)
>=20
>  	case PCI_DEVICE_ID_INTEL_ICL_NHI0:
>  	case PCI_DEVICE_ID_INTEL_ICL_NHI1:
> -		icm->is_supported =3D icm_ar_is_supported;
> +		icm->is_supported =3D icm_fr_is_supported;
>  		icm->driver_ready =3D icm_icl_driver_ready;
>  		icm->set_uuid =3D icm_icl_set_uuid;
>  		icm->device_connected =3D icm_icl_device_connected;
> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index 6c468ba96e9a..aebf2c10aa85 100644
> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c
> @@ -9,7 +9,6 @@
>  #include <linux/slab.h>
>  #include <linux/errno.h>
>  #include <linux/delay.h>
> -#include <linux/platform_data/x86/apple.h>
>=20
>  #include "tb.h"
>  #include "tb_regs.h"
> @@ -1117,9 +1116,6 @@ struct tb *tb_probe(struct tb_nhi *nhi)
>  	struct tb_cm *tcm;
>  	struct tb *tb;
>=20
> -	if (!x86_apple_machine)
> -		return NULL;
> -
>  	tb =3D tb_domain_alloc(nhi, sizeof(*tcm));
>  	if (!tb)
>  		return NULL;
> --
> 2.23.0

