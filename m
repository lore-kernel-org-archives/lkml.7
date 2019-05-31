Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC56DC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 12:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BDBD23B19
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 12:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiAqc2Xw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfEaMFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 08:05:38 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44412 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfEaMFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 08:05:38 -0400
Received: by mail-qt1-f194.google.com with SMTP id x47so432321qtk.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 05:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9KPOVLmvvXsL0gadrSnIAU8IhtKcTnY8xUtv7zMmXgc=;
        b=iiAqc2XwnJTkxShtC/LJ/WSt2853Dw1d0SxOZh+nPklnIHaqr1WqcM85MGdIN9Vzic
         4cJZ0cFWsyZ5TkpMKTNdwmW7P/WKWgnd0YD1elFyvn/x3WsfC2wEq1aOl+RSnXpMU7BZ
         kOBJqAQGUor4vEpnbnJkcpskdzMW1MbOTn9ouGCb7ev2G7wLuCtNVsPQ7UaviJYnYqs0
         wvLfHO6PJtmzGmpFCWrcJIbvoRdMygFv6trt/WCqiVGVQKLy/BopImHRlpG+m8w+tlPH
         q19aimwxEIRxYAWjkzujUS5OnzNcs9iuyVeANfXtUxMzig1loRHvg6pvlX/nyq9ZIgYt
         eHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9KPOVLmvvXsL0gadrSnIAU8IhtKcTnY8xUtv7zMmXgc=;
        b=jPjp+86hZY8+jar1dh+ODoIj8rgPSad0w9UOiYWAkhPmXFdDCY5ho9c9KHjDnXgl67
         k358imaRNQda1/IIdiZJ7C6vOCrawjyAh+3IcwLCkiWHlY9xCbPffapdEuk7pHFZaov2
         OwfYIuSNq2Mb+HmY3oYErjVrww+TUJo8T7xJl+/fUxawRngHhKDmH+U3r0mH6jkCLuPP
         daJzRyyEPVpH1+CKDOHnOp3yoF4ki0foaZDin7+lr+km0kKL7B+4A3xygfCAUJs08w6q
         D7yaDwWwG0q8nSCiv7wleC2Wp3AjaFeuK5+h8wYPQUB/bhwFX8f78enZntbUUEoJTcZk
         FwSg==
X-Gm-Message-State: APjAAAVbeM7oRNA4UXdXVK3RnROVoQQ1U88oa62CHiNqg7nw5r/CqwnI
        lB/+a0r19a4Jp1vebpXamCk=
X-Google-Smtp-Source: APXvYqya/MH/Akz3FKT9TqrNrQp1/JhULWBSJRJ1AQ1+Q0o/LoNG45Oko6ub/K418mzvSvJW5T5Tcw==
X-Received: by 2002:ac8:21bc:: with SMTP id 57mr8491674qty.73.1559304337082;
        Fri, 31 May 2019 05:05:37 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id 6sm3525057qtt.72.2019.05.31.05.05.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 05:05:36 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2A3D841149; Fri, 31 May 2019 09:05:30 -0300 (-03)
Date:   Fri, 31 May 2019 09:05:30 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Ben Gainey <ben.gainey@arm.com>,
        Stephane Eranian <eranian@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf jvmti: Fix gcc string overflow warning
Message-ID: <20190531120530.GB17152@kernel.org>
References: <20190531080307.22628-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190531080307.22628-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 31, 2019 at 10:03:07AM +0200, Jiri Olsa escreveu:
> We are getting fake gcc warning when we compile with gcc9 (9.1.1):
> 
>      CC       jvmti/libjvmti.o
>    In file included from /usr/include/string.h:494,
>                     from jvmti/libjvmti.c:5:
>    In function ‘strncpy’,
>        inlined from ‘copy_class_filename.constprop’ at jvmti/libjvmti.c:166:3:
>    /usr/include/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ specified bound depends on the length of the source argument [-Werror=stringop-overflow=]
>      106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>          |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    jvmti/libjvmti.c: In function ‘copy_class_filename.constprop’:
>    jvmti/libjvmti.c:165:26: note: length computed here
>      165 |   size_t file_name_len = strlen(file_name);
>          |                          ^~~~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors
> 
> First I wanted to disable the check, but now I think the code
> could be more straight forward. There's no need to check the
> source size, strncpy will do that. We just need to make sure
> the string is correctly terminated.
> 
> Cc: Ben Gainey <ben.gainey@arm.com>
> Cc: Stephane Eranian <eranian@google.com>
> Link: http://lkml.kernel.org/n/tip-sve3b63c550wr907e6ui6gx5@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/jvmti/libjvmti.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
> index aea7b1fe85aa..00fa0b7f1ad9 100644
> --- a/tools/perf/jvmti/libjvmti.c
> +++ b/tools/perf/jvmti/libjvmti.c
> @@ -162,8 +162,8 @@ copy_class_filename(const char * class_sign, const char * file_name, char * resu
>  		result[i] = '\0';
>  	} else {
>  		/* fallback case */
> -		size_t file_name_len = strlen(file_name);
> -		strncpy(result, file_name, file_name_len < max_length ? file_name_len : max_length);
> +		strncpy(result, file_name, max_length - 1);
> +		result[max_length - 1] = 0;

The usual idiom here, if we stay with strncpy is:

		strncpy(result, file_name, max_length - 1)[max_length - 1] = 0;

one line instead of two, but there are other possibilities, what I've
done int these cases in tools/perf/ is to switch to strlcpy, so just
flip that 'n' to a 'l' and it should be enough.

For that we just have a copy of the kernel's strlcpy() implementation in
lib/string.c, and it has this doc:

/**
 * strlcpy - Copy a C-string into a sized buffer
 * @dest: Where to copy the string to
 * @src: Where to copy the string from
 * @size: size of destination buffer
 *
 * Compatible with ``*BSD``: the result is always a valid
 * NUL-terminated string that fits in the buffer (unless,
 * of course, the buffer size is zero). It does not pad
 * out the result like strncpy() does.
 */

The kernel folks moved beyond that and in lib/string.c we have:

/**
 * strscpy - Copy a C-string into a sized buffer
 * @dest: Where to copy the string to
 * @src: Where to copy the string from
 * @count: Size of destination buffer
 *
 * Copy the string, or as much of it as fits, into the dest buffer.  The
 * behavior is undefined if the string buffers overlap.  The destination
 * buffer is always NUL terminated, unless it's zero-sized.
 *
 * Preferred to strlcpy() since the API doesn't require reading memory
 * from the src string beyond the specified "count" bytes, and since
 * the return value is easier to error-check than strlcpy()'s.
 * In addition, the implementation is robust to the string changing out
 * from underneath it, unlike the current strlcpy() implementation.
 *
 * Preferred to strncpy() since it always returns a valid string, and
 * doesn't unnecessarily force the tail of the destination buffer to be
 * zeroed.  If zeroing is desired please use strscpy_pad().
 *
 * Return: The number of characters copied (not including the trailing
 *         %NUL) or -E2BIG if the destination buffer wasn't big enough.
 */
ssize_t strscpy(char *dest, const char *src, size_t count)



I think for these needs flipping that 'n' into a 'l' is good enough.

- Arnaldo

>  	}
>  }
>  
> -- 
> 2.21.0

-- 

- Arnaldo
