Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E18C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 17:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C052920717
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 17:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JTGcrXJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387572AbfHFRir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 13:38:47 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60086 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731830AbfHFRir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 13:38:47 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x76HcKok007671;
        Tue, 6 Aug 2019 12:38:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565113100;
        bh=rJsG4X64+05xGE5m7rzAm+zLsHKU8QbIpns9wHygRi8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JTGcrXJxmNXfgFaTAASCC8SBU0IJYQKQ9sqs1KXIxaYUufOHQoFVSZnbd2BvK5njh
         fZDQwADBbTvkxFkt4XnG0TMlvWO9YT7XMiXlARvBBWS9RhxLIADyRSPZ4qRVjNxKi0
         gL+fxOYLnghoOyTN4v2RUhKvKlg4GCqEtToiwFrg=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x76HcKZA075961
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Aug 2019 12:38:20 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 6 Aug
 2019 12:38:19 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 6 Aug 2019 12:38:19 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x76HcJ61094917;
        Tue, 6 Aug 2019 12:38:19 -0500
Subject: Re: [PATCH 0/6] hwspinlock: allow sharing of hwspinlocks
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Fabien DESSENNE <fabien.dessenne@st.com>
CC:     Ohad Ben-Cohen <ohad@wizery.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>
References: <1552492237-28810-1-git-send-email-fabien.dessenne@st.com>
 <20190801191403.GA7234@tuxbook-pro>
 <1a057176-81ab-e302-4375-2717ceef6924@st.com>
 <20190805174659.GA23928@tuxbook-pro>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <dcd1aeea-cffe-d5fb-af5a-e52efcc2e046@ti.com>
Date:   Tue, 6 Aug 2019 12:38:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190805174659.GA23928@tuxbook-pro>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabien,

On 8/5/19 12:46 PM, Bjorn Andersson wrote:
> On Mon 05 Aug 01:48 PDT 2019, Fabien DESSENNE wrote:
> 
>>
>> On 01/08/2019 9:14 PM, Bjorn Andersson wrote:
>>> On Wed 13 Mar 08:50 PDT 2019, Fabien Dessenne wrote:
>>>
>>>> The current implementation does not allow two different devices to use
>>>> a common hwspinlock. This patch set proposes to have, as an option, some
>>>> hwspinlocks shared between several users.
>>>>
>>>> Below is an example that explain the need for this:
>>>> 	exti: interrupt-controller@5000d000 {
>>>> 		compatible = "st,stm32mp1-exti", "syscon";
>>>> 		interrupt-controller;
>>>> 		#interrupt-cells = <2>;
>>>> 		reg = <0x5000d000 0x400>;
>>>> 		hwlocks = <&hsem 1>;
>>>> 	};
>>>> The two drivers (stm32mp1-exti and syscon) refer to the same hwlock.
>>>> With the current hwspinlock implementation, only the first driver succeeds
>>>> in requesting (hwspin_lock_request_specific) the hwlock. The second request
>>>> fails.

Help me understand the problem that you are trying to solve here. Is
this a case of you having two clients on Linux-side needing to use the
same lock but still requiring the arbitration with software running on
some other remote processor? Are they talking to the same entity on the
remote-side or different peers.

I see the series is all about getting a handle so that they can use the
API, and is the expected usage that the same entity will lock and unlock
before the other driver can lock it.

>>>>
>>>>
>>>> The proposed approach does not modify the API, but extends the DT 'hwlocks'
>>>> property with a second optional parameter (the first one identifies an
>>>> hwlock) that specifies whether an hwlock is requested for exclusive usage
>>>> (current behavior) or can be shared between several users.
>>>> Examples:
>>>> 	hwlocks = <&hsem 8>;	Ref to hwlock #8 for exclusive usage
>>>> 	hwlocks = <&hsem 8 0>;	Ref to hwlock #8 for exclusive (0) usage
>>>> 	hwlocks = <&hsem 8 1>;	Ref to hwlock #8 for shared (1) usage
>>>>
>>>> As a constraint, the #hwlock-cells value must be 1 or 2.
>>>> In the current implementation, this can have theorically any value but:
>>>> - all of the exisiting drivers use the same value : 1.
>>>> - the framework supports only one value : 1 (see implementation of
>>>>    of_hwspin_lock_simple_xlate())
>>>> Hence, it shall not be a problem to restrict this value to 1 or 2 since
>>>> it won't break any driver.
>>>>
>>> Hi Fabien,
>>>
>>> Your series looks good, but it makes me wonder why the hardware locks
>>> should be an exclusive resource.
>>>
>>> How about just making all (specific) locks shared?
>>
>> Hi Bjorn,
>>
>> Making all locks shared is a possible implementation (my first 
>> implementation
>> was going this way) but there are some drawbacks we must be aware of:
>>
>> A/ This theoretically break the legacy behavior (the legacy works with
>> exclusive (UNUSED radix tag) usage). As a consequence, an existing driver
>> that is currently failing to request a lock (already claimed by another
>> user) would now work fine. Not sure that there are such drivers, so this
>> point is probably not a real issue.
>>
> 
> Right, it's possible that a previously misconfigured system now
> successfully probes more than one device that uses a particular
> spinlock. But such system would be suffering from issues related to e.g.
> probe ordering.
> 
> So I think we should ignore this issue.
> 
>> B/ This would introduce some inconsistency between the two 'request' API
>> which are hwspin_lock_request() and hwspin_lock_request_specific().
>> hwspin_lock_request() looks for an unused lock, so requests for an exclusive
>> usage. On the other side, request_specific() would request shared locks.
>> Worst the following sequence can transform an exclusive usage into a shared
>>
> 
> There is already an inconsistency in between these; as with above any
> system that uses both request() and request_specific() will be suffering
> from intermittent failures due to probe ordering.
> 
>> one:
>>    -hwspin_lock_request() -> returns Id#0 (exclusive)
>>    -hwspin_lock_request() -> returns Id#1 (exclusive)
>>    -hwspin_lock_request_specific(0) -> returns Id#0 and makes Id#0 shared
>> Honestly I am not sure that this is a real issue, but it's better to have it
>> in mind before we take ay decision

Wouldn't it be actually simpler to just introduce a new specific API
variant for this, similar to the reset core for example (it uses a
separate exclusive API), without having to modify the bindings at all.
It is just a case of your driver using the right API, and the core can
be modified to use the additional tag semantics based on the API. It
should avoid any confusion with say using a different second cell value
for the same lock in two different nodes.

If you are sharing a hwlock on the Linux side, surely your driver should
be aware that it is a shared lock. The tag can be set during the first
request API, and you look through both tags when giving out a handle.

Obviously, the hwspin_lock_request() API usage semantics always had the
implied additional need for communicating the lock id to the other peer
entity, so a realistic usage is most always the specific API variant. I
doubt this API would be of much use for the shared driver usage. This
also implies that the client user does not care about specifying a lock
in DT.

regards
Suman

> 
> The case where I can see a
> problem with this would be if the two clients somehow would nest their
> locking regions.
> 
> But generally I think this could consider this an improvement, because
> the request_specific() would now be able to acquire its hwlock, with
> some additional contention due to the multiple use.
> 
>> I could not find any driver using the hwspin_lock_request() API, we
>> may decide to remove (or to make deprecated) this API, having
>> everything 'shared without any conditions'.
>>
> 
> It would be nice to have an upstream user of this API.
> 
>>
>> I can see three options:
>> 1- Keep my initial proposition
>> 2- Have hwspin_lock_request_specific() using shared locks and
>>     hwspin_lock_request() using unused (so 'initially' exclusive) locks.
>> 3- Have hwspin_lock_request_specific() using shared locks and
>>     remove/make deprecated hwspin_lock_request().
>>
>> Just let me know what is your preference.
>>
> 
> I think we should start with #2 and would like input from e.g. Suman
> regarding #3.
> 
> Regards,
> Bjorn
> 
>> BR
>>
>> Fabien
>>
>>>
>>> Regards,
>>> Bjorn
>>>
>>>> Fabien Dessenne (6):
>>>>    dt-bindings: hwlock: add support of shared locks
>>>>    hwspinlock: allow sharing of hwspinlocks
>>>>    dt-bindings: hwlock: update STM32 #hwlock-cells value
>>>>    ARM: dts: stm32: Add hwspinlock node for stm32mp157 SoC
>>>>    ARM: dts: stm32: Add hwlock for irqchip on stm32mp157
>>>>    ARM: dts: stm32: hwlocks for GPIO for stm32mp157
>>>>
>>>>   .../devicetree/bindings/hwlock/hwlock.txt          | 27 +++++--
>>>>   .../bindings/hwlock/st,stm32-hwspinlock.txt        |  6 +-
>>>>   Documentation/hwspinlock.txt                       | 10 ++-
>>>>   arch/arm/boot/dts/stm32mp157-pinctrl.dtsi          |  2 +
>>>>   arch/arm/boot/dts/stm32mp157c.dtsi                 | 10 +++
>>>>   drivers/hwspinlock/hwspinlock_core.c               | 82 +++++++++++++++++-----
>>>>   drivers/hwspinlock/hwspinlock_internal.h           |  2 +
>>>>   7 files changed, 108 insertions(+), 31 deletions(-)
>>>>
>>>> -- 
>>>> 2.7.4
>>>>

