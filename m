Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A315FC74A59
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730B620872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="d2lENQ3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfGKP0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 11:26:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33868 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728933AbfGKPZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 11:25:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id p10so3116790pgn.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 08:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3ahhQ+9CCV1RUDKRM5TFZcgtNPOj1dansSCnwk/nmOg=;
        b=d2lENQ3wKspL1afPpwiMIMJTEtBu+3KRlviHBIV4/B5UC37H51zReuZ416QRoXpIe2
         o2wmkTIr2ailmX4MJoktDc/x2fNGBESK7lpnPf7caIWBEthnI9JViE9zFBOEMjvhf43m
         itDC80oThCy9XFYKTuVKPJxhfVAl1WIfVRYNc/DGVIIlIyfcbvY8GHGrD4lY885E/trN
         mb5C9EWN/v+uf6P74qonMeev0oC/D5Ql51Bi7zMZrRAMf3hOVm2RTc65AQrbrM2+uR3G
         FVzAh9j0UcKXid1HRp7x21ZT/XBEHmZbifIcBunTXtfAdXxqZgU0OdEi7CbGXIa3/UQr
         YdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3ahhQ+9CCV1RUDKRM5TFZcgtNPOj1dansSCnwk/nmOg=;
        b=N3U0FQaxuU3SCF8zF9xN90FVtBZAvRWuB11YAk8LdeSeiLDkIIOm5eyd+DIYfxQJlY
         ZSGtvf1d19dEz45rHofLXtxuGusUsSlT8yAXyi55Kuv42J+CaIiKMjw6gRKGGlg90ZAb
         UPzojjqxN7mVKSB49xS5mL3nZEA05TbbqS2bpqheSMV8wb8XKAzq6IhmFDAEKBDw/bg4
         ZFL17Wx+2D0TnDiFcVmGODuGD5ekm125mBDUgNqLrb76tnfdg9Xyz22+jwzROd6wkyHC
         /6zQbIcQ/fpOLBVCCp6xzFPVqlUuP31F3vcZzjVYJlf0AnFFPv3gEUHPZ9T+ThUDCw/j
         aL0w==
X-Gm-Message-State: APjAAAXTFlxL3FbES9cd5aQ5ohx/3XbLTZ5NO0HVp9c9mnzI0sgnIW3Y
        99rHso5gAG3xMJsKEcZWJZU=
X-Google-Smtp-Source: APXvYqzrq8ZKmOBHrm3NMUilV5X7y9HrlK8XVGKpg1nNByoohX3AvOSOI4JtUKlplVLiWjaFRr+p9Q==
X-Received: by 2002:a17:90a:d3d4:: with SMTP id d20mr5665939pjw.28.1562858757966;
        Thu, 11 Jul 2019 08:25:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:6fa9])
        by smtp.gmail.com with ESMTPSA id h129sm5716609pfb.110.2019.07.11.08.25.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 08:25:57 -0700 (PDT)
Date:   Thu, 11 Jul 2019 11:25:55 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 1/4] mm: introduce MADV_COLD
Message-ID: <20190711152555.GB20341@cmpxchg.org>
References: <20190711012528.176050-1-minchan@kernel.org>
 <20190711012528.176050-2-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711012528.176050-2-minchan@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 10:25:25AM +0900, Minchan Kim wrote:
> When a process expects no accesses to a certain memory range, it could
> give a hint to kernel that the pages can be reclaimed when memory pressure
> happens but data should be preserved for future use.  This could reduce
> workingset eviction so it ends up increasing performance.
> 
> This patch introduces the new MADV_COLD hint to madvise(2) syscall.
> MADV_COLD can be used by a process to mark a memory range as not expected
> to be used in the near future. The hint can help kernel in deciding which
> pages to evict early during memory pressure.
> 
> It works for every LRU pages like MADV_[DONTNEED|FREE]. IOW, It moves
> 
> 	active file page -> inactive file LRU
> 	active anon page -> inacdtive anon LRU
> 
> Unlike MADV_FREE, it doesn't move active anonymous pages to inactive
> file LRU's head because MADV_COLD is a little bit different symantic.
> MADV_FREE means it's okay to discard when the memory pressure because
> the content of the page is *garbage* so freeing such pages is almost zero
> overhead since we don't need to swap out and access afterward causes just
> minor fault. Thus, it would make sense to put those freeable pages in
> inactive file LRU to compete other used-once pages. It makes sense for
> implmentaion point of view, too because it's not swapbacked memory any
> longer until it would be re-dirtied. Even, it could give a bonus to make
> them be reclaimed on swapless system. However, MADV_COLD doesn't mean
> garbage so reclaiming them requires swap-out/in in the end so it's bigger
> cost. Since we have designed VM LRU aging based on cost-model, anonymous
> cold pages would be better to position inactive anon's LRU list, not file
> LRU. Furthermore, it would help to avoid unnecessary scanning if system
> doesn't have a swap device. Let's start simpler way without adding
> complexity at this moment. However, keep in mind, too that it's a caveat
> that workloads with a lot of pages cache are likely to ignore MADV_COLD
> on anonymous memory because we rarely age anonymous LRU lists.
> 
> * man-page material
> 
> MADV_COLD (since Linux x.x)
> 
> Pages in the specified regions will be treated as less-recently-accessed
> compared to pages in the system with similar access frequencies.
> In contrast to MADV_FREE, the contents of the region are preserved
> regardless of subsequent writes to pages.
> 
> MADV_COLD cannot be applied to locked pages, Huge TLB pages, or VM_PFNMAP
> pages.
> 
> * v2
>  * add up the warn with lots of page cache workload - mhocko
>  * add man page stuff - dave
> 
> * v1
>  * remove page_mapcount filter - hannes, mhocko
>  * remove idle page handling - joelaf
> 
> * RFCv2
>  * add more description - mhocko
> 
> * RFCv1
>  * renaming from MADV_COOL to MADV_COLD - hannes
> 
> * internal review
>  * use clear_page_youn in deactivate_page - joelaf
>  * Revise the description - surenb
>  * Renaming from MADV_WARM to MADV_COOL - surenb
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
