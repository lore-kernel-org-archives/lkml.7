Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B0ACA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 14:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FE121928
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 14:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="BZkHaRYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392350AbfJWOsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 10:48:18 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36107 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389782AbfJWOsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 10:48:18 -0400
Received: by mail-qt1-f195.google.com with SMTP id d17so18057013qto.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 07:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vjvG0YaPvJzrnfB/Uiu1r+Ze/1d150PHkHjsMUcfx8E=;
        b=BZkHaRYuoe/FkavOYJiIUDecwTMvo28hYRHTq0igC1R8h30o/ZIhCWeNSIxxhWMWwa
         i8iVq6KCl1LApCQRYUVIu75WbWIYRroN5PECJrmF1BfLZvA46aOVHMVNmNDuH/HQTMri
         AaHuy6wbFV7ZEhVuvS9wd65t+noxEmvNSAR9MlN8KxkAEXclE8KdaPrbzTD2gSshGM0c
         nzszAuXlpap01G11P/jWRtJXDDk0X1AJ+VESkIe0CmH7DaGHdDIjGZ/VU2YohRo4j3Hk
         0fAKivpfTSlBjGOdrMLQr5C+NOQRvv6Rre8wf6+a4mRlLPodlyj/bTe65CD28lXyfghK
         uS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vjvG0YaPvJzrnfB/Uiu1r+Ze/1d150PHkHjsMUcfx8E=;
        b=qPsEAaiMbZSSTaHapykAc+jKPcJLiq6UK/5TNrYIaKi3W+6jACwaouLEz1E4lU3SFe
         RjjNSjYxQtn+1V+s2hdkUsTNYzNpqWZXVnmYRkwpbJPiKQ6cIe05W3Qy5ZL1CzXlB0XT
         iAdQ+9aM3rCv3K2dpn1EGd4/Cp1ZOdpp9VywBQx/dDppp0C92bps0QL2GC2e69HEqNbb
         FKc+Yf+PFsoqgJLMoJ13FHEj6IXAmE0OQzl0EtEINZ491qNt8D3dtjo9UnbO36SUl1VX
         yzb533UhZGb3wz7/ngmkxMvpowD/218kZMycyTk+nSO118Xr/rABhmUwKqbqjqIJe70O
         FIsQ==
X-Gm-Message-State: APjAAAVNMqZzAXA4CbWyzwjfE02AuI/DFs9p3oRgibGA08p6j5AJB5Z0
        N0FkrNd9sNpGTnIuHYZH85iTww==
X-Google-Smtp-Source: APXvYqySKb0FbXVLchzcGl/io5uNfHzYtkG46H1IUxRsYaG9m/mP2gxIrRF8Pe1O8FziLDmvAWG4EQ==
X-Received: by 2002:aed:3151:: with SMTP id 75mr879137qtg.145.1571842096703;
        Wed, 23 Oct 2019 07:48:16 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id p3sm10008989qkm.52.2019.10.23.07.48.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 07:48:16 -0700 (PDT)
Message-ID: <1571842093.5937.84.camel@lca.pw>
Subject: Re: [PATCH] mm/vmstat: Reduce zone lock hold time when reading
 /proc/pagetypeinfo
From:   Qian Cai <cai@lca.pw>
To:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>
Date:   Wed, 23 Oct 2019 10:48:13 -0400
In-Reply-To: <2236495a-ead0-e08e-3fb6-f3ab906b75b6@redhat.com>
References: <20191022162156.17316-1-longman@redhat.com>
         <20191022145902.d9c4a719c0b32175e06e4eee@linux-foundation.org>
         <2236495a-ead0-e08e-3fb6-f3ab906b75b6@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-23 at 10:30 -0400, Waiman Long wrote:
> On 10/22/19 5:59 PM, Andrew Morton wrote:
> > On Tue, 22 Oct 2019 12:21:56 -0400 Waiman Long <longman@redhat.com> wrote:
> > 
> > > The pagetypeinfo_showfree_print() function prints out the number of
> > > free blocks for each of the page orders and migrate types. The current
> > > code just iterates the each of the free lists to get counts.  There are
> > > bug reports about hard lockup panics when reading the /proc/pagetyeinfo
> > > file just because it look too long to iterate all the free lists within
> > > a zone while holing the zone lock with irq disabled.
> > > 
> > > Given the fact that /proc/pagetypeinfo is readable by all, the possiblity
> > > of crashing a system by the simple act of reading /proc/pagetypeinfo
> > > by any user is a security problem that needs to be addressed.
> > 
> > Yes.
> > 
> > > There is a free_area structure associated with each page order. There
> > > is also a nr_free count within the free_area for all the different
> > > migration types combined. Tracking the number of free list entries
> > > for each migration type will probably add some overhead to the fast
> > > paths like moving pages from one migration type to another which may
> > > not be desirable.
> > > 
> > > we can actually skip iterating the list of one of the migration types
> > > and used nr_free to compute the missing count. Since MIGRATE_MOVABLE
> > > is usually the largest one on large memory systems, this is the one
> > > to be skipped. Since the printing order is migration-type => order, we
> > > will have to store the counts in an internal 2D array before printing
> > > them out.
> > > 
> > > Even by skipping the MIGRATE_MOVABLE pages, we may still be holding the
> > > zone lock for too long blocking out other zone lock waiters from being
> > > run. This can be problematic for systems with large amount of memory.
> > > So a check is added to temporarily release the lock and reschedule if
> > > more than 64k of list entries have been iterated for each order. With
> > > a MAX_ORDER of 11, the worst case will be iterating about 700k of list
> > > entries before releasing the lock.
> > > 
> > > ...
> > > 
> > > --- a/mm/vmstat.c
> > > +++ b/mm/vmstat.c
> > > @@ -1373,23 +1373,54 @@ static void pagetypeinfo_showfree_print(struct seq_file *m,
> > >  					pg_data_t *pgdat, struct zone *zone)
> > >  {
> > >  	int order, mtype;
> > > +	unsigned long nfree[MAX_ORDER][MIGRATE_TYPES];
> > 
> > 600+ bytes is a bit much.  I guess it's OK in this situation.
> > 
> 
> This function is called by reading /proc/pagetypeinfo. The call stack is
> rather shallow:
> 
> PID: 58188  TASK: ffff938a4d4f1fa0  CPU: 2   COMMAND: "sosreport"
>  #0 [ffff9483bf488e48] crash_nmi_callback at ffffffffb8c551d7
>  #1 [ffff9483bf488e58] nmi_handle at ffffffffb931d8cc
>  #2 [ffff9483bf488eb0] do_nmi at ffffffffb931dba8
>  #3 [ffff9483bf488ef0] end_repeat_nmi at ffffffffb931cd69
>     [exception RIP: pagetypeinfo_showfree_print+0x73]
>     RIP: ffffffffb8db7173  RSP: ffff938b9fcbfda0  RFLAGS: 00000006
>     RAX: fffff0c9946d7020  RBX: ffff96073ffd5528  RCX: 0000000000000000
>     RDX: 00000000001c7764  RSI: ffffffffb9676ab1  RDI: 0000000000000000
>     RBP: ffff938b9fcbfdd0   R8: 000000000000000a   R9: 00000000fffffffe
>     R10: 0000000000000000  R11: ffff938b9fcbfc36  R12: ffff942b97758240
>     R13: ffffffffb942f730  R14: ffff96073ffd5000  R15: ffff96073ffd5180
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> --- <NMI exception stack> ---
>  #4 [ffff938b9fcbfda0] pagetypeinfo_showfree_print at ffffffffb8db7173
>  #5 [ffff938b9fcbfdd8] walk_zones_in_node at ffffffffb8db74df
>  #6 [ffff938b9fcbfe20] pagetypeinfo_show at ffffffffb8db7a29
>  #7 [ffff938b9fcbfe48] seq_read at ffffffffb8e45c3c
>  #8 [ffff938b9fcbfeb8] proc_reg_read at ffffffffb8e95070
>  #9 [ffff938b9fcbfed8] vfs_read at ffffffffb8e1f2af
> #10 [ffff938b9fcbff08] sys_read at ffffffffb8e2017f
> #11 [ffff938b9fcbff50] system_call_fastpath at ffffffffb932579b
> 
> So we should not be in any risk of overflowing the stack.
> 
> > > -	for (mtype = 0; mtype < MIGRATE_TYPES; mtype++) {
> > > -		seq_printf(m, "Node %4d, zone %8s, type %12s ",
> > > -					pgdat->node_id,
> > > -					zone->name,
> > > -					migratetype_names[mtype]);
> > > -		for (order = 0; order < MAX_ORDER; ++order) {
> > > +	lockdep_assert_held(&zone->lock);
> > > +	lockdep_assert_irqs_disabled();
> > > +
> > > +	/*
> > > +	 * MIGRATE_MOVABLE is usually the largest one in large memory
> > > +	 * systems. We skip iterating that list. Instead, we compute it by
> > > +	 * subtracting the total of the rests from free_area->nr_free.
> > > +	 */
> > > +	for (order = 0; order < MAX_ORDER; ++order) {
> > > +		unsigned long nr_total = 0;
> > > +		struct free_area *area = &(zone->free_area[order]);
> > > +
> > > +		for (mtype = 0; mtype < MIGRATE_TYPES; mtype++) {
> > >  			unsigned long freecount = 0;
> > > -			struct free_area *area;
> > >  			struct list_head *curr;
> > >  
> > > -			area = &(zone->free_area[order]);
> > > -
> > > +			if (mtype == MIGRATE_MOVABLE)
> > > +				continue;
> > >  			list_for_each(curr, &area->free_list[mtype])
> > >  				freecount++;
> > > -			seq_printf(m, "%6lu ", freecount);
> > > +			nfree[order][mtype] = freecount;
> > > +			nr_total += freecount;
> > >  		}
> > > +		nfree[order][MIGRATE_MOVABLE] = area->nr_free - nr_total;
> > > +
> > > +		/*
> > > +		 * If we have already iterated more than 64k of list
> > > +		 * entries, we might have hold the zone lock for too long.
> > > +		 * Temporarily release the lock and reschedule before
> > > +		 * continuing so that other lock waiters have a chance
> > > +		 * to run.
> > > +		 */
> > > +		if (nr_total > (1 << 16)) {
> > > +			spin_unlock_irq(&zone->lock);
> > > +			cond_resched();
> > > +			spin_lock_irq(&zone->lock);
> > > +		}
> > > +	}
> > > +
> > > +	for (mtype = 0; mtype < MIGRATE_TYPES; mtype++) {
> > > +		seq_printf(m, "Node %4d, zone %8s, type %12s ",
> > > +					pgdat->node_id,
> > > +					zone->name,
> > > +					migratetype_names[mtype]);
> > > +		for (order = 0; order < MAX_ORDER; ++order)
> > > +			seq_printf(m, "%6lu ", nfree[order][mtype]);
> > >  		seq_putc(m, '\n');
> > 
> > This is not exactly a thing of beauty :( Presumably there might still
> > be situations where the irq-off times remain excessive.
> 
> Yes, that is still possible.
> > 
> > Why are we actually holding zone->lock so much?  Can we get away with
> > holding it across the list_for_each() loop and nothing else?  If so,
> 
> We can certainly do that with the risk that the counts will be less
> reliable for a given order. I can send a v2 patch if you think this is
> safer.
> 
> 
> > this still isn't a bulletproof fix.  Maybe just terminate the list
> > walk if freecount reaches 1024.  Would anyone really care?
> > 
> > Sigh.  I wonder if anyone really uses this thing for anything
> > important.  Can we just remove it all?
> > 
> 
> Removing it will be a breakage of kernel API.

Who cares about breaking this part of the API that essentially nobody will use
this file?

> 
> Another alternative is to mark the migration type in the page structure
> so that we can do per-migration type nr_free tracking. That will be a
> major change to the mm code.
> 
> I consider this patch lesser of the two evils. 
> 
> Cheers,
> Longman
> 
> 
