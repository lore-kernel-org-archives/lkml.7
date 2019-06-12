Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C6DC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8162053B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qb+kCs3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfFMRR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:17:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41806 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbfFLVVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 17:21:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id 83so9608156pgg.8;
        Wed, 12 Jun 2019 14:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MKxVm/WfGETVRsG3kCSe/758WxcwLgrzhgM6fPPKDZg=;
        b=Qb+kCs3U00uOTJiF0XYJ8Zg3wOUSD69g79a4p5UfDUBIwAB6KhNoPRApNIv00L/iL5
         pDPWbVRRwGO40eFyx0fD0DKEpj18F+YU5tT7+KcMY1Ri1MVqyZP8gZIrDAmWwhEE9Er6
         K2PLLmK6CSglO8r13crX9l215tS+glQC8oyojWeAibX4TYz3EQhGuQk7BEO+GnEXGhw5
         sXHZWATmCpENd05f0C5uPgVnlvcZoMx1w1vaKncrl7XpOLkUMikgIipuChTOkVYcsJ7o
         LHgtGhDa2KMvTLLXlNukCz9HpMrEW8aLYOKzdO1/KngAU1wVq3ATr2W1ZFac4C8CUotR
         0xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MKxVm/WfGETVRsG3kCSe/758WxcwLgrzhgM6fPPKDZg=;
        b=Uh8RVJp14FGDgL0ZcV2KcZ7ziKz95MAUaij1EWBLP0lboPD1Il20GUjhQUX6COW3bb
         4RnLtB3UCA64zFT010HXoyOreODx87K1QJjNVxkXvJMMuLKE5sV/IavDbRCCtPwdPBoI
         QxdSP2JZZlKX8YbyvaMOrdKWq7lpfydNMGbhhbkHnU9THkKNtX5NRL6EUMZ9lANggvgV
         6VVlbcl1ZNnGs7d5MlJZ611sq54lJjUsqfNbHsqj9aWuzCq22xG5zEYOgboeFJH8rvYN
         LXljt5B49HIRVkpLoond7IHDQe4hNVnzD9iBwDOKCTk2yKdNtiJTLvPhzniOL3ka1LKp
         +YoA==
X-Gm-Message-State: APjAAAWIaz4iF0vPwE7SezrXQJrm5gaP9IIexp4xt76EffYKk9W1/fuy
        akBbUD7yfpXPqrzJXFwGxCs=
X-Google-Smtp-Source: APXvYqzKHi6082P19NzJghJqnn3jp5lvt6SHmUNNSZ1OGNELyjbvr5wAqXD49msD7OmThG4Udz691A==
X-Received: by 2002:a62:1750:: with SMTP id 77mr20648005pfx.172.1560374463082;
        Wed, 12 Jun 2019 14:21:03 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id w24sm393889pga.90.2019.06.12.14.21.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 14:21:02 -0700 (PDT)
Subject: Re: [RESEND PATCH v1 0/5] Solve postboot supplier cleanup and
 optimize probe ordering
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     David Collins <collinsd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, David Collins <collinsd@codeaurora.org>
References: <20190604003218.241354-1-saravanak@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <095b631b-155d-483e-5ffb-3a04b0db0245@gmail.com>
Date:   Wed, 12 Jun 2019 14:21:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604003218.241354-1-saravanak@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding cc: David Collins

Plus my comments below.

On 6/3/19 5:32 PM, Saravana Kannan wrote:
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
> 
> Saravana Kannan (5):
>   of/platform: Speed up of_find_device_by_node()
>   driver core: Add device links support for pending links to suppliers
>   dt-bindings: Add depends-on property
>   of/platform: Add functional dependency link from "depends-on" property
>   driver core: Add sync_state driver/bus callback
> 
>  .../devicetree/bindings/depends-on.txt        |  26 +++++
>  drivers/base/core.c                           | 106 ++++++++++++++++++
>  drivers/of/platform.c                         |  75 ++++++++++++-
>  include/linux/device.h                        |  24 ++++
>  include/linux/of.h                            |   3 +
>  5 files changed, 233 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/depends-on.txt
> 


I don't think the above description adequately describes one key problem
that the patch set addresses.

David Collins described the problem in an email late in the thread of
the first submission of this series.  Instead of providing a link to
that email, I am going to fully copy it here:

On 5/31/19 4:27 PM, David Collins wrote:
> Hello Saravana,
> 
> On 5/23/19 6:01 PM, Saravana Kannan wrote:
> ...
>> Having functional dependencies explicitly called out in DT and
>> automatically added before the devices are probed, provides the
>> following benefits:
> ...
>> - Supplier devices like clock providers, regulators providers, etc
>>   need to keep the resources they provide active and at a particular
>>   state(s) during boot up even if their current set of consumers don't
>>   request the resource to be active. This is because the rest of the
>>   consumers might not have probed yet and turning off the resource
>>   before all the consumers have probed could lead to a hang or
>>   undesired user experience.
> This benefit provided by the sync_state() callback function introduced in
> this series gives us a mechanism to solve a specific problem encountered
> on Qualcomm Technologies, Inc. (QTI) boards when booting with drivers
> compiled as modules.  QTI boards have a regulator that powers the PHYs for
> display, camera, USB, UFS, and PCIe.  When these boards boot up, the boot
> loader enables this regulator along with other resources in order to
> display a splash screen image.  The regulator must remain enabled until
> the Linux display driver has probed and made a request with the regulator
> framework to keep the regulator enabled.  If the regulator is disabled
> prematurely, then the screen image is corrupted and the display hardware
> enters a bad state.
> 
> We have observed that when the camera driver probes before the display
> driver, it performs this sequence: regulator_enable(), camera register IO,
> regulator_disable().  Since it is the first consumer of the shared
> regulator, the regulator is physically disabled (even though display
> hardware still requires it to be enabled).  We have solved this problem
> when compiling drivers statically with a downstream regulator
> proxy-consumer driver.  This proxy-consumer is able to make an enable
> request for the shared regulator before any other consumer.  It then
> removes its request at late_initcall_sync.
> 
> Unfortunately, when drivers are compiled as modules instead of compiled
> statically into the kernel image, late_initcall_sync is not a meaningful
> marker of driver probe completion.  This means that our existing proxy
> voting system will not work when drivers are compiled as modules.  The
> sync_state() callback resolves this issue by providing a notification that
> is guaranteed to arrive only after all consumers of the shared regulator
> have probed.
> 
> QTI boards have other cases of shared resources such as bus bandwidth
> which must remain at least at a level set by boot loaders in order to
> properly support hardware blocks that are enabled before the Linux kernel
> starts booting.
> 
> Take care,
> David
> 

To paraphrase, the problem is:

   - bootloader enables a regulator for display
   - during Linux boot camera driver probes:
      * enable the regulator also used for display
      * disable the regulator
         + screen image is corrupted
         + display hardware enters bad state
   - later during Linux boot display driver probes:
      * enable the regulator, but too late

So the problem is an ordering dependency between the camera driver probe
and the display driver probe.

Or alternatively the problem could be seen as: the bootloader has enabled
a regulator for a device that the bootloader is aware of, but has not
communicated to the Linux regulator framework that the device requires
the regulator to remain enabled.

Thinking about the problem this way could lead to an entirely different
solution.

-Frank
      
