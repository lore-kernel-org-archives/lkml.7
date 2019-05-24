Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88195C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F692168B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558703096;
	bh=l4t6CtyS8OAuOzB3K8zNqJtlqJ5eH46BJbroNn6tWdo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XzATL3SspqTXUAxOadDca/5xPkBuQt65yQdohTwdgaj9Rum/26rkc4F/4n+5woJSa
	 2eZ8IGDEhqzK5WQt/Yy9bodnCMCOA+YmAsz93l4rVuV5Ii91nzRrFwVgZxHZYMc9gi
	 EI7LmKAlF3c+A7/d0ESxmSH2BE40A55P5Lqm506o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391574AbfEXNEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 09:04:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391193AbfEXNEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 09:04:55 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 762912184E;
        Fri, 24 May 2019 13:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558703094;
        bh=l4t6CtyS8OAuOzB3K8zNqJtlqJ5eH46BJbroNn6tWdo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B5GkERmExuEsL0nNeOynZFaOkUNEmjjvC5mPYRnQCgCbA4lWg6zPzs9Ir/UW90vI/
         i7tb8OciJvD6Bl2srehW9BPgaGOOJsa1wbhPn/YRnDvmE8gfh3R4MwYv58j41IxwnB
         IjMj2kAKQHlpg2Xafx6ZDVO4tUGM9LnYWgn7oEko=
Received: by mail-qk1-f173.google.com with SMTP id t64so7204572qkh.1;
        Fri, 24 May 2019 06:04:54 -0700 (PDT)
X-Gm-Message-State: APjAAAWS16+CGTnerKdIVi3/0Q41b22p3gWFFAFzRZCaE1eO5BFjUIAL
        NuO0XDDo25QIXRuNuc966cZw2sh8DZiHwjLlAg==
X-Google-Smtp-Source: APXvYqzttVxi8ocThZlAkAUMLzwoMvppPQwP1Jl3JDk64KXopdTDxe6RTxzWqF0DCJ3fC4NAQRjG2PeZppcG4AEApO0=
X-Received: by 2002:a0c:ad23:: with SMTP id u32mr46430375qvc.39.1558703093679;
 Fri, 24 May 2019 06:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190524010117.225219-1-saravanak@google.com>
In-Reply-To: <20190524010117.225219-1-saravanak@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 24 May 2019 08:04:41 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKiXEKECMZpZR3j+uRqnsec5f0vN301tagT687HRhu6Nw@mail.gmail.com>
Message-ID: <CAL_JsqKiXEKECMZpZR3j+uRqnsec5f0vN301tagT687HRhu6Nw@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Solve postboot supplier cleanup and optimize probe ordering
To:     Saravana Kannan <saravanak@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 8:01 PM Saravana Kannan <saravanak@google.com> wrote:
>
> Add a generic "depends-on" property that allows specifying mandatory
> functional dependencies between devices. Add device-links after the
> devices are created (but before they are probed) by looking at this
> "depends-on" property.

The DT already has dependency information. A node with 'clocks'
property has its dependency right there. We should use that. We don't
need to duplicate the information.

> This property is used instead of existing DT properties that specify
> phandles of other devices (Eg: clocks, pinctrl, regulators, etc). This
> is because not all resources referred to by existing DT properties are
> mandatory functional dependencies. Some devices/drivers might be able
> to operate with reduced functionality when some of the resources
> aren't available. For example, a device could operate in polling mode
> if no IRQ is available, a device could skip doing power management if
> clock or voltage control isn't available and they are left on, etc.

Yeah, but none of these examples are typically what you'd want to
happen. These cases are a property of the OS, not the DT. For example,
until recently, If you added pinctrl bindings to your DT, the kernel
would no longer boot because it would be looking for pinctrl driver.
That's wrong because the DT should not be coupled to the OS like that.
Adding this property will cause the same problem.

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

Do you have data on how much time is spent. Past 'smarter probing'
attempts have not shown a significant difference.

> - Supplier devices like clock providers, regulators providers, etc
>   need to keep the resources they provide active and at a particular
>   state(s) during boot up even if their current set of consumers don't
>   request the resource to be active. This is because the rest of the
>   consumers might not have probed yet and turning off the resource
>   before all the consumers have probed could lead to a hang or
>   undesired user experience.

We already know generally what devices are dependencies because you
just listed them. Why don't we make the kernel smarter by
instantiating these core devices/drivers first instead of relying on
initcall and link order.

>   Some frameworks (Eg: regulator) handle this today by turning off
>   "unused" resources at late_initcall_sync and hoping all the devices
>   have probed by then. This is not a valid assumption for systems with
>   loadable modules. Other frameworks (Eg: clock) just don't handle
>   this due to the lack of a clear signal for when they can turn off
>   resources. This leads to downstream hacks to handle cases like this
>   that can easily be solved in the upstream kernel.

IMO, we should get rid of this auto disabling.

Rob
