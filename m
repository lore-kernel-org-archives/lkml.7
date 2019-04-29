Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66625C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309F521655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="EOuJnQQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbfD2Uvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 16:51:52 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33939 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbfD2Uvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 16:51:52 -0400
Received: by mail-lf1-f67.google.com with SMTP id h5so9121390lfm.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 13:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5BTG3ToioK+yJqzujw26pVQ5qbb2+Iq3UMr0lsqymLA=;
        b=EOuJnQQt7qkx4dDVY/1fbGW6T3WZ9JBpZk5tVD6J3SHJvrhnPiFzPoIbicXkZGKNkN
         mGX0EYnA0q8yagmnytDlIhnGOl/hkr5duDj+b61Nr2ZCd7X+lDAFHqu1eUjFRB1Cze3+
         zJak73BLzXwh1w3y6hdfgsuxs17QVf8Ro2bjfijP8uZnFgwZb51UEJfJxhn9DD4jq57/
         5ZnwBghizTPJprglQL33FeJ6j+COd765tAqrBfPMzaszGDioF7QRxJzyJ8WOfBDCd5Rt
         UVLJ5Wm2r6MFMSd/P8feIvqqccErMacfA7Lt4CWRJUdTWEBVW498VHYoNFkGW6H8QlmR
         r1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5BTG3ToioK+yJqzujw26pVQ5qbb2+Iq3UMr0lsqymLA=;
        b=A2J/YwET4zMJkkUGfDIdk3KDjwRgk3R99VlovR9z0rrz2ZPGt1i6iq7eyTj5UNxTsm
         D2DJk6lia3EPiTZ4lmj6ghELrV1Avaa5sXY+MlNat2Lmqw4f9K/++Xdfgj44Ouwoczo+
         FzyWwIM9+wMzjC2WDlZmMZmhyJ9PTJmbwt9mMTMFIfqLpeGYAjy2ZZZsl5QnHH1GJ/6B
         FohWWOubxbvW75rvHeG02FLlvz1eJya8KNimr9iwu/50oOFTCHUpSGQ/89uqOFwV+y/B
         Y1z3cHoHrBXcf1wrkyf66nu+smkdS9KZlt5R6fjG3vP/WJ1LQz/+FBIOqyS/TI0+EHOX
         j1lg==
X-Gm-Message-State: APjAAAVPAxROhJGu0rkmn1icOeZrRxyUWSmVEQtitpoxBlw4CO5Qv3kV
        2li16Vw5wsKXlfP7XXEsuRcY9fE/JCaVKYAq4Qq91Q==
X-Google-Smtp-Source: APXvYqxLq9OOTcjel5gfhKM5gMgYMYXZmRaHRnb4PsXA8AVljxBhy4wP3e85LPQLU3ed5Gz23e88OiQWNj/7BRbgJgU=
X-Received: by 2002:a19:761a:: with SMTP id c26mr33187686lff.8.1556571110197;
 Mon, 29 Apr 2019 13:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190414201436.19502-1-christian@brauner.io> <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
 <20190415195911.z7b7miwsj67ha54y@yavin> <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com>
 <20190420071406.GA22257@ip-172-31-15-78> <CAG48ez0gG4bd-t1wdR2p6-N2FjWbCqm_+ZThKfF7yKnD=KLqAQ@mail.gmail.com>
 <CAG48ez15bf1EJB0XTJsGFpvf8r5pj9+rv1axKVr13H1NW7ARZw@mail.gmail.com>
 <CAHk-=wi_N81mKYFz33ycoWiL7_tGbZBMJOsAs16inYzSza+OEw@mail.gmail.com> <87zho8bl8x.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <87zho8bl8x.fsf@oldenburg2.str.redhat.com>
From:   Christian Brauner <christian@brauner.io>
Date:   Mon, 29 Apr 2019 22:51:39 +0200
Message-ID: <CAHrFyr5HxpGXA2YrKza-oB-GGwJCqwPfyhD-Y5wbktWZdt0sGQ@mail.gmail.com>
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add CLONE_PIDFD]
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Kevin Easton <kevin@guarana.org>,
        Andy Lutomirski <luto@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 10:38 PM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Linus Torvalds:
>
> > On Mon, Apr 29, 2019 at 12:55 PM Jann Horn <jannh@google.com> wrote:
> >>
> >> ... I guess that already has a name, and it's called vfork(). (Well,
> >> except that the Linux vfork() isn't a real vfork().)
> >
> > What?
> >
> > Linux vfork() is very much a real vfork(). What do you mean?
>
> In Linux-as-the-ABI (as opposed to Linux-as-the-implementation), vfork
> is sometimes implemented as fork, so applications cannot rely on the
> vfork behavior regarding the stopped parent and the shared address
> space.
>
> In fact, it would be nice to have a flag we can check in the posix_spawn
> implementation, so that we can support vfork-as-fork without any run
> time cost to native Linux.

After the next merge window we'll be out of flags if things go as planned.
To address this problem, Jann and I are currently in the middle of working
on a clone version that we intend to send out for discussion afterwards.
If the proposal is acceptable it would bump the number of available flags
significantly, putting things like this within reach.

Christian
