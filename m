Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C53C04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1313321019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfEUHGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 03:06:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38571 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfEUHGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:06:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id t5so1636763wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 00:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BCDVtsCA4fRRI80jdr090j+ebnC+z4xJdQUu/i1zpls=;
        b=pM9f3FTgZV5CGqT/7fEU6y0zdIo9eIZP7HzB5lLBMXKShndamcyVRnPd86dQbzGZ2G
         o6EbeNddlOzAKlXygIf3C37DAxaX5ZU4iC3Cz8B0BeyoR//RDcoFT5NropC8v8nK/69t
         OFGyuGBXHugzH6VFhV98uDguucbnHDA3cWMpAZEXIwHq9Qj/qbgnLVT/cCn7Y8uPbRBj
         6tUk8A+XZqQDhvpsKUGd0yYeUNk95p/O85Ojs59TxAQT89S63yEs4j14vDyYK2q+BJlS
         cerOX42pSnYaNBaz0crf1V9n7iT8Hef6TQhEoPQQuUa22j54UmZ47EvoH1FWwce+ZqGB
         DJ+w==
X-Gm-Message-State: APjAAAUk47FHRhnEtaARoWDJPra4ms4uBJ7N0DpC3/KdiBJO6FsleK6Q
        c4J3I45mR95zn80OLr4auVD+rg==
X-Google-Smtp-Source: APXvYqy+62EkTHounYwTTGspsUVLyMrAch/IR6B+AY9ezOb09mJ+jQU7lo14UYsu/j4pyAlmgZ1Q2g==
X-Received: by 2002:a05:600c:21c1:: with SMTP id x1mr2134691wmj.5.1558422400441;
        Tue, 21 May 2019 00:06:40 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z74sm2922006wmc.2.2019.05.21.00.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 00:06:39 -0700 (PDT)
Date:   Tue, 21 May 2019 09:06:38 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
Subject: Re: [RFC 4/7] mm: factor out madvise's core functionality
Message-ID: <20190521070638.yhn3w4lpohwcqbl3@butterfly.localdomain>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-5-minchan@kernel.org>
 <20190520142633.x5d27gk454qruc4o@butterfly.localdomain>
 <20190521012649.GE10039@google.com>
 <20190521063628.x2npirvs75jxjilx@butterfly.localdomain>
 <20190521065000.GH32329@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521065000.GH32329@dhcp22.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, May 21, 2019 at 08:50:00AM +0200, Michal Hocko wrote:
> On Tue 21-05-19 08:36:28, Oleksandr Natalenko wrote:
> [...]
> > Regarding restricting the hints, I'm definitely interested in having
> > remote MADV_MERGEABLE/MADV_UNMERGEABLE. But, OTOH, doing it via remote
> > madvise() introduces another issue with traversing remote VMAs reliably.
> > IIUC, one can do this via userspace by parsing [s]maps file only, which
> > is not very consistent, and once some range is parsed, and then it is
> > immediately gone, a wrong hint will be sent.
> > 
> > Isn't this a problem we should worry about?
> 
> See http://lkml.kernel.org/r/20190520091829.GY6836@dhcp22.suse.cz

Oh, thanks for the pointer.

Indeed, for my specific task with remote KSM I'd go with map_files
instead. This doesn't solve the task completely in case of traversal
through all the VMAs in one pass, but makes it easier comparing to a
remote syscall.

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer
