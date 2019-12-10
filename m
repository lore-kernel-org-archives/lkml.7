Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC36C2D0C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929092053B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575973718;
	bh=IaLF+6C6rtCeO28wRs53cVjaoPZ2JIiz4oxX9ATcRyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gqTugqOdOIZTMbe1onL914PLll9klAGzlsMH2MHEbuekkFDydYnIwYxHPP6xX2dTZ
	 V3PZhzxVFJsTOvzyHrZ5XnTORDNLZv4U25j8dVpxu3F3ATieoyaRFGb+gn/qKMpfwp
	 K3TmXnB/I7HPj8M8nEUo2GA8HZV0jAdQmFS4ovd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfLJK2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:28:37 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51914 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfLJK2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:28:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id g206so2533126wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 02:28:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fudI/aRGQE48dZnpXNXew2ZtUZnD2II/Xql7iFkccbY=;
        b=g4LHcyKPNJ96bwG/fZbNzIH2amGh72gJneSIeu1H8MbshZ4lzJBZBw4YAw4kjX+nZS
         7RceXh1hSeOAhEX4weIebYejdMcquP/CopsW+EfcXgUB8JbuZj4Bi2LdQe6w+MJ/14TM
         SfcYb86nAj5SRdCrzkPkzm37CD8vkkMVvAZhC07bU3+p3RRx/XdxLmKnW6u4V4oeOF4B
         /WRd8vmEyhiIFQRHatLCbAnxD1UaW5l+6RwmjKRJUKN7Ysz6GJuEXUxMw5rvc5EQwWxG
         D5Bn7T//H1xA4c/6G3+3LykPvoaqgVpfLUfzMnp7vPZl6ibGumyiHWE2BoWdkRmBbuTe
         ZNaQ==
X-Gm-Message-State: APjAAAV3dVU/zz3R98dKv9hBOc7Fqa/5IgeMNJVVFqkDRjKn3azUYuWk
        +lDYuHBxuVG5n5Sh4m9B3afaIAmv
X-Google-Smtp-Source: APXvYqx/v6CfpInoUTQTQoZfdNAAhX+8sLPCZQs4TdYgIAyp3JgIU9yVpLdDIJsMWnTgvEF4Gz1LEg==
X-Received: by 2002:a1c:4f:: with SMTP id 76mr4129259wma.69.1575973715127;
        Tue, 10 Dec 2019 02:28:35 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id h127sm2634857wme.31.2019.12.10.02.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 02:28:34 -0800 (PST)
Date:   Tue, 10 Dec 2019 11:28:34 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, jgross@suse.com,
        william.kucharski@oracle.com, mingo@kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm/hotplug: Only respect mem= parameter during boot stage
Message-ID: <20191210102834.GE10404@dhcp22.suse.cz>
References: <20191206150524.14687-1-bhe@redhat.com>
 <20191209100717.GC6156@dhcp22.suse.cz>
 <20191210072453.GI2984@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210072453.GI2984@MiWiFi-R3L-srv>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-12-19 15:24:53, Baoquan He wrote:
> On 12/09/19 at 11:07am, Michal Hocko wrote:
> > On Fri 06-12-19 23:05:24, Baoquan He wrote:
> > > In commit 357b4da50a62 ("x86: respect memory size limiting via mem=
> > > parameter") a global varialbe global max_mem_size is added to store
> > > the value which is parsed from 'mem= '. This truly stops those
> > > DIMM from being added into system memory during boot.
> > > 
> > > However, it also limits the later memory hotplug functionality. Any
> > > memory board can't be hot added any more if its region is beyond the
> > > max_mem_size. System will print error like below:
> > > 
> > > [  216.387164] acpi PNP0C80:02: add_memory failed
> > > [  216.389301] acpi PNP0C80:02: acpi_memory_enable_device() error
> > > [  216.392187] acpi PNP0C80:02: Enumeration failure
> > > 
> > > >From document of 'mem =' parameter, it should be a restriction during
> > > boot, but not impact the system memory adding/removing after booting.
> > > 
> > >   mem=nn[KMG]     [KNL,BOOT] Force usage of a specific amount of memory
> > > 
> > > So fix it by also checking if it's during SYSTEM_BOOTING stage when
> > > restrict memory adding. Otherwise, skip the restriction.
> > 
> > Could you be more specific about why the boot vs. later hotplug makes
> > any difference? The documentation is explicit about the boot time but
> > considering this seems to be like that since ever I strongly suspect
> > that this is just an omission.
> 
> I think the 'mem=' updating in commit 357b4da50a62 will only affect
> those hotplugable memory regions. When I tested it, there are three
> memmory boards, one is the normal memory region with 4G memory, and the
> other two are hotpluggable memory boards and recorded in ACPI tables,
> each is 1GB. When put all them three onsite before boot, they will be
> recognized by firmware and written into e820 table and/or EFI table, then
> kernel can read them from e820 and them as system memory, we get 6G
> memory. 
> 
> However, if add 'mem=', like 'mme=3G', w/o commit 357b4da50a62, in e820,
> we will only get 3G memory. Later in acpi_init(), acpi scanning will
> search those two memory regions, and try to add them into system call
> because the two hotpluggable memory boards are power on and ready.
> Then we will get 3G + 1G + 1G, 5G memory. the 1st 3G is from the normal
> memory board, its last 1G is trimmed. Jurgen's patch is trying to fix this
> because the adding happens during boot time, and conflicts with 'mem='. 

Unless I misunderstand what you are saying this all is just expected.
You have restricted the memory explicitly and the result is that not all
the memory is visible.

> But after system bootup, we should be able to hot add/remove any memory
> board. This should not be restricted by a boot-time kernel parameter
> 'mme='. This is what I am trying to fix.

This is a simple statement without any actual explanation on why. Why is
hotplug memory special? What is the usecase? Who would want to use mem
parameter and later expect a memory above the restrected area to be
hotplugable?

David has provided an actual usecase [1] but this needs to be documented
somewhere so that we do not break that accidentally in the future.
Ideally both in code which adds the boot restriction and the kernel
command line documentation to be explicit about BOOT restriction.

[1] http://lkml.kernel.org/r/429622cf-f0f4-5d80-d39d-b0d8a6c6605f@redhat.com
-- 
Michal Hocko
SUSE Labs
