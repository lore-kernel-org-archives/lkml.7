Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BCDC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 20:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7362071E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 20:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DhZc/CD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfKYUjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 15:39:02 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46463 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKYUjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 15:39:02 -0500
Received: by mail-pg1-f193.google.com with SMTP id r18so7730790pgu.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 12:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=4jww085fwhsjcasHAHalHX5IMzf67Lk78+xW5E+3pZg=;
        b=DhZc/CD+8Iw+9W8tdABmjMYG+cx0Pl5u5O6zYs1I9FDQsi6hpNgKwyTe5j3v1DAOC+
         MzX5vD7D0wK5EHSbSW54vsDmkQmaW0Nv4EpBpd1f7uvYkTOPg4S5X0ihktt6qPM6dFCb
         KJ3ASXe80VM0sMde7xOEFPjGRJ/mfjqbI4Dw2qrgLyaocXxezHsaONRuSaa+e9PSGnhX
         c0KZxRkCifiJtjfaFGg2RpJoFJf2bHV1b7pQNP/AP1kZV8uwu0x3cYWrpIlxqdbcSG+G
         j0ZycUzNVq+dw/K+Jj7cdmf2jkmXLEPkgPZbCg0q5EDc1/GDI8BAvzPp8Ty5ffsVtXRr
         ksSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=4jww085fwhsjcasHAHalHX5IMzf67Lk78+xW5E+3pZg=;
        b=aQmDgBtryB9NW5l27yQ0IDfIpSEQjME3VSCANTawt9qNLDudh+X+XHp2TXbq8K16bi
         74agy1fIaQQNwbNRPwXg9bfWBZjaVou2v/MpK6H43smWzR0eysJ9shpbdQeiOR87XNTr
         Mm0RnjPvJNwRYyGcm7X8gk1h//Bg5lPJfQquJ+/qfsBYby/tBGL577mRTieiaUlp+HFx
         dpYbjscit61wxkUNa7te6GJcWgnBFwb+BOChRTD57VyfbMQSmH2/Yr6kBky1O3hiwJ6G
         aeWtT0mPn5kLpL0Q6O10F2+MY2+mxGf1fUABVJvjrjwl3SQXJJI3Q2Y+GiJuKcAytGf5
         hOKQ==
X-Gm-Message-State: APjAAAXlMeRDZMeYbpUv8bodt8Wc9eKjd2jZa8l7+3YeLXR86qEi5UEp
        Hxr6vJr9qpikfLzerdERsloprw==
X-Google-Smtp-Source: APXvYqw9gTa3iCNUSrr2tIaCf8dn/2ovDkf3aL/g9j1xutJ2hnD8bxey51ilKv+a/D4xFQvn+2VZ1Q==
X-Received: by 2002:a62:1d90:: with SMTP id d138mr37413555pfd.223.1574714341636;
        Mon, 25 Nov 2019 12:39:01 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id g192sm9463027pgc.3.2019.11.25.12.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 12:38:59 -0800 (PST)
Date:   Mon, 25 Nov 2019 12:38:59 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [patch for-5.3 0/4] revert immediate fallback to remote
 hugepages
In-Reply-To: <20191125114708.GI31714@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1911251233020.245192@chino.kir.corp.google.com>
References: <08a3f4dd-c3ce-0009-86c5-9ee51aba8557@suse.cz> <20191029151549.GO31513@dhcp22.suse.cz> <20191029143351.95f781f09a9fbf254163d728@linux-foundation.org> <alpine.DEB.2.21.1910291623050.9914@chino.kir.corp.google.com> <20191105130253.GO22672@dhcp22.suse.cz>
 <alpine.DEB.2.21.1911051659010.181254@chino.kir.corp.google.com> <20191106073521.GC8314@dhcp22.suse.cz> <alpine.DEB.2.21.1911061330030.155572@chino.kir.corp.google.com> <20191113112042.GG28938@suse.de> <alpine.DEB.2.21.1911241548340.192260@chino.kir.corp.google.com>
 <20191125114708.GI31714@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2019, Michal Hocko wrote:

> > So my question would be: if we know the previous behavior that allowed 
> > excessive swap and recalling into compaction was deemed harmful for the 
> > local node, why do we now believe it cannot be harmful if done for all 
> > system memory?
> 
> I have to say that I got lost in your explanation. I have already
> pointed this out in a previous email you didn't reply to. But the main
> difference to previous __GFP_THISNODE behavior is that it is used along
> with __GFP_NORETRY and that reduces the overall effort of the reclaim
> AFAIU. If that is not the case then please be _explicit_ why.
> 

I'm referring to the second allocation in alloc_pages_vma() after the 
patch:

 			/*
 			 * If hugepage allocations are configured to always
 			 * synchronous compact or the vma has been madvised
 			 * to prefer hugepage backing, retry allowing remote
-			 * memory as well.
+			 * memory with both reclaim and compact as well.
 			 */
 			if (!page && (gfp & __GFP_DIRECT_RECLAIM))
 				page = __alloc_pages_node(hpage_node,
- 						gfp | __GFP_NORETRY, order);
+							gfp, order);

So we now do not have __GFP_NORETRY nor __GFP_THISNODE so this bypasses 
all the precautionary logic in the page allocator that avoids excessive 
swap: it is free to continue looping, swapping, and thrashing, trying to 
allocate hugepages if all memory is fragmented.

Qemu uses MADV_HUGEPAGE so this allocation *will* be attempted for 
Andrea's workload.  The swap storms were reported for the same allocation 
but with __GFP_THISNODE so it only occurred for local fragmentation and 
low-on-memory conditions for the local node in the past.  This is now 
opened up for all nodes.

So the question is: what prevents the exact same issue from happening 
again for Andrea's usecase if all memory on the system is fragmented?  I'm 
assuming that if this were tested under such conditions that the swap 
storms would be much worse.
