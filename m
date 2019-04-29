Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E26C004C9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2948C2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BgVcqwvV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="jI9qpTer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfD2MFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 08:05:33 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:36062 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727913AbfD2MFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 08:05:32 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 947A9C0021;
        Mon, 29 Apr 2019 12:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1556539532; bh=c+QUALNkWW5wNzbd99cDz+XcgUCrztrwP9YNXR/jNIk=;
        h=From:To:CC:Subject:Date:References:From;
        b=BgVcqwvVStkuq02l6audyRA/mp7UgBIKPeNOiUw7+kn4K8RQ4hIJRjozeTKX2cqx+
         mDWaP5gat8ozeFtk0ztno+K639/Hi5HJ0L8XXSW7cPez0PAUBwVOmkk7yw1kEj9yFE
         6G7S1Ld5wI+U6Al3MrUGCHakUS3a4o2usNiUBS2BX6LwmuOBZVundohk8fVvzdHJfX
         dgwJKD/vwyHPe0eRGiqFZIRZ3l4clXOvLad3+thGDhTXcvXk5BFmSKo+gEa8roEk4J
         w9XQbB5miApANJeziHgNQbDeq6y4chu4F0zFveiYhKW1QY+FBs3+1AfYAYehza6UV5
         AzQEysQpVqkcg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5783BA0071;
        Mon, 29 Apr 2019 12:05:31 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 29 Apr 2019 05:05:31 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 29 Apr 2019 05:05:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Edmwkntly4fpfC9C6ZGu7zzsX/VrubJ6otNlVcodGVw=;
 b=jI9qpTer9B1v9Yky4ASHuuAqBV6RHC2y1ytjL0UoOlTe8s/WsrR6GEpEvrKnT0cJnQQ3Nwy2piEXv2SzyhhpMH7rB5rfMMl6TARZ2RgE2zKiWZwB//Bk2iabzvN8j2/S9EjBYmtlts4N7TipCCB/5q5x3LEUydFa+nlaj4VMACk=
Received: from SN1PR12MB2431.namprd12.prod.outlook.com (52.132.195.146) by
 SN1PR12MB2351.namprd12.prod.outlook.com (52.132.194.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Mon, 29 Apr 2019 12:05:29 +0000
Received: from SN1PR12MB2431.namprd12.prod.outlook.com
 ([fe80::1982:4b45:2adf:9a1f]) by SN1PR12MB2431.namprd12.prod.outlook.com
 ([fe80::1982:4b45:2adf:9a1f%4]) with mapi id 15.20.1835.010; Mon, 29 Apr 2019
 12:05:29 +0000
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
Date:   Mon, 29 Apr 2019 12:05:29 +0000
Message-ID: <SN1PR12MB2431C9312AD486935C9B728AA7390@SN1PR12MB2431.namprd12.prod.outlook.com>
References: <cover.1555672441.git.arturp@synopsys.com>
 <87k1fis1b5.fsf@linux.intel.com>
 <SN1PR12MB2431EB450993E07730C3672FA73D0@SN1PR12MB2431.namprd12.prod.outlook.com>
 <CAD=FV=WKJMks9oCdUVS9vTKp9yD_VPE_uaAmTM9HgNoz8tt4pA@mail.gmail.com>
 <SN1PR12MB24312AEFA71B7EEF6FE4EB59A73E0@SN1PR12MB2431.namprd12.prod.outlook.com>
 <CAD=FV=WmtKYt5hn8s1PrjEgFcJqyc-8UWbyEmjPPVq0o4YgD5w@mail.gmail.com>
 <CAD=FV=WM7k-6moen+sgzZXnX-Zcw_BY9L=RTTrmt6pSHpXPLng@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arturp@synopsys.com; 
x-originating-ip: [84.53.141.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bbab8fd-136d-408f-0a0f-08d6cc9af91c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:SN1PR12MB2351;
x-ms-traffictypediagnostic: SN1PR12MB2351:
x-ms-exchange-purlcount: 4
x-microsoft-antispam-prvs: <SN1PR12MB2351EC1C04AF8C6353ADADD7A7390@SN1PR12MB2351.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39850400004)(376002)(396003)(136003)(31014005)(199004)(189003)(8676002)(486006)(305945005)(71200400001)(71190400001)(7736002)(74316002)(66476007)(73956011)(66946007)(102836004)(316002)(478600001)(66556008)(64756008)(66446008)(186003)(76116006)(91956017)(93886005)(86362001)(33656002)(81156014)(81166006)(6916009)(68736007)(53546011)(26005)(66066001)(8936002)(6506007)(446003)(476003)(229853002)(53936002)(7696005)(99286004)(6306002)(76176011)(6246003)(30864003)(6436002)(9686003)(25786009)(52536014)(966005)(3846002)(6116002)(54906003)(256004)(14454004)(14444005)(2906002)(5660300002)(55016002)(4326008)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR12MB2351;H:SN1PR12MB2431.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5Wc1Y8YBXpoUhlqh9ACikeNiLM3jbvpnFDSLBoA016EpZ7BQDp29z+HkyrFRc03Tm+1Qjp4GSNTM96YXVkQ/GQcrhn92L25sEEtVR0x06J5P+aNHl4J6OaXb5dRbrmWHTRskxTfHEM3D6MF0FEDRFjpb8+YjKOhFZXFLl+2qMfe9/2Jadl7+hSQV8rrpZn5sf2cVkDXU268E9QTiU4/99Ll+hyYh+w/nqDHIYwJFLOSkMrFIt2/67yZpvnlVNR2MZpB6FdKds94iTFX/xAGhYelnInTmqUSRL2bzcj8j7m4hzYmLuacJMVSz0QZhBdX9fSpakeM3ZDyF4vQx4ib1wuzdlkoGzQJ1gQiST1yCuqg3F4HOyP3hiwfBXGgLCRl6pjUKTLrNwkODyPagyuuM0j2QSXOchzLz2fb3wNHEsuM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bbab8fd-136d-408f-0a0f-08d6cc9af91c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 12:05:29.4136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2351
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=0A=
=0A=
On 4/27/2019 01:06, Doug Anderson wrote:=0A=
> Hi,=0A=
> =0A=
> On Fri, Apr 26, 2019 at 9:01 AM Doug Anderson <dianders@chromium.org> wro=
te:=0A=
>>=0A=
>> Hi,=0A=
>>=0A=
>> On Fri, Apr 26, 2019 at 12:11 AM Artur Petrosyan=0A=
>> <Arthur.Petrosyan@synopsys.com> wrote:=0A=
>>>=0A=
>>> Hi Doug,=0A=
>>>=0A=
>>> On 4/26/2019 00:13, Doug Anderson wrote:=0A=
>>>> Hi,=0A=
>>>>=0A=
>>>> On Thu, Apr 25, 2019 at 7:01 AM Artur Petrosyan=0A=
>>>> <Arthur.Petrosyan@synopsys.com> wrote:=0A=
>>>>>=0A=
>>>>> Hi,=0A=
>>>>>=0A=
>>>>> On 4/25/2019 16:43, Felipe Balbi wrote:=0A=
>>>>>> Artur Petrosyan <Arthur.Petrosyan@synopsys.com> writes:=0A=
>>>>>>> This patch set, fixes and improves partial power down and hibernati=
on power=0A=
>>>>>>> saving modes. Also, adds support for entering/exiting hibernation b=
y=0A=
>>>>>>> system issued suspend/resume.=0A=
>>>>>>>=0A=
>>>>>>> This series contains patches which were submitted to LKML. However,=
 a part=0A=
>>>>>>> of those patches didn't reach to LKML because of local issue relate=
d to=0A=
>>>>>>> smtp server.=0A=
>>>>>>>=0A=
>>>>>>> The patches which reached to LKML are:=0A=
>>>>>>>=0A=
>>>>>>> - usb: dwc2: Add part. power down exit from dwc2_conn_id_status_cha=
nge().=0A=
>>>>>>> - usb: dwc2: Add port conn. sts. checking in _dwc2_hcd_resume() fun=
ction.=0A=
>>>>>>> - usb: dwc2: Fix suspend state in host mode for partial power down.=
=0A=
>>>>>>> - usb: dwc2: Fix wakeup detected and session request interrupt hand=
lers.=0A=
>>>>>>> - usb: dwc2: Add descriptive debug messages for Partial Power Down =
mode.=0A=
>>>>>>> - usb: dwc2: Fix dwc2_restore_device_registers() function.=0A=
>>>>>>>=0A=
>>>>>>> The patches which didn't reach to LKML are:=0A=
>>>>>>>=0A=
>>>>>>> - usb: dwc2: Add enter/exit hibernation from system issued suspend/=
resume=0A=
>>>>>>> - usb: dwc2: Clear GINTSTS_RESTOREDONE bit after restore is generat=
ed.=0A=
>>>>>>> - usb: dwc2: Clear fifo_map when resetting core.=0A=
>>>>>>> - usb: dwc2: Allow exiting hibernation from gpwrdn rst detect=0A=
>>>>>>> - usb: dwc2: Fix hibernation between host and device modes.=0A=
>>>>>>> - usb: dwc2: Update dwc2_handle_usb_suspend_intr function.=0A=
>>>>>>> - usb: dwc2: Add default param to control power optimization.=0A=
>>>>>>> - usb: dwc2: Reset DEVADDR after exiting gadget hibernation.=0A=
>>>>>>>=0A=
>>>>>>> Submitting all of the patches together in this version.=0A=
>>>>>>>=0A=
>>>>>>> Changes from V0:=0A=
>>>>>>>     - Replaced 1 with DWC2_POWER_DOWN_PARAM_PARTIAL in commit=0A=
>>>>>>>       "9eed02b9fe96 usb: dwc2: Fix wakeup detected and session requ=
est=0A=
>>>>>>>       interrupt handlers.=0A=
>>>>>>>=0A=
>>>>>>>=0A=
>>>>>>> Artur Petrosyan (14):=0A=
>>>>>>>      usb: dwc2: Fix dwc2_restore_device_registers() function.=0A=
>>>>>>>      usb: dwc2: Add descriptive debug messages for Partial Power Do=
wn mode.=0A=
>>>>>>>      usb: dwc2: Fix wakeup detected and session request interrupt h=
andlers.=0A=
>>>>>>>      usb: dwc2: Fix suspend state in host mode for partial power do=
wn.=0A=
>>>>>>>      usb: dwc2: Add port conn. sts. checking in _dwc2_hcd_resume()=
=0A=
>>>>>>>        function.=0A=
>>>>>>>      usb: dwc2: Add part. power down exit from=0A=
>>>>>>>        dwc2_conn_id_status_change().=0A=
>>>>>>>      usb: dwc2: Reset DEVADDR after exiting gadget hibernation.=0A=
>>>>>>>      usb: dwc2: Add default param to control power optimization.=0A=
>>>>>>>      usb: dwc2: Update dwc2_handle_usb_suspend_intr function.=0A=
>>>>>>>      usb: dwc2: Fix hibernation between host and device modes.=0A=
>>>>>>>      usb: dwc2: Allow exiting hibernation from gpwrdn rst detect=0A=
>>>>>>>      usb: dwc2: Clear fifo_map when resetting core.=0A=
>>>>>>>      usb: dwc2: Clear GINTSTS_RESTOREDONE bit after restore is gene=
rated.=0A=
>>>>>>>      usb: dwc2: Add enter/exit hibernation from system issued=0A=
>>>>>>>        suspend/resume=0A=
>>>>>>=0A=
>>>>>> patches don't apply.=0A=
>>>>>>=0A=
>>>>>=0A=
>>>>> Do we need to wait for Minas's acknowledge or there is problem relate=
d=0A=
>>>>> to the patches?=0A=
>>>>=0A=
>>>> It looks like the problem is that my patches won the race and Felipe=
=0A=
>>>> applied them before yours.  Thus, presumably, it'll be up to you to=0A=
>>>> rebase your patches atop mine and re-submit.  Specifically, you can=0A=
>>>> do:=0A=
>>>>=0A=
>>>> git remote add linux_usb_balbi=0A=
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git=0A=
>>>> git fetch linux_usb_balbi=0A=
>>>> git checkout linux_usb_balbi/testing/next=0A=
>>>>=0A=
>>>> If you do that and then try to apply your patches you'll find that=0A=
>>>> they no longer apply.  AKA try running:=0A=
>>>>=0A=
>>>> for patch in 10909749 10909737 10909739 10909745 10909533 \=0A=
>>>>      10909531 10909747 10909535 10909523 10909741 10909525 \=0A=
>>>>      10909751 10909527 10909743; do=0A=
>>>>     curl -L https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__pat=
chwork.kernel.org_patch_-24-257Bpatch-257D_mbox&d=3DDwIBaQ&c=3DDPL6_X_6JkXF=
x7AXWqB0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_HlVzYqrC_D7niMJI&m=3DgzzEDEbxflLM=
gk9I-7Re9ytRMvyc_B8iZEmg2xGZN5E&s=3DaWT1hYtXeIeY8ClQ0sNYxwkmJFKDz4iaa4DchNw=
x3_w&e=3D | git am=0A=
>>>> done=0A=
>>>>=0A=
>>>> You'll see:=0A=
>>>>=0A=
>>>>> Applying: usb: dwc2: Fix wakeup detected and session request interrup=
t handlers.=0A=
>>>>> error: patch failed: drivers/usb/dwc2/core_intr.c:435=0A=
>>>>> error: drivers/usb/dwc2/core_intr.c: patch does not apply=0A=
>>>>> Patch failed at 0001 usb: dwc2: Fix wakeup detected and session reque=
st interrupt handlers.=0A=
>>>>=0A=
>>>> NOTE: before reposting it might be a good idea to apply the last 3=0A=
>>>> patches in my series as per [1] before sending up your series.  Since=
=0A=
>>>> Felipe has already applied patches #1 and #2 in that series presumably=
=0A=
>>>> he'll also apply #3 - #5.=0A=
>>>>=0A=
>>>> I know it'a also up to me to try testing our your patches.  It's still=
=0A=
>>>> on my list to give it a shot...=0A=
>>>>=0A=
>>>> [1] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.kernel=
.org_r_CAD-3DFV-3DWA07-2BgUkVvsikN-3DiDHZLUJQtzjkKtiBHAEDw4gLNWY7w-40mail.g=
mail.com&d=3DDwIBaQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQ=
jP_HlVzYqrC_D7niMJI&m=3DgzzEDEbxflLMgk9I-7Re9ytRMvyc_B8iZEmg2xGZN5E&s=3D9QP=
_h5ZlnT7ayUE1_6EVEgu8FaI3_kWm9xuzs1qrvdI&e=3D=0A=
>>>>=0A=
>>>> P.S: It's helpful if you CC LKML on patches and discussions about=0A=
>>>> them.  That allows the magic "permalink via message ID" on=0A=
>>>> lkml.kernel.org and also allows your patches to be found on=0A=
>>>> lore.kernel.org/patchwork/=0A=
>>>>=0A=
>>>> -Doug=0A=
>>>>=0A=
>>>=0A=
>>> Besides the issue that comes from the patch "usb: dwc2: Fix wakeup=0A=
>>> detected and session request interrupt handlers." there is one more=0A=
>>> serious conflict with one of your patches.=0A=
>>>=0A=
>>> So the patch "usb: dwc2: bus suspend/resume for hosts with=0A=
>>> DWC2_POWER_DOWN_PARAM_NONE" have had also been added to the=0A=
>>> "balbi/testing/next" before my patch series which conflicts with two of=
=0A=
>>> my patches.=0A=
>>>=0A=
>>> 1. usb: dwc2: Fix suspend state in host mode for partial power down.=0A=
>>> 2. usb: dwc2: Add enter/exit hibernation from system issued suspend/res=
ume=0A=
>>>=0A=
>>> This patch introduced by you "usb: dwc2: bus suspend/resume for hosts=
=0A=
>>> with DWC2_POWER_DOWN_PARAM_NONE" got a little bit of issue. It=0A=
>>> eliminates entering hibernation through system issued suspend by=0A=
>>> checking "if (hsotg->params.power_down > DWC2_POWER_DOWN_PARAM_PARTIAL)=
"=0A=
>>=0A=
>> To be fair, the patch does not make entering hibernation worse, does=0A=
>> it?  Specifically, I'll point to this part of the diff:=0A=
>>=0A=
>> - if (hsotg->params.power_down !=3D DWC2_POWER_DOWN_PARAM_PARTIAL) {=0A=
>> + if (hsotg->params.power_down > DWC2_POWER_DOWN_PARAM_PARTIAL) {=0A=
>>=0A=
>> As you can see, if power_down =3D=3D DWC2_POWER_DOWN_PARAM_HIBERNATION t=
he=0A=
>> flow for this "if" test is exactly the same before and after my patch.=
=0A=
>>=0A=
>>=0A=
>>> . As per the patch you mention that it fixes suspend/resume flow for=0A=
>>> Altera SOCFPGA and Chrome OS 3.14 kernel tree. I assume that the board=
=0A=
>>> has the Partial Power Down enabled core that is why it works out.=0A=
>>=0A=
>> I mentioned some of this in my cover letter [1].  To rehash, I said=0A=
>> "Turning on partial power down on rk3288 doesn't "just work".  I don't=
=0A=
>> get hotplug events.  This is despite dwc2 auto-detecting that we are=0A=
>> power optimized."=0A=
>>=0A=
>> ...it is certainly possible that partial power down would work on=0A=
>> rk3288 if someone had the time to debug it.=0A=
>>=0A=
>> NOTE: I don't have an Altera SOCFPGA, but I'll mention that a previous=
=0A=
>> iteration of my patch (written by Kever Yang at Rockchip) was reverted=
=0A=
>> because it _broke_ Altera SOCFPGAS.  Given my requests to test the new=
=0A=
>> version have been met with silence, I'm inclined to land this and hope=
=0A=
>> it's all good.  If there are problems then hopefully some actual=0A=
>> details can be provided.  Last time there were none provided.=0A=
>>=0A=
>>=0A=
>>> However, we don't just support the Partial Power Down feature enabled=
=0A=
>>> cores. We also support Hibernation feature enabled cores.=0A=
>>=0A=
>> Sure, but the code that is actually landed upstream (even before my=0A=
>> series) almost certainly doesn't function for Hibernation.  As pointed=
=0A=
>> out above the entire "_dwc2_hcd_suspend()" function had a great big:=0A=
>>=0A=
>> if (hsotg->params.power_down !=3D DWC2_POWER_DOWN_PARAM_PARTIAL)=0A=
>>    goto skip_power_saving;=0A=
>>=0A=
>> ...which, as far as I could tell, meant that Hibernation could not=0A=
>> possible work.=0A=
>>=0A=
>>=0A=
>>> The patch set that had been introduced by me which includes "usb: dwc2:=
=0A=
>>> Add enter/exit hibernation from system issued suspend/resume" patch add=
s=0A=
>>> support for both hibernation and Partial Power Down feature enabled=0A=
>>> cores and fixes several of Partial Power Down and hibernation related=
=0A=
>>> issues.=0A=
>>>=0A=
>>> This patch set may fix all of the issues related with Altera SOCFPGA or=
=0A=
>>> Chrome OS 3.14 kernel tree.=0A=
>>>=0A=
>>> That is why we asked you to test the patch set before we could ACK or=
=0A=
>>> have chance to debug your patch deeper to see the help of it and to=0A=
>>> provide you information related to it.=0A=
>>=0A=
>> It may well fix my problems and maybe I can use partial power down=0A=
>> now.  That'd be nice.  It was on my list and I would have worked on it=
=0A=
>> last week except that your patches weren't on the mailing list then.=0A=
>> ...so I moved on to some other work.  To avoid context switching too=0A=
>> much I needed to get to a stopping point before testing your patches.=0A=
>> I was hoping to have some nice rebased patches from you to test today,=
=0A=
>> but maybe I'll try a hand at rebasing them myself.=0A=
>>=0A=
>> NOTE also that though I ported this change from the Chrome OS 3.14=0A=
>> kernel tree, I'm actually currently working on the Chrome OS 4.19=0A=
>> tree.  I also made sure to test the changes on mainline Linux.=0A=
>>=0A=
>>=0A=
>>> So now I can rebase my changes to the "balbi/testing/next" but I will=
=0A=
>>> have to take the logic of skipping Hibernation out otherwise we will=0A=
>>> have problems with hibernation enabled cores.=0A=
>>=0A=
>> As per above, please have a careful look at my patches and you'll see=0A=
>> that I was not introducing code that skipped hibernation.  I was=0A=
>> keeping the same flow as the old code that skipped hibernation.  So if=
=0A=
>> you are making hibernation work there should be no problems removing=0A=
>> that.=0A=
>>=0A=
>>=0A=
>>> We can ask Balbi to permanently suspend adding of the patch "usb: dwc2:=
=0A=
>>> bus suspend/resume for hosts with DWC2_POWER_DOWN_PARAM_NONE" and my=0A=
>>> patch series to his "testing/next". After you can have a chance to test=
=0A=
>>> my patch series we can see if the patches are acknowledged and ask Balb=
i=0A=
>>>    to add them.=0A=
>>=0A=
>> Personally I'd prefer if Felipe finished landing my series and then=0A=
>> you rebased atop it.  As I said I'm convinced I'm not making your=0A=
>> hibernation case any worse.  If you know of actual things that are=0A=
>> made worse by my series then that would be a reason not to land it,=0A=
>> but so far I haven't been convinced.=0A=
>>=0A=
>>=0A=
>> [1] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.kernel.o=
rg_r_20190418001356.124334-2D2-2Ddianders-40chromium.org&d=3DDwIFaQ&c=3DDPL=
6_X_6JkXFx7AXWqB0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_HlVzYqrC_D7niMJI&m=3Dmdz=
-R9O5TUR_zXEeeCZO2341dvcwZro2cedCZzIIans&s=3D6qAU20vyvZqIWdkRGSUWEdiTr57arb=
Jf2uHECkCuwQg&e=3D=0A=
> =0A=
> To add a bit of breadcrumbs, I did the rebase atop my patches and also=0A=
> did some basic review of yours.  Other than a few nits I think I found=0A=
> at least one bug where you're unlocking a spinlock twice in the=0A=
> partial power down case.=0A=
Yeah thank you so much for the review it really helps to make =0A=
conclusions on the implementations. I have tested those patches on =0A=
HAPS-DX platform and have not got any problem. Hibernation and partial =0A=
power down flows are working ok.=0A=
> =0A=
> I continue to be convinced that the right thing to do is to finish=0A=
> landing my series and then once you've spun yours atop mine we can=0A=
> look at landing it.=0A=
> =0A=
> Here's all my picks atop Felipe's tree that show how I resolved=0A=
> things:  https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__chromium.=
googlesource.com_chromiumos_third-5Fparty_kernel_-2Blog_refs_sandbox_diande=
rs_190426-2Ddwc2-2Dstuff&d=3DDwIFaQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3D9hPBFKCJ=
_nBjJhGVrrlYOeOQjP_HlVzYqrC_D7niMJI&m=3Dmdz-R9O5TUR_zXEeeCZO2341dvcwZro2ced=
CZzIIans&s=3DmVfBGtiMQg2XVHXmGCWcd584g0DYRH1JDVnEnJWE6P8&e=3D=0A=
> =0A=
> =0A=
> -Doug=0A=
> =0A=
=0A=
I will make my changes then will go ahead and rebase.=0A=
=0A=
=0A=
-- =0A=
Regards,=0A=
Artur=0A=
