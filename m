Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FA2C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2E52166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565339540;
	bh=VhHWr98ioYMV+zk7RcYtkMcWJVNdHu4NCx2fXJ3129M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GO6Gwb06Ga4gcF0x/PaYsAA2COrP+KtbVEad4Wf+kwe6q0+d0+DS8DT79LUZxI+Qk
	 KtKWDhU6hIJCMhEGft6mHYVjtvAZwOo5NaiVggJo9QDVA7Mq66OQlUnP6M9LS8goA8
	 4q13N8ySqeG6oYMLMjGJsDuYxFDfeBq/fG7WYo04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405821AbfHIIcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 04:32:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:37384 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726059AbfHIIcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 04:32:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8E435AF3F;
        Fri,  9 Aug 2019 08:32:17 +0000 (UTC)
Date:   Fri, 9 Aug 2019 10:32:16 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     kirill.shutemov@linux.intel.com, hannes@cmpxchg.org,
        vbabka@suse.cz, rientjes@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 1/2 -mm] mm: account lazy free pages separately
Message-ID: <20190809083216.GM18351@dhcp22.suse.cz>
References: <1565308665-24747-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565308665-24747-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09-08-19 07:57:44, Yang Shi wrote:
> When doing partial unmap to THP, the pages in the affected range would
> be considered to be reclaimable when memory pressure comes in.  And,
> such pages would be put on deferred split queue and get minus from the
> memory statistics (i.e. /proc/meminfo).
> 
> For example, when doing THP split test, /proc/meminfo would show:
> 
> Before put on lazy free list:
> MemTotal:       45288336 kB
> MemFree:        43281376 kB
> MemAvailable:   43254048 kB
> ...
> Active(anon):    1096296 kB
> Inactive(anon):     8372 kB
> ...
> AnonPages:       1096264 kB
> ...
> AnonHugePages:   1056768 kB
> 
> After put on lazy free list:
> MemTotal:       45288336 kB
> MemFree:        43282612 kB
> MemAvailable:   43255284 kB
> ...
> Active(anon):    1094228 kB
> Inactive(anon):     8372 kB
> ...
> AnonPages:         49668 kB
> ...
> AnonHugePages:     10240 kB
> 
> The THPs confusingly look disappeared although they are still on LRU if
> you are not familair the tricks done by kernel.

Is this a fallout of the recent deferred freeing work?

> Accounted the lazy free pages to NR_LAZYFREE, and show them in meminfo
> and other places.  With the change the /proc/meminfo would look like:
> Before put on lazy free list:

The name is really confusing because I have thought of MADV_FREE immediately.

> +LazyFreePages: Cleanly freeable pages under memory pressure (i.e. deferred
> +               split THP).

What does that mean actually? I have hard time imagine what cleanly
freeable pages mean.
-- 
Michal Hocko
SUSE Labs
