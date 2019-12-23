Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACA4C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 13:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89FD206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 13:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="S9MDjxmH";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="i1AA2Gg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfLWNqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 08:46:18 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:7192 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726676AbfLWNqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 08:46:18 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBNDXodg018349;
        Mon, 23 Dec 2019 05:46:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=lSH7p09kHW4vctMm+S9pd+srxbw3VpWwoBPIRLizTSU=;
 b=S9MDjxmHB5eff+jqZhXTczng/p5lYTqZhgjyrC64FLFer7Pj9OE8OOz/PeN3hZZgMNWz
 kH8bbmDOeW9setKLVmDMvC3vKaHjp6M2tVJMnAgWTAGghjePPUbQD7RYo5bOC4s/Cyk1
 CfqQm+szaldIXxNR9wpc80E+8RarhfBdoJsHGXNN7b5h3ZqNTxtXWGgZH/TmCDyXcKG/
 lxdr5Bg/A6io0ZB45MhgBjBF+lclGsWoEHGezG18ktLjTKbfA6ku1iPf/k8HpOEVYDPO
 +LjFhmIxeLg7TJQgZ6+dwKMpzGyUpy/M5sGABZWvrbc5TXHTINSpvqrgbiA/7W3c6VtS tA== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2053.outbound.protection.outlook.com [104.47.44.53])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2x1gu4w3rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Dec 2019 05:46:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNaMtBv6YWOoeUzTiJN2U6z/vysfcRQE1Bs3nTkKrU/U1AIkC6gpS/Rus8BI4bWrqEeQowlZnUp3v1VwKcqXR7AF5fjjOXJkF4My1Ol0EUey2wTo8hdhRTs7/sXWxYxdVPkh0lxyTW8auuRUqqP/XkBId87ZK15D6gPmS5RWQ8C7Crc7yeAXUKgCNyo7Am2ylKt2NRUjr0GUW8fSzK7rIeCudFOrAxh3uWWTaBHmN9vBrLib+BqbTefH8orFkkOU5sEbqQpjygoF+8Pm2uTW2ZAsUZQYoqZ+gaDCmwXXd3SUpELMZv7rzuehypkSiUNjoW8SizYdgvqU89SfRSnAbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSH7p09kHW4vctMm+S9pd+srxbw3VpWwoBPIRLizTSU=;
 b=nsq8HamGuAn0MXaCah4PrKWDVtat2dPwblrvDlrAjU1JELFpUQXxWVZqNx0mi1LRafuORKtydqFBWSCpb1Z+Xp1C5D4i5myKIb57YZ5dNLwklfhHer5yPEZi/zH2sP4JjkNLeWnHMDDqqSyL9Rov5UmEtkJFqJDymzglEuWOBjJzk3SC+4Luob3ah4ZgQJ19KAa6xGa3Quvm5t7SJna0Kqfs379scfDFz8vGnhQPTCIq/slldJhbpMnxW4xXhlcmlhNMTpzMHH9ncYx7ruMo8sKY8pgH7hEBCMxCIWdFzfFSZucC8pGhjuOd4IMWzK4/Qlk/TM1AyTHLDuhaxwTjaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSH7p09kHW4vctMm+S9pd+srxbw3VpWwoBPIRLizTSU=;
 b=i1AA2Gg/TA66l2eclMhuTk95CHyrWnnQHqwLT/r1RsfQkWKTKCfZo0XA++GZysiU53iyX3ngzXRNYN5mBLicRsw0hyzi6BLUncyAe4kGiljjAOlJD55hKlr81EH1R304veISx16nRxtLKNni+eYA2sLDhuwr3xfbXIWOh/X4pvI=
Received: from BYAPR07MB5110.namprd07.prod.outlook.com (20.176.255.14) by
 BYAPR07MB6213.namprd07.prod.outlook.com (20.179.62.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Mon, 23 Dec 2019 13:46:06 +0000
Received: from BYAPR07MB5110.namprd07.prod.outlook.com
 ([fe80::e4c9:23b3:78c1:acdd]) by BYAPR07MB5110.namprd07.prod.outlook.com
 ([fe80::e4c9:23b3:78c1:acdd%6]) with mapi id 15.20.2559.017; Mon, 23 Dec 2019
 13:46:06 +0000
From:   Yuti Suresh Amonkar <yamonkar@cadence.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "maxime@cerno.tech" <maxime@cerno.tech>,
        "kishon@ti.com" <kishon@ti.com>
CC:     "praneeth@ti.com" <praneeth@ti.com>,
        "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>,
        "jsarha@ti.com" <jsarha@ti.com>, Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>
Subject: RE: [PATCH v2] phy: Add DisplayPort configuration options
Thread-Topic: [PATCH v2] phy: Add DisplayPort configuration options
Thread-Index: AQHVuZarlyuLHgdLs0ymbXdtACZzt6fHuuug
Date:   Mon, 23 Dec 2019 13:46:05 +0000
Message-ID: <BYAPR07MB511039939973065EA4D7D85AD22E0@BYAPR07MB5110.namprd07.prod.outlook.com>
References: <1577108473-29294-1-git-send-email-yamonkar@cadence.com>
In-Reply-To: <1577108473-29294-1-git-send-email-yamonkar@cadence.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [14.143.9.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fbfda6b-414e-40e9-69bf-08d787ae7569
x-ms-traffictypediagnostic: BYAPR07MB6213:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB62134711F640AD37D1A440F8D22E0@BYAPR07MB6213.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0260457E99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(36092001)(189003)(199004)(13464003)(966005)(52536014)(26005)(64756008)(9686003)(186003)(66946007)(66446008)(33656002)(66476007)(66556008)(76116006)(55016002)(110136005)(81156014)(54906003)(81166006)(53546011)(6506007)(5660300002)(316002)(4326008)(8676002)(2906002)(7696005)(55236004)(8936002)(86362001)(71200400001)(478600001)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB6213;H:BYAPR07MB5110.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4mAi3tQCAAjFrf0Oxo9TLXD3pvP1PN52FKGhgXvo6E2jnDmH3howLQEA74ATXtZxfGzK6IwxOjX2xFDhmRnNa7kjeLruS+P7HmzynJberrXoevJGXNwei2KLJGxQmX1rETBncR5ksbL6CtVoa3AwWkAb1Tk7TnDd80Ek27Tqz0v27PVAFe73I+jV4FUepbEcSM93ypxXXBVpHmYDGDDPW0j1RfB9pa/L1w50/XoxRY9Afl342EsKR3CVPvExEhOst01CGzXfYzuyegSI0x/FgZ3Xbhc/MM9WaH7VSbDa47QTL+zT7TCvi/2g+2MN8ejAlmgBBudjuzi7DSSbavOTsnlg14K0oRT0Vpmo40t8WYtRMBrTrlcbf+mwsG0JJKNvR0EkQpwtTbKHwwdkxXKQuudqGaNUCYmPw/nBpDyOkGmWun/CaP0WiLkk8s3pbHe8Fv1rzzRuSA74l6FkLFOZfrjqmbu0Ks6mOkyPUfW2/vgscswh6DTdxbKDvbdXrjpXIcem9LTMcKHSLBTCVtErE6ZzuH9lYok6psh1osxBMM5gZDqgwxPVz2i/GWHxIRli
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbfda6b-414e-40e9-69bf-08d787ae7569
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2019 13:46:05.8957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zo1kvrKHKo7ERzmOjPfnxGoYLn7dqekkST5yGFfjEopqTL2keJlvc4PmiEbvBKKIdbm4iFbdXWQ3oqpcpE4Vl/wZ8d9GtjCpwD1LYGB8L3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB6213
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-23_06:2019-12-23,2019-12-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 suspectscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912230118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Kishon

Thanks & Regards,
Yuti Amonkar

> -----Original Message-----
> From: Yuti Amonkar <yamonkar@cadence.com>
> Sent: Monday, December 23, 2019 19:11
> To: linux-kernel@vger.kernel.org; dri-devel@lists.freedesktop.org;
> maxime@cerno.tech
> Cc: praneeth@ti.com; tomi.valkeinen@ti.com; jsarha@ti.com; Milind Parab
> <mparab@cadence.com>; Swapnil Kashinath Jakhade
> <sjakhade@cadence.com>; Yuti Suresh Amonkar <yamonkar@cadence.com>
> Subject: [PATCH v2] phy: Add DisplayPort configuration options
>=20
> Allow DisplayPort PHYs to be configured through the generic functions
> through a custom structure added to the generic union.
> The configuration structure is used for reconfiguration of DisplayPort PH=
Ys
> during link training operation.
>=20
> The parameters added here are the ones defined in the DisplayPort spec 1.=
4
> which include link rate, number of lanes, voltage swing and pre-emphasis.
>=20
> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> ---
>=20
> This patch was a part of [1] series earlier but we think that it needs to=
 have a
> separate attention of the reviewers. Also as both [1] & [2] are dependent=
 on
> this patch, our sincere request to reviewers to have a faster review of t=
his
> patch.
>=20
> [1]
>=20
> https://lkml.org/lkml/2019/12/11/455
>=20
> [2]
>=20
> https://patchwork.kernel.org/cover/11271191/
>=20
>  include/linux/phy/phy-dp.h | 95
> ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/phy/phy.h    |  4 ++
>  2 files changed, 99 insertions(+)
>  create mode 100644 include/linux/phy/phy-dp.h
>=20
> diff --git a/include/linux/phy/phy-dp.h b/include/linux/phy/phy-dp.h new
> file mode 100644 index 0000000..18cad23
> --- /dev/null
> +++ b/include/linux/phy/phy-dp.h
> @@ -0,0 +1,95 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2019 Cadence Design Systems Inc.
> + */
> +
> +#ifndef __PHY_DP_H_
> +#define __PHY_DP_H_
> +
> +#include <linux/types.h>
> +
> +/**
> + * struct phy_configure_opts_dp - DisplayPort PHY configuration set
> + *
> + * This structure is used to represent the configuration state of a
> + * DisplayPort phy.
> + */
> +struct phy_configure_opts_dp {
> +	/**
> +	 * @link_rate:
> +	 *
> +	 * Link Rate, in Mb/s, of the main link.
> +	 *
> +	 * Allowed values: 1620, 2160, 2430, 2700, 3240, 4320, 5400, 8100
> Mb/s
> +	 */
> +	unsigned int link_rate;
> +
> +	/**
> +	 * @lanes:
> +	 *
> +	 * Number of active, consecutive, data lanes, starting from
> +	 * lane 0, used for the transmissions on main link.
> +	 *
> +	 * Allowed values: 1, 2, 4
> +	 */
> +	unsigned int lanes;
> +
> +	/**
> +	 * @voltage:
> +	 *
> +	 * Voltage swing levels, as specified by DisplayPort specification,
> +	 * to be used by particular lanes. One value per lane.
> +	 * voltage[0] is for lane 0, voltage[1] is for lane 1, etc.
> +	 *
> +	 * Maximum value: 3
> +	 */
> +	unsigned int voltage[4];
> +
> +	/**
> +	 * @pre:
> +	 *
> +	 * Pre-emphasis levels, as specified by DisplayPort specification, to b=
e
> +	 * used by particular lanes. One value per lane.
> +	 *
> +	 * Maximum value: 3
> +	 */
> +	unsigned int pre[4];
> +
> +	/**
> +	 * @ssc:
> +	 *
> +	 * Flag indicating, whether or not to enable spread-spectrum
> clocking.
> +	 *
> +	 */
> +	u8 ssc : 1;
> +
> +	/**
> +	 * @set_rate:
> +	 *
> +	 * Flag indicating, whether or not reconfigure link rate and SSC to
> +	 * requested values.
> +	 *
> +	 */
> +	u8 set_rate : 1;
> +
> +	/**
> +	 * @set_lanes:
> +	 *
> +	 * Flag indicating, whether or not reconfigure lane count to
> +	 * requested value.
> +	 *
> +	 */
> +	u8 set_lanes : 1;
> +
> +	/**
> +	 * @set_voltages:
> +	 *
> +	 * Flag indicating, whether or not reconfigure voltage swing
> +	 * and pre-emphasis to requested values. Only lanes specified
> +	 * by "lanes" parameter will be affected.
> +	 *
> +	 */
> +	u8 set_voltages : 1;
> +};
> +
> +#endif /* __PHY_DP_H_ */
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h index
> 15032f14..ba0aab5 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -16,6 +16,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
>=20
> +#include <linux/phy/phy-dp.h>
>  #include <linux/phy/phy-mipi-dphy.h>
>=20
>  struct phy;
> @@ -46,9 +47,12 @@ enum phy_mode {
>   *
>   * @mipi_dphy:	Configuration set applicable for phys supporting
>   *		the MIPI_DPHY phy mode.
> + * @dp:		Configuration set applicable for phys supporting
> + *		the DisplayPort protocol.
>   */
>  union phy_configure_opts {
>  	struct phy_configure_opts_mipi_dphy	mipi_dphy;
> +	struct phy_configure_opts_dp		dp;
>  };
>=20
>  /**
> --
> 2.7.4

