Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97553ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE7E21848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Jm+mF2rD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbfJIN0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:26:24 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38016 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731260AbfJIN0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:26:23 -0400
Received: by mail-lj1-f196.google.com with SMTP id b20so2493888ljj.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 06:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WJWP5QMUkAgHs6BnCYZNp8h84d1YBL5Bm1yud/rHHZg=;
        b=Jm+mF2rDsCJLcrUlB0SLiwko2Z9Ves98s22gSAsrBVZEVcVXfdwdOX7ZJbB2fF3d2T
         vKttvPExXAug4yqPWc4vwbzwUhsxX/Uy7mwYXY4KALSDq+YjoBb0exsJD8/Ho6kGT+bE
         dqiCaslb16ZKB+zIWqGcpDxrd2wnBcHzk+Hzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WJWP5QMUkAgHs6BnCYZNp8h84d1YBL5Bm1yud/rHHZg=;
        b=kjd75pw8dSas70V7mdgo00qotsGalBoNwHWaja4sZw+5okTQPepmI7zEYRsoWuFMxC
         DKR9YYjj5b9l7+YsN6m7dfElfsbMhdfqh6C3ziEHr8nIDihwZZgRkL0faRFOcpueBNKU
         vpBvgvhghxVcSXPB36+8Sm5FAoG9BSZi4NdMlmGzLzrouBcZf1tStypRc5T1P/6OnjVk
         uPkWI5aE6+0w7IIxTnKBccZSKXlvqO9YOmGwUBI+FBnKVsgwzZ/jetOx+CwUHXzVsB0b
         phuEkpB/4elAlmj1pBOjK3SUpgiGiUiF6To2o/9F9dRl1nWT0HBZmr5sfF70YDT4+HJz
         94UA==
X-Gm-Message-State: APjAAAURkVp1/Y2LXowtYEG/oI7Pq5E91zABp9o9wgWOgkA6hbpSXLsw
        DyY0+6OJVlFoQdKTxkj3FqPEcDQonPUy7Y+f
X-Google-Smtp-Source: APXvYqy4mU7KScbhHDcIf4/Gp+K03M2QERvYtcI9RxomBaOLKIoCVSOFjmrd7KC6npByX6cOnQC0jw==
X-Received: by 2002:a2e:2943:: with SMTP id u64mr2382988lje.241.1570627580325;
        Wed, 09 Oct 2019 06:26:20 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id r19sm472597ljd.95.2019.10.09.06.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 06:26:19 -0700 (PDT)
Subject: Re: [PATCH] string.h: Mark 34 functions with __must_check
To:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <954c5d70-742f-7b0e-57ad-ea967e93be89@rasmusvillemoes.dk>
Date:   Wed, 9 Oct 2019 15:26:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2019 14.14, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 9 Oct 2019 13:53:59 +0200
> 
> Several functions return values with which useful data processing
> should be performed. These values must not be ignored then.
> Thus use the annotation “__must_check” in the shown function declarations.

This _might_ make sense for those that are basically kmalloc() wrappers
in one way or another [1]. But what's the point of annotating pure
functions such as strchr, strstr, memchr etc? Nobody is calling those
for their side effects (they don't have any...), so obviously the return
value is used. If somebody does a strcmp() without using the result, so
what? OK, it's odd code that might be worth flagging, but I don't think
that's the kind of thing one accidentally adds. You're also not
consistent - strlen() is not annotated. And, for the standard C
functions, -Wall already seems to warn about an unused call:

 #include <string.h>
int f(const char *s)
{
	strlen(s);
	return 3;
}
$ gcc -Wall -o a.o -c a.c
a.c: In function ‘f’:
a.c:5:2: warning: statement with no effect [-Wunused-value]
  strlen(s);
  ^~~~~~~~~

[1] Just might. The problem is the __must_check does not mean that the
return value must be followed by a comparison to NULL and bailing out
(that can't really be checked), it simply ensures the return value is
assigned somewhere or used in an if(). So foo->bar = kstrdup() not
followed by a check of foo->bar won't warn. So one would essentially
only catch instant-leaks. __must_check is much better suited for
functions that mutate a passed-in or global object, e.g.
start_engine(engine).

Rasmus
