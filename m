Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B9AC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3BB206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="pF/DGxdK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKNPJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 10:09:53 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:40702 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfKNPJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:09:52 -0500
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id xAEF9W9o025244;
        Fri, 15 Nov 2019 00:09:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com xAEF9W9o025244
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1573744173;
        bh=qT+oeFIy/euq0pjgKwdV5q+AmMmXgB5IsDUm3nbRMug=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pF/DGxdKF/kgm6vFSo1CHhtEqThJ5MNkv65P+tsPx1MUaA6zLRxEBfhn7EUyY0hcu
         gQwOZRtWB5zx/nE5y3Kk+QRD+0QyPVtqLygvMj+kBXYGXarkXQEKkNtGbSOKgm/L0U
         6mINbu0Tgb3RGQqfhzJ+FAZnJhyPIUi6D8+7ksyC38oXIolSbnPPY1xSa2PM0w0uGl
         yCzKotAPea5zVM/88o5t3AKHRlerOE3sOmO51b0IInIArm20mQQfgGYk35l5p556jH
         DWIlp7aJ+OaYYjlUWdn27zOxY3h8l0toqERkm7J0F1JyaSmTbdmXQGv0vxAiFMaxQs
         jpUMfjbJhT1YQ==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id i13so1960109uaq.7;
        Thu, 14 Nov 2019 07:09:32 -0800 (PST)
X-Gm-Message-State: APjAAAWBku/hg7p370pFdJ6l0eUhyB/uFJaRQTazBo1ic/TjJ92jLFQD
        LNbJJsOPPwxDKuwQP2K5OXPJcIRzGZbC7FWg/xw=
X-Google-Smtp-Source: APXvYqxP6fimCUjd9UUjSmw3gNS/GNK41A1+OJKsdwGXeZ9QlASqiVEwdOwyGiSacAGc3X2E5Gf9FatJh03k0eQJhAA=
X-Received: by 2002:a9f:262d:: with SMTP id 42mr5173143uag.109.1573744171503;
 Thu, 14 Nov 2019 07:09:31 -0800 (PST)
MIME-Version: 1.0
References: <20190922113436.10396-1-yamada.masahiro@socionext.com>
 <201911131558.6B0778229@keescook> <20191113.162157.111707512627631395.davem@davemloft.net>
In-Reply-To: <20191113.162157.111707512627631395.davem@davemloft.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 15 Nov 2019 00:08:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQtmy8p2GJooX_8dgp3ipC0Kp6x4e1tfiOay3_0qLhhvg@mail.gmail.com>
Message-ID: <CAK7LNAQtmy8p2GJooX_8dgp3ipC0Kp6x4e1tfiOay3_0qLhhvg@mail.gmail.com>
Subject: Re: [PATCH] sparc: vdso: fix build error of vdso32
To:     David Miller <davem@davemloft.net>
Cc:     Kees Cook <keescook@chromium.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Anatoly Pugachev <matorola@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 9:22 AM David Miller <davem@davemloft.net> wrote:
>
> From: Kees Cook <keescook@chromium.org>
> Date: Wed, 13 Nov 2019 15:59:27 -0800
>
> > On Sun, Sep 22, 2019 at 08:34:36PM +0900, Masahiro Yamada wrote:
> >> Since commit 54b8ae66ae1a ("kbuild: change *FLAGS_<basetarget>.o to
> >> take the path relative to $(obj)"), sparc allmodconfig fails to build
> >> as follows:
> >>
> >>   CC      arch/sparc/vdso/vdso32/vclock_gettime.o
> >> unrecognized e_machine 18 arch/sparc/vdso/vdso32/vclock_gettime.o
> >> arch/sparc/vdso/vdso32/vclock_gettime.o: failed
> >>
> >> The cause of the breakage is that -pg flag not being dropped.
> >>
> >> The vdso32 files are located in the vdso32/ subdirectory, but I missed
> >> to update the Makefile.
> >>
> >> Fixes: 54b8ae66ae1a ("kbuild: change *FLAGS_<basetarget>.o to take the path relative to $(obj)")
> >> Reported-by: Anatoly Pugachev <matorola@gmail.com>
> >> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >
> > I've tripped over this as well. Since no one has picked this up, can you
> > take it via your tree Masahiro?
>
> Yes, please do.  Sorry, I haven't had a lot of time for Sparc work lately.
>
> Acked-by: David S. Miller <davem@davemloft.net>


Applied to linux-kbuild.

-- 
Best Regards
Masahiro Yamada
