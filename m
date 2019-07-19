Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD4FC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 19:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23BCD2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 19:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boDlrr7C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732360AbfGSTAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 15:00:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42400 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730217AbfGSTAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 15:00:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id x1so18229948wrr.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 12:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OjBT3y0IaTj0mi7QluR2YRiH1GY4BrXcRWNycnDwyBg=;
        b=boDlrr7CFoH21qvg1/5Teuk3X1A3tK+3HTzgbX3pdma7cHA7CsmFBb0KAz33jnnnFb
         TddRkJQwlj+LcptuusZXF0YTYziP20x3Sq6z3P5IIvxnbvKU+F4o/DzaOYdeY5WjyuVy
         j32tlfmiafecndlihGNpm4FkOwBOdmtnAJKCA6m3Z54vfH8wD4hGUG6c6pfkzSXKIMpX
         p1hW7Y0OaB2tixhoTS7nHgbTfe4ehsplPSK/3GYxdeYtQvcE3QNh7P0XrCtBjsSV72rW
         fOxZFgwVvrSfwobx9nV8ME4PV3u0NEu1/t8gPo3iZed0LBMnj2EuxEd3ywb7tV64z8Re
         e5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OjBT3y0IaTj0mi7QluR2YRiH1GY4BrXcRWNycnDwyBg=;
        b=QgRsqKqW/2tVoEglsVDnU+TgAEdwoWx2prSf2Z/1eq1BMT+q91pKlC68cXPTLB6OZG
         TGCRIk/kGBtJpJdtqZj849N3aHHC6dqo8b1Y1nf/My4z14tkTyYDwHAl/vUf6oVVtH/2
         3ICSh+sigfGom/fJBJ9J5fwNUHxW/jrNMOvvDM00GKL9XCBywPPp8gkfwLQ9k9P6wNJz
         E+xppqBum5Ho7VMbBnb2/dirYYUnuuc8dqT2bOxBdGKECsjZ3/Vl1MXfg72dxttmCoaK
         DfWnMdrSSW9RDQ4CS0FM32gjK+wrPRP27xzTqgz+19Ghm9A9jTEKwyAVku1p2p7FGfl4
         FZHA==
X-Gm-Message-State: APjAAAWZ1eWST/F2U7DOe4cyAK2/jR4F14uuR0ohim0tBpscIhgQPJ/f
        SjHNck0g4MJjRIrY5HWlOe0=
X-Google-Smtp-Source: APXvYqyv+qw/F80wNWpo4e5+AhTWCt+QAd/VTzUWqR+OSqAWkeRS0lj8PjowFynbiintxTbLKQVSog==
X-Received: by 2002:a5d:514f:: with SMTP id u15mr58323856wrt.183.1563562828112;
        Fri, 19 Jul 2019 12:00:28 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id l8sm53303856wrg.40.2019.07.19.12.00.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 12:00:27 -0700 (PDT)
Date:   Fri, 19 Jul 2019 12:00:26 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] [v2] waitqueue: shut up clang -Wuninitialized warnings
Message-ID: <20190719190026.GA27734@archlinux-threadripper>
References: <20190719113638.4189771-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719113638.4189771-1-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 01:36:00PM +0200, Arnd Bergmann wrote:
> When CONFIG_LOCKDEP is set, every use of DECLARE_WAIT_QUEUE_HEAD_ONSTACK()
> produces an bogus warning from clang, which is particularly annoying
> for allmodconfig builds:
> 
> fs/namei.c:1646:34: error: variable 'wq' is uninitialized when used within its own initialization [-Werror,-Wuninitialized]
>         DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
>                                         ^~
> include/linux/wait.h:74:63: note: expanded from macro 'DECLARE_WAIT_QUEUE_HEAD_ONSTACK'
>         struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)
>                                ~~~~                                  ^~~~
> include/linux/wait.h:72:33: note: expanded from macro '__WAIT_QUEUE_HEAD_INIT_ONSTACK'
>         ({ init_waitqueue_head(&name); name; })
>                                        ^~~~
> 
> A patch for clang has already been proposed and should soon be
> merged for clang-9, but for now all clang versions produce the
> warning in an otherwise (almost) clean allmodconfig build.
> 
> Link: https://bugs.llvm.org/show_bug.cgi?id=31829
> Link: https://bugs.llvm.org/show_bug.cgi?id=42604
> Link: https://lore.kernel.org/lkml/20190703081119.209976-1-arnd@arndb.de/
> Link: https://reviews.llvm.org/D64678
> Link: https://storage.kernelci.org/next/master/next-20190717/arm64/allmodconfig/clang-8/build-warnings.log
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: given that kernelci is getting close to reporting a clean build for
>     clang, I'm trying again with a less invasive approach after my
>     first version was not too popular.
> ---
>  include/linux/wait.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index ddb959641709..276499ae1a3e 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -70,8 +70,17 @@ extern void __init_waitqueue_head(struct wait_queue_head *wq_head, const char *n
>  #ifdef CONFIG_LOCKDEP
>  # define __WAIT_QUEUE_HEAD_INIT_ONSTACK(name) \
>  	({ init_waitqueue_head(&name); name; })
> -# define DECLARE_WAIT_QUEUE_HEAD_ONSTACK(name) \
> +# if defined(__clang__) && __clang_major__ <= 9

Might look cleaner if we used CONFIG_CC_IS_CLANG and
CONFIG_CLANG_VERSION but I have no strong opinion.

It works as is, I checked clang-9, clang-10, and GCC 9.1.0.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
