Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC4FC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136E020B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="AJHLJi81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731315AbfJIPIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:08:39 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33319 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729865AbfJIPIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:08:39 -0400
Received: by mail-qt1-f193.google.com with SMTP id r5so3947652qtd.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 08:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6qPsXR/T23d2yQXhVGAwdewXonUCgZDbn2dZYxeSHVw=;
        b=AJHLJi81MFFfsyyMX6muUq1/ofBVohlqThw40+CF8J3lqWlzpfqESlx74nHjmwarmH
         CJu5PzafVtvyg86U+DrhZM8iHUu5ckEOf26KfmQ/v4tyq7R2aly7xpSr7DF8UH8UA47X
         Q5pfKtrwBgu3eq4ar1CKrkfb6A9hZt+OPV8abxQUC8obXkwjiGfWIYaNds8VV4LgIne0
         /rK1jYvqs6dnoMacVaR3ppmAMuEVvfavi2GsCJPU2IS820TA6e7rGDWacvNGc/pVy4Ye
         ESIia2cW8kk8bDNKYkk966/ZIe82ygy1mv91PjKDv67k6jfy5vh0LbHkrh48W1D6wa9k
         kzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6qPsXR/T23d2yQXhVGAwdewXonUCgZDbn2dZYxeSHVw=;
        b=jpIdM60x440vwzBJgNot+UyQRVCMZ3VnZpIYSHN4z4kXpmdSERwYovYlhxvh7PlqCR
         U1nbn4GxG4ruxnCus27p0IVUCZiFBR+TGg7t87pioFtudrxm2yTe4vKBBQoveprQ5wjr
         PuS2fJ+VTfmmdQGKs9a36U65pmedu91KNDIpwmt5pQ57y3GeT6WZ8paCkjTdxmUhnPbN
         N1LtBE+KaCwhxID45Ml+3igm7gFRtNr7nF8sm/SOF88B0gBS5AA+Gr7wyO+dPcoWxPzg
         e+f7F8tN1yt9273kt6/7lgNiuW/w7qX7hm9pWuWyGrw0hKQyzVarBEs0ZxJlKZ5PPECF
         wtnA==
X-Gm-Message-State: APjAAAUiyisnvhEhNlTRXXVI8HuBIqJNchtGVJtfIKDwlKGcqgFYHsCK
        uq8mEPndAVO+0w6OqscTPpL3gQ==
X-Google-Smtp-Source: APXvYqx4ZHLPpIlLgc8wAMy6Uv0C9n/Nzaxln6HO9c+OEP5hBmcbu6XmCqN7xb1WEkHsGmzovG/v+w==
X-Received: by 2002:ac8:fb6:: with SMTP id b51mr4260217qtk.70.1570633718500;
        Wed, 09 Oct 2019 08:08:38 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id k2sm1043678qtm.42.2019.10.09.08.08.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 08:08:37 -0700 (PDT)
Message-ID: <1570633715.5937.10.camel@lca.pw>
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, akpm@linux-foundation.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>, david@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 09 Oct 2019 11:08:35 -0400
In-Reply-To: <20191009143439.GF6681@dhcp22.suse.cz>
References: <20191008183525.GQ6681@dhcp22.suse.cz>
         <1570561573.5576.307.camel@lca.pw> <20191008191728.GS6681@dhcp22.suse.cz>
         <1570563324.5576.309.camel@lca.pw>
         <20191009114903.aa6j6sa56z2cssom@pathway.suse.cz>
         <1570626402.5937.1.camel@lca.pw> <20191009132746.GA6681@dhcp22.suse.cz>
         <1570628593.5937.3.camel@lca.pw> <20191009135155.GC6681@dhcp22.suse.cz>
         <1570630784.5937.5.camel@lca.pw> <20191009143439.GF6681@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-09 at 16:34 +0200, Michal Hocko wrote:
> On Wed 09-10-19 10:19:44, Qian Cai wrote:
> > On Wed, 2019-10-09 at 15:51 +0200, Michal Hocko wrote:
> 
> [...]
> > > Can you paste the full lock chain graph to be sure we are on the same
> > > page?
> > 
> > WARNING: possible circular locking dependency detected
> > 5.3.0-next-20190917 #8 Not tainted
> > ------------------------------------------------------
> > test.sh/8653 is trying to acquire lock:
> > ffffffff865a4460 (console_owner){-.-.}, at:
> > console_unlock+0x207/0x750
> > 
> > but task is already holding lock:
> > ffff88883fff3c58 (&(&zone->lock)->rlock){-.-.}, at:
> > __offline_isolated_pages+0x179/0x3e0
> > 
> > which lock already depends on the new lock.
> > 
> > 
> > the existing dependency chain (in reverse order) is:
> > 
> > -> #3 (&(&zone->lock)->rlock){-.-.}:
> >        __lock_acquire+0x5b3/0xb40
> >        lock_acquire+0x126/0x280
> >        _raw_spin_lock+0x2f/0x40
> >        rmqueue_bulk.constprop.21+0xb6/0x1160
> >        get_page_from_freelist+0x898/0x22c0
> >        __alloc_pages_nodemask+0x2f3/0x1cd0
> >        alloc_pages_current+0x9c/0x110
> >        allocate_slab+0x4c6/0x19c0
> >        new_slab+0x46/0x70
> >        ___slab_alloc+0x58b/0x960
> >        __slab_alloc+0x43/0x70
> >        __kmalloc+0x3ad/0x4b0
> >        __tty_buffer_request_room+0x100/0x250
> >        tty_insert_flip_string_fixed_flag+0x67/0x110
> >        pty_write+0xa2/0xf0
> >        n_tty_write+0x36b/0x7b0
> >        tty_write+0x284/0x4c0
> >        __vfs_write+0x50/0xa0
> >        vfs_write+0x105/0x290
> >        redirected_tty_write+0x6a/0xc0
> >        do_iter_write+0x248/0x2a0
> >        vfs_writev+0x106/0x1e0
> >        do_writev+0xd4/0x180
> >        __x64_sys_writev+0x45/0x50
> >        do_syscall_64+0xcc/0x76c
> >        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> This one looks indeed legit. pty_write is allocating memory from inside
> the port->lock. But this seems to be quite broken, right? The forward
> progress depends on GFP_ATOMIC allocation which might fail easily under
> memory pressure. So the preferred way to fix this should be to change
> the allocation scheme to use the preallocated buffer and size it from a
> context when it doesn't hold internal locks. It might be a more complex
> fix than using printk_deferred or other games but addressing that would
> make the pty code more robust as well.

I am not really sure if doing a surgery in pty code is better than fixing the
memory offline side as a short-term fix.
