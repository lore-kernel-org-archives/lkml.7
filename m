Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30784C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53192084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g5ZZ7Icj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfDBVkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:40:39 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:44009 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfDBVkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:40:39 -0400
Received: by mail-vk1-f193.google.com with SMTP id s63so634093vkg.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LX8kUzOaHxHTzkRPmHJmLool6PxekiwIJ46DJSVJBNc=;
        b=g5ZZ7Icjpc/UeXuKV8fIT4NQhbym6dSVYmPVjBQuMhtnPgikSRquP7YXMxyfmaCqtp
         7dOsPO/YLaOwWPpZ3z1dFn6UBS4vUo/0MdiUsCgDoQI/QqBi5TGk+FfOqung6am0txiu
         NiHmxw3+hpAM5SNHMVPCBdIWdpf84035tPXd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LX8kUzOaHxHTzkRPmHJmLool6PxekiwIJ46DJSVJBNc=;
        b=AzXmOpShKHumMUoxILi4KO+rI6tOtfwLIvYUHgS2JoP3UVMh+lVqbFjFnnL4+1sSxl
         8TzRqiPozhHvuoAGdKlqXf2cq3p75Gh5GTlN3CPfga8e14TPJR/MC0BdtvLZ5jgVpQD4
         pvK8/T5hW27XGs7i7mCh18UVJlwMZbMPlurJAe71s5//ls/wlKgXba9O28dVR/rwGllQ
         lVMKDuEtX7NWB0illcKvvVaLNoNWLGhXITX/uFA4JSXKEE4oaBnckJfYZas3g8XLuvaL
         5x/FnlPyaK9rW00DU0nxLy8Es5/Ywe4cgDHpXqa/txY8v/2tjtKuNMm3Ak7JvpttM40/
         GkJg==
X-Gm-Message-State: APjAAAXYy+TvCZ2udHap7aF9BNpV1NyEc6PjCSCymLV+aqXNu8S7E1zX
        9A0RrCEQcIC/KLbHvBucqcP+Be/JuTM=
X-Google-Smtp-Source: APXvYqyw6DcLnO/MGrMkXFtmsDd//vljaLUHpv7g1v0Kczld3ubIhadFMxlLssENgm7JUFqbZkXoCQ==
X-Received: by 2002:a1f:8101:: with SMTP id c1mr34202402vkd.55.1554241237993;
        Tue, 02 Apr 2019 14:40:37 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id 187sm11361893vku.45.2019.04.02.14.40.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 14:40:37 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id c6so4910196uan.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:40:37 -0700 (PDT)
X-Received: by 2002:ab0:a97:: with SMTP id d23mr37644264uak.99.1554240913430;
 Tue, 02 Apr 2019 14:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190306214226.14598-1-tobin@kernel.org> <20190306214226.14598-7-tobin@kernel.org>
In-Reply-To: <20190306214226.14598-7-tobin@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 2 Apr 2019 14:35:02 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+4hxuOcrm5mqHuUS4TfLZRrR7+uEUOr9YKsK7sAWJJ8A@mail.gmail.com>
Message-ID: <CAGXu5j+4hxuOcrm5mqHuUS4TfLZRrR7+uEUOr9YKsK7sAWJJ8A@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] lib/string: Add strscpy_pad() function
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Micay <danielmicay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 1:43 PM Tobin C. Harding <tobin@kernel.org> wrote:
>
> We have a function to copy strings safely and we have a function to copy
> strings and zero the tail of the destination (if source string is
> shorter than destination buffer) but we do not have a function to do
> both at once.  This means developers must write this themselves if they
> desire this functionality.  This is a chore, and also leaves us open to
> off by one errors unnecessarily.
>
> Add a function that calls strscpy() then memset()s the tail to zero if
> the source string is shorter than the destination buffer.
>
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>

Lovely. :)

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/string.h |  4 ++++
>  lib/string.c           | 47 +++++++++++++++++++++++++++++++++++-------
>  2 files changed, 44 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 7927b875f80c..bfe95bf5d07e 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -31,6 +31,10 @@ size_t strlcpy(char *, const char *, size_t);
>  #ifndef __HAVE_ARCH_STRSCPY
>  ssize_t strscpy(char *, const char *, size_t);
>  #endif
> +
> +/* Wraps calls to strscpy()/memset(), no arch specific code required */
> +ssize_t strscpy_pad(char *dest, const char *src, size_t count);
> +
>  #ifndef __HAVE_ARCH_STRCAT
>  extern char * strcat(char *, const char *);
>  #endif
> diff --git a/lib/string.c b/lib/string.c
> index 38e4ca08e757..3a3353512184 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -159,11 +159,9 @@ EXPORT_SYMBOL(strlcpy);
>   * @src: Where to copy the string from
>   * @count: Size of destination buffer
>   *
> - * Copy the string, or as much of it as fits, into the dest buffer.
> - * The routine returns the number of characters copied (not including
> - * the trailing NUL) or -E2BIG if the destination buffer wasn't big enough.
> - * The behavior is undefined if the string buffers overlap.
> - * The destination buffer is always NUL terminated, unless it's zero-sized.
> + * Copy the string, or as much of it as fits, into the dest buffer.  The
> + * behavior is undefined if the string buffers overlap.  The destination
> + * buffer is always NUL terminated, unless it's zero-sized.
>   *
>   * Preferred to strlcpy() since the API doesn't require reading memory
>   * from the src string beyond the specified "count" bytes, and since
> @@ -173,8 +171,10 @@ EXPORT_SYMBOL(strlcpy);
>   *
>   * Preferred to strncpy() since it always returns a valid string, and
>   * doesn't unnecessarily force the tail of the destination buffer to be
> - * zeroed.  If the zeroing is desired, it's likely cleaner to use strscpy()
> - * with an overflow test, then just memset() the tail of the dest buffer.
> + * zeroed.  If zeroing is desired please use strscpy_pad().
> + *
> + * Return: The number of characters copied (not including the trailing
> + *         %NUL) or -E2BIG if the destination buffer wasn't big enough.
>   */
>  ssize_t strscpy(char *dest, const char *src, size_t count)
>  {
> @@ -237,6 +237,39 @@ ssize_t strscpy(char *dest, const char *src, size_t count)
>  EXPORT_SYMBOL(strscpy);
>  #endif
>
> +/**
> + * strscpy_pad() - Copy a C-string into a sized buffer
> + * @dest: Where to copy the string to
> + * @src: Where to copy the string from
> + * @count: Size of destination buffer
> + *
> + * Copy the string, or as much of it as fits, into the dest buffer.  The
> + * behavior is undefined if the string buffers overlap.  The destination
> + * buffer is always %NUL terminated, unless it's zero-sized.
> + *
> + * If the source string is shorter than the destination buffer, zeros
> + * the tail of the destination buffer.
> + *
> + * For full explanation of why you may want to consider using the
> + * 'strscpy' functions please see the function docstring for strscpy().
> + *
> + * Return: The number of characters copied (not including the trailing
> + *         %NUL) or -E2BIG if the destination buffer wasn't big enough.
> + */
> +ssize_t strscpy_pad(char *dest, const char *src, size_t count)
> +{
> +       ssize_t written;
> +
> +       written = strscpy(dest, src, count);
> +       if (written < 0 || written == count - 1)
> +               return written;
> +
> +       memset(dest + written + 1, 0, count - written - 1);
> +
> +       return written;
> +}
> +EXPORT_SYMBOL(strscpy_pad);
> +
>  #ifndef __HAVE_ARCH_STRCAT
>  /**
>   * strcat - Append one %NUL-terminated string to another
> --
> 2.20.1
>


-- 
Kees Cook
