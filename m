Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCF7C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2AB20658
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hEU4Jc+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfKMQlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 11:41:02 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33503 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbfKMQlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:41:01 -0500
Received: by mail-oi1-f196.google.com with SMTP id m193so2386872oig.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 08:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oVfwiSp+CCVuO7gwDDwfVCYiALcYNYj8C4nivlUEYh4=;
        b=hEU4Jc+TMKFYo/hClXe4LbEOv2c6xDkpCXQqwl0Z22xOispCr4ItFBq6P3SIqqjsFY
         VMPkl2Ip3H8rGxZ+odTDTzTUfRJqbARb1f9rXcXv9CUCREofvYLctcVawyyirByAJMwN
         ei9fYe5bFlcuSzGJ5HwVndtFoKKv1vq4h+2X/TvDP618luMx3USRKABKneg9QTW0bRYp
         tkrge1Oo0QMqdYnIZnCmlxjw8E75S707Q2y3nfSTEUBKrhHBJIA0SMfHFNrHUt2bVP/7
         ZCtGzajbwdi4S8LQsNV+0V9OHy41RBEk3rr3XBiAVi05uEylHilzdK2PGwAkDhAT7pE1
         m7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oVfwiSp+CCVuO7gwDDwfVCYiALcYNYj8C4nivlUEYh4=;
        b=B+GZC6hGGWQH6z9fk6rkTMQk7w5ICaN6QK7xLtPAVXxJC2Sb6mAHdg1Ig7nPqKrOEv
         ZmKniawaQx8otF7TBlhX/8ssa6tJgHW+xRkJ5MN4fFBmNpfES02I127Doc0sAb72zeIr
         zGz/s0+QAT4ZAaeksuUaDkeKwyKYfUPp/ttVpKjP+siNutCAgjUZIU5S8oyc4km+9mi0
         NU7sJvwrFpPE7BJdR0cGZ2YJ+lT/U18YN5O0tQhotQLP9RBR9f7P5GZkqoVqlpuNQlR2
         6pTwCHwbIOJI1xVofEZ2sg1GhXS6bLSuWJLtfVdWkjFtuLnfgh50aCylD8zEQfuYXm+s
         6EOA==
X-Gm-Message-State: APjAAAWlNn5eRRBhAOaAWOZ2d4NBkn4MXNzD4TQPvPHQf/ws4xg6eVeA
        99JLB/kgPPnucP/IRTZAQvcKJlvXlB2+5MEM2FXIiA==
X-Google-Smtp-Source: APXvYqxsagONtdiNjq6NZ5m7sI0CzPjh/C+hYdKwSFkcYayF5GIcMok6FIb/ScIimmm+EHJtckaZo27u5SdUKfTZ9s8=
X-Received: by 2002:a05:6808:9a1:: with SMTP id e1mr4473205oig.175.1573663259884;
 Wed, 13 Nov 2019 08:40:59 -0800 (PST)
MIME-Version: 1.0
References: <74a91362-247c-c749-5200-7bdce704ed9e@gmail.com>
 <20191112232239.yevpeemgxz4wy32b@wittgenstein> <CAG48ez0j_7NyCyvGn8U8NS2p=CQQb=me-5KTa7k5E6xpHJphaA@mail.gmail.com>
 <13bc7935-8341-bb49-74ea-2eb58f72fd1f@gmail.com>
In-Reply-To: <13bc7935-8341-bb49-74ea-2eb58f72fd1f@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 13 Nov 2019 17:40:33 +0100
Message-ID: <CAG48ez1qtVXSBCmLCWdRwfemw6u5d-Zargm-MNJV_N0WAAoVwg@mail.gmail.com>
Subject: Re: [PATCH] Allow restricting permissions in /proc/sys
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 5:19 PM Topi Miettinen <toiwoton@gmail.com> wrote:
> On 13.11.2019 18.00, Jann Horn wrote:
> > On Wed, Nov 13, 2019 at 12:22 AM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> >> On Sun, Nov 03, 2019 at 04:55:48PM +0200, Topi Miettinen wrote:
> >>> Several items in /proc/sys need not be accessible to unprivileged
> >>> tasks. Let the system administrator change the permissions, but only
> >>> to more restrictive modes than what the sysctl tables allow.
[...]
> > In kernel/ucount.c, the ->permissions handler set_permissions() grants
> > access based on whether the caller has CAP_SYS_RESOURCE. And in
> > net/sysctl_net.c, the handler net_ctl_permissions() grants access
> > based on whether the caller has CAP_NET_ADMIN. This added check is
> > going to break those, right?
> >
>
> Right. The comment above seems then a bit misleading:
>         /*
>          * sysctl entries that are not writeable,
>          * are _NOT_ writeable, capabilities or not.
>          */

I don't see the problem. Those handlers never make a file writable
that doesn't have one of the three write bits (0222) set.
