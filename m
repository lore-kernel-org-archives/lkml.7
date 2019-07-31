Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A395C32750
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 02:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C9E2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 02:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0cwZYY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbfGaCVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 22:21:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34691 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfGaCVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 22:21:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id b13so30910532pfo.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 19:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=wfO9r2YHzfXnuX5Kr+rPkjXbDXK210fTn6hrztawxZ0=;
        b=Z0cwZYY6NB9z3AeRFZ5F9ivrbekqwqA754MYg0lxZjoYmmBYsJ/Bl5wHSjCKN2LKBb
         RiVb5ZqBigEi4yXwuIOEc+nJm9XYTqh9pkF3ES4VOLOnLst2nENuMZ5bG6Gbp4kPWl+X
         o4vpIC701znWr7RpZaoEqbr+/iYRHbkWllXL4o2GCx4fis/KCQhsrL0vYoZ88J5Amasj
         iNC5H8rZr6XTCcyOtcWZGOYJ5RxHa4DpWz9b98qFzLk7iUJODCPdexNE2tz+I6fQfbhv
         ZQ7hTkO3HvNNx1onQLjN+IFoG63qcYI0uegXN2aKkbVSDUnES9G0m5qhEHNx+/x5H/1A
         Rntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=wfO9r2YHzfXnuX5Kr+rPkjXbDXK210fTn6hrztawxZ0=;
        b=HqpF6FlAzMdD7p5txEvNaEk/R5REOLLd4RfhqbbUKjc1WoFKO9VR9astgxIYu5tIbT
         JjZkCMM/5KZk5ixrw9Yk01fu8GiU86L/WZ3Yv45BHjYPbeiowomveu4gyPpVUEWpbjYC
         gAkyAibTxEv2cosjSTNew5gwjFPKlkJlHv5C2khjpieEMzHr3869Z3SICmX8Au9syEZo
         sXdXU+wnogN8N57ulF0/jqbS+ugPwWIeh24BZ8B8d7vmparf3IF5f7eC6wDCgyylIP+6
         1DwaiLdshohrvRwAOIk2k/bFwmUOVDnACIUgdbm5WRRzblGJGcbt7e2AkaQ0iSLKie/c
         XRuw==
X-Gm-Message-State: APjAAAXZDk7ETevefH1dHS28MOoNiT0UBWil1SN3Fuscqx2b0FkZAg+o
        qUgXCqA6lQWq74X7UyMTtEI=
X-Google-Smtp-Source: APXvYqxyqpyYZY8qY7B1CMLxmEvGtOzFCCg6NIwd49Af1HowMQkaHr7BFniHgWBtLUGq47Ht38tPyw==
X-Received: by 2002:a62:14c4:: with SMTP id 187mr43672529pfu.241.1564539683105;
        Tue, 30 Jul 2019 19:21:23 -0700 (PDT)
Received: from rashmica.ozlabs.ibm.com ([122.99.82.10])
        by smtp.googlemail.com with ESMTPSA id e11sm79504488pfm.35.2019.07.30.19.21.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 19:21:22 -0700 (PDT)
Message-ID: <7c49e493510ce04371d8d6cd6c436c347b1f8469.camel@gmail.com>
Subject: Re: [PATCH v2 0/5] Allocate memmap from hotadded memory
From:   Rashmica Gupta <rashmica.g@gmail.com>
To:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, pasha.tatashin@soleen.com,
        Jonathan.Cameron@huawei.com, anshuman.khandual@arm.com,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 31 Jul 2019 12:21:16 +1000
In-Reply-To: <b3fd1177-45ef-fd9e-78c8-d05138c647da@redhat.com>
References: <20190625075227.15193-1-osalvador@suse.de>
         <2ebfbd36-11bd-9576-e373-2964c458185b@redhat.com>
         <20190626080249.GA30863@linux>
         <2750c11a-524d-b248-060c-49e6b3eb8975@redhat.com>
         <20190626081516.GC30863@linux>
         <887b902e-063d-a857-d472-f6f69d954378@redhat.com>
         <9143f64391d11aa0f1988e78be9de7ff56e4b30b.camel@gmail.com>
         <0cd2c142-66ba-5b6d-bc9d-fe68c1c65c77@redhat.com>
         <b7de7d9d84e9dd47358a254d36f6a24dd48da963.camel@gmail.com>
         <b3fd1177-45ef-fd9e-78c8-d05138c647da@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-29 at 10:06 +0200, David Hildenbrand wrote:
> > > Of course, other interfaces might make sense.
> > > 
> > > You can then start using these memory blocks and hinder them from
> > > getting onlined (as a safety net) via memory notifiers.
> > > 
> > > That would at least avoid you having to call
> > > add_memory/remove_memory/offline_pages/device_online/modifying
> > > memblock
> > > states manually.
> > 
> > I see what you're saying and that definitely sounds safer.
> > 
> > We would still need to call remove_memory and add_memory from
> > memtrace
> > as
> > just offlining memory doesn't remove it from the linear page tables
> > (if 
> > it's still in the page tables then hardware can prefetch it and if
> > hardware tracing is using it then the box checkstops).
> 
> That prefetching part is interesting (and nasty as well). If we could
> at
> least get rid of the manual onlining/offlining, I would be able to
> sleep
> better at night ;) One step at a time.
> 

What are your thoughts on adding remove to state_store in
drivers/base/memory.c? And an accompanying add? So then userspace could
do "echo remove > memory34/state"? 

Then most of the memtrace code could be moved to a userspace tool. The
only bit that we would need to keep in the kernel is setting up debugfs
files in memtrace_init_debugfs.



