Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937ECC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5935A20673
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570826794;
	bh=ykWXAll2XTEdbRIij34cgkoy34QiWjJs5wJDL67vMig=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YGUr+1DpNKj4e3CVsktKoDseHPwXr5rB/VmL6D8OW++G8VlJd1buk2VrBQkq43uu8
	 BGUo8ZK0mWXdUB2sn7Sq0zpGZ/U1d9A/rcrow67lnB0w1RHealiQU0p+rbOuMN1nOW
	 KBlpvFwo0rxpHpveQc8R0sbhD9UHlnkLBm8YSX3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbfJKUqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:46:33 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39135 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfJKUqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:46:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id y3so11084313ljj.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 13:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FNABcTciGmLPgzKCUlHZRBRsyOpw5zPeOkeqEXDcIFc=;
        b=hiusd5bTKbuf8Io1VHhHhrY3WPkC8HiE+LZAmpWF8M5eNj+z1KEhXR6703FdJnh6Fn
         mco4+ZkYzjQTqICNRn9LKyFFsCB9Owxm8mZcigV5i+SgI22JVStBEVyyBrw4SLHSEXt2
         n8BsJjHPsRARgvmaaSQ1mbnYPbUvUTven4vcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNABcTciGmLPgzKCUlHZRBRsyOpw5zPeOkeqEXDcIFc=;
        b=UMn2XLYjz8a7N3FXtwogKo+6QQedxfRdz+1lA41ALsDg5QXZuGRbmY14Z/ctHtwc6l
         FvzL6/pPW8jnP3+VsgZ1MRl953xdkunlzrQHracqgVuodcHvIfOUOQE733hsyHPSKcKF
         RvcHWA2HVY8yw1Lhh2LoeHuWPRAqqnbYzhNuZpA+CG0MwQyjNWrzdBFlS/69f74UmB+3
         Ag0c1hLqL0R5XWA9ylbo/TyBmLWeigbkum9PYLEMGmiv3Z3TboHCPLkCMFrqxukNOZnn
         A3vYo+ilL46GcFhmxWOAFUUAyq0OV/+C8Md9uOjPFrra3ooUj4pfCd1vW6qY6pNG39Uz
         Fcaw==
X-Gm-Message-State: APjAAAWktX0SsqTOgbG4Dlw5tyr4Z8GvEHIohlT+ve+N9lMZy9c65td1
        RBGh4ttuXHBXrdddTOttjZ/yKpOyrbk=
X-Google-Smtp-Source: APXvYqxxZkK13VAxsd8xuSFf+72nz7qroNBqJjYYCOhUmgsM/a7TsnDywzRE9vVyFqTvB0bAeduDuw==
X-Received: by 2002:a2e:6a04:: with SMTP id f4mr10613570ljc.186.1570826790297;
        Fri, 11 Oct 2019 13:46:30 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id c4sm2159183lfm.4.2019.10.11.13.46.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 13:46:28 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id y23so11047264lje.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 13:46:28 -0700 (PDT)
X-Received: by 2002:a2e:2b91:: with SMTP id r17mr10481233ljr.1.1570826788212;
 Fri, 11 Oct 2019 13:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191011135458.7399da44@gandalf.local.home> <CAHk-=wj7fGPKUspr579Cii-w_y60PtRaiDgKuxVtBAMK0VNNkA@mail.gmail.com>
 <20191011162518.2f8c99ca@gandalf.local.home>
In-Reply-To: <20191011162518.2f8c99ca@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Oct 2019 13:46:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=whC6Ji=fWnjh2+eS4b15TnbsS4VPVtvBOwCy1jjEG_JHQ@mail.gmail.com>
Message-ID: <CAHk-=whC6Ji=fWnjh2+eS4b15TnbsS4VPVtvBOwCy1jjEG_JHQ@mail.gmail.com>
Subject: Re: [PATCH] tracefs: Do not allocate and free proxy_ops for lockdown
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 1:25 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> OK, so I tried this approach, and there's a bit more than just a "few"
> extra cases that use tracing_open_generic().

Yeah, that's more than I would have expected.

That said, you also did what I consider a somewhat over-done conversion.

Just do

   static inline bool tracefs_lockdown_or_disabled(void)
   { return tracing_disabled || security_locked_down(LOCKDOWN_TRACEFS); }

and ignore the pointless return value (we know it's EPERM, and we
really don't care).

And then several of those conversions just turn into oneliner

-       if (tracing_disabled)
+       if (tracefs_lockdown_or_disabled())
                 return -ENODEV;

patches instead.

I'm also not sure why you bothered with a lot of the files that don't
currently even have that "tracing_disabled" logic at all. Yeah, they
show pre-existing tracing info, but even if you locked down _after_
starting some tracing, that's probably what you want. You just don't
want people to be able to add new trace events.

For example, maybe you want to have lockdown after you've booted, but
still show boot time traces?

I dunno. I feel like you re-did the original patch, and the original
patch was designed for "least line impact" rather than for anything
else.

I also suspect that if you *actually* do lockdown at early boot (which
is presumably one common case), then all you need is to do

    --- a/fs/tracefs/inode.c
    +++ b/fs/tracefs/inode.c
    @@ -418,6 +418,9 @@ struct dentry *tracefs_create_file(
        struct dentry *dentry;
        struct inode *inode;

    +   if (security_locked_down(LOCKDOWN_TRACEFS))
    +           return NULL;
    +
        if (!(mode & S_IFMT))
                mode |= S_IFREG;
        BUG_ON(!S_ISREG(mode));

and the "open-time check" is purely for "we did lockdown _after_ boot,
but then you might well want to be able to read the existing trace
information that you did before you locked down.

Again - I think trying to emulate exactly what that broken lockdown
patch did is not really what you should aim for.

That patch was not only buggy, it really wasn't about what people
really necessarily _want_, as about "we don't want to deal with
tracing, so here's a minimal patch that doesn't even work".

          Linus
