Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D2FC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3184C206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ny3tuhDW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfGASGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 14:06:25 -0400
Received: from mail-eopbgr700059.outbound.protection.outlook.com ([40.107.70.59]:10272
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726664AbfGASGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 14:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0GErOmXWvzZBnCzwVTs8ZusGUhRN06T0PRYmCTIm1o=;
 b=ny3tuhDW2/vwmiWWxY4oFGwJh/kMPU/7MT0GLNRWt4i8u+hRdqm8oR1VNHOCsfYybyslAEBBp3ksRW3WsQdPBxyknWcO0HxGd+r7BOSV7tw198DytbAueY0zmH6Hx6ogUy4cb/efQDiYAJ5rv2mlFVdR/4W2UTGvfnKeeziEl0E=
Received: from BYAPR02MB5992.namprd02.prod.outlook.com (20.179.89.80) by
 BYAPR02MB5925.namprd02.prod.outlook.com (20.179.88.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.17; Mon, 1 Jul 2019 18:06:19 +0000
Received: from BYAPR02MB5992.namprd02.prod.outlook.com
 ([fe80::7d51:4070:6fa5:ad63]) by BYAPR02MB5992.namprd02.prod.outlook.com
 ([fe80::7d51:4070:6fa5:ad63%6]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 18:06:19 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Manish Narani <MNARANI@xilinx.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Michal Simek <michals@xilinx.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "christoph.muellner@theobroma-systems.com" 
        <christoph.muellner@theobroma-systems.com>,
        "philipp.tomsich@theobroma-systems.com" 
        <philipp.tomsich@theobroma-systems.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "scott.branden@broadcom.com" <scott.branden@broadcom.com>,
        "ayaka@soulik.info" <ayaka@soulik.info>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        "tony.xie@rock-chips.com" <tony.xie@rock-chips.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        Nava kishore Manne <navam@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        Manish Narani <MNARANI@xilinx.com>,
        "olof@lixom.net" <olof@lixom.net>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
Subject: RE: [PATCH v2 09/11] firmware: xilinx: Add SDIO Tap Delay APIs
Thread-Topic: [PATCH v2 09/11] firmware: xilinx: Add SDIO Tap Delay APIs
Thread-Index: AQHVL84JY2ud08ZOekGksOuZgwbNtaa2D3KQ
Date:   Mon, 1 Jul 2019 18:06:19 +0000
Message-ID: <BYAPR02MB599224BA6280EDF56870E1D8B8F90@BYAPR02MB5992.namprd02.prod.outlook.com>
References: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
 <1561958991-21935-10-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1561958991-21935-10-git-send-email-manish.narani@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab625af0-dafc-46da-7bad-08d6fe4ed178
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR02MB5925;
x-ms-traffictypediagnostic: BYAPR02MB5925:
x-microsoft-antispam-prvs: <BYAPR02MB592513AE55DD28A437424BCBB8F90@BYAPR02MB5925.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(199004)(189003)(13464003)(73956011)(68736007)(316002)(14454004)(86362001)(446003)(14444005)(66946007)(2201001)(6246003)(76116006)(256004)(66476007)(66446008)(64756008)(66556008)(7696005)(71190400001)(486006)(66066001)(102836004)(476003)(11346002)(74316002)(305945005)(53546011)(81156014)(81166006)(6506007)(7736002)(2906002)(52536014)(8676002)(478600001)(99286004)(33656002)(229853002)(7416002)(53936002)(76176011)(186003)(5660300002)(55016002)(9686003)(26005)(4326008)(3846002)(2501003)(25786009)(6116002)(6436002)(8936002)(54906003)(110136005)(71200400001)(72206003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5925;H:BYAPR02MB5992.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4njsNdeEFYZIs3xM5jaOMl2Q0bqnmGl7nohzZQeljFBW9B+GMSlr+lMTwjjMRSC4MPm/2xFwnzr/nsZC3EmPDHVvRGrT2E/Eyu/80LpnCmVih47yUyv+ZhKlcOcgwn5QtKz7filXzUjwQtM/NdKP6b/yxyxvfXfgpKkh6mY2PCouIj/IGfkCa8BZqnfcxv94AJOAdPrs90hIc3zsiADhdCfqxewzoFJ+KSiHd8Wek1qzP+3VuuK9pXVR7nJCfrV33u/AU+SzW7qmzZnfmzH6hGS/gHCkZJPCHmP0dJJcI15HUMw6ZKkwPbcXdURc45qy09XAcCs9wP3DuB+SOzfHPR6jCR6n43mz9lpTEfDgHxE3JAYKfl5y3YwTqPk8QtL+vY5C0tQRjo/IL7evfBtEKXG4v2pB1+/9DozD64DNdsk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab625af0-dafc-46da-7bad-08d6fe4ed178
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 18:06:19.0874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jollys@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5925
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manish,

> -----Original Message-----
> From: Manish Narani <manish.narani@xilinx.com>
> Sent: Sunday, June 30, 2019 10:30 PM
> To: ulf.hansson@linaro.org; robh+dt@kernel.org; mark.rutland@arm.com;
> heiko@sntech.de; Michal Simek <michals@xilinx.com>;
> adrian.hunter@intel.com; christoph.muellner@theobroma-systems.com;
> philipp.tomsich@theobroma-systems.com; viresh.kumar@linaro.org;
> scott.branden@broadcom.com; ayaka@soulik.info; kernel@esmil.dk;
> tony.xie@rock-chips.com; Rajan Vaja <RAJANV@xilinx.com>; Jolly Shah
> <JOLLYS@xilinx.com>; Nava kishore Manne <navam@xilinx.com>;
> mdf@kernel.org; Manish Narani <MNARANI@xilinx.com>; olof@lixom.net
> Cc: linux-mmc@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> rockchip@lists.infradead.org
> Subject: [PATCH v2 09/11] firmware: xilinx: Add SDIO Tap Delay APIs
>=20
> Add APIs for setting SDIO Tap Delays on ZynqMP platform.
>=20
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c     | 48
> ++++++++++++++++++++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h | 15 ++++++++++-
>  2 files changed, 62 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/z=
ynqmp.c
> index fd3d837..b81f1be 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -664,6 +664,52 @@ static int zynqmp_pm_set_requirement(const u32
> node, const u32 capabilities,
>  				   qos, ack, NULL);
>  }
>=20
> +/**
> + * zynqmp_pm_sdio_out_setphase() - PM call to set clock output delays fo=
r SD
> + * @device_id:		Device ID of the SD controller
> + * @tap_delay:		Tap Delay value for output clock
> + *
> + * This API function is to be used for setting the clock output delays f=
or SD
> + * clock.
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_sdio_out_setphase(u32 device_id, u8 tap_delay)
> +{
> +	u32 node_id =3D (!device_id) ? NODE_SD_0 : NODE_SD_1;
> +	int ret;
> +
> +	ret =3D zynqmp_pm_ioctl(node_id, IOCTL_SET_SD_TAPDELAY,
> +			      PM_TAPDELAY_OUTPUT, tap_delay, NULL);
> +	if (ret)
> +		pr_err("Error setting Output Tap Delay\n");
> +
> +	return ret;
> +}
> +
> +/**
> + * zynqmp_pm_sdio_in_setphase() - PM call to set clock input delays for =
SD
> + * @device_id:		Device ID of the SD controller
> + * @tap_delay:		Tap Delay value for input clock
> + *
> + * This API function is to be used for setting the clock input delays fo=
r SD
> + * clock.
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_sdio_in_setphase(u32 device_id, u8 tap_delay)
> +{
> +	u32 node_id =3D (!device_id) ? NODE_SD_0 : NODE_SD_1;
> +	int ret;
> +
> +	ret =3D zynqmp_pm_ioctl(node_id, IOCTL_SET_SD_TAPDELAY,
> +			      PM_TAPDELAY_INPUT, tap_delay, NULL);
> +	if (ret)
> +		pr_err("Error setting Input Tap Delay\n");
> +
> +	return ret;
> +}
> +
>  static const struct zynqmp_eemi_ops eemi_ops =3D {
>  	.get_api_version =3D zynqmp_pm_get_api_version,
>  	.get_chipid =3D zynqmp_pm_get_chipid,
> @@ -687,6 +733,8 @@ static const struct zynqmp_eemi_ops eemi_ops =3D {
>  	.set_requirement =3D zynqmp_pm_set_requirement,
>  	.fpga_load =3D zynqmp_pm_fpga_load,
>  	.fpga_get_status =3D zynqmp_pm_fpga_get_status,
> +	.sdio_out_setphase =3D zynqmp_pm_sdio_out_setphase,
> +	.sdio_in_setphase =3D zynqmp_pm_sdio_in_setphase,

Are these eemi APIs? You are using ioctl eemi api to set the delay.

Thanks,
Jolly Shah

>  };
>=20
>  /**
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmwar=
e/xlnx-
> zynqmp.h
> index 1262ea6..d9b53e5 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -92,7 +92,8 @@ enum pm_ret_status {
>  };
>=20
>  enum pm_ioctl_id {
> -	IOCTL_SET_PLL_FRAC_MODE =3D 8,
> +	IOCTL_SET_SD_TAPDELAY =3D 7,
> +	IOCTL_SET_PLL_FRAC_MODE,
>  	IOCTL_GET_PLL_FRAC_MODE,
>  	IOCTL_SET_PLL_FRAC_DATA,
>  	IOCTL_GET_PLL_FRAC_DATA,
> @@ -251,6 +252,16 @@ enum zynqmp_pm_request_ack {
>  	ZYNQMP_PM_REQUEST_ACK_NON_BLOCKING,
>  };
>=20
> +enum pm_node_id {
> +	NODE_SD_0 =3D 39,
> +	NODE_SD_1,
> +};
> +
> +enum tap_delay_type {
> +	PM_TAPDELAY_INPUT =3D 0,
> +	PM_TAPDELAY_OUTPUT,
> +};
> +
>  /**
>   * struct zynqmp_pm_query_data - PM query data
>   * @qid:	query ID
> @@ -295,6 +306,8 @@ struct zynqmp_eemi_ops {
>  			       const u32 capabilities,
>  			       const u32 qos,
>  			       const enum zynqmp_pm_request_ack ack);
> +	int (*sdio_out_setphase)(u32 device_id, u8 tap_delay);
> +	int (*sdio_in_setphase)(u32 device_id, u8 tap_delay);
>  };
>=20
>  int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
> --
> 2.1.1

