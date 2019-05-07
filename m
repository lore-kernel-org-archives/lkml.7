Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34F0C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD4420C01
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mSpBsPXK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="Vl/Cqw9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfEGH1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 03:27:09 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:32830 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726085AbfEGH1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 03:27:09 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 66812C0086;
        Tue,  7 May 2019 07:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557214031; bh=0z759RCJFMlZO7ucuET0Sajv1Xvygs1pUnrTfj2uEXI=;
        h=From:To:CC:Subject:Date:References:From;
        b=mSpBsPXKGKpdtVphGsQeGcygJRC91dtW/3yiisyGX/6lNYoH0ds5tEazuIMXx+geX
         fc9wTxQC6u8yrRydwng1seYq9VLAPOJ7sImqKi5L3wKtWMu6U/pnldbybWlfKQ4fbj
         JiD03lfJ5xIARkNWSxkNXc8MxhPfIUBwMaa7QBWOS67kn6SaSZJcR/3fIgzKoe6uk5
         1vm8+Mm/dopTjJQoZV+2ULvmmrkKZBVAx2qPs1ygY2ZyNLOxehCIvdooslKK+YyZmU
         HSHQ/bzD91LhD54RK+TShTPPqjGd/UvuUhAo/GZM+gyoZkzWhOvJlKQvvfs8Q/CYtY
         M0USXYzfA529Q==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2E651A006B;
        Tue,  7 May 2019 07:27:02 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 7 May 2019 00:27:02 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 7 May 2019 00:27:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EyqdiMu40WdTAdfOsw11FJ6b89u3ONbZBYkx4stZq8=;
 b=Vl/Cqw9GbD9J7E/kUL+uzKmIGyDfluisx6K6qfy/4bKHeZ8Om5leCpLP0SG2iMHLPz2Va0cRA25hyl9iWjbRsEuWZfuXT4zU831/tRlzNdpzxUIK4rqjBd38D62R32TMxYCY6DRXa2szC2ixhsLZKmtmzAkmAyDzVAVwg/CWAhY=
Received: from SN1PR12MB2431.namprd12.prod.outlook.com (52.132.195.146) by
 SN1PR12MB2590.namprd12.prod.outlook.com (52.132.199.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Tue, 7 May 2019 07:26:59 +0000
Received: from SN1PR12MB2431.namprd12.prod.outlook.com
 ([fe80::1982:4b45:2adf:9a1f]) by SN1PR12MB2431.namprd12.prod.outlook.com
 ([fe80::1982:4b45:2adf:9a1f%4]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 07:26:59 +0000
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
Date:   Tue, 7 May 2019 07:26:59 +0000
Message-ID: <SN1PR12MB2431A37C761DA0BAAEF45F30A7310@SN1PR12MB2431.namprd12.prod.outlook.com>
References: <20190418001356.124334-1-dianders@chromium.org>
 <20190418001356.124334-2-dianders@chromium.org>
 <SN1PR12MB243108D1EF3239EC4F730ACDA7390@SN1PR12MB2431.namprd12.prod.outlook.com>
 <CAD=FV=UOmfNeuZPrDcZRdwAkF4yRifCpBGUuZTsmmz0UVEZ+yA@mail.gmail.com>
 <SN1PR12MB24317F315C5A4DFE70F9CB0DA73A0@SN1PR12MB2431.namprd12.prod.outlook.com>
 <CAD=FV=UWGOWiCpy5qUY8oFHPyxdYJe7OsdWBDuCNcXBu5BJoGA@mail.gmail.com>
 <SN1PR12MB243156982D5BD74F11680597A7350@SN1PR12MB2431.namprd12.prod.outlook.com>
 <CAD=FV=XzsKe5n_ThcrByW79UznpkmHf0YNRNKH8G3eFtUSsYZQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arturp@synopsys.com; 
x-originating-ip: [23.62.99.241]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 693e1b90-6564-4fae-0a8c-08d6d2bd6478
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:SN1PR12MB2590;
x-ms-traffictypediagnostic: SN1PR12MB2590:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <SN1PR12MB259071AB1309B260C1430A1DA7310@SN1PR12MB2590.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:469;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(376002)(366004)(346002)(396003)(136003)(189003)(199004)(55674003)(316002)(25786009)(446003)(54906003)(73956011)(478600001)(99286004)(76176011)(53936002)(186003)(53546011)(6306002)(74316002)(486006)(26005)(476003)(6506007)(9686003)(55016002)(66946007)(66556008)(66066001)(76116006)(66446008)(66476007)(2906002)(64756008)(52536014)(86362001)(6116002)(3846002)(15650500001)(91956017)(14454004)(81156014)(71200400001)(71190400001)(7696005)(8676002)(966005)(8936002)(7736002)(305945005)(5660300002)(102836004)(68736007)(229853002)(6436002)(7416002)(4326008)(6246003)(6916009)(81166006)(33656002)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR12MB2590;H:SN1PR12MB2431.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k5Jcbfi3ZbTxddmApLu3MMfBr0TS2ygOiDmJh35hbSPqg63jRujseAuOZDiuWHuBy6e+kFZoN5mACXNCV8Fd+7Yp6S4mRQ15xRNMh/MM8Bw8WP/vSAsi401Dl8rmPpQvy2JDWwe5XUpaFNq6Y/KRs/kdLSeyfLb7/TcrNdQXVlzENgfa8cUcAbeeLdPbEhhdkQZnHvnvbVTi3xJ/wLhebzv0IMLWyyT7O3+ywUUhBmj8jhFQKkB+Y2/CcJ1OMo090S9TquPsVe01wRV97wC7xENt3cImCu0C8jqAgRuqm8qJ1QhtZjoW/uUFrP7HuDYco0Oq5J5oU40tWuJyPaHstMUrjCrdSdAOnAlfZUTBXFJZMVMNLH0geuwDVzUsdeBE8UI1j3E3HEVuNTA8/ZbCZAkeiTm9I7fuprK6VlcbxQ0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 693e1b90-6564-4fae-0a8c-08d6d2bd6478
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 07:26:59.5033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2590
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/2019 19:04, Doug Anderson wrote:=0A=
> Hi,=0A=
> =0A=
> On Fri, May 3, 2019 at 1:20 AM Artur Petrosyan=0A=
> <Arthur.Petrosyan@synopsys.com> wrote:=0A=
>>=0A=
>> On 5/1/2019 05:57, Doug Anderson wrote:=0A=
>>> Hi,=0A=
>>>=0A=
>>> On Mon, Apr 29, 2019 at 11:06 PM Artur Petrosyan=0A=
>>> <Arthur.Petrosyan@synopsys.com> wrote:=0A=
>>>>=0A=
>>>> Hi,=0A=
>>>>=0A=
>>>> On 4/29/2019 21:34, Doug Anderson wrote:=0A=
>>>>> Hi,=0A=
>>>>>=0A=
>>>>> On Mon, Apr 29, 2019 at 1:43 AM Artur Petrosyan=0A=
>>>>> <Arthur.Petrosyan@synopsys.com> wrote:=0A=
>>>>>>=0A=
>>>>>> Hi,=0A=
>>>>>>=0A=
>>>>>> On 4/18/2019 04:15, Douglas Anderson wrote:=0A=
>>>>>>> This is an attempt to rehash commit 0cf884e819e0 ("usb: dwc2: add b=
us=0A=
>>>>>>> suspend/resume for dwc2") on ToT.  That commit was reverted in comm=
it=0A=
>>>>>>> b0bb9bb6ce01 ("Revert "usb: dwc2: add bus suspend/resume for dwc2""=
)=0A=
>>>>>>> because apparently it broke the Altera SOCFPGA.=0A=
>>>>>>>=0A=
>>>>>>> With all the changes that have happened to dwc2 in the meantime, it=
's=0A=
>>>>>>> possible that the Altera SOCFPGA will just magically work with this=
=0A=
>>>>>>> change now.  ...and it would be good to get bus suspend/resume=0A=
>>>>>>> implemented.=0A=
>>>>>>>=0A=
>>>>>>> This change is a forward port of one that's been living in the Chro=
me=0A=
>>>>>>> OS 3.14 kernel tree.=0A=
>>>>>>>=0A=
>>>>>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>=0A=
>>>>>>> ---=0A=
>>>>>>> This patch was last posted at:=0A=
>>>>>>>=0A=
>>>>>>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.kernel.=
org_r_1446237173-2D15263-2D1-2Dgit-2Dsend-2Demail-2Ddianders-40chromium.org=
&d=3DDwIDAg&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_HlVzY=
qrC_D7niMJI&m=3DMMfe-4lZePyty6F5zfQ54kiYGuJWNulyRat944LkOsc&s=3DnExFpAPP_0p=
lZfO5LMG1B-mqt1vyCvE35elVcyVgs8Y&e=3D=0A=
>>>>>>>=0A=
>>>>>>> ...and appears to have died the death of silence.  Maybe it could g=
et=0A=
>>>>>>> some bake time in linuxnext if we can't find any proactive testing?=
=0A=
>>>>>>>=0A=
>>>>>>> I will also freely admit that I don't know tons about the theory=0A=
>>>>>>> behind this patch.  I'm mostly just re-hashing the original commit=
=0A=
>>>>>>> from Kever that was reverted since:=0A=
>>>>>>> * Turning on partial power down on rk3288 doesn't "just work".  I=
=0A=
>>>>>>>       don't get hotplug events.  This is despite dwc2 auto-detectin=
g that=0A=
>>>>>>>       we are power optimized.=0A=
>>>>>> What do you mean by doesn't "just work" ? It seem to me that even af=
ter=0A=
>>>>>> adding this patch you don't get issues fixed.=0A=
>>>>>> You mention that you don't get the hotplug events. Please provide dw=
c2=0A=
>>>>>> debug logs and register dumps on this issue.=0A=
>>>>>=0A=
>>>>> I mean that partial power down in the currently upstream driver=0A=
>>>>> doesn't work.  AKA: if I turn on partial power down in the upstream=
=0A=
>>>>> driver then hotplug events break.  I can try to provide some logs.  O=
n=0A=
>>>>> what exact version of the code do you want logs?  Just your series?=
=0A=
>>>>> Just my series?  Mainline?  Some attempt at combining both series?  A=
s=0A=
>>>>> I said things seem to sorta work with the combined series.  I can try=
=0A=
>>>>> to clarify if that's the series you want me to test with.  ...or I ca=
n=0A=
>>>>> wait for your next version?=0A=
>>>> As I said this patch doesn't fix the issue with hotplug. With this pat=
ch=0A=
>>>> or without the hotplug behaves as it was. I have tested it on our setu=
p.=0A=
>>>>=0A=
>>>> Have you debugged your patch? Does it make any difference on your setu=
p=0A=
>>>> ? Does it fix the issue with hotplug?=0A=
>>>=0A=
>>> I think we're still not taking on the same page.=0A=
>>>=0A=
>>> My patch makes no attempt to make partial power down mode work.  My=0A=
>>> patch attempts to make things work a little better when using=0A=
>>> DWC2_POWER_DOWN_PARAM_NONE.  There is no use testing my patch with=0A=
>>> partial power down as it shouldn't have any impact there.=0A=
>>>=0A=
>>>=0A=
>>>>> I am by no means an expert on dwc2, but an assumption made in my patc=
h=0A=
>>>>> is that even cores that can't support partial power down can still=0A=
>>>>> save some amount of power when hcd_suspend is called.=0A=
>>>> Have you tried to debug dwc2 with power_down =3D=3D DWC2_POWER_DOWN_PA=
RAM_NONE ?=0A=
>>>>>=0A=
>>>>> Some evidence that this should be possible: looking at mainline Linux=
=0A=
>>>>> and at dwc2_port_suspend(), I see:=0A=
>>>>>=0A=
>>>>> * It is currently called even when we have DWC2_POWER_DOWN_PARAM_NONE=
=0A=
>>>> Currently (without your and my patches) (looking at mainline Linux) th=
e=0A=
>>>> function dwc2_port_suspend() is called anyway because its call is issu=
ed=0A=
>>>> by the system. But it performs entering to suspend only in case of=0A=
>>>> DWC2_POWER_DOWN_PARAM_PARTIAL.=0A=
>>>>=0A=
>>>> This is not an assumption. What I am pointing out is based on debuggin=
g=0A=
>>>> and before making assumptions without debugging for me seems not ok.=
=0A=
>>>>=0A=
>>>> Currently without your patch and without my patches. In the=0A=
>>>> dwc2_port_suspend() it will enter to suspend only in case that=0A=
>>>> power_down =3D=3D DWC2_POWER_DOWN_PARAM_PARTIAL. Because if you look a=
t the=0A=
>>>> code more carefully you will see=0A=
>>>>=0A=
>>>>           if (hsotg->params.power_down !=3D DWC2_POWER_DOWN_PARAM_PART=
IAL)=0A=
>>>>                   goto skip_power_saving;=0A=
>>>>=0A=
>>>> This says if power_down is not DWC2_POWER_DOWN_PARAM_PARTIAL then skip=
=0A=
>>>> power saving.=0A=
>>>>=0A=
>>>> So but after your patch. If power_down is DWC2_POWER_DOWN_PARAM_NONE i=
t=0A=
>>>> tries to suspend.=0A=
>>>=0A=
>>> We must be looking at different code.  I'm looking at Linux's tree, AKA=
:=0A=
>>>=0A=
>>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_p=
ub_scm_linux_kernel_git_torvalds_linux.git_tree_drivers_usb_dwc2_hcd.c-23n3=
488&d=3DDwIFaQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_Hl=
VzYqrC_D7niMJI&m=3DIWkDOOGTr0q-H1piDv2KOZe_Hnrz18g6rXFx-DsTuv4&s=3DAHu2iOKk=
ybliRGtIfN7cF5p070UdvUKTYJsyAKYojis&e=3D=0A=
>> Here you are looking at the old code. After that there are several of=0A=
>> changes related to suspend/resume functions.=0A=
> =0A=
> In my email, see that I said I actually checked out mainline kernel=0A=
> (and I gave you the exact version: "v5.1-rc7-5-g83a50840e72a") and=0A=
> added printouts in dwc2_port_suspend() next to where it set HPRT0_SUSP=0A=
> and PCGCTL_STOPPCLK in dwc2_port_suspend().=0A=
I was talking about your patch which edits _dwc2_hcd_suspend() function.=0A=
What dwc2_port_suspend() implements for the hibernation or partial power =
=0A=
down I have not tested. It is a different implementation.=0A=
> =0A=
> [  454.906364] dwc2 ff540000.usb: I'm setting HPRT0_SUSP=0A=
> [  454.906367] dwc2 ff540000.usb: I'm setting PCGCTL_STOPPCLK=0A=
> =0A=
> The version "v5.1-rc7-5-g83a50840e72a" is not old code.=0A=
> =0A=
> =0A=
>> This is the link to the code with changes. Latest version of those=0A=
>> functions.=0A=
>>=0A=
>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_pu=
b_scm_linux_kernel_git_torvalds_linux.git_tree_drivers_usb_dwc2_hcd.c-23n44=
89&d=3DDwIFaQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_HlV=
zYqrC_D7niMJI&m=3D4lskGlSdN5lp0MXVy1SP0zxzFtbPMSUoQKQzLLmfoOg&s=3DA-ikUNQkl=
zouItTOQB078WrOiMcfCqgw8sBgLFwtyTU&e=3D=0A=
>>=0A=
>> Your changes are sitting on that latest version of code. Not the old=0A=
>> version of it.=0A=
> =0A=
> You are pointing me at _dwc2_hcd_suspend() whereas I pointed at=0A=
> dwc2_port_suspend().  Why?=0A=
Because your patch is editing _dwc2_hcd_suspend().=0A=
> =0A=
> I am saying that dwc2_port_suspend() _does_ set "HPRT0_SUSP" and=0A=
> "PCGCTL_STOPPCLK" even with DWC2_POWER_DOWN_PARAM_NONE.  Do you=0A=
> disagree?=0A=
Yes dwc2_port_suspend() does but that is a different implementation=0A=
> =0A=
> I completely agree that on mainline _dwc2_hcd_suspend() _does not_ set=0A=
> these bits with DWC2_POWER_DOWN_PARAM_NONE.  That is what my patch=0A=
> fixes.=0A=
Yes so I was pointing to that.=0A=
> =0A=
> =0A=
> -Doug=0A=
> =0A=
=0A=
I have performed testes and made sure that the patch is ok. It is just =0A=
that I am not sure if it does really save power. I have not been able to =
=0A=
see if any power is saved.=0A=
=0A=
So I am ok with this patch.=0A=
=0A=
-- =0A=
Regards,=0A=
Artur=0A=
