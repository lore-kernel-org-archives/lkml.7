Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF2BC282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8EA9218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556194190;
	bh=Boq9SEpDm1PmKMOHsXTxIdCNa0TvASejWmjMBuLPzEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Or0lmMKCstoF4EvUvXi98LNxewyp71rhn/dIw0M/LmGzMcRyp16WF/yYCeSo9DtVU
	 gYcxloM/xt5QAjbdZ7CSdRef5iYKbyIIcUFEYCX0OWwPfodeNlgd6zc7OeKO/6YaM1
	 jzcEw2DFNLvK+VLlU0P5XWsGQNZ+pR69KZ3dl6lI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbfDYMJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:09:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:56652 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726435AbfDYMJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:09:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5EF19AD45;
        Thu, 25 Apr 2019 12:09:46 +0000 (UTC)
Date:   Thu, 25 Apr 2019 14:09:45 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/Kconfig: update "Memory Model" help text
Message-ID: <20190425120945.GB1144@dhcp22.suse.cz>
References: <1556188531-20728-1-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556188531-20728-1-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-04-19 13:35:31, Mike Rapoport wrote:
> The help describing the memory model selection is outdated. It still says
> that SPARSEMEM is experimental and DISCONTIGMEM is a preferred over
> SPARSEMEM.
> 
> Update the help text for the relevant options:
> * add a generic help for the "Memory Model" prompt
> * add description for FLATMEM
> * reduce the description of DISCONTIGMEM and add a deprecation note
> * prefer SPARSEMEM over DISCONTIGMEM
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/Kconfig | 48 +++++++++++++++++++++++-------------------------
>  1 file changed, 23 insertions(+), 25 deletions(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 25c71eb8a7db..8f7ae4d71b77 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -11,23 +11,24 @@ choice
>  	default DISCONTIGMEM_MANUAL if ARCH_DISCONTIGMEM_DEFAULT
>  	default SPARSEMEM_MANUAL if ARCH_SPARSEMEM_DEFAULT
>  	default FLATMEM_MANUAL
> +	help
> +	  This option allows you to change some of the ways that
> +	  Linux manages its memory internally. Most users will
> +	  only have one option here selected by the architecture
> +	  configuration. This is normal.
>  
>  config FLATMEM_MANUAL
>  	bool "Flat Memory"
>  	depends on !(ARCH_DISCONTIGMEM_ENABLE || ARCH_SPARSEMEM_ENABLE) || ARCH_FLATMEM_ENABLE
>  	help
> -	  This option allows you to change some of the ways that
> -	  Linux manages its memory internally.  Most users will
> -	  only have one option here: FLATMEM.  This is normal
> -	  and a correct option.
> -
> -	  Some users of more advanced features like NUMA and
> -	  memory hotplug may have different options here.
> -	  DISCONTIGMEM is a more mature, better tested system,
> -	  but is incompatible with memory hotplug and may suffer
> -	  decreased performance over SPARSEMEM.  If unsure between
> -	  "Sparse Memory" and "Discontiguous Memory", choose
> -	  "Discontiguous Memory".
> +	  This option is best suited for non-NUMA systems with
> +	  flat address space. The FLATMEM is the most efficient
> +	  system in terms of performance and resource consumption
> +	  and it is the best option for smaller systems.
> +
> +	  For systems that have holes in their physical address
> +	  spaces and for features like NUMA and memory hotplug,
> +	  choose "Sparse Memory"
>  
>  	  If unsure, choose this option (Flat Memory) over any other.
>  
> @@ -38,29 +39,26 @@ config DISCONTIGMEM_MANUAL
>  	  This option provides enhanced support for discontiguous
>  	  memory systems, over FLATMEM.  These systems have holes
>  	  in their physical address spaces, and this option provides
> -	  more efficient handling of these holes.  However, the vast
> -	  majority of hardware has quite flat address spaces, and
> -	  can have degraded performance from the extra overhead that
> -	  this option imposes.
> +	  more efficient handling of these holes.
>  
> -	  Many NUMA configurations will have this as the only option.
> +	  Although "Discontiguous Memory" is still used by several
> +	  architectures, it is considered deprecated in favor of
> +	  "Sparse Memory".
>  
> -	  If unsure, choose "Flat Memory" over this option.
> +	  If unsure, choose "Sparse Memory" over this option.
>  
>  config SPARSEMEM_MANUAL
>  	bool "Sparse Memory"
>  	depends on ARCH_SPARSEMEM_ENABLE
>  	help
>  	  This will be the only option for some systems, including
> -	  memory hotplug systems.  This is normal.
> +	  memory hot-plug systems.  This is normal.
>  
> -	  For many other systems, this will be an alternative to
> -	  "Discontiguous Memory".  This option provides some potential
> -	  performance benefits, along with decreased code complexity,
> -	  but it is newer, and more experimental.
> +	  This option provides efficient support for systems with
> +	  holes is their physical address space and allows memory
> +	  hot-plug and hot-remove.
>  
> -	  If unsure, choose "Discontiguous Memory" or "Flat Memory"
> -	  over this option.
> +	  If unsure, choose "Flat Memory" over this option.
>  
>  endchoice
>  
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
