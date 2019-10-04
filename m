Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A9FC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE70B222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NsRPdCT+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388450AbfJDNco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:32:44 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37229 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388270AbfJDNcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:32:43 -0400
Received: by mail-io1-f67.google.com with SMTP id b19so13568737iob.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 06:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wRHGFsQMIDC8m376mc63E7wEOAD5ITX6WDH77PzxyQ8=;
        b=NsRPdCT+T6Cc2S2CpDv0rf0WDwFwQeIMg+Sv9DOKGhqre7BaxUUUN8xCcX1UJoWSNL
         k0pckZdKgODpDOv8eInlAfuomy6pkn3fIsNHZ/oOViFPOGjnWj7eFl33caHnqvqCmFcd
         5bD7MKgeSnRU2eIrx7+IEx3175Nhabn+GoHSkGuE6TAe0S2WqUMcrPRTiNBllOxTJMnE
         L9J6BQyCQKQtdYMDrniNKIq0lQXG+8v+elHIcEOLoQZ2u+YZBc2orrNyt3mG/zKZkUpZ
         zvwuumyIlxyw+39S2usvwuus10IEPBCNg5ED8AChEhJZHZD58jlQXSw9zOG0yFn6qng9
         aG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wRHGFsQMIDC8m376mc63E7wEOAD5ITX6WDH77PzxyQ8=;
        b=XeT2RDY4pqO2BHyXPbcXc8B5wHgzAFqgbMYr+b4hUPr4vPXrpV/c8d22kNrN1xNbWZ
         jAub0M2U44wdqEYKOINPcrJkOG/F/PiV6h+nMCDZC8sXoayD40ShOWHsT+9fxlA6HpNM
         rtn6w1qH0WZdGetwmhFwKOg2JGTacxHnPrQFsVcbJWdB7iD9qot9Dzx4wsecJ5eZqRxL
         E2SGw52XcOHJ18BfCZSzlITwduSWHyFrFSPkJuiocjtW444OMKxBbBcPvtmsRBixWr5D
         FQDw0VabnW8bLBY/JewrCr44QbUk6tTyw6z/abpXmF7EfgvCzyG+NsAnFZSBp+UqK2Ek
         u5Jg==
X-Gm-Message-State: APjAAAUYBM/J3c4oP59ZRNjg6ZxpwumYuoxa8VAdcn0Tm72u8cCN035e
        x4RkqCdmxk05cIbtSUxIjLu4eIAg6kdWJQ==
X-Google-Smtp-Source: APXvYqxWwyHE26+gIZ6KDkIhQyxHlYbL+uzCyQoyyQJfAwtrmSEclwpUZMYL5i0Fk1zQmn1woWXR1A==
X-Received: by 2002:a92:9fdb:: with SMTP id z88mr16669276ilk.38.1570195962479;
        Fri, 04 Oct 2019 06:32:42 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o17sm2382146ils.46.2019.10.04.06.32.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 06:32:41 -0700 (PDT)
Subject: Re: System hangs if NVMe/SSD is removed during suspend
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Tejun Heo <tj@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        AceLan Kao <acelan.kao@canonical.com>, Jan Kara <jack@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20191002122136.GD2819@lahna.fi.intel.com>
 <20191003165033.GC3247445@devbig004.ftw2.facebook.com>
 <20191004080340.GB2819@lahna.fi.intel.com> <2367934.HCQFgJ56tP@kreacher>
 <20191004110151.GH2819@lahna.fi.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <99b3ffb8-4205-9795-a48a-09125f5fceec@kernel.dk>
Date:   Fri, 4 Oct 2019 07:32:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191004110151.GH2819@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/19 5:01 AM, Mika Westerberg wrote:
> On Fri, Oct 04, 2019 at 11:59:26AM +0200, Rafael J. Wysocki wrote:
>> On Friday, October 4, 2019 10:03:40 AM CEST Mika Westerberg wrote:
>>> On Thu, Oct 03, 2019 at 09:50:33AM -0700, Tejun Heo wrote:
>>>> Hello, Mika.
>>>>
>>>> On Wed, Oct 02, 2019 at 03:21:36PM +0300, Mika Westerberg wrote:
>>>>> but from that discussion I don't see more generic solution to be
>>>>> implemented.
>>>>>
>>>>> Any ideas we should fix this properly?
>>>>
>>>> Yeah, the only fix I can think of is not using freezable wq.  It's
>>>> just not a good idea and not all that difficult to avoid using.
>>>
>>> OK, thanks.
>>>
>>> In that case I will just make a patch that removes WQ_FREEZABLE from
>>> bdi_wq and see what people think about it :)
>>
>> I guess that depends on why WQ_FREEZABLE was added to it in the first place. :-)
>>
>> The reason might be to avoid writes to persistent storage after creating an
>> image during hibernation, since wqs remain frozen throughout the entire
>> hibernation including the image saving phase.
> 
> Good point.
> 
>> Arguably, making the wq freezable is kind of a sledgehammer approach to that
>> particular issue, but in principle it may prevent data corruption from
>> occurring, so be careful there.
> 
> I tried to find the commit that introduced the "freezing" and I think it
> is this one:
> 
>    03ba3782e8dc writeback: switch to per-bdi threads for flushing data
> 
> Unfortunately from that commit it is not clear (at least to me) why it
> calls set_freezable() for the bdi task. It does not look like it has
> anything to do with blocking writes to storage while entering
> hibernation but I may be mistaken.

Wow, a decade ago...

Honestly, I don't recall why these were marked freezable, and as I wrote
in the other reply, I don't think there's a good reason for that to be
the case.

-- 
Jens Axboe

