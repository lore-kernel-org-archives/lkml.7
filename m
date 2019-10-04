Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D877C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51F121D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iClBElnd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388272AbfJDSCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 14:02:25 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38555 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbfJDSCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 14:02:24 -0400
Received: by mail-pl1-f194.google.com with SMTP id w8so3477444plq.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 11:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Ql3anKlqLg5yve0WzNzTsdKXFFYYc4UNlV1/EYA3gp0=;
        b=iClBElndd2SzblF0cS82SmIvLJioWTl5+Vthgw3JYiwkTwrOOHYh6jXgQag+vW+HMA
         DNInR6Po+RGC7qI28kCUHIexnqXtjH1huvR0toNJn8wlxTm/Ty0leX+8frcQBjCdstOH
         BhPf9RVfes0+8Le3uSQ3XAkfW7ZmGV3tIcEulfqcr/mh4iD4jxVy99Ywtps2Iu721rgk
         crR5WAQ9GkKKr7Q+LY3njINIZxE0cf+md/+cOxMdXMnp+FK62hb9ydQnkhSZGfU4+BgR
         vrN7+1XUBSVIvkSqMaKxxca4osPLzG56dAuCnJAemuILmJsn4/nfOpM81M/VI9b+tXYd
         N4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Ql3anKlqLg5yve0WzNzTsdKXFFYYc4UNlV1/EYA3gp0=;
        b=RxvvTVAD3VQO76qUqBxTS/sP81GG9TjAfKHo+w6q5QlQoYOJ0I0+6yMKv1lu+lwFlH
         WB14/2SXANSzPExYCW8DC4pEysZoZP4wkV2LTNFLd28rM2EYNU1K/DwcPK00F5k0JgGF
         19lUOUA8WVY3J64ZBFYM5XnPTKpwg7jKxtzASgp+gZurnmM0n12MtlY6J6CzXkHHESg1
         CXxsRAQw8AYD1C6Wes5k3819JyKNfjQJYsd0Vv7LA8t/UaAekmOLLLYUq89ssQ2Fnhxj
         nO87B3J5Dw5+1GAU0KaqD1QOZAuRXy4MoJXWpqJ1UmcN7ABpxNp3pS+NXoT57gyBbaTS
         NMtQ==
X-Gm-Message-State: APjAAAVwB6dboi8qE/ZvLQ8J8tERhOYdmB+8RBPag2/vNcLYcZ+wUq9L
        rs3w9xdWovtFrQKumIwJp4wm7A==
X-Google-Smtp-Source: APXvYqyms40qiYxx6LN6MlOpABvRYxDlldwai0uQqG3a1IT31g+KvEPc+zhndCaPWohkAcVAxh0SEQ==
X-Received: by 2002:a17:902:b10d:: with SMTP id q13mr16693850plr.109.1570212143849;
        Fri, 04 Oct 2019 11:02:23 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id v5sm8531431pfv.76.2019.10.04.11.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 11:02:23 -0700 (PDT)
Date:   Fri, 4 Oct 2019 11:02:22 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [rfc] mm, hugetlb: allow hugepage allocations to excessively
 reclaim
In-Reply-To: <20191004092808.GC9578@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1910041058330.16371@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1910021556270.187014@chino.kir.corp.google.com> <d7752ddf-ccdc-9ff4-ab9f-529c2cd7f041@suse.cz> <alpine.DEB.2.21.1910031243050.88296@chino.kir.corp.google.com> <20191004092808.GC9578@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Oct 2019, Michal Hocko wrote:

> Requesting the userspace to drop _all_ page cache in order allocate a
> number of hugetlb pages or any other affected __GFP_RETRY_MAYFAIL
> requests is simply not reasonable IMHO.

It can be used as a fallback when writing to nr_hugepages and the amount 
allocated did not match expectation.  Again, I'll defer all of this to 
Mike when he returns: he expressed his preference, I suggested an 
alternative to consider, and he can make the decision to ack or nack this 
patch because he has a better understanding of that expectation from users 
who use hugetlb pages.
