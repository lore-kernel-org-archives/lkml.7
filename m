Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32569C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD9F222FC
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P0uPmYZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388693AbfHGQT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:19:58 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38314 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387827AbfHGQT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:19:57 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x77GJf7I067099;
        Wed, 7 Aug 2019 11:19:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565194781;
        bh=Zb8W9EuN9h+ioKpDhDbW8AsmcjUEyy8dsKXf060zWuM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=P0uPmYZpjT3lslMFU9rmNZDlKcspm94fWdIbgfnTqy+QUW27VO9oWdvXFMJJsXAr7
         +lnkn+w2pDVhq0hdGJhKW3rX7D/258xuMD6SsqVRYEgMBqZsxwRYGHSNjq4vXrwT6P
         iBnicme/oQVnDrTFoii0DGlrC1TbtrZ6ROyljvk0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x77GJfBw056200
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Aug 2019 11:19:41 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 7 Aug
 2019 11:19:41 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 7 Aug 2019 11:19:41 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x77GJfwg110878;
        Wed, 7 Aug 2019 11:19:41 -0500
Subject: Re: [PATCH 0/6] hwspinlock: allow sharing of hwspinlocks
To:     Fabien DESSENNE <fabien.dessenne@st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
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
 <dcd1aeea-cffe-d5fb-af5a-e52efcc2e046@ti.com>
 <20190806182128.GD26807@tuxbook-pro>
 <1aea3d28-29dc-f9de-3b86-cf777e0d5caa@ti.com>
 <02329102-5571-c6c1-b78c-693747133f0e@st.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <f0893b3f-0124-007a-3ca2-831f60ad9a80@ti.com>
Date:   Wed, 7 Aug 2019 11:19:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <02329102-5571-c6c1-b78c-693747133f0e@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabien,

On 8/7/19 3:39 AM, Fabien DESSENNE wrote:
> Hi
> 
> On 06/08/2019 11:30 PM, Suman Anna wrote:
>> On 8/6/19 1:21 PM, Bjorn Andersson wrote:
>>> On Tue 06 Aug 10:38 PDT 2019, Suman Anna wrote:
>>>
>>>> Hi Fabien,
>>>>
>>>> On 8/5/19 12:46 PM, Bjorn Andersson wrote:
>>>>> On Mon 05 Aug 01:48 PDT 2019, Fabien DESSENNE wrote:
>>>>>
>>>>>> On 01/08/2019 9:14 PM, Bjorn Andersson wrote:
>>>>>>> On Wed 13 Mar 08:50 PDT 2019, Fabien Dessenne wrote:
>>> [..]
>>>>>> B/ This would introduce some inconsistency between the two 'request' API
>>>>>> which are hwspin_lock_request() and hwspin_lock_request_specific().
>>>>>> hwspin_lock_request() looks for an unused lock, so requests for an exclusive
>>>>>> usage. On the other side, request_specific() would request shared locks.
>>>>>> Worst the following sequence can transform an exclusive usage into a shared
>>>>>>
>>>>> There is already an inconsistency in between these; as with above any
>>>>> system that uses both request() and request_specific() will be suffering
>>>>> from intermittent failures due to probe ordering.
>>>>>
>>>>>> one:
>>>>>>     -hwspin_lock_request() -> returns Id#0 (exclusive)
>>>>>>     -hwspin_lock_request() -> returns Id#1 (exclusive)
>>>>>>     -hwspin_lock_request_specific(0) -> returns Id#0 and makes Id#0 shared
>>>>>> Honestly I am not sure that this is a real issue, but it's better to have it
>>>>>> in mind before we take ay decision
>>>> Wouldn't it be actually simpler to just introduce a new specific API
>>>> variant for this, similar to the reset core for example (it uses a
>>>> separate exclusive API), without having to modify the bindings at all.
>>>> It is just a case of your driver using the right API, and the core can
>>>> be modified to use the additional tag semantics based on the API. It
>>>> should avoid any confusion with say using a different second cell value
>>>> for the same lock in two different nodes.
>>>>
>>> But this implies that there is an actual need to hold these locks
>>> exclusively. Given that they are (except for the raw case) all wrapped
>>> by Linux locking primitives there shouldn't be a problem sharing a lock
>>> (except possibly for the raw case).
>> Yes agreed, the HWLOCK_RAW and HWLOCK_IN_ATOMIC cases are unprotected. I
>> am still trying to understand better the usecase to see if the same lock
>> is being multiplexed for different protection contexts, or if all of
>> them are protecting the same context.
> 
> 
> Here are two different examples that explain the need for changes.
> In both cases the Linux clients are talking to a single entity on the
> remote-side.
> 
> Example 1:
>      exti: interrupt-controller@5000d000 {
>          compatible = "st,stm32mp1-exti", "syscon";
>          interrupt-controller;
>          #interrupt-cells = <2>;
>          reg = <0x5000d000 0x400>;
>          hwlocks = <&hsem 1>;
>      };
> The two drivers (stm32mp1-exti and syscon) refer to the same hwlock.
> With the current hwspinlock implementation, only the first driver succeeds
> in requesting (hwspin_lock_request_specific) the hwlock. The second request
> fails.
> Here, we really need to share the hwlock between the two drivers.
> Note: hardware spinlock support for regmap was 'recently' introduced in 4.15
> see https://lore.kernel.org/patchwork/patch/845941/
> 
> 
> 
> Example 2:
> Here it is more a question of optimization : we want to save the number of
> hwlocks used to protect resources, using an unique hwlock to protect all
> pinctrl resources:
>          pinctrl: pin-controller@50002000 {
>              compatible = "st,stm32mp157-pinctrl";
>              ranges = <0 0x50002000 0xa400>;
>              hwlocks = <&hsem 0 1>;
> 
>          pinctrl_z: pin-controller-z@54004000 {
>              compatible = "st,stm32mp157-z-pinctrl";
>              ranges = <0 0x54004000 0x400>;
>              pins-are-numbered;
>              hwlocks = <&hsem 0 1>;

Thanks for the examples.

> 
>>
>>> I agree that we shouldn't specify this property in DT - if anything it
>>> should be a variant of the API.
> 
> 
> If we decide to add a 'shared' API, then, what about the generic regmap 
> driver?
> 
> In the context of above example1, this would require to update the 
> regmap driver.
> 
> But would this be acceptable for any driver using syscon/regmap?
> 
> 
> I think it is better to keep the existing API (modifying it so it always 
> allows
> 
> hwlocks sharing, so no need for bindings update) than adding another API.

For your usecases, you would definitely need the syscon/regmap behavior
to be shared right. Whether we introduce a 'shared' API or an
'exclusive' API and change the current API behavior to shared, it is
definitely a case-by-case usage scenario for the existing drivers and
usage right. The main contention point is what to do with the
unprotected usecases like Bjorn originally pointed out.

regards
Suman

> 
> 
> 
>>>
>>>> If you are sharing a hwlock on the Linux side, surely your driver should
>>>> be aware that it is a shared lock. The tag can be set during the first
>>>> request API, and you look through both tags when giving out a handle.
>>>>
>>> Why would the driver need to know about it?
>> Just the semantics if we were to support single user vs multiple users
>> on Linux-side to even get a handle. Your point is that this may be moot
>> since we have protection anyway other than the raw cases. But we need to
>> be able to have the same API work across all cases.
>>
>> So far, it had mostly been that there would be one user on Linux
>> competing with other equivalent peer entities on different processors.
>> It is not common to have multiple users since these protection schemes
>> are usually needed only at the lowest levels of a stack, so the
>> exclusive handle stuff had been sufficient.
>>
>>>> Obviously, the hwspin_lock_request() API usage semantics always had the
>>>> implied additional need for communicating the lock id to the other peer
>>>> entity, so a realistic usage is most always the specific API variant. I
>>>> doubt this API would be of much use for the shared driver usage. This
>>>> also implies that the client user does not care about specifying a lock
>>>> in DT.
>>>>
>>> Afaict if the lock are shared then there shouldn't be a problem with
>>> some clients using the request API and others request_specific(). As any
>>> collisions would simply mean that there are more contention on the lock.
>>>
>>> With the current exclusive model that is not possible and the success of
>>> the request_specific will depend on probe order.
>>>
>>> But perhaps it should be explicitly prohibited to use both APIs on the
>>> same hwspinlock instance?
>> Yeah, they are meant to be complimentary usage, though I doubt we will
>> ever have any realistic users for the generic API if we haven't had a
>> usage so far. I had posted a concept of reserved locks long back [1] to
>> keep away certain locks from the generic requestor, but dropped it since
>> we did not have an actual use-case needing it.
>>
>> regards
>> Suman
>>
>> [1] https://lwn.net/Articles/611944/

