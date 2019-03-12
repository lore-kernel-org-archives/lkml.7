Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ABCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E5D20657
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552407430;
	bh=QoIQn2kvJq08K8pZbEVuAhWc69BZ8y1i1Wa0T3DgTlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x11mEMftexx2zPC73Nv/QI1rgAaXwkraNOK5Mgxel7O3dFkaBLHf5h7Z1WNmmSGIH
	 zETTOc8ex1pCHnHDfDXn8ly7xMt5jH8loN8cIwn8Mg+ZJrAoMyJPGB6G7tC8DL0+ip
	 DWe6MSUzyYY9egn4exdYAuzEjE6Jkpsd8G1r0MAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfCLQRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:17:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:52132 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725894AbfCLQRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:17:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 25416AC3C;
        Tue, 12 Mar 2019 16:17:07 +0000 (UTC)
Date:   Tue, 12 Mar 2019 17:17:05 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     vbabka@suse.cz, jrdr.linux@gmail.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        shaoyafang@didiglobal.com
Subject: Re: [PATCH] mm: compaction: show gfp flag names in
 try_to_compact_pages tracepoint
Message-ID: <20190312161705.GB5721@dhcp22.suse.cz>
References: <1551501538-4092-1-git-send-email-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551501538-4092-1-git-send-email-laoar.shao@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 02-03-19 12:38:57, Yafang Shao wrote:
> show the gfp flag names instead of the gfp_mask could make the trace
> more convenient.

Agreed

> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/trace/events/compaction.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/compaction.h b/include/trace/events/compaction.h
> index 6074eff..e66afb818 100644
> --- a/include/trace/events/compaction.h
> +++ b/include/trace/events/compaction.h
> @@ -189,9 +189,9 @@
>  		__entry->prio = prio;
>  	),
>  
> -	TP_printk("order=%d gfp_mask=0x%x priority=%d",
> +	TP_printk("order=%d gfp_mask=%s priority=%d",
>  		__entry->order,
> -		__entry->gfp_mask,
> +		show_gfp_flags(__entry->gfp_mask),
>  		__entry->prio)
>  );
>  
> -- 
> 1.8.3.1
> 

-- 
Michal Hocko
SUSE Labs
