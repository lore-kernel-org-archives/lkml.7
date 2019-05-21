Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDECC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F662173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEfKlxNG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbfEUOOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 10:14:10 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37818 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfEUOOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:14:10 -0400
Received: by mail-oi1-f194.google.com with SMTP id f4so12908498oib.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 07:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uRNDr9pcs809VfqKtnwGY1ZmCZnJ35mdhlIjT4jz8dA=;
        b=GEfKlxNGI7sf6J5JN6I8h2DJdSqbWBqRkz0la0iq5adhusTgZkvt4gmuUBj6qs20mY
         9STsHiHzOOXnJkJW/uCo7qsWW3+r7rEaAqFhiD6S8odzTJgt9Y9yY7WuZg7RJScxpexO
         HeoPDvXAiBeDFEwPKY/4vVqQCRsDbJ2La29n2vc2KcQm787l7Eg0bhSXc/iaFttbPf0X
         ZZKHWPkXf2vq+VbVJJ3pCUjOvHPwWCbkX7QXaaNvTFo0zNk+iLeLqtTAWsTihaj2GEp2
         dRcbfCGquHTImCkLrmnODxJyuwA9TlsH2QSUVQP2ECkzDfeHJClS6Mf2q3R6wAQrCZ1W
         1VQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uRNDr9pcs809VfqKtnwGY1ZmCZnJ35mdhlIjT4jz8dA=;
        b=FL/oBdvsp3kQT6QTQw7LS5r+/g1jAJoPQbq2B23GAbfB5GPe4Zf93ipXuU5EO+bNsy
         VVwD2RcZxzHbfpFKoLqej6cIoYagMaWcI8oIqSLsdqbRfWSZCAfqxK4isMQGr4ooTgjj
         EtqYBhALlJcmyf4a0W2M+mmFy4KNJqgD8ow34XJXmrlugAIMR9ghoaQCxUjoDVX27+KZ
         5OJ3OILTjkHW4nyJj/lxTzernHiBo2ru2JBD5WKdEfx6dOPLC+GbgiCsE4gd3pn9Pme0
         sA3xvUxqii1XKUoplxb0xjyBZPQENrRPvfBbXopLp3TZ3Q6T4svmD3WRlGxSxM3wt/7W
         tpJQ==
X-Gm-Message-State: APjAAAVlJYHMr1p1ACoIT8XeRpEIT3jhd3iz2uQvWQVk+3laongmsbpz
        O68r6ZAUa8CJrcVt5DKRTnUmi+Qmb7H8CiUaG4gDHg==
X-Google-Smtp-Source: APXvYqxEOBTq9mA569ONS1VIuYThxyQ2MF+mAavR4dg7z9Ti/qjR9oudmeZr1cDRuNroOKEItLPbP61YTNdia7/WtmA=
X-Received: by 2002:aca:5ad6:: with SMTP id o205mr424929oib.92.1558448049154;
 Tue, 21 May 2019 07:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <1558115396-3244-1-git-send-email-oscargomezf@gmail.com>
In-Reply-To: <1558115396-3244-1-git-send-email-oscargomezf@gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 21 May 2019 10:13:58 -0400
Message-ID: <CAGngYiVNQrr2nKfGCdi8FzS5UnmGaDj_Gu_F0ZeOTMKX6_1Zuw@mail.gmail.com>
Subject: Re: [PATCH] staging: fieldbus: solve warning incorrect type dev_core.c
To:     Oscar Gomez Fuente <oscargomezf@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 1:50 PM Oscar Gomez Fuente
<oscargomezf@gmail.com> wrote:
>
> These changes solve a warning realated to an incorrect type inilizer in the function
> fieldbus_poll.
>
> Signed-off-by: Oscar Gomez Fuente <oscargomezf@gmail.com>
> ---

I've reviewed your patch and tested it on a live system. Everything looks good.
However, I believe that your commit message could be improved.

I am going to re-post this patch as v3 (keeping you as the author) but with
a (hopefully) improved commit message. If you provide positive feedback,
and nobody else has any comments, I will tag it with my Reviewed-by,
which will hopefully be Greg's cue to take the patch.

In the future you could perhaps run your patch through ./scripts/checkpatch.pl
before you post it? This should pick up missing commit messages, lines in the
commit msg that are too long, etc.
