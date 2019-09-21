Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71768C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 00:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBE32086A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 00:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hhdDkdje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407389AbfIUAWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 20:22:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48722 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405111AbfIUAWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 20:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4PchiSSViLW0r0Wt7nbJES5Bs28WkfeH74BkpFQR7sc=; b=hhdDkdje1aiOmtMCxZAD0kSz+
        /p3p3wKvpUQ4U/Ug5RGlBwHwUeM8tXo40vjPS0di+woN2Nm6GDe0LDI+SFGd6yhGS986KctAxVui1
        dQQvhrm/dV6Wfq86S4yEh5OIXsmcg2bXJIu1UDKsmHj3+KTqEvMVmorqTjouGt7oRY0asF/piWpYg
        ZtLoQT4kcSsdO356zvaY+P6V+hHtGXOzkiEMAxVTI0D9/cHLM6r12Gy9ILuNOLhWwfxSIWpf/pbMT
        DA4qBn9AI6siLgmKHz3SOH5ij2J3sZqAt2d+Qi5jvhy8HlJPl9uLOumQu1cj4pqYo5DnlkyNJSLOR
        u4jJe5BXw==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iBTAf-0007TQ-QH; Sat, 21 Sep 2019 00:22:41 +0000
Subject: Re: [RFC v2] zswap: Add CONFIG_ZSWAP_IO_SWITCH to handle swap IO
 issue
To:     Hui Zhu <teawaterz@linux.alibaba.com>, sjenning@redhat.com,
        ddstreet@ieee.org, akpm@linux-foundation.org, mhocko@suse.com,
        willy@infradead.org, chris@chris-wilson.co.uk, hannes@cmpxchg.org,
        ziqian.lzq@antfin.com, osandov@fb.com, ying.huang@intel.com,
        aryabinin@virtuozzo.com, vovoy@chromium.org,
        richard.weiyang@gmail.com, jgg@ziepe.ca, dan.j.williams@intel.com,
        rppt@linux.ibm.com, jglisse@redhat.com, b.zolnierkie@samsung.com,
        axboe@kernel.dk, dennis@kernel.org, josef@toxicpanda.com,
        tj@kernel.org, oleg@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <1568961307-32419-1-git-send-email-teawaterz@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fa3dcc32-e120-52a5-2365-68e55df1f1d9@infradead.org>
Date:   Fri, 20 Sep 2019 17:22:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568961307-32419-1-git-send-email-teawaterz@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/19 11:35 PM, Hui Zhu wrote:
> This is the second version of this patch.  The previous version is in
> https://lkml.org/lkml/2019/9/11/935
> I updated the commit introduction and Kconfig  because it is not clear.
> 
Hi,
Just a few minor fixes (below):

> 
> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
> ---
>  include/linux/swap.h |  3 +++
>  mm/Kconfig           | 18 +++++++++++++++++
>  mm/page_io.c         | 16 +++++++++++++++
>  mm/zswap.c           | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 92 insertions(+)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 56cec63..5408d65 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -546,6 +546,24 @@ config ZSWAP
>  	  they have not be fully explored on the large set of potential
>  	  configurations and workloads that exist.
>  
> +config ZSWAP_IO_SWITCH
> +	bool "Compressed cache for swap pages according to the IO status"
> +	depends on ZSWAP
> +	def_bool n

Just drop the "def_bool n".  It's already a "bool" and 'n' is the default value for it.

> +	help
> +	  This function help the system that normal swap speed is higher

	                helps the system in which normal swap speed is higher

> +	  than zswap speed to handle the swap IO issue.
> +	  For example, a VM that is disk device is not set cache config or

possibly:
	  For example, a VM where the disk device is not set for cache config or

> +	  set cache=writeback.
> +
> +	  This function make zswap just work when the disk of the swap file

	  This function makes

> +	  is under high IO load.
> +	  It add two parameters read_in_flight_limit and write_in_flight_limit to

	  It adds two parameters (read_in_flight_limit and write_in_flight_limit) to

> +	  zswap.  When zswap is enabled, pages will be stored to zswap only
> +	  when the IO in flight number of swap device is bigger than

	                               of the swap device

> +	  zswap_read_in_flight_limit or zswap_write_in_flight_limit.
> +	  If unsure, say "n".
> +
>  config ZPOOL
>  	tristate "Common API for compressed memory storage"
>  	help

> diff --git a/mm/zswap.c b/mm/zswap.c
> index 0e22744..1255645 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -62,6 +62,13 @@ static u64 zswap_reject_compress_poor;
>  static u64 zswap_reject_alloc_fail;
>  /* Store failed because the entry metadata could not be allocated (rare) */
>  static u64 zswap_reject_kmemcache_fail;
> +#ifdef CONFIG_ZSWAP_IO_SWITCH
> +/* Store failed because zswap_read_in_flight_limit or
> + * zswap_write_in_flight_limit is bigger than IO in flight number of
> + * swap device
> + */

Please use the documented multi-line comment format.  E.g.:

/*
 * Store failed because zswap_read_in_flight_limit or
 * zswap_write_in_flight_limit is bigger than IO in flight number of
 * swap device.
 */

> +static u64 zswap_reject_io;
> +#endif
>  /* Duplicate store was encountered (rare) */
>  static u64 zswap_duplicate_entry;
>  
> @@ -114,6 +121,22 @@ static bool zswap_same_filled_pages_enabled = true;
>  module_param_named(same_filled_pages_enabled, zswap_same_filled_pages_enabled,
>  		   bool, 0644);
>  
> +#ifdef CONFIG_ZSWAP_IO_SWITCH
> +/* zswap will not try to store the page if zswap_read_in_flight_limit is
> + * bigger than IO read in flight number of swap device
> + */

Use documented multi-line comment format.

> +static unsigned int zswap_read_in_flight_limit;
> +module_param_named(read_in_flight_limit, zswap_read_in_flight_limit,
> +		   uint, 0644);
> +
> +/* zswap will not try to store the page if zswap_write_in_flight_limit is
> + * bigger than IO write in flight number of swap device
> + */

ditto.

thanks.
-- 
~Randy
