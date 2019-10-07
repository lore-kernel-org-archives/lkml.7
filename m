Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F93BECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0136A206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="CYId0mdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfJGMeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:34:15 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46508 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfJGMeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:34:15 -0400
Received: by mail-qk1-f194.google.com with SMTP id 201so12307360qkd.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 05:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aX38mKathL6hGZ5wfaJ4tWyTc6Mqm9Kf3jmqSU2okVY=;
        b=CYId0mddJCKrzR+XxA8vZFoMDfRmBJN4cg6/EGWNPs1i+kPhJ/sX9AzAmx3RLkeXzB
         8YcNqrXJS8EkuxWD+8NwJfLHk7DoxzE6+l3omsx7SkSouFC8IPFuhuEjC9xxPjWYAsAt
         mo7W+yyA9a/kzO6m3VSFgP1Z2lPwPhhGohSfyc1SOVlgd0HrWUJLp2ANkUgrYEOty3JM
         T0E5FJG5/dt6rlidSPEWKwgYcbYlF6ldGlqEfKHq0V5zR1stftyQT25Pkzmt/PSwGqt/
         iNUZ+ngQ8MBGrO9ttUTELD7J5VxNRu9jBeuAP9YrCvUNpmTvmVrmt5TfVurPLTuEIrDE
         WUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aX38mKathL6hGZ5wfaJ4tWyTc6Mqm9Kf3jmqSU2okVY=;
        b=p2B0Sd1lK2JFa/6lQ6EIbIKsVO1dovcQIIgXFrVuhs5HE2WG0xEsvTOGtcWSuyDeMA
         nUpyAr9hpx/3qXLEzH3YfrATIuvXvYxvD/+p06M+TyuzmN5/XBf8OU8BpADPz1utK3qG
         s80oGC069gnYZSFNtl8+KASPbhD2vtyu8VY2E7K/m5ZD2bOdrHFo41mefSe6Wwt4EEmJ
         02yLSAGYqff+LK25Om8ZEnW+4rY9w812i+bFWDWOfHMdVyQzeM+dmSCLk7daqrChhog+
         tuCcRsRMvWzogYKGEZ0GhR6XK7PvZgvFOkNBh45gy2Asr4Lddu/aIz07smTDYu1Tsvz4
         RnAQ==
X-Gm-Message-State: APjAAAWMCfEZ/4WdDcT5S17WJv9Qx6M8w51JhzJSH4cnYhTMIeVUM9EB
        h37ygkwjLPt/8K685FXo+gLbGQ==
X-Google-Smtp-Source: APXvYqx98soN4TJOR6EqsnHUBrwxgT/pxlU3w83u9j9CkrR0R48FZdRdWl1D11WSUnw1Xm3cnPuPDQ==
X-Received: by 2002:ae9:ebcc:: with SMTP id b195mr21560825qkg.387.1570451654081;
        Mon, 07 Oct 2019 05:34:14 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id i30sm10406440qte.27.2019.10.07.05.34.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 05:34:13 -0700 (PDT)
Message-ID: <1570451651.5576.285.camel@lca.pw>
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
From:   Qian Cai <cai@lca.pw>
To:     Petr Mladek <pmladek@suse.com>, Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        rostedt@goodmis.org, peterz@infradead.org, david@redhat.com,
        john.ogness@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 07 Oct 2019 08:34:11 -0400
In-Reply-To: <20191007090553.g5cq7qa4tj5yrtaa@pathway.suse.cz>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
         <20191007080742.GD2381@dhcp22.suse.cz>
         <20191007090553.g5cq7qa4tj5yrtaa@pathway.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-07 at 11:05 +0200, Petr Mladek wrote:
> On Mon 2019-10-07 10:07:42, Michal Hocko wrote:
> > On Fri 04-10-19 18:26:45, Qian Cai wrote:
> > > It is unsafe to call printk() while zone->lock was held, i.e.,
> > > 
> > > zone->lock --> console_lock
> > > 
> > > because the console could always allocate some memory in different code
> > > paths and form locking chains in an opposite order,
> > > 
> > > console_lock --> * --> zone->lock
> > > 
> > > As the result, it triggers lockdep splats like below and in different
> > > code paths in this thread [1]. Since has_unmovable_pages() was only used
> > > in set_migratetype_isolate() and is_pageblock_removable_nolock(). Only
> > > the former will set the REPORT_FAILURE flag which will call printk().
> > > Hence, unlock the zone->lock just before the dump_page() there where
> > > when has_unmovable_pages() returns true, there is no need to hold the
> > > lock anyway in the rest of set_migratetype_isolate().
> > > 
> > > While at it, remove a problematic printk() in __offline_isolated_pages()
> > > only for debugging as well which will always disable lockdep on debug
> > > kernels.
> > 
> > I do not think that removing the printk is the right long term solution.
> > While I do agree that removing the debugging printk __offline_isolated_pages
> > does make sense because it is essentially of a very limited use, this
> > doesn't really solve the underlying problem.  There are likely other
> > printks from zone->lock. It would be much more saner to actually
> > disallow consoles to allocate any memory while printk is called from an
> > atomic context.
> 
> The current "standard" solution for these situations is to replace
> the problematic printk() with printk_deferred(). It would deffer
> the console handling.
> 
> Of course, this is a whack a mole approach. The long term solution
> is to deffer printk() by default. We have finally agreed on this
> few weeks ago on Plumbers conference. It is going to be added
> together with fully lockless log buffer hopefully soon. It will
> be part of upstreaming Real-Time related code.

Does this guarantee that if,

lock(zone->lock)
printk_deferred()
unlock(zone->lock)

that the locks (console_owner and console_sem) in printk_deferred() will always
be processed by the unlock(zone->lock)?

If it is more of timing thing where klogd wakes up, it could still end up with,

zone_lock -> console_owner/console_sem

that causes a deadlock.
