Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E37C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC1E2053B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfPy2sbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391389AbfGOO0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:26:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41205 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388806AbfGOO0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:26:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id m30so7496338pff.8;
        Mon, 15 Jul 2019 07:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C3QXEL/fPNGe17iDAvE2LlvHDEkQmHgPu4toOaZwVhw=;
        b=hfPy2sbt0tV9EStp/eTjbCnIp5uLw0yztSdM+4JXY9fHmZZdFtgna3nfVdOG77bzrz
         n1OP47goNnwPH7LYPOEp/Ps7bYDaQ0YV/q6eQ+bK/lnNwUaNvBPH9ZLti4D1N4jTOWwB
         BdbxZjjV+nfE6iH/M2tgab8juZeQ1V2qUPeUUPS+3acCSXdhT43izNT8iKgjVGAvfQS3
         E8naKOORz+ya2PEJS75dxznDt0M6TUrLgdEpozzb7Rqzfu42I4K3YgWG22/OqsJkdBbt
         P/6PnCVVg2urtGQ0PA/IqM5UbNvnzxafJ5J749VdImHtKGorfZdrD7dzwYNR/+qy6xWc
         d8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C3QXEL/fPNGe17iDAvE2LlvHDEkQmHgPu4toOaZwVhw=;
        b=IIw9OF68rx2xqoI64onh/DLKz74RdTITgkHWZuul+UdxMC7aZkogVz4Nny3SKB3nIR
         v/s3o7u0pm2I4ARqXRwT04X6MozDJjFkzYbjwSru1iS6VE7uOfzdNrJjt423f9TILcHQ
         GHfdZW3LsQM3ny7GYFL97jqa+8RfJmoCQhKOVyGdkNj9UCY2VNEkSbp7ntlc01t38d9s
         BuvMnvEnTfwXYQ7YO/yFudASiHRncamBNVtNXIOqZy5wfRMYLJDDllwZhEN0KG0sp3FR
         p7v3CSXkBUvsGYxZgUkH6armYLpxklp0SVwBOW92DRZGNa4ugMYQ+s9aiab6VTRD+nXF
         JY2A==
X-Gm-Message-State: APjAAAWpSaL0whKAZrVa/6VvzVMCtNYZa0uqeC5+bXWoQfRIUz7oboIM
        PMkJ+09urlxNgM5cLo/4BPuNVDmq
X-Google-Smtp-Source: APXvYqx0ZqLnsS41LgIxt8wupYdXf9DdV8vBLToaJ6rBJz4/GJgQOEalEBOwR6y8pUyyaedFgHE/3A==
X-Received: by 2002:a63:6904:: with SMTP id e4mr26948138pgc.321.1563200803516;
        Mon, 15 Jul 2019 07:26:43 -0700 (PDT)
Received: from [10.231.110.95] ([125.29.25.186])
        by smtp.gmail.com with ESMTPSA id 34sm17490859pgl.15.2019.07.15.07.26.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 07:26:42 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] of/platform: Add functional dependency link from
 DT bindings
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
References: <20190702004811.136450-1-saravanak@google.com>
 <20190702004811.136450-3-saravanak@google.com>
 <CAL_JsqLdvDpKB=iV6x3eTr2F4zY0bxU-Wjb+JeMjj5rdnRc-OQ@mail.gmail.com>
 <CAGETcx_i9353aRFbJXNS78EvqwmU-2-xSBJ+ySZX1gjjHpz_cg@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <9e75b3dd-380b-c868-728f-46379e53bc11@gmail.com>
Date:   Mon, 15 Jul 2019 07:26:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAGETcx_i9353aRFbJXNS78EvqwmU-2-xSBJ+ySZX1gjjHpz_cg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HiRob,

Sorry for such a late reply...


On 7/1/19 8:25 PM, Saravana Kannan wrote:
> On Mon, Jul 1, 2019 at 6:32 PM Rob Herring <robh+dt@kernel.org> wrote:
>>
>> On Mon, Jul 1, 2019 at 6:48 PM Saravana Kannan <saravanak@google.com> wrote:
>>>
>>> Add device-links after the devices are created (but before they are
>>> probed) by looking at common DT bindings like clocks and
>>> interconnects.
>>>
>>> Automatically adding device-links for functional dependencies at the
>>> framework level provides the following benefits:
>>>
>>> - Optimizes device probe order and avoids the useless work of
>>>   attempting probes of devices that will not probe successfully
>>>   (because their suppliers aren't present or haven't probed yet).
>>>
>>>   For example, in a commonly available mobile SoC, registering just
>>>   one consumer device's driver at an initcall level earlier than the
>>>   supplier device's driver causes 11 failed probe attempts before the
>>>   consumer device probes successfully. This was with a kernel with all
>>>   the drivers statically compiled in. This problem gets a lot worse if
>>>   all the drivers are loaded as modules without direct symbol
>>>   dependencies.
>>>
>>> - Supplier devices like clock providers, interconnect providers, etc
>>>   need to keep the resources they provide active and at a particular
>>>   state(s) during boot up even if their current set of consumers don't
>>>   request the resource to be active. This is because the rest of the
>>>   consumers might not have probed yet and turning off the resource
>>>   before all the consumers have probed could lead to a hang or
>>>   undesired user experience.
>>>
>>>   Some frameworks (Eg: regulator) handle this today by turning off
>>>   "unused" resources at late_initcall_sync and hoping all the devices
>>>   have probed by then. This is not a valid assumption for systems with
>>>   loadable modules. Other frameworks (Eg: clock) just don't handle
>>>   this due to the lack of a clear signal for when they can turn off
>>>   resources. This leads to downstream hacks to handle cases like this
>>>   that can easily be solved in the upstream kernel.
>>>
>>>   By linking devices before they are probed, we give suppliers a clear
>>>   count of the number of dependent consumers. Once all of the
>>>   consumers are active, the suppliers can turn off the unused
>>>   resources without making assumptions about the number of consumers.
>>>
>>> By default we just add device-links to track "driver presence" (probe
>>> succeeded) of the supplier device. If any other functionality provided
>>> by device-links are needed, it is left to the consumer/supplier
>>> devices to change the link when they probe.
>>>
>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>>> ---
>>>  drivers/of/Kconfig    |  9 ++++++++
>>>  drivers/of/platform.c | 52 +++++++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 61 insertions(+)
>>>
>>> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
>>> index 37c2ccbefecd..7c7fa7394b4c 100644
>>> --- a/drivers/of/Kconfig
>>> +++ b/drivers/of/Kconfig
>>> @@ -103,4 +103,13 @@ config OF_OVERLAY
>>>  config OF_NUMA
>>>         bool
>>>
>>> +config OF_DEVLINKS
>>
>> I'd prefer this not be a config option. After all, we want one kernel
>> build that works for all platforms.
> 
> We need a lot more changes before one kernel build can work for all
> platforms. At least until then, I think we need this. Lot less chance
> of breaking existing platforms before all the missing pieces are
> created.
> 
>> A kernel command line option to disable might be useful for debugging.
> 
> Or we can have a command line to enable this for platforms that want
> to use it and have it default off.

Given the fragility of the current boot sequence (without this patch set)
and the potential breakage of existing systems, I think that if we choose
to accept this patch set that it should first bake in the -next tree for
at least one major release cycle.  Maybe even two major release cycles.

-Frank


> 
>>> +       bool "Device links from DT bindings"
>>> +       help
>>> +         Common DT bindings like clocks, interconnects, etc represent a
>>> +         consumer device's dependency on suppliers devices. This option
>>> +         creates device links from these common bindings so that consumers are
>>> +         probed only after all their suppliers are active and suppliers can
>>> +         tell when all their consumers are active.
>>> +
>>>  endif # OF
>>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>>> index 04ad312fd85b..a53717168aca 100644
>>> --- a/drivers/of/platform.c
>>> +++ b/drivers/of/platform.c
>>> @@ -61,6 +61,57 @@ struct platform_device *of_find_device_by_node(struct device_node *np)
>>>  EXPORT_SYMBOL(of_find_device_by_node);
>>>
>>>  #ifdef CONFIG_OF_ADDRESS
>>> +static int of_link_binding(struct device *dev, char *binding, char *cell)
>>
>> Under CONFIG_OF_ADDRESS seems like a strange location.
> 
> Yeah, but the rest of the file seems to be under this. So I'm not
> touching that. I can probably move this function further down (close
> to platform populate) if you want that.
>>
>>> +{
>>> +       struct of_phandle_args sup_args;
>>> +       struct platform_device *sup_dev;
>>> +       unsigned int i = 0, links = 0;
>>> +       u32 dl_flags = DL_FLAG_AUTOPROBE_CONSUMER;
>>> +
>>> +       while (!of_parse_phandle_with_args(dev->of_node, binding, cell, i,
>>> +                                          &sup_args)) {
>>> +               i++;
>>> +               sup_dev = of_find_device_by_node(sup_args.np);
>>> +               if (!sup_dev)
>>> +                       continue;
>>> +               if (device_link_add(dev, &sup_dev->dev, dl_flags))
>>> +                       links++;
>>> +               put_device(&sup_dev->dev);
>>> +       }
>>> +       if (links < i)
>>> +               return -ENODEV;
>>> +       return 0;
>>> +}
>>> +
>>> +/*
>>> + * List of bindings and their cell names (use NULL if no cell names) from which
>>> + * device links need to be created.
>>> + */
>>> +static char *link_bindings[] = {
>>
>> const
> 
> Ack
> 
>>
>>> +#ifdef CONFIG_OF_DEVLINKS
>>> +       "clocks", "#clock-cells",
>>> +       "interconnects", "#interconnect-cells",
>>
>> Planning to add others?
> 
> Not in this patch.
> 
> Regulators are the other big missing piece that I'm aware of now but
> they need a lot of discussion (see email from David and my reply).
> 
> Not sure what other resources are shared where they can be "turned
> off" and cause devices set up at boot to fail. For example, I don't
> think interrupts need functional dependency tracking because they
> aren't really turned off by consumer 1 in a way that breaks things for
> consumer 2. Just masked and the consumer 2 can unmask and use it once
> it probes.
> 
> I'm only intimately familiar with clocks, interconnects and regulators
> (to some extent). I'm open to adding other supplier categories in
> future patches as I educate myself of those or if other people want to
> add support for more categories.
> 
> -Saravana
> 
>>> +#endif
>>> +};
>>> +
>>> +static int of_link_to_suppliers(struct device *dev)
>>> +{
>>> +       unsigned int i = 0;
>>> +       bool done = true;
>>> +
>>> +       if (unlikely(!dev->of_node))
>>> +               return 0;
>>> +
>>> +       for (i = 0; i < ARRAY_SIZE(link_bindings) / 2; i++)
>>> +               if (of_link_binding(dev, link_bindings[i * 2],
>>> +                                       link_bindings[i * 2 + 1]))
>>> +                       done = false;
>>> +
>>> +       if (!done)
>>> +               return -ENODEV;
>>> +       return 0;
>>> +}
>>> +
>>>  /*
>>>   * The following routines scan a subtree and registers a device for
>>>   * each applicable node.
>>> @@ -524,6 +575,7 @@ static int __init of_platform_default_populate_init(void)
>>>         if (!of_have_populated_dt())
>>>                 return -ENODEV;
>>>
>>> +       platform_bus_type.add_links = of_link_to_suppliers;
>>>         /*
>>>          * Handle certain compatibles explicitly, since we don't want to create
>>>          * platform_devices for every node in /reserved-memory with a
>>> --
>>> 2.22.0.410.gd8fdbe21b5-goog
>>>
> 

