Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A1EC04A6B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 01:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DE521851
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 01:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XtgM9GTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbfEKBsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 21:48:09 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:49490 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728079AbfEKBsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 21:48:09 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F3DE0C0124;
        Sat, 11 May 2019 01:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557539292; bh=R+2S9hsN1O5pmtXZq6Xo+Py+Mo7znMvzY7NQ1w6aRuc=;
        h=From:To:CC:Subject:Date:References:From;
        b=XtgM9GTpl55k80QjAD+ci8SIxofSWGqGw4Q2n8jHKiThjsShWvcNufFXyjng5/QtE
         TN2HKLtUnKK+YdklZzJ3FoBQVxvDglqn0O6enSYPn6U4BRQaeSpGFbsA8YQCdKwmVB
         Ooj/KewOyep5Q9rTGcgvFOoYJjlgdowldf/DeI56hWZcNfUWcfqLfmheCo3hXggcr2
         aZXLmA9kkn2MWg+oDiHwo1lEFhRY0Q5qRnVrUS8lit+HebE+7Y8fO9TaPrIEGkpODH
         6OrjYqK9xfEh6GhKr1ruFaLcYXNQE2wepPEUEV2evzNlNiri5MFMG5onSMz0v8d4jV
         +K95ofipmBklw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1D1E4A0077;
        Sat, 11 May 2019 01:48:07 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.223]) by
 us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Fri, 10
 May 2019 18:48:07 -0700
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Anurag Kumar Vulisha <anuragku@xilinx.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Felipe Balbi" <balbi@kernel.org>,
        "Claus H. Stovgaard" <cst@phaseone.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>
Subject: Re: [PATCH v2 3/3] usb: dwc3: gadget: Add support for disabling U1
 and U2 entries
Thread-Topic: [PATCH v2 3/3] usb: dwc3: gadget: Add support for disabling U1
 and U2 entries
Thread-Index: AQHVBXNg9QMnfODDx0qS+2/7kcKJQQ==
Date:   Sat, 11 May 2019 01:48:06 +0000
Message-ID: <30102591E157244384E984126FC3CB4F639EA444@us01wembx1.internal.synopsys.com>
References: <1557302091-7455-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1557302091-7455-4-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <30102591E157244384E984126FC3CB4F639E9823@us01wembx1.internal.synopsys.com>
 <BL0PR02MB5587B28B6CCAC0FD790F8335A7330@BL0PR02MB5587.namprd02.prod.outlook.com>
 <30102591E157244384E984126FC3CB4F639E9E8F@us01wembx1.internal.synopsys.com>
 <BYAPR02MB55913E2D6F6865202DE88514A70C0@BYAPR02MB5591.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.184.19]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=0A=
=0A=
Anurag Kumar Vulisha wrote:=0A=
> Hi Thinh,=0A=
>=0A=
>> -----Original Message-----=0A=
>> From: Thinh Nguyen [mailto:Thinh.Nguyen@synopsys.com]=0A=
>> Sent: Friday, May 10, 2019 5:30 AM=0A=
>> To: Anurag Kumar Vulisha <anuragku@xilinx.com>; Thinh Nguyen=0A=
>> <Thinh.Nguyen@synopsys.com>; Greg Kroah-Hartman=0A=
>> <gregkh@linuxfoundation.org>; Rob Herring <robh+dt@kernel.org>; Mark Rut=
land=0A=
>> <mark.rutland@arm.com>; Felipe Balbi <balbi@kernel.org>; Claus H. Stovga=
ard=0A=
>> <cst@phaseone.com>=0A=
>> Cc: linux-usb@vger.kernel.org; devicetree@vger.kernel.org; linux-=0A=
>> kernel@vger.kernel.org; v.anuragkumar@gmail.com=0A=
>> Subject: Re: [PATCH v2 3/3] usb: dwc3: gadget: Add support for disabling=
 U1 and U2=0A=
>> entries=0A=
>>=0A=
>> Hi Anurag,=0A=
>>=0A=
>> Anurag Kumar Vulisha wrote:=0A=
>>>>> +		return -EINVAL;=0A=
>>>>>=0A=
>>>>>  	reg =3D dwc3_readl(dwc->regs, DWC3_DCTL);=0A=
>>>>>  	if (set)=0A=
>>>>> @@ -626,7 +630,10 @@ static int dwc3_ep0_set_config(struct dwc3 *dwc,=
=0A=
>> struct=0A=
>>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c=0A=
>>>>> index e293400..f2d3112 100644=0A=
>>>>> --- a/drivers/usb/dwc3/gadget.c=0A=
>>>>> +++ b/drivers/usb/dwc3/gadget.c=0A=
>>>>> @@ -2073,6 +2073,24 @@ static int dwc3_gadget_stop(struct usb_gadget =
*g)=0A=
>>>>>  	return 0;=0A=
>>>>>  }=0A=
>>>>>=0A=
>>>>> +static void dwc3_gadget_config_params(struct usb_gadget *g,=0A=
>>>>> +				      struct usb_dcd_config_params *params)=0A=
>>>>> +{=0A=
>>>>> +	struct dwc3		*dwc =3D gadget_to_dwc(g);=0A=
>>>>> +=0A=
>>>>> +	/* U1 Device exit Latency */=0A=
>>>>> +	if (dwc->dis_u1_entry_quirk)=0A=
>>>>> +		params->bU1devExitLat =3D 0;=0A=
>>>> It doesn't make sense to have exit latency of 0. Rejecting=0A=
>>>> SET_FEATURE(enable U1/U2) should already let the host know that the=0A=
>>>> device doesn't support U1/U2.=0A=
>>>>=0A=
>>> I am okay to remove this, but I feel that it is better to report zero v=
alue instead=0A=
>>> of a non-zero value in exit latency of BOS when U1 or U2 entries are no=
t supported.=0A=
>>> Advantage of reporting 0 is that some hosts doesn't even send=0A=
>> SET_FEATURE(U1/U2)=0A=
>>> requests on seeing zero value in BOS descriptor. Also there can be case=
s where U1 is=0A=
>>> disabled and U2 entry is allowed or vice versa, for these kind of cases=
 the driver can=0A=
>>> set zero exit latency value for U1 and non-zero exit latency value for =
U2 . Based on=0A=
>> this=0A=
>>> I think it would be better to report 0 when U1/U2 states are not enable=
d. Please=0A=
>> provide=0A=
>>> your opinion on this.=0A=
>> Hm... I assume you're testing against linux usb stack and xhci host. If=
=0A=
>> that's the case, it looks like host will still request the device to=0A=
>> enter U1/U2 despite the device rejecting SET_FEATURE(enable U1/U2). This=
=0A=
>> needs to be fixed. I think what you have is fine to workaround this issu=
e.=0A=
> Thanks . Will send the next series with the other fixes that you have sug=
gested=0A=
>=0A=
> Best Regards,=0A=
> Anurag Kumar Vulisha=0A=
>=0A=
=0A=
I want to try something. Can you see if this helps with your performance=0A=
test without setting the U1/U2 exit latency to 0?=0A=
(No need to change what you have in your patch. This is just for testing).=
=0A=
=0A=
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c=0A=
index 2f94568ba385..619351c581cf 100644=0A=
--- a/drivers/usb/core/hub.c=0A=
+++ b/drivers/usb/core/hub.c=0A=
@@ -4057,8 +4057,18 @@ static void usb_enable_link_state(struct usb_hcd=0A=
*hcd, struct usb_device *udev,=0A=
                /* Only a configured device will accept the Set Feature=0A=
                 * U1/U2_ENABLE=0A=
                 */=0A=
-               if (udev->actconfig)=0A=
-                       usb_set_device_initiated_lpm(udev, state, true);=0A=
+               if (udev->actconfig) {=0A=
+                       if (usb_set_device_initiated_lpm(udev, state,=0A=
true)) {=0A=
+                               /*=0A=
+                                * Don't request U1/U2 entry if the device=
=0A=
+                                * cannot enable U1/U2.=0A=
+                                */=0A=
+                               usb_set_lpm_timeout(udev, state, 0);=0A=
+                              =0A=
hcd->driver->disable_usb3_lpm_timeout(hcd, udev,=0A=
+                                                                    =0A=
state);=0A=
+                               return;=0A=
+                       }=0A=
+               }=0A=
 =0A=
                /* As soon as usb_set_lpm_timeout(timeout) returns 0, the=
=0A=
                 * hub-initiated LPM is enabled. Thus, LPM is enabled no=0A=
=0A=
=0A=
Thanks,=0A=
Thinh=0A=
