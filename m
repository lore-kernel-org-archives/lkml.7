Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D8FC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DAF20644
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TccqouOd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="IRpO70xd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfD2Inp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 04:43:45 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:49460 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727480AbfD2Ino (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 04:43:44 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 08A55C00AE;
        Mon, 29 Apr 2019 08:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1556527422; bh=xI5h5MdXnhVD9y3tDSYGBQQ7Nsli3e4FTVtv6zWlr/U=;
        h=From:To:CC:Subject:Date:References:From;
        b=TccqouOdCMcNrMf7ERvNWy2BcFsOTPjlQ+MQ9FhllvuNFwdzVkS1cWVf0s2jUFWsV
         Zm0JdaRq6wJlOkAnwuHLz2RW7yP8CdkAGak4iIHpwkQk0OyC6CY221kSqAelNMEeAf
         /OB7p5n0lTVQSzB6A5TaRPNYdrYROPFAIFofdSyaW6nHHS28s3ZhIKaksNZ/Xp1OuJ
         QaK6a1GT6XD9J2BeYtBeeDtC+P9E+BoMXCpjj/a+PrOTHk1EiwJrhEiKoNbFMDJS+u
         D0H6ViypmhsGqncHDiak22z1bxH9dfu/WTqQWz/Cm0WvQkmcJrXMxGmFSGB4SyD8V4
         QAIJkU2qLvUAg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 11651A008E;
        Mon, 29 Apr 2019 08:43:37 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 29 Apr 2019 01:43:37 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 29 Apr 2019 01:43:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLtaK4dBkDbZZHaE01dlvd+2qLnST+ZXlz8Bal5/SMk=;
 b=IRpO70xdzfiCbg7qqRoA4bzq39hXrQxQi34IFxwU2E2MtmcDfIFYzNJaShjaBNxceh4iynShD/aFjvVeOullm7NmsaPwGoWuehNhimban/xx6/aXUf5Cg+bAA1/GPIJdA58VxieT0y9RFp28IO9Yy3arzPhsvolnoviD17c1CGk=
Received: from SN1PR12MB2431.namprd12.prod.outlook.com (52.132.195.146) by
 SN1PR12MB2493.namprd12.prod.outlook.com (52.132.196.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Mon, 29 Apr 2019 08:43:35 +0000
Received: from SN1PR12MB2431.namprd12.prod.outlook.com
 ([fe80::1982:4b45:2adf:9a1f]) by SN1PR12MB2431.namprd12.prod.outlook.com
 ([fe80::1982:4b45:2adf:9a1f%4]) with mapi id 15.20.1835.010; Mon, 29 Apr 2019
 08:43:34 +0000
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
To:     Douglas Anderson <dianders@chromium.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "heiko@sntech.de" <heiko@sntech.de>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        "amstan@chromium.org" <amstan@chromium.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        William Wu <william.wu@rock-chips.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Randy Li <ayaka@soulik.info>,
        "zyw@rock-chips.com" <zyw@rock-chips.com>,
        "mka@chromium.org" <mka@chromium.org>,
        "ryandcase@chromium.org" <ryandcase@chromium.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        "jwerner@chromium.org" <jwerner@chromium.org>,
        "dinguyen@opensource.altera.com" <dinguyen@opensource.altera.com>,
        "Elaine Zhang" <zhangqing@rock-chips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] usb: dwc2: bus suspend/resume for hosts with
 DWC2_POWER_DOWN_PARAM_NONE
Thread-Topic: [PATCH v2 1/5] usb: dwc2: bus suspend/resume for hosts with
 DWC2_POWER_DOWN_PARAM_NONE
Thread-Index: AQHU9XvT/eL2bASAskajIQu3Y3ICkw==
Date:   Mon, 29 Apr 2019 08:43:34 +0000
Message-ID: <SN1PR12MB243108D1EF3239EC4F730ACDA7390@SN1PR12MB2431.namprd12.prod.outlook.com>
References: <20190418001356.124334-1-dianders@chromium.org>
 <20190418001356.124334-2-dianders@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arturp@synopsys.com; 
x-originating-ip: [84.53.141.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dece680f-3687-4750-9416-08d6cc7ec439
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:SN1PR12MB2493;
x-ms-traffictypediagnostic: SN1PR12MB2493:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN1PR12MB24939235DAC2E3F6AE9AE470A7390@SN1PR12MB2493.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39850400004)(396003)(366004)(376002)(136003)(189003)(199004)(55674003)(14444005)(15650500001)(476003)(55016002)(256004)(9686003)(6306002)(99286004)(6246003)(966005)(486006)(316002)(52536014)(76116006)(8936002)(66946007)(66446008)(64756008)(66556008)(91956017)(5660300002)(66476007)(73956011)(33656002)(81156014)(81166006)(97736004)(8676002)(446003)(68736007)(102836004)(4326008)(478600001)(26005)(74316002)(53546011)(86362001)(25786009)(2906002)(7736002)(2501003)(305945005)(71190400001)(71200400001)(186003)(6506007)(6436002)(7416002)(7696005)(54906003)(229853002)(6116002)(66066001)(3846002)(76176011)(53936002)(14454004)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR12MB2493;H:SN1PR12MB2431.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PVAMvAtIY6ExilWoGs9GVvpiTp0Lk50DV2PtMF4MlUqVQ4yxJPbyC1ka08CT3JzrnJESy/Pw7TDclDrjS4DTheOogy5RbnZpjnI6AAbkXnfAu7NujCRojC9BAEp+wNERk3HiM5Ong2Dy0uGl/ew9dkdiqcfHl+ktSvEB+cNrJHlf7mpxyQcq0Rl3JwwanFgYGVvkYMwNMxuIdDykT7vbnJrKxSKpaC5nnujCzjJOi+rcyLeANlSAwi/jm9RLwiwXIReKy8gUGAEHvJLB/wWqCEDOON50jCH1dXkEKkNTmZZy24FEj2QnAMtThiu1Ac6FVwnmGrbcpuG1YYgTUPch/vNXiuEspsxSGmQlP/Mj3Is61P/Sbulo8f9QoC3tN2TrfoFmblLkueGcTitFWyPiEg8EldwxijfKltreVaIU40Y=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dece680f-3687-4750-9416-08d6cc7ec439
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 08:43:34.8366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2493
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=0A=
=0A=
On 4/18/2019 04:15, Douglas Anderson wrote:=0A=
> This is an attempt to rehash commit 0cf884e819e0 ("usb: dwc2: add bus=0A=
> suspend/resume for dwc2") on ToT.  That commit was reverted in commit=0A=
> b0bb9bb6ce01 ("Revert "usb: dwc2: add bus suspend/resume for dwc2"")=0A=
> because apparently it broke the Altera SOCFPGA.=0A=
> =0A=
> With all the changes that have happened to dwc2 in the meantime, it's=0A=
> possible that the Altera SOCFPGA will just magically work with this=0A=
> change now.  ...and it would be good to get bus suspend/resume=0A=
> implemented.=0A=
> =0A=
> This change is a forward port of one that's been living in the Chrome=0A=
> OS 3.14 kernel tree.=0A=
> =0A=
> Signed-off-by: Douglas Anderson <dianders@chromium.org>=0A=
> ---=0A=
> This patch was last posted at:=0A=
> =0A=
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.kernel.org_r_=
1446237173-2D15263-2D1-2Dgit-2Dsend-2Demail-2Ddianders-40chromium.org&d=3DD=
wIDAg&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_HlVzYqrC_D7=
niMJI&m=3DMMfe-4lZePyty6F5zfQ54kiYGuJWNulyRat944LkOsc&s=3DnExFpAPP_0plZfO5L=
MG1B-mqt1vyCvE35elVcyVgs8Y&e=3D=0A=
> =0A=
> ...and appears to have died the death of silence.  Maybe it could get=0A=
> some bake time in linuxnext if we can't find any proactive testing?=0A=
> =0A=
> I will also freely admit that I don't know tons about the theory=0A=
> behind this patch.  I'm mostly just re-hashing the original commit=0A=
> from Kever that was reverted since:=0A=
> * Turning on partial power down on rk3288 doesn't "just work".  I=0A=
>    don't get hotplug events.  This is despite dwc2 auto-detecting that=0A=
>    we are power optimized.=0A=
What do you mean by doesn't "just work" ? It seem to me that even after =0A=
adding this patch you don't get issues fixed.=0A=
You mention that you don't get the hotplug events. Please provide dwc2 =0A=
debug logs and register dumps on this issue.=0A=
=0A=
> * If we don't do something like this commit we don't get into as low=0A=
>    of a power mode.=0A=
> =0A=
> Changes in v2: None=0A=
> =0A=
>   drivers/usb/dwc2/hcd.c | 84 ++++++++++++++++++++++++++----------------=
=0A=
>   1 file changed, 53 insertions(+), 31 deletions(-)=0A=
> =0A=
> diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c=0A=
> index e272d020012e..978232a9e4a8 100644=0A=
> --- a/drivers/usb/dwc2/hcd.c=0A=
> +++ b/drivers/usb/dwc2/hcd.c=0A=
> @@ -4482,6 +4482,7 @@ static int _dwc2_hcd_suspend(struct usb_hcd *hcd)=
=0A=
>   	unsigned long flags;=0A=
>   	int ret =3D 0;=0A=
>   	u32 hprt0;=0A=
> +	u32 pcgctl;=0A=
>   =0A=
>   	spin_lock_irqsave(&hsotg->lock, flags);=0A=
>   =0A=
> @@ -4497,7 +4498,7 @@ static int _dwc2_hcd_suspend(struct usb_hcd *hcd)=
=0A=
>   	if (hsotg->op_state =3D=3D OTG_STATE_B_PERIPHERAL)=0A=
>   		goto unlock;=0A=
>   =0A=
> -	if (hsotg->params.power_down !=3D DWC2_POWER_DOWN_PARAM_PARTIAL)=0A=
> +	if (hsotg->params.power_down > DWC2_POWER_DOWN_PARAM_PARTIAL)=0A=
 >   		goto skip_power_saving;=0A=
 >=0A=
=0A=
"hsotg->params.power_down" is assigned to "DWC2_POWER_DOWN_PARAM_NONE =3D =
=0A=
0" if there is no hibernation or partial power down supported by the =0A=
core or power saving features are disabled by =0A=
"hsotg->params.power_saving =3D false" , "DWC2_POWER_DOWN_PARAM_PARTIAL" =
=0A=
if core supports partial power down, "DWC2_POWER_DOWN_PARAM_HIBERNATION =0A=
" if the core supports hibernation=0A=
=0A=
When you check "if (hsotg->params.power_down > =0A=
DWC2_POWER_DOWN_PARAM_PARTIAL)" you are saying that "skip_power_saving" =0A=
only in that case when core supports Hibernation. But what if core =0A=
doesn't support both hibernation and partial power down and the =0A=
"hsotg->params.power_down" value us equal to =0A=
"DWC2_POWER_DOWN_PARAM_NONE" which is 0.=0A=
=0A=
With this implementation driver will program entering to suspend when =0A=
core doesn't support both hibernation and partial power down.=0A=
=0A=
>   	/*=0A=
> @@ -4506,21 +4507,35 @@ static int _dwc2_hcd_suspend(struct usb_hcd *hcd)=
=0A=
>   	 */=0A=
>   	if (!hsotg->bus_suspended) {=0A=
>   		hprt0 =3D dwc2_read_hprt0(hsotg);=0A=
> -		hprt0 |=3D HPRT0_SUSP;=0A=
> -		hprt0 &=3D ~HPRT0_PWR;=0A=
> -		dwc2_writel(hsotg, hprt0, HPRT0);=0A=
> -		spin_unlock_irqrestore(&hsotg->lock, flags);=0A=
> -		dwc2_vbus_supply_exit(hsotg);=0A=
> -		spin_lock_irqsave(&hsotg->lock, flags);=0A=
> +		if (hprt0 & HPRT0_CONNSTS) { > +			hprt0 |=3D HPRT0_SUSP;=0A=
Here you set "HPRT0_SUSP" bit but what if core doesn't support both =0A=
hibernation and Partial Power down assuming that =0A=
hsotg->params.power_down" value us equal to "DWC2_POWER_DOWN_PARAM_NONE" =
=0A=
which is 0.=0A=
> +			if (hsotg->params.power_down =3D=3D DWC2_POWER_DOWN_PARAM_PARTIAL)=0A=
You make one checking of hsotg->params.power_down mode here.=0A=
> +				hprt0 &=3D ~HPRT0_PWR;=0A=
> +			dwc2_writel(hsotg, hprt0, HPRT0);=0A=
> +		}=0A=
> +		if (hsotg->params.power_down =3D=3D DWC2_POWER_DOWN_PARAM_PARTIAL) {=
=0A=
another checking of power_down mode here.=0A=
> +			spin_unlock_irqrestore(&hsotg->lock, flags);=0A=
> +			dwc2_vbus_supply_exit(hsotg);=0A=
> +			spin_lock_irqsave(&hsotg->lock, flags);=0A=
> +		} else {=0A=
> +			pcgctl =3D readl(hsotg->regs + PCGCTL);=0A=
> +			pcgctl |=3D PCGCTL_STOPPCLK;=0A=
> +			writel(pcgctl, hsotg->regs + PCGCTL);=0A=
"PCGCTL_STOPPCLK" bit is set only when core enters to partial power =0A=
down. So here if hsotg->params.power_down is not equal to =0A=
DWC2_POWER_DOWN_PARAM_PARTIAL and is DWC2_POWER_DOWN_PARAM_NONE the the =0A=
bit will be set.=0A=
> +		}=0A=
>   	}=0A=
>   =0A=
> -	/* Enter partial_power_down */=0A=
> -	ret =3D dwc2_enter_partial_power_down(hsotg);=0A=
> -	if (ret) {=0A=
> -		if (ret !=3D -ENOTSUPP)=0A=
> -			dev_err(hsotg->dev,=0A=
> -				"enter partial_power_down failed\n");=0A=
> -		goto skip_power_saving;=0A=
> +	if (hsotg->params.power_down =3D=3D DWC2_POWER_DOWN_PARAM_PARTIAL) {=0A=
one more power_down mode checking here.=0A=
I understand that those checking are to make sure that we got partial =0A=
power down mode enabled but before this patch it was done with one checking=
.=0A=
> +		/* Enter partial_power_down */=0A=
> +		ret =3D dwc2_enter_partial_power_down(hsotg);=0A=
> +		if (ret) {=0A=
> +			if (ret !=3D -ENOTSUPP)=0A=
> +				dev_err(hsotg->dev,=0A=
> +					"enter partial_power_down failed\n");=0A=
> +			goto skip_power_saving;=0A=
> +		}=0A=
> +=0A=
> +		/* After entering partial_power_down, hardware is no more accessible *=
/=0A=
> +		clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);=0A=
>   	}=0A=
>   =0A=
>   	/* Ask phy to be suspended */=0A=
> @@ -4530,9 +4545,6 @@ static int _dwc2_hcd_suspend(struct usb_hcd *hcd)=
=0A=
>   		spin_lock_irqsave(&hsotg->lock, flags);=0A=
>   	}=0A=
>   =0A=
> -	/* After entering partial_power_down, hardware is no more accessible */=
=0A=
> -	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);=0A=
> -=0A=
>   skip_power_saving:=0A=
>   	hsotg->lx_state =3D DWC2_L2;=0A=
>   unlock:=0A=
> @@ -4545,6 +4557,7 @@ static int _dwc2_hcd_resume(struct usb_hcd *hcd)=0A=
>   {=0A=
>   	struct dwc2_hsotg *hsotg =3D dwc2_hcd_to_hsotg(hcd);=0A=
>   	unsigned long flags;=0A=
> +	u32 pcgctl;=0A=
>   	int ret =3D 0;=0A=
>   =0A=
>   	spin_lock_irqsave(&hsotg->lock, flags);=0A=
> @@ -4555,17 +4568,11 @@ static int _dwc2_hcd_resume(struct usb_hcd *hcd)=
=0A=
>   	if (hsotg->lx_state !=3D DWC2_L2)=0A=
>   		goto unlock;=0A=
>   =0A=
> -	if (hsotg->params.power_down !=3D DWC2_POWER_DOWN_PARAM_PARTIAL) {=0A=
> +	if (hsotg->params.power_down > DWC2_POWER_DOWN_PARAM_PARTIAL) {=0A=
>   		hsotg->lx_state =3D DWC2_L0;=0A=
>   		goto unlock;=0A=
>   	}=0A=
>   =0A=
> -	/*=0A=
> -	 * Set HW accessible bit before powering on the controller=0A=
> -	 * since an interrupt may rise.=0A=
> -	 */=0A=
> -	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);=0A=
> -=0A=
>   	/*=0A=
>   	 * Enable power if not already done.=0A=
>   	 * This must not be spinlocked since duration=0A=
> @@ -4577,10 +4584,23 @@ static int _dwc2_hcd_resume(struct usb_hcd *hcd)=
=0A=
>   		spin_lock_irqsave(&hsotg->lock, flags);=0A=
>   	}=0A=
>   =0A=
> -	/* Exit partial_power_down */=0A=
> -	ret =3D dwc2_exit_partial_power_down(hsotg, true);=0A=
> -	if (ret && (ret !=3D -ENOTSUPP))=0A=
> -		dev_err(hsotg->dev, "exit partial_power_down failed\n");=0A=
> +	if (hsotg->params.power_down =3D=3D DWC2_POWER_DOWN_PARAM_PARTIAL) {=0A=
> +		/*=0A=
> +		 * Set HW accessible bit before powering on the controller=0A=
> +		 * since an interrupt may rise.=0A=
> +		 */=0A=
> +		set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);=0A=
> +=0A=
> +=0A=
you leave an odd blank line here.  Please delete it.=0A=
> +		/* Exit partial_power_down */=0A=
> +		ret =3D dwc2_exit_partial_power_down(hsotg, true);=0A=
> +		if (ret && (ret !=3D -ENOTSUPP))=0A=
> +			dev_err(hsotg->dev, "exit partial_power_down failed\n");=0A=
> +	} else {=0A=
> +		pcgctl =3D readl(hsotg->regs + PCGCTL);=0A=
> +		pcgctl &=3D ~PCGCTL_STOPPCLK;=0A=
> +		writel(pcgctl, hsotg->regs + PCGCTL);=0A=
=0A=
Here if core doesn't support both hibernation and partial power down =0A=
and "hsotg->params.power_down" is equal to "DWC2_POWER_DOWN_PARAM_NONE" =0A=
which is 0 then "PCGCTL_STOPPCLK" bit is unset.=0A=
=0A=
> +	}=0A=
>   =0A=
>   	hsotg->lx_state =3D DWC2_L0;=0A=
>   =0A=
> @@ -4592,10 +4612,12 @@ static int _dwc2_hcd_resume(struct usb_hcd *hcd)=
=0A=
>   		spin_unlock_irqrestore(&hsotg->lock, flags);=0A=
>   		dwc2_port_resume(hsotg);=0A=
>   	} else {=0A=
> -		dwc2_vbus_supply_init(hsotg);=0A=
> +		if (hsotg->params.power_down =3D=3D DWC2_POWER_DOWN_PARAM_PARTIAL) {=
=0A=
> +			dwc2_vbus_supply_init(hsotg);=0A=
>   =0A=
> -		/* Wait for controller to correctly update D+/D- level */=0A=
> -		usleep_range(3000, 5000);=0A=
> +			/* Wait for controller to correctly update D+/D- level */=0A=
> +			usleep_range(3000, 5000);=0A=
> +		}=0A=
>   =0A=
>   		/*=0A=
>   		 * Clear Port Enable and Port Status changes.=0A=
> =0A=
=0A=
I have tested the patch on HAPS-DX. With this patch or without it when I =
=0A=
have a device connected core  enters to partial power down and doesn't =0A=
exit from it. So I cannot use the device.=0A=
=0A=
-- =0A=
Regards,=0A=
Artur=0A=
