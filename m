Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D4FC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63551218EA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="RRbq2pjM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390640AbfGWOhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 10:37:06 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33937 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbfGWOhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 10:37:05 -0400
Received: by mail-lf1-f66.google.com with SMTP id b29so22288281lfq.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 07:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YBcNl1Cx1gVNSGn+Kq9310BI1gMrWUUWqNCvZ/2rb/s=;
        b=RRbq2pjMpXvz9KgvzBNVhBIj6k2ETFnueG4QX8xDJ5WLNruHjwz1L6JINxAG0AoLtJ
         c5QjfhUPBMbc9oGLYyjKO+/cooINg5BDHACf/+q6fNCge217NgFndpxjTo7RrTxBPoZw
         anV3B+QvbgTWq3vsY28TiRMC7b7EwF4WtpagU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YBcNl1Cx1gVNSGn+Kq9310BI1gMrWUUWqNCvZ/2rb/s=;
        b=ntNyad2yITLzZ51Fo8cix5BTT4pC0gyMz2DhIXiDPym52yEw+j2PrLU07+hy6XmU9C
         skY2hu5jSI7/TD9wvPhwZs0oU2h0OVHWm93BRVw1kkIe4hG4bNVZuU6JeeKweH9/3q8j
         wuu0SshfWY0T8S4EWdo1uif5pbAL/RU8bHkC/CgbGOFsfKtOyczUfwlIbl0j7ShT2luI
         g/VDTFlPArLYC8ME45dvZ3kI8RtADRbiS1L1tY7L/Uec2gnS24kWC3+3nbKteZAWmjdx
         ZlaeDiAGFyOQLx+IbVVrXcbI8RKbzwFqd+m4Hwu5HKaci1NKHNtb/YUSLYLoi5Q6UwPp
         WpSQ==
X-Gm-Message-State: APjAAAXApbf3gD0xqZTdfTx46u5iZMjHPaxxU3Tng8NrLchXMmOjWC6C
        up9rUxlZYjulHlO/FgUrT4Q=
X-Google-Smtp-Source: APXvYqzh3QhbGRFuTVqjNmfeVm8I4Q8Oe5n8SjeNL4DVCXX34MRoWq5JCbYU1iJqo5oVGl3DEjonGQ==
X-Received: by 2002:ac2:43cf:: with SMTP id u15mr23454716lfl.188.1563892623570;
        Tue, 23 Jul 2019 07:37:03 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id e13sm8107351ljg.102.2019.07.23.07.37.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 07:37:03 -0700 (PDT)
Subject: Re: [PATCH V2 1/2] string: Add stracpy and stracpy_pad mechanisms
To:     Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Stephen Kitt <steve@sk2.org>,
        Kees Cook <keescook@chromium.org>,
        Nitin Gote <nitin.r.gote@intel.com>, jannh@google.com,
        kernel-hardening@lists.openwall.com,
        Andrew Morton <akpm@linux-foundation.org>
References: <cover.1563889130.git.joe@perches.com>
 <ed4611a4a96057bf8076856560bfbf9b5e95d390.1563889130.git.joe@perches.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <ce1320d8-60df-7c54-2348-6aabac63c24d@rasmusvillemoes.dk>
Date:   Tue, 23 Jul 2019 16:37:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <ed4611a4a96057bf8076856560bfbf9b5e95d390.1563889130.git.joe@perches.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2019 15.51, Joe Perches wrote:
> Several uses of strlcpy and strscpy have had defects because the
> last argument of each function is misused or typoed.
> 
> Add macro mechanisms to avoid this defect.
> 
> stracpy (copy a string to a string array) must have a string
> array as the first argument (dest) and uses sizeof(dest) as the
> count of bytes to copy.
> 
> These mechanisms verify that the dest argument is an array of
> char or other compatible types like u8 or s8 or equivalent.

Sorry, but "compatible types" has a very specific meaning in C, so
please don't use that word. And yes, the kernel disables -Wpointer-sign,
so passing an u8* or s8* when strscpy() expects a char* is silently
accepted, but does such code exist?

> 
> V2: Use __same_type testing char[], signed char[], and unsigned char[]
>     Rename to, from, and size, dest, src and count

count is just as bad as size in terms of "the expression src might
contain that identifier". But there's actually no reason to even declare
a local variable, just use ARRAY_SIZE() directly as the third argument
to strscpy().

Rasmus
