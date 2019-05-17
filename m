Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9237BC04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 12:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D802087B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 12:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558097211;
	bh=zChL7idvGIU2QV6AgtCeuGhZR59ABSD7mqmJoFmWgcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ybp1MfA2dDj27G/jIffsm/m0xThvOIDveBI2+D+FXuUmeSRBSq37gKDzYj1FtLnLK
	 /ZH/ajf9PWg3mPA7ogOzS6nqgk+bzXWddM1T6xldFmWwYXihoaK5kduy02dTnLr/9c
	 24b8QsI2i3eHaKW001M4SXE/VHG0ugW87vyoZ6MY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfEQMqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 08:46:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:34744 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728654AbfEQMqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 08:46:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D83B1AF68;
        Fri, 17 May 2019 12:46:48 +0000 (UTC)
Date:   Fri, 17 May 2019 14:46:48 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Cyrill Gorcunov <gorcunov@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 3/5] proc: use down_read_killable for /proc/pid/pagemap
Message-ID: <20190517124648.GC1825@dhcp22.suse.cz>
References: <155790967258.1319.11531787078240675602.stgit@buzz>
 <155790967960.1319.6040190052682812218.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155790967960.1319.6040190052682812218.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-05-19 11:41:19, Konstantin Khlebnikov wrote:
> Ditto.

ditto to the previous patch, including -EINTR.

> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  fs/proc/task_mmu.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 781879a91e3b..78bed6adc62d 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1547,7 +1547,9 @@ static ssize_t pagemap_read(struct file *file, char __user *buf,
>  		/* overflow ? */
>  		if (end < start_vaddr || end > end_vaddr)
>  			end = end_vaddr;
> -		down_read(&mm->mmap_sem);
> +		ret = down_read_killable(&mm->mmap_sem);
> +		if (ret)
> +			goto out_free;
>  		ret = walk_page_range(start_vaddr, end, &pagemap_walk);
>  		up_read(&mm->mmap_sem);
>  		start_vaddr = end;

-- 
Michal Hocko
SUSE Labs
