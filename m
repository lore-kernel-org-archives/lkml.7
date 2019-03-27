Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBB2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55AC3204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfC0Mx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:53:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:60416 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726312AbfC0Mx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:53:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 86259AD63;
        Wed, 27 Mar 2019 12:53:56 +0000 (UTC)
Date:   Wed, 27 Mar 2019 13:53:56 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] lib/vsprintf: Make use of fwnode API to obtain node
 names and separators
Message-ID: <20190327125356.s7hockgf5yfyhx52@pathway.suse.cz>
References: <20190322152930.16642-1-sakari.ailus@linux.intel.com>
 <20190322152930.16642-5-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322152930.16642-5-sakari.ailus@linux.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-03-22 17:29:29, Sakari Ailus wrote:
> Instead of implementing our own means of discovering parent nodes, node
> names or counting how many parents a node has, use the newly added
> functions in the fwnode API to obtain that information.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  lib/vsprintf.c | 37 +++++++++++++++----------------------
>  1 file changed, 15 insertions(+), 22 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 5f60b8d41277..91f2a3e4892e 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -37,6 +37,7 @@
>  #include <net/addrconf.h>
>  #include <linux/siphash.h>
>  #include <linux/compiler.h>
> +#include <linux/property.h>
>  #ifdef CONFIG_BLOCK
>  #include <linux/blkdev.h>
>  #endif
> @@ -1720,32 +1721,23 @@ char *flags_string(char *buf, char *end, void *flags_ptr, const char *fmt)
>  	return format_flags(buf, end, flags, names);
>  }
>  
> -static const char *device_node_name_for_depth(const struct device_node *np, int depth)
> -{
> -	for ( ; np && depth; depth--)
> -		np = np->parent;
> -
> -	return kbasename(np->full_name);
> -}
> -
>  static noinline_for_stack
> -char *device_node_gen_full_name(const struct device_node *np, char *buf, char *end)
> +char *fwnode_gen_full_name(struct fwnode_handle *fwnode, char *buf, char *end)

I first read this as fwnode_get_full_name(), see "get" vs. "gen".
I guess that it was because there is used also fwnode_get_name().

Please, rename it to fwnode_full_name_string() or so ;-)

Best Regards,
Petr
