Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC95CFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 08:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE0421882
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 08:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="T4/hkniH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbfKHIu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 03:50:56 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38898 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfKHIu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 03:50:56 -0500
Received: by mail-ot1-f65.google.com with SMTP id v24so4576084otp.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 00:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S85cv+dFRN5SsgvHSORQbdSIxYwn0oEGmdvNGbJesco=;
        b=T4/hkniHISxhKLviDVpNOrLIS3abyDnRgQR27nInQ39mJfNwJk6aSi5flcSy0a8nff
         3EVQJqEWux4tnPaNvTFjGU804fkSgk03TkvJIB91ggXPxGE/QseehJlvvX3Wdh6LZwjp
         1+s29e2NxGZKY/UG6nJYehPsF14x3szH0Mc2OGM37sGXTYhBlQcBo9W6F1NLNYH+YRXk
         4aNgnF7AL3sbmok1Mh3XwPia/IoVoiPw/0g9GsSVOW7NaC/Psni09+17MkYXZWKAiDUv
         GkR2xO3Ivjq9DY8E6c/kirvfYFyu0j5XZmUyO3abzIhBmN5WSAa3e2eNqgXn1LoTnLsg
         2kEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S85cv+dFRN5SsgvHSORQbdSIxYwn0oEGmdvNGbJesco=;
        b=fYK4kueNXChZtZaDr6PQ/SD4gYfyl37gReKHGTfpT7YIrsmeZ2YNIvGTIohF7C/1Z0
         ia0LxG94G4rwCu+TOhwLUacgnhTrRw/ObpIWk7U6e6/zdsBflXi2fPzZUiwlk0gH/SZX
         yIPp6HrZyNI74KwLGNC7TQyLONLYOhM5TgkNvwZBvkxIJ1IaycNf/bg3/TbPcmy7Zw82
         nfvgLsN0hF1lTtVlfNnXT7uS6i0ntLc+facBG0eIkPVw62IKLiRaMER8bD9bfqsUL8yV
         T4OZZwrxIJjCwz6wUAA1UWaNBYh+Wqx7bcfEz10aM4cCxY2A2nFDvERsqbtZzDDPz6Vr
         5K2A==
X-Gm-Message-State: APjAAAWGj+RRGvUzEAXOSDB9rLwvr9WawaYThiiBjcdJq6ul4sfMnGXU
        XdYLXJLt0b7edQm1t4o0Y0qMcWOPPev7QHPPqPksQw==
X-Google-Smtp-Source: APXvYqzvFWycGq+rgNWjzjUl8DaEflPl0cye1A5IDVDIfB+L9OLXtWK4iNaOX6xH2U0TJB9gdbn8KheZwxW1Z0UDGy4=
X-Received: by 2002:a05:6830:2106:: with SMTP id i6mr2362173otc.75.1573203055439;
 Fri, 08 Nov 2019 00:50:55 -0800 (PST)
MIME-Version: 1.0
References: <1572920412-15661-1-git-send-email-zong.li@sifive.com> <20191108072523.GA20338@infradead.org>
In-Reply-To: <20191108072523.GA20338@infradead.org>
From:   Zong Li <zong.li@sifive.com>
Date:   Fri, 8 Nov 2019 16:50:44 +0800
Message-ID: <CANXhq0qr-hsaJUaQ_nToyMv2sJHDUnHrernqYFV1Q90Uek6XxQ@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: Use PMD_SIZE to repalce PTE_PARENT_SIZE
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 3:25 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Nov 04, 2019 at 06:20:12PM -0800, Zong Li wrote:
> >       uintptr_t map_size = PAGE_SIZE;
> >
> > -     /* Upgrade to PMD/PGDIR mappings whenever possible */
> > -     if (!(base & (PTE_PARENT_SIZE - 1)) &&
> > -         !(size & (PTE_PARENT_SIZE - 1)))
> > -             map_size = PTE_PARENT_SIZE;
> > +     /* Upgrade to PMD_SIZE mappings whenever possible */
> > +     if (!(base & (PMD_SIZE - 1)) &&
> > +         !(size & (PMD_SIZE - 1)))
> > +             map_size = PMD_SIZE;
>
> The check easily fits onto a single line now.  Also the map_size
> variable is rather pointless.  Why not:
>
>         if ((base & (PMD_SIZE - 1) || (size & (PMD_SIZE - 1)))
>                 return PAGE_SIZE;
>         return PMD_SIZE;

Yes, Use positive representation is more clear to me. Change it in next version.
