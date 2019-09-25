Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AE1C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 13:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59B120640
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 13:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IiPGDc/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406263AbfIYNNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 09:13:09 -0400
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]:37925
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406237AbfIYNNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 09:13:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6cgG2Jr5FdXOsOuMwUtwTY0q4NYmyaidMv1eCjmliXzWgGwlUFDcgH3AxbZy5qKFlOpETM+cw9LcgpyNhGaZqDRz9PhJ2zRXXB0qQeC3gOzblBezTa0k58kMQM1ogOkdV1V4+sJMKyxQ3LxGgpk12Pub2g7Dloz8HqzNaBKyiQd8mWelo5zzyYwyYF+VVQxQD4E+zHcovZU43FWYscYOJr6RGA8l1YhyNLQQmhe9jy3mZbGwQqZzs3Scxj7w78cHPXCSwc8Ji7eptV4R6BlMCFQBlUc9bW7LE937qbaskIDyVkCYTWmoekEZN7gErVcRgEX52/t2tZTnFkjGmNoVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yijX3nsW6Eu8F/x5H+sE1PiV9eRcmfiPEs8Eod6KO5A=;
 b=V9NqwJBfJQM9/5FYUnAZhVWV65oBgLl0yuNX3m6CYFAV/5NIvVRxph6vFtPblmwfWpWBxVmKR2K+LXu9FzymyrTv5r2X12Tksq9GIlMJULlUPMf+ZIikcJw83i2skQVfac5jA3yWNVBHrzFCJlFI2iCkib/X/W/97hV4zNPbawqjYImrvBmqCCLUb/uDxYROjN9K+kPeJMYXIuB/4kr0Ms4pDLNjzRHBXDaWmdqOtadLjnciUQq6fChzgoO2eaw4b/DaKZ5DT3VyOxFNp7kK0CoyZacaBREukoD1pP8zkp3r4iM02ibW0zglZcPkEgBgVZa1oF2Hi9nVdKUB78UrsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yijX3nsW6Eu8F/x5H+sE1PiV9eRcmfiPEs8Eod6KO5A=;
 b=IiPGDc/v959ZurmIg6Lrb9AxOtwCjPBCiCXZiYOAeguv7110EgSkbp610R1A0tpw6frmiP3lUix10Bz9YfGKIeJLXP0067qRU1dCVztmhNCB9HnS8+8ewkn4l2eKhc+wOPOhLLlXPZO7VqHo2c9i6Zsb3r1fAEnM1O76g9ZqEXM=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1SPR01MB023.eurprd04.prod.outlook.com (52.134.18.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 25 Sep 2019 13:13:03 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8%2]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 13:13:02 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] firmware: imx: Skip return value check for some special
 SCU firmware APIs
Thread-Topic: [PATCH] firmware: imx: Skip return value check for some special
 SCU firmware APIs
Thread-Index: AQHVc4lSn4nBMGf230anvZh0PllY6g==
Date:   Wed, 25 Sep 2019 13:13:02 +0000
Message-ID: <VI1PR04MB70232DEA67972332611480CAEE870@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1569406066-16626-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2526283c-1931-412f-009b-08d741ba18a9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1SPR01MB023;
x-ms-traffictypediagnostic: VI1SPR01MB023:|VI1SPR01MB023:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1SPR01MB0239392B88A58BA2D3E113BEE870@VI1SPR01MB023.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(199004)(189003)(6636002)(316002)(102836004)(186003)(26005)(305945005)(6506007)(7696005)(8936002)(5660300002)(53546011)(76116006)(66946007)(9686003)(76176011)(7736002)(66066001)(91956017)(45080400002)(54906003)(6306002)(478600001)(66556008)(66476007)(81156014)(110136005)(64756008)(25786009)(66446008)(8676002)(71200400001)(71190400001)(86362001)(81166006)(229853002)(3846002)(6246003)(2501003)(99286004)(33656002)(6116002)(14454004)(44832011)(55016002)(2906002)(446003)(14444005)(966005)(4326008)(476003)(52536014)(256004)(486006)(6436002)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1SPR01MB023;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 66u+VoyOVB0RdKZ0ocp5uO9BaQSYUkMSetPZaxq86rSvYvFHXVeEjfto7tyV70LC371fmfcJxnFBcbVPtnanA6jAk1tjnNUDrD9hZbBvXt+1gMc3VxaRqhKagu0FxfiHcNq1034/PSRDkssAJ//a5sqiCagxFdZROr8VmGH+Wra8pTwIqkTvSl7QwCyWabCTJZnHzKCN6sG901QPSIte8HYS5z20bi6YiAgtmTNP9AtjwipXVbI+pkStgUkPz6Ys4bxsU6Ry37he+OeuCsAq/XoBiOGcedOjB22qsmpmqz4GDGcV5e2aXjrCcjEu25AgycE0Tr2i4lNcsZMYPRJDyMzUfb+ryc15YgrAWFY5roXM16zDB/Bsv1pBVXYHS7XdWloNg/+Sjj/pn6EWPHMhIgzRqLJo02w2saNhsRoORqGMIE/RgreqF3jW3tNmPRBcZ2FUzpdNCYq+9C7IY7GQhA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2526283c-1931-412f-009b-08d741ba18a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 13:13:02.8264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I2ZvYu/9RCXozIhCIO+YRWSZ88ZLHxrJ/LeexbbRmitPfGQrW6/v1GrL7J6WOLK9uCykYC5EL0SfwG6XHwer8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1SPR01MB023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.09.2019 13:09, Anson Huang wrote:=0A=
> The SCU firmware does NOT always have return value stored in message=0A=
> header's function element even the API has response data, those special=
=0A=
> APIs are defined as void function in SCU firmware, so they should be=0A=
> treated as return success always.=0A=
> =0A=
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>=0A=
> ---=0A=
> 	- This patch is based on the patch of https://eur01.safelinks.protection=
.outlook.com/?url=3Dhttps%3A%2F%2Fpatchwork.kernel.org%2Fpatch%2F11129553%2=
F&amp;data=3D02%7C01%7Cleonard.crestez%40nxp.com%7Cc0ced6cd07f04023977008d7=
41a07367%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637050029712216472&am=
p;sdata=3DCcq%2Fb2RJdMqmnL7VXrl8YhOlUwC7bWiUG%2BNmiw4OsSM%3D&amp;reserved=
=3D0=0A=
> ---=0A=
>   drivers/firmware/imx/imx-scu.c | 34 ++++++++++++++++++++++++++++++++--=
=0A=
>   1 file changed, 32 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-sc=
u.c=0A=
> index 869be7a..ced5b12 100644=0A=
> --- a/drivers/firmware/imx/imx-scu.c=0A=
> +++ b/drivers/firmware/imx/imx-scu.c=0A=
> @@ -78,6 +78,11 @@ static int imx_sc_linux_errmap[IMX_SC_ERR_LAST] =3D {=
=0A=
>   	-EIO,	 /* IMX_SC_ERR_FAIL */=0A=
>   };=0A=
>   =0A=
> +static const struct imx_sc_rpc_msg whitelist[] =3D {=0A=
> +	{ .svc =3D IMX_SC_RPC_SVC_MISC, .func =3D IMX_SC_MISC_FUNC_UNIQUE_ID },=
=0A=
> +	{ .svc =3D IMX_SC_RPC_SVC_MISC, .func =3D IMX_SC_MISC_FUNC_GET_BUTTON_S=
TATUS },=0A=
> +};=0A=
=0A=
Until now this low level IPC code didn't treat any svc/func specially =0A=
and this seems good.=0A=
=0A=
The imx_scu_call_rpc function already has an have_resp argument and =0A=
callers are responsible to fill it. Can't we deal with this by adding an =
=0A=
additional err_ret flag passed by the caller?=0A=
=0A=
We can add wrapper functions to avoid tree-wide changes for all callers.=0A=
=0A=
> +=0A=
>   static struct imx_sc_ipc *imx_sc_ipc_handle;=0A=
>   =0A=
>   static inline int imx_sc_to_linux_errno(int errno)=0A=
> @@ -157,11 +162,24 @@ static int imx_scu_ipc_write(struct imx_sc_ipc *sc_=
ipc, void *msg)=0A=
>   	return 0;=0A=
>   }=0A=
>   =0A=
> +static bool imx_scu_call_skip_return_value_check(uint8_t svc, uint8_t fu=
nc)=0A=
> +{=0A=
> +	int i;=0A=
> +=0A=
> +	for (i =3D 0; i < ARRAY_SIZE(whitelist); i++)=0A=
> +		if (svc =3D=3D whitelist[i].svc &&=0A=
> +			func =3D=3D whitelist[i].func)=0A=
> +			return true;=0A=
> +=0A=
> +	return false;=0A=
> +}=0A=
> +=0A=
>   /*=0A=
>    * RPC command/response=0A=
>    */=0A=
>   int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *msg, bool have_re=
sp)=0A=
>   {=0A=
> +	uint8_t saved_svc, saved_func;=0A=
>   	struct imx_sc_rpc_msg *hdr;=0A=
>   	int ret;=0A=
>   =0A=
> @@ -171,8 +189,11 @@ int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void=
 *msg, bool have_resp)=0A=
>   	mutex_lock(&sc_ipc->lock);=0A=
>   	reinit_completion(&sc_ipc->done);=0A=
>   =0A=
> -	if (have_resp)=0A=
> +	if (have_resp) {=0A=
>   		sc_ipc->msg =3D msg;=0A=
> +		saved_svc =3D ((struct imx_sc_rpc_msg *)msg)->svc;=0A=
> +		saved_func =3D ((struct imx_sc_rpc_msg *)msg)->func;=0A=
> +	}=0A=
>   	sc_ipc->count =3D 0;=0A=
>   	ret =3D imx_scu_ipc_write(sc_ipc, msg);=0A=
>   	if (ret < 0) {=0A=
> @@ -190,7 +211,16 @@ int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void=
 *msg, bool have_resp)=0A=
>   =0A=
>   		/* response status is stored in hdr->func field */=0A=
>   		hdr =3D msg;=0A=
> -		ret =3D hdr->func;=0A=
> +		/*=0A=
> +		 * Some special SCU firmware APIs do NOT have return value=0A=
> +		 * in hdr->func, but they do have response data, those special=0A=
> +		 * APIs are defined as void function in SCU firmware, so they=0A=
> +		 * should be treated as return success always.=0A=
> +		 */=0A=
> +		if (!imx_scu_call_skip_return_value_check(saved_svc, saved_func))=0A=
> +			ret =3D hdr->func;=0A=
> +		else=0A=
> +			ret =3D 0;=0A=
>   	}=0A=
>   =0A=
>   out:=0A=
> =0A=
=0A=
