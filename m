Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC54C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 11:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783F820645
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 11:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556971052;
	bh=nWpIszXTY5++UVi7bCuG+Qw2x3pMchtxOj43BXp2/L8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mVvi8sSJOcekDB3jfsHtQTkKp++yln8ChWeEFrUrNBfZjnjWO6WdlOhuZ/jmxVWay
	 3m2ImtrTtZc/WRikOnE/R/f0njhiG1cVUzfbQwYnjuz6lsbwytcVIdBZGaJx/VbAh6
	 XQlOQfNybeZsoil7npyRTIqi14ft3Nh9ZJs1/9Bs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfEDLyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 07:54:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:57566 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727266AbfEDLyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 07:54:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8C168AC4A;
        Sat,  4 May 2019 11:54:48 +0000 (UTC)
Date:   Sat, 4 May 2019 07:54:46 -0400
From:   Michal Hocko <mhocko@kernel.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory.c: Make __thp_get_unmapped_area static
Message-ID: <20190504115446.GP29835@dhcp22.suse.cz>
References: <20190504102353.GA22525@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190504102353.GA22525@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 04-05-19 15:53:54, Bharath Vedartham wrote:
> __thp_get_unmapped_area is only used in mm/huge_memory.c. Make it
> static.

Makes sense. Looks like an omission.

> Tested by building and booting the kernel.

Testing by git grep __thp_get_unmapped_area would give you a better
picture. Build test migh not hit paths that are config specific and
static aspect of a functions should not have any functionality related
side effects AFAICS.
 
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/huge_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 165ea46..75fe2b7 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -509,7 +509,7 @@ void prep_transhuge_page(struct page *page)
>  	set_compound_page_dtor(page, TRANSHUGE_PAGE_DTOR);
>  }
>  
> -unsigned long __thp_get_unmapped_area(struct file *filp, unsigned long len,
> +static unsigned long __thp_get_unmapped_area(struct file *filp, unsigned long len,
>  		loff_t off, unsigned long flags, unsigned long size)
>  {
>  	unsigned long addr;
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
