Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF935C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD12A22CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JOkaU1T5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfIDHeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:34:10 -0400
Received: from mail-eopbgr50056.outbound.protection.outlook.com ([40.107.5.56]:20096
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728259AbfIDHeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:34:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGxlOYPUcaAeVVTJ9bGM2BQ02hzsdFB338ZktE6T+o8xNeQ8cbhMm/MsLhS8yeKIjIMKDB5L9LaBWbLQg7wRArm6qFiEh6YKCFyxCDq3NXrLkN/u621UKDVqxV+QodD55FWPajNy88zqilrl4aQM4rwZNFthDK6C14B4uHQ1GfXMsA5YT04F4t9wTe3jELsgwdZy0tDnGVInDmv6YoQSEfEgdNUKM8/EINNbr/zpaqDL/tp5bQvTXXVm9y3uhUtiZMyCPw7b8ufVcAh5kBv0vnxSaHsZBUobWM5o4TxNgOUzVouvHStLCDNRacvEy7wmJNqtcnKxqdEt/eJx3mAMtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6ZyFsO57BP6TrSD81oEt1mcaWQnh1PpYQj1J9rfekY=;
 b=RkIigE7nYLiLPHMDCyygU0XpZagNApOLOSKn7cDMJgHCUHp4l1705CpTYge3X7MQhx61ncMsHTae+iWnh2305YI6kKdMj1RFlQMcGmXetJSd30SX3UCVRVBGDWbqUxfVdKyy5CpaunywP6VHHxGiv4kgMn0b7RXhSYY0pU/e7TpgoZ8rE+vmQDs9isHlP2mCdKKeBer6YLNNJf4CYCbc0ph1a/+lbw+6iq7KiD1qpFj93qCQo7wMfZOEnK94zKU0xH2tyMJkp70kuIMr1wa7vjKc5fsbe4pfWSIlm7nW8wqnt3uA4gH/3n1R7wk4fZt33k3DDRa9MFZdexG3VO3xTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6ZyFsO57BP6TrSD81oEt1mcaWQnh1PpYQj1J9rfekY=;
 b=JOkaU1T5lMEGOq+CtCZz/XTpDWMHWe4eCOzTNpL15j85W1ISF/nll0Cz6VmNms2xMCsQ6ItwRexsPC+/MqofZtCpqlNbU3XDdWx6/s6AizHDR/NKkZlIL+tOMPAxCDorQfi0u/oFCuOLsH4QpvCtItibr98Pso13+ljlLVN7xKE=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4606.eurprd04.prod.outlook.com (20.177.56.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Wed, 4 Sep 2019 07:34:07 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e%3]) with mapi id 15.20.2220.022; Wed, 4 Sep 2019
 07:34:07 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] soc: imx: imx-scu: Getting UID from SCU should have
 response
Thread-Topic: [PATCH] soc: imx: imx-scu: Getting UID from SCU should have
 response
Thread-Index: AQHVYvBashyquDfUQEej9aDOPv0J5A==
Date:   Wed, 4 Sep 2019 07:34:06 +0000
Message-ID: <VI1PR04MB7023B9C325C54AA8112F1AE5EEB80@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1567624394-25023-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [82.144.34.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40e1f21a-b14d-4900-12b2-08d7310a44e3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4606;
x-ms-traffictypediagnostic: VI1PR04MB4606:|VI1PR04MB4606:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4606447F47127BF1557463C9EEB80@VI1PR04MB4606.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(199004)(189003)(486006)(110136005)(7696005)(256004)(3846002)(6116002)(44832011)(76176011)(54906003)(316002)(6436002)(14444005)(6506007)(102836004)(53546011)(446003)(55016002)(478600001)(2906002)(476003)(14454004)(186003)(9686003)(26005)(53936002)(81156014)(5660300002)(4326008)(66066001)(6636002)(86362001)(6246003)(74316002)(305945005)(7736002)(66946007)(8676002)(76116006)(91956017)(71190400001)(8936002)(25786009)(52536014)(66446008)(99286004)(229853002)(33656002)(66556008)(66476007)(64756008)(71200400001)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4606;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0i9qREzh4HakHv+UF2wxPXrhVBl1xZBR+dDyDGWaCv7ktANnBtfgb+EF8XLQZlFQnz1dhw5HlvZDFO7CkKK1K7sdmJ0EEUe8t68NCOGf7D56UrWtzhnrAIPS0S8bRwI5+W7iwZUIzs0bt4nFpM82IWtIg+clW8EPLoIU45g6KbYF9rgQup/jRsZo4gxH2bYz75J10psUXa75h2P9FPUDUcZQvzXpk2/Age/bmwjUPwi+D9ah17byTt9yGwdCLFuodc1cglyS2G4QF7PFvyd58Vxq3IgC7O2RNr9lJGaZM71mPQ4LvRSW748shjjNuZfXwHclz1USPGGHTg9B08eVau0oHhJICVM1zbJxR0q4hwiDt0UeprigvVOmo/p6OA/F5su2tt6lM1LlWPpC1TrpoQazCbfafqBMhTJlbloZ7Po=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e1f21a-b14d-4900-12b2-08d7310a44e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 07:34:06.9669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CFtEgeZZyaEgbx3MGjg4ZLCi9NNEBxBfkT8wMfnkXuazU5RfI9tU1ixifIjh4dsrAlP30H5nBlNu3g2LVGgfgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4606
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-04 10:14 AM, Anson Huang wrote:=0A=
> The SCU firmware API for getting UID should have response,=0A=
> otherwise, the message stored in function stack could be=0A=
> released and then the response data received from SCU will be=0A=
> stored into that released stack and cause kernel NULL pointer=0A=
> dump.=0A=
=0A=
This fix looks good, but looking at imx-scu code it seems that passing =0A=
the incorrect "have_resp" argument to imx_scu_call_rpc or just receiving =
=0A=
an unexpected message from SCFW will always result in kernel stack =0A=
corruption!=0A=
=0A=
This is worth handling inside imx-scu itself: unless a response was =0A=
explicitly requested it should ignore and print a warning on rx, for =0A=
example by setting imx_sc_ipc to NULL when not waiting for a response.=0A=
=0A=
Holding on to arbitrary stack pointers is bad.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
=0A=
> diff --git a/drivers/soc/imx/soc-imx-scu.c b/drivers/soc/imx/soc-imx-scu.=
c=0A=
> index 50831eb..c68882e 100644=0A=
> --- a/drivers/soc/imx/soc-imx-scu.c=0A=
> +++ b/drivers/soc/imx/soc-imx-scu.c=0A=
> @@ -46,7 +46,7 @@ static ssize_t soc_uid_show(struct device *dev,=0A=
>   	hdr->func =3D IMX_SC_MISC_FUNC_UNIQUE_ID;=0A=
>   	hdr->size =3D 1;=0A=
>   =0A=
> -	ret =3D imx_scu_call_rpc(soc_ipc_handle, &msg, false);=0A=
> +	ret =3D imx_scu_call_rpc(soc_ipc_handle, &msg, true);=0A=
>   	if (ret) {=0A=
>   		pr_err("%s: get soc uid failed, ret %d\n", __func__, ret);=0A=
>   		return ret;=0A=
