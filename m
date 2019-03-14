Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580E5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7672186A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="bLY+EcJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfCNRNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 13:13:22 -0400
Received: from mail-eopbgr50063.outbound.protection.outlook.com ([40.107.5.63]:52997
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726157AbfCNRNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 13:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpvkAOzmuDBPxzk0BHDCU2/nver6Vq/utq6GU+160u8=;
 b=bLY+EcJk6BmJ07Ss2+etN3DueuJ1WT/J4q7x/vAJOZE58YWJaJI+khm6n1fsEvdbuwzIK1MvHRAdp4V6YSEqrZ3BHXywMaXOAmNpdb0g14qoYj3SwvgpY/mVlmqS4hEVhpOlPkcBXbFHESLbai/O70scxbTUhZx5htO/WjTrlQc=
Received: from DB6PR0501MB2709.eurprd05.prod.outlook.com (10.172.226.16) by
 DB6PR0501MB2824.eurprd05.prod.outlook.com (10.172.226.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.21; Thu, 14 Mar 2019 17:13:09 +0000
Received: from DB6PR0501MB2709.eurprd05.prod.outlook.com
 ([fe80::e595:dbdf:132d:3ef7]) by DB6PR0501MB2709.eurprd05.prod.outlook.com
 ([fe80::e595:dbdf:132d:3ef7%7]) with mapi id 15.20.1709.011; Thu, 14 Mar 2019
 17:13:09 +0000
From:   Junhan Zhou <Junhan@mellanox.com>
To:     Junhan Zhou <Junhan@mellanox.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Liming Sun <lsun@mellanox.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] EDAC, mellanox: Add ECC support for BlueField DDR4
Thread-Topic: [PATCH v1 1/1] EDAC, mellanox: Add ECC support for BlueField
 DDR4
Thread-Index: AQHUzhufLnpn0YmSqUG23Fj2fS8i96X0F/MAgBddpaA=
Date:   Thu, 14 Mar 2019 17:13:09 +0000
Message-ID: <DB6PR0501MB2709EE477B6CBB525EF2C911B34B0@DB6PR0501MB2709.eurprd05.prod.outlook.com>
References: <e59276b6f3dc165703ddcb47a8a006d8a62d9c95.1551216637.git.Junhan@mellanox.com>
 <1551298916-4981-1-git-send-email-Junhan@mellanox.com>
In-Reply-To: <1551298916-4981-1-git-send-email-Junhan@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Junhan@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94f049a8-8696-4c7c-d053-08d6a8a05539
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0501MB2824;
x-ms-traffictypediagnostic: DB6PR0501MB2824:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DB6PR0501MB2824;23:CEL4zQak+bTRKDPsNuUENXqsP70uXacUf5p4YQa?=
 =?us-ascii?Q?nNXn0BIsXCClVvTOp9EY8Bux3uiuRphPfUPM26V1gcgd3lSuzvTWf1z0cfw0?=
 =?us-ascii?Q?ofxFVQkar7Lf9Na2T5QHr7SBlCzHv2Jttgt8gzH6sSB36awx9ioc6p6hhGzA?=
 =?us-ascii?Q?RGnu6LsoZ++Mbi2NFnOoMcl5YIuhkVf+B0tSAgAczFNK6siqMz8ljdO6XmjR?=
 =?us-ascii?Q?gAWbUPqDSN2HSuUvkuPxCxUNuP/yPE2qeEJnFKvF9pa3ppwADIdAjMiQeWab?=
 =?us-ascii?Q?ShG4Ty3wlke6JvttAeJCygArRdbhoYXSuw8/8XfoERMzBivaT01gtluryubN?=
 =?us-ascii?Q?OVG7rphO3ucAtE/HIj8rR+n00j2Gkr9nFKbgBj+paWVfE+ORZR7/IuwNXe8G?=
 =?us-ascii?Q?Oc/4TSDUQGAmDzKHeuGsqp58K6qGzm4JQcEaXJgiX/KLbkSXFB+qkgMoV2Oe?=
 =?us-ascii?Q?AM0C7GS/gN9+b+JZSo0dl3zNcJaKnsJDIUKPGIOa8tT8kWrCNmur28+6WaSa?=
 =?us-ascii?Q?Bidx9PtoCJNLNlyRhAR8pTeYFx76kxRIZ4vpDnKjTIdBAiEip2tdR3E23geu?=
 =?us-ascii?Q?X4pM29Y5kBDmaa8Npn6RbbEz5qjhKJ0go1tYWGq7M/5IfrabeAgwG4JJXAdM?=
 =?us-ascii?Q?r2qpS+2/++aiPFLAz4LF4V2whFgfif59382ZGEmq8+wZFDblnQQbYN/zmK9C?=
 =?us-ascii?Q?gu95dsnnxnXGYliRR3XfzAFOwvh+tjDzjHwfM/2IdIkqloOgOxtVVKOXWzxb?=
 =?us-ascii?Q?w2nZMZMpVhkU9j5fR+aJQblXWvt9UQ/kyyiQkTS1MjPrFhI65IXyp7fV4TyO?=
 =?us-ascii?Q?vnDpK/nk81pPH313KDvX6vKDCyEeJl1IJ7p1+eZpJkQuzUGGXepzo9wnMwp9?=
 =?us-ascii?Q?wQS47MttplESZjw4anPL7wOM4ylK9+cbXWbt75i0HvtpgkdjfV4V4wA8b/z+?=
 =?us-ascii?Q?7Bf6Hux9wtm7KAuRxo5MhjpM2S4WIsnmlaZBwm2tiOQ8l1yfA5pM7mN10MgR?=
 =?us-ascii?Q?dHY3jiZUR7PZXfDzTnXiRQDHl3OKKBplvjBCS52ygEOEqa5TjuQCsQOP9w/2?=
 =?us-ascii?Q?x8flT+YT5JaqeAzDhgHVK8W3eRFpIFQP1yXGaD3HX3XZPWZB/k7VkdzwHiO7?=
 =?us-ascii?Q?z53xLudl5k2cVBNoAr6gUwj2G9pPivJ8XfRsqOkhO/F2mtaJAKS54tbUcE2k?=
 =?us-ascii?Q?Y0NYCigK8D5ndFy+rxt3mTf53dhIEg6MeXBBphKaft3LWKQO/1gDkkHgDhLW?=
 =?us-ascii?Q?ish9a5HnpRGWjZ39yElPga9S0I33wNWvG7w3nbPVfTkYypYhmQLfrPCWxYeH?=
 =?us-ascii?Q?91qXcaV10DDpAWRbhTMsf5CPmXXNKKGKCgIWlsK7BLqzy?=
x-microsoft-antispam-prvs: <DB6PR0501MB2824CC22AD8CAEB2697937C6B34B0@DB6PR0501MB2824.eurprd05.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(346002)(366004)(189003)(199004)(13464003)(102836004)(74316002)(86362001)(8936002)(476003)(8676002)(9686003)(6246003)(66066001)(305945005)(7736002)(55016002)(30864003)(186003)(446003)(11346002)(26005)(81156014)(105586002)(106356001)(33656002)(486006)(52536014)(14454004)(54906003)(110136005)(99286004)(316002)(6436002)(229853002)(3846002)(478600001)(5660300002)(6116002)(2906002)(81166006)(80792005)(4326008)(7696005)(25786009)(72206003)(6506007)(71200400001)(68736007)(256004)(53936002)(76176011)(71190400001)(14444005)(97736004)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2824;H:DB6PR0501MB2709.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6g3cRjJ4Lmb9DSF5r2iIg7W58/A5x7izhjfYy2kgd9J+ZW2ryM/rlPrAbJV2BKRTsgnYtO4/ddZfmIGLlwNSC+37yWbyQ3qvafFl2/GsMvb+wRQqywxQ+5V0rfWVjXDGicrLtTuEuQmy2/M7OsLpo5ErjxNxJquGz29/UrupKBZ4dhldc5x0oPFySpib4Ro8xNBiP3edwL55Fx/4b7M99zb4STX/i9OI5z7qbOtYzVtnM3HuwNWfALP7F5gbF9TPF13s+dbk6BK3Or0xbObo9NeLrMCH1GK/hYwoiXOomL8dIimGldPbOpmAD4BFMQDgOMCRTMODCRboOjugACMrcQR8mt/HrVJmRSrTb8cumBKCvRLzcvvgQaVghysLd06CRRBCZgJyzLS4eGTZbFxYUQShHURtKbRTq6EC/DPY5Bg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f049a8-8696-4c7c-d053-08d6a8a05539
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 17:13:09.5778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, any comments on this patch?
I'm trying to add EDAC support for our BlueField platform memory controller=
.

> -----Original Message-----
> From: linux-edac-owner@vger.kernel.org <linux-edac-
> owner@vger.kernel.org> On Behalf Of Junhan Zhou
> Sent: Wednesday, February 27, 2019 3:22 PM
> To: Borislav Petkov <bp@alien8.de>; Mauro Carvalho Chehab
> <mchehab@kernel.org>
> Cc: Junhan Zhou <Junhan@mellanox.com>; Liming Sun
> <lsun@mellanox.com>; linux-edac@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH v1 1/1] EDAC, mellanox: Add ECC support for BlueField DDR=
4
>=20
> Add ECC support for Mellanox BlueField SoC DDR controller.
> This requires SMC to the running Arm Trusted Firmware to report what is t=
he
> current memory configuration.
>=20
> Signed-off-by: Junhan Zhou <Junhan@mellanox.com>
> ---
>  drivers/edac/Kconfig          |   7 +
>  drivers/edac/Makefile         |   1 +
>  drivers/edac/bluefield_edac.c | 425
> ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 433 insertions(+)
>  create mode 100644 drivers/edac/bluefield_edac.c
>=20
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig index
> e286b5b..3bcb8fe 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -475,4 +475,11 @@ config EDAC_QCOM
>  	  For debugging issues having to do with stability and overall system
>  	  health, you should probably say 'Y' here.
>=20
> +config EDAC_BLUEFIELD
> +	tristate "Mellanox BlueField Memory ECC"
> +	depends on (MELLANOX_PLATFORM && ARM64 && ACPI) ||
> COMPILE_TEST
> +	help
> +	  Support for error detection and correction on the
> +	  Mellanox BlueField SoCs.
> +
>  endif # EDAC
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile index
> 716096d..6dd5e67 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -78,3 +78,4 @@ obj-$(CONFIG_EDAC_SYNOPSYS)		+=3D
> synopsys_edac.o
>  obj-$(CONFIG_EDAC_XGENE)		+=3D xgene_edac.o
>  obj-$(CONFIG_EDAC_TI)			+=3D ti_edac.o
>  obj-$(CONFIG_EDAC_QCOM)			+=3D qcom_edac.o
> +obj-$(CONFIG_EDAC_BLUEFIELD)		+=3D bluefield_edac.o
> diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.=
c
> new file mode 100644 index 0000000..bdcf0cc
> --- /dev/null
> +++ b/drivers/edac/bluefield_edac.c
> @@ -0,0 +1,425 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Bluefield-specific EDAC driver.
> + *
> + * Copyright (c) 2019 Mellanox Technologies.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/arm-smccc.h>
> +#include <linux/edac.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include "edac_module.h"
> +
> +#define DRIVER_NAME		"bluefield-edac"
> +
> +/*
> + * Mellanox BlueField EMI (External Memory Interface) register definitio=
ns.
> + * Registers which have individual bitfields have a union defining the
> + * bitfields following the address define.
> + */
> +
> +#define MLXBF_EMI_DRAM_ECC_COUNT 0x340
> +
> +union MLXBF_EMI_DRAM_ECC_COUNT_u {
> +	struct {
> +		/* ECC single errors counter */
> +		u32 single_error_count : 16;
> +		/* ECC double errors counter */
> +		u32 double_error_count : 16;
> +	};
> +
> +	u32 word;
> +};
> +
> +#define MLXBF_EMI_DRAM_ECC_ERROR 0x348
> +
> +union MLXBF_EMI_DRAM_ECC_ERROR_u {
> +	struct {
> +		/* 1 - ECC single error from DRAM wrapper x. */
> +		u32 dram_ecc_single : 1;
> +		/* Reserved. */
> +		u32 __reserved_0    : 15;
> +		/* 1 - ECC double error from DRAM wrapper x. */
> +		u32 dram_ecc_double : 1;
> +		/* Reserved. */
> +		u32 __reserved_1    : 15;
> +	};
> +
> +	u32 word;
> +};
> +
> +#define MLXBF_EMI_DRAM_ECC_LATCH_SELECT 0x354
> +
> +union MLXBF_EMI_DRAM_ECC_LATCH_SELECT_u {
> +	struct {
> +		/*
> +		 * For DRAM wrapper x.
> +		 *
> +		 * 0 - Last ECC error will be stored.
> +		 *
> +		 * 1 - First ECC error will be stored.
> +		 */
> +		u32 dram_ecc_first : 1;
> +		/* Reserved. */
> +		u32 __reserved_0   : 15;
> +		/* Selects to Edge (one of 8) to get the ECC info. */
> +		u32 edge_sel       : 4;
> +		/* Reserved. */
> +		u32 __reserved_1   : 4;
> +		/* 1 - Start select DRAM_INFO */
> +		u32 start          : 1;
> +		/* Reserved. */
> +		u32 __reserved_2   : 7;
> +	};
> +
> +	u32 word;
> +};
> +
> +#define MLXBF_EMI_DRAM_ERR_ADDR_0 0x358
> +
> +#define MLXBF_EMI_DRAM_ERR_ADDR_1 0x37c
> +
> +#define MLXBF_EMI_DRAM_SYNDROM 0x35c
> +
> +union MLXBF_EMI_DRAM_SYNDROM_u {
> +	struct {
> +		/* 1 - Double error. */
> +		u32 derr         : 1;
> +		/* 1 - Single error. */
> +		u32 serr         : 1;
> +		/* Reserved. */
> +		u32 __reserved_0 : 14;
> +		/* ECC syndrome (error bit according to the Hamming code).
> */
> +		u32 syndrom      : 10;
> +		/* Reserved. */
> +		u32 __reserved_1 : 6;
> +	};
> +
> +	u32 word;
> +};
> +
> +#define MLXBF_EMI_DRAM_ADDITIONAL_INFO_0 0x364
> +
> +union MLXBF_EMI_DRAM_ADDITIONAL_INFO_0_u {
> +	struct {
> +		/* Physical Error Bank. */
> +		u32 err_bank     : 4;
> +		/* Physical Error Logical Rank. */
> +		u32 err_lrank    : 2;
> +		/* Reserved. */
> +		u32 __reserved_0 : 2;
> +		/* Physical Error Physical Rank. */
> +		u32 err_prank    : 2;
> +		/* Reserved. */
> +		u32 __reserved_1 : 6;
> +		/* Error Edge Bitmap. */
> +		u32 err_edge     : 8;
> +		/* Reserved. */
> +		u32 __reserved_2 : 8;
> +	};
> +
> +	u32 word;
> +};
> +
> +#define MLXBF_EDAC_DIMM_PER_MC		2
> +#define MLXBF_EDAC_ERROR_GRAIN		8
> +
> +/*
> + * Request MLNX_SIP_GET_DIMM_INFO
> + *
> + * Retrieve information about DIMM on a certaion slot.
> + *
> + * Call register usage:
> + * a0: MLNX_SIP_GET_DIMM_INFO
> + * a1: (Memory controller index) << 16 | (Dimm index in memory
> +controller)
> + * a2-7: not used.
> + *
> + * Return status:
> + * a0: dimm_info_smc union defined below describing the DIMM.
> + * a1-3: not used.
> + */
> +#define MLNX_SIP_GET_DIMM_INFO		0x82000008
> +
> +/* Format for the SMC response about the memory information */ union
> +dimm_info_smc {
> +	struct {
> +		unsigned long size_GB : 16;	/* Dimm size in GB */
> +		unsigned long is_rdimm : 1;	/* If is RDIMM/LRDIMM */
> +		unsigned long is_lrdimm : 1;	/* If is LRDIMM */
> +		unsigned long is_nvdimm : 1;	/* If is NVDIMM */
> +		unsigned long __reserved0 : 2;
> +		unsigned long ranks : 3;	/* Rank num of DIMM */
> +		unsigned long package_X : 8;	/* Bits per memory package
> */
> +		unsigned long __reserved1 : 32;
> +	};
> +	unsigned long val;
> +};
> +
> +struct bluefield_edac_priv {
> +	int dimm_ranks[MLXBF_EDAC_DIMM_PER_MC]; /* How many ranks
> in dimm */
> +	void __iomem *emi_base;
> +};
> +
> +static unsigned long smc_call1(unsigned long smc_op, unsigned long
> +smc_arg) {
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(smc_op, smc_arg, 0, 0, 0, 0, 0, 0, &res);
> +
> +	return res.a0;
> +}
> +
> +/*
> + * Gather the ECC information from the External Memory Interface
> +registers
> + * and report it to the edac handler.
> + */
> +static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
> +					int error_cnt,
> +					int is_single_ecc)
> +{
> +	struct bluefield_edac_priv *priv =3D mci->pvt_info;
> +	union MLXBF_EMI_DRAM_ADDITIONAL_INFO_0_u edai0;
> +	union MLXBF_EMI_DRAM_ECC_LATCH_SELECT_u edels;
> +	union MLXBF_EMI_DRAM_SYNDROM_u eds;
> +	enum hw_event_mc_err_type ecc_type;
> +	unsigned long ecc_dimm_addr;
> +	int ecc_dimm;
> +	u32 edea0;
> +	u32 edea1;
> +
> +	ecc_type =3D is_single_ecc ? HW_EVENT_ERR_CORRECTED :
> +				   HW_EVENT_ERR_UNCORRECTED;
> +
> +	/*
> +	 * Tell the External Memory Interface to populate the relavent
> +	 * registers with information about the last ECC error occurrence.
> +	 */
> +	edels.word =3D 0;
> +	edels.start =3D 1;
> +	writel(edels.word, priv->emi_base +
> MLXBF_EMI_DRAM_ECC_LATCH_SELECT);
> +
> +	/*
> +	 * Verify that the ECC reported info in the registers is of the
> +	 * same type as the one asked to report. If not, just report the
> +	 * error without the detailed information.
> +	 */
> +	eds.word =3D readl(priv->emi_base + MLXBF_EMI_DRAM_SYNDROM);
> +
> +	if ((is_single_ecc && !eds.serr) || (!is_single_ecc && !eds.derr)) {
> +		edac_mc_handle_error(ecc_type, mci, error_cnt, 0, 0, 0,
> +				     0, 0, -1, mci->ctl_name, "");
> +		return;
> +	}
> +
> +	edai0.word =3D readl(priv->emi_base +
> MLXBF_EMI_DRAM_ADDITIONAL_INFO_0);
> +
> +	ecc_dimm =3D edai0.err_prank >=3D 2 && priv->dimm_ranks[0] <=3D 2;
> +
> +	edea0 =3D readl(priv->emi_base + MLXBF_EMI_DRAM_ERR_ADDR_0);
> +	edea1 =3D readl(priv->emi_base + MLXBF_EMI_DRAM_ERR_ADDR_1);
> +
> +	ecc_dimm_addr =3D ((unsigned long)edea1 << 32) | edea0;
> +
> +	edac_mc_handle_error(ecc_type, mci, error_cnt,
> +			     ecc_dimm_addr / 0x1000, ecc_dimm_addr & 0xfff,
> +			     eds.syndrom, ecc_dimm, 0, 0, mci->ctl_name, "");
> }
> +
> +static void bluefield_edac_check(struct mem_ctl_info *mci) {
> +	union MLXBF_EMI_DRAM_ECC_ERROR_u edee =3D { .word =3D 0 };
> +	struct bluefield_edac_priv *priv =3D mci->pvt_info;
> +	union MLXBF_EMI_DRAM_ECC_COUNT_u edec;
> +
> +	/*
> +	 * The memory controller might not be initialized by the firmware
> +	 * when there isn't memory, which may lead to bad register readings.
> +	 */
> +	if (mci->edac_cap =3D=3D EDAC_FLAG_NONE)
> +		return;
> +
> +	edec.word =3D readl(priv->emi_base +
> MLXBF_EMI_DRAM_ECC_COUNT);
> +
> +	if (edec.single_error_count !=3D 0) {
> +		edee.dram_ecc_single =3D 1;
> +
> +		bluefield_gather_report_ecc(mci, edec.single_error_count,
> 1);
> +	}
> +
> +	if (edec.double_error_count !=3D 0) {
> +		edee.dram_ecc_double =3D 1;
> +
> +		bluefield_gather_report_ecc(mci, edec.double_error_count,
> 0);
> +	}
> +
> +	/* Write to clear reported errors. */
> +	if (edec.word !=3D 0)
> +		writel(edee.word, priv->emi_base +
> MLXBF_EMI_DRAM_ECC_ERROR); }
> +
> +/* Initialize the DIMMs information for the given memory controller. */
> +static void bluefield_edac_init_dimms(struct mem_ctl_info *mci) {
> +	struct bluefield_edac_priv *priv =3D mci->pvt_info;
> +	int mem_ctrl_idx =3D mci->mc_idx;
> +	union dimm_info_smc smc_info;
> +	struct dimm_info *dimm;
> +	unsigned long smc_arg;
> +	int is_empty =3D 1;
> +	int i;
> +
> +	for (i =3D 0; i < MLXBF_EDAC_DIMM_PER_MC; i++) {
> +		dimm =3D mci->dimms[i];
> +
> +		smc_arg =3D mem_ctrl_idx << 16 | i;
> +		smc_info =3D (union dimm_info_smc) {
> +			.val =3D smc_call1(MLNX_SIP_GET_DIMM_INFO,
> smc_arg),
> +		};
> +
> +		if (smc_info.size_GB =3D=3D 0) {
> +			dimm->mtype =3D MEM_EMPTY;
> +			continue;
> +		}
> +
> +		is_empty =3D 0;
> +
> +		dimm->edac_mode =3D EDAC_SECDED;
> +
> +		if (smc_info.is_nvdimm)
> +			dimm->mtype =3D MEM_NVDIMM;
> +		else if (smc_info.is_lrdimm)
> +			dimm->mtype =3D MEM_LRDDR4;
> +		else if (smc_info.is_rdimm)
> +			dimm->mtype =3D MEM_RDDR4;
> +		else
> +			dimm->mtype =3D MEM_DDR4;
> +
> +		dimm->nr_pages =3D smc_info.size_GB * 256 * 1024;
> +		dimm->grain =3D MLXBF_EDAC_ERROR_GRAIN;
> +
> +		/* Mem controller for BlueField only supports x4, x8 and x16
> */
> +		if (smc_info.package_X =3D=3D 4)
> +			dimm->dtype =3D DEV_X4;
> +		else if (smc_info.package_X =3D=3D 8)
> +			dimm->dtype =3D DEV_X8;
> +		else if (smc_info.package_X =3D=3D 16)
> +			dimm->dtype =3D DEV_X16;
> +		else
> +			dimm->dtype =3D DEV_UNKNOWN;
> +
> +		priv->dimm_ranks[i] =3D smc_info.ranks;
> +	}
> +
> +	if (is_empty)
> +		mci->edac_cap =3D EDAC_FLAG_NONE;
> +	else
> +		mci->edac_cap =3D EDAC_FLAG_SECDED;
> +}
> +
> +static int bluefield_edac_mc_probe(struct platform_device *pdev) {
> +	struct bluefield_edac_priv *priv;
> +	struct device *dev =3D &pdev->dev;
> +	struct edac_mc_layer layers[1];
> +	struct mem_ctl_info *mci;
> +	struct resource *emi_res;
> +	unsigned int mc_idx;
> +	int rc, ret;
> +
> +	/* Only POLL mode supported so far. */
> +	edac_op_state =3D EDAC_OPSTATE_POLL;
> +
> +	/* Read the MSS (Memory SubSystem) index from ACPI table. */
> +	if (device_property_read_u32(dev, "mss_number", &mc_idx)) {
> +		dev_warn(dev, "bf_edac: MSS number unknown\n");
> +		return -EINVAL;
> +	}
> +
> +	emi_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!emi_res)
> +		return -EINVAL;
> +
> +	layers[0].type =3D EDAC_MC_LAYER_SLOT;
> +	layers[0].size =3D MLXBF_EDAC_DIMM_PER_MC;
> +	layers[0].is_virt_csrow =3D true;
> +
> +	mci =3D edac_mc_alloc(mc_idx, ARRAY_SIZE(layers), layers,
> sizeof(*priv));
> +	if (mci =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	priv =3D mci->pvt_info;
> +
> +	priv->emi_base =3D devm_ioremap_resource(dev, emi_res);
> +	if (IS_ERR(priv->emi_base)) {
> +		dev_err(dev, "failed to map EMI IO resource\n");
> +		ret =3D PTR_ERR(priv->emi_base);
> +		goto err;
> +	}
> +
> +	mci->pdev =3D dev;
> +	mci->mtype_cap =3D MEM_FLAG_DDR4 | MEM_FLAG_RDDR4 |
> +			 MEM_FLAG_LRDDR4 | MEM_FLAG_NVDIMM;
> +	mci->edac_ctl_cap =3D EDAC_FLAG_SECDED;
> +
> +	mci->mod_name =3D DRIVER_NAME;
> +	mci->ctl_name =3D "BlueField_Memory_Controller";
> +	mci->dev_name =3D dev_name(dev);
> +	mci->edac_check =3D bluefield_edac_check;
> +
> +	/* Initialize mci with the actual populated DIMM information. */
> +	bluefield_edac_init_dimms(mci);
> +
> +	platform_set_drvdata(pdev, mci);
> +
> +	/* Register with EDAC core */
> +	rc =3D edac_mc_add_mc(mci);
> +	if (rc) {
> +		dev_err(dev, "failed to register with EDAC core\n");
> +		ret =3D rc;
> +		goto err;
> +	}
> +
> +	return 0;
> +
> +err:
> +	edac_mc_free(mci);
> +
> +	return ret;
> +
> +}
> +
> +static int bluefield_edac_mc_remove(struct platform_device *pdev) {
> +	struct mem_ctl_info *mci =3D platform_get_drvdata(pdev);
> +
> +	edac_mc_del_mc(&pdev->dev);
> +	edac_mc_free(mci);
> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id bluefield_mc_acpi_ids[] =3D {
> +	{"MLNXBF08", 0},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(acpi, bluefield_mc_acpi_ids);
> +
> +static struct platform_driver bluefield_edac_mc_driver =3D {
> +	.driver =3D {
> +		.name =3D DRIVER_NAME,
> +		.acpi_match_table =3D bluefield_mc_acpi_ids,
> +	},
> +	.probe =3D bluefield_edac_mc_probe,
> +	.remove =3D bluefield_edac_mc_remove,
> +};
> +
> +module_platform_driver(bluefield_edac_mc_driver);
> +
> +MODULE_DESCRIPTION("Mellanox BlueField memory edac driver");
> +MODULE_AUTHOR("Mellanox Technologies"); MODULE_LICENSE("GPL v2");
> --
> 2.1.2

