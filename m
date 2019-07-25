Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1F2C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075622190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="DZ2Ni7t0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbfGYKWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 06:22:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38684 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfGYKV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:21:59 -0400
Received: by mail-ed1-f68.google.com with SMTP id r12so14937791edo.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 03:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xg/jPeKKTB739DC4K1Kn5i6nMiOCPP3yYS7XnqJJUR0=;
        b=DZ2Ni7t05/jQ93QmmC1R/YHMhpDaH8fwuJhAj4qWCViaKIFm+SJfKoKs4xeUSlf6RS
         ailFXEETYnNGKz+7klPXoF8lDxcqG89449URMDPBWZjGELL7cSyACtnBbD4QDxEv4DoY
         Vn7vJM73S9XdMTu9iKTl/VdhHTOPfXZTu92TnJvcAWj+umf2IJhq27wK7ddcHkcgAu9y
         mqrSYlYtMqqPZ7K3fJP+EFG9XjL32ozVRHam37ox6u7p+F/nzOG6Vss7s/WlKrCfsT6W
         tjCKCSkaCnKbS7sl/aZOHoTqbO5jqslxO5EDaNiyel8F4szFy3JP3f0qL8zonVM1mpTl
         2dig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xg/jPeKKTB739DC4K1Kn5i6nMiOCPP3yYS7XnqJJUR0=;
        b=UWyFGjrPbP1ixF6OE8BH9suelOWEPxZ2ScxJCpIGY6ZlmnQ/4mxFBItYW3Ox1HDA7C
         ordoKqklkZVROF7uxOP2p1R4HcLK4rYJdAuqbRocjzv02aaLWSYrLHsUpjIGYZW0d/3N
         wyjRX9TXx1FodBwj7R6B3iX9fvlkgcPF+LnXv4hdf8lK+op01mXyb5yh/CaFjZ638pLZ
         yDcQiBibmQAhsS1EjtkY08lo6o0vR11T+o6i5tEfG4oYPS0cH9n68yRwV0JM+jibCZ6J
         6jBrTavxhIP+gA0pJAU4qOQnPvxTv5Qbdxl+UwfDtLrFfOj6Kr2TwkiM4ltSGhnyeSf3
         JZJg==
X-Gm-Message-State: APjAAAVG74XzRUE+WSS7jlyveimbYCnv62q6mm80SpqEBy3ikxg9l/k6
        NWghyeP7jFJdirLhJVn3iJ8=
X-Google-Smtp-Source: APXvYqwnnlwEsNrhcUAHrNjHscYNwb1YbvHUcf+02n2cfVtguvWwOau6+5+iaL+tXi5yG6SvDguEKg==
X-Received: by 2002:a50:ad45:: with SMTP id z5mr75231854edc.21.1564050117987;
        Thu, 25 Jul 2019 03:21:57 -0700 (PDT)
Received: from brauner.io (ip5b40f7ec.dynamic.kabel-deutschland.de. [91.64.247.236])
        by smtp.gmail.com with ESMTPSA id uz27sm9729326ejb.24.2019.07.25.03.21.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 03:21:57 -0700 (PDT)
Date:   Thu, 25 Jul 2019 12:21:56 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        keescook@chromium.org, joel@joelfernandes.org, tglx@linutronix.de,
        tj@kernel.org, dhowells@redhat.com, jannh@google.com,
        luto@kernel.org, akpm@linux-foundation.org, cyphar@cyphar.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        kernel-team@android.com, linux-api@vger.kernel.org
Subject: Re: [PATCH 2/5] pidfd: add pidfd_wait()
Message-ID: <20190725102156.nqnngsrb6dwmyztb@brauner.io>
References: <20190724144651.28272-1-christian@brauner.io>
 <20190724144651.28272-3-christian@brauner.io>
 <20190725101626.GD4707@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190725101626.GD4707@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 12:16:27PM +0200, Oleg Nesterov wrote:
> On 07/24, Christian Brauner wrote:
> >
> > +SYSCALL_DEFINE6(pidfd_wait, int, pidfd, int __user *, stat_addr,
> > +		siginfo_t __user *, info, struct rusage __user *, ru,
> > +		unsigned int, states, unsigned int, flags)
> > +{
> 
> Oh, I too think that P_PIDFD makes more sense.

I have already updated the patch to introduce P_PIDFD.

> 
> and could you explain in the changelog why? I am not arguing and if
> nothing else this is consistent with other pidfd features, but if you
> are parent/debugger you can't hit the problem with pid-reuse, unless
> you races with your sub-threads.

One of the things is that later on this will allow us to make it
possible to retrieve the exit status via waitid(P_PIDFD) for non-parent
processes if handed a _suitable_ pidfd that has this feature set. Maybe
even - if safe - make it possible to wait on a process as a non-parent.
And some tools just really want to do away with pids completely.

Christian
