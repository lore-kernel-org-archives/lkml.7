Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA5EC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 12:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7150020879
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 12:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558096886;
	bh=o8S2kJzM7vX8V+5IVod+/oW0qgbBC25Kg7lmcTyOEpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ObJAStGTfITnKpK6RSOC0RqbzOk3pEcQO8Fkk7S0CLbDNzBgQswEvLMXzYLLMW6gD
	 mS9xGdu0qAlLrjI299tinzjj5K9Ikkipnh58SbFqxph/7OfR9pCsxtHKCSxO3XweMZ
	 UaGuNNaPl/VYThiKh6aLuUgBgrDKGZDgFT6MPt9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfEQMlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 08:41:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:33548 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728474AbfEQMlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 08:41:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 410FBAF3A;
        Fri, 17 May 2019 12:41:20 +0000 (UTC)
Date:   Fri, 17 May 2019 14:41:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Cyrill Gorcunov <gorcunov@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/5] proc: use down_read_killable for /proc/pid/maps
Message-ID: <20190517124119.GA1825@dhcp22.suse.cz>
References: <155790967258.1319.11531787078240675602.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155790967258.1319.11531787078240675602.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-05-19 11:41:12, Konstantin Khlebnikov wrote:
> Do not stuck forever if something wrong.
> This function also used for /proc/pid/smaps.

I do agree that the killable variant is better but I do not understand
the changelog. What would keep the lock blocked for ever? I do not think
we have writer lock held for unbound amount of time anywhere, do we?

> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Other than that
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  fs/proc/task_mmu.c   |    6 +++++-
>  fs/proc/task_nommu.c |    6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 01d4eb0e6bd1..2bf210229daf 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -166,7 +166,11 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
>  	if (!mm || !mmget_not_zero(mm))
>  		return NULL;
>  
> -	down_read(&mm->mmap_sem);
> +	if (down_read_killable(&mm->mmap_sem)) {
> +		mmput(mm);
> +		return ERR_PTR(-EINTR);
> +	}
> +
>  	hold_task_mempolicy(priv);
>  	priv->tail_vma = get_gate_vma(mm);
>  
> diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
> index 36bf0f2e102e..7907e6419e57 100644
> --- a/fs/proc/task_nommu.c
> +++ b/fs/proc/task_nommu.c
> @@ -211,7 +211,11 @@ static void *m_start(struct seq_file *m, loff_t *pos)
>  	if (!mm || !mmget_not_zero(mm))
>  		return NULL;
>  
> -	down_read(&mm->mmap_sem);
> +	if (down_read_killable(&mm->mmap_sem)) {
> +		mmput(mm);
> +		return ERR_PTR(-EINTR);
> +	}
> +
>  	/* start from the Nth VMA */
>  	for (p = rb_first(&mm->mm_rb); p; p = rb_next(p))
>  		if (n-- == 0)

-- 
Michal Hocko
SUSE Labs
