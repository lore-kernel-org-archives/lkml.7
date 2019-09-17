Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A912C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66716216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568753144;
	bh=sN16v5aE9f1en31OdtpF6sxJr9PK5t1WeiNsz4wlq24=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xo0nUlpDxRzrBhBmcyr239tOncKso1FD8OdYQXrrpSQrKqPAqBkhpB9pbGYOrGStD
	 POY4XlhN0EX8ZcVPTxcaOQ8vcWbqFLFhR4NngHjFTdNkpB0q06b631SZVdcL7vGGIz
	 NPmKdFo7Wkzg9iAI9dx31Ws3XlZr/wB5Hqnw656I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbfIQUpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 16:45:43 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:34732 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfIQUpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 16:45:43 -0400
Received: by mail-lj1-f172.google.com with SMTP id h2so5006621ljk.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 13:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UTaApOHQWYgneuGzZ7YNtvEevdvs1utVLoBKbHK1gYc=;
        b=dJLYKuAkBH0gzZVZ5XUTjdiwI6yU/P2WChCP/N72EQ2Jjw/TxbYhFEMt3oMsLrmAsQ
         sO9ViXYnECjpjc2F/0uAhTdcUXwf//dQw+raN4fOY8re5ShVjoy3PG1vK0CYyIyluosO
         q0/CbwDt7HWX9fUrgappPxJpagzsKuCP75+uY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UTaApOHQWYgneuGzZ7YNtvEevdvs1utVLoBKbHK1gYc=;
        b=CSJlvZxvF85Lm//Wy6864Qg2S0pn9n7IXvmJa0rQtqLb/OE6Onh1U9Ujm/noy3lhci
         Wanuc3M43PWavq0dOVOJ4DwSllWw6jACScAehbYdVQBwtn/5GYpL9AtE/6Vpb3YzxNi2
         NkAKpj5eEFVmbZcFXrH/HvmD6KTSEam9iZbWSToNAC5Q7scHmRppn/W/EJgpW8xwYnyp
         ItiPVJ2+0gdPTSyP4lgFEYe+otd0Ex/mH69S+iNPKutB0ea7BoxzdUP3WBAIIFVWEWzv
         QdhpvQBO48nbrBYD3RmV61vBdKiM0t9A3/7rNmq9cuAFx3evrg/6yvg1uyAs2nXfJWPV
         BBlQ==
X-Gm-Message-State: APjAAAXU7N9MQ1vEcv5LuNTUMk5ZuS6DOYGE95zMNRS3G5eGakiGORlX
        Md+Z+7Yl2jg2cEYu0kBAWdatieKWN4g=
X-Google-Smtp-Source: APXvYqy+Bi8BZqDt1AdAABsxu0uP7ZGXYiT9vFh9u//Orld57MuDiKNUQNvIjnSgjzQgk01zE+tR5A==
X-Received: by 2002:a2e:9a03:: with SMTP id o3mr155002lji.51.1568753138926;
        Tue, 17 Sep 2019 13:45:38 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id k13sm629827ljc.96.2019.09.17.13.45.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 13:45:37 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id u28so3951114lfc.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 13:45:37 -0700 (PDT)
X-Received: by 2002:ac2:47f8:: with SMTP id b24mr128474lfp.134.1568753137199;
 Tue, 17 Sep 2019 13:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190913072237.GA12381@zn.tnic> <20190917201021.evoxxj7vkcb45rpg@treble>
In-Reply-To: <20190917201021.evoxxj7vkcb45rpg@treble>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Sep 2019 13:45:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjDiDOcz2GHC88rV8gySCMZZko8PFW-ywJDkeY5n+je9Q@mail.gmail.com>
Message-ID: <CAHk-=wjDiDOcz2GHC88rV8gySCMZZko8PFW-ywJDkeY5n+je9Q@mail.gmail.com>
Subject: Re: [RFC] Improve memset
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86-ml <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 1:10 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> Could it instead do this?
>
>         ALTERNATIVE_2("call memset_orig",
>                       "call memset_rep",        X86_FEATURE_REP_GOOD,
>                       "rep; stosb",             X86_FEATURE_ERMS)
>
> Then the "reverse alternatives" feature wouldn't be needed anyway.

That sounds better, but I'm a bit nervous about the whole thing
because who knows when the alternatives code itself internally uses
memset() and then we have a nasty little chicken-and-egg problem.

Also, for it to make sense to inline rep stosb, I think we also need
to just make the calling conventions for the alternative calls be that
they _don't_ clobber other registers than the usual rep ones
(cx/di/si). Otherwise one big code generation advantage of inlining
the thing just goes away.

On the whole I get the feeling that this is all painful complexity and
we shouldn't do it. At least not without some hard performance numbers
for some huge improvement, which I don't think we've seen.

Because I find the thing fascinating conceptually, but am not at all
convinced I want to deal with the pain in practice ;)

              Linus
