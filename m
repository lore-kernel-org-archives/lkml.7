Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01061C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD0F20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552294067;
	bh=hc6KYrqPeIgsN9PzQlC8sDywcFDAT1qWj8oVLGvCrtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mqWxPjz8xpL+JdkfQWJfjWExE3+L/RmZraLDbPWM7HLAHrXZylPn1LfliazNr+3aj
	 K6qBXZ1Uea4pfsRnU6nQS5lwrylgoEb8S4I9rmyuq2DWYi+NI1hxXLsEeqqswuV+ry
	 c42spnRu32KL6wLbH9cOmmjXfGCHebT6/HSgtPaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfCKIrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 04:47:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:43006 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726631AbfCKIrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 04:47:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2FD81ACC8;
        Mon, 11 Mar 2019 08:47:44 +0000 (UTC)
Date:   Mon, 11 Mar 2019 09:47:43 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     vbabka@suse.cz, jrdr.linux@gmail.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        shaoyafang@didiglobal.com
Subject: Re: [PATCH] mm: vmscan: show zone type in kswapd tracepoints
Message-ID: <20190311084743.GX5232@dhcp22.suse.cz>
References: <1551425934-28068-1-git-send-email-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551425934-28068-1-git-send-email-laoar.shao@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01-03-19 15:38:54, Yafang Shao wrote:
> If we want to know the zone type, we have to check whether
> CONFIG_ZONE_DMA, CONFIG_ZONE_DMA32 and CONFIG_HIGHMEM are set or not,
> that's not so convenient.
> 
> We'd better show the zone type directly.

I do agree that zone number is quite PITA to process in general but do
we really need this information in the first place? Why do we even care?

Zones are an MM internal implementation details and the more we export
to the userspace the more we are going to argue about breaking userspace
when touching them. So I would rather not export that information unless
it is terribly useful.

> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/trace/events/vmscan.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> index a1cb913..4c8880b 100644
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -73,7 +73,10 @@
>  		__entry->order	= order;
>  	),
>  
> -	TP_printk("nid=%d zid=%d order=%d", __entry->nid, __entry->zid, __entry->order)
> +	TP_printk("nid=%d zid=%-8s order=%d",
> +		__entry->nid,
> +		__print_symbolic(__entry->zid, ZONE_TYPE),
> +		__entry->order)
>  );
>  
>  TRACE_EVENT(mm_vmscan_wakeup_kswapd,
> @@ -96,9 +99,9 @@
>  		__entry->gfp_flags	= gfp_flags;
>  	),
>  
> -	TP_printk("nid=%d zid=%d order=%d gfp_flags=%s",
> +	TP_printk("nid=%d zid=%-8s order=%d gfp_flags=%s",
>  		__entry->nid,
> -		__entry->zid,
> +		__print_symbolic(__entry->zid, ZONE_TYPE),
>  		__entry->order,
>  		show_gfp_flags(__entry->gfp_flags))
>  );
> -- 
> 1.8.3.1
> 

-- 
Michal Hocko
SUSE Labs
