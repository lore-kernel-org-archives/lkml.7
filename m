Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D3BC76194
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186EC216C8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564129880;
	bh=Dln2R5c1sxVQkvy4USB/vJb7LaTofhaMOW3S89+dboA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xctCZ0myrOMbFTVTlKsSICLoY+820x2158vEp9cUbUR7vadYtaqDezHQnnZAu5ZUt
	 THh4zcMLJ7ymyXmTfcpF2y/AKsLFy3aqa3lQsBVnJIgrLoOntpKbKB3o4cteC7ks+k
	 QHYSwN+sTTUsvb80owduJCvpQR1pVNU7mbJD9sb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfGZIbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 04:31:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:42978 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725842AbfGZIbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:31:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AB72DB606;
        Fri, 26 Jul 2019 08:31:17 +0000 (UTC)
Date:   Fri, 26 Jul 2019 10:31:17 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1] ACPI / scan: Acquire device_hotplug_lock in
 acpi_scan_init()
Message-ID: <20190726083117.GJ6142@dhcp22.suse.cz>
References: <20190724143017.12841-1-david@redhat.com>
 <20190725125636.GA3582@dhcp22.suse.cz>
 <6dc566c2-faf6-565d-4ef1-2ac3a366bc76@redhat.com>
 <20190725135747.GB3582@dhcp22.suse.cz>
 <447b74ca-f7c7-0835-fd50-a9f7191fe47c@redhat.com>
 <20190725191943.GA6142@dhcp22.suse.cz>
 <e31882cf-3290-ea36-77d6-637eaf66fe77@redhat.com>
 <20190726075729.GG6142@dhcp22.suse.cz>
 <fd9e8495-1a93-ac47-442f-081d392ed09b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd9e8495-1a93-ac47-442f-081d392ed09b@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26-07-19 10:05:58, David Hildenbrand wrote:
> On 26.07.19 09:57, Michal Hocko wrote:
> > On Thu 25-07-19 22:49:36, David Hildenbrand wrote:
> >> On 25.07.19 21:19, Michal Hocko wrote:
> > [...]
> >>> We need to rationalize the locking here, not to add more hacks.
> >>
> >> No, sorry. The real hack is calling a function that is *documented* to
> >> be called under lock without it. That is an optimization for a special
> >> case. That is the black magic in the code.
> > 
> > OK, let me ask differently. What does the device_hotplug_lock actually
> > protects from in the add_memory path? (Which data structures)
> > 
> > This function is meant to be used when struct pages and node/zone data
> > structures should be updated. Why should we even care about some device
> > concept here? This should all be handled a layer up. Not all memory will
> > have user space API to control online/offline state.
> 
> Via add_memory()/__add_memory() we create memory block devices for all
> memory. So all memory we create via this function (IOW, hotplug) will
> have user space APIs.

Ups, I have mixed add_memory with add_pages which I've had in mind while
writing that. Sorry about the confusion.

Anyway, my dislike of the device_hotplug_lock persists. I would really
love to see it go rather than grow even more to the hotplug code. We
should be really striving for mem hotplug internal and ideally range
defined locking longterm.

-- 
Michal Hocko
SUSE Labs
