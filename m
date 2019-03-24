Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F477C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 19:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08532133F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 19:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553454111;
	bh=f4dwUuFVsAvuttSn3rBRdaTHiovPVrZw23TLkiz1xec=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jkbuw2FEYSX4GyX5mAEw/szaT9U2JcEBkXUyjNB5ku0oujPz7wvtg6+u+8nE065WC
	 h9Ikj1jU/1F7ZbXDyd3+0yKAzmkfRlXd3uxhoKGTUYxHfFbl8WvwozcyLAbDHZThoC
	 qtoorTuIhpPumncDtO1yNZ0xoZEdBcH2WnOFHxHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbfCXTBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 15:01:40 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40119 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfCXTBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 15:01:40 -0400
Received: by mail-lj1-f194.google.com with SMTP id q66so5921918ljq.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 12:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JPPFm+auGjVjAe9ALla/4JXdlF3YLWWAuGt6YpWzDX0=;
        b=B3Nc4AWCu0WZyGGEJUROdggq8uDHwxkq2EDmnif/bqFGaDaoiAvhwY1F14QLXCPePf
         Ck5bEBKffV4YNwzQMJg4MgOMJlzivGrxV7rA06++oaGqbBh3kkFNIScaqVE5r3E5UmCg
         30TNRcejHwVUX4gwW1B5jZhpZdekhgu0LKwFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JPPFm+auGjVjAe9ALla/4JXdlF3YLWWAuGt6YpWzDX0=;
        b=kPOvKnjKI4Nvn1juXHRD0svl3ZWbx2V+gTH24ObFnpbz2QcaoNnPfb3OGLAc+PXJYB
         3dGjQ9j5sCnRWev9iFzHV5BZ7figvnAh7/mr1I5xUni0JQsYBmo7dVfhkznT0MxS1LV6
         QgF6lev2GBmvWm3HMmTZVWTddOSir3p/l212lqvwtsbAWCxm2u9FK509yvdcvA+3yXJP
         vZdAu3Tp53F+jgPkdsGUJjT/ShLYJd74qiqv1GXPY/heSfrnHpr/ajQCulwYIQrl5XZ7
         h1uwhnNlKnj58Szn42dlG5SasGe7aZfg2zVkA87n1iNJLDJZe9diiux0VrjKn/c21apC
         eJqA==
X-Gm-Message-State: APjAAAV2Twb2QNro3YPpodTJFODWpv4MuyDeLjd/XfYFfwVTfFw5Ij0q
        HlYf453HVqCXPG5CRUDbLdAyfPvgu7w=
X-Google-Smtp-Source: APXvYqzCgYkwADhMnQ3YeypqPwrmnkvwVL7mTjTBXmAyviv+uXKQ05Qup/Zu2niE7XKcWpBobxUBgg==
X-Received: by 2002:a2e:7f13:: with SMTP id a19mr7910304ljd.35.1553454098054;
        Sun, 24 Mar 2019 12:01:38 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id d26sm3047070ljc.15.2019.03.24.12.01.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 12:01:36 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id f18so5896561lja.10
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 12:01:36 -0700 (PDT)
X-Received: by 2002:a2e:9786:: with SMTP id y6mr9913501lji.79.1553454096543;
 Sun, 24 Mar 2019 12:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <155343674151.28403.7455818401538063350.tglx@nanos.tec.linutronix.de>
 <155343674152.28403.9250472064220526031.tglx@nanos.tec.linutronix.de>
 <CAHk-=wgC4FQeT8Z6+gXnbsDFxRAD9sSELd8-G=6gQg4kxKKL4g@mail.gmail.com>
 <alpine.DEB.2.21.1903241929290.1798@nanos.tec.linutronix.de> <CAHk-=wixSEaRjAPT8ZiJhbs-5phzjSrRktz7tOCdSe5OCixfmA@mail.gmail.com>
In-Reply-To: <CAHk-=wixSEaRjAPT8ZiJhbs-5phzjSrRktz7tOCdSe5OCixfmA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Mar 2019 12:01:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=whM4WVADKr_Qg-5nv8UczLp+eBd6KH44y_6=XC4nvvrcQ@mail.gmail.com>
Message-ID: <CAHk-=whM4WVADKr_Qg-5nv8UczLp+eBd6KH44y_6=XC4nvvrcQ@mail.gmail.com>
Subject: Re: [GIT pull] scheduler updates for 5.1
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 11:48 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It looks right to me now, so I've pulled it.

Interestingly, I'm not seeing pr-tracker-bot reacting to my pull.

I *think* that's because pr-tracker-bot saw the same thing as I
initially did for the pull request, so it thinks the pull I actually
*did* after you force-updated the branch doesn't match the original
pull request, because I ended up pulling something else..

Or maybe it's just delayed. We'll see.

                Linus
