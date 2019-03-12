Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EB4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111CD2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552402719;
	bh=LKf2N3fvQyKyfuMqRjgYcYFzh86ITZWLkUchBgw6WPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SJ+6LF7B5T42w4hNkG1h9UHgu0/jTooN0aseG5LOE2OLxenDX5xhWg7hL3m7yPEDW
	 GJgrf4grEwF/RwKG5aO8+9+tQm3Q1TqGt4pWP5x+JJ1vu/559rph6G11kAZW1FNamX
	 YdolIsV0MwGhG9aATjCbsERBcLmuHJ77sHgynYp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbfCLO6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:58:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:37028 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726514AbfCLO6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:58:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 44819B682;
        Tue, 12 Mar 2019 14:58:15 +0000 (UTC)
Date:   Tue, 12 Mar 2019 15:58:13 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/slab: protect cache_reap() against CPU and memory hot
 plug operations
Message-ID: <20190312145813.GS5721@dhcp22.suse.cz>
References: <20190311191701.24325-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311191701.24325-1-ldufour@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11-03-19 20:17:01, Laurent Dufour wrote:
> The commit 95402b382901 ("cpu-hotplug: replace per-subsystem mutexes with
> get_online_cpus()") remove the CPU_LOCK_ACQUIRE operation which was use to
> grap the cache_chain_mutex lock which was protecting cache_reap() against
> CPU hot plug operations.
> 
> Later the commit 18004c5d4084 ("mm, sl[aou]b: Use a common mutex
> definition") changed cache_chain_mutex to slab_mutex but this didn't help
> fixing the missing the cache_reap() protection against CPU hot plug
> operations.
> 
> Here we are stopping the per cpu worker while holding the slab_mutex to
> ensure that cache_reap() is not running in our back and will not be
> triggered anymore for this cpu.
> 
> This patch fixes that race leading to SLAB's data corruption when CPU
> hotplug are triggered. We hit it while doing partition migration on PowerVM
> leading to CPU reconfiguration through the CPU hotplug mechanism.

What is the actual race? slab_offline_cpu calls cancel_delayed_work_sync
so it removes a pending item and waits for the item to finish if they run
concurently. So why do we need an additional lock?

> This fix is covering kernel containing to the commit 6731d4f12315 ("slab:
> Convert to hotplug state machine"), ie 4.9.1, earlier kernel needs a
> slightly different patch.
> 
> Cc: stable@vger.kernel.org
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> ---
>  mm/slab.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index 28652e4218e0..ba499d90f27f 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1103,6 +1103,7 @@ static int slab_online_cpu(unsigned int cpu)
>  
>  static int slab_offline_cpu(unsigned int cpu)
>  {
> +	mutex_lock(&slab_mutex);
>  	/*
>  	 * Shutdown cache reaper. Note that the slab_mutex is held so
>  	 * that if cache_reap() is invoked it cannot do anything
> @@ -1112,6 +1113,7 @@ static int slab_offline_cpu(unsigned int cpu)
>  	cancel_delayed_work_sync(&per_cpu(slab_reap_work, cpu));
>  	/* Now the cache_reaper is guaranteed to be not running. */
>  	per_cpu(slab_reap_work, cpu).work.func = NULL;
> +	mutex_unlock(&slab_mutex);
>  	return 0;
>  }
>  
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
