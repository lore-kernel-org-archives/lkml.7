Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1DCC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DD02086D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kOAGLiHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfHFVag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:30:36 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48034 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfHFVag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:30:36 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x76LUIHF012505;
        Tue, 6 Aug 2019 16:30:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565127018;
        bh=WdeZC33FQzUWVkojwaOQI3NxAt+YMap5Tl9hn+mPGaA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=kOAGLiHHmutdic+kFgKihOFdUxHKB7ihp+q0M1HR8vSrqzCpkJvEw4p6uF7yWq+JO
         ff4xkY1QqHsvraG3Urzv98BF+dmBOffCU3lytoIrcPlUzD25N9ZHsjb4blGVvoS3bd
         wunaAkYh25prIMpCyfE1RcAigwMMzRfE6zg9awew=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x76LUIEn119700
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Aug 2019 16:30:18 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 6 Aug
 2019 16:30:18 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 6 Aug 2019 16:30:18 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x76LUH4a105393;
        Tue, 6 Aug 2019 16:30:18 -0500
Subject: Re: [PATCH 0/6] hwspinlock: allow sharing of hwspinlocks
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Fabien DESSENNE <fabien.dessenne@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Rob Herring <robh+dt@kernel.org>,
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
From:   Suman Anna <s-anna@ti.com>
Message-ID: <1aea3d28-29dc-f9de-3b86-cf777e0d5caa@ti.com>
Date:   Tue, 6 Aug 2019 16:30:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190806182128.GD26807@tuxbook-pro>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/19 1:21 PM, Bjorn Andersson wrote:
> On Tue 06 Aug 10:38 PDT 2019, Suman Anna wrote:
> 
>> Hi Fabien,
>>
>> On 8/5/19 12:46 PM, Bjorn Andersson wrote:
>>> On Mon 05 Aug 01:48 PDT 2019, Fabien DESSENNE wrote:
>>>
>>>>
>>>> On 01/08/2019 9:14 PM, Bjorn Andersson wrote:
>>>>> On Wed 13 Mar 08:50 PDT 2019, Fabien Dessenne wrote:
> [..]
>>>> B/ This would introduce some inconsistency between the two 'request' API
>>>> which are hwspin_lock_request() and hwspin_lock_request_specific().
>>>> hwspin_lock_request() looks for an unused lock, so requests for an exclusive
>>>> usage. On the other side, request_specific() would request shared locks.
>>>> Worst the following sequence can transform an exclusive usage into a shared
>>>>
>>>
>>> There is already an inconsistency in between these; as with above any
>>> system that uses both request() and request_specific() will be suffering
>>> from intermittent failures due to probe ordering.
>>>
>>>> one:
>>>>    -hwspin_lock_request() -> returns Id#0 (exclusive)
>>>>    -hwspin_lock_request() -> returns Id#1 (exclusive)
>>>>    -hwspin_lock_request_specific(0) -> returns Id#0 and makes Id#0 shared
>>>> Honestly I am not sure that this is a real issue, but it's better to have it
>>>> in mind before we take ay decision
>>
>> Wouldn't it be actually simpler to just introduce a new specific API
>> variant for this, similar to the reset core for example (it uses a
>> separate exclusive API), without having to modify the bindings at all.
>> It is just a case of your driver using the right API, and the core can
>> be modified to use the additional tag semantics based on the API. It
>> should avoid any confusion with say using a different second cell value
>> for the same lock in two different nodes.
>>
> 
> But this implies that there is an actual need to hold these locks
> exclusively. Given that they are (except for the raw case) all wrapped
> by Linux locking primitives there shouldn't be a problem sharing a lock
> (except possibly for the raw case).

Yes agreed, the HWLOCK_RAW and HWLOCK_IN_ATOMIC cases are unprotected. I
am still trying to understand better the usecase to see if the same lock
is being multiplexed for different protection contexts, or if all of
them are protecting the same context.

> 
> I agree that we shouldn't specify this property in DT - if anything it
> should be a variant of the API.
> 
>> If you are sharing a hwlock on the Linux side, surely your driver should
>> be aware that it is a shared lock. The tag can be set during the first
>> request API, and you look through both tags when giving out a handle.
>>
> 
> Why would the driver need to know about it?

Just the semantics if we were to support single user vs multiple users
on Linux-side to even get a handle. Your point is that this may be moot
since we have protection anyway other than the raw cases. But we need to
be able to have the same API work across all cases.

So far, it had mostly been that there would be one user on Linux
competing with other equivalent peer entities on different processors.
It is not common to have multiple users since these protection schemes
are usually needed only at the lowest levels of a stack, so the
exclusive handle stuff had been sufficient.

> 
>> Obviously, the hwspin_lock_request() API usage semantics always had the
>> implied additional need for communicating the lock id to the other peer
>> entity, so a realistic usage is most always the specific API variant. I
>> doubt this API would be of much use for the shared driver usage. This
>> also implies that the client user does not care about specifying a lock
>> in DT.
>>
> 
> Afaict if the lock are shared then there shouldn't be a problem with
> some clients using the request API and others request_specific(). As any
> collisions would simply mean that there are more contention on the lock.
> 
> With the current exclusive model that is not possible and the success of
> the request_specific will depend on probe order.
> 
> But perhaps it should be explicitly prohibited to use both APIs on the
> same hwspinlock instance?

Yeah, they are meant to be complimentary usage, though I doubt we will
ever have any realistic users for the generic API if we haven't had a
usage so far. I had posted a concept of reserved locks long back [1] to
keep away certain locks from the generic requestor, but dropped it since
we did not have an actual use-case needing it.

regards
Suman

[1] https://lwn.net/Articles/611944/
