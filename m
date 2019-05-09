Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD961C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FD42177B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cEmfOBgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfEIQwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 12:52:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41334 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfEIQwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 12:52:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id z3so1501421pgp.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 09:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aVeDGqfbT0YGG1y1uT4kmEchoYa9pupr9YpNC6PdnA4=;
        b=cEmfOBgAi+j3wDMyN2HuQ8YOAyEOvblZNzvn4ss1G8HyoBp6uVkeWdDSKXx1VxS3/Q
         y/d9aZeJg9/MJ9Ryz+ewFOxRPwSVlr6YDx4ROjWLeIf6DpZVCWcDflTo2N9G/HCo6uVj
         Ev3q2WToDXYuTcB7vEYj04kGomUTNvSQhRKBefDilB4iThJ7Q6wdXhIRywnj0NJDhBaZ
         flyWYM53ifjnS0gFNtReN2FpfRdHTzbLKtaR0r8v+xksDe3G8/TnFB0f6x8ZEiqB5NvI
         EYa/elhvhyMawxgPw7Ur0eAmRofJTpshP2GkQ9cjE6Z3Wsj+AILirPuWKgAh5+u6xkMm
         GG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aVeDGqfbT0YGG1y1uT4kmEchoYa9pupr9YpNC6PdnA4=;
        b=s5hxD0eFOEzD6xcxx8zMKA6SRSuPfH0YvLy39+uAYumbekyIJTaY0yoWIMRU4dZHWu
         cs+sy/uaelf8xx4+3fLepLkYnVkHhEjxbVa7A32X+HulJOSMcCqoFuxGblsC8Ak8trlU
         VPKxoa/bHetVEpL/NChaxbA0wB+Zm/SdIIkjuVUrEJU6/OBgiUPL1zTjrJB4LPBTEU3H
         Q7ZuxVK9MHvdywYmBwmNYwexn2Yd60WLlAje29TuZSmhWrYvWAD+bNQILnIWbG5c7806
         ymZxucXD4HI6yGN9iln0sL9anaDikBoUv8bwOdUx7HkPr6uRXsI46i1ZxksAvwokBM8z
         NnhA==
X-Gm-Message-State: APjAAAU0ltPKS1lPMX4uuOExMHhTIcgXsVkw8VnVMfU+prnqPGFz1Uk9
        rUoVDsE2JJCtH4/RQQyHLOEtTpe5Uu0LXwaIUi1xzLnQSVg=
X-Google-Smtp-Source: APXvYqwilvKZBerd/RIiPZ0wRdI5EOy9Y7Ffui3bXF5SQ9uDUWYuz7xExBnRYaOSy7gRyxeb4muNbUsVaVXCNgub+fI=
X-Received: by 2002:a62:704a:: with SMTP id l71mr6797419pfc.32.1557420729060;
 Thu, 09 May 2019 09:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190509064549.1302-1-yamada.masahiro@socionext.com> <CAGXu5jKDELCthqEcnL3TvC8DtMnfoWnOd14wrKpcReUxubdMCg@mail.gmail.com>
In-Reply-To: <CAGXu5jKDELCthqEcnL3TvC8DtMnfoWnOd14wrKpcReUxubdMCg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 9 May 2019 09:51:57 -0700
Message-ID: <CAKwvOd=cbvYyVPcGYweMbPDM5WpBtZr8tOQgHu9BJiGqoq4RDg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: add -Wvla flag unconditionally
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michal Marek <michal.lkml@markovi.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, May 8, 2019 at 11:46 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> > This flag is documented in the GCC 4.6 manual, and recognized by
> > Clang as well. Let's rip off the cc-option switch.

Checked w/ godbolt w/ Clang 4 and GCC 4.6.4.
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
