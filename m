Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38514C10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 03:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0934C2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 03:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfDLDBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 23:01:24 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:39943 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfDLDBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 23:01:24 -0400
X-Originating-IP: 50.39.168.148
Received: from localhost (50-39-168-148.bvtn.or.frontiernet.net [50.39.168.148])
        (Authenticated sender: josh@joshtriplett.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id C44CDE0004;
        Fri, 12 Apr 2019 03:01:14 +0000 (UTC)
Date:   Thu, 11 Apr 2019 20:01:12 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Changbin Du <changbin.du@intel.com>
Subject: Re: [PATCH v4 1/5] init: Introduce DEBUG_MISC option
Message-ID: <20190412030111.GA1577@localhost>
References: <20190412014355.25307-1-okaya@kernel.org>
 <20190412014355.25307-2-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412014355.25307-2-okaya@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 01:43:51AM +0000, Sinan Kaya wrote:
> Introduce DEBUG_MISC ("Miscellaneous debug code that should be under a more
> specific debug option but isn't"), make it depend on DEBUG_KERNEL and be
> "default DEBUG_KERNEL" but allow itself to be turned off, and then
> mechanically change the small handful of "#ifdef CONFIG_DEBUG_KERNEL" to
> "#ifdef CONFIG_DEBUG_MISC".
> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>

Minor typo below; with that:
Reviewed-by: Josh Triplett <josh@joshtriplett.org>

And thank you!

> ---
>  lib/Kconfig.debug | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 0d9e81779e37..2f80ebaa6d9a 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -438,6 +438,15 @@ config DEBUG_KERNEL
>  	  Say Y here if you are developing drivers or trying to debug and
>  	  identify kernel problems.
>  
> +config DEBUG_MISC
> +	bool "Miscellaneous debug code"
> +	default DEBUG_KERNEL
> +	depends on DEBUG_KERNEL
> +	help
> +	  Say Y here if you need to enable Miscellaneous debug code that should

Nit: s/Miscellaneous/miscellaneous/

> +	  be under a more specific debug option but isn't.
> +
> +
>  menu "Memory Debugging"
>  
>  source "mm/Kconfig.debug"
> -- 
> 2.21.0
> 
