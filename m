Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D8CC76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61CF227B9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="n21hbjdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390478AbfGWOZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 10:25:50 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33983 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbfGWOZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 10:25:50 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so20702131plt.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 07:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wJZ801ANBKnPIKQYwYJaIw5FVuF7oY1lEYc4x9KCGg8=;
        b=n21hbjdIvqGA7so7xre9KxtX9A25carBopCDVVwJ0cju9rZ3C2askKWnyx4AV63WUb
         GQqOeqF99/UITIYGwZ1M4TCxAN1tds/splo04dXVQcH4Vk3/O+CDH9c5jALBwmi129aX
         nexyLOhLqykV1k4gcufHhkE98OYvN4BYMRZ+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wJZ801ANBKnPIKQYwYJaIw5FVuF7oY1lEYc4x9KCGg8=;
        b=ArsZgvAhFPgXoK8KBcPt8T2J3pau4/sP7mszYwkgzjEYHe3zzczdd1TtF5oYZftsUp
         W2BD/YVZrhYsbnSQZU5oSbdaskRspqoRXw8WLg0MzlA3PGWW5s+ln5/xr4P/m8P4Xi0W
         a7xA9grLBo/Yf/LJaDFhk0HOjnfQTUukpXb0G2rqG5jFZzIeHqBT4LfVjhjhnruwsTgx
         32+yij1tIz+tLgJByxvgSJV3JJQDawpljsK4s62u9krUrnwm/3brpYaTwMTOr6gtcjtv
         NtgotC2/EzpEiVpfVA1OZatRujhGWSZTuGsFRqtsP3pOhAahTkgtcMYFe3I6q+ECihQS
         HP1A==
X-Gm-Message-State: APjAAAXLCZW0pFPcjQYfXchAZJDcsH6M3PQEp4oe372vkDaYjzgeuqe5
        yt4uBhdr1W6Xvit5/G6DPYI=
X-Google-Smtp-Source: APXvYqzTB9qvvsmDg4Qv92Ie0WxPkNg5+9vi47JkPUPkzdmySjr1W+rQOyNBacsorNKTD8yGc5TgoQ==
X-Received: by 2002:a17:902:8203:: with SMTP id x3mr81493411pln.304.1563891949369;
        Tue, 23 Jul 2019 07:25:49 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id p27sm64054292pfq.136.2019.07.23.07.25.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 07:25:48 -0700 (PDT)
Date:   Tue, 23 Jul 2019 10:25:47 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RFC] mm/page_idle: simple idle page tracking for virtual
 memory
Message-ID: <20190723142547.GD104199@google.com>
References: <156388286599.2859.5353604441686895041.stgit@buzz>
 <20190723134647.GA104199@google.com>
 <53719394-2679-81ae-686e-c138522c0dfc@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53719394-2679-81ae-686e-c138522c0dfc@yandex-team.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 04:59:07PM +0300, Konstantin Khlebnikov wrote:
> 
> 
> On 23.07.2019 16:46, Joel Fernandes wrote:
> > On Tue, Jul 23, 2019 at 02:54:26PM +0300, Konstantin Khlebnikov wrote:
> > > The page_idle tracking feature currently requires looking up the pagemap
> > > for a process followed by interacting with /sys/kernel/mm/page_idle.
> > > This is quite cumbersome and can be error-prone too. If between
> > > accessing the per-PID pagemap and the global page_idle bitmap, if
> > > something changes with the page then the information is not accurate.
> > > More over looking up PFN from pagemap in Android devices is not
> > > supported by unprivileged process and requires SYS_ADMIN and gives 0 for
> > > the PFN.
> > > 
> > > This patch adds simplified interface which works only with mapped pages:
> > > Run: "echo 6 > /proc/pid/clear_refs" to mark all mapped pages as idle.
> > > Pages that still idle are marked with bit 57 in /proc/pid/pagemap.
> > > Total size of idle pages is shown in /proc/pid/smaps (_rollup).
> > > 
> > > Piece of comment is stolen from Joel Fernandes <joel@joelfernandes.org>
> > 
> > This will not work well for the problem at hand, the heap profiler
> > (heapprofd) only wants to clear the idle flag for the heap memory area which
> > is what it is profiling. There is no reason to do it for all mapped pages.
> > Using the /proc/pid/page_idle in my patch, it can be done selectively for
> > particular memory areas.
> > 
> > I had previously thought of having an interface that accepts an address
> > range to set the idle flag, however that is also more complexity.
> 
> Profiler could look into particular area in /proc/pid/smaps
> or count idle pages via /proc/pid/pagemap.
> 
> Selective /proc/pid/clear_refs is not so hard to add.
> Somthing like echo "6 561214d03000-561214d29000" > /proc/pid/clear_refs
> might be useful for all other operations.

This seems really odd of an interface. Also I don't see how you can avoid
looking up reverse maps to determine if a page is really idle.

What is also more odd is that traditionally clear_refs does interfere with
reclaim due to clearing of accessed bit. Now you have one of the interfaces
with clear_refs that does not interfere with reclaim. That is makes it very
inconsistent. Also in this patch you have 2 interfaces to solve this, where
as my patch added a single clean interface that is easy to use and does not
need parsing of address ranges.

All in all, I don't see much the point of this honestly. But thanks for
poking at it.

thanks,

 - Joel

