Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DCBC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76A820684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n4oPmjU+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="b/iBNtuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbfCFTv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 14:51:59 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6833 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbfCFTv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 14:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1551901919; x=1583437919;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=zuOCwmN1+Ehoi1k0VU3hOLETvBUERWckjgxNh+pgPl0=;
  b=n4oPmjU+OdFv9245B6l+9RqPGifq2gwfEypla1pmtR9WLYeWVUHlr2HT
   H+I+EaiLgcgSy+bxx9o+LBtctqh2hdCw//ZHk2y7KpBnXFs8sR2IV/70U
   /UdbDPmqbvNkYs0qEHbNPfIH4vdCjGwCFuYd/5mzAlF4kQn7z7fQRPGil
   80EmNuJSESnzrHXf+dmzJV3YC4nmSe+T/0Ds+7CRtK9ksAvVZqoh1t+kp
   u+LRB0glBUElJ5UUM1C2sm2Jzy6xTtONkvLb/IHN1Ct91yRZuOXnjKgiE
   sjS8jTm9qnmoUAHOlWeSwHkbI9Al2uDwF+IMDXLzC160IokedyBg75y4O
   g==;
X-IronPort-AV: E=Sophos;i="5.58,448,1544457600"; 
   d="scan'208";a="107900762"
Received: from mail-by2nam05lp2057.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.57])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2019 03:51:56 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDJqvUiRRMkp+uTKEAOmwn+viftQwat3YnZx0ie2++U=;
 b=b/iBNtuKkqDc6pPcSN/Ouue05PT6XVQSUxC1vuKIhqP0mxeDO7s8d7VHkRZvoe4otk2W9FSNzKUcqiVdvgHG9rnTk6AFENgcvgL+Yqk/KJMm9zYCUB8PNLOmopObSyQodJiK3czlvRKCMFv/9Bcq0HHbi15J7KRpb83XaLLMRqQ=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB3837.namprd04.prod.outlook.com (52.135.81.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Wed, 6 Mar 2019 19:51:53 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::adbe:cbf2:4b33:dbd]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::adbe:cbf2:4b33:dbd%4]) with mapi id 15.20.1665.020; Wed, 6 Mar 2019
 19:51:53 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] drivers: nvme: Kconfig: pedantic cleanups
Thread-Topic: [PATCH] drivers: nvme: Kconfig: pedantic cleanups
Thread-Index: AQHU1ErVcVgOv7WiIkajHpPtl6Ubrg==
Date:   Wed, 6 Mar 2019 19:51:53 +0000
Message-ID: <SN6PR04MB4527FD956498AD3A5959470C86730@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <1551897030-2219-1-git-send-email-info@metux.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e41ca2fd-7606-4b8d-ea44-08d6a26d2e6e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB3837;
x-ms-traffictypediagnostic: SN6PR04MB3837:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;SN6PR04MB3837;23:x6dFNHkuXHgBtdzjKLvtolRvK4Hi2yGviAjgBpNMJ?=
 =?us-ascii?Q?ybUvvsu6CIN2GxZDaOZ7Tr9QxsoxhkhkoIH/TcQfZDbAquHVUxwkq5Fch1Tq?=
 =?us-ascii?Q?S3vp4eWHG77EYvgHYdoeWr+LTIOHdlAsbRGKp2DK0yobnu5cUqe+K1spMTv4?=
 =?us-ascii?Q?NXcAkz9wUXznkwuCEisLygyR2HxFMnvRPLkkjhwK9b+wFWd84ImpAzxZATg8?=
 =?us-ascii?Q?gm10IzF+GlhJPffPmSI/O5mYvoohPMYJzwYrvfhEcWQv7t5f43D2viYWXYG9?=
 =?us-ascii?Q?vAsFurelN2OpDgvXmGYlDWIik3rsRD9E7lO1Plp5ia5a0U+mAM6sDF00G8ou?=
 =?us-ascii?Q?TNyxO2ZAAtMGtwjvvUPq9rqjIG27xgG9WxMMTZFs5MWR3CL+2I1Z7CnCn15p?=
 =?us-ascii?Q?rD++lSr4LQw6Joz3E+TIv7k3FOLY+9s0heF0dxgtBEVzN5VI1/H8t7vXe4GC?=
 =?us-ascii?Q?cucEFMVYuypMlK10j7CMcUYGlktoWuBLTzVcF2+/jVqlBBmmHtChY1vr+Fir?=
 =?us-ascii?Q?EDGzX9x+fS/FnPRGC1++I0qBnCPYqdIWqrVCXTJaL+EiypMk6bDU9YySu2Ag?=
 =?us-ascii?Q?2qd10eO1tOaTk8ygAUScFrXRYNpDBC3yrnwEyjD8sqajkJMAUVkQW1+btF0i?=
 =?us-ascii?Q?tgEEY4P3fV0BRrBHnNvaAjzHpm7p38Qd2ujz3SgCwXx07D177ZqTH8S2GMqY?=
 =?us-ascii?Q?oYVboEnUnCY0LEpJJG2OIcLcGThVdhwo/xo4lUIskK8U2Ub3AEDR+3st5nBn?=
 =?us-ascii?Q?qxP/F7nsQGxvADPihg44DZs2X4A+ayukXKdrtVtJelFtmvz4Af7LAzGVoHxP?=
 =?us-ascii?Q?uuM4CjaWwgnN3qCCp+1RKXP7k/Gqtjm+8w23qHK+O70KW1sFW7xPesONYuiY?=
 =?us-ascii?Q?EI0En/rvyy196Yd04Gg/65G91eWVJ//3KmGW1RWvSwwVZFNQFlDFFw+pdSWf?=
 =?us-ascii?Q?wDFQSh00nevmPzKFQIhMCVbUyA8401+0WzG3M/CSmJ7OGFn2lViUKMZS2xhR?=
 =?us-ascii?Q?Bv/1p+rGuyBDZL3Zf0zbhnMw+aPnhQO5VtRycZb2Tg3oxFHyYmu6Y9DZM5Cn?=
 =?us-ascii?Q?+tn8uBrRvCA3kGjMqOoYO9VacMi5nOitK5MLHTETrcMKnm2BcQRxvqzBkVGa?=
 =?us-ascii?Q?tKGWIslaeXX7RcFFjw1lm3YLgwQFuOLbZiKU5ZYiq7f/DEHjtdNmb5wa0V4y?=
 =?us-ascii?Q?SJHrckjYe5V7gF7WUD2LVPikcw4wmIadz3fTzbrAm4QPsJS0ABD8lRytaHDU?=
 =?us-ascii?Q?d5Fgr73mMi9ACF9aPg8sKeY3s26TlnC/ijtKiJm?=
x-microsoft-antispam-prvs: <SN6PR04MB38374B3F5D0F2FC6BDC3073286730@SN6PR04MB3837.namprd04.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(136003)(39860400002)(189003)(199004)(53936002)(66066001)(106356001)(6506007)(8936002)(53546011)(6116002)(6246003)(3846002)(6436002)(72206003)(68736007)(1250700005)(14454004)(97736004)(7696005)(76176011)(105586002)(4326008)(2501003)(26005)(55016002)(102836004)(478600001)(7736002)(14444005)(229853002)(256004)(305945005)(86362001)(71200400001)(74316002)(110136005)(71190400001)(81166006)(186003)(99286004)(25786009)(5660300002)(33656002)(316002)(52536013)(476003)(446003)(81156014)(8676002)(486006)(2906002)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB3837;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hKZJzsrdv7VWdcEhIxlKG1SHOTR1HnnBrkbPOnxRzx2Gug/pYmJKo5DOzB6/k58DKcqJ/oTwJugKSaM+ZJdESFpjdJXJuN83naGDqeSLWPvBsiFC3+jzEyFIlXxUftFyMYOKqheZItwHzlB3B3NXEq64gFhNxdWtqd29LR2YjOjtwFgilYx3/kdCL3iTSLFefVVKG8SZ1CnSR8GJdl1aJ5fFncjInnWhMJrC9KYVXHicyxWnKVBY7ENkbcVIsWrvvLSfdWdzqcpAqlQzDp2Sja3DtZOICHli0wW33NmABwx4gUcI4o1KhiaGI1hrcvasEw/aeowU/AWaj/O7sUopi9IU30h+DWPT8ERega3n7PCCNGWiUYnCwYLr01VtJ0gIvLQwVFslQL0wZKczzi9xVpdjMYBfB8dfITS7TXhbtpQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41ca2fd-7606-4b8d-ea44-08d6a26d2e6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 19:51:53.2008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3837
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/19 10:31 AM, Enrico Weigelt, metux IT consult wrote:=0A=
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>=0A=
> ---=0A=
>   drivers/nvme/host/Kconfig | 8 ++++----=0A=
>   1 file changed, 4 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig=0A=
> index 0f345e2..ce361c9 100644=0A=
> --- a/drivers/nvme/host/Kconfig=0A=
> +++ b/drivers/nvme/host/Kconfig=0A=
> @@ -17,10 +17,10 @@ config NVME_MULTIPATH=0A=
>   	bool "NVMe multipath support"=0A=
>   	depends on NVME_CORE=0A=
>   	---help---=0A=
> -	   This option enables support for multipath access to NVMe=0A=
> -	   subsystems.  If this option is enabled only a single=0A=
> -	   /dev/nvmeXnY device will show up for each NVMe namespaces,=0A=
> -	   even if it is accessible through multiple controllers.=0A=
> +	  This option enables support for multipath access to NVMe=0A=
> +	  subsystems.  If this option is enabled only a single=0A=
> +	  /dev/nvmeXnY device will show up for each NVMe namespaces,=0A=
> +	  even if it is accessible through multiple controllers.=0A=
>   =0A=
>   config NVME_FABRICS=0A=
>   	tristate=0A=
> =0A=
=0A=
=0A=
Alignment looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
