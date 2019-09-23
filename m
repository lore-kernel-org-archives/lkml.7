Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27395C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84922064A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731473AbfIWImV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 04:42:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbfIWImV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 04:42:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DF00E83F40;
        Mon, 23 Sep 2019 08:42:20 +0000 (UTC)
Received: from localhost (ovpn-12-214.pek2.redhat.com [10.72.12.214])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 12C3B60852;
        Mon, 23 Sep 2019 08:42:19 +0000 (UTC)
Date:   Mon, 23 Sep 2019 16:42:17 +0800
From:   Baoquan He <bhe@redhat.com>
To:     tj@kernel.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] memcg: Only record foreign writebacks with dirty pages
 when memcg is not disabled
Message-ID: <20190923084217.GA342@MiWiFi-R3L-srv>
References: <20190923083030.6442-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923083030.6442-1-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 23 Sep 2019 08:42:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/23/19 at 04:30pm, Baoquan He wrote:
 
> ---
>  include/linux/memcontrol.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index ad8f1a397ae4..fa53f9d51205 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1261,7 +1261,8 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
>  static inline void mem_cgroup_track_foreign_dirty(struct page *page,
>  						  struct bdi_writeback *wb)
>  {
> -	if (unlikely(&page->mem_cgroup->css != wb->memcg_css))
> +	if (unlikely(&page->mem_cgroup->css != wb->memcg_css)
> +		&& !mem_cgroup_disabled())

Sorry, this is the draft patch I was testing. Later I think this
had better be moved into mem_cgroup_track_foreign_dirty_slowpath().

Not very sure about this. Will send a v2 to match the patch log.

>  		mem_cgroup_track_foreign_dirty_slowpath(page, wb);
>  }
>  
> -- 
> 2.17.2
> 
