Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1353C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88AC5206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="hi5kcFLu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387744AbfG2MWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 08:22:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39369 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfG2MWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 08:22:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so8458935wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 05:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4xJv/RlYVsMTmymZ03BVzmA0ujnyoY1BNvCxMH+Th3E=;
        b=hi5kcFLu0H3JkoPCRLd7zTp242F4y+S14BmGOIe9p525GeRcqCgnjcxzKppG5fc8ov
         hte8Q28w4gN9kCMwuHpMYKtCMYUoda/fqHCIPf4O2OfVhG9E75OChQgy2chDB0hNBM2B
         47QLXJXShM2D62VqEQ8EwZGao4NeXn+Vh0E1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4xJv/RlYVsMTmymZ03BVzmA0ujnyoY1BNvCxMH+Th3E=;
        b=Fk/c2phWxKFa5JR3fziiQP71m2n34alWpjbYVM1eiypsdAMQOWR1s2jl9uI8T3Alrm
         HgjBFw6BLxuI9rTK5jAg1dmFj1hzG4pf3cGxck6vtq2Ezf/1QrV8AEvJ/Thuvxu4nQhQ
         w8CrNje9LJdmcZUWlAzXp9Ud8bmm80J/2D4aW8LUNfmtIJ8teMBX2P6qs+PoUcoZYGhh
         gQoFDq+4Y70uRhoSxHK72ukZ3VCyirV6mG6u3vcJnygtHwuntAYiewOi1JQpWxxx0UgH
         3+gwLRfLM7+xGs0TeRa5byI1JNFL2DFDCpVZc5FzROKg7ytewQ81KplQUR+Q8d8Ln9E1
         GyHQ==
X-Gm-Message-State: APjAAAVi/v0bI8yBoMZm2LDxKEa/PYxER5AbDVzFncFv/ID8o8hYsjRU
        OWXiIATs6V8+6sLR/Wc7kGeekBl7qKU=
X-Google-Smtp-Source: APXvYqzTZ04vcIAz68DOV0am57cKQrKsnk9DYFjABMfl84YSR8j+55zyVAF2bnm9jy4xrQ60nYf15A==
X-Received: by 2002:a5d:5012:: with SMTP id e18mr18481650wrt.166.1564402934775;
        Mon, 29 Jul 2019 05:22:14 -0700 (PDT)
Received: from [192.168.0.107] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id z25sm64631411wmf.38.2019.07.29.05.22.13
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 05:22:14 -0700 (PDT)
Subject: Re: [PATCH] net: bridge: Allow bridge to joing multicast groups
To:     "Allan W. Nielsen" <allan.nielsen@microchip.com>
Cc:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        roopa@cumulusnetworks.com, davem@davemloft.net,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1564055044-27593-1-git-send-email-horatiu.vultur@microchip.com>
 <7e7a7015-6072-d884-b2ba-0a51177245ab@cumulusnetworks.com>
 <eef063fe-fd3a-7e02-89c2-e40728a17578@cumulusnetworks.com>
 <20190725142101.65tusauc6fzxb2yp@soft-dev3.microsemi.net>
 <b9ce433a-3ef7-fe15-642a-659c5715d992@cumulusnetworks.com>
 <e6ad982f-4706-46f9-b8f0-1337b09de350@cumulusnetworks.com>
 <20190726120214.c26oj5vks7g5ntwu@soft-dev3.microsemi.net>
 <b755f613-e6d8-a2e6-16cd-6f13ec0a6ddc@cumulusnetworks.com>
 <20190729121409.wa47uelw5f6l4vs4@lx-anielsen.microsemi.net>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <95315f9e-0d31-2d34-ba50-11e1bbc1465c@cumulusnetworks.com>
Date:   Mon, 29 Jul 2019 15:22:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190729121409.wa47uelw5f6l4vs4@lx-anielsen.microsemi.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Allan,
On 29/07/2019 15:14, Allan W. Nielsen wrote:
> Hi Nikolay,
> 
> First of all, as mentioned further down in this thread, I realized that our
> implementation of the multicast floodmasks does not align with the existing SW
> implementation. We will change this, such that all multicast packets goes to the
> SW bridge.
> 
> This changes things a bit, not that much.
> 
> I actually think you summarized the issue we have (after changing to multicast
> flood-masks) right here:
> 
> The 07/26/2019 12:26, Nikolay Aleksandrov wrote:
>>>> Actually you mentioned non-IP traffic, so the querier stuff is not a problem. This
>>>> traffic will always be flooded by the bridge (and also a copy will be locally sent up).
>>>> Thus only the flooding may need to be controlled.
> 
> This seems to be exactly what we need.
> 
> Assuming we have a SW bridge (br0) with 4 slave interfaces (eth0-3). We use this
> on a network where we want to limit the flooding of frames with dmac
> 01:21:6C:00:00:01 (which is non IP traffic) to eth0 and eth1.
> 
> One way of doing this could potentially be to support the following command:
> 
> bridge fdb add    01:21:6C:00:00:01 port eth0
> bridge fdb append 01:21:6C:00:00:01 port eth1
> 
> On 25/07/2019 16:06, Nikolay Aleksandrov wrote:
>>>>>>>>  In general NLM_F_APPEND is only used in vxlan, the bridge does not
>>>>>>>>  handle that flag at all.  FDB is only for *unicast*, nothing is joined
>>>>>>>>  and no multicast should be used with fdbs. MDB is used for multicast
>>>>>>>>  handling, but both of these are used for forwarding.
> This is true, and this should have been addressed in the patch, we were too
> focused on setting up the offload patch in the driver, and forgot to do the SW
> implementation.
> 
> Do you see any issues in supporting this flag, and updating the SW
> forwarding in br_handle_frame_finish such that it can support/allow a FDB entry
> to be a multicast?
> 

Yes, all of the multicast code is handled differently, it doesn't go through the fdb
lookup or code at all. I don't see how you'll do a lookup in the fdb table with a
multicast mac address, take a look at br_handle_frame_finish() and you'll notice
that when a multicast dmac is detected then we use the bridge mcast code for lookups
and forwarding. If you're trying to achieve Rx only on the bridge of these then
why not just use Ido's tc suggestion or even the ip maddr add offload for each port ?

If you add a multicast mac in the fdb (currently allowed, but has no effect) and you
use dev_mc_add() as suggested that'd just be a hack to pass it down and it is already
possible to achieve via other methods, no need to go through the bridge.

> /Allan
> 

