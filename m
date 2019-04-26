Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25B5C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C45C2067C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="J1u2eDCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfDZKGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:06:02 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37307 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfDZKGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 06:06:01 -0400
Received: by mail-lf1-f67.google.com with SMTP id h126so2053160lfh.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 03:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V6YfoSDGzpRc5jf/Ret2tebWXfDQiQOnbiio0o2ZU6E=;
        b=J1u2eDCGJ2gEioZTB921qsXqhJT6wj/kGUqepebtFVKjTSdJggMoCosui9RSYJo6Jy
         VzsD/zhtV+95zn57iya3oiKD0AoMsu7h6C9mh8KhSttxweUag0JmZFPXmZJna/iouiiu
         lNBqkaCqEeQPxhrZDX/w1tWKj3vBVlQVMS5IM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V6YfoSDGzpRc5jf/Ret2tebWXfDQiQOnbiio0o2ZU6E=;
        b=Z43ByYlPb6DCErI6qee9s9spfSmUsI/rYlM6bYHoBCo20HHcUAbFyw7Lec8rkkkC2t
         U+s6mlc5TF4PvWgkVUvwPl/Sa2J2Lqu7W6Xa6Oy/4w/wwICZc4qq6Rcx1lJT+T9SMxNl
         Iajpqg0efl4lAeQOQXQvLpJeTGbq/uMmu9zhLCNrhnugmhBbjlYknGHG09nofbsaQa2/
         pT26+B5+jTiChJzyp91xn7UmHb9CeONrKXryq/lFn+wgD7moZ9bj16kbLeyKQHyApmQc
         1kN+vAnlQbJAGgyNb4HnW5P4qUg8Lc6mZsb9s50Tx1KD0nvnmVvKm+/yQV+wWakipVMV
         m98g==
X-Gm-Message-State: APjAAAVlRfoaGCj4BAACLY8nSoQPCx4VdmJ0mzcq4OCheU8IpN4N9Eq/
        50UrniluP+WQk9lzZE3iiC+mZg==
X-Google-Smtp-Source: APXvYqyQ/3Ze+NoK18P3XhfyG2CTLYM7V7o3VpK8T6b+OrXiZ7EaMMNLhQA69cVTra4J966OKvyOOw==
X-Received: by 2002:ac2:482e:: with SMTP id 14mr21642162lft.1.1556273159457;
        Fri, 26 Apr 2019 03:05:59 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y19sm5484183lfb.24.2019.04.26.03.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 03:05:58 -0700 (PDT)
Subject: Re: [PATCH 09/10] arm64: select DYNAMIC_DEBUG_RELATIVE_POINTERS
To:     Arnd Bergmann <arnd@arndb.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
 <20190409212517.7321-10-linux@rasmusvillemoes.dk>
 <CAK8P3a1by1-ZF2NoTdGbxv+AJu92d3Sp5L08BhLCA+0PNS8s2Q@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <94b816aa-ad36-75e6-8782-d141dec2e803@rasmusvillemoes.dk>
Date:   Fri, 26 Apr 2019 12:05:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1by1-ZF2NoTdGbxv+AJu92d3Sp5L08BhLCA+0PNS8s2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2019 11.39, Arnd Bergmann wrote:
> On Tue, Apr 9, 2019 at 11:26 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> Similar to GENERIC_BUG_RELATIVE_POINTERS, one can now relativize the
>> four const char* members of struct _ddebug, thus saving 16 bytes per
>> instance (one for each pr_debug(), dev_debug() etc. in a
>> CONFIG_DYNAMIC_DEBUG kernel). The asm-generic implementation seems to
>> work out-of-the-box, though this is only compile-tested.
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> This causes a build regression when compiling with clang,
> see http://staging-storage.kernelci.org/next-clang/master/next-20190424/arm64/allmodconfig/clang-8/build.log

Yes, see also https://github.com/ClangBuiltLinux/linux/issues/456 .

The quickest short-term fix is to append "if CC_IS_GCC" to the select
statements. Then when a fix lands in clang one can change that to "if
CC_IS_GCC || CLANG_VERSION >= something". It's probably best if we fix
-next builds ASAP instead of waiting for knowing the proper value of
"something". Nathan, Nick, WDYT?

I had 0day verify my patches before sending them out officially, and
thought it also did clang builds. But apparently not, or not with enough
arch/.config combinations?

Rasmus
