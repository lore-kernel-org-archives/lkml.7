Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF23FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6E521928
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E48lPBM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406322AbfJPQbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 12:31:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41514 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406230AbfJPQbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:31:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id t10so11507716plr.8;
        Wed, 16 Oct 2019 09:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aHC7OwfdC69Z0KRAD+EWnIiG2rdK2yJfrgEFtsnvF8U=;
        b=E48lPBM/GDUuCdynE2UEkg7yX49YTZcF5OqjdTVOP9SiJNY+ZujZMbUE90ye3ksyQ/
         YDCtB/yqcCRv4RDgJxUgDF8vhl+TVJ1tXctryqdVmztCt8tUnlvbmlMDSnrG9FTKrZvw
         Zx54sUV4sVKIDiugH6R6sLNC0QXuOL2viU/6b2RD6/lql6lF379288QSLxCpKSO6VF3w
         ftBqPY/NZ7eLUjqtxo5MjhXaiDMFAx514sjsUN7CSECDWZDpkjHh/SBZoWllkWrpAo5e
         HpGERD9oTgia0mBK7wqPwYfmNuRvvbfenqmTvqMU3fllA92M/51VZJ7JK5BruqctJGPv
         jbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aHC7OwfdC69Z0KRAD+EWnIiG2rdK2yJfrgEFtsnvF8U=;
        b=spnIj1LcESNdwQCLx+HvyaEpWHmYvBgaHyjtd7y4pVnsiI5YAOvQcr72Ko7lPNEAsY
         PhrJA3Z267E70UBK3EgOU0iuU0jBMErtMh1lCV0EeTO7Jx4Dqz6hEy1WQS/kVsruTXaj
         2jO38Zb/NqEOnyXfxTdWtxz9bc/FGdPFZz8M2/WzXuhNjylIaPTLItELc2FGfC2r2lkG
         nVM8NFOnmkEb/Ez/yfbXQ6wR/Ea9RTj/qghbOHDHC6EIyF5ICRkESydlBXDUVfk5YYUM
         RQk1PFgOh1ozfNhHb/9e+QXzHvTisSjkAQh8rT6i7/ezYkHIjUi+PmORVdsoxGbLx5YS
         N7Xg==
X-Gm-Message-State: APjAAAXHPGDt1oydYpzPqn8JEs66umTnMYqLyZuwQQzUCZusVG4GiHsS
        fzXMHhvgE9AMgmcFFZvV5R+9HOL0PDiPaNnho/WOe3pKJrk=
X-Google-Smtp-Source: APXvYqzx702VXN+99c52whUHecV++KxTcIcFpsFjpjarNg/Zf7s6rhzu2f+htUnApjpSM789BvbMpxZTZ9v7vhRCViQ=
X-Received: by 2002:a17:902:bc48:: with SMTP id t8mr41500626plz.255.1571243505005;
 Wed, 16 Oct 2019 09:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191011133617.9963-1-linux@rasmusvillemoes.dk>
 <20191015190706.15989-1-linux@rasmusvillemoes.dk> <CAHp75Vcw9Wn6a2VEhQ00o1FZq=egtiQGjC1=uX1J71wQ9pf-pw@mail.gmail.com>
 <20191016145208.dqvquyw2m4o5skbz@pathway.suse.cz>
In-Reply-To: <20191016145208.dqvquyw2m4o5skbz@pathway.suse.cz>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 16 Oct 2019 19:31:33 +0300
Message-ID: <CAHp75Vdov2m5hb9ot3A8paPvUCympmktYtW9A5QEZ2TdBX_1Xw@mail.gmail.com>
Subject: Re: [PATCH v5] printf: add support for printing symbolic error names
To:     Petr Mladek <pmladek@suse.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joe Perches <joe@perches.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 5:52 PM Petr Mladek <pmladek@suse.com> wrote:
>
> On Wed 2019-10-16 16:49:41, Andy Shevchenko wrote:
> > On Tue, Oct 15, 2019 at 10:07 PM Rasmus Villemoes
> > <linux@rasmusvillemoes.dk> wrote:
> >
> > > +const char *errname(int err)
> > > +{
> > > +       const char *name = __errname(err > 0 ? err : -err);
> >
> > Looks like mine comment left unseen.
> > What about to simple use abs(err) here?
>
> Andy, would you want to ack the patch with this change?
> I could do it when pushing the patch.

Looks good to me.
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
> Otherwise, it looks ready to go.
>
> Thanks everybody involved for the patience.



-- 
With Best Regards,
Andy Shevchenko
