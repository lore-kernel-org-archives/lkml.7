Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C12C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8340120643
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551961397;
	bh=9MKT18nsRZPfF4X7TxKITIX6OyJ7Yo0ADu/onCUUIFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jkW5LRoeB4MkzN2jR94Z7Vg86Jj9nTJqrN581+G5/wNnYCvRFdHgnUF/szI6SlQOa
	 iSGHga7jVWgYqQ+RqkrmUfoyW6zYNMlSUJ+C3l/8/XTn7fvi1GhQKjDEK2Zv4goFdi
	 NXU+cD96fJpQOD7SYxaC7pc1Sbz7opNKAffS0RU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfCGMXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:23:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:43586 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726127AbfCGMXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:23:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7DE58BE21;
        Thu,  7 Mar 2019 12:23:14 +0000 (UTC)
Date:   Thu, 7 Mar 2019 13:23:13 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Huang Ying <ying.huang@intel.com>,
        Aaron Lu <aaron.lu@intel.com>, Tejun Heo <tj@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/swap: Avoid undefined behavior in __swapoffset
Message-ID: <20190307122313.GA30234@dhcp22.suse.cz>
References: <20190307094653.119425-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307094653.119425-1-pihsun@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07-03-19 17:46:50, Pi-Hsun Shih wrote:
> Use offsetof to calculate offset of a field to avoid UBSAN warning like:
> 
> ===================================================================
> UBSAN: Undefined behaviour in mm/swapfile.c:3010:38
> member access within null pointer of type 'union swap_header'
> CPU: 6 PID: 1833 Comm: swapon Tainted: G S                4.19.23 #43
> Call trace:
>  dump_backtrace+0x0/0x194
>  show_stack+0x20/0x2c
>  __dump_stack+0x20/0x28
>  dump_stack+0x70/0x94
>  ubsan_epilogue+0x14/0x44
>  ubsan_type_mismatch_common+0xf4/0xfc
>  __ubsan_handle_type_mismatch_v1+0x34/0x54
>  __se_sys_swapon+0x654/0x1084
>  __arm64_sys_swapon+0x1c/0x24
>  el0_svc_common+0xa8/0x150
>  el0_svc_compat_handler+0x2c/0x38
>  el0_svc_compat+0x8/0x18
> ==================================================================

Could you be more specific about what exactly is undefined here and
why offsetof is any better. AFAIR it uses the same construct unless a
compiler defines a built in.

I do not object the change itself because it is cleaner to use the
existing helper but I am wondering why this is fixing ubsan. Is ubsan
defining the compiler variant and consider it safe?

> 
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> ---
>  include/linux/swap.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index fc50e21b3b88..4bfb5c4ac108 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -157,9 +157,9 @@ struct swap_extent {
>  /*
>   * Max bad pages in the new format..
>   */
> -#define __swapoffset(x) ((unsigned long)&((union swap_header *)0)->x)
>  #define MAX_SWAP_BADPAGES \
> -	((__swapoffset(magic.magic) - __swapoffset(info.badpages)) / sizeof(int))
> +	((offsetof(union swap_header, magic.magic) - \
> +	  offsetof(union swap_header, info.badpages)) / sizeof(int))
>  
>  enum {
>  	SWP_USED	= (1 << 0),	/* is slot in swap_info[] used? */
> -- 
> 2.21.0.352.gf09ad66450-goog
> 

-- 
Michal Hocko
SUSE Labs
