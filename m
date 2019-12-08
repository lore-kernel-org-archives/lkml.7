Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CA4C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 23:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96EA20673
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 23:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575849238;
	bh=CULy7KMQDZU6jsu8o6HUknaS+gR44jeXyDFRHEqEYok=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gc1zT/4oVMZv4Cu0pGwCyP/9QtahTB5nAo+txBVYvIThd+1aBWzrkJEiQ99/rybhx
	 sja6m1HGOZQywntwh4ovgZENIeMcckxyEznmzFmxBHUNSwwwhvKVQrpWIMmnBHjMkX
	 zPMViIgeoPoFqbVCmOffgL+NS3FghXfpsE0WJp38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfLHXx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 18:53:58 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33218 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfLHXx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 18:53:57 -0500
Received: by mail-lj1-f194.google.com with SMTP id 21so13590217ljr.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 15:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6DlfIiOai815cLgwtkOx7AzvsqYegl+pyGVZGR0UXRc=;
        b=NVOJJKYYK/bJKTvdyUo3eGtl2yV2k80wMNnIiO5jxzph7OOmIU8eF3rMLxBYI9yJoK
         kfNy3ZNNaGNJ4HqJqhMWXVvJsRGYUH5nkn2EBGSuEYO9HrFgPBTxc8tbY21/LD2On0N7
         WP8ZKex4iClWYC2InqkWfWD7l8Zdr35pA9dNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6DlfIiOai815cLgwtkOx7AzvsqYegl+pyGVZGR0UXRc=;
        b=GCbq1KPgGP4xpgXgWgjOmwvei/OSfQ6j58nfyoLghpeEXhxXksZjqppOrRDavVB5xV
         0Iw6ACem+Ev97n4C+Zb0d+f8v+o15c2l9nPemoDUckTgHFYiatR0r+G3+kVfrT/Kp3e5
         32BG/La4DQNipNOWis/HEXfh3McNitpUc3do1nS1f7F68qUyDW2QDWPTS+n2RDpshGlh
         TYjIFMguk7aEY2vlwEN/Eb/JTA5wXkNeYVTRSo0/la8c98XhhSGpgslFNJjJVqeZCpaJ
         H+XwHas50O3LLYeAW4K5725jGyut02vtF706gMt5Pa9lvjB73FRarKlR/dgScHImKzhA
         BXkg==
X-Gm-Message-State: APjAAAWrROkTKMMO/Q6QPfMqBw3sBethH33m+ZtR2s7gmpYigHfrRId4
        uSN94c7DvgCE+XmvodFEmWm340d7CsE=
X-Google-Smtp-Source: APXvYqxTmTtv/SfLJf0AICzjNsl7/KzU+w135Sy248WNGHiwmM+TVucDvVDe0ObaC/M80BV6V5Yslw==
X-Received: by 2002:a2e:8745:: with SMTP id q5mr15018623ljj.208.1575849235003;
        Sun, 08 Dec 2019 15:53:55 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id m16sm10183789ljb.47.2019.12.08.15.53.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2019 15:53:54 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id u17so13559664lja.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 15:53:53 -0800 (PST)
X-Received: by 2002:a2e:241a:: with SMTP id k26mr14930781ljk.26.1575849233336;
 Sun, 08 Dec 2019 15:53:53 -0800 (PST)
MIME-Version: 1.0
References: <201912071144.768E249A4F@keescook> <CAHk-=wgnaWN1V2G1zyk8zqTVQBdHBBHcdkB-rek5z2VeRq4nmA@mail.gmail.com>
 <8ad884f80c538efabc5c2442517c75c9@perches.com>
In-Reply-To: <8ad884f80c538efabc5c2442517c75c9@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Dec 2019 15:53:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj=+UoeP_ZOyH_wjA-cew=Y0Tqfb+6tw3+USTfjCD7MjA@mail.gmail.com>
Message-ID: <CAHk-=wj=+UoeP_ZOyH_wjA-cew=Y0Tqfb+6tw3+USTfjCD7MjA@mail.gmail.com>
Subject: Re: [GIT PULL] treewide conversion to sizeof_member() for v5.5-rc1
To:     Joe Perches <joe@perches.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 8, 2019 at 3:40 PM <joe@perches.com> wrote:
>
> Call it what the standard calls it.

... or, you know, call it what the individual parts of a data
structure is called in computer science in general: fields.

That really is standard naming too, Joe. Just to quote Wikipedia

  "A record (also called tuple or struct) is an aggregate data
structure. A record is a value that contains other values, typically
in fixed number and sequence and typically indexed by names. The
elements of records are usually called fields or members"

see?

Do we name things by their C implementation, or by their generic CS
names? Sometimes one, sometimes the other.

But the fact is, "field" really isn't wrong AND IT IS WHAT WE ALREADY USE.

And last time I pointed out that at least according to a quick grep,
we use "field" a whole lot more than we use "member".

Possibly exactly because that's the typical generic name.

             Linus
