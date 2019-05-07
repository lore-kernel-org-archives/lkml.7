Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577BBC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DE220989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HSkHZwLl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="IWjUFCCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfEGHFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 03:05:52 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:53238 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726558AbfEGHFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 03:05:52 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 74765C01E7;
        Tue,  7 May 2019 07:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557212746; bh=UZC/NRc6Xdr1ZOxpEVn7WONo+nXBMm+s6S16TQtruXE=;
        h=From:To:CC:Subject:Date:References:From;
        b=HSkHZwLl0089pS8598+q2iene4Dcd8tdxQzTU1XMTt/tOBS3TaLsNFcXzvhBeFwU0
         Bspxf+5JSpZbxf3I7B/b4qMR/Nda8Iof/+LiHP/Z8u1G95hpQw1vqkLw9zC/qgI9dU
         jzjJmhcoG5u8UsKsbOiAjP9rfHmgfbY64c9q/Q6zVWTiUSWOPAZ85+9Yzs89s7iK7p
         8FslszdAQsiG7mh4zWCHW2vjHPMdSVgusaSxjfBlkOrF3x9ceSr/3SS5mxoZapjpHO
         VV1iDN5laBvgSQqQP64dIQV7N256l/2xD19G/xNrcSIlCXUQi8mN35iQ03NtvtexS8
         a8vpA7d/sbe5Q==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id F30C5A0095;
        Tue,  7 May 2019 07:05:47 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 7 May 2019 00:05:47 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 7 May 2019 00:05:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oosWBMgy/3s2+Mq3tB+lAiFIauPKwxtXKXLLHn3ypeE=;
 b=IWjUFCCoaTfkILce1sf8T64WKpnQqgG2zGgo/tpneWhJpcQm9Uq/TQattOQfuLt1VJhbHeERHI/HtdZxinZhalvj6FZtwnxB+TdwNBwDHdAQG+BDc/js6CqjTf4VbqHwxm17lLfzUmVr238FvZtwR4KjRWwTaTXuedkVKijgNFU=
Received: from SN1PR12MB2431.namprd12.prod.outlook.com (52.132.195.146) by
 SN1PR12MB2480.namprd12.prod.outlook.com (52.132.196.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Tue, 7 May 2019 07:05:45 +0000
Received: from SN1PR12MB2431.namprd12.prod.outlook.com
 ([fe80::1982:4b45:2adf:9a1f]) by SN1PR12MB2431.namprd12.prod.outlook.com
 ([fe80::1982:4b45:2adf:9a1f%4]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 07:05:45 +0000
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
To:     Doug Anderson <dianders@chromium.org>
CC:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        =?iso-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexandru M Stan <amstan@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        William Wu <william.wu@rock-chips.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Randy Li <ayaka@soulik.info>, Chris <zyw@rock-chips.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        "Julius Werner" <jwerner@chromium.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] usb: dwc2: bus suspend/resume for hosts with
 DWC2_POWER_DOWN_PARAM_NONE
Thread-Topic: [PATCH v2 1/5] usb: dwc2: bus suspend/resume for hosts with
 DWC2_POWER_DOWN_PARAM_NONE
Thread-Index: AQHU9XvT/eL2bASAskajIQu3Y3ICkw==
Date:   Tue, 7 May 2019 07:05:45 +0000
Message-ID: <SN1PR12MB243183AAC5636C23144634FBA7310@SN1PR12MB2431.namprd12.prod.outlook.com>
References: <20190418001356.124334-1-dianders@chromium.org>
 <20190418001356.124334-2-dianders@chromium.org>
 <CAD=FV=UGjQz9Di=NL_r_g1Hofqv-FWBywfSm9Vu6gGr22wzPrA@mail.gmail.com>
 <SN1PR12MB243136608514210F3E3E536EA7350@SN1PR12MB2431.namprd12.prod.outlook.com>
 <CAD=FV=V97+_cQ1aD=w_a3SifGOG3M5DPvcnvxYVUJMkX_WLTFg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arturp@synopsys.com; 
x-originating-ip: [23.201.30.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29437df8-1b63-41c6-b375-08d6d2ba6d1e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:SN1PR12MB2480;
x-ms-traffictypediagnostic: SN1PR12MB2480:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <SN1PR12MB24804DCFF30D0EA71522CC6CA7310@SN1PR12MB2480.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:294;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(376002)(366004)(396003)(346002)(136003)(189003)(199004)(55674003)(8676002)(71200400001)(8936002)(76176011)(71190400001)(55016002)(476003)(6916009)(81166006)(9686003)(81156014)(6306002)(7736002)(74316002)(5660300002)(52536014)(7416002)(229853002)(14454004)(33656002)(316002)(6436002)(86362001)(478600001)(7696005)(486006)(966005)(99286004)(53936002)(6506007)(3846002)(186003)(102836004)(66446008)(64756008)(66556008)(66476007)(53546011)(6246003)(54906003)(6116002)(305945005)(66066001)(26005)(25786009)(68736007)(256004)(446003)(15650500001)(73956011)(66946007)(2906002)(76116006)(14444005)(4326008)(91956017);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR12MB2480;H:SN1PR12MB2431.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yNni9roYFD9aphHVuRtUx+6CaKJQdeU4KZtxxmffcJTNDsUF3yNZQ8BjVztcd98KRZI9/OZfCqXMrc2vkxL1aenX22NU0JTnfLowIGV7oAqeEqoKSzM2Z36zRrHxDXoWzg8i0miLrkIr3aTbOTuGyIRpx8LHK0b52dkRv4WdWLB2LoO08tKpuW4vfr5yehp4hzraP+pblAmxEVS54dSygqMGDOSPiMmrNyeOj/17AMfTs6IoDD7ak3tR3nGA5QCKLnfHk9+sHlqOyTPlMvvkjKNWKa0Dd4wGlavr3/nVUUsd1vZcyHxPqEqO3MMNUibTKncMxSf0iuNxa7gWxBLOlcZTuDZRO5WxPP65vNmlHLkUcq4k0anijHFbHSJc4vdLV7JOPzlNj3ZPr8vxMBMVrVTB8HBDHigxSCs9VrIYj/Y=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 29437df8-1b63-41c6-b375-08d6d2ba6d1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 07:05:45.5422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2480
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=0A=
=0A=
On 5/3/2019 19:08, Doug Anderson wrote:=0A=
> Hi,=0A=
> =0A=
> On Fri, May 3, 2019 at 1:25 AM Artur Petrosyan=0A=
> <Arthur.Petrosyan@synopsys.com> wrote:=0A=
>>=0A=
>> On 5/2/2019 03:58, Doug Anderson wrote:=0A=
>>> Hi,=0A=
>>>=0A=
>>>=0A=
>>> On Wed, Apr 17, 2019 at 5:15 PM Douglas Anderson <dianders@chromium.org=
> wrote:=0A=
>>>>=0A=
>>>> This is an attempt to rehash commit 0cf884e819e0 ("usb: dwc2: add bus=
=0A=
>>>> suspend/resume for dwc2") on ToT.  That commit was reverted in commit=
=0A=
>>>> b0bb9bb6ce01 ("Revert "usb: dwc2: add bus suspend/resume for dwc2"")=
=0A=
>>>> because apparently it broke the Altera SOCFPGA.=0A=
>>>>=0A=
>>>> With all the changes that have happened to dwc2 in the meantime, it's=
=0A=
>>>> possible that the Altera SOCFPGA will just magically work with this=0A=
>>>> change now.  ...and it would be good to get bus suspend/resume=0A=
>>>> implemented.=0A=
>>>>=0A=
>>>> This change is a forward port of one that's been living in the Chrome=
=0A=
>>>> OS 3.14 kernel tree.=0A=
>>>>=0A=
>>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>=0A=
>>>> ---=0A=
>>>> This patch was last posted at:=0A=
>>>>=0A=
>>>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.kernel.org=
_r_1446237173-2D15263-2D1-2Dgit-2Dsend-2Demail-2Ddianders-40chromium.org&d=
=3DDwIBaQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_HlVzYqr=
C_D7niMJI&m=3D7rxT8EFX9mqUDtTL4P7iuzYNsYROe9rxHGCresSKPTg&s=3DlTaNUA2XIYPat=
417fkd1A4Zpvb5eyYtTc1H_NIfW8Vw&e=3D=0A=
>>>>=0A=
>>>> ...and appears to have died the death of silence.  Maybe it could get=
=0A=
>>>> some bake time in linuxnext if we can't find any proactive testing?=0A=
>>>>=0A=
>>>> I will also freely admit that I don't know tons about the theory=0A=
>>>> behind this patch.  I'm mostly just re-hashing the original commit=0A=
>>>> from Kever that was reverted since:=0A=
>>>> * Turning on partial power down on rk3288 doesn't "just work".  I=0A=
>>>>     don't get hotplug events.  This is despite dwc2 auto-detecting tha=
t=0A=
>>>>     we are power optimized.=0A=
>>>> * If we don't do something like this commit we don't get into as low=
=0A=
>>>>     of a power mode.=0A=
>>>=0A=
>>> OK, I spent the day digging more into this patch to confirm that it's=
=0A=
>>> really the right thing to do.  ...and it still seems to be.=0A=
>>>=0A=
>>> First off: I'm pretty sure the above sentence "If we don't do=0A=
>>> something like this commit we don't get into as low of a power mode."=
=0A=
>>> is totally wrong.  Luckily it's "after the cut" and not part of the=0A=
>>> commit message.  Specifically I did a bunch of power testing and I=0A=
>>> couldn't find any instance saving power after this patch.=0A=
>>>=0A=
>>> ...but, then I looked more carefully at all the history of this=0A=
>>> commit.  I ended up at:=0A=
>>>=0A=
>>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__chromium-2Drevie=
w.googlesource.com_c_chromiumos_third-5Fparty_kernel_-2B_306265_&d=3DDwIBaQ=
&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_HlVzYqrC_D7niMJI=
&m=3D7rxT8EFX9mqUDtTL4P7iuzYNsYROe9rxHGCresSKPTg&s=3DLiyyIyaCPmr88nJeI7TCGt=
oJBFLRWir_reikYtAHHDw&e=3D=0A=
>> Looking at this code review I see that this patch fixes whatever issues=
=0A=
>> you have on Chrome OS 3.14. But your patch has landed on the top of=0A=
>> latest Kernel version. With the latest version I think you would not=0A=
>> have the regression issue.=0A=
>> So you are fixing Chrome OS 3.14.=0A=
> =0A=
> I'm confused why you ignored the rest of my email where I said I also=0A=
> ported it to 4.19 (which, from a dwc2 host point of view, is pretty=0A=
> much mainline) and saw that the patch was still needed.=0A=
I didn't ignore it just I had to perform testes and reply to it with =0A=
another email.=0A=
> =0A=
> -Doug=0A=
> =0A=
I spent yesterday debugging and performing testes with Linux Mainline. =0A=
So when we don't have any of power saving modes supported and the =0A=
power_down is DWC2_POWER_DOWN_PARAM_NONE. We can set "PCGCTL_STOPPCLK" =0A=
bit whenever there is suspend ( Checked the programming guide and data =0A=
book). I have not seen any case that this affects the flow. I have not =0A=
been able to see if after setting "PCGCTL_STOPPCLK" bit there is any =0A=
power saved or driver behaved differently. Maybe it is platform depended =
=0A=
. However, there is a possibility that this might save power.=0A=
=0A=
So as this is not breaking anything. I am ok with this patch.=0A=
=0A=
-- =0A=
Regards,=0A=
Artur=0A=
