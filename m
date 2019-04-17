Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E264C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FAC20645
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="ExNi4No3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732085AbfDQMy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:54:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42940 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbfDQMy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 08:54:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so31784085wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 05:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6saxc2kTeaHnspIYfhRGji+8DaiZiZ+BM5zhQWik19w=;
        b=ExNi4No3r5ALAgrtFxr7ZSweILHDqvS0xKIvxhfu8IAuHh4xairEAUGf6TG6Ijm7kh
         USpnAfoWv8R8UzTUCT5Qmu4zvt5IIX0Vwl9tilTledUFWNLzrN0UyxDM/341DTuOTiCB
         c1lV1xBpEi/2pmPmPFnw1fAAA6CFKFZYOmkWdW3hFxgsa+bxdA0C3Ngns902zOUL4g/9
         UCgZk5sM4GMGfKI40ASWx1hC5RtP2QzY43/oF4e50rLip+tEt+wD8QxF9TesT0f74qmg
         uLnEyZbFwU5/UF95a7/shVNVm4TjV6m2K69wTvl9HIZODdmiEyO4oTj2EQetX1ed/djY
         KVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6saxc2kTeaHnspIYfhRGji+8DaiZiZ+BM5zhQWik19w=;
        b=TEu16jwyHl+dWkiwJ3PKWAd7T9T0WMcbvC7xUqhyiyjfKmlPmVsKizzmmthw3viLxx
         Q4htr0sZBUATD4g6E9yNDGZObtAiTX/cozzZtzd5ZTqf8uRPN724biBYzsIZV2v10D5e
         8w6KHujWegssnHpjntFaDvJ7cSxiu4OWYS87sBSKfydfGlQA2g4dXvPD5dWG+vI/Lc/W
         maDrbqWiiWsIk4OjWZ6PT2edwOvhCeTR8Hithlog7z6lIqQdGdDp6Cf6XP/k8lw9G1V9
         AjdUInflCIVTmdUmoigr+dhOnqQ0WEkp580c0+42XQs55DtnxS+12iM1YiR3v9hfbiXw
         fdrg==
X-Gm-Message-State: APjAAAUBHRjNs1Mq2rGt+b++jCG9JwrigH0SbIErJ4rU2jYuapZbyg/Z
        Amk7sV40ZNaa869qq94OyT3V5A==
X-Google-Smtp-Source: APXvYqyXDbmF7CYpT+TxUzcq6T2QOyA3/SZL/h1WqJ+VMa6Kjcl+/B4SIb5vMmwvrXYjP8So9VjdrA==
X-Received: by 2002:a5d:4d42:: with SMTP id a2mr57635518wru.130.1555505666491;
        Wed, 17 Apr 2019 05:54:26 -0700 (PDT)
Received: from brauner.io ([185.197.132.10])
        by smtp.gmail.com with ESMTPSA id i17sm59701224wrs.44.2019.04.17.05.54.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Apr 2019 05:54:25 -0700 (PDT)
Date:   Wed, 17 Apr 2019 14:54:23 +0200
From:   Christian Brauner <christian@brauner.io>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
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
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add
 CLONE_PIDFD]
Message-ID: <20190417125422.bhyrmzom4kwuenwm@brauner.io>
References: <20190414201436.19502-1-christian@brauner.io>
 <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
 <20190415195911.z7b7miwsj67ha54y@yavin>
 <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com>
 <c783a83a-01a1-9813-e2f7-0516cf7a1c16@metux.net>
 <CALCETrWWoEvnzx6oLTEajBmiArScX5sSt74o2VO+aTiwEi_9mQ@mail.gmail.com>
 <e58d1694-c143-3465-512d-43301422bd8b@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e58d1694-c143-3465-512d-43301422bd8b@metux.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 02:03:16PM +0200, Enrico Weigelt, metux IT consult wrote:
> On 16.04.19 23:31, Andy Lutomirski wrote:
> 
> >> How exactly would the pidfd improve this scenario ?
> >> IMHO, would just need to pass the inherited fd's to that daemon (eg.
> >> via unix socket) which then sets them up in the new child process.
> > 
> > It makes it easier to wait until the privileged program exits.
> > Without pidfd, you can't just wait(2) because the program that gets
> > spawned isn't a child.  
> 
> Ah, that is a cool thing !
> I suppose that also works across namespaces ?

Yes, it should. If you hand off the pidfd to another pidns (e.g. via SCM
credentials) for example.

> 
> What other things can be done via pidfd ?

Very basic things right now and until CLONE_PIDFD is accepted (possibly
for 5.2) we won't enable any more features.
I'm not a fan of wild speculations and grand schemes that then don't
come to fruition. :) Right now it's about focussing on somewhat cleanly
covering the basics. Coming to a consensus there was hard enough. We
have no intention in making this more complex right now as it needs to
be.

Christian
