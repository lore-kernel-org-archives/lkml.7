Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE37C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF7620881
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfENNdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 09:33:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55552 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfENNdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 09:33:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id x64so2890323wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 06:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d9EoIX4OtN63tuf6PqPnEv+P68EjjjVZjk7X2yNFHPw=;
        b=WHw6utQ1Ksb9eNJLcAXPGnNfOi2mN1CkRshQb1izkYSq48LhIz0A78ujFhS3cKeUEj
         EKk5Z9hePWhe2mgrG/qdWIU3/lAU+KJBE5u+bh/o9VbS8syr2TqMcEEwynnrfR+0X723
         OMEde0SiBFUiB4dkt5msum0rzly+dQul9K2PrS4uICJiad1+CLKBQryK8maP55Hy/uBX
         5gkLToOLNG8WI6rvb1atpt/Rj4et5wp7E8UZkyAQHKrBECmntvvldOEn7pLnLC36hVJM
         3Otm+yYOKnC1hFOxhRrvuw30qNrcRtx6aqFg54o4Lq2dLI8XdsIKvv43OtSAIYwIMk+r
         HPkQ==
X-Gm-Message-State: APjAAAUI8Koo4FosT+qUszJwM5g3zBD1V/2Us4gMMgJjNfyFu0qgz4jM
        YRREOeynNxHUTetRnTHBEjKds1IqHbcO3w==
X-Google-Smtp-Source: APXvYqyH4xbvnALaIskNjJjytlyDm4bpDsvIv/E9RvAZ/9pcOfLCie6sMSJ6eRwPJvRv8tXja/Wuaw==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr18961502wmq.96.1557840800371;
        Tue, 14 May 2019 06:33:20 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a6sm13803254wrp.49.2019.05.14.06.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 06:33:19 -0700 (PDT)
Date:   Tue, 14 May 2019 15:33:18 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH RFC 0/4] mm/ksm: add option to automerge VMAs
Message-ID: <20190514133318.6ajp3jn22jqowt4p@butterfly.localdomain>
References: <20190510072125.18059-1-oleksandr@redhat.com>
 <36a71f93-5a32-b154-b01d-2a420bca2679@virtuozzo.com>
 <20190513113314.lddxv4kv5ajjldae@butterfly.localdomain>
 <a3870e32-3a27-e6df-fcb2-79080cdd167a@virtuozzo.com>
 <20190514063043.ojhsb6d3ohxx4wur@butterfly.localdomain>
 <8f146863-5963-81b2-ed20-6428d1da353c@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f146863-5963-81b2-ed20-6428d1da353c@virtuozzo.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, May 14, 2019 at 12:12:16PM +0300, Kirill Tkhai wrote:
> > Immediate question: what should be actually done on this? I see 2
> > options:
> > 
> > 1) mark all VMAs as mergeable + set some flag for mmap() to mark all
> > further allocations as mergeable as well;
> > 2) just mark all the VMAs as mergeable; userspace can call this
> > periodically to mark new VMAs.
> > 
> > My prediction is that 2) is less destructive, and the decision is
> > preserved predominantly to userspace, thus it would be a desired option.
> 
> Let's see, how we use KSM now. It's good for virtual machines: people
> install the same distribution in several VMs, and they have the same
> packages and the same files. When you read a file inside VM, its pages
> are file cache for the VM, but they are anonymous pages for host kernel.
> 
> Hypervisor marks VM memory as mergeable, and host KSM merges the same
> anonymous pages together. Many of file cache inside VM is constant
> content, so we have good KSM compression on such the file pages.
> The result we have is explainable and expected.

Yup, correct.

> But we don't know anything about pages, you have merged on your laptop.
> We can't make any assumptions before analysis of applications, which
> produce such the pages. Let's check what happens before we try to implement
> some specific design (if we really need something to implement).
> 
> The rest is just technical details. We may implement everything we need
> on top of this (even implement a polling of /proc/[pid]/maps and write
> a task and address of vma to force_madvise or similar file).

I'm not sure that reviewing all the applications falls under the scope
of this and/or similar submission. Personally I do not feel comfortable
reviewing Firefox code, for example.

But I do run 2 instances of FF, one for work stuff, one for personal stuff,
so merging its memory would be definitely beneficial for me. I believe I'm
not the only one doing this, and things are not limited to Firefox only, of
course.

Please consider checking a v2 submission I've just posted. It implements
your suggestion on "force_madvise" knob, and I find your feedback very
relevant and useful.

Thanks.

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer
