Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70496C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361B82177E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A4iWMTO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbfFMPf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:35:28 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51776 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbfFMKXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 06:23:37 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5DANWqi014203;
        Thu, 13 Jun 2019 05:23:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560421413;
        bh=geebHCw5GI5dZPh1vMErrBBAzxFlhgHq+1xPGSF6NlM=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=A4iWMTO1J1WP3GSJpcl9bP2Ul/ir2nJTlFvWOuQHgT8+XB2hr49OfdcX66Hxb7Rl4
         nxfRYKuDNAaH0Gj91DRH1pck9NwDiZZLYGU+AQI530VAz92sDaCQeB0ch5TT6LxCFD
         F0X02T9bRilSRh+HqdfPOME6Co3Ac0KIszbwZOtY=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5DANWiR007415
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Jun 2019 05:23:32 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 13
 Jun 2019 05:23:32 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 13 Jun 2019 05:23:32 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5DANSxP015746;
        Thu, 13 Jun 2019 05:23:30 -0500
Subject: Re: [PATCH v4 4/5] phy: ti: Add a new SERDES driver for TI's AM654x
 SoC
To:     Peter Rosin <peda@axentia.se>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
References: <c357f9bc-dcf9-e8de-f879-f208e45a5b86@axentia.se>
 <ac361a0c-829c-41bb-64f0-bd74bb0c0dd6@ti.com>
 <c990858e-5473-570a-221e-d2b3eea603a3@axentia.se>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <0131b92f-29da-ef85-fbdc-5fdaf041bb4d@ti.com>
Date:   Thu, 13 Jun 2019 15:51:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <c990858e-5473-570a-221e-d2b3eea603a3@axentia.se>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13/06/19 1:22 PM, Peter Rosin wrote:
> Hi,
> 
> On 2019-06-13 06:57, Kishon Vijay Abraham I wrote:
>> Hi Peter,
>>
>> On 13/06/19 4:20 AM, Peter Rosin wrote:
>>> Hi!
>>>
>>> [I know this has already been merged upstream, but I only just
>>>  now noticed the code and went to the archives to find the
>>>  originating mail. I hope I managed to set in-reply-to correctly...]
>>>
>>> The mux handling is problematic and does not follow the rules.
>>> It needs to be fixed, or you may face deadlocks. See below.
>>>
>>> On 2019-04-05 11:08, Kishon Vijay Abraham I wrote:
>>>> Add a new SERDES driver for TI's AM654x SoC which configures
>>>> the SERDES only for PCIe. Support fo USB3 will be added later.
>>>>
>>>> SERDES in am654x has three input clocks (left input, externel reference
>>>> clock and right input) and two output clocks (left output and right
>>>> output) in addition to a PLL mux clock which the SERDES uses for Clock
>>>> Multiplier Unit (CMU refclock).
>>>>
>>>> The PLL mux clock can select from one of the three input clocks.
>>>> The right output can select between left input and external reference
>>>> clock while the left output can select between the right input and
>>>> external reference clock.
>>>>
>>>> The driver has support to select PLL mux and left/right output mux as
>>>> specified in device tree.
>>>>
>>>> [rogerq@ti.com: Fix boot lockup caused by accessing a structure member
>>>> (hw->init) allocated in stack of probe() and accessed in get_parent]
>>>> [rogerq@ti.com: Fix "Failed to find the parent" warnings]
>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> *snip*
> 
>>>> +static void serdes_am654_release(struct phy *x)
>>>> +{
>>>> +	struct serdes_am654 *phy = phy_get_drvdata(x);
>>>> +
>>>> +	phy->type = PHY_NONE;
>>>> +	phy->busy = false;
>>>> +	mux_control_deselect(phy->control);
>>>
>>> Here you unconditionally deselect the mux, and that seems
>>> dangerous. Are you *sure* that ->release may not be called
>>> without a successful xlate call?
>>
>> Yeah, without a successful xlate(), the consumer will never get a reference to
>> the PHY and the ->release() is invoked only from phy_put() which needs a
>> reference to the PHY.
> 
> Yes, I thought it might be ok, but good that you can confirm it.
> 
>>> I'm not 100% sure of that, but I have not looked at the phy
>>> code before today, so it may very well be the case that this
>>> is safe...
>>>
>>>> +}
>>>> +
>>>> +struct phy *serdes_am654_xlate(struct device *dev, struct of_phandle_args
>>>> +				 *args)
>>>> +{
>>>> +	struct serdes_am654 *am654_phy;
>>>> +	struct phy *phy;
>>>> +	int ret;
>>>> +
>>>> +	phy = of_phy_simple_xlate(dev, args);
>>>> +	if (IS_ERR(phy))
>>>> +		return phy;
>>>> +
>>>> +	am654_phy = phy_get_drvdata(phy);
>>>> +	if (am654_phy->busy)
>>>> +		return ERR_PTR(-EBUSY);
>>>> +
>>>> +	ret = mux_control_select(am654_phy->control, args->args[1]);
>>>> +	if (ret) {
>>>> +		dev_err(dev, "Failed to select SERDES Lane Function\n");
>>>> +		return ERR_PTR(ret);
>>>> +	}
>>>
>>> *However*
>>>
>>> Here you select the mux as the last action, good, but, a mux must
>>> be handled with that same care as a locking primitive, i.e.
>>> successful selects must be perfectly balanced with deselects. I
>>> see no guarantee of that here, since there are other failures
>>> possible after the xlate call. So, being last in the function
>>> does not really help. If I read the code correctly, the
>>> phy core may fail if try_module_get fails in phy_get(). If that
>>> ever happens, a successful call to mux_control_select is simply
>>> forgotten, and the mux will be locked indefinitely.
>>
>> Good catch. While adding ->release() ops which is only invoked from phy_put,
>> perhaps this was missed. Ideally it should be invoked from other places where
>> there is a failure after phy_get.
>>>
>>> am654_phy->busy will also be set indefinitely, so you will get
>>> -EBUSY and not a hard deadlock. At least here, but if the now
>>> locked mux control happens to also control some other muxes
>>> (probably unlikely, but if), then their consumers will potentially
>>> deadlock hard. But that's just after a cursory reading, so I may
>>> completely miss something...
>>
>> The ->busy here should prevent two consumers trying to control the same mux.
> 
> Aha, you do not seem to be aware that one mux controller can
> have multiple independent consumers (a mux is not like a gpio
> or a pwm in that aspect). What I'm talking about is a single
> mux control that controls several parallel muxes, each with its
> own consumer. In the specific case you are targeting, that may
> not be possible due to some hardware reason or something, but
> looking at just this driver *it* cannot know that the mux will
> be available just because it has a local ->busy flag.

I think this should be okay atleast for my case.

My dt node will looks something like this
serdes_mux: mux-controller {
	compatible = "mmio-mux";
        #mux-control-cells = <1>;
        mux-reg-masks = <0x4080 0x3>, /* SERDES0 lane select */
                        <0x4090 0x3>; /* SERDES1 lane select */
}

Here SERDES lane0 is muxed between PCIe0 Lane0, ICSS2 SGMII Lane0.
The consumers of SERDES0 (in this case PCIe and ICSS), will have to invoke
->xlate of AM654 SERDES driver to select the mux and ->busy should be able to
tell whether it is available.

Only when multiple drivers try to get devm_mux_control_get and use
mux_control_select, the problem might occur. For my case, only SERDES is the
consumer of mux.
> 
> For this case, I get the feeling that the mux may be selected for
> a very long time, right? It is never about selecting the mux,
> doing something for x milli/microseconds or so and then deselecting
> the mux. Perhaps the mux will typically sit in the same state for
> the entire uptime of the machine?

Yes right. It'll be for the entire up time. Well, with dt overlay this could
change.
> 
> If you have these very long access patterns, the sharing capability
> of the mux controls are pretty much useless, and I have
> contemplating a mux mode to support this case. I.e. where you
> lock/unlock the mux control once at probe/release (or similar),
> and then basically instead of a shared mux get an exclusive mux
> where the consumer is responsible for not making parallel accesses.
> In other words, just like a gpio or a pwm.

Yes, having an exclusive mux will make sure no one can accidentally modify the mux.

> 
> The problem is that I then need a definition of "long" and "short"
> accesses, and I split the mux universe in two...

Are you trying to make sure there is no deadlock when two different consumers
try to control a shared mux?

Thanks
Kishon
