Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C03C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CC52087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dCEEATTn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="STTkZKmC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfECIUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:20:17 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:44434 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725793AbfECIUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:20:16 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4ACE4C0159;
        Fri,  3 May 2019 08:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1556871612; bh=ev67Stj8Ed6IH7ye+6gIzDKkiT6vgQ7ftgweF+BDnNc=;
        h=From:To:CC:Subject:Date:References:From;
        b=dCEEATTn3JgBqd9Sf4DNufaAaejA5dqOb3lRFq2AtplazchpExGQy/pOdKNxj41n0
         72WIjyIwpatbOM8A0LVfv9YRQ1rLtgQC8crwBiV/fdSS3V2uAcZQVgsY/T36+6oq5y
         BOI5N/aY4ctAcjcVVUKd9UVu3YaK3VNG2ulO+6M4yLJMkelLknUAQE5gacGjJs5p2R
         fOhDHgON/4hi5wk2l6HfkMrBs6AHqV/8JuK5xLO7TrRX13g98+gsMCGv0GMiwxxaoG
         a9A2DPy6CGYat2jyPUP1StPu8sukW4VKzGlbd4GIBhOEc4wDgC1osX1BvW6p9QCbTa
         /QLDLSvIE7vBQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 28813A005D;
        Fri,  3 May 2019 08:20:11 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 3 May 2019 01:20:11 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 3 May 2019 01:20:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzOqCEoi/RMSfvrSTXJ0eRwO8LREf+nR0SENYAUxBVw=;
 b=STTkZKmC2EaUwtk2LnupenYQ1y8juDrEzji1glMkzFiqMwSUh4ppPQJ19cTznbbYclRAnLto75MWeCr02O5ZeEO10vxQk18zGhTZifzC+NWHioe+h6EPdhcqATuXcxBuilvRTawaWN/Nrh5A22XvZDzU0inlURc27NXXnWxrHcY=
Received: from SN1PR12MB2431.namprd12.prod.outlook.com (52.132.195.146) by
 SN1PR12MB2509.namprd12.prod.outlook.com (52.132.196.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Fri, 3 May 2019 08:20:09 +0000
Received: from SN1PR12MB2431.namprd12.prod.outlook.com
 ([fe80::1982:4b45:2adf:9a1f]) by SN1PR12MB2431.namprd12.prod.outlook.com
 ([fe80::1982:4b45:2adf:9a1f%4]) with mapi id 15.20.1856.012; Fri, 3 May 2019
 08:20:09 +0000
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
Date:   Fri, 3 May 2019 08:20:09 +0000
Message-ID: <SN1PR12MB243156982D5BD74F11680597A7350@SN1PR12MB2431.namprd12.prod.outlook.com>
References: <20190418001356.124334-1-dianders@chromium.org>
 <20190418001356.124334-2-dianders@chromium.org>
 <SN1PR12MB243108D1EF3239EC4F730ACDA7390@SN1PR12MB2431.namprd12.prod.outlook.com>
 <CAD=FV=UOmfNeuZPrDcZRdwAkF4yRifCpBGUuZTsmmz0UVEZ+yA@mail.gmail.com>
 <SN1PR12MB24317F315C5A4DFE70F9CB0DA73A0@SN1PR12MB2431.namprd12.prod.outlook.com>
 <CAD=FV=UWGOWiCpy5qUY8oFHPyxdYJe7OsdWBDuCNcXBu5BJoGA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arturp@synopsys.com; 
x-originating-ip: [84.53.141.186]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7cb46ea9-9584-441e-b4cb-08d6cfa02804
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:SN1PR12MB2509;
x-ms-traffictypediagnostic: SN1PR12MB2509:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <SN1PR12MB25097AEF3FF18589CEF1D033A7350@SN1PR12MB2509.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(39850400004)(366004)(376002)(55674003)(199004)(189003)(102836004)(26005)(55016002)(9686003)(53546011)(6436002)(229853002)(6306002)(68736007)(966005)(476003)(6506007)(81156014)(81166006)(4326008)(446003)(8676002)(74316002)(7416002)(7736002)(305945005)(6916009)(486006)(25786009)(86362001)(99286004)(186003)(53936002)(8936002)(73956011)(66066001)(6116002)(3846002)(6246003)(478600001)(5660300002)(66556008)(256004)(14444005)(316002)(33656002)(66476007)(66446008)(14454004)(66946007)(76116006)(91956017)(71190400001)(2906002)(15650500001)(71200400001)(52536014)(54906003)(7696005)(64756008)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR12MB2509;H:SN1PR12MB2431.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pRi0aiEbfO5wqX2cwvLLp/ax4KrsZ2HypcXfe8VVnzHrBJrjRiFmCu5lJjz1RqFinGurabwHfrkZP1cj7LUjcIGNI3eT3waYMu5Awp8oFw87j4b5B05xyyuKTPjvn/lf+FaVQmPr2EhUILzP8BGK8NY8B7oGFkse/viA0ZVtt8V1TeMXVbTJ3MQXq+jJarIv5KYuDrFL7fMMEnYhhcNqFo5Pw1rUU+Rofk4f0CuxJSd/Jtw+29yMf85BabaFRKrTKq9pimXqD/t6rDovZn7P+qfZsIsag0mbAnlcgkMtimjZUg6H1cDacxZ55998OgMUwzxOsVJL0vBghYziUKXpnu9oHwIcEqL3F82ti9gBToPbVgLMIs/KbVjSk9wpFjgiCDahQZTzZPOyC4/14h/py0G4mnWo+DJve7GREqynuqc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb46ea9-9584-441e-b4cb-08d6cfa02804
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 08:20:09.0886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2509
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/2019 05:57, Doug Anderson wrote:=0A=
> Hi,=0A=
> =0A=
> On Mon, Apr 29, 2019 at 11:06 PM Artur Petrosyan=0A=
> <Arthur.Petrosyan@synopsys.com> wrote:=0A=
>>=0A=
>> Hi,=0A=
>>=0A=
>> On 4/29/2019 21:34, Doug Anderson wrote:=0A=
>>> Hi,=0A=
>>>=0A=
>>> On Mon, Apr 29, 2019 at 1:43 AM Artur Petrosyan=0A=
>>> <Arthur.Petrosyan@synopsys.com> wrote:=0A=
>>>>=0A=
>>>> Hi,=0A=
>>>>=0A=
>>>> On 4/18/2019 04:15, Douglas Anderson wrote:=0A=
>>>>> This is an attempt to rehash commit 0cf884e819e0 ("usb: dwc2: add bus=
=0A=
>>>>> suspend/resume for dwc2") on ToT.  That commit was reverted in commit=
=0A=
>>>>> b0bb9bb6ce01 ("Revert "usb: dwc2: add bus suspend/resume for dwc2"")=
=0A=
>>>>> because apparently it broke the Altera SOCFPGA.=0A=
>>>>>=0A=
>>>>> With all the changes that have happened to dwc2 in the meantime, it's=
=0A=
>>>>> possible that the Altera SOCFPGA will just magically work with this=
=0A=
>>>>> change now.  ...and it would be good to get bus suspend/resume=0A=
>>>>> implemented.=0A=
>>>>>=0A=
>>>>> This change is a forward port of one that's been living in the Chrome=
=0A=
>>>>> OS 3.14 kernel tree.=0A=
>>>>>=0A=
>>>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>=0A=
>>>>> ---=0A=
>>>>> This patch was last posted at:=0A=
>>>>>=0A=
>>>>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.kernel.or=
g_r_1446237173-2D15263-2D1-2Dgit-2Dsend-2Demail-2Ddianders-40chromium.org&d=
=3DDwIDAg&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_HlVzYqr=
C_D7niMJI&m=3DMMfe-4lZePyty6F5zfQ54kiYGuJWNulyRat944LkOsc&s=3DnExFpAPP_0plZ=
fO5LMG1B-mqt1vyCvE35elVcyVgs8Y&e=3D=0A=
>>>>>=0A=
>>>>> ...and appears to have died the death of silence.  Maybe it could get=
=0A=
>>>>> some bake time in linuxnext if we can't find any proactive testing?=
=0A=
>>>>>=0A=
>>>>> I will also freely admit that I don't know tons about the theory=0A=
>>>>> behind this patch.  I'm mostly just re-hashing the original commit=0A=
>>>>> from Kever that was reverted since:=0A=
>>>>> * Turning on partial power down on rk3288 doesn't "just work".  I=0A=
>>>>>      don't get hotplug events.  This is despite dwc2 auto-detecting t=
hat=0A=
>>>>>      we are power optimized.=0A=
>>>> What do you mean by doesn't "just work" ? It seem to me that even afte=
r=0A=
>>>> adding this patch you don't get issues fixed.=0A=
>>>> You mention that you don't get the hotplug events. Please provide dwc2=
=0A=
>>>> debug logs and register dumps on this issue.=0A=
>>>=0A=
>>> I mean that partial power down in the currently upstream driver=0A=
>>> doesn't work.  AKA: if I turn on partial power down in the upstream=0A=
>>> driver then hotplug events break.  I can try to provide some logs.  On=
=0A=
>>> what exact version of the code do you want logs?  Just your series?=0A=
>>> Just my series?  Mainline?  Some attempt at combining both series?  As=
=0A=
>>> I said things seem to sorta work with the combined series.  I can try=
=0A=
>>> to clarify if that's the series you want me to test with.  ...or I can=
=0A=
>>> wait for your next version?=0A=
>> As I said this patch doesn't fix the issue with hotplug. With this patch=
=0A=
>> or without the hotplug behaves as it was. I have tested it on our setup.=
=0A=
>>=0A=
>> Have you debugged your patch? Does it make any difference on your setup=
=0A=
>> ? Does it fix the issue with hotplug?=0A=
> =0A=
> I think we're still not taking on the same page.=0A=
> =0A=
> My patch makes no attempt to make partial power down mode work.  My=0A=
> patch attempts to make things work a little better when using=0A=
> DWC2_POWER_DOWN_PARAM_NONE.  There is no use testing my patch with=0A=
> partial power down as it shouldn't have any impact there.=0A=
> =0A=
> =0A=
>>> I am by no means an expert on dwc2, but an assumption made in my patch=
=0A=
>>> is that even cores that can't support partial power down can still=0A=
>>> save some amount of power when hcd_suspend is called.=0A=
>> Have you tried to debug dwc2 with power_down =3D=3D DWC2_POWER_DOWN_PARA=
M_NONE ?=0A=
>>>=0A=
>>> Some evidence that this should be possible: looking at mainline Linux=
=0A=
>>> and at dwc2_port_suspend(), I see:=0A=
>>>=0A=
>>> * It is currently called even when we have DWC2_POWER_DOWN_PARAM_NONE=
=0A=
>> Currently (without your and my patches) (looking at mainline Linux) the=
=0A=
>> function dwc2_port_suspend() is called anyway because its call is issued=
=0A=
>> by the system. But it performs entering to suspend only in case of=0A=
>> DWC2_POWER_DOWN_PARAM_PARTIAL.=0A=
>>=0A=
>> This is not an assumption. What I am pointing out is based on debugging=
=0A=
>> and before making assumptions without debugging for me seems not ok.=0A=
>>=0A=
>> Currently without your patch and without my patches. In the=0A=
>> dwc2_port_suspend() it will enter to suspend only in case that=0A=
>> power_down =3D=3D DWC2_POWER_DOWN_PARAM_PARTIAL. Because if you look at =
the=0A=
>> code more carefully you will see=0A=
>>=0A=
>>          if (hsotg->params.power_down !=3D DWC2_POWER_DOWN_PARAM_PARTIAL=
)=0A=
>>                  goto skip_power_saving;=0A=
>>=0A=
>> This says if power_down is not DWC2_POWER_DOWN_PARAM_PARTIAL then skip=
=0A=
>> power saving.=0A=
>>=0A=
>> So but after your patch. If power_down is DWC2_POWER_DOWN_PARAM_NONE it=
=0A=
>> tries to suspend.=0A=
> =0A=
> We must be looking at different code.  I'm looking at Linux's tree, AKA:=
=0A=
> =0A=
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_pub=
_scm_linux_kernel_git_torvalds_linux.git_tree_drivers_usb_dwc2_hcd.c-23n348=
8&d=3DDwIFaQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_HlVz=
YqrC_D7niMJI&m=3DIWkDOOGTr0q-H1piDv2KOZe_Hnrz18g6rXFx-DsTuv4&s=3DAHu2iOKkyb=
liRGtIfN7cF5p070UdvUKTYJsyAKYojis&e=3D=0A=
Here you are looking at the old code. After that there are several of =0A=
changes related to suspend/resume functions.=0A=
=0A=
This is the link to the code with changes. Latest version of those =0A=
functions.=0A=
=0A=
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/usb/dwc2/hcd.c#n4489=0A=
=0A=
Your changes are sitting on that latest version of code. Not the old =0A=
version of it.=0A=
=0A=
> =0A=
> I took a mainline kernel ("v5.1-rc7-5-g83a50840e72a") and added=0A=
> printouts in dwc2_port_suspend() next to where it set HPRT0_SUSP and=0A=
> PCGCTL_STOPPCLK in dwc2_port_suspend().=0A=
I think you did this tests on the old version of the code=0A=
=0A=
I have tested the flow myself with the mainline Kernel on =0A=
"torvalds/master" and not HPRT0_SUSP nor PCGCTL_STOPPCLK are not being set.=
=0A=
=0A=
So here you need to review those things again.=0A=
=0A=
> =0A=
> [  454.906364] dwc2 ff540000.usb: I'm setting HPRT0_SUSP=0A=
> [  454.906367] dwc2 ff540000.usb: I'm setting PCGCTL_STOPPCLK=0A=
> =0A=
> ...and just to confirm:=0A=
> =0A=
> # grep '^power' /sys/kernel/debug/*.usb/params=0A=
> /sys/kernel/debug/ff540000.usb/params:power_down                    : 0=
=0A=
> /sys/kernel/debug/ff580000.usb/params:power_down                    : 0=
=0A=
> =0A=
> So I'm really quite convinced that on mainline Linux with=0A=
> DWC2_POWER_DOWN_PARAM_NONE that dwc2_port_suspend() sets HPRT0_SUSP=0A=
> and PCGCTL_STOPPCLK.=0A=
> =0A=
> =0A=
>>> ...I believe that the net effect of my patch ends up doing both those=
=0A=
>>> same two things in hcd_suspend.  That is: when power_down is=0A=
>>> DWC2_POWER_DOWN_PARAM_NONE I believe my patch is really just doing the=
=0A=
>>> same thing that dwc2_port_suspend() would do in the same case.  Is=0A=
>>> that not OK?=0A=
>> No if your patch is doing the same thing as it was doing before what is=
=0A=
>> the purpose of the patch ?=0A=
> =0A=
> The purpose is to make _dwc2_hcd_suspend() work more correctly in the=0A=
> case where power_down is DWC2_POWER_DOWN_PARAM_NONE >=0A=
> =0A=
>> My testes show that your patch doesn't fix the issue related partial=0A=
>> power down.=0A=
> =0A=
> Right.  I have been trying to say that my patch doesn't do anything at=0A=
> all for partial power down.  I am simply trying to make=0A=
> DWC2_POWER_DOWN_PARAM_NONE work more correctly.=0A=
> =0A=
> I haven't run all the power consumption tests in quite a long time and=0A=
> I'll try to get it hooked up tomorrow to confirm that my patch really=0A=
> truly is still needed to help with power consumption.  I did confirm=0A=
> that at least there are cases where _dwc2_hcd_suspend() is called and=0A=
> my patch is what sets the important bits.=0A=
> =0A=
> -Doug=0A=
> =0A=
=0A=
=0A=
-- =0A=
Regards,=0A=
Artur=0A=
