Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976E6C4646C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6497A20665
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="unDytAdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfFXWhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 18:37:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34143 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbfFXWhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 18:37:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id p10so7875127pgn.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 15:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PVdZv0wwo7AUgjgbTdtKv5MPkWck4LusYw9ccLhXv1g=;
        b=unDytAdhv9eLs4aVxey+PovyA7OLrt6LzAdtbe1H2YsybDe0+cb7hmNY68HKFeky3Y
         1/ShkybB54MeLfinqhItApaAIzOvsNZrpJy2FSOGjYIngKoQzZhTs+B68+lRrqNt8sjh
         YmwCCSHqK0JUJkO0VPkbdGhnRDonwo4RbtKLh8ybeUwHkJTjGKq10uYMPJzbUxl5NUuj
         yjX8P/d7jbJ1H0giv2DwKdsn1lY0QbGcMrBgwrr5D1AooqckKKJ1q4I+4AfEQFtEdOGn
         voXfhbrXxCXMTEIGnNrbK6+TT5+NazPzBKDnngaC1paCg8DUd4YnnKSnI52uBa3h6Ygm
         1xtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PVdZv0wwo7AUgjgbTdtKv5MPkWck4LusYw9ccLhXv1g=;
        b=KUVNRcD5+AN7+ILEgj/vpedhX4cPKZljYPyqzbITs23PeVJJeIEiDfFfsnY9x0juyS
         sHZ0GtPKaGc/AXSQYsnMJygb71+Uq8bF6JxZE/w5iOBQ71/JaBa7etzv8apNiCKiqx7K
         jqQLbrebzB4TUAM07yYZGax/N6QnZ6K9kRFdgNrOwx7m9RG44/3eYL9HKFzvjMGgGxZM
         x9mIztWk1Vvs6Uc9I5oRv0Z7lKDf9mi/fxmglji7ZNifctzAaZ8ZrxXAgc7q6/shtuVE
         0qeRFhcU+5XdmQ84FPxomPDZOS5BtEv6Tp8E9s/QuxR5SV5Ey3IAK9+zmE0x0GjyelMJ
         JjHg==
X-Gm-Message-State: APjAAAUZacGiLgl3cPlcT6UXn0+X6sM/giJuO8Vj/cIaW7UTYaqAJb9a
        HCTX6O2udaFWsT5hZQikaND+iA==
X-Google-Smtp-Source: APXvYqxbNiviVhTgUYWHtVesC13Iu7nWAF+dX1SY1JxvDPDRzC0v5nulzld8pZohquqpsd44l5R6Sw==
X-Received: by 2002:a63:f4e:: with SMTP id 14mr35285630pgp.58.1561415828288;
        Mon, 24 Jun 2019 15:37:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3fed:2d30:9d40:70a3])
        by smtp.gmail.com with ESMTPSA id t70sm5015290pgc.13.2019.06.24.15.37.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 15:37:07 -0700 (PDT)
Date:   Mon, 24 Jun 2019 15:37:07 -0700
From:   Sandeep Patil <sspatil@android.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        David Collins <collinsd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [RESEND PATCH v1 0/5] Solve postboot supplier cleanup and
 optimize probe ordering
Message-ID: <20190624223707.GH203031@google.com>
References: <20190604003218.241354-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604003218.241354-1-saravanak@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Responding to the first email in the series to summarize the current
situation and choices we have.)

On Mon, Jun 03, 2019 at 05:32:13PM -0700, 'Saravana Kannan' via kernel-team wrote:
> Add a generic "depends-on" property that allows specifying mandatory
> functional dependencies between devices. Add device-links after the
> devices are created (but before they are probed) by looking at this
> "depends-on" property.
> 
> This property is used instead of existing DT properties that specify
> phandles of other devices (Eg: clocks, pinctrl, regulators, etc). This
> is because not all resources referred to by existing DT properties are
> mandatory functional dependencies. Some devices/drivers might be able
> to operate with reduced functionality when some of the resources
> aren't available. For example, a device could operate in polling mode
> if no IRQ is available, a device could skip doing power management if
> clock or voltage control isn't available and they are left on, etc.
> 
> So, adding mandatory functional dependency links between devices by
> looking at referred phandles in DT properties won't work as it would
> prevent probing devices that could be probed. By having an explicit
> depends-on property, we can handle these cases correctly.
> 
> Having functional dependencies explicitly called out in DT and
> automatically added before the devices are probed, provides the
> following benefits:
> 
> - Optimizes device probe order and avoids the useless work of
>   attempting probes of devices that will not probe successfully
>   (because their suppliers aren't present or haven't probed yet).
> 
>   For example, in a commonly available mobile SoC, registering just
>   one consumer device's driver at an initcall level earlier than the
>   supplier device's driver causes 11 failed probe attempts before the
>   consumer device probes successfully. This was with a kernel with all
>   the drivers statically compiled in. This problem gets a lot worse if
>   all the drivers are loaded as modules without direct symbol
>   dependencies.
> 
> - Supplier devices like clock providers, regulators providers, etc
>   need to keep the resources they provide active and at a particular
>   state(s) during boot up even if their current set of consumers don't
>   request the resource to be active. This is because the rest of the
>   consumers might not have probed yet and turning off the resource
>   before all the consumers have probed could lead to a hang or
>   undesired user experience.
> 
>   Some frameworks (Eg: regulator) handle this today by turning off
>   "unused" resources at late_initcall_sync and hoping all the devices
>   have probed by then. This is not a valid assumption for systems with
>   loadable modules. Other frameworks (Eg: clock) just don't handle
>   this due to the lack of a clear signal for when they can turn off
>   resources. This leads to downstream hacks to handle cases like this
>   that can easily be solved in the upstream kernel.
> 
>   By linking devices before they are probed, we give suppliers a clear
>   count of the number of dependent consumers. Once all of the
>   consumers are active, the suppliers can turn off the unused
>   resources without making assumptions about the number of consumers.
> 
> By default we just add device-links to track "driver presence" (probe
> succeeded) of the supplier device. If any other functionality provided
> by device-links are needed, it is left to the consumer/supplier
> devices to change the link when they probe.
>  

We are trying to make sure that all (most) drivers in an Aarch64 system can
be kernel modules for Android, like any other desktop system for
example. There are a number of problems we need to fix before that happens
ofcourse.

That patch series does the following -

1. Resolve the consumer<->supplier relationship in order for subsystems to
turn off resources to save power is #1 on our list. This is because it will
define how driver and DT writers define and write their code for Android
devices.

2. Resolve cyclic dependency between devices nodes as a side-effect.  That
will make sure Android systems do not suffer from deferred probing and we
have a generic way of serialize driver probes. (This can also be mitigated
somewhat by module dependencies outside of the kernel.)

Subsystems like regulator, interconnect can immediately benefit from #1 and
it makes the module/driver loading possible for Android systems without
regressing power horribly.

After thinking about Rob's suggestion to loop though dependencies, I think it
doesn't work because we don't know what to do when there are cycles. Drivers
sometimes need to have access to phandles in order to retrieve resources from
that phandle. We can't assume that is an implied "probe dependency". Saravana
had several such examples already and it is a _real world_ scenario.

I think the current binding are insufficient to describe the runtime hardware
dependencies. IOW, the current bindinds were probably intended to be that, but
drivers use them to get phandles for other nodes too and are not *strict*
dependencies. Either way, for Android systems to realize this goal of having
driver modules load on demand, we have to have something that does what this
patch series does.

I am also sensitive to the fact that adding a new binding in "depends-on"
will mean all Android devices will start *depending on* that DT binding (no
pun intended) without any upstream support. We want to avoid that as much
as possible.

I guess we are happy to hear better ways of doing this that work, but in the
absence of that, we are going to have to carry the series for Android and
that makes me sad :(

Suggestions, thoughts, for what Android should do here...?

Thanks
- ssp


