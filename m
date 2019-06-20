Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053F7C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB5C206E0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7KQnw6/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731932AbfFTNKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 09:10:53 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41249 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfFTNKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 09:10:52 -0400
Received: by mail-lf1-f66.google.com with SMTP id 136so2394577lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 06:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3R8g4P26UIPbxa2jL7jXQ1Hl0lmGg7Sw8gg5ZFkQV2E=;
        b=E7KQnw6/zwAMJbhbi0bJ+j/IYPpL/UFkUyxxFqY3N2j6Rmtzs5XvTiseAES9ui0Ly4
         6JPZdQbMC6uK5QjWchSP9gwOcZo0XBPXQz9h3cQJ4wYAr0RUPt6uqlVQT4L1VhBJ/39L
         60SmrcwSyFK7AZ4lzDIgyPPJT8FBhoRMVRqjVLc+Wg6aNcBD35coI2bbIKNn9DHJzIMk
         tvyzUGcrdta9VFw+annMiI7+kFyW5OXKHdvCzYM4v7B9IFIEqXtg2g3OVJ259i7xTuOR
         q7SRQKxZBnhfR69YgG+8IP9gE1jCON2Jiu33aAi4QcsH6Ob6GgFNjN58ck1+AiR5YCx1
         WDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3R8g4P26UIPbxa2jL7jXQ1Hl0lmGg7Sw8gg5ZFkQV2E=;
        b=ILn1XIYbO+NK/YFF9sxebdKdk1jbNWTP1x/vPtFy7BKyTJFQJ712UdAdiB7QNdANU0
         z0HDRlNjiQ9gVSRd2lzWScFSwh43nI4nQOGlWJ2t4bX2LGDSfXi1Zt/0ik17OcgJFBNw
         POhT1x4mP7zeEe7MXR/JxmLd1pTaV8JAxcaHZBG76ZqrZwdIV7KKkXt3HPOGLiamFA9S
         XDe77rd2/oUkVlu5sCD9+LXnAhZSrg7Cyqp7tmKmDQxbqGXeovMzPGRmH2AGIN8au8nm
         GCHCGiyTxlrKyLaMPkEAZm5kV6ejJvhs7zD0KdAM6Se5No4JCubMsg8Zop8p5fLGA5fE
         hX1g==
X-Gm-Message-State: APjAAAUEW+7gGRq2rnWibkuisijlHd8c7rLNebNL5A00+s2KT/5zMf3p
        g5y6+ohfzI7ARTOXHoEV/8osI4Inin03w0PbOXE=
X-Google-Smtp-Source: APXvYqxdpbDjHR9y63Rn6bPvqSJZkL4Hgw1c/hiaobsdflntg7lb7BdbmvMR9BBPHaguUIi252wbG/oDRVrD4IfWKS0=
X-Received: by 2002:a19:d5:: with SMTP id 204mr63936539lfa.66.1561036250966;
 Thu, 20 Jun 2019 06:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <1558887028-4026-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1558887028-4026-1-git-send-email-jrdr.linux@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 20 Jun 2019 15:10:39 +0200
Message-ID: <CANiq72m538x8=eCq78sUC2T1_US7Ddbh4O96G1-vD3yaF6wgUQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] auxdisplay/cfag12864bfb.c: Convert to use vm_map_pages_zero()
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2019 at 6:05 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> While using mmap, the incorrect values of length and vm_pgoff are
> ignored and this driver goes ahead with mapping cfag12864b_buffer
> to user vma.
>
> Convert vm_insert_pages() to use vm_map_pages_zero(). We could later
> "fix" these drivers to behave according to the normal vm_pgoff
> offsetting simply by removing the _zero suffix on the function name and
> if that causes regressions, it gives us an easy way to revert.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
> v2: Fixed minor typo.

Almost forgot about these two -- picking both v2s for a PR later. Not
sure what happened with the mm/ related one I sent, is it in Andrew's
tree?

Cheers,
Miguel
