Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C1CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4DA72085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="oCGunGSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfCYG7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:59:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46572 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbfCYG7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:59:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id o1so8679578wrs.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 23:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N0CZYjFXovkJsI/9QEDEPROJKfnrmM28A3Czk4ehuJA=;
        b=oCGunGSmmKDA7JdBCm21Xfd24OkSiuyoChBtmXQSA0fFH1TA0D6VZO2PDlmV1/l6aK
         KQB5BNj+8oIIQcYDfjkJ0t/+gKH3I6voTzNPzmWWMcMGifAhJH1ZMd14bbrSNyEZ7mEI
         hvIcELpCx40jr36iuwJrcAvzU474eJRwOq5r15NMR6I9ZUYSb8Gq8eey2im2B17M/Gkf
         Y/b6qFt6RmmdI0NHLxVQ1KwmttoG6WE5YDUE2iw4OC2gPHuiBV7xczemJluS2vKmg9Xt
         Czo45n4CATD2SS4QHRbNpbIRhG9gkK9e8eExInjJcVhVC0lGLrlYaW/wLI+5rf+P1Zer
         Zs6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N0CZYjFXovkJsI/9QEDEPROJKfnrmM28A3Czk4ehuJA=;
        b=AyhGitabRINDRE7J3sx/hzh6tUbKtv5DyB2ob3SUzVThFDqHPtoO6zle6hQxSrqXXl
         bS6Rx5+Jv6+i+E6+2flxDdzKn1aVfN2hlDf8KXhfwzqMQjkBeUDzw42nrAH8fhz0y/jz
         yI8XYaACZyi/b7CNKSr/j/iBijv+oKea1/Z4osvSMGHWTFtAJdoyUBtQ9z6X8IghlvV2
         8CLJ8u8GWYV8eDAa1fRbTiMoeRb9LdpFICbNKk99I3NOR0WRf2ukNzpiCqjDtwkkeXay
         xZZxlgovsNxuiJTriZVwgUiIeYD/Q/JGuKc+AnNFi+nbezAUWH4VJ42wi9rcS06Ez6E+
         /T3Q==
X-Gm-Message-State: APjAAAVpvkPXdyTEB+4O/fqKWgqSaqNkWRYq8prNf9WC+ge8nGm1u6bV
        xglheoKpbwxqyncH6Dje5yyEnaP8kksECIG7/Q4XKQ==
X-Google-Smtp-Source: APXvYqwMP0b7DlWO+/dhfW/YQnyEJ21Adkz/UN4gTLLrK6iNKZm8O5Cl6rk8oezwxe6PDMvpukqZYQth97p/WtVvueA=
X-Received: by 2002:a5d:4087:: with SMTP id o7mr2766082wrp.9.1553497151665;
 Sun, 24 Mar 2019 23:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190325033648.16171-1-anup.patel@wdc.com> <20190325052550.GA30996@andestech.com>
In-Reply-To: <20190325052550.GA30996@andestech.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 25 Mar 2019 12:29:00 +0530
Message-ID: <CAAhSdy1wZB-A9Gon5=X21Hnf59hGktggO1f0iERq9eC6Zz-JCQ@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Always compile mm/init.c with cmodel=medany
To:     Alan Kao <alankao@andestech.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 10:56 AM Alan Kao <alankao@andestech.com> wrote:
>
> Hi Anup,
>
> Sorry for being late to the party.  I think one more thing should
> move together with setup_vm():
>
> On Mon, Mar 25, 2019 at 03:37:38AM +0000, Anup Patel wrote:
> > The Linux RISC-V 32bit kernel is broken after we moved setup_vm() from
> > kernel/setup.c to mm/init.c because Linux RISC-V 32bit kernel by default
> > uses cmodel=medlow which results in a non-position-independent setup_vm().
> >
> > This patch fixes Linux RISC-V 32bit kernel booting by:
> > 1. Forcing cmodel=medany for mm/init.c
> > 2. Moving remaing MM-related stuff va_pa_offset, pfn_base and
> >    empty_zero_page from kernel/setup.c to mm/init.c
> >
> > Fixes: 6f1e9e946f0b ("RISC-V: Move setup_vm() to mm/init.c")
> > Suggested-by: Christoph Hellwig <hch@lst.de>
> > Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> > v2: Removed CFLAGS_setup.o from kernel/Makefile and replaced SoBs
> > ---
> >  arch/riscv/kernel/Makefile | 2 --
> >  arch/riscv/kernel/setup.c  | 8 --------
> >  arch/riscv/mm/Makefile     | 2 ++
> >  arch/riscv/mm/init.c       | 9 +++++++++
> >  4 files changed, 11 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index f13f7f276639..8b9780b6bd7f 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
>
> earlier in this file, there are four lines about ftrace,
>
>   5 ifdef CONFIG_FTRACE
>   6 CFLAGS_REMOVE_ftrace.o = -pg
>   7 CFLAGS_REMOVE_setup.o = -pg
>   8 endif
>
> removing "-pg" flag from setup.o was necessary for ftrace to work, since
> setup_vm() cannot process the trampoline of ftrace properly.
>
> As setup_vm() is being moved to mm/init.c, you may either mark it with a
> "notrace" attribute with its declaration, or adding corresponding CFLAGS_REMOVE*
> to mm/Makefile.

Let's handle it in same way as it was handled for kernel/setup.o

Most of the stuff is already moved to mm/init.c so no need for
"CFLAGS_REMOVE_setup.o = -pg"

I will send-out v3 with above changes and also update patch description
accordingly.

Regards,
Anup
