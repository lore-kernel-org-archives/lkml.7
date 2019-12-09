Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956D6C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6864F207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfLIOkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:40:43 -0500
Received: from mga01.intel.com ([192.55.52.88]:44217 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727300AbfLIOkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:40:42 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 06:40:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,296,1571727600"; 
   d="scan'208";a="387256605"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 09 Dec 2019 06:40:39 -0800
Received: from andy by smile with local (Exim 4.93-RC5)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ieKDH-0007XR-7G; Mon, 09 Dec 2019 16:40:39 +0200
Date:   Mon, 9 Dec 2019 16:40:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tuowen Zhao <ztuowen@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] hexagon: io: Define ioremap_uc to fix build error
Message-ID: <20191209144039.GI32742@smile.fi.intel.com>
References: <20191204133328.18668-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204133328.18668-1-linux@roeck-us.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 05:33:28AM -0800, Guenter Roeck wrote:
> ioremap_uc is now mandatory.
> 
> lib/devres.c:44:3: error: implicit declaration of function 'ioremap_uc'

Thanks for a fix!
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Fixes: e537654b7039 ("lib: devres: add a helper function for ioremap_uc")
> Cc: Tuowen Zhao <ztuowen@gmail.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/hexagon/include/asm/io.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
> index 539e3efcf39c..39e5605c5d42 100644
> --- a/arch/hexagon/include/asm/io.h
> +++ b/arch/hexagon/include/asm/io.h
> @@ -173,7 +173,7 @@ static inline void writel(u32 data, volatile void __iomem *addr)
>  
>  void __iomem *ioremap(unsigned long phys_addr, unsigned long size);
>  #define ioremap_nocache ioremap
> -
> +#define ioremap_uc ioremap
>  
>  #define __raw_writel writel
>  
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


