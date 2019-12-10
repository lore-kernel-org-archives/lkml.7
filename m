Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CFCC2D0C5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D47207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575971407;
	bh=BVM4zL9n0R4w/Kl6HDxdTjjADtkfjRRwb8D0ukIAYJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p+vpzXefJ3ZRwhNcJIZBNHkXqrPODDTswNozfYc+NLdd29HndDdSskNFqtLZXBdvP
	 9rfYhUTpCioXHtmCEKlbuGaMM9kZP7xkVm0hMsxaAlj8i6ho2TDDnOOjLzoEELQaym
	 9jZEK3bCHxt1zJvmSNa1PmF1YCzh4QOMUR3ZQYpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfLJJuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:50:06 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41123 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfLJJuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:50:05 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so19248641wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 01:50:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7WkJTOKc1Bnd1dO9SMcHZyqU/qBYt7sZp0ZFAmC/CkU=;
        b=bflki9rk9mIDXM/aufVope2ueKk9ovPdqZY0ud9NhxXipIonmyPNkpkdc+aJagXP5/
         nHr3eUhHIfv1nwNDwKaFjaXAFd8qt1WNtr+RkoAQ9aT4dKB9hijevuiWNnL9wZWtCMre
         dff5HBZkzKVD77gEgu7MdvPWsJKOBo50Fe6gX5t+OY1qJmUnHed5EpeDSF/FmF5yyJAK
         Fo3PsN1VlSiwZXcGgy0GCsYnrM959a6UHfu1umE2z67RIx7bv8kHXgAbb97UiXcRw+Hf
         2dId0ikA1g88ySNxId2LbZGmuocy+ILPAhPBaUvs1BsmqD7GZRMYhpRZqDUvwiJRHfts
         PZAw==
X-Gm-Message-State: APjAAAX1MxPQVFwcj1/fI938FxsQfeh20udqvV2uNjRC/XBbXlADNLwR
        R6hLttFyocxF4iSlYeJyiGU=
X-Google-Smtp-Source: APXvYqyKiFRp4ntrVzf8c4z9W2pSugz+5UBlNTqIBRLIH0lcFqj5Wr0oe1UwnuQMV8dezFZ45h4nZQ==
X-Received: by 2002:adf:82f3:: with SMTP id 106mr2169013wrc.69.1575971403497;
        Tue, 10 Dec 2019 01:50:03 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id w13sm2727586wru.38.2019.12.10.01.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 01:50:02 -0800 (PST)
Date:   Tue, 10 Dec 2019 10:50:02 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Balbir Singh <bsingharora@gmail.com>, Baoquan He <bhe@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, jgross@suse.com,
        akpm@linux-foundation.org
Subject: Re: [Patch v2] mm/hotplug: Only respect mem= parameter during boot
 stage
Message-ID: <20191210095002.GA10404@dhcp22.suse.cz>
References: <20191210084413.21957-1-bhe@redhat.com>
 <75188d0f-c609-5417-aa2e-354e76b7ba6e@gmail.com>
 <429622cf-f0f4-5d80-d39d-b0d8a6c6605f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429622cf-f0f4-5d80-d39d-b0d8a6c6605f@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-12-19 10:36:19, David Hildenbrand wrote:
> On 10.12.19 10:24, Balbir Singh wrote:
> > 
> > 
> > On 10/12/19 7:44 pm, Baoquan He wrote:
> >> In commit 357b4da50a62 ("x86: respect memory size limiting via mem=
> >> parameter") a global varialbe global max_mem_size is added to store
> >                   typo ^^^
> >> the value parsed from 'mem= ', then checked when memory region is
> >> added. This truly stops those DIMM from being added into system memory
> >> during boot-time.
> >>
> >> However, it also limits the later memory hotplug functionality. Any
> >> memory board can't be hot added any more if its region is beyond the
> >> max_mem_size. System will print error like below:
> >>
> >> [  216.387164] acpi PNP0C80:02: add_memory failed
> >> [  216.389301] acpi PNP0C80:02: acpi_memory_enable_device() error
> >> [  216.392187] acpi PNP0C80:02: Enumeration failure
> >>
> >> From document of 'mem= ' parameter, it should be a restriction during
> >> boot, but not impact the system memory adding/removing after booting.
> >>
> >>   mem=nn[KMG]     [KNL,BOOT] Force usage of a specific amount of memory
> >> 	          ...
> >>
> >> So fix it by also checking if it's during boot-time when restrict memory
> >> adding. Otherwise, skip the restriction.
> >>
> > 
> > The fix looks reasonable, but I don't get the use case. Booting with mem= is
> > generally a debug option, is this for debugging memory hotplug + limited memory?
> 
> Some people/companies use "mem=" along with KVM e.g., to avoid
> allocating memmaps for guest backing memory and to not expose it to the
> buddy across kexec's. The excluded physical memory is then memmap into
> the hypervisor process and KVM can deal with that. I can imagine that
> hotplug might be desirable as well for such use cases.

If this is really the usecase (it makes some sense to me) then it should
be folded into the changelog. Because the real semantic is not really
clear as I've pointed out in the previous version of this patch [1].
The restriction to BOOT is documented since ever long before the memory
hotplug was a thing.

Thanks!

[1] Btw. it would have been much better if you posted the version 2 only
after all the feedback got discussed properly.

-- 
Michal Hocko
SUSE Labs
