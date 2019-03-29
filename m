Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD77C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E43206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfC2KcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:32:04 -0400
Received: from nat.nue.novell.com ([195.135.221.2]:27746 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728703AbfC2KcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:32:04 -0400
Received: by suse.de (Postfix, from userid 1000)
        id C04684746; Fri, 29 Mar 2019 11:32:01 +0100 (CET)
Date:   Fri, 29 Mar 2019 11:32:01 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rafael@kernel.org, akpm@linux-foundation.org, mhocko@suse.com,
        rppt@linux.ibm.com, willy@infradead.org, fanc.fnst@cn.fujitsu.com
Subject: Re: [PATCH v4 2/2] drivers/base/memory.c: Rename the misleading
 parameter
Message-ID: <20190329103201.v4r74pdej4y7mecr@d104.suse.de>
References: <20190329082915.19763-1-bhe@redhat.com>
 <20190329082915.19763-2-bhe@redhat.com>
 <20190329093659.GG7627@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329093659.GG7627@MiWiFi-R3L-srv>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 05:36:59PM +0800, Baoquan He wrote:
> The input parameter 'phys_index' of memory_block_action() is actually
> the section number, but not the phys_index of memory_block. This is
> a relict from the past when one memory block could only contain one
> section.
> 
> Rename it to start_section_nr.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


> ---
>  drivers/base/memory.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index cb8347500ce2..9ea972b2ae79 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -231,13 +231,14 @@ static bool pages_correctly_probed(unsigned long start_pfn)
>   * OK to have direct references to sparsemem variables in here.
>   */
>  static int
> -memory_block_action(unsigned long phys_index, unsigned long action, int online_type)
> +memory_block_action(unsigned long start_section_nr, unsigned long action,
> +		    int online_type)
>  {
>  	unsigned long start_pfn;
>  	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
>  	int ret;
>  
> -	start_pfn = section_nr_to_pfn(phys_index);
> +	start_pfn = section_nr_to_pfn(start_section_nr);
>  
>  	switch (action) {
>  	case MEM_ONLINE:
> @@ -251,7 +252,7 @@ memory_block_action(unsigned long phys_index, unsigned long action, int online_t
>  		break;
>  	default:
>  		WARN(1, KERN_WARNING "%s(%ld, %ld) unknown action: "
> -		     "%ld\n", __func__, phys_index, action, action);
> +		     "%ld\n", __func__, start_section_nr, action, action);
>  		ret = -EINVAL;
>  	}
>  
> -- 
> 2.17.2
> 

-- 
Oscar Salvador
SUSE L3
