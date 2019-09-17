Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB60C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0B32054F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o90CdJ6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfIQU0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 16:26:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37444 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfIQU0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 16:26:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id c17so2599714pgg.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 13:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=3hrsqxgYoLZLVUn9UcvGaDBzQEYsVePntZ0NXkBb8d8=;
        b=o90CdJ6jULBoiMWu9aZxAJzFtYkecrPhyq2BBYGDGbsS7hue6MLYv4Sqo71W48kE/W
         hVIA63xDI9v8s2HFpYk8ralgVlEOvTjOPpvdJNZ1GYcfkdq6Th5pGE4YYTC/yI2ArebY
         paARUW7i9iG3YJrfoaEBv+sjJ6oPu7ibs5+iM7gaYLxA7VJmFWz1NkZgQdzdd6GOI7Nf
         kImNv4HkB5QdYulW7IkA/a2PVuAy0ACovaYzvOsNmJmhaQ9NVFR+m6+XqV9PymeHCQL0
         2fcBSypr3wp7PPD1Dl9mm2Gdu8t+fTKxLK34ffpaFMrHM8wbz8W42VLD9m21APMoN+By
         u2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=3hrsqxgYoLZLVUn9UcvGaDBzQEYsVePntZ0NXkBb8d8=;
        b=g3f8pnrAFsLSURLIbUmNDDNJwa1VfR09lPehxPuspZ1xhIpstJ5g6WwBZZxUbqpDua
         ZHDcuZuEGNEQ7akJAH1Z5gU2q/5EGoFVZmFlYyn6j3pC7aDIGjpMt6UQdq678dD/8r3s
         aPaMEEZGbqpK5D3hbiG0PypYtPzwdng4lxWlW5U3FaJCdCrupBAyoIOK53Ip8uCE+st6
         P1nmCgWsZfwXKebzGe9cguzAgmZBJ+z3uqH9++yqhIwFm8RZSrQPUXwxrpc7ZuOSGRnb
         GLnp/bhuh4crj0XBBhOiUEZrU4dGwojxkmuVjYiejtX8+nC9qZJiGfn9WJ0u4wODqtID
         o3RQ==
X-Gm-Message-State: APjAAAXGAjCKXbccCXyiyZIwfTxOENUuEtGZBzhMlPSG3Hgksv8CzCQr
        CuEYvRwF1NLzAKEdH54GOpZwmg==
X-Google-Smtp-Source: APXvYqxU2ChEEZ8iNk1LY0wjMAK1n2GRQIlW/Nm5fDFFAhtfMp0dk+X9eqhTIgDmlQe2i8o+OJdC0w==
X-Received: by 2002:a63:cd04:: with SMTP id i4mr643565pgg.21.1568752013795;
        Tue, 17 Sep 2019 13:26:53 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id t8sm3049095pjq.30.2019.09.17.13.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 13:26:53 -0700 (PDT)
Date:   Tue, 17 Sep 2019 13:26:52 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     John Hubbard <jhubbard@nvidia.com>
cc:     Nitin Gupta <nigupta@nvidia.com>, akpm@linux-foundation.org,
        vbabka@suse.cz, mgorman@techsingularity.net, mhocko@suse.com,
        dan.j.williams@intel.com, Yu Zhao <yuzhao@google.com>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Roman Gushchin <guro@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Arun KS <arunks@codeaurora.org>,
        Janne Huttunen <janne.huttunen@nokia.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] mm: Proactive compaction
In-Reply-To: <f4a74669-b86b-741a-1c2b-c117878734c6@nvidia.com>
Message-ID: <alpine.DEB.2.21.1909171318070.161860@chino.kir.corp.google.com>
References: <20190816214413.15006-1-nigupta@nvidia.com> <alpine.DEB.2.21.1909161312050.118156@chino.kir.corp.google.com> <f4a74669-b86b-741a-1c2b-c117878734c6@nvidia.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2019, John Hubbard wrote:

> > We've had good success with periodically compacting memory on a regular 
> > cadence on systems with hugepages enabled.  The cadence itself is defined 
> > by the admin but it causes khugepaged[*] to periodically wakeup and invoke 
> > compaction in an attempt to keep zones as defragmented as possible 
> 
> That's an important data point, thanks for reporting it. 
> 
> And given that we have at least one data point validating it, I think we
> should feel fairly comfortable with this approach. Because the sys admin 
> probably knows  when are the best times to steal cpu cycles and recover 
> some huge pages. Unlike the kernel, the sys admin can actually see the 
> future sometimes, because he/she may know what is going to be run.
> 
> It's still sounding like we can expect excellent results from simply 
> defragmenting from user space, via a chron job and/or before running
> important tests, rather than trying to have the kernel guess whether 
> it's a performance win to defragment at some particular time.
> 
> Are you using existing interfaces, or did you need to add something? How
> exactly are you triggering compaction?
> 

It's possible to do this through a cron job but there are a fre reasons 
that we preferred to do it through khugepaged:

 - we use a lighter variation of compaction, MIGRATE_SYNC_LIGHT, than what 
   the per-node trigger provides since compact_node() forces MIGRATE_SYNC
   and can stall for minutes and become disruptive under some
   circumstances,

 - we do not ignore the pageblock skip hint which compact_node() hardcodes 
   to ignore, and 

 - we didn't want to do this in process context so that the cpu time is
   not taxed to any user cgroup since it's on behalf of the system as a
   whole.

It seems much better to do this on a per-node basis rather than through 
the sysctl to do it for the whole system to partition the work.  Extending 
the per-node interface to do MIGRATE_SYNC_LIGHT and not ignore pageblock 
skip is possible but the work done would still be done in process context 
so if done from userspace this would need to be attached to a cgroup that 
does not tax that cgroup for usage done on behalf of the entire system.

Again, we're using khugepaged and allowing the period to be defined 
through /sys/kernel/mm/transparent_hugepage/khugepaged but that is because 
we only want to do this on systems where we want to dynamically allocate 
hugepages on a regular basis.
