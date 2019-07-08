Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777DBC606AF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B872064B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbfGHNCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:02:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:50744 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727601AbfGHNCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:02:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5D13BAFC4;
        Mon,  8 Jul 2019 13:02:00 +0000 (UTC)
Date:   Mon, 8 Jul 2019 15:01:59 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mans Rullgard <mans@mansr.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kernel.h: Update comment about
 simple_strto<foo>() functions
Message-ID: <20190708130159.whefdhz4d65exdns@pathway.suse.cz>
References: <20190704115532.15679-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704115532.15679-1-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-07-04 14:55:31, Andy Shevchenko wrote:
> There were discussions in the past about use cases for
> simple_strto<foo>() functions and, in some rare cases,
> they have a benefit over kstrto<foo>() ones.
> 
> Update a comment to reduce confusion about special use cases.
> 
> Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> - update comment based on Geert's input
>  include/linux/kernel.h | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 0c9bc231107f..63663c44933d 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -332,8 +332,7 @@ int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
>   * @res: Where to write the result of the conversion on success.
>   *
>   * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
> - * Used as a replacement for the obsolete simple_strtoull. Return code must
> - * be checked.
> + * Used as a replacement for the simple_strtoull. Return code must be checked.
>  */
>  static inline int __must_check kstrtoul(const char *s, unsigned int base, unsigned long *res)
>  {
> @@ -361,8 +360,7 @@ static inline int __must_check kstrtoul(const char *s, unsigned int base, unsign
>   * @res: Where to write the result of the conversion on success.
>   *
>   * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
> - * Used as a replacement for the obsolete simple_strtoull. Return code must
> - * be checked.
> + * Used as a replacement for the simple_strtoull. Return code must be checked.
>   */
>  static inline int __must_check kstrtol(const char *s, unsigned int base, long *res)
>  {
> @@ -438,7 +436,16 @@ static inline int __must_check kstrtos32_from_user(const char __user *s, size_t
>  	return kstrtoint_from_user(s, count, base, res);
>  }
>  
> -/* Obsolete, do not use.  Use kstrto<foo> instead */
> +/*
> + * Use kstrto<foo> instead.
> + *
> + * NOTE: The simple_strto<foo> does not check for overflow and,
> + *	 depending on the input, may give interesting results.

I am a bit confused whether the interesting results are caused
by the buffer overflow or if there is another reason.

If it is because of the overflow, I would remove the 2nd line. I guess
that anyone knows what a buffer overflow might cause.

Otherwise the patch looks fine to me.

Best Regards,
Petr
