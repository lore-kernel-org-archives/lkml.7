Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEA8C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584C620675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Zx6RWQrt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfEGSmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 14:42:23 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:60322 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727264AbfEGSmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 14:42:22 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 757FAC01AC;
        Tue,  7 May 2019 18:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557254545; bh=+Kw/M/wsl5I8kh5Zi1eVVOvgVSMbvlURKUyvYUBDAzs=;
        h=From:To:CC:Subject:Date:References:From;
        b=Zx6RWQrtlJ5nSATgWJQV/eeZHNA5htBlJrpji0erd6qjO17eNzjyOmnkvRl4ulo5i
         OtueF2YJPjUeBV6UzPgz+tSZUI6rVngGMyK2rvxk+IS7nNKfBn2MJacMQNC9iUzDTW
         cxDrgIK+4Mzfl2KIHgaBIcUVjnDMWUicEpX3M6XogOpbdHqTAjV9C8Gu0AiMfR9J7S
         O83jp5hAH2cu3Y0JcfeTelwdPffd5RR9GdO/dsgQW05YDGlRkA5LeMldLc6cYZ3m91
         A+9x0gGYzekJGsKgc81W0c1bztPdyXfrJ6vvGwOky08o63G68HVedrP1A0WMaZFY+Q
         ACZVB8tOpJQqw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id C4824A006B;
        Tue,  7 May 2019 18:42:21 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.223]) by
 us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue, 7
 May 2019 11:42:21 -0700
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Anurag Kumar Vulisha <anuragku@xilinx.com>,
        "Claus H. Stovgaard" <cst@phaseone.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>
Subject: Re: [PATCH 3/3] usb: dwc3: gadget: Add support for disabling U1 and
 U2 entries
Thread-Topic: [PATCH 3/3] usb: dwc3: gadget: Add support for disabling U1
 and U2 entries
Thread-Index: AQHVANC7IojVFwqibkuorQOh5WYjBw==
Date:   Tue, 7 May 2019 18:42:20 +0000
Message-ID: <30102591E157244384E984126FC3CB4F639E9035@us01wembx1.internal.synopsys.com>
References: <1556792423-4833-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1556792423-4833-4-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <30102591E157244384E984126FC3CB4F639E7BA8@us01wembx1.internal.synopsys.com>
 <1557176302.18203.20.camel@phaseone.com>
 <BYAPR02MB55918A76A1567C3209860748A7310@BYAPR02MB5591.namprd02.prod.outlook.com>
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
> Hi Claus,=0A=
>=0A=
>> -----Original Message-----=0A=
>> From: Claus H. Stovgaard [mailto:cst@phaseone.com]=0A=
>> Sent: Tuesday, May 07, 2019 2:28 AM=0A=
>> To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>; Anurag Kumar Vulisha=0A=
>> <anuragku@xilinx.com>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>; =
Rob=0A=
>> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Felip=
e Balbi=0A=
>> <balbi@kernel.org>=0A=
>> Cc: linux-usb@vger.kernel.org; devicetree@vger.kernel.org; linux-=0A=
>> kernel@vger.kernel.org; v.anuragkumar@gmail.com=0A=
>> Subject: Re: [PATCH 3/3] usb: dwc3: gadget: Add support for disabling U1=
 and U2=0A=
>> entries=0A=
>>=0A=
>> Hi Thinh and Anurag=0A=
>>=0A=
>> On man, 2019-05-06 at 19:21 +0000, Thinh Nguyen wrote:=0A=
>>=0A=
>>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c index=
=0A=
>>>> a1b126f..4f0912c 100644=0A=
>>>> --- a/drivers/usb/dwc3/core.c=0A=
>>>> +++ b/drivers/usb/dwc3/core.c=0A=
>>>> @@ -1285,6 +1285,10 @@ static void dwc3_get_properties(struct dwc3=0A=
>>>> *dwc)=0A=
>>>>  				"snps,dis_u2_susphy_quirk");=0A=
>>>>  	dwc->dis_enblslpm_quirk =3D device_property_read_bool(dev,=0A=
>>>>  				"snps,dis_enblslpm_quirk");=0A=
>>>> +	dwc->dis_u1_entry_quirk =3D device_property_read_bool(dev,=0A=
>>>> +				"snps,dis_u1_entry_quirk");=0A=
>>>> +	dwc->dis_u2_entry_quirk =3D device_property_read_bool(dev,=0A=
>>>> +				"snps,dis_u2_entry_quirk");=0A=
>>> Please use "-" rather than "_" in the property names.=0A=
>> I have thought about this feature over the weekend, and think the naming=
 should be=0A=
>> changed to something like "snps,bos-u1-exit-lat-in-us"=0A=
>> and named the same in the code. And then be the value used by the=0A=
>> get_config_params. E.g. the device-tree is used to set the values direct=
ly used for=0A=
>> bUxdevExitLat instead of named something not related to exit latency.=0A=
>>=0A=
>> With this the name and function is a 1 to 1 match, and you can among oth=
ers set it to=0A=
>> 0 for optaining what Anurag wants.=0A=
>>=0A=
> Your suggestion looks good but the problem is the U1 and U2 exit latencie=
s are=0A=
> fixed values in dwc3 controller(can be found in HCSPARAMS3). Adding diffe=
rent=0A=
> exit latencies may modify the U1SEL/U2SEL values sent from the host but t=
he real=0A=
> dwc3 controller exit latencies are not getting changed. Because of this r=
eason I=0A=
> had opted "snps,dis_u1_entry_quirk", so that the U1/U2 exit latency value=
s=0A=
> reported in BOS descriptor can be either be zero (when U1/U2 entries need=
s to be=0A=
> disabled) or non-zero value (reported in HCSPARAMS3) when U1/U2 states al=
lowed.=0A=
> Based on this I think it is better if we can continue with "snps,dis-u1-e=
ntry-quirk"=0A=
> instead of the "snps,bos-u1-exit-lat-in-us". Please  provide your opinion=
 on this.=0A=
=0A=
>  =0A=
>> Regarding the disabling of U1 / U2. I send this to Anurag=0A=
>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__marc.info_-3Fl-3D=
linux-2Dusb-26m-3D155683299311954-26w-3D2&d=3DDwIGaQ&c=3DDPL6_X_6JkXFx7AXWq=
B0tg&r=3Du9FYoxKtyhjrGFcyixFYqTjw1ZX0VsG2d8FCmzkTY-w&m=3DMBQpZmX-jgrlpT68k5=
VR-4xv_DYb5UGUiD5objMqwpA&s=3DCa-zBV5t26-ZFPbNAkD8K3F3lbc3CwUXNpAgnkVasg4&e=
=3D=0A=
>> Here i created a configfs interface with the names "lpm_U1_disable" and=
=0A=
>> "lpm_U2_disable" for controlling the DTCL of dwc3, and reject=0A=
>> SET_FEATURE(U1/U2)=0A=
>>=0A=
>> Will send this in seperate patch tomorrow, in the hope that Anurags feat=
ure can=0A=
>> become a way for controlling exit latency, and my patch become a way for=
 disabling=0A=
>> U1/U2=0A=
>>=0A=
> I agree with your suggestion. When U1 and U2 entries are not allowed  it =
is always=0A=
> better to report zero value for U1/U2 exit latencies in BOS descriptor (n=
o point in=0A=
> reporting non-zero exit latency values when U1/U2 states are not allowed)=
.  Along=0A=
> with that changes for preventing the dwc3 controller from initiating or a=
ccepting=0A=
> U1/U2 requests are also required (since there are some host platforms whe=
re sending=0A=
> 0 exit latency doesn't work). Based on these observations I believe both =
your patch=0A=
> changes and my patch changes needs to be added.=0A=
>=0A=
> @Thinh Nguyen=0A=
> Please provide your opinion on this=0A=
>=0A=
=0A=
The 0 exit latency in the BOS descriptor doesn't mean that device=0A=
doesn't support U1/U2 (however unrealistic it may seem).=0A=
=0A=
The exit latency values reported in the BOS decriptor are just=0A=
recommended latency. The host controls over what they should be (host=0A=
has its own U1/U2 exit latency). I don't think we should have a device=0A=
property to set the device exit latency.=0A=
=0A=
If the gadget driver needs to know what the recommended latency to set=0A=
in the BOS descriptor, we can have those values exported to some new=0A=
fields in the usb_gadget structure.=0A=
=0A=
BR,=0A=
Thinh=0A=
=0A=
=0A=
