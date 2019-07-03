Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590FEC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3356621881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VGm4cgty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfGCRox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:44:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45034 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfGCRow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:44:52 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so1588485pgl.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 10:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=E+nIXNVtybGCJQ9qhR+v7ySrKVmdYkqu+JpBB3XRK44=;
        b=VGm4cgtyuTX82jA5Q7OkqzviUC7ZS3E1fwHKamsDm+UAbbNRF67b8ZYcwOoKfx6UvT
         yD5jrQPVE8fBsT1+7vjAyGEBXYa708NL3AAHTpXQubo0l2bhrBSZ871MN0nZ/AJiwdd8
         xrfc7Y7NXHqF0sXfiwb+/eqvImMniB0H6K3E6+fFwnJ7JwlfEe20OqqGToK5uwTXqNq/
         4pye2K9cVhUqpj6h3YTAUMB9h4p5cICiXBCmdrbIp416i+hvmLHO+Baviv4uDez5FViF
         v9o1XoL+AFUzvC8K+LVa3P09MOhAkKLAup6cLLiTT5fr0x9vDqitwp12MaBNuyZM4TFU
         CSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=E+nIXNVtybGCJQ9qhR+v7ySrKVmdYkqu+JpBB3XRK44=;
        b=PJS2NPICb9o2xP2wc1QUTvtsnTF9VO81BXi7lFOa567Y9KK1VbsJTsDcJqIJzdkd4z
         duyjoKcUru1kA8VNW2ve9BUzucBQhXrUkYf/CuM9J1twUZA3wnBTCtYl/hclJSTU6ScF
         6CscusTwlEwO5W5hF6shEN+cHRzI7YU5AYexEp0af0YbqzuTouhbd62GEx9Cl28Rvi5K
         2vs+DMB4Gu3dJRU3T7IIkrhR8ncWlfvoy+MBo7gkb2Qy9hNsolg+AJJ1zJ/QngCrQ2UQ
         L9Bn+dDNCVWS4Rtv8SMmsd/wzYCrTrWEHlCQbmHzZRO0lywWE7bRGNXyiF3Q5n0EuhRD
         KmVA==
X-Gm-Message-State: APjAAAXTEzkhUIzkmWAZjzdnpE0jU0CgKUZnT2aJtgR1z0wUdydnrBtB
        c3gPWWgIhoLf7UIrF5tpc3LpxQ==
X-Google-Smtp-Source: APXvYqwArpI7P6wKPUVysPVfB3+fPhZXcp1OWM5P/heFWlYBdzn2JqcYRDrKS9rawXIy3vL2I9zG4Q==
X-Received: by 2002:a63:6286:: with SMTP id w128mr29708938pgb.12.1562175891115;
        Wed, 03 Jul 2019 10:44:51 -0700 (PDT)
Received: from [100.112.64.100] ([104.133.8.100])
        by smtp.gmail.com with ESMTPSA id y68sm3021050pfy.164.2019.07.03.10.44.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Jul 2019 10:44:50 -0700 (PDT)
Date:   Wed, 3 Jul 2019 10:44:30 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Oleg Nesterov <oleg@redhat.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Hugh Dickins <hughd@google.com>,
        Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>,
        hch@lst.de, gkohli@codeaurora.org, mingo@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix a crash in do_task_dead()
In-Reply-To: <20190703173546.GB21672@redhat.com>
Message-ID: <alpine.LSU.2.11.1907031039180.1132@eggly.anvils>
References: <1559161526-618-1-git-send-email-cai@lca.pw> <20190530080358.GG2623@hirez.programming.kicks-ass.net> <82e88482-1b53-9423-baad-484312957e48@kernel.dk> <20190603123705.GB3419@hirez.programming.kicks-ass.net> <ddf9ee34-cd97-a62b-6e91-6b4511586339@kernel.dk>
 <alpine.LSU.2.11.1906301542410.1105@eggly.anvils> <97d2f5cc-fe98-f28e-86ce-6fbdeb8b67bd@kernel.dk> <20190702150615.1dfbbc2345c1c8f4d2a235c0@linux-foundation.org> <20190703173546.GB21672@redhat.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2019, Oleg Nesterov wrote:
> On 07/02, Andrew Morton wrote:
> > On Mon, 1 Jul 2019 08:22:32 -0600 Jens Axboe <axboe@kernel.dk> wrote:
> > 
> > > Andrew, can you queue Oleg's patch for 5.2? You can also add my:
> > > 
> > > Reviewed-by: Jens Axboe <axboe@kernel.dk>
> > 
> > Sure.  Although things are a bit of a mess.  Oleg, can we please have a
> > clean resend with signoffs and acks, etc?
> 
> OK, will do tomorrow. This cleanup can be improved, we can avoid get/put_task_struct
> altogether, but need to recheck.

Thank you, Oleg. But, with respect, I'd caution against making it cleverer
at the last minute: what you posted already is understandable, works, has
Jen's Reviewed-by and my Acked-by: it just lacks a description and signoff.

Hugh
