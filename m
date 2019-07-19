Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAD0C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 18:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090562084D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 18:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gznuTwuf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731596AbfGSSX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 14:23:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42652 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729446AbfGSSX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 14:23:28 -0400
Received: by mail-pl1-f193.google.com with SMTP id ay6so16019051plb.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 11:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2YU8DTjyy8eQnNRmlMpHI4dE8EXYO0RN+2/iEJZ71QI=;
        b=gznuTwufJV76J3Rt/qXTirRRummP0bqeDQgbZ8OYO+Ma4m/LyiOWn1oHJWFFrKlYc5
         7hFsqX76GQn3GJqqK61nMHvU4pt3bi6tkNG5NGdYvkq0XyZCFyO77w2hxvL3Mlj0dNic
         DB0Jmt+nWkxh2NfRs6B31kqJD3mMf6lUvFMFAtNiEvlxb9sbc4Cg+9C9du/+GLmHG7/0
         2gWecjd98OnVs/TIaaCQ2wisiunrrpDAps3IJnldrZaSWZm/bTaB7vS0kIcjMl49BQab
         LElkT2Wbu6WAPH3DPHo2AfBaKFwkRr5LNHoaGugtz3uWHRV5onLd0v2PfeLkwN8gd/+s
         o+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2YU8DTjyy8eQnNRmlMpHI4dE8EXYO0RN+2/iEJZ71QI=;
        b=Eh3tDGnNVH4GRyyy0xMknFnR6/0uj2n+1dwJ4PxWc9iOKnQuoCoq+qgc0tHnaygCl5
         bNZ5xyLjKkq8FW7AgRaHpng3CxzRj51/wA50M5FW2mFS0Eg3pt5KrrKQbl2AnPo30la+
         2TNsumcqQ8BrccAUvUodwopi9zfracV0saXDJu3OYSu/8NnrmkvkrR1ZFvWVQbNH0ilq
         He6M9uNYWbmfBxVCfUNkHSEn7AuLrRSRSLJsKKzhPd4Z7PrRl+KkCBXtamZuaKkvEFfC
         c6YdcPBeHpLgAWcnNkqHyel1ILQn1EmdUGuDzY4qbkM3qx0zYLeT43DTOWndxh9isBkm
         eVfw==
X-Gm-Message-State: APjAAAW5DKuJz4Dyztxq7A0viLsoSmQ/rPuO0NmS2XzdKp30H5/1Q/Fe
        58WUonJ6LfEwp9YcEhHIENcXkBovwYks9KZgati0Nw==
X-Google-Smtp-Source: APXvYqy2PoKyd4BXKOEFi8QBzMaDJ20Dzb7OS8AIobWPto0GkLuVemrAN9YP3qauEs/2eFvjCglyCNyL8iqzE8wNQe0=
X-Received: by 2002:a17:902:9f93:: with SMTP id g19mr57804425plq.223.1563560607118;
 Fri, 19 Jul 2019 11:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a12cVdrEXdgWkHGHP6O04mz5khaB7WgQ1nvOptaUTu_SA@mail.gmail.com>
In-Reply-To: <CAK8P3a12cVdrEXdgWkHGHP6O04mz5khaB7WgQ1nvOptaUTu_SA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 19 Jul 2019 11:23:16 -0700
Message-ID: <CAKwvOdmoD1wVFLdWRXTA=c-p4oc6HDxsfhXq5wQpD-8oFUfNNQ@mail.gmail.com>
Subject: Re: warning: objtool: fn1 uses BP as a scratch register
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 11:10 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> A lot of objtool fixes showed up in linux-next, so I looked at some
> remaining ones.
> This one comes a lot up in some configurations
>
> https://godbolt.org/z/ZZLVD-
>
> struct ov7670_win_size {
>   int width;
>   int height;
> };
> struct ov7670_devtype {
>   struct ov7670_win_size *win_sizes;
>   unsigned n_win_sizes;
> };
> struct ov7670_info {
>   int min_width;
>   int min_height;
>   struct ov7670_devtype devtype;
> } a;
> int b;
> int fn1() {
>   struct ov7670_info c = a;
>   int i = 0;
>   for (; i < c.devtype.n_win_sizes; i++) {
>     struct ov7670_win_size d = c.devtype.win_sizes[i];
>     if (c.min_width && d.width < d.height < c.min_height)
>       if (b)
>         return 0;
>   }
>   return 2;
> }
>
> $ clang-8 -O2 -fno-omit-frame-pointer -fno-strict-overflow -c ov7670.i
> $ objtool check  --no-unreachable --uaccess ov7670.o
> ov7670.o: warning: objtool: fn1 uses BP as a scratch register

Thanks for the report and reduced test case.  From the godbolt link, I
don't see %rbp, %ebp, %bp, or %bpl being referenced (other that %rbp
in the typical epilogue).  Am I missing something? Is objtool maybe
not reporting the precise function at fault?
-- 
Thanks,
~Nick Desaulniers
