Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCFAC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A9822DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbfIDIsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:48:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbfIDIsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:48:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 577BD875222;
        Wed,  4 Sep 2019 08:48:36 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C9AD560BFB;
        Wed,  4 Sep 2019 08:48:30 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id x848mUBu011879;
        Wed, 4 Sep 2019 04:48:30 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id x848mUGT011875;
        Wed, 4 Sep 2019 04:48:30 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 4 Sep 2019 04:48:30 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Huaisheng Ye <yehs2007@zoho.com>
cc:     snitzer@redhat.com, agk@redhat.com, prarit@redhat.com,
        tyu1@lenovo.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Huaisheng Ye <yehs1@lenovo.com>
Subject: Re: [PATCH] dm writecache: skip writecache_wait for pmem mode
In-Reply-To: <20190902100450.10600-1-yehs2007@zoho.com>
Message-ID: <alpine.LRH.2.02.1909040444440.11252@file01.intranet.prod.int.rdu2.redhat.com>
References: <20190902100450.10600-1-yehs2007@zoho.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Wed, 04 Sep 2019 08:48:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 Sep 2019, Huaisheng Ye wrote:

> From: Huaisheng Ye <yehs1@lenovo.com>
> 
> The array bio_in_progress[2] only have chance to be increased and
> decreased with ssd mode. For pmem mode, they are not involved at all.
> So skip writecache_wait_for_ios in writecache_flush for pmem.
> 
> Suggested-by: Doris Yu <tyu1@lenovo.com>
> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
> ---
>  drivers/md/dm-writecache.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> index c481947..d06b8aa 100644
> --- a/drivers/md/dm-writecache.c
> +++ b/drivers/md/dm-writecache.c
> @@ -726,7 +726,8 @@ static void writecache_flush(struct dm_writecache *wc)
>  	}
>  	writecache_commit_flushed(wc);
>  
> -	writecache_wait_for_ios(wc, WRITE);
> +	if (!WC_MODE_PMEM(wc))
> +		writecache_wait_for_ios(wc, WRITE);
>  
>  	wc->seq_count++;
>  	pmem_assign(sb(wc)->seq_count, cpu_to_le64(wc->seq_count));
> -- 
> 1.8.3.1

I think this is not needed - wait_event in writecache_wait_for_ios exits 
immediatelly if the condition is true.

This code path is not so hot that we would need microoptimizations like 
this to avoid function calls.

Mikulas
