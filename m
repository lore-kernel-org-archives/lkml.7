Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C981C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8FB206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Ri9trJYT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="Z0hhxbmI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfDZHLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:11:00 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:36962 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725877AbfDZHLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:11:00 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5AB06C0B43;
        Fri, 26 Apr 2019 07:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1556262659; bh=ri/zEyrAaVlOEAc1xD9zn8OBzmbQE79bKQJh+zzw/dc=;
        h=From:To:CC:Subject:Date:References:From;
        b=Ri9trJYTe3qLGbtaeWeNqeIH7um7ntfybnZntnSTkdBNb1H5QgUZhnU3D3bOcgHx0
         ZAgfiyGJXkkqZGxODglwSxDZBngYMK50tuhNBdofBTgFh1AacWj/qPVhMlUxApGTK7
         vb7L7zGFcLx4rFql7qCcn3+oSUS9lQgkciPVasArEwjRYJetmnOP8sjZj0mhG0uBe/
         p1E9llydO+G2xUZfo68KMuzNXwGeMk8OD92FVsgTd7dGg9pnmptBDqa0hKfUg+61nn
         Y805FIBT3eBoZiX1ob3IRkVwGal16guJTpkX3srbThyf0ttpjX61u3L/3bd1guEebO
         C7LwkFcdcGEZQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 458D6A00A6;
        Fri, 26 Apr 2019 07:10:59 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 26 Apr 2019 00:10:59 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 26 Apr 2019 00:10:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qdxGMhnaBvucWi63bYU2h2w36V1a1+Pp2dLj5+kIo4=;
 b=Z0hhxbmIWTz3mspW5x277SvSDoVeWZ/CGd0pX5W4zS8u06oNOKoEawXVxStBY3Mfs+gy58D1r7TwFKHKpitTYXVZVj+5lbr12ZKLtaJGKEYxCnUj9Ld2tXC/cKNzPUacm/e5qZwHsrj6zLBfpCVzqKYoTOvGkSt2RMdwdnDQ3Kc=
Received: from SN1PR12MB2431.namprd12.prod.outlook.com (52.132.195.146) by
 SN1PR12MB2464.namprd12.prod.outlook.com (52.132.196.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Fri, 26 Apr 2019 07:10:56 +0000
Received: from SN1PR12MB2431.namprd12.prod.outlook.com
 ([fe80::1982:4b45:2adf:9a1f]) by SN1PR12MB2431.namprd12.prod.outlook.com
 ([fe80::1982:4b45:2adf:9a1f%4]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 07:10:56 +0000
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
Date:   Fri, 26 Apr 2019 07:10:56 +0000
Message-ID: <SN1PR12MB24312AEFA71B7EEF6FE4EB59A73E0@SN1PR12MB2431.namprd12.prod.outlook.com>
References: <cover.1555672441.git.arturp@synopsys.com>
 <87k1fis1b5.fsf@linux.intel.com>
 <SN1PR12MB2431EB450993E07730C3672FA73D0@SN1PR12MB2431.namprd12.prod.outlook.com>
 <CAD=FV=WKJMks9oCdUVS9vTKp9yD_VPE_uaAmTM9HgNoz8tt4pA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arturp@synopsys.com; 
x-originating-ip: [84.53.141.190]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ff87396-4960-45c7-a919-08d6ca165403
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN1PR12MB2464;
x-ms-traffictypediagnostic: SN1PR12MB2464:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <SN1PR12MB24646B7BC9EFE00BDB4114FFA73E0@SN1PR12MB2464.namprd12.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(346002)(376002)(39850400004)(189003)(199004)(31014005)(478600001)(316002)(52536014)(25786009)(33656002)(6436002)(966005)(14454004)(54906003)(99286004)(3846002)(2906002)(71200400001)(71190400001)(6116002)(55016002)(256004)(446003)(97736004)(476003)(4326008)(486006)(305945005)(7736002)(74316002)(14444005)(6246003)(6916009)(6506007)(229853002)(81166006)(53546011)(73956011)(9686003)(64756008)(26005)(76116006)(8936002)(66946007)(102836004)(5660300002)(66066001)(7696005)(66476007)(76176011)(66446008)(66556008)(6306002)(91956017)(93886005)(68736007)(81156014)(53936002)(186003)(8676002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR12MB2464;H:SN1PR12MB2431.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hL2ihNDLnXV6XNdazp3uc2UHHMGaVkB6m2M1VIL1cGspw92oBd689FPcLx7ICj2gdRbaOtdhFHsGn73k3Qdqxi9yB5afpqq3hv9X8cgjk6OE7NoXHpZ3pJq660QZuFdALd6TgTF6RktM2bAYKKqnE3zVkZ3dnMmB+6fmU1NdPagz+zJAtS/VvZJ3DNj6CIwT1cGQ+wxsehH4c/dw1ToYIAQ1lhbBlEHWrKmV6EQdu/dh/lSmn2ov1z7JCTho5GLMwWrZJcrF+CVnG4D42uhanzOM34gjSzEd5YsAjIzxdOMR4ZXfkPmj68s6zew9AftmNIrVmaMJjJdDTAowoHqxgjgftFr0jtoTIGDhxJ0XYNMgTHVk4Bibl2AaxtzYBKhjzqxIizM3dwVgxM1R5iw8tejRwc8SjS8ZospBRO1YLZ8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff87396-4960-45c7-a919-08d6ca165403
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 07:10:56.6050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2464
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,=0A=
=0A=
On 4/26/2019 00:13, Doug Anderson wrote:=0A=
> Hi,=0A=
> =0A=
> On Thu, Apr 25, 2019 at 7:01 AM Artur Petrosyan=0A=
> <Arthur.Petrosyan@synopsys.com> wrote:=0A=
>>=0A=
>> Hi,=0A=
>>=0A=
>> On 4/25/2019 16:43, Felipe Balbi wrote:=0A=
>>> Artur Petrosyan <Arthur.Petrosyan@synopsys.com> writes:=0A=
>>>> This patch set, fixes and improves partial power down and hibernation =
power=0A=
>>>> saving modes. Also, adds support for entering/exiting hibernation by=
=0A=
>>>> system issued suspend/resume.=0A=
>>>>=0A=
>>>> This series contains patches which were submitted to LKML. However, a =
part=0A=
>>>> of those patches didn't reach to LKML because of local issue related t=
o=0A=
>>>> smtp server.=0A=
>>>>=0A=
>>>> The patches which reached to LKML are:=0A=
>>>>=0A=
>>>> - usb: dwc2: Add part. power down exit from dwc2_conn_id_status_change=
().=0A=
>>>> - usb: dwc2: Add port conn. sts. checking in _dwc2_hcd_resume() functi=
on.=0A=
>>>> - usb: dwc2: Fix suspend state in host mode for partial power down.=0A=
>>>> - usb: dwc2: Fix wakeup detected and session request interrupt handler=
s.=0A=
>>>> - usb: dwc2: Add descriptive debug messages for Partial Power Down mod=
e.=0A=
>>>> - usb: dwc2: Fix dwc2_restore_device_registers() function.=0A=
>>>>=0A=
>>>> The patches which didn't reach to LKML are:=0A=
>>>>=0A=
>>>> - usb: dwc2: Add enter/exit hibernation from system issued suspend/res=
ume=0A=
>>>> - usb: dwc2: Clear GINTSTS_RESTOREDONE bit after restore is generated.=
=0A=
>>>> - usb: dwc2: Clear fifo_map when resetting core.=0A=
>>>> - usb: dwc2: Allow exiting hibernation from gpwrdn rst detect=0A=
>>>> - usb: dwc2: Fix hibernation between host and device modes.=0A=
>>>> - usb: dwc2: Update dwc2_handle_usb_suspend_intr function.=0A=
>>>> - usb: dwc2: Add default param to control power optimization.=0A=
>>>> - usb: dwc2: Reset DEVADDR after exiting gadget hibernation.=0A=
>>>>=0A=
>>>> Submitting all of the patches together in this version.=0A=
>>>>=0A=
>>>> Changes from V0:=0A=
>>>>    - Replaced 1 with DWC2_POWER_DOWN_PARAM_PARTIAL in commit=0A=
>>>>      "9eed02b9fe96 usb: dwc2: Fix wakeup detected and session request=
=0A=
>>>>      interrupt handlers.=0A=
>>>>=0A=
>>>>=0A=
>>>> Artur Petrosyan (14):=0A=
>>>>     usb: dwc2: Fix dwc2_restore_device_registers() function.=0A=
>>>>     usb: dwc2: Add descriptive debug messages for Partial Power Down m=
ode.=0A=
>>>>     usb: dwc2: Fix wakeup detected and session request interrupt handl=
ers.=0A=
>>>>     usb: dwc2: Fix suspend state in host mode for partial power down.=
=0A=
>>>>     usb: dwc2: Add port conn. sts. checking in _dwc2_hcd_resume()=0A=
>>>>       function.=0A=
>>>>     usb: dwc2: Add part. power down exit from=0A=
>>>>       dwc2_conn_id_status_change().=0A=
>>>>     usb: dwc2: Reset DEVADDR after exiting gadget hibernation.=0A=
>>>>     usb: dwc2: Add default param to control power optimization.=0A=
>>>>     usb: dwc2: Update dwc2_handle_usb_suspend_intr function.=0A=
>>>>     usb: dwc2: Fix hibernation between host and device modes.=0A=
>>>>     usb: dwc2: Allow exiting hibernation from gpwrdn rst detect=0A=
>>>>     usb: dwc2: Clear fifo_map when resetting core.=0A=
>>>>     usb: dwc2: Clear GINTSTS_RESTOREDONE bit after restore is generate=
d.=0A=
>>>>     usb: dwc2: Add enter/exit hibernation from system issued=0A=
>>>>       suspend/resume=0A=
>>>=0A=
>>> patches don't apply.=0A=
>>>=0A=
>>=0A=
>> Do we need to wait for Minas's acknowledge or there is problem related=
=0A=
>> to the patches?=0A=
> =0A=
> It looks like the problem is that my patches won the race and Felipe=0A=
> applied them before yours.  Thus, presumably, it'll be up to you to=0A=
> rebase your patches atop mine and re-submit.  Specifically, you can=0A=
> do:=0A=
> =0A=
> git remote add linux_usb_balbi=0A=
> git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git=0A=
> git fetch linux_usb_balbi=0A=
> git checkout linux_usb_balbi/testing/next=0A=
> =0A=
> If you do that and then try to apply your patches you'll find that=0A=
> they no longer apply.  AKA try running:=0A=
> =0A=
> for patch in 10909749 10909737 10909739 10909745 10909533 \=0A=
>     10909531 10909747 10909535 10909523 10909741 10909525 \=0A=
>     10909751 10909527 10909743; do=0A=
>    curl -L https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__patchwo=
rk.kernel.org_patch_-24-257Bpatch-257D_mbox&d=3DDwIBaQ&c=3DDPL6_X_6JkXFx7AX=
WqB0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_HlVzYqrC_D7niMJI&m=3DgzzEDEbxflLMgk9I=
-7Re9ytRMvyc_B8iZEmg2xGZN5E&s=3DaWT1hYtXeIeY8ClQ0sNYxwkmJFKDz4iaa4DchNwx3_w=
&e=3D | git am=0A=
> done=0A=
> =0A=
> You'll see:=0A=
> =0A=
>> Applying: usb: dwc2: Fix wakeup detected and session request interrupt h=
andlers.=0A=
>> error: patch failed: drivers/usb/dwc2/core_intr.c:435=0A=
>> error: drivers/usb/dwc2/core_intr.c: patch does not apply=0A=
>> Patch failed at 0001 usb: dwc2: Fix wakeup detected and session request =
interrupt handlers.=0A=
> =0A=
> NOTE: before reposting it might be a good idea to apply the last 3=0A=
> patches in my series as per [1] before sending up your series.  Since=0A=
> Felipe has already applied patches #1 and #2 in that series presumably=0A=
> he'll also apply #3 - #5.=0A=
> =0A=
> I know it'a also up to me to try testing our your patches.  It's still=0A=
> on my list to give it a shot...=0A=
> =0A=
> [1] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.kernel.or=
g_r_CAD-3DFV-3DWA07-2BgUkVvsikN-3DiDHZLUJQtzjkKtiBHAEDw4gLNWY7w-40mail.gmai=
l.com&d=3DDwIBaQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_=
HlVzYqrC_D7niMJI&m=3DgzzEDEbxflLMgk9I-7Re9ytRMvyc_B8iZEmg2xGZN5E&s=3D9QP_h5=
ZlnT7ayUE1_6EVEgu8FaI3_kWm9xuzs1qrvdI&e=3D=0A=
> =0A=
> P.S: It's helpful if you CC LKML on patches and discussions about=0A=
> them.  That allows the magic "permalink via message ID" on=0A=
> lkml.kernel.org and also allows your patches to be found on=0A=
> lore.kernel.org/patchwork/=0A=
> =0A=
> -Doug=0A=
> =0A=
=0A=
Besides the issue that comes from the patch "usb: dwc2: Fix wakeup =0A=
detected and session request interrupt handlers." there is one more =0A=
serious conflict with one of your patches.=0A=
=0A=
So the patch "usb: dwc2: bus suspend/resume for hosts with =0A=
DWC2_POWER_DOWN_PARAM_NONE" have had also been added to the =0A=
"balbi/testing/next" before my patch series which conflicts with two of =0A=
my patches.=0A=
=0A=
1. usb: dwc2: Fix suspend state in host mode for partial power down.=0A=
2. usb: dwc2: Add enter/exit hibernation from system issued suspend/resume=
=0A=
=0A=
This patch introduced by you "usb: dwc2: bus suspend/resume for hosts =0A=
with DWC2_POWER_DOWN_PARAM_NONE" got a little bit of issue. It =0A=
eliminates entering hibernation through system issued suspend by =0A=
checking "if (hsotg->params.power_down > DWC2_POWER_DOWN_PARAM_PARTIAL)" =
=0A=
. As per the patch you mention that it fixes suspend/resume flow for =0A=
Altera SOCFPGA and Chrome OS 3.14 kernel tree. I assume that the board =0A=
has the Partial Power Down enabled core that is why it works out. =0A=
However, we don't just support the Partial Power Down feature enabled =0A=
cores. We also support Hibernation feature enabled cores.=0A=
=0A=
The patch set that had been introduced by me which includes "usb: dwc2: =0A=
Add enter/exit hibernation from system issued suspend/resume" patch adds =
=0A=
support for both hibernation and Partial Power Down feature enabled =0A=
cores and fixes several of Partial Power Down and hibernation related =0A=
issues.=0A=
=0A=
This patch set may fix all of the issues related with Altera SOCFPGA or=0A=
Chrome OS 3.14 kernel tree.=0A=
=0A=
That is why we asked you to test the patch set before we could ACK or =0A=
have chance to debug your patch deeper to see the help of it and to =0A=
provide you information related to it.=0A=
=0A=
So now I can rebase my changes to the "balbi/testing/next" but I will =0A=
have to take the logic of skipping Hibernation out otherwise we will =0A=
have problems with hibernation enabled cores.=0A=
=0A=
We can ask Balbi to permanently suspend adding of the patch "usb: dwc2: =0A=
bus suspend/resume for hosts with DWC2_POWER_DOWN_PARAM_NONE" and my =0A=
patch series to his "testing/next". After you can have a chance to test =0A=
my patch series we can see if the patches are acknowledged and ask Balbi =
=0A=
  to add them.=0A=
=0A=
-- =0A=
Regards,=0A=
Artur=0A=
