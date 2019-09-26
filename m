Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2217EC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6B0222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="d7KxK0sC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbfIZIvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 04:51:16 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36013 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfIZIvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 04:51:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id v24so1310160ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 01:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JxTQ4Xr3344cpWCG4BIW/1ZqVwik7sHCKiCTOE2X9m4=;
        b=d7KxK0sCAAvz6z6Y8/K09q831hikJED/i8jll4bvn33Ys1TzPK/1bPUSAbJeeZTEWU
         uVlRKsN5TIDvkYtTaSbySKPWBn2tBkB9jCWPz2EGcVuwRVsw3t3O/McRsLnocDiEewNh
         Fl1fBmxfKpOeIzHAZxfu7QTM+DZ2L1UikE3bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JxTQ4Xr3344cpWCG4BIW/1ZqVwik7sHCKiCTOE2X9m4=;
        b=GtqPcu1r/BPB1q+6AdphEjNhQatVa5g/DKGeJ/FuqIRz7EWlAnz8OyJItV3AYq1amE
         LDCEtCZZzRqNQQgoTc3qTXQpF7stxcjAQkmSO7HCvjf0uR82nJoiEG2Cqo6MEA3RkdT2
         7hyVrCp+/x7VyQY7GzMEwBrMvPMZy+sDjLreV3MRQB8ThDybeNyyymYYBuoWC7Oe/yyb
         rgTK06e0lyqbcw3D27pXOGLPJzNfcwtIZtdV+zC69HRvnIoDKhXpSX/u+WFgQ/8SYlKn
         LCVpf/dxbv4H60r5SfLMfD5Wo88FuSF/49y9nBc0Qu9wqJSeGImTvLLs5chlLNnaL/VS
         sGRA==
X-Gm-Message-State: APjAAAXmKO7PoNfHCSVxVlXfac+raiErHIxjStB6v//hdxbKPxsrgwN9
        xvnUkVxSQ7H3+AWxeeJTQ/r6sw==
X-Google-Smtp-Source: APXvYqzssLLp7ITRItmffAgBPI/U1AAur6UajisezavY9OYf/UxAeld/gv0f7dgMumw1Ows7Xglchg==
X-Received: by 2002:a2e:808c:: with SMTP id i12mr1775624ljg.78.1569487871273;
        Thu, 26 Sep 2019 01:51:11 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id t27sm393173lfl.48.2019.09.26.01.51.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 01:51:10 -0700 (PDT)
Subject: Re: [PATCH V2 1/2] string: Add stracpy and stracpy_pad mechanisms
To:     Stephen Kitt <steve@sk2.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Nitin Gote <nitin.r.gote@intel.com>, jannh@google.com,
        kernel-hardening@lists.openwall.com, Takashi Iwai <tiwai@suse.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        alsa-devel@alsa-project.org
References: <cover.1563889130.git.joe@perches.com>
 <ed4611a4a96057bf8076856560bfbf9b5e95d390.1563889130.git.joe@perches.com>
 <20190925145011.c80c89b56fcee3060cf87773@linux-foundation.org>
 <c0c2b8f6ac9f257b102b5a1a4b4dc949@sk2.org>
 <8039728c-b41d-123c-e1ed-b35daac68fd3@rasmusvillemoes.dk>
 <24bb53c57767c1c2a8f266c305a670f7@sk2.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f257526e-7d6e-6665-b539-da113b0f83ba@rasmusvillemoes.dk>
Date:   Thu, 26 Sep 2019 10:51:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <24bb53c57767c1c2a8f266c305a670f7@sk2.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2019 10.25, Stephen Kitt wrote:
> Le 26/09/2019 09:29, Rasmus Villemoes a écrit :
>> On 26/09/2019 02.01, Stephen Kitt wrote:
>>> Le 25/09/2019 23:50, Andrew Morton a écrit :
>>>> On Tue, 23 Jul 2019 06:51:36 -0700 Joe Perches <joe@perches.com> wrote:
>>>>
>>
>> Please don't. At least not for the cases where the source is a string
>> literal - that just gives worse code generation (because gcc doesn't
>> know anything about strscpy or strlcpy), and while a run-time (silent)
>> truncation is better than a run-time buffer overflow, wouldn't it be
>> even better with a build time error?
> 
> Yes, that was the plan once Joe's patch gets merged (if it does), and my
> patch was only an example of using stracpy, as a step on the road. I was
> intending to follow up with a patch converting stracpy to something like
> https://www.openwall.com/lists/kernel-hardening/2019/07/06/14
> 
> __FORTIFY_INLINE ssize_t strscpy(char *dest, const char *src, size_t count)
> {
>     size_t dest_size = __builtin_object_size(dest, 0);
>     size_t src_size = __builtin_object_size(src, 0);
>     if (__builtin_constant_p(count) &&
>         __builtin_constant_p(src_size) &&
>         __builtin_constant_p(dest_size) &&

Eh? Isn't the output of __builtin_object_size() by definition a
compile-time constant - whatever the compiler happens to know about the
object size (or a sentinel 0 or -1 depending on the type argument)?

> 
> #define stracpy(dest, src)                        \
> ({                                    \
>     size_t count = ARRAY_SIZE(dest);                \
>     size_t dest_size = __builtin_object_size(dest, 0);        \
>     size_t src_size = __builtin_object_size(src, 0);        \
>     BUILD_BUG_ON(!(__same_type(dest, char[]) ||            \
>                __same_type(dest, unsigned char[]) ||        \
>                __same_type(dest, signed char[])));        \
>                                     \
>     (__builtin_constant_p(count) &&                    \
>      __builtin_constant_p(src_size) &&                \
>      __builtin_constant_p(dest_size) &&                \
>      src_size <= count &&                        \
>      src_size <= dest_size &&                    \
>      src[src_size - 1] == '\0') ?                    \
>         (((size_t) strcpy(dest, src)) & 0) + src_size - 1    \
>     :                                \
>         strscpy(dest, src, count);                \
> })
> 
> and both of these get optimised to movs when copying a constant string
> which fits in the target.

But does it catch the case of overflowing a char[] member in a struct
passed by reference at build time? I'm surprised that
__builtin_object_size(dest, 0) seems to be (size_t)-1, when dest is
s->name (with struct s { char name[4]; };). So I'm not very confident
that any of the fancy fortify logic actually works here - we _really_
should have some Kbuild infrastructure for saying "this .c file should
not compile" so we can test that the fortifications actually work in the
simple and common cases.

> I was going at this from the angle of improving the existing APIs and
> their resulting code.

I'm not against stracpy() as a wrapper for strscpy(), but we should make
sure that whenever we can fail at build time (i.e., both source and dst
lengths known), we do - and in that case also let the compiler optimize
the copy (not only to do the immediate movs, but that also gives it
wider opportunity to remove it completely as dead stores if the
surrounding code ends up dead - with a call to some strscpy(), gcc
cannot eliminate that). If stracpy() can be made sufficiently magic that
it fails at build time for the string literal cases, fine, let's not add
yet another API. Otherwise, I think the static_strcpy() is a much more
readable and reliable API for those cases.

If I'm reading your stracpy() macro correctly, you're explicitly
requesting a run-time truncation (the src_size <= dest_size check
causing as to fall back to strscpy) rather than failing at build time.

Rasmus
