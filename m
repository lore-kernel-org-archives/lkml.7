Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACCAC433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 02:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC59217F4
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 02:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hM96Sb0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfHJC5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 22:57:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44681 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfHJC5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 22:57:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so46971497pfe.11;
        Fri, 09 Aug 2019 19:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kQcn7trNekDj0qqTtDkSs96HNHs6dudjhS459W20OWo=;
        b=hM96Sb0BYW/n/w11bIADqi7mwIwqUS+dBKttzYw4hWbql5ALkH5BSFvdfVEzHEp6Jp
         0NCyPcckjd4ksM+HtzUM4OTyhbRfo58Nnx/pR7k1/WOpBHvitgL8PosUcZZNt5FMrNuU
         ghhTMw2N/JaYr2nkCoHSeJZq3syjmqLtDRo5owDJA4ZB0k0IevX/G/yedx3j8g3tqGec
         QBhySOvX4QgXE5R76K8ohI1g8LCxCqbBMQL5dlx0RvfTCOLhKGIinaymYoH9tWn0viE9
         L2giVnaAcuxt6x+z+Pm0DWPWxWSsNT/QzajTq5V4AhvhtF7ewa6ZQxF1nTYIlntN3Ff0
         F1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kQcn7trNekDj0qqTtDkSs96HNHs6dudjhS459W20OWo=;
        b=SJnrtt1MKTMZT1c+MqlkAwSlZ/0qkTZzpsOQRg6ariy3/PMRBh60qVf8zUlyR3Te17
         8HwSM8BYT2ft/LBFrFhquSBpMw5OJYh1tkiq/HkPZ8nv0VTPvUBmTwlus7pZwBlwbqyv
         FzYs4FVpPJlxqLPvUTYP6M/MiZHfYLxSZNaMpxfCIRFaPTMSmItniq62686vqSMC88HA
         zFl17Q1OvXgcW+GzAzRyso8i+S57BOCQ3jBlnbdWndgLHT/J45XXXP2KJ7RcWTIiZvt+
         +T7SGMzAeUuM0fYGRCKErldsz5+iulVKCQZfoNgVbWDj+qbseJF1TspW6izM4PEnW4Un
         219w==
X-Gm-Message-State: APjAAAWDJaH6IgHFooGY18gdRcgPlcCAxoSp9pFlpkxJYnWGMXjZgNRP
        oE7+eI4mEkoG1tnLzt8BC0w=
X-Google-Smtp-Source: APXvYqyODM1aXn3F0N5dKbLQNYVoL+RPmQnATl8faybWKMxo9YzKkJEhSTG1H5dvEuw5VlZHE876og==
X-Received: by 2002:a65:64cf:: with SMTP id t15mr19721356pgv.88.1565405865533;
        Fri, 09 Aug 2019 19:57:45 -0700 (PDT)
Received: from [192.168.1.70] (c-73-231-235-122.hsd1.ca.comcast.net. [73.231.235.122])
        by smtp.gmail.com with ESMTPSA id m13sm4112400pfh.36.2019.08.09.19.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 19:57:44 -0700 (PDT)
Subject: Re: [PATCH v9 0/7] Solve postboot supplier cleanup and optimize probe
 ordering
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com
References: <20190731221721.187713-1-saravanak@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <919b66e9-9708-de34-41cd-e448838b130c@gmail.com>
Date:   Fri, 9 Aug 2019 19:57:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731221721.187713-1-saravanak@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On 7/31/19 3:17 PM, Saravana Kannan wrote:
> Add device-links to track functional dependencies between devices
> after they are created (but before they are probed) by looking at
> their common DT bindings like clocks, interconnects, etc.
> 
> Having functional dependencies automatically added before the devices
> are probed, provides the following benefits:
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
> - Supplier devices like clock providers, interconnect providers, etc
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
> v1 -> v2:
> - Drop patch to speed up of_find_device_by_node()
> - Drop depends-on property and use existing bindings
> 
> v2 -> v3:
> - Refactor the code to have driver core initiate the linking of devs
> - Have driver core link consumers to supplier before it's probed
> - Add support for drivers to edit the device links before probing
> 
> v3 -> v4:
> - Tested edit_links() on system with cyclic dependency. Works.
> - Added some checks to make sure device link isn't attempted from
>   parent device node to child device node.
> - Added way to pause/resume sync_state callbacks across
>   of_platform_populate().
> - Recursively parse DT node to create device links from parent to
>   suppliers of parent and all child nodes.
> 
> v4 -> v5:
> - Fixed copy-pasta bugs with linked list handling
> - Walk up the phandle reference till I find an actual device (needed
>   for regulators to work)
> - Added support for linking devices from regulator DT bindings
> - Tested the whole series again to make sure cyclic dependencies are
>   broken with edit_links() and regulator links are created properly.
> 
> v5 -> v6:
> - Split, squashed and reordered some of the patches.
> - Refactored the device linking code to follow the same code pattern for
>   any property.
> 
> v6 -> v7:
> - No functional changes.
> - Renamed i to index
> - Added comment to clarify not having to check property name for every
>   index
> - Added "matched" variable to clarify code. No functional change.
> - Added comments to include/linux/device.h for add_links()
> 
> v7 -> v8:
> - Rebased on top of linux-next to handle device link changes in [1]
> 


> v8 -> v9:
> - Fixed kbuild test bot reported errors (docs and const)

Some maintainers have strong opinions about whether change logs should be:

  (1) only in patch 0
  (2) only in the specific patches that are changed
  (3) both in patch 0 and in the specific patches that are changed.

I can adapt to any of the three styles.  But for style "(1)" please
list which specific patch has changed for each item in the change list.

-Frank


> 
> [1] - https://lore.kernel.org/lkml/2305283.AStDPdUUnE@kreacher/
> 
> -Saravana
> 
> 
> Saravana Kannan (7):
>   driver core: Add support for linking devices during device addition
>   driver core: Add edit_links() callback for drivers
>   of/platform: Add functional dependency link from DT bindings
>   driver core: Add sync_state driver/bus callback
>   of/platform: Pause/resume sync state during init and
>     of_platform_populate()
>   of/platform: Create device links for all child-supplier depencencies
>   of/platform: Don't create device links for default busses
> 
>  .../admin-guide/kernel-parameters.txt         |   5 +
>  drivers/base/core.c                           | 168 ++++++++++++++++
>  drivers/base/dd.c                             |  29 +++
>  drivers/of/platform.c                         | 189 ++++++++++++++++++
>  include/linux/device.h                        |  60 ++++++
>  5 files changed, 451 insertions(+)
> 

