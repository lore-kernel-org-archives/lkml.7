Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81C3C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 08:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2A12081B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 08:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ELop5NzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfIHIKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 04:10:01 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41896 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfIHIKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 04:10:01 -0400
Received: by mail-lj1-f193.google.com with SMTP id a4so9738328ljk.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 01:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rK3idBChgXpZBYEMCk4smWWhaKLMi7X3IKqLIeI2HXw=;
        b=ELop5NzEmw8P2dhvnHe7o1eUrVsiLJI/cSOVdZqbI5Wo2ejzGRFGW3h9c/WvRte4q/
         mHYhwBl9IpsuIaT9p7pUYt/+3+wxzJr3NERGAtY3USrOgzkZGj/rQmgquTme7pRjru16
         u4k8OstlsaHDDw+vP+T2uNAFQ8vD806YJQuy5p/3TR7hBQFig3cec+VhkjkoOhb+uF4+
         kpLRw43nux7w+XVgVyKWwTa1PqAHFQAn1juU7NRxVj+UZz6uI/uDqEEgcXJtxZSTIQu2
         EXcL1Fk+q70zVG4baK4yQdHELKHdf8bgPwc4iOGXgDXH5BzCntFeq79d92I9DHUe90Pm
         zA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rK3idBChgXpZBYEMCk4smWWhaKLMi7X3IKqLIeI2HXw=;
        b=Tfcm2dmjpa++EXeU7abJYwm4rbL3DhnMmD5Dt1dDsVqI4N7A7tNzauZf4sDFIlttpL
         vQ1KVu/dD9xTGUHbYjn9RcRKtblr567R+GXWqeFmIVhESnA2zsUjSxECP9ED6/RAXyVY
         ey0OgNt/mjDSK36GBeIyHra6QEZaDsJZd5Fu67j9dbDrcx/7NIiSLTiWY57H7P5kFR3Q
         +/TCh/FcGG6MtVIkskZj1ilYBEgC9D9Eyp856CMNkRAr9cpZmvG3BAN1X5+zpTE/+6No
         z/WoQqFqJtXDLtGZX4kX+Fl289RXk0Mb4bfZwfBznJzGDZ9GNNVLSXvaCEdunEMoRqHP
         wVgg==
X-Gm-Message-State: APjAAAWG655q1yNmHLiMH2QxsQLmPcmMnlvic9iXc/oq9lUBK+83q+Cx
        kcxrtfOV0S9kecYMmZfWw0I68kkwFJ7qXeHptKY7ZfWJ3Fp2tQ==
X-Google-Smtp-Source: APXvYqwQ4r+VRrfjdBn6nVPHnlf3wdFS7wvaHGxSg7UmgOUz8Ir+bHVwQpF3laZCpkO2TkPU4AWjbK20Ax50t3J5XsQ=
X-Received: by 2002:a2e:9dc3:: with SMTP id x3mr7787513ljj.108.1567930198762;
 Sun, 08 Sep 2019 01:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <156776809772.24167.8650737097914479700.tip-bot2@tip-bot2>
In-Reply-To: <156776809772.24167.8650737097914479700.tip-bot2@tip-bot2>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 8 Sep 2019 09:09:47 +0100
Message-ID: <CACRpkdZs9KLaGnU7JrJDviyYwT1PX=pWb5z179t8-XE7ZSGjTA@mail.gmail.com>
Subject: Re: [tip: irq/core] gpio/ixp4xx: Register the base PA instead of its
 VA in fwnode
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 12:08 PM tip-bot2 for Marc Zyngier
<tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the irq/core branch of tip:
>
> Commit-ID:     daa19fe5b082779962988a5ba9e38509004db3de
> Gitweb:        https://git.kernel.org/tip/daa19fe5b082779962988a5ba9e38509004db3de
> Author:        Marc Zyngier <maz@kernel.org>
> AuthorDate:    Wed, 31 Jul 2019 16:13:42 +01:00
> Committer:     Marc Zyngier <maz@kernel.org>
> CommitterDate: Wed, 07 Aug 2019 14:24:45 +01:00
>
> gpio/ixp4xx: Register the base PA instead of its VA in fwnode
>
> Do not expose the base VA (it appears in debugfs). Instead,
> record the PA, which at least can be used to precisely identify
> the associated irqchip and domain.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

I think that patch is already in my gpio devel branch.

But I guess it doesn't hurt either, git will figure it out.

Yours,
Linus Walleij
