Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9527DC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F162075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="enueYVGh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="Hqo/ohcv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfD2Ion (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 04:44:43 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:49508 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727480AbfD2Ion (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 04:44:43 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 92E08C00A8;
        Mon, 29 Apr 2019 08:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1556527480; bh=DU3VWRbAs6/GrQSujr4I8dCcILdJa21AGnRt6jIuV3c=;
        h=From:To:CC:Subject:Date:References:From;
        b=enueYVGhhOO6N2E6JVSUPd2aQEVIUkIrdigpKW6171KGCDC+Sp7tTpViBu5lWI4pD
         mALk9KLdD2MYflbtDHxS9e2gawer1tLlYKIAu1yY3g45MOqrp1o9TeHw5hYpGWwB8G
         NItoIme9i/ML4s5u4fYFDIH8Jc22gAG2g+LAq1L88E02Zrz9dmCBj0OyxOhsVD2K+H
         JIx3eEFJ/MM5LnKAO4PjIIMfNjShpve5PmLH5wvldpgl8jijBY6C2KmJyIxgyU5Hzg
         BYgBQgDY6VEhld7zs95rYfgaTECnLNW6Cwxfm1LhYx5NBeMsokyFbCtEhyvw3gbFlA
         y82jw3So1nQYA==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 164D2A005D;
        Mon, 29 Apr 2019 08:44:42 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 29 Apr 2019 01:44:42 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 29 Apr 2019 01:44:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Da76UT9ySUKBHrJmru1gBDNS02zNCzTkEzRcPDg/Ebo=;
 b=Hqo/ohcvFpYE/H7SO5c4xWfFrLmE2pXGkvtt4PzLIoqFEFYgH3XviKylVvMHezQc90G5ryYZHwC2Uy/N0CWs0/2wklwbVogEDjLopV/fhDo3cBjcdtrZ8YX9HAEf/g4nPl+soDmpRbPhMvFORxrkXFZd3t4nX20L4WGe4Uv8KoE=
Received: from SN1PR12MB2431.namprd12.prod.outlook.com (52.132.195.146) by
 SN1PR12MB0479.namprd12.prod.outlook.com (10.162.105.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.14; Mon, 29 Apr 2019 08:44:37 +0000
Received: from SN1PR12MB2431.namprd12.prod.outlook.com
 ([fe80::1982:4b45:2adf:9a1f]) by SN1PR12MB2431.namprd12.prod.outlook.com
 ([fe80::1982:4b45:2adf:9a1f%4]) with mapi id 15.20.1835.010; Mon, 29 Apr 2019
 08:44:37 +0000
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
To:     Doug Anderson <dianders@chromium.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        John Youn <John.Youn@synopsys.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 00/14] usb: dwc2: Fix and improve power saving modes.
Thread-Topic: [PATCH v1 00/14] usb: dwc2: Fix and improve power saving modes.
Thread-Index: AQHU9qJP9TPmzBH3xU6dprNhQakiQw==
Date:   Mon, 29 Apr 2019 08:44:37 +0000
Message-ID: <SN1PR12MB24318002A0D240A853F5B368A7390@SN1PR12MB2431.namprd12.prod.outlook.com>
References: <cover.1555672441.git.arturp@synopsys.com>
 <87k1fis1b5.fsf@linux.intel.com>
 <SN1PR12MB2431EB450993E07730C3672FA73D0@SN1PR12MB2431.namprd12.prod.outlook.com>
 <CAD=FV=WKJMks9oCdUVS9vTKp9yD_VPE_uaAmTM9HgNoz8tt4pA@mail.gmail.com>
 <SN1PR12MB24312AEFA71B7EEF6FE4EB59A73E0@SN1PR12MB2431.namprd12.prod.outlook.com>
 <CAD=FV=WmtKYt5hn8s1PrjEgFcJqyc-8UWbyEmjPPVq0o4YgD5w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arturp@synopsys.com; 
x-originating-ip: [84.53.141.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1ad35d3-6a50-4f4c-0099-08d6cc7ee9b1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:SN1PR12MB0479;
x-ms-traffictypediagnostic: SN1PR12MB0479:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <SN1PR12MB047966BC4C7289FEAFC9E041A7390@SN1PR12MB0479.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39850400004)(366004)(376002)(31014005)(199004)(189003)(4326008)(446003)(476003)(8676002)(86362001)(30864003)(486006)(5660300002)(6436002)(66066001)(55016002)(2906002)(256004)(14444005)(5024004)(966005)(71200400001)(25786009)(14454004)(186003)(81156014)(97736004)(81166006)(8936002)(71190400001)(93886005)(102836004)(6916009)(68736007)(53936002)(74316002)(76176011)(53546011)(9686003)(91956017)(66446008)(66556008)(26005)(6506007)(6306002)(6246003)(7696005)(478600001)(305945005)(7736002)(99286004)(316002)(52536014)(3846002)(6116002)(33656002)(54906003)(229853002)(76116006)(73956011)(66946007)(66476007)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR12MB0479;H:SN1PR12MB2431.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vsz3Rg/cF/4doFbtqanCIUJ28g7FGKXR5jtVQU3J7wnc29aZ9L8OpGa+Vir39h/vKBH0VnD/6IO1LO6FRUilILxoXHzHlb5VdQYYiaSPcAWRHkDNvuol92HikhPoLscFv9QFQjAKOmAS4eZvcpNzeDbawdiQC1r6fRVm13NSV7jwISsJmAF9wEtY+zXP4P9a+oSg7kOkoJDcaJ+FV/TaHeeAZzFHpiVQFa/M44riHpHukDixAKO3TjD5TDwzxo6z5lcK4uYnPg3hhi7IunnIRLFjwyslJkgH7Bn+wpl/iHvnPS2N7/a4vAV1wSn+E/WUjIm5f0dvbv9gp3fjj64JEvUExsm2u3x9JqDCvmK5G9E1mf+Ar39kMLDFivdlQZGKyhMwfEhZbVMMlWrGvb1c8WVnrnU5DwRzmrazKOca57s=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ad35d3-6a50-4f4c-0099-08d6cc7ee9b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 08:44:37.6469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0479
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=0A=
=0A=
On 4/26/2019 20:02, Doug Anderson wrote:=0A=
> Hi,=0A=
> =0A=
> On Fri, Apr 26, 2019 at 12:11 AM Artur Petrosyan=0A=
> <Arthur.Petrosyan@synopsys.com> wrote:=0A=
>>=0A=
>> Hi Doug,=0A=
>>=0A=
>> On 4/26/2019 00:13, Doug Anderson wrote:=0A=
>>> Hi,=0A=
>>>=0A=
>>> On Thu, Apr 25, 2019 at 7:01 AM Artur Petrosyan=0A=
>>> <Arthur.Petrosyan@synopsys.com> wrote:=0A=
>>>>=0A=
>>>> Hi,=0A=
>>>>=0A=
>>>> On 4/25/2019 16:43, Felipe Balbi wrote:=0A=
>>>>> Artur Petrosyan <Arthur.Petrosyan@synopsys.com> writes:=0A=
>>>>>> This patch set, fixes and improves partial power down and hibernatio=
n power=0A=
>>>>>> saving modes. Also, adds support for entering/exiting hibernation by=
=0A=
>>>>>> system issued suspend/resume.=0A=
>>>>>>=0A=
>>>>>> This series contains patches which were submitted to LKML. However, =
a part=0A=
>>>>>> of those patches didn't reach to LKML because of local issue related=
 to=0A=
>>>>>> smtp server.=0A=
>>>>>>=0A=
>>>>>> The patches which reached to LKML are:=0A=
>>>>>>=0A=
>>>>>> - usb: dwc2: Add part. power down exit from dwc2_conn_id_status_chan=
ge().=0A=
>>>>>> - usb: dwc2: Add port conn. sts. checking in _dwc2_hcd_resume() func=
tion.=0A=
>>>>>> - usb: dwc2: Fix suspend state in host mode for partial power down.=
=0A=
>>>>>> - usb: dwc2: Fix wakeup detected and session request interrupt handl=
ers.=0A=
>>>>>> - usb: dwc2: Add descriptive debug messages for Partial Power Down m=
ode.=0A=
>>>>>> - usb: dwc2: Fix dwc2_restore_device_registers() function.=0A=
>>>>>>=0A=
>>>>>> The patches which didn't reach to LKML are:=0A=
>>>>>>=0A=
>>>>>> - usb: dwc2: Add enter/exit hibernation from system issued suspend/r=
esume=0A=
>>>>>> - usb: dwc2: Clear GINTSTS_RESTOREDONE bit after restore is generate=
d.=0A=
>>>>>> - usb: dwc2: Clear fifo_map when resetting core.=0A=
>>>>>> - usb: dwc2: Allow exiting hibernation from gpwrdn rst detect=0A=
>>>>>> - usb: dwc2: Fix hibernation between host and device modes.=0A=
>>>>>> - usb: dwc2: Update dwc2_handle_usb_suspend_intr function.=0A=
>>>>>> - usb: dwc2: Add default param to control power optimization.=0A=
>>>>>> - usb: dwc2: Reset DEVADDR after exiting gadget hibernation.=0A=
>>>>>>=0A=
>>>>>> Submitting all of the patches together in this version.=0A=
>>>>>>=0A=
>>>>>> Changes from V0:=0A=
>>>>>>     - Replaced 1 with DWC2_POWER_DOWN_PARAM_PARTIAL in commit=0A=
>>>>>>       "9eed02b9fe96 usb: dwc2: Fix wakeup detected and session reque=
st=0A=
>>>>>>       interrupt handlers.=0A=
>>>>>>=0A=
>>>>>>=0A=
>>>>>> Artur Petrosyan (14):=0A=
>>>>>>      usb: dwc2: Fix dwc2_restore_device_registers() function.=0A=
>>>>>>      usb: dwc2: Add descriptive debug messages for Partial Power Dow=
n mode.=0A=
>>>>>>      usb: dwc2: Fix wakeup detected and session request interrupt ha=
ndlers.=0A=
>>>>>>      usb: dwc2: Fix suspend state in host mode for partial power dow=
n.=0A=
>>>>>>      usb: dwc2: Add port conn. sts. checking in _dwc2_hcd_resume()=
=0A=
>>>>>>        function.=0A=
>>>>>>      usb: dwc2: Add part. power down exit from=0A=
>>>>>>        dwc2_conn_id_status_change().=0A=
>>>>>>      usb: dwc2: Reset DEVADDR after exiting gadget hibernation.=0A=
>>>>>>      usb: dwc2: Add default param to control power optimization.=0A=
>>>>>>      usb: dwc2: Update dwc2_handle_usb_suspend_intr function.=0A=
>>>>>>      usb: dwc2: Fix hibernation between host and device modes.=0A=
>>>>>>      usb: dwc2: Allow exiting hibernation from gpwrdn rst detect=0A=
>>>>>>      usb: dwc2: Clear fifo_map when resetting core.=0A=
>>>>>>      usb: dwc2: Clear GINTSTS_RESTOREDONE bit after restore is gener=
ated.=0A=
>>>>>>      usb: dwc2: Add enter/exit hibernation from system issued=0A=
>>>>>>        suspend/resume=0A=
>>>>>=0A=
>>>>> patches don't apply.=0A=
>>>>>=0A=
>>>>=0A=
>>>> Do we need to wait for Minas's acknowledge or there is problem related=
=0A=
>>>> to the patches?=0A=
>>>=0A=
>>> It looks like the problem is that my patches won the race and Felipe=0A=
>>> applied them before yours.  Thus, presumably, it'll be up to you to=0A=
>>> rebase your patches atop mine and re-submit.  Specifically, you can=0A=
>>> do:=0A=
>>>=0A=
>>> git remote add linux_usb_balbi=0A=
>>> git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git=0A=
>>> git fetch linux_usb_balbi=0A=
>>> git checkout linux_usb_balbi/testing/next=0A=
>>>=0A=
>>> If you do that and then try to apply your patches you'll find that=0A=
>>> they no longer apply.  AKA try running:=0A=
>>>=0A=
>>> for patch in 10909749 10909737 10909739 10909745 10909533 \=0A=
>>>      10909531 10909747 10909535 10909523 10909741 10909525 \=0A=
>>>      10909751 10909527 10909743; do=0A=
>>>     curl -L https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__patc=
hwork.kernel.org_patch_-24-257Bpatch-257D_mbox&d=3DDwIBaQ&c=3DDPL6_X_6JkXFx=
7AXWqB0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_HlVzYqrC_D7niMJI&m=3DgzzEDEbxflLMg=
k9I-7Re9ytRMvyc_B8iZEmg2xGZN5E&s=3DaWT1hYtXeIeY8ClQ0sNYxwkmJFKDz4iaa4DchNwx=
3_w&e=3D | git am=0A=
>>> done=0A=
>>>=0A=
>>> You'll see:=0A=
>>>=0A=
>>>> Applying: usb: dwc2: Fix wakeup detected and session request interrupt=
 handlers.=0A=
>>>> error: patch failed: drivers/usb/dwc2/core_intr.c:435=0A=
>>>> error: drivers/usb/dwc2/core_intr.c: patch does not apply=0A=
>>>> Patch failed at 0001 usb: dwc2: Fix wakeup detected and session reques=
t interrupt handlers.=0A=
>>>=0A=
>>> NOTE: before reposting it might be a good idea to apply the last 3=0A=
>>> patches in my series as per [1] before sending up your series.  Since=
=0A=
>>> Felipe has already applied patches #1 and #2 in that series presumably=
=0A=
>>> he'll also apply #3 - #5.=0A=
>>>=0A=
>>> I know it'a also up to me to try testing our your patches.  It's still=
=0A=
>>> on my list to give it a shot...=0A=
>>>=0A=
>>> [1] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.kernel.=
org_r_CAD-3DFV-3DWA07-2BgUkVvsikN-3DiDHZLUJQtzjkKtiBHAEDw4gLNWY7w-40mail.gm=
ail.com&d=3DDwIBaQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQj=
P_HlVzYqrC_D7niMJI&m=3DgzzEDEbxflLMgk9I-7Re9ytRMvyc_B8iZEmg2xGZN5E&s=3D9QP_=
h5ZlnT7ayUE1_6EVEgu8FaI3_kWm9xuzs1qrvdI&e=3D=0A=
>>>=0A=
>>> P.S: It's helpful if you CC LKML on patches and discussions about=0A=
>>> them.  That allows the magic "permalink via message ID" on=0A=
>>> lkml.kernel.org and also allows your patches to be found on=0A=
>>> lore.kernel.org/patchwork/=0A=
>>>=0A=
>>> -Doug=0A=
>>>=0A=
>>=0A=
>> Besides the issue that comes from the patch "usb: dwc2: Fix wakeup=0A=
>> detected and session request interrupt handlers." there is one more=0A=
>> serious conflict with one of your patches.=0A=
>>=0A=
>> So the patch "usb: dwc2: bus suspend/resume for hosts with=0A=
>> DWC2_POWER_DOWN_PARAM_NONE" have had also been added to the=0A=
>> "balbi/testing/next" before my patch series which conflicts with two of=
=0A=
>> my patches.=0A=
>>=0A=
>> 1. usb: dwc2: Fix suspend state in host mode for partial power down.=0A=
>> 2. usb: dwc2: Add enter/exit hibernation from system issued suspend/resu=
me=0A=
>>=0A=
>> This patch introduced by you "usb: dwc2: bus suspend/resume for hosts=0A=
>> with DWC2_POWER_DOWN_PARAM_NONE" got a little bit of issue. It=0A=
>> eliminates entering hibernation through system issued suspend by=0A=
>> checking "if (hsotg->params.power_down > DWC2_POWER_DOWN_PARAM_PARTIAL)"=
=0A=
> =0A=
> To be fair, the patch does not make entering hibernation worse, does=0A=
> it?  Specifically, I'll point to this part of the diff:=0A=
>  > - if (hsotg->params.power_down !=3D DWC2_POWER_DOWN_PARAM_PARTIAL) {=
=0A=
> + if (hsotg->params.power_down > DWC2_POWER_DOWN_PARAM_PARTIAL) {=0A=
> =0A=
> As you can see, if power_down =3D=3D DWC2_POWER_DOWN_PARAM_HIBERNATION th=
e=0A=
> flow for this "if" test is exactly the same before and after my patch.=0A=
> =0A=
> =0A=
=0A=
 From the point of making hibernation worse no it doesn't.=0A=
=0A=
>> . As per the patch you mention that it fixes suspend/resume flow for=0A=
>> Altera SOCFPGA and Chrome OS 3.14 kernel tree. I assume that the board=
=0A=
>> has the Partial Power Down enabled core that is why it works out.=0A=
> =0A=
> I mentioned some of this in my cover letter [1].  To rehash, I said=0A=
> "Turning on partial power down on rk3288 doesn't "just work".  I don't=0A=
> get hotplug events.  This is despite dwc2 auto-detecting that we are=0A=
> power optimized."=0A=
> =0A=
=0A=
Have you tested your patch on any board?=0A=
=0A=
=0A=
> ...it is certainly possible that partial power down would work on=0A=
> rk3288 if someone had the time to debug it.=0A=
> =0A=
> NOTE: I don't have an Altera SOCFPGA, but I'll mention that a previous=0A=
> iteration of my patch (written by Kever Yang at Rockchip) was reverted=0A=
> because it _broke_ Altera SOCFPGAS.  Given my requests to test the new=0A=
> version have been met with silence, I'm inclined to land this and hope=0A=
> it's all good.  If there are problems then hopefully some actual=0A=
> details can be provided.  Last time there were none provided.=0A=
> =0A=
>  >> However, we don't just support the Partial Power Down feature enabled=
=0A=
>> cores. We also support Hibernation feature enabled cores.=0A=
> =0A=
> Sure, but the code that is actually landed upstream (even before my=0A=
> series) almost certainly doesn't function for Hibernation.  As pointed=0A=
> out above the entire "_dwc2_hcd_suspend()" function had a great big:=0A=
> =0A=
> if (hsotg->params.power_down !=3D DWC2_POWER_DOWN_PARAM_PARTIAL)=0A=
>    goto skip_power_saving;=0A=
> =0A=
> ...which, as far as I could tell, meant that Hibernation could not=0A=
> possible work.=0A=
> =0A=
> =0A=
>> The patch set that had been introduced by me which includes "usb: dwc2:=
=0A=
>> Add enter/exit hibernation from system issued suspend/resume" patch adds=
=0A=
>> support for both hibernation and Partial Power Down feature enabled=0A=
>> cores and fixes several of Partial Power Down and hibernation related=0A=
>> issues.=0A=
>>=0A=
>> This patch set may fix all of the issues related with Altera SOCFPGA or=
=0A=
>> Chrome OS 3.14 kernel tree.=0A=
>>=0A=
>> That is why we asked you to test the patch set before we could ACK or=0A=
>> have chance to debug your patch deeper to see the help of it and to=0A=
>> provide you information related to it.=0A=
> =0A=
> It may well fix my problems and maybe I can use partial power down=0A=
> now.  That'd be nice.  It was on my list and I would have worked on it=0A=
> last week except that your patches weren't on the mailing list then.=0A=
> ...so I moved on to some other work.  To avoid context switching too=0A=
> much I needed to get to a stopping point before testing your patches.=0A=
> I was hoping to have some nice rebased patches from you to test today,=0A=
> but maybe I'll try a hand at rebasing them myself.=0A=
> =0A=
> NOTE also that though I ported this change from the Chrome OS 3.14=0A=
> kernel tree, I'm actually currently working on the Chrome OS 4.19=0A=
> tree.  I also made sure to test the changes on mainline Linux.=0A=
> =0A=
> =0A=
>> So now I can rebase my changes to the "balbi/testing/next" but I will=0A=
>> have to take the logic of skipping Hibernation out otherwise we will=0A=
>> have problems with hibernation enabled cores.=0A=
> =0A=
> As per above, please have a careful look at my patches and you'll see=0A=
> that I was not introducing code that skipped hibernation.  I was=0A=
> keeping the same flow as the old code that skipped hibernation.  So if=0A=
> you are making hibernation work there should be no problems removing=0A=
> that.=0A=
> =0A=
> =0A=
Ok so after rebase it may be removed.=0A=
=0A=
>> We can ask Balbi to permanently suspend adding of the patch "usb: dwc2:=
=0A=
>> bus suspend/resume for hosts with DWC2_POWER_DOWN_PARAM_NONE" and my=0A=
>> patch series to his "testing/next". After you can have a chance to test=
=0A=
>> my patch series we can see if the patches are acknowledged and ask Balbi=
=0A=
>>    to add them.=0A=
> =0A=
> Personally I'd prefer if Felipe finished landing my series and then=0A=
> you rebased atop it.  As I said I'm convinced I'm not making your=0A=
> hibernation case any worse.  If you know of actual things that are=0A=
> made worse by my series then that would be a reason not to land it,=0A=
> but so far I haven't been convinced > [1] =0A=
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.kernel.org_r_20=
190418001356.124334-2D2-2Ddianders-40chromium.org&d=3DDwIFaQ&c=3DDPL6_X_6Jk=
XFx7AXWqB0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_HlVzYqrC_D7niMJI&m=3DBgo5YsUKyt=
ageORysPEnHFDC2KH68gUT5GSuZFXYBiU&s=3D5X1sj6qNMNW85zQbTzXJuKIgH74L-P8LsGfSi=
66MjDE&e=3D=0A=
> =0A=
I have had a look on your patch and made some comments.=0A=
=0A=
Also, tested your patch "usb: dwc2: bus suspend/resume for hosts with =0A=
DWC2_POWER_DOWN_PARAM_NONE" on HAPS-DX. With this patch or without it =0A=
when I have a device connected core  enters to partial power down and =0A=
doesn't exit from it. The attached device cannot be used.=0A=
=0A=
=0A=
=0A=
-- =0A=
Regards,=0A=
Artur=0A=
