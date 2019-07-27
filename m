Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE2DC76186
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 19:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2080A2064A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 19:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="UHJ2++i0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388234AbfG0Tqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 15:46:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35781 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388181AbfG0Tqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 15:46:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so50219366wmg.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 12:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n43qXuEr3mG1ijMb2XGbusnjU1ZIjDMamENkGkmKVxQ=;
        b=UHJ2++i0FDAHvtlpG67S4XkRT06ha0fBqds6o2J9t3UIRrj4x8nHPY601Hfu3liZmC
         ud5RdFXVxFvdipQG1/T0lyQ1UBBsgI/FpRTG+7H4+iCpwtJBqcmPCjoC0RLrklKEPG2d
         +RrDIBA9sPOAbQKtGpJ6IgJ0RoX3+GbayNA80VF0Eqy7Dm7KY6jGqLtC6Tln63s0cxce
         4CDkiz3XhO2mAXhlWGfqArFZpRKl26aDuLDqQbEdJcKO7bIM0ZAVSRa6/hU0M+preU8p
         jTczSRqtJZ2dO+fAosYL+mcGjCE23P5r7TTTRBNUrvRZ9DUM7CQQD9JDt6sEyGEXS0kh
         C4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n43qXuEr3mG1ijMb2XGbusnjU1ZIjDMamENkGkmKVxQ=;
        b=SRwHFnHPkoQ3KaSi07SjzTitlbhsDvh4PkGoLzoEP6VzCbOC/HhXrdzL6SxMDA3CqU
         tpHdudN1lpa/eK6Yot+PA6zuwFxOa02w1fBVC28F3LljQ7tAeRtkZnlrINwztex9n/VR
         f1d5HMuWAKIGG7t27A7NKDFNsi/CR8YG1kVT9umwFV7fMecOyvfnyRRt4nXrRBfxqU4Q
         Qm4J7wWY0B0tyTeYVpAFtN8w1qGg7d2wqlzXKy45YHjM/YziwlYEwQPu2rQ0E1YXoXaX
         ApovniaG+z3jSSNcxF9Tvly6CFa0VI5LtCQAejjvGL+Bo3wtGRqS8b4I3XVZEp2cpubl
         fqIA==
X-Gm-Message-State: APjAAAXGITy8jyJBRem4IMG8q7E34ppT6rXk3JiMCNIa5be01NEgwLnZ
        uIJdZvdoNSGkety5iEJYirg=
X-Google-Smtp-Source: APXvYqwO9ebrnNWkgR/AOWvbm7Of2c68A7LdITWjQz8bObLKixyrdF6ihaYKAu6Q01GOTDEVyIUQ8A==
X-Received: by 2002:a1c:f409:: with SMTP id z9mr20833366wma.176.1564256788985;
        Sat, 27 Jul 2019 12:46:28 -0700 (PDT)
Received: from brauner.io ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id l25sm43182621wme.13.2019.07.27.12.46.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 12:46:28 -0700 (PDT)
Date:   Sat, 27 Jul 2019 21:46:27 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v2 1/2] pidfd: add P_PIDFD to waitid()
Message-ID: <20190727194627.ivyc4rltkfgvdhpf@brauner.io>
References: <20190727085201.11743-1-christian@brauner.io>
 <20190727085201.11743-2-christian@brauner.io>
 <CAHk-=whrh5+aHmgqP9YhZ-yzCtUWT8fPi08ZSJdxusx7aHXOQQ@mail.gmail.com>
 <20190727164932.GR1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190727164932.GR1131@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2019 at 05:49:32PM +0100, Al Viro wrote:
> On Sat, Jul 27, 2019 at 09:28:40AM -0700, Linus Torvalds wrote:
> 
> > is the stupid and straightforward thing, but if you want to be
> > *clever* you can actually avoid getting a reference to the 'struct
> > file *" entirely, and do the fd->pid lookup under rcu_read_lock()
> > instead. It's slightly more complex, but it avoids the fdget/fdput
> > reference count games entirely.
> 
> Yecchhh...  Please, don't do the last part - at least not unless
> we really see that in profiles.

Yeah, I will leave this out for now.

Christian
