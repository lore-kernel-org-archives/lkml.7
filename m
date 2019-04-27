Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133EFC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 14:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38042087F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 14:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdh6WW5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfD0OOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 10:14:46 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46509 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfD0OOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 10:14:46 -0400
Received: by mail-ot1-f68.google.com with SMTP id s24so5032387otk.13
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 07:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fNJmGKbv36s3sMlqGpxows0ZUIacXcPpEBALYAGUe/Y=;
        b=jdh6WW5fZa0BSmUAfpt5gppjYPJC/lPFo0HvEw9/IRuKGWuv7V97rcx6eu2yw48MKt
         ikDwjTMWg/ftRINw4uUiIx6ESwWi055wr6nXzWtuObnmffMIFX0bRr8Bd0S28PtgPAk1
         7NnU8hStFZaHyqPkcNOShf7gSaXIvSBGnzdEfzw+L2P3X0o1CVoyjkAf2JdPEN/vAD94
         I8ULa6x3tn0+jiIONZtDm2zWdCa7jg/d4/jdXXoEyAabDoZIyjH/XAzXrASsmw6OAs5G
         kMul83Ct7GlK/orI/l2FQLDZEpXMQwwdfKcNPCqLdDWdXjfM9XTWgo04EcKVx0tSs0ok
         IR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fNJmGKbv36s3sMlqGpxows0ZUIacXcPpEBALYAGUe/Y=;
        b=cauvhgm4wFMJWxShFjp1Nccl4fzGN8bkTS00nD4rJQSglze2pUQWvujbIAA4m+B+s2
         Y5mDbv6LARl4f9PAgRtYaetDQ4eNzD9RukL0UbSxcazB46udqmnnrQL/zC19zcIFGI1v
         mnFDm81ytx7+FFN/tgc4n6DuBSD2cE6NFyKsK9CFA5/NFEqb8H6m/ixbo5Lz4SLqnS33
         liAR8aom9qKRQYMfwOIF+Nnik8KyLQYS5p34XGVL8GZyh8y6Z0BUE3hSZgZi/UHTT4ue
         4imySFgqT+GXqRHa1PzJiGSL+HvnbMf+KYGlLKJkGU88VjOXRk25WE/vXz/aU3Hgw52h
         YmZg==
X-Gm-Message-State: APjAAAVVB++rQcWCLKeVQvtRUF/7ggrN6N4XIoOpt6gPI/pcG1zm4cXh
        oR1z68RNQlVv2yj/w8nIbLlh+/4KxrqigR79do0=
X-Google-Smtp-Source: APXvYqxkImR+uL6ynwmODFrvJPQgKvcJlSeetJ+/1qZDSYG6jnKoglmkofm3yF3nHlxxZh3++2BbiWykhSBjuHZvxaI=
X-Received: by 2002:a9d:6318:: with SMTP id q24mr18403400otk.95.1556374485344;
 Sat, 27 Apr 2019 07:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <1556339208-7722-1-git-send-email-hofrat@osadl.org>
 <CAGngYiXBrNu7Jrk535=L89-mOSNx-6EfqL=1EwwG49Sf44R0Vg@mail.gmail.com>
 <20190427070021.GA2290@osadl.at> <CAGngYiX-s6dCc5focdXW5WYaiWiBF=dzacqFjSvXggvdxD3zAQ@mail.gmail.com>
 <20190427111748.GA3157@osadl.at>
In-Reply-To: <20190427111748.GA3157@osadl.at>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Sat, 27 Apr 2019 10:14:32 -0400
Message-ID: <CAGngYiV3YCDqD7c4qcc3hyBM2wV05Sk54_ROZckf5S4SLXSbvA@mail.gmail.com>
Subject: Re: [PATCH RFC] staging: fieldbus: anybus-s: use proper type for wait_for_completion_timeout
To:     Nicholas Mc Guire <der.herr@hofr.at>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 7:18 AM Nicholas Mc Guire <der.herr@hofr.at> wrote:
>
> so the issue is simply that the endiannes anotatoin is missing even
> though the conversion is being done - with other words there is no code
> lvel funcitonal bug here but rather sparse needs the anotation to verify
> correctness and that is missing. Just want to make sure I understand
> this before I try to "fix" a sparse warning.

Correct.

Thanks,
Sven
