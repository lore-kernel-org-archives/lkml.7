Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7752C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9092147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfDCLW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 07:22:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:3200 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfDCLW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 07:22:27 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2019 04:22:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,304,1549958400"; 
   d="scan'208";a="147673504"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga002.jf.intel.com with ESMTP; 03 Apr 2019 04:22:24 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hBdyI-0001dH-7l; Wed, 03 Apr 2019 14:22:22 +0300
Date:   Wed, 3 Apr 2019 14:22:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Mike Travis <travis@sgi.com>, Yury Norov <ynorov@marvell.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] lib: rework bitmap_parselist
Message-ID: <20190403112222.GR9224@smile.fi.intel.com>
References: <20190403044540.16322-1-ynorov@marvell.com>
 <20190403044540.16322-3-ynorov@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403044540.16322-3-ynorov@marvell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 07:45:37AM +0300, Yury Norov wrote:
> Remove __bitmap_parselist helper and split the function to logical
> parts.

>  /**
> - * __bitmap_parselist - convert list format ASCII string to bitmap
> - * @buf: read nul-terminated user string from this buffer
> - * @buflen: buffer size in bytes.  If string is smaller than this
> - *    then it must be terminated with a \0.
> - * @is_user: location of buffer, 0 indicates kernel space
> + * bitmap_parselist - convert list format ASCII string to bitmap

> + * @buf: read user string from this buffer; must be terminated
> + * with a \0 or \n.

It's still good idea to put line continuation with deeper level of
indentation.

>   * @maskp: write resulting mask here
>   * @nmaskbits: number of bits in mask to be written
>   *
> @@ -498,127 +619,38 @@ EXPORT_SYMBOL(bitmap_print_to_pagebuf);
>   *
>   * Returns: 0 on success, -errno on invalid input strings. Error values:
>   *
> - *   - ``-EINVAL``: second number in range smaller than first
> + *   - ``-EINVAL``: wrong region format
>   *   - ``-EINVAL``: invalid character in string
>   *   - ``-ERANGE``: bit number specified too large for mask
> + *   - ``-EOVERFLOW``: integer overflow in the input parameters
>   */

-- 
With Best Regards,
Andy Shevchenko


