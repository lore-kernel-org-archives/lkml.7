Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D8DC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6C2205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="b8T1p9Ya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfEBI52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:57:28 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40002 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfEBI52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:57:28 -0400
Received: by mail-lf1-f65.google.com with SMTP id o16so1278374lfl.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 01:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AcJGzEJKvjgTm5krN5D7sGxdgNjNgaxocAX/9P/bdOw=;
        b=b8T1p9YazMcCX++tQtbU7XUF6HHYDl8X5UpxdNuLa3Osr2bjH8bpdc1xWcY8lQ0Klh
         oAyl7StdIrtl/o/sFVYI0MgEafxlvwNPk+u8n2PMlLwgZUBwj5ReHS9q+mybO1Mp7lJB
         XdOnPTQjfBRH1qyudmcauJI0lSUh//ms9ieOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AcJGzEJKvjgTm5krN5D7sGxdgNjNgaxocAX/9P/bdOw=;
        b=NZWqW7NcxXMRA9KUL/ynqLdsdhzmRLNH1T6M38PnBmynVkAiqV9kHtlu0vJ02zU0Is
         StC949u6HgEo44PAeUE/vm3YXDLup3SnfA3FMWYFOG/iBCHqA60CXkCEOqVCmHLLLovp
         mVnICGPDzYIalbGXrpNW3M68RZ2pNCGvvxQF+lTpmBG4askuA56KzmHQ28m8g3fOMbdG
         AY3yb9iag0w4vBRcHL9hx2HGfEJVZWte3AeA8FXNVFnj1CtLTGyQOfO08HQMDeTBa/7w
         CMewW0LGmPy2vFkY3Ij7iufwpLhCjDQod/BDx9WSuPY6AkBryuGSKUORYPOAmOvnDId9
         ejdA==
X-Gm-Message-State: APjAAAVKqFnYJQXSJRPgzYlPPd7wr1BAjLHsxx+J2SRGichVgQzIPf+l
        6v/xcbDjUjgAJKDlhxJdbK76eZxyxpZJF213
X-Google-Smtp-Source: APXvYqw7FZBjd6a3kkQOF5flv5TSYRYTplkliXQYoiTwQ/XqZE/8EmKNd0UNu6GKae4dE6rxkrhAtQ==
X-Received: by 2002:ac2:554a:: with SMTP id l10mr1211456lfk.45.1556787445842;
        Thu, 02 May 2019 01:57:25 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id r5sm3645295ljh.27.2019.05.02.01.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 01:57:24 -0700 (PDT)
Subject: Re: [PATCH 11/10] arm64: unbreak DYNAMIC_DEBUG=y build with clang
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>, Dan Rue <dan.rue@linaro.org>
References: <20190426130015.GA12483@archlinux-i9>
 <20190426190603.5982-1-linux@rasmusvillemoes.dk>
 <CAKwvOd=Qzs8gAenS6-GkiSmrwxwJA7wChJ6FUE5+=LPAj4XSfQ@mail.gmail.com>
 <CAKwvOdkg=Xo_C_hQrnHt-t-RfcDrBYsrBZUwsKjfXSPhkynOHQ@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <dec53053-fa42-7b9d-14c1-61357e1ecc66@rasmusvillemoes.dk>
Date:   Thu, 2 May 2019 10:57:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKwvOdkg=Xo_C_hQrnHt-t-RfcDrBYsrBZUwsKjfXSPhkynOHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2019 20.22, Nick Desaulniers wrote:
> On Mon, Apr 29, 2019 at 10:32 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>>
>> On Fri, Apr 26, 2019 at 12:06 PM Rasmus Villemoes
>> <linux@rasmusvillemoes.dk> wrote:
>>>
>>> Current versions of clang does not like the %c modifier in inline
>>> assembly for targets other than x86, so any DYNAMIC_DEBUG=y build
>>> fails on arm64. A fix is likely to land in 9.0 (see
>>> https://github.com/ClangBuiltLinux/linux/issues/456), but unbreak the
>>> build for older versions.
>>>
>>> Fixes: arm64: select DYNAMIC_DEBUG_RELATIVE_POINTERS
>>> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
>>> Reported-by: Arnd Bergmann <arnd@arndb.de>
>>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>>> ---
>>> Andrew, please apply and/or fold into 9/10.

Andrew, friendly ping.

>>>  arch/arm64/Kconfig | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index d0871d523d5d..315992e33b17 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -83,7 +83,7 @@ config ARM64
>>>         select CRC32
>>>         select DCACHE_WORD_ACCESS
>>>         select DMA_DIRECT_REMAP
>>> -       select DYNAMIC_DEBUG_RELATIVE_POINTERS
>>> +       select DYNAMIC_DEBUG_RELATIVE_POINTERS if CC_IS_GCC || CLANG_VERSION >= 90000
>>
>> I just landed the fix for this in Clang, I think around the time you
>> sent the patch.  Should ship in Clang 9.  Thanks for unbreaking our
>> build.

Sorry for breaking it in the first place :-/

Rasmus
