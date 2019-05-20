Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEC9C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25AF2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="UsDmFQ7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389805AbfETQqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 12:46:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44100 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388796AbfETQqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 12:46:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id g9so7484055pfo.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 09:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AhvyYHsik8s1aZ1UVXcXGfBu8d3R9Dfu1UdhHMa3ucQ=;
        b=UsDmFQ7yRbOepyPR7AjsW03NVtO+g8LFYwT6yxz7nEb0fYQOAlBdknmQRffXAKJDn+
         qV0ymJDcpra7H0FQSx0LU3Oa5wQEQ13MOb15Uo06QKp1xgsj59VeiUeVv31nzJt6QHcy
         VctpAADvyCkdJG6b767kqERvNpCn2FFbJfIDtNbGvfm6CcdbUj+p8s10vaRAgUdNlcJ2
         EKC7JALHTUVt8/gOfKpLrmr+kn0XS1uI5z94u40MOK/cb3vHvpjS6MtPWkD96noFPlR9
         6uRMThqfDY/3g9WBdejaM87bPQdgmSG66QVHIUiV1dj/HUV+mlXXWXMe/whZAxWbmsJb
         +otQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AhvyYHsik8s1aZ1UVXcXGfBu8d3R9Dfu1UdhHMa3ucQ=;
        b=cqdifnU+430bCNmwiHa1pKv4tRUZkJLxcUa2J7PNd1kA4zssm6ti006QBP9vP1eXtM
         op8CwEFbUrp1eW4o2/jT+3VKVab1yPUMfiqMDYhw61PGnkIdOM3pfVjz0tf9Wuhpubpu
         xiMDxppUSHDXlBnDgm+J2K4yagJK+bAsxlSjrhANKRwVOPqFYQLizRcFU1IdxSba5cV4
         0qpPSoYsYiPQ0C2li7NvYZ3U21YLwv5tVpLRcog5ziSA+NAkkC+XZFWd4cwXUOJBZQop
         ViGt9QFxTk58SfBnqKYBpqXUi7xKy2VIUHRqo5K7LHLLLIkGKdekFEVJI93PQI06kvP5
         muhg==
X-Gm-Message-State: APjAAAXzLOQZ7A6jVsUY80/VsteCj26Z1cbMNXkqp90zfNC98HEOYmMN
        HPxxY/wTpUv8Mhk/pRP61Z7k4g==
X-Google-Smtp-Source: APXvYqxlq0UlxgIX7doeBMTtmPdq658NEoNcyut9RersVG40Z/X4qMzdBoFTKWS1679tGeWZaJICIA==
X-Received: by 2002:a65:638a:: with SMTP id h10mr7938216pgv.64.1558370767966;
        Mon, 20 May 2019 09:46:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:df5f])
        by smtp.gmail.com with ESMTPSA id u20sm21814466pfm.145.2019.05.20.09.46.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 09:46:06 -0700 (PDT)
Date:   Mon, 20 May 2019 12:46:05 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
Subject: Re: [RFC 0/7] introduce memory hinting API for external process
Message-ID: <20190520164605.GA11665@cmpxchg.org>
References: <20190520035254.57579-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520035254.57579-1-minchan@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 12:52:47PM +0900, Minchan Kim wrote:
> - Approach
> 
> The approach we chose was to use a new interface to allow userspace to
> proactively reclaim entire processes by leveraging platform information.
> This allowed us to bypass the inaccuracy of the kernel’s LRUs for pages
> that are known to be cold from userspace and to avoid races with lmkd
> by reclaiming apps as soon as they entered the cached state. Additionally,
> it could provide many chances for platform to use much information to
> optimize memory efficiency.
> 
> IMHO we should spell it out that this patchset complements MADV_WONTNEED
> and MADV_FREE by adding non-destructive ways to gain some free memory
> space. MADV_COLD is similar to MADV_WONTNEED in a way that it hints the
> kernel that memory region is not currently needed and should be reclaimed
> immediately; MADV_COOL is similar to MADV_FREE in a way that it hints the
> kernel that memory region is not currently needed and should be reclaimed
> when memory pressure rises.

I agree with this approach and the semantics. But these names are very
vague and extremely easy to confuse since they're so similar.

MADV_COLD could be a good name, but for deactivating pages, not
reclaiming them - marking memory "cold" on the LRU for later reclaim.

For the immediate reclaim one, I think there is a better option too:
In virtual memory speak, putting a page into secondary storage (or
ensuring it's already there), and then freeing its in-memory copy, is
called "paging out". And that's what this flag is supposed to do. So
how about MADV_PAGEOUT?

With that, we'd have:

MADV_FREE: Mark data invalid, free memory when needed
MADV_DONTNEED: Mark data invalid, free memory immediately

MADV_COLD: Data is not used for a while, free memory when needed
MADV_PAGEOUT: Data is not used for a while, free memory immediately

What do you think?
