Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EC6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C122147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552379176;
	bh=l2HsO194GmzSjaZJ7s/9hf4Ym+X28F8Jw7yOi+Dx7sI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F62eS6iUWe/5ctybCoitpXqaML1jKrHsBIVK4Lk045e0LF1wdPD58/CP11sQ6toYz
	 X78tEEZp2yaXcQ8k6bHJf/xipL1gpNe+tE6xT8cOHkv0NJO17xSDdvW3lVxT1E0Wyb
	 e41IaMCuWZA6wC0IGZpR1XLbrRz6PCPo8p72rVG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfCLI0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:26:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:46018 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725832AbfCLI0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:26:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1BA30B157;
        Tue, 12 Mar 2019 08:26:13 +0000 (UTC)
Date:   Tue, 12 Mar 2019 09:26:12 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Minchan Kim <minchan@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Aaron Lu <aaron.lu@intel.com>, Tejun Heo <tj@kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/swap: Use offsetof instead of custom __swapoffset
 macro.
Message-ID: <20190312082612.GH5721@dhcp22.suse.cz>
References: <20190307094653.119425-1-pihsun@chromium.org>
 <20190312081902.223764-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312081902.223764-1-pihsun@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-03-19 16:18:59, Pi-Hsun Shih wrote:
> Use offsetof to calculate offset of a field to take advantage of
> compiler built-in version when possible, and avoid UBSAN warning when
> compiling with Clang:
> 
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
> 
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>

Yes this makes more sense. I still think the warning is bogus but
whatever. A cleanup is worth it.

Acked-by: Michal Hocko <mhocko@suse.com>

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
> 2.21.0.360.g471c308f928-goog
> 

-- 
Michal Hocko
SUSE Labs
