Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C167C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A047214DA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573244801;
	bh=0g6wpz1ufWU/+noCtUaNqcZd3sQlCr9U0WbxteXS4Cw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tD82DQp8XD6F4jwcHLQWa11NCBd15vUkW0dsmM/xOzCHa21zoKaiVnylYinb5BVy1
	 i5Vqes0SogPiSF7h5gUghK3Tan1FX5SrniHzjb90xxMGtqigAwO1FID8DjQWkunqLZ
	 VOimzHn0Wjs2e75TkjmfmTcJ9Syuco24JSlbMc/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbfKHU0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 15:26:40 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46132 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfKHU0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:26:39 -0500
Received: by mail-lf1-f65.google.com with SMTP id o65so1741286lff.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 12:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yMlK7Upw2ce5Zg7xMf34DmhBHJDspfQIGQ9pArSi7bQ=;
        b=ewzwuNQJNv+rrAILk6q5QHFnd1Xzbim9h9jPAvXpQWCTVqKUJmJw++ZuvJ2MYk9fCx
         czzZhfUQJ6541scoc2zP5x8caPV4R3FzvKOXqehc3zRMpi+NGAJACZ9aWVponq/2HLdq
         roQhq+s37Hg01PjIBwDBF0Zc6qNUt1DhxJssk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yMlK7Upw2ce5Zg7xMf34DmhBHJDspfQIGQ9pArSi7bQ=;
        b=m4xsem/0FehgYVsWpRIWemm+GndUVfl2zaghcyfJk+RAlwP0kIYUwSGcNf+GaCrsOO
         /+WOBhhzI8xPIeZP5k3wLVYu649gZHomGblGkbZPGvCL2d9AXwcnb7/R11DZSuAICmvx
         W59Ei73pM97eRtgljbhylkT/ItQiVWuLsaFk7Efe4V1f06yVK5WSo0SxgduUNL+Rc7DE
         PIrPjdkFOo+sVjHU5eXwRoGHHL/EyBtscfWpzVs6jnM5grDHaNZHs9fmrpHtJnO6ENzG
         K1h70IahHhKk6FazaDZ71g/7wAy2NYadrzlHDZtS+fnjTs9lPrYdlnMCfnNSljRgEcd4
         TRjQ==
X-Gm-Message-State: APjAAAU51MO/MkdiIv4uokTYa5teHkqdUQPrgDjJ1qAMzWd9KdfEnhOP
        IwfNOwHGVfSHZYrHO4hIYsXgXEa+P+w=
X-Google-Smtp-Source: APXvYqxjHh0dsbszWjoG3teDXO7IgGRlxmnzhWROHYt7ug7G0ANFS9c/k2OANuO1zkIUVptpGd+Rgw==
X-Received: by 2002:a19:e018:: with SMTP id x24mr7750151lfg.191.1573244796537;
        Fri, 08 Nov 2019 12:26:36 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id u14sm3048921lfk.47.2019.11.08.12.26.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 12:26:35 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id n5so7529549ljc.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 12:26:35 -0800 (PST)
X-Received: by 2002:a2e:9a8f:: with SMTP id p15mr7938802lji.148.1573244794852;
 Fri, 08 Nov 2019 12:26:34 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c422a80596d595ee@google.com> <6bddae34-93df-6820-0390-ac18dcbf0927@gmail.com>
 <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com>
 <CANn89iK9mTJ4BN-X3MeSx5LGXGYafXkhZyaUpdXDjVivTwA6Jg@mail.gmail.com>
 <CAHk-=whNBL63qmO176qOQpkY16xvomog5ocvM=9K55hUgAgOPA@mail.gmail.com>
 <CANn89iJJiB6avNtZ1qQNTeJwyjW32Pxk_2CwvEJxgQ==kgY0fA@mail.gmail.com>
 <CAHk-=wiZdSoweA-W_8iwLy6KLsd-DaZM0gN9_+f-aT4KL64U0g@mail.gmail.com>
 <CANpmjNOuRp0gdekQeodXm8O_yiXm7mA8WZsXZNmFfJYMs93x8w@mail.gmail.com>
 <CAHk-=wjodfXqd9=iW=ziFrfY7xqopgO3Ko_HrAUp-kUQHHyyqg@mail.gmail.com> <CANpmjNO6UgNS9h5ZwSV2c+uKz04ch96d+f0-jquDj_ekOjr5bQ@mail.gmail.com>
In-Reply-To: <CANpmjNO6UgNS9h5ZwSV2c+uKz04ch96d+f0-jquDj_ekOjr5bQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Nov 2019 12:26:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiGfnHopopFDhcGp1=wg7XY8iGm7tDjgf_zfZZy5tdRjA@mail.gmail.com>
Message-ID: <CAHk-=wiGfnHopopFDhcGp1=wg7XY8iGm7tDjgf_zfZZy5tdRjA@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Marco Elver <elver@google.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 11:48 AM Marco Elver <elver@google.com> wrote:
>
> It's not explicitly aware of initialization or release. We rely on
> compiler instrumentation for all memory accesses; KCSAN then sets up
> "watchpoints" for sampled memory accesses, delaying execution, and
> checking if a concurrent access is observed.

Ok.

> This same approach could be used to ignore "idempotent writes" where
> we would otherwise report a data race; i.e. if there was a concurrent
> write, but the data value did not change, do not report the race. I'm
> happy to add this feature if this should always be ignored.

Hmm. I don't think it's valid in general, but it might be useful
enough in practice, at least as an option to lower the false
positives.

               Linus
