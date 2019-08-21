Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A98C3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 01:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4D322D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 01:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJEIOxjx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfHUBHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 21:07:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36775 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfHUBG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 21:06:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id w2so259373pfi.3;
        Tue, 20 Aug 2019 18:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bPGydZDsTXm+pQL+ZamItire/LptDjK2jdxX34oHw2I=;
        b=DJEIOxjxaTYg43VfGlKm764ePPPDWT+Tg+/be59AsaTpGjVzGNE4uaNbvpZ9fAP8yg
         w7/ZS3ktUpKV4Pn4jINT+cDmy6/PWm4bVTd2ftq2A0sVqVp4oL2lWBDt2vnM1BPYjg5j
         aMZeew5utZHB6h/YTHpUHObVoiVM5R0AKQ5usKbGcnr68oMttan7N+jokXcmS/GQFdu0
         by+BJCBglcycOPRmAO8vBmhFi7uAtD/jj9AggsOp7JIxQsbyVT9YdmbmMuNY/SvGOx/T
         WnhdzqnnAj9249SC2CWK8zCxliitDRhCebzPS/E9264eDXvIsHpSKQrqSHqix8S6SAuu
         hzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bPGydZDsTXm+pQL+ZamItire/LptDjK2jdxX34oHw2I=;
        b=D8l/7DkDgOSbVccwEVl31kNozzdxiEvqHry0eDF1LsTocnDf0Cok+XAFTIZ5tJqE6o
         umrBmF53hlmv7Cc5w/YzULQuE7M2pZfzTSrVavf7i/5/qEZP5LOWT2nLR4OdLGBL1Hv4
         BSDbjQFtI/ahk5rDNuG14cuPNxQL+hk9rt4Lv8v55nZxA+WMk351Py1baHOVKBKr+pvy
         mQuDrEJKiIunpfpPRkXTa9PRw0LeahhtwnVgF3SNpOGO57Ai+47+7I9+ElFghu0l3a+V
         MTIMO7IJZKEBbzf6fLAYyfEVrZm7tKsBqesmqnA/Wpw+4LzxVNrrfs8Ae9COEy3UNH3E
         d4Jw==
X-Gm-Message-State: APjAAAVlmNPXczDmn4dgnn0rlP0mirmT7YuGF6nni8f8gKKevQnIm8b9
        9GFahnGvTckK4n3DCqOGikk=
X-Google-Smtp-Source: APXvYqwaVzz209HdTL8sek/eebdxhqh57jMBqVzpKsFejJCRWRMkCp3y3wBZfkttgDmCHuyeo+DGoQ==
X-Received: by 2002:a63:7205:: with SMTP id n5mr19353144pgc.443.1566349617997;
        Tue, 20 Aug 2019 18:06:57 -0700 (PDT)
Received: from [192.168.43.210] (mobile-166-137-176-042.mycingular.net. [166.137.176.42])
        by smtp.gmail.com with ESMTPSA id y188sm21237131pfy.57.2019.08.20.18.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 18:06:57 -0700 (PDT)
Subject: Re: [PATCH v7 1/7] driver core: Add support for linking devices
 during device addition
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
References: <20190724001100.133423-1-saravanak@google.com>
 <20190724001100.133423-2-saravanak@google.com>
 <32a8abd2-b6a4-67df-eee9-0f006310e81e@gmail.com>
 <CAGETcx8Q27+Jnz+rHtt33muMV6U+S3cmKh02Ok_Ds_ZzfBqhrg@mail.gmail.com>
 <522e8375-5070-f579-6509-3e44fe66768e@gmail.com>
 <CAGETcx-9Bera+nU-3=ZNpHqdqKxO0TmNuVUsCMQ-yDm1VXn5zA@mail.gmail.com>
 <a4c139c1-c9d1-3e5a-f47f-cd790b42da1f@gmail.com>
 <CAGETcx-J7+d3pcArMZvO5zQbUhAhRW+1=FUf7C1fV9-QhkckBw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <6028b35b-a4ca-18de-84c6-4a22dbd987c9@gmail.com>
Date:   Tue, 20 Aug 2019 18:06:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx-J7+d3pcArMZvO5zQbUhAhRW+1=FUf7C1fV9-QhkckBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/19 3:10 PM, Saravana Kannan wrote:
> On Mon, Aug 19, 2019 at 9:25 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 8/19/19 5:00 PM, Saravana Kannan wrote:
>>> On Sun, Aug 18, 2019 at 8:38 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>>>
>>>> On 8/15/19 6:50 PM, Saravana Kannan wrote:
>>>>> On Wed, Aug 7, 2019 at 7:04 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>>>>>
>>>>>>> Date: Tue, 23 Jul 2019 17:10:54 -0700
>>>>>>> Subject: [PATCH v7 1/7] driver core: Add support for linking devices during
>>>>>>>  device addition
>>>>>>> From: Saravana Kannan <saravanak@google.com>
>>>>>>>
>>>>>>> When devices are added, the bus might want to create device links to track
>>>>>>> functional dependencies between supplier and consumer devices. This
>>>>>>> tracking of supplier-consumer relationship allows optimizing device probe
>>>>>>> order and tracking whether all consumers of a supplier are active. The
>>>>>>> add_links bus callback is added to support this.
>>>>>>
>>>>>> Change above to:
>>>>>>
>>>>>> When devices are added, the bus may create device links to track which
>>>>>> suppliers a consumer device depends upon.  This
>>>>>> tracking of supplier-consumer relationship may be used to defer probing
>>>>>> the driver of a consumer device before the driver(s) for its supplier device(s)
>>>>>> are probed.  It may also be used by a supplier driver to determine if
>>>>>> all of its consumers have been successfully probed.
>>>>>> The add_links bus callback is added to create the supplier device links
>>>>>>
>>>>>>>
>>>>>>> However, when consumer devices are added, they might not have a supplier
>>>>>>> device to link to despite needing mandatory resources/functionality from
>>>>>>> one or more suppliers. A waiting_for_suppliers list is created to track
>>>>>>> such consumers and retry linking them when new devices get added.
>>>>>>
>>>>>> Change above to:
>>>>>>
>>>>>> If a supplier device has not yet been created when the consumer device attempts
>>>>>> to link it, the consumer device is added to the wait_for_suppliers list.
>>>>>> When supplier devices are created, the supplier device link will be added to
>>>>>> the relevant consumer devices on the wait_for_suppliers list.
>>>>>>
>>>>>
>>>>> I'll take these commit text suggestions if we decide to revert the
>>>>> entire series at the end of this review.
>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>>>>>>> ---
>>>>>>>  drivers/base/core.c    | 83 ++++++++++++++++++++++++++++++++++++++++++
>>>>>>>  include/linux/device.h | 14 +++++++
>>>>>>>  2 files changed, 97 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>>>>>>> index da84a73f2ba6..1b4eb221968f 100644
>>>>>>> --- a/drivers/base/core.c
>>>>>>> +++ b/drivers/base/core.c
>>>>>>> @@ -44,6 +44,8 @@ early_param("sysfs.deprecated", sysfs_deprecated_setup);
>>>>>>>  #endif
>>>>>>>
>>>>>>>  /* Device links support. */
>>>>>>> +static LIST_HEAD(wait_for_suppliers);
>>>>>>> +static DEFINE_MUTEX(wfs_lock);
>>>>>>>
>>>>>>>  #ifdef CONFIG_SRCU
>>>>>>>  static DEFINE_MUTEX(device_links_lock);
>>>>>>> @@ -401,6 +403,51 @@ struct device_link *device_link_add(struct device *consumer,
>>>>>>>  }
>>>>>>>  EXPORT_SYMBOL_GPL(device_link_add);
>>>>>>>
>>>>>>> +/**
>>>>>>
>>>>>>> + * device_link_wait_for_supplier - Mark device as waiting for supplier
>>>>>>
>>>>>>     * device_link_wait_for_supplier - Add device to wait_for_suppliers list
>>>>>
>>>>
>>>> As a meta-comment, I found this series very hard to understand in the context
>>>> of reading the new code for the first time.  When I read the code again in
>>>> six months or a year or two years it will not be in near term memory and it
>>>> will be as if I am reading it for the first time.  A lot of my suggestions
>>>> for changes of names are in that context -- the current names may be fine
>>>> when one has recently read the code, but not so much when trying to read
>>>> the whole thing again with a blank mind.
>>>
>>> Thanks for the context.
>>>
>>>> The code also inherits a good deal of complexity because it does not stand
>>>> alone in a nice discrete chunk, but instead delicately weaves into a more
>>>> complex body of code.
>>>
>>> I'll take this as a compliment :)
>>
>> Please do!
>>
>>
>>>
>>>> When I was trying to understand the code, I wrote a lot of additional
>>>> comments within my reply email to provide myself context, information
>>>> about various things, and questions that I needed to answer (or if I
>>>> could not answer to then ask you).  Then I ended up being able to remove
>>>> many of those notes before sending the reply.
>>>>
>>>>
>>>>> I intentionally chose "Mark device..." because that's a better
>>>>> description of the semantics of the function instead of trying to
>>>>> describe the implementation. Whether I'm using a linked list or some
>>>>> other data structure should not be the one line documentation of a
>>>>> function. Unless the function is explicitly about operating on that
>>>>> specific data structure.
>>>>
>>>> I agree with the intent of trying to describe the semantics of a function,
>>>> especially at the API level where other systems (or drivers) would be using
>>>> the function.  But for this case the function is at the implementation level
>>>> and describing explicitly what it is doing makes this much more readable for
>>>> me.
>>>
>>> Are you distinguishing between API level vs implementation level based
>>> on the function being "static"/not exported? I believe the earlier
>>
>> No, being static helps say a function is not API, but an function that is
>> not static may be intended to be used in a limited and constrained manner.
>> I distinguished based on the usage of the function.
>>
>>
>>> version of this series had this function as an exported API. So maybe
>>> that's why I had it as "Mark device".
>>>
>>>> I also find "Mark device" to be vague and not descriptive of what the
>>>> intent is.
>>>>
>>>>>
>>>>>>
>>>>>>
>>>>>>> + * @consumer: Consumer device
>>>>>>> + *
>>>>>>> + * Marks the consumer device as waiting for suppliers to become available. The
>>>>>>> + * consumer device will never be probed until it's unmarked as waiting for
>>>>>>> + * suppliers. The caller is responsible for adding the link to the supplier
>>>>>>> + * once the supplier device is present.
>>>>>>> + *
>>>>>>> + * This function is NOT meant to be called from the probe function of the
>>>>>>> + * consumer but rather from code that creates/adds the consumer device.
>>>>>>> + */
>>>>>>> +static void device_link_wait_for_supplier(struct device *consumer)
>>>>>>> +{
>>>>>>> +     mutex_lock(&wfs_lock);
>>>>>>> +     list_add_tail(&consumer->links.needs_suppliers, &wait_for_suppliers);
>>>>>>> +     mutex_unlock(&wfs_lock);
>>>>>>> +}
>>>>>>> +
>>>>>>> +/**
>>>>>>
>>>>>>
>>>>>>> + * device_link_check_waiting_consumers - Try to remove from supplier wait list
>>>>>>> + *
>>>>>>> + * Loops through all consumers waiting on suppliers and tries to add all their
>>>>>>> + * supplier links. If that succeeds, the consumer device is unmarked as waiting
>>>>>>> + * for suppliers. Otherwise, they are left marked as waiting on suppliers,
>>>>>>> + *
>>>>>>> + * The add_links bus callback is expected to return 0 if it has found and added
>>>>>>> + * all the supplier links for the consumer device. It should return an error if
>>>>>>> + * it isn't able to do so.
>>>>>>> + *
>>>>>>> + * The caller of device_link_wait_for_supplier() is expected to call this once
>>>>>>> + * it's aware of potential suppliers becoming available.
>>>>>>
>>>>>> Change above comment to:
>>>>>>
>>>>>>     * device_link_add_supplier_links - add links from consumer devices to
>>>>>>     *                                  supplier devices, leaving any consumer
>>>>>>     *                                  with inactive suppliers on the
>>>>>>     *                                  wait_for_suppliers list
>>>>>
>>>>> I didn't know that the first one line comment could span multiple
>>>>> lines. Good to know.
>>>>>
>>>>>
>>>>>>     * Scan all consumer devices in the devicetree.
>>>>>
>>>>> This function doesn't have anything to do with devicetree. I've
>>>>> intentionally kept all OF related parts out of the driver/core because
>>>>> I hope that other busses can start using this feature too. So I can't
>>>>> take this bit.
>>>>
>>>> My comment is left over from when I was taking notes, trying to understand the
>>>> code.
>>>>
>>>> At the moment, only devicetree is used as a source of the dependency information.
>>>> The comment would better be re-phrased as:
>>>>
>>>>         * Scan all consumer devices in the firmware description of the hardware topology
>>>>
>>>
>>> Ok
>>>
>>>> I did not ask why this feature is tied to _only_ the platform bus, but will now.
>>>
>>> Because devicetree and platform bus the only ones I'm familiar with.
>>> If other busses want to add this, I'd be happy to help with code
>>> and/or direction/review. But I won't pretend to know anything about
>>> ACPI.
>>
>> Sorry, you don't get to ignore other buses because you are not familiar
>> with them.
> 
> It's important that I don't design out other buses -- which I don't.
> But why would you want someone who has no idea of ACPI to write code
> for it? It's a futile effort that's going to be rejected by people who
> know ACPI anyway.

ACPI is not a bus.

Devicetree is not a bus.

A devicetree can contain multiple buses in the topology that is described.


> 
>> I am not aware of any reason to exclude devices that on other buses and your
>> answer below does not provide a valid technical reason why the new feature is
>> correct when it excludes all other buses.
>>>
>>>> I do not know of any reason that a consumer / supplier relationship can not be
>>>> between devices on different bus types.  Do you know of such a reason?
>>>
>>> Yes, it's hypothetically possible. But I haven't seen such a
>>> relationship being defined in DT. Nor somewhere else where this might
>>> be captured. So, how common/realistic is it?
>>
>> It is entirely legal.  I have no idea how common it is but that is not a valid
>> reason to exclude other buses from the feature.
> 
> I'm not going to write code for a hypothetical hardware scenario. Find
> one supported in upstream, show me that it'll benefit from this series
> and tell me how to interpret the dependency graph and then we'll talk
> about writing code for that.

You don't get to implement a general feature in a way that only supports
a subset of potential devicetree users.  Note the word "general".  This is
not a small isolated feature.

Now, am I being inconsistent if I say that it is ok for the feature to
only support devicetree systems, or only support ACPI systems?  I'll
have to ponder that.

But I don't think the question of only platform buses or all buses needs
to be resolved because I don't think that the add_links function is a bus
specific function.  The add_links function is specific to devicetree or
ACPI.

We seem to be talking past each other on this point right now.  I don't now
how to get our minds to the same place, but let's keep trying.


> 
>>>>>
>>>>>>  For any supplier device that
>>>>>>     * is not already linked to the consumer device, add the supplier to the
>>>>>>     * consumer device's device links.
>>>>>>     *
>>>>>>     * If all of a consumer device's suppliers are available then the consumer
>>>>>>     * is removed from the wait_for_suppliers list (if previously on the list).
>>>>>>     * Otherwise the consumer is added to the wait_for_suppliers list (if not
>>>>>>     * already on the list).
>>>>>
>>>>> Honestly, I don't think this is any better than what I already have.
>>>>
>>>> Note that my version of these comments was written while I was reading the code,
>>>> and did not have any big picture understanding yet.  This will likely also be
>>>> the mind set of most everyone who reads this code in the future, once it is
>>>> woven into the kernel.
>>>>
>>>> If you don't like the change, I can revisit it in a later version of the
>>>> patch set.
>>>
>>> I'll take in all the ones I feel are reasonable or don't feel strongly
>>> about. We can revisit the rest later.
>>>
>>>>>
>>>>>>     * The add_links bus callback must return 0 if it has found and added all
>>>>>>     * the supplier links for the consumer device. It must return an error if
>>>>>>     * it is not able to do so.
>>>>>>     *
>>>>>>     * The caller of device_link_wait_for_supplier() is expected to call this once
>>>>>>     * it is aware of potential suppliers becoming available.
>>>>>>
>>>>>>
>>>>>>
>>>>>>> + */
>>>>>>> +static void device_link_check_waiting_consumers(void)
>>>>>>
>>>>>> Function name is misleading and hides side effects.
>>>>>>
>>>>>> I have not come up with a name that does not hide side effects, but a better
>>>>>> name would be:
>>>>>>
>>>>>>    device_link_add_supplier_links()
>>>>>
>>>>> I kinda agree that it could afford a better name. The current name is
>>>>> too similar to device_links_check_suppliers() and I never liked that.
>>>>
>>>> Naming new fields or variables related to device links looks pretty
>>>> challenging to me, because of the desire to be part of device links
>>>> and not a wart pasted on the side.  So I share the pain in trying
>>>> to find good names.
>>>>
>>>>>
>>>>> Maybe device_link_add_missing_suppliers()?
>>>>
>>>> My first reaction was "yes, that sounds good".  But then I stopped and
>>>> tried to read the name out of context.  The name is not adding the
>>>> missing suppliers, it is saving the information that a supplier is
>>>> not yet available (eg, is "missing").  I struggled in coming up with
>>
>> Reading what you say below, and looking at the code again, what I say
>> in that sentence is backwards.  It is not adding the missing supplier
>> device links, it is instead adding existing supplier device inks.
>>
>>
>>>> the name that I suggested.  We can keep thinking.
>>>
>>> No, this function _IS_ about adding links to suppliers. These
>>
>> You are mis-reading what I wrote.  I said the function "is not adding
>> the missing suppliers".  You are converting that to "is not adding
>> links to the missing suppliers".
>>
>> My suggested name was hinting "add_supplier_links", which is what you
>> say it does below.  The name you suggest is hinting "add_missing_suppliers".
>> Do you see the difference?
> 
> Yeah, which is why I said earlier that I didn't want to repeat "links"
> twice in a function name. As in
> device_links_add_missing_supplier_links() has too many "links". In the
> context of device_links_, "add missing suppliers" means "add missing
> supplier links". Anyway, I think we can come back to figuring out a
> good name once we agree on the more important discussions further
> below.

Yes, later is fine.  This is a detail.

> 
>>> consumers were "saved" as "not yet having the supplier" earlier by
>>> device_link_wait_for_supplier(). This function doesn't do that. This
>>> function is just trying to see if those missing suppliers are present
>>> now and if so adding a link to them from the "saved" consumers. I
>>> think device_link_add_missing_suppliers() is actually a pretty good
>>> name. Let me know what you think now.
>>>
>>>>
>>>>
>>>>>
>>>>> I don't think we need "links" repeated twice in the function name.
>>>>
>>>> Yeah, I didn't like that either.
>>>>
>>>>
>>>>> With this suggestion, what side effect is hidden in your opinion? That
>>>>> the fully linked consumer is removed from the "waiting for suppliers"
>>>>> list?
>>>>
>>>> The side effect is that the function does not merely do a check.  It also
>>>> adds missing suppliers to a list.
>>>
>>> No, it doesn't do that. I can't keep a list of things that aren't
>>> allocated yet :). In the whole patch series, we only keep a list of things
>>> (consumers) that are waiting on other things (missing suppliers).
>>
>> OK, as I noted above, I stated that backwards.  It is adding links for
>> existing suppliers, not for the missing suppliers.
>>
>>>
>>>>>
>>>>> Maybe device_link_try_removing_from_wfs()?
>>>>
>>>> I like that, other than the fact that it still does not provide a clue
>>>> that the function is potentially adding suppliers to a list.
>>>
>>> It doesn't. How would you add a supplier device to a list if the
>>> device itself isn't there? :)
>>
>> Again, that should be existing suppliers, as you noted.  But the point stands
>> that the function is potentially adding links.
>>
>>
>>>
>>>>  I think
>>>> part of the challenge is that the function does two things: (1) a check,
>>>> and (2) potentially adding missing suppliers to a list.  Maybe a simple
>>>> one line comment at the call site, something like:
>>>>
>>>>    /* adds missing suppliers to wfs */
>>>>
>>>>
>>>>>
>>>>> I'll wait for us to agree on a better name here before I change this.
>>>>>
>>>>>>> +{
>>>>>>> +     struct device *dev, *tmp;
>>>>>>> +
>>>>>>> +     mutex_lock(&wfs_lock);
>>>>>>> +     list_for_each_entry_safe(dev, tmp, &wait_for_suppliers,
>>>>>>> +                              links.needs_suppliers)
>>>>>>> +             if (!dev->bus->add_links(dev))
>>>>>>> +                     list_del_init(&dev->links.needs_suppliers);
>>>>>>
>>>>>> Empties dev->links.needs_suppliers, but does not remove dev from
>>>>>> wait_for_suppliers list.  Where does that happen?
>>>>>
>>>>> I'll chalk this up to you having a long day or forgetting your coffee
>>>>> :) list_del_init() does both of those things because needs_suppliers
>>>>> is the node and wait_for_suppliers is the list.
>>>>
>>>> Yes, brain mis-fire on my part.  I'll have to go back and look at the
>>>> list related code again.
>>>>
>>>>
>>>>>
>>>>>>
>>>>>>> +     mutex_unlock(&wfs_lock);
>>>>>>> +}
>>>>>>> +
>>>>>>>  static void device_link_free(struct device_link *link)
>>>>>>>  {
>>>>>>>       while (refcount_dec_not_one(&link->rpm_active))
>>>>>>> @@ -535,6 +582,19 @@ int device_links_check_suppliers(struct device *dev)
>>>>>>>       struct device_link *link;
>>>>>>>       int ret = 0;
>>>>>>>
>>>>>>> +     /*
>>>>>>> +      * If a device is waiting for one or more suppliers (in
>>>>>>> +      * wait_for_suppliers list), it is not ready to probe yet. So just
>>>>>>> +      * return -EPROBE_DEFER without having to check the links with existing
>>>>>>> +      * suppliers.
>>>>>>> +      */
>>>>>>
>>>>>> Change comment to:
>>>>>>
>>>>>>         /*
>>>>>>          * Device waiting for supplier to become available is not allowed
>>>>>>          * to probe
>>>>>>          */
>>>>>
>>>>> Po-tay-to. Po-tah-to? I think my comment is just as good.
>>>>
>>>> If just as good and shorter, then better.
>>>>
>>>> Also the original says "it is not ready to probe".  That is not correct.  It
>>>> is ready to probe, it is just that the probe attempt will return -EPROBE_DEFER.
>>>> Nit picky on my part, but tiny things like that mean I have to think harder.
>>>> I have to think "why is it not ready to probe?".  Maybe my version should have
>>>> instead been something like:
>>>>
>>>>         * Device waiting for supplier to become available will return
>>>>         * -EPROBE_DEFER if probed.  Avoid the unneeded processing.
>>>>
>>>>>
>>>>>>> +     mutex_lock(&wfs_lock);
>>>>>>> +     if (!list_empty(&dev->links.needs_suppliers)) {
>>>>>>> +             mutex_unlock(&wfs_lock);
>>>>>>> +             return -EPROBE_DEFER;
>>>>>>> +     }
>>>>>>> +     mutex_unlock(&wfs_lock);
>>>>>>> +
>>>>>>>       device_links_write_lock();
>>>>>>
>>>>>> Update Documentation/driver-api/device_link.rst to reflect the
>>>>>> check of &dev->links.needs_suppliers in device_links_check_suppliers().
>>>>>
>>>>> Thanks! Will do.
>>>>>
>>>>>>
>>>>>>>
>>>>>>>       list_for_each_entry(link, &dev->links.suppliers, c_node) {
>>>>>>> @@ -812,6 +872,10 @@ static void device_links_purge(struct device *dev)
>>>>>>>  {
>>>>>>>       struct device_link *link, *ln;
>>>>>>>
>>>>>>> +     mutex_lock(&wfs_lock);
>>>>>>> +     list_del(&dev->links.needs_suppliers);
>>>>>>> +     mutex_unlock(&wfs_lock);
>>>>>>> +
>>>>>>>       /*
>>>>>>>        * Delete all of the remaining links from this device to any other
>>>>>>>        * devices (either consumers or suppliers).
>>>>>>> @@ -1673,6 +1737,7 @@ void device_initialize(struct device *dev)
>>>>>>>  #endif
>>>>>>>       INIT_LIST_HEAD(&dev->links.consumers);
>>>>>>>       INIT_LIST_HEAD(&dev->links.suppliers);
>>>>>>> +     INIT_LIST_HEAD(&dev->links.needs_suppliers);
>>>>>>>       dev->links.status = DL_DEV_NO_DRIVER;
>>>>>>>  }
>>>>>>>  EXPORT_SYMBOL_GPL(device_initialize);
>>>>>>> @@ -2108,6 +2173,24 @@ int device_add(struct device *dev)
>>>>>>>                                            BUS_NOTIFY_ADD_DEVICE, dev);
>>>>>>>
>>>>>>>       kobject_uevent(&dev->kobj, KOBJ_ADD);
>>>>>>
>>>>>>> +
>>>>>>> +     /*
>>>>>>> +      * Check if any of the other devices (consumers) have been waiting for
>>>>>>> +      * this device (supplier) to be added so that they can create a device
>>>>>>> +      * link to it.
>>>>>>> +      *
>>>>>>> +      * This needs to happen after device_pm_add() because device_link_add()
>>>>>>> +      * requires the supplier be registered before it's called.
>>>>>>> +      *
>>>>>>> +      * But this also needs to happe before bus_probe_device() to make sure
>>>>>>> +      * waiting consumers can link to it before the driver is bound to the
>>>>>>> +      * device and the driver sync_state callback is called for this device.
>>>>>>> +      */
>>>>>>
>>>>>>         /*
>>>>>>          * Add links to dev from any dependent consumer that has dev on it's
>>>>>>          * list of needed suppliers
>>>>>
>>>>> There is no list of needed suppliers.
>>>>
>>>> "the other devices (consumers) have been waiting for this device (supplier)".
>>>> Isn't that a list of needed suppliers?
>>>
>>> No, that's a list of consumers that needs_suppliers.
>>>
>>>>>
>>>>>> (links.needs_suppliers).  Device_pm_add()
>>>>>>          * must have previously registered dev to allow the links to be added.
>>>>>>          *
>>>>>>          * The consumer links must be created before dev is probed because the
>>>>>>          * sync_state callback for dev will use the consumer links.
>>>>>>          */
>>>>>
>>>>> I think what I wrote is just as clear.
>>>>
>>>> The original comment is vague.  It does not explain why consumer links must be
>>>> created before the probe.  I had to go off and read other code to determine
>>>> why that is true.
>>>>
>>>> And again, brevity is better if otherwise just as clear.
>>>>
>>>>
>>>>>
>>>>>>
>>>>>>> +     device_link_check_waiting_consumers();
>>>>>>> +
>>>>>>> +     if (dev->bus && dev->bus->add_links && dev->bus->add_links(dev))
>>>>>>> +             device_link_wait_for_supplier(dev);
>>>>>>> +
>>>>>>>       bus_probe_device(dev);
>>>>>>>       if (parent)
>>>>>>>               klist_add_tail(&dev->p->knode_parent,
>>>>>>> diff --git a/include/linux/device.h b/include/linux/device.h
>>>>>>> index c330b75c6c57..5d70babb7462 100644
>>>>>>> --- a/include/linux/device.h
>>>>>>> +++ b/include/linux/device.h
>>>>>>> @@ -78,6 +78,17 @@ extern void bus_remove_file(struct bus_type *, struct bus_attribute *);
>>>>>>>   *           -EPROBE_DEFER it will queue the device for deferred probing.
>>>>>>>   * @uevent:  Called when a device is added, removed, or a few other things
>>>>>>>   *           that generate uevents to add the environment variables.
>>>>>>
>>>>>>> + * @add_links:       Called, perhaps multiple times per device, after a device is
>>>>>>> + *           added to this bus.  The function is expected to create device
>>>>>>> + *           links to all the suppliers of the input device that are
>>>>>>> + *           available at the time this function is called.  As in, the
>>>>>>> + *           function should NOT stop at the first failed device link if
>>>>>>> + *           other unlinked supplier devices are present in the system.
>>>>>>
>>>>>> * @add_links:   Called after a device is added to this bus.
>>>>>
>>>>> Why are you removing the "perhaps multiple times" part? that's true
>>>>> and that's how some of the other ops are documented.
>>>>
>>>> I didn't remove it.  I rephrased it with a little bit more explanation as
>>>> "If some suppliers are not yet available, this function will be
>>>> called again when the suppliers become available." (below).
>>>>
>>>>
>>>>>
>>>>>>  The function is
>>>>>> *               expected to create device links to all the suppliers of the
>>>>>> *               device that are available at the time this function is called.
>>>>>> *               The function must NOT stop at the first failed device link if
>>>>>> *               other unlinked supplier devices are present in the system.
>>>>>> *               If some suppliers are not yet available, this function will be
>>>>>> *               called again when the suppliers become available.
>>>>>>
>>>>>> but add_links() not needed, so moving this comment to of_link_to_suppliers()
>>>>>
>>>>> Sorry, I'm not sure I understand. Can you please explain what you are
>>>>> trying to say? of_link_to_suppliers() is just one implementation of
>>>>> add_links(). The comment above is try for any bus trying to implement
>>>>> add_links().
>>>>
>>>> This is conflating bus with the source of the firmware description of the
>>>> hardware topology.  For drivers that use various APIs to access firmware
>>>> description of topology that may be either devicetree or ACPI the access
>>>> is done via fwnode_operations, based on struct device.fwnode (if I recall
>>>> properly).
>>>>
>>>> I failed to completely address why add_links() is not needed.  The answer
>>>> is that there should be a single function called for all buses.  Then
>>>> the proper firmware data source would be accessed via a struct fwnode_operations.
>>>>
>>>> I think I left this out because I had not yet asked why this feature is
>>>> tied only to the platform bus.  Which I asked earlier in this reply.
>>>
>>> Thanks for the pointer about fwnode and fwnode_operations. I wasn't
>>> aware of those. I see where you are going with this. I see a couple of
>>> problems with this approach though:
>>>
>>> 1. How you interpret the properties of a fwnode is specific to the fw
>>> type. The clocks DT property isn't going to have the same definition
>>> in ACPI or some other firmware. Heck, I don't know if ACPI even has a
>>> clocks like property. So have one function to parse all the FW types
>>> doesn't make a lot of sense.
>>
>> The functions in fwnode_operations are specific to the proper firmware.
>> So there is a set of functions in a struct fwnode_operations for
>> devicetree that only know about devicetree.  And there is a different
>> variable of type fwnode_operations that is initialized with ACPI
>> specific functions.
> 
> Yes, I understand how ops work :) So I have one ops (fwnode ops) to
> call that will read a property from DT or ACPI depending on where that
> specific device's firmware is from. But that's not my point here.
> 
> My point is that clock bindings in DT are under a "clocks" property
> that lists references (phandles) to the supplier. But in ACPI, the
> property might be called "clk" and could list references to actual
> clock IDs. So, you can't have one piece of code that works for all
> firmware even if I have one ops that can read properties from any
> firmware.
> 
> I'll still have to know what type the underlying firmware is before I
> try to interpret the properties. So having one function that parses DT
> and ACPI and whatever else would be a terrible and unnecessary design.

You have already implemented the devicetree function, which is
of_link_to_suppliers().  The devicetree fwnode_operations would have
a pointer to of_link_to_suppliers().

If ACPI support is added, there would be an analogous ACPI aware function
that would essentially do the same thing that of_link_to_suppliers()
does.  This would be in the ACPI version of fwnode_operations.

There would not be a single function that is both devicetree aware and
ACPI aware.


> 
>>> 2. If this common code is implemented as part of driver/base/, then at
>>> a minimum, I'll have to check if a fwnode is a DT node before I start
>>> interpreting the properties of a device's fwnode. But that means I'll
>>> have to include linux/of.h to use is_of_node(). I don't like having
>>> driver/base code depend on OF or platform or ACPI headers.
>>
>> You just use the function in the device's fwnode_operations (I think,
>> I would have to go look at the precise way the code works because it
>> has been quite a while since I've looked at it).
> 
> Because you missed my point in (1) you are missing my point in (2).
> I'll wait for your updated reply.

We are still talking at cross purposes.  If my reply to (1) does not
change that, I'll have to go dig into how the fwnode framework figures
out which set of fwnode_operations to use for each device.


> 
>>>
>>> 3. The supplier info doesn't always need to come from a firmware. So I
>>> don't want to limit it to that?
>>
>> If you can find another source of topology info, then I would expect
>> that another set of fwnode_operations functions would be created
>> for the info source.
> 
> The other source could just be C files in the kernel. Using fwnodes
> for that would be hacky. But let's sort (1) and (2) out first.

I suspected that might be the other source.  But we have been trying
to deprecate this type of data.

> 
>>>
>>> Also, I don't necessarily see this as conflating firmware (DT, ACPI,
>>> etc) with the bus (platform bus, ACPI bus, PCI bus). Whoever creates
>>> the device seems like the entity best suited to figure out the
>>> suppliers of the device (apart from the driver, obviously). So the bus
>>> deciding the suppliers doesn't seem wrong to me.
>>
>> Patch 3 assigns the devicetree add_links function to the platform bus.
>> It seems incorrect to me for of_platform_default_populate_init() to be
>> changing a field in platform_bus_type.
>>
>>
>>    of_platform_default_populate_init()
>>            ...
>>            platform_bus_type.add_links = of_link_to_suppliers;
>>
> 
> I didn't want to have platform bus include OF header files.
Yet another clue that the function pointer should not belong to the bus.


> 
>>>
>>> In this specific case, I'm trying to address DT for now and leaving
>>> ACPI to whoever else wants to add device links based on ACPI data.
>>> Most OF/DT based devices end up in platform bus. So I'm just handling
>>> this in platform bus. If some other person wants this to work for ACPI
>>> bus or PCI bus, they are welcome to implement add_links() for those
>>> busses? I'm nowhere close to an expert on those.
>>
>> Devicetree is not limited to the platform bus.
> 
> I know. That's why I said "most". PCI seems to have some DT support too.
> 
> Thanks,
> Saravana
> 

-Frank
