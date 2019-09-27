Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D266C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1522C207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569608405;
	bh=nixqikW0YVjyRXTXPZ0OQykyrHovBq2poqnxlZ2w0Xo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=o7NdgynZCxgJ4ZPMu1X6H2zRsAmZbFhQC1+h1Cn+3YGGac8FA/TATIrk4lDZB/bcH
	 ZvKMnIFXWSneGZEk0rf+g576smby9OuI285b1fCqVHVsSZoxSZuxUc+6osda12lT+y
	 /IlQ5FFWomI9+rW9Ti38gNpE9xW3pTDU5SwI72lg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbfI0SUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 14:20:01 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43571 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfI0SUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:20:00 -0400
Received: by mail-lf1-f67.google.com with SMTP id u3so2595644lfl.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 11:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tehHftnlIZpuK7bFKqc+5WjFB+mT//aLNi+OsMfiEtY=;
        b=QLf7L0LguMNURN7cmZ8SzPczLJx0nHvbuzjXD2HCo2gMYHnYf7c+bP+/Hfh9MKZIic
         cB/dy3RBKY3e+GPCukLmg90dkAaOu76XTBJeSZC3tKQbBgHO55QHDU9+bS+EsZOYVWnB
         n70YIM6HULzAXopOzej3WTpMpZSPeE4pcO9CA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tehHftnlIZpuK7bFKqc+5WjFB+mT//aLNi+OsMfiEtY=;
        b=dv0SK37iAW5j5aJ1jACOEapU2A0GFp5y6W68cRV8fEPZN4hym70+YJ2WnDtDaRQbx8
         SV54ggTGpHwYpRPWUqiYnBsLYXech+NG4R/QjpasvJV8kAkHRFoEPxP1B2MLAt1b7EIi
         Rxqwi9iEIN6Jxm5n+SSHjBgVvoQuZcWTnu7EaZG3JW88BSqC2XVIzQcY4g0i2dugyD/b
         BWzI1wOGkXvM0DM2y+qTARr7lXxP8wpbqLaUatYPkOzvMaYsju1KmSFyjhX41fQt/14s
         RddT4oZGi+7Q3JQFOOogVqVRnwmIiuO59yPvL0EXkHRhIYylZM6YGnShgCQprgoJHo9n
         yBow==
X-Gm-Message-State: APjAAAWvP4LBLHFDWREtYnYE4hrF/Fkk3MkDGK3bU419HYADofMwyixv
        veU+u7YHaI+sYNXuqZbksbDpLSVkTtY=
X-Google-Smtp-Source: APXvYqzGyziJjY7exw+TNxSGHS4tqNnwYr2gpL/BWIRzLZScE+wJ11Ahdrvuo6WgEOcEorSE39bh5g==
X-Received: by 2002:a05:6512:14c:: with SMTP id m12mr3598580lfo.27.1569608398411;
        Fri, 27 Sep 2019 11:19:58 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id t8sm601920lfc.80.2019.09.27.11.19.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2019 11:19:57 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id j19so3432880lja.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 11:19:57 -0700 (PDT)
X-Received: by 2002:a2e:8789:: with SMTP id n9mr3912648lji.52.1569608396991;
 Fri, 27 Sep 2019 11:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1909101402230.20291@namei.org> <nycvar.YEU.7.76.1909251652360.15418@gjva.wvxbf.pm>
In-Reply-To: <nycvar.YEU.7.76.1909251652360.15418@gjva.wvxbf.pm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Sep 2019 11:19:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjYz8UQkzBX_1h3cqzDHKEWwyXjnbCoHYWnjn=9RPVOeg@mail.gmail.com>
Message-ID: <CAHk-=wjYz8UQkzBX_1h3cqzDHKEWwyXjnbCoHYWnjn=9RPVOeg@mail.gmail.com>
Subject: Re: [GIT PULL][SECURITY] Kernel lockdown patches for v5.4
To:     Jiri Kosina <jikos@kernel.org>
Cc:     James Morris <jmorris@namei.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 7:54 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> Seems like this didn't happen (yet) ... are there any plans to either drop
> it for good, or merge it?

This is one of the pull requests that I have to go through commit by
commit because of the history of this thing.

And I've yet to empty my queue of all the _regular_ things that came
in this merge window, so I haven't had time.

                   Linus
