Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7270AC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 23:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CF22145D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 23:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Mwm1+mM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfEIX7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 19:59:47 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:53444 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726701AbfEIX7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 19:59:47 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1DA2DC00D0;
        Thu,  9 May 2019 23:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557446390; bh=EnqrzmpzPbj+nGgnpyTF6VzPxqLccG3bhMGQETJ3X8c=;
        h=From:To:CC:Subject:Date:References:From;
        b=Mwm1+mM2RVhLnJUa6D1AJx3dhWWhijAAloSjByMrWk0GErXdoZcGJgIvqxb04DICq
         4Rd8dHDIf+eUdbZTU/S6yP3HNZlbHbwibdu5L8p83z+LT9GYKw7chIaRKA1vto5trE
         yM+dNdFMW0qnGR7rLSK+WEjYrAzSD898OoDpaun3KVo9DXfP/eATtMQRk8RNIx9d2G
         sbaiHMMrlT2/vmSsITdWIQ44RwsifsAp/mmqpusjPXgIy+rz2pf7lVIuvblZKs2mea
         GMtQbSkfRHvlw3hl6h3TAAzl6VawULLss2hQpwZc+b1hEzH446Wh56q1Vgi1o/F866
         WA3d2nrj3UX5w==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 936DFA005D;
        Thu,  9 May 2019 23:59:45 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.223]) by
 US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Thu,
 9 May 2019 16:59:45 -0700
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
Date:   Thu, 9 May 2019 23:59:43 +0000
Message-ID: <30102591E157244384E984126FC3CB4F639E9E8F@us01wembx1.internal.synopsys.com>
References: <1557302091-7455-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1557302091-7455-4-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <30102591E157244384E984126FC3CB4F639E9823@us01wembx1.internal.synopsys.com>
 <BL0PR02MB5587B28B6CCAC0FD790F8335A7330@BL0PR02MB5587.namprd02.prod.outlook.com>
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

Hi Anurag,=0A=
=0A=
Anurag Kumar Vulisha wrote:=0A=
>>> +		return -EINVAL;=0A=
>>>=0A=
>>>  	reg =3D dwc3_readl(dwc->regs, DWC3_DCTL);=0A=
>>>  	if (set)=0A=
>>> @@ -626,7 +630,10 @@ static int dwc3_ep0_set_config(struct dwc3 *dwc, s=
truct=0A=
>> usb_ctrlrequest *ctrl)=0A=
>>>  			 * nothing is pending from application.=0A=
>>>  			 */=0A=
>>>  			reg =3D dwc3_readl(dwc->regs, DWC3_DCTL);=0A=
>>> -			reg |=3D (DWC3_DCTL_ACCEPTU1ENA |=0A=
>> DWC3_DCTL_ACCEPTU2ENA);=0A=
>>> +			if (!dwc->dis_u1_entry_quirk)=0A=
>>> +				reg |=3D DWC3_DCTL_ACCEPTU1ENA;=0A=
>>> +			if (!dwc->dis_u2_entry_quirk)=0A=
>>> +				reg |=3D DWC3_DCTL_ACCEPTU2ENA;=0A=
>>>  			dwc3_writel(dwc->regs, DWC3_DCTL, reg);=0A=
>>>  		}=0A=
>>>  		break;=0A=
>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c=0A=
>>> index e293400..f2d3112 100644=0A=
>>> --- a/drivers/usb/dwc3/gadget.c=0A=
>>> +++ b/drivers/usb/dwc3/gadget.c=0A=
>>> @@ -2073,6 +2073,24 @@ static int dwc3_gadget_stop(struct usb_gadget *g=
)=0A=
>>>  	return 0;=0A=
>>>  }=0A=
>>>=0A=
>>> +static void dwc3_gadget_config_params(struct usb_gadget *g,=0A=
>>> +				      struct usb_dcd_config_params *params)=0A=
>>> +{=0A=
>>> +	struct dwc3		*dwc =3D gadget_to_dwc(g);=0A=
>>> +=0A=
>>> +	/* U1 Device exit Latency */=0A=
>>> +	if (dwc->dis_u1_entry_quirk)=0A=
>>> +		params->bU1devExitLat =3D 0;=0A=
>> It doesn't make sense to have exit latency of 0. Rejecting=0A=
>> SET_FEATURE(enable U1/U2) should already let the host know that the=0A=
>> device doesn't support U1/U2.=0A=
>>=0A=
> I am okay to remove this, but I feel that it is better to report zero val=
ue instead=0A=
> of a non-zero value in exit latency of BOS when U1 or U2 entries are not =
supported. =0A=
> Advantage of reporting 0 is that some hosts doesn't even send SET_FEATURE=
(U1/U2)=0A=
> requests on seeing zero value in BOS descriptor. Also there can be cases =
where U1 is=0A=
> disabled and U2 entry is allowed or vice versa, for these kind of cases t=
he driver can=0A=
> set zero exit latency value for U1 and non-zero exit latency value for U2=
 . Based on this=0A=
> I think it would be better to report 0 when U1/U2 states are not enabled.=
 Please provide=0A=
> your opinion on this.=0A=
=0A=
Hm... I assume you're testing against linux usb stack and xhci host. If=0A=
that's the case, it looks like host will still request the device to=0A=
enter U1/U2 despite the device rejecting SET_FEATURE(enable U1/U2). This=0A=
needs to be fixed. I think what you have is fine to workaround this issue.=
=0A=
=0A=
Thanks,=0A=
Thinh=0A=
