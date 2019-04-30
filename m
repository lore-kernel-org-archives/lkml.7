Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DD0C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 06:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0151821670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 06:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LCjBUga8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="P8AWQTB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfD3GGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 02:06:32 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:52768 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725554AbfD3GGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 02:06:31 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B653BC004D;
        Tue, 30 Apr 2019 06:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1556604391; bh=v57Lc5qEJQEbqpWZJHgfBy/s9g8JdJin+UyR2xA0EN0=;
        h=From:To:CC:Subject:Date:References:From;
        b=LCjBUga8v8p65eOzBIjWCKN4mcfw33iN4gYQIE1wwWB4YcxCpNOlqJeKXqAB4BRx5
         JONvO5DlREB//bkGmvwJhFNiNR/05bfCIzQgQigs0iBFHoT9Y/qSR5lqpKnnF6OuNL
         SjAArA7OxvQx+xw8lLDCAJKzyG6+MQZCc1HNZNX7s53/ePBGviubSairZ1IX2EE/6M
         2hdVnqcWi13cBhPgRbixC+DHF5KVGhsdllfn8DFzj8eb175+SL40C3gb7j82ikPWOs
         10RHB/19mJCSkvJbsPPZRthARBKIx5raRqJmIyTzU9VHHIzPve6w5HPsp5XaAZ+r4m
         U70Omwp6IeqHg==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 95402A0067;
        Tue, 30 Apr 2019 06:06:25 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 29 Apr 2019 23:05:27 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 29 Apr 2019 23:05:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0U4FQ17djSGy5iqZxiL6Sgpa131uidFWQrZIhQwFKUg=;
 b=P8AWQTB/Tnirc9JTvlE3v3rNt3oyt/Rjem62WcyX+pcJZskYefTmzsx+J50Se4IuxL/Pd4RkAnV7D5rgmAqXBy26tPMqi8gDyEFPw5qNz0rnxYCqJUSTboOsDkjD7ejQQ0vUuKfmEBAsytoH40IvbLeC/Ubgoo4bLo7w9AeS/nw=
Received: from SN1PR12MB2431.namprd12.prod.outlook.com (52.132.195.146) by
 SN1PR12MB0717.namprd12.prod.outlook.com (10.163.209.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Tue, 30 Apr 2019 06:05:21 +0000
Received: from SN1PR12MB2431.namprd12.prod.outlook.com
 ([fe80::1982:4b45:2adf:9a1f]) by SN1PR12MB2431.namprd12.prod.outlook.com
 ([fe80::1982:4b45:2adf:9a1f%4]) with mapi id 15.20.1835.010; Tue, 30 Apr 2019
 06:05:21 +0000
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
To:     Doug Anderson <dianders@chromium.org>
CC:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "Alan Stern" <stern@rowland.harvard.edu>,
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
Date:   Tue, 30 Apr 2019 06:05:21 +0000
Message-ID: <SN1PR12MB24317F315C5A4DFE70F9CB0DA73A0@SN1PR12MB2431.namprd12.prod.outlook.com>
References: <20190418001356.124334-1-dianders@chromium.org>
 <20190418001356.124334-2-dianders@chromium.org>
 <SN1PR12MB243108D1EF3239EC4F730ACDA7390@SN1PR12MB2431.namprd12.prod.outlook.com>
 <CAD=FV=UOmfNeuZPrDcZRdwAkF4yRifCpBGUuZTsmmz0UVEZ+yA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arturp@synopsys.com; 
x-originating-ip: [84.53.141.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d285ef8-4bc7-4bde-de41-08d6cd31d457
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:SN1PR12MB0717;
x-ms-traffictypediagnostic: SN1PR12MB0717:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN1PR12MB071732B43D42CB23DFEF7069A73A0@SN1PR12MB0717.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(136003)(376002)(39850400004)(189003)(199004)(55674003)(5660300002)(52536014)(478600001)(8936002)(66066001)(68736007)(102836004)(14444005)(8676002)(81166006)(81156014)(256004)(76176011)(229853002)(7696005)(6916009)(316002)(54906003)(99286004)(53546011)(6506007)(71200400001)(71190400001)(55016002)(6436002)(15650500001)(4326008)(6306002)(9686003)(6246003)(25786009)(53936002)(97736004)(26005)(93886005)(476003)(14454004)(446003)(186003)(486006)(33656002)(74316002)(64756008)(66556008)(66946007)(66476007)(91956017)(66446008)(305945005)(966005)(7416002)(76116006)(6116002)(73956011)(86362001)(7736002)(3846002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR12MB0717;H:SN1PR12MB2431.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Y0slcSJZsQUBb35x3QxOCUjT2bTnz00Fwkud7cq9I1u59UiBHedG1NGg2CxDP5V10Pqh1J+ML2+oe1JTdoFrVS0LQsU4BImb659h1Kn/z0+I7Bg2YEyLdoxxFkDFG1NXxJI5US+BHfZdx6gykFU0IViO9x1Y3oAH3Ly7I5dukHGtlRVbaYJa9QjlB2j6MOkjoPQbmk71GK9j7wiVaaZVrEh/wI8khYg3v4Oqnj43r4wEbgsQRd9kJUZ0XTIDkcTNTnBKpUo7j8K6r5aR4lxOZGbWZiQEbDHEtJbIs1pGROR4cX0cYocUaRk8pHmUDfCNu0jF62TXQkDb+iH0AZ8DsZmYozh8OJvx0Xn3q+imw86OEOVbIM6v6nsgyo97k5wu+4hwfkTd26Gqq822ljz7xbqjKouLmBz3j2C1ylvrRQI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d285ef8-4bc7-4bde-de41-08d6cd31d457
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 06:05:21.8203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0717
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=0A=
=0A=
On 4/29/2019 21:34, Doug Anderson wrote:=0A=
> Hi,=0A=
> =0A=
> On Mon, Apr 29, 2019 at 1:43 AM Artur Petrosyan=0A=
> <Arthur.Petrosyan@synopsys.com> wrote:=0A=
>>=0A=
>> Hi,=0A=
>>=0A=
>> On 4/18/2019 04:15, Douglas Anderson wrote:=0A=
>>> This is an attempt to rehash commit 0cf884e819e0 ("usb: dwc2: add bus=
=0A=
>>> suspend/resume for dwc2") on ToT.  That commit was reverted in commit=
=0A=
>>> b0bb9bb6ce01 ("Revert "usb: dwc2: add bus suspend/resume for dwc2"")=0A=
>>> because apparently it broke the Altera SOCFPGA.=0A=
>>>=0A=
>>> With all the changes that have happened to dwc2 in the meantime, it's=
=0A=
>>> possible that the Altera SOCFPGA will just magically work with this=0A=
>>> change now.  ...and it would be good to get bus suspend/resume=0A=
>>> implemented.=0A=
>>>=0A=
>>> This change is a forward port of one that's been living in the Chrome=
=0A=
>>> OS 3.14 kernel tree.=0A=
>>>=0A=
>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>=0A=
>>> ---=0A=
>>> This patch was last posted at:=0A=
>>>=0A=
>>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.kernel.org_=
r_1446237173-2D15263-2D1-2Dgit-2Dsend-2Demail-2Ddianders-40chromium.org&d=
=3DDwIDAg&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_HlVzYqr=
C_D7niMJI&m=3DMMfe-4lZePyty6F5zfQ54kiYGuJWNulyRat944LkOsc&s=3DnExFpAPP_0plZ=
fO5LMG1B-mqt1vyCvE35elVcyVgs8Y&e=3D=0A=
>>>=0A=
>>> ...and appears to have died the death of silence.  Maybe it could get=
=0A=
>>> some bake time in linuxnext if we can't find any proactive testing?=0A=
>>>=0A=
>>> I will also freely admit that I don't know tons about the theory=0A=
>>> behind this patch.  I'm mostly just re-hashing the original commit=0A=
>>> from Kever that was reverted since:=0A=
>>> * Turning on partial power down on rk3288 doesn't "just work".  I=0A=
>>>     don't get hotplug events.  This is despite dwc2 auto-detecting that=
=0A=
>>>     we are power optimized.=0A=
>> What do you mean by doesn't "just work" ? It seem to me that even after=
=0A=
>> adding this patch you don't get issues fixed.=0A=
>> You mention that you don't get the hotplug events. Please provide dwc2=
=0A=
>> debug logs and register dumps on this issue.=0A=
> =0A=
> I mean that partial power down in the currently upstream driver=0A=
> doesn't work.  AKA: if I turn on partial power down in the upstream=0A=
> driver then hotplug events break.  I can try to provide some logs.  On=0A=
> what exact version of the code do you want logs?  Just your series?=0A=
> Just my series?  Mainline?  Some attempt at combining both series?  As=0A=
> I said things seem to sorta work with the combined series.  I can try=0A=
> to clarify if that's the series you want me to test with.  ...or I can=0A=
> wait for your next version?=0A=
As I said this patch doesn't fix the issue with hotplug. With this patch =
=0A=
or without the hotplug behaves as it was. I have tested it on our setup.=0A=
=0A=
Have you debugged your patch? Does it make any difference on your setup =0A=
? Does it fix the issue with hotplug?=0A=
=0A=
Try to debug with the following steps.=0A=
1. Debug code with just your patch. Capture the logs and provide. So =0A=
that I can see what is difference with your patch.=0A=
2. Debug only with my series and see if those issues with hotplug are =0A=
still there.=0A=
=0A=
=0A=
> =0A=
> =0A=
>>> @@ -4506,21 +4507,35 @@ static int _dwc2_hcd_suspend(struct usb_hcd *hc=
d)=0A=
>>>         */=0A=
>>>        if (!hsotg->bus_suspended) {=0A=
>>>                hprt0 =3D dwc2_read_hprt0(hsotg);=0A=
>>> -             hprt0 |=3D HPRT0_SUSP;=0A=
>>> -             hprt0 &=3D ~HPRT0_PWR;=0A=
>>> -             dwc2_writel(hsotg, hprt0, HPRT0);=0A=
>>> -             spin_unlock_irqrestore(&hsotg->lock, flags);=0A=
>>> -             dwc2_vbus_supply_exit(hsotg);=0A=
>>> -             spin_lock_irqsave(&hsotg->lock, flags);=0A=
>>> +             if (hprt0 & HPRT0_CONNSTS) { > +                        h=
prt0 |=3D HPRT0_SUSP;=0A=
>> Here you set "HPRT0_SUSP" bit but what if core doesn't support both=0A=
>> hibernation and Partial Power down assuming that=0A=
>> hsotg->params.power_down" value us equal to "DWC2_POWER_DOWN_PARAM_NONE"=
=0A=
>> which is 0.=0A=
> =0A=
> I am by no means an expert on dwc2, but an assumption made in my patch=0A=
> is that even cores that can't support partial power down can still=0A=
> save some amount of power when hcd_suspend is called.=0A=
Have you tried to debug dwc2 with power_down =3D=3D DWC2_POWER_DOWN_PARAM_N=
ONE ?=0A=
> =0A=
> Some evidence that this should be possible: looking at mainline Linux=0A=
> and at dwc2_port_suspend(), I see:=0A=
> =0A=
> * It is currently called even when we have DWC2_POWER_DOWN_PARAM_NONE=0A=
Currently (without your and my patches) (looking at mainline Linux) the =0A=
function dwc2_port_suspend() is called anyway because its call is issued =
=0A=
by the system. But it performs entering to suspend only in case of =0A=
DWC2_POWER_DOWN_PARAM_PARTIAL.=0A=
=0A=
This is not an assumption. What I am pointing out is based on debugging =0A=
and before making assumptions without debugging for me seems not ok.=0A=
=0A=
Currently without your patch and without my patches. In the =0A=
dwc2_port_suspend() it will enter to suspend only in case that =0A=
power_down =3D=3D DWC2_POWER_DOWN_PARAM_PARTIAL. Because if you look at the=
 =0A=
code more carefully you will see=0A=
=0A=
  	if (hsotg->params.power_down !=3D DWC2_POWER_DOWN_PARAM_PARTIAL)=0A=
		goto skip_power_saving;=0A=
=0A=
This says if power_down is not DWC2_POWER_DOWN_PARAM_PARTIAL then skip =0A=
power saving.=0A=
=0A=
So but after your patch. If power_down is DWC2_POWER_DOWN_PARAM_NONE it =0A=
tries to suspend.=0A=
=0A=
=0A=
> =0A=
> * It currently sets HPRT0_SUSP=0A=
> =0A=
> * It currently sets PCGCTL_STOPPCLK specifically in the case where=0A=
> power down is DWC2_POWER_DOWN_PARAM_NONE.=0A=
It currently (without my and your patches) doesn't set PCGCTL_STOPPCLK =0A=
when power down is DWC2_POWER_DOWN_PARAM_NONE. Because again and again =0A=
when power down is DWC2_POWER_DOWN_PARAM_NONE power saving is skipped.=0A=
=0A=
=0A=
> =0A=
> ...I believe that the net effect of my patch ends up doing both those=0A=
> same two things in hcd_suspend.  That is: when power_down is=0A=
> DWC2_POWER_DOWN_PARAM_NONE I believe my patch is really just doing the=0A=
> same thing that dwc2_port_suspend() would do in the same case.  Is=0A=
> that not OK?=0A=
No if your patch is doing the same thing as it was doing before what is =0A=
the purpose of the patch ?=0A=
=0A=
My testes show that your patch doesn't fix the issue related partial =0A=
power down.=0A=
=0A=
> =0A=
> =0A=
> =0A=
>>> +                     if (hsotg->params.power_down =3D=3D DWC2_POWER_DO=
WN_PARAM_PARTIAL)=0A=
>> You make one checking of hsotg->params.power_down mode here.=0A=
>>> +                             hprt0 &=3D ~HPRT0_PWR;=0A=
>>> +                     dwc2_writel(hsotg, hprt0, HPRT0);=0A=
>>> +             }=0A=
>>> +             if (hsotg->params.power_down =3D=3D DWC2_POWER_DOWN_PARAM=
_PARTIAL) {=0A=
>> another checking of power_down mode here.=0A=
> =0A=
> Yeah, we can debate about how to best share/split code.  I'm not in=0A=
> love with the current structure either.  When I rebased your patches=0A=
> atop mine I changed this to more fully split them and I agree that was=0A=
> better.=0A=
> =0A=
> =0A=
>>> @@ -4592,10 +4612,12 @@ static int _dwc2_hcd_resume(struct usb_hcd *hcd=
)=0A=
>>>                spin_unlock_irqrestore(&hsotg->lock, flags);=0A=
>>>                dwc2_port_resume(hsotg);=0A=
>>>        } else {=0A=
>>> -             dwc2_vbus_supply_init(hsotg);=0A=
>>> +             if (hsotg->params.power_down =3D=3D DWC2_POWER_DOWN_PARAM=
_PARTIAL) {=0A=
>>> +                     dwc2_vbus_supply_init(hsotg);=0A=
>>>=0A=
>>> -             /* Wait for controller to correctly update D+/D- level */=
=0A=
>>> -             usleep_range(3000, 5000);=0A=
>>> +                     /* Wait for controller to correctly update D+/D- =
level */=0A=
>>> +                     usleep_range(3000, 5000);=0A=
>>> +             }=0A=
>>>=0A=
>>>                /*=0A=
>>>                 * Clear Port Enable and Port Status changes.=0A=
>>>=0A=
>>=0A=
>> I have tested the patch on HAPS-DX. With this patch or without it when I=
=0A=
>> have a device connected core  enters to partial power down and doesn't=
=0A=
>> exit from it. So I cannot use the device.=0A=
> =0A=
> Can you explain what HAPS-DX is?=0A=
It is the general setup to perform our use case testes.=0A=
For more information about the details you can google about it.=0A=
=0A=
> =0A=
> =0A=
> -Doug=0A=
> =0A=
=0A=
=0A=
-- =0A=
Regards,=0A=
Artur=0A=
