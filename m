Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BCAC76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 02:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F87205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 02:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="URgXerQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387497AbfGRCvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 22:51:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42954 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbfGRCvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 22:51:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id t132so12120409pgb.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 19:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yLarAZTpweIC1BdUqX+3ijZ3HifFvejAA7UqeAP5Lhs=;
        b=URgXerQufM7qYv3HPde0X/qEUwO02Jxo7qRR0JUssemT5LKRuGkfzKKZhhDq7CjGba
         p3/IIrVYL0PHfWDFtX75KOma4hDD7nve2uF41j1uQNO/dOyMZziP5Cw9cHSu9YEdrlzM
         e/oYsDmEeGthz2/3eEQ1LZUZHOm0jYUH2jyl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yLarAZTpweIC1BdUqX+3ijZ3HifFvejAA7UqeAP5Lhs=;
        b=ZcATcMm3ZxJiNFHkf8UqtzA9j+hDRRa2hLn7CSqKjdCNAKCK2nN2M7siIkgxrJ12q0
         E3tukPs/Xc5XoPtSnrXZKrPImKQnxOmDg2wJuDfZe+Zi4ffxda6dbrJxG4qoVbzRChvR
         IOzBDbj9iDIq8tWqKMQaITxvCXXWu+xCvVFQiOvnmZbvlwPJXrRR7ZVE69SgB/0Snj0i
         EskdMxUN+GyQGpnZAg0r4EQI6C1LOzDxZJu1+3/1VqA9Z6d+zk9F4f1STgsHGWgdWZ5U
         FQggPFogaUCM89UCTh7BrxhxwHQZkF+Z4jcd2F+kGJd31FfUE68dZBqOFHszzDYxsURZ
         lvPA==
X-Gm-Message-State: APjAAAWjBfvAVAStzGVFiPNuD3Azl8GyBxEepsJBhSCvVOFnj7tAQv/v
        72yOxIHqWCiNjofVixMKKQk=
X-Google-Smtp-Source: APXvYqyVRmvTk3VQ5lO6EIVaGhf6ezsSDsWJWyoFvo41QVT+B/w1MZqk60Ab8WhI1LA2VcLn+Jm9ww==
X-Received: by 2002:a63:9e43:: with SMTP id r3mr19902707pgo.148.1563418306192;
        Wed, 17 Jul 2019 19:51:46 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id l1sm34920564pfl.9.2019.07.17.19.51.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 19:51:45 -0700 (PDT)
Date:   Wed, 17 Jul 2019 22:51:43 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, kernel-team@android.com
Subject: Re: [PATCH RFC 0/4] Add support to directly attach BPF program to
 ftrace
Message-ID: <20190718025143.GB153617@google.com>
References: <20190710141548.132193-1-joel@joelfernandes.org>
 <20190716205455.iimn3pqpvsc3k4ry@ast-mbp.dhcp.thefacebook.com>
 <20190716213050.GA161922@google.com>
 <20190716222650.tk2coihjtsxszarf@ast-mbp.dhcp.thefacebook.com>
 <20190716224150.GC172157@google.com>
 <20190716235500.GA199237@google.com>
 <20190717012406.lugqemvubixfdd6v@ast-mbp.dhcp.thefacebook.com>
 <20190717130119.GA138030@google.com>
 <CAADnVQJY_=yeY0C3k1ZKpRFu5oNbB4zhQf5tQnLr=Mi8i6cgeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJY_=yeY0C3k1ZKpRFu5oNbB4zhQf5tQnLr=Mi8i6cgeQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexei,

On Wed, Jul 17, 2019 at 02:40:42PM -0700, Alexei Starovoitov wrote:
> On Wed, Jul 17, 2019 at 6:01 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> I trimmed cc. some emails were bouncing.

Ok, thanks.

> > > I think allowing one tracepoint and disallowing another is pointless
> > > from security point of view. Tracing bpf program can do bpf_probe_read
> > > of anything.
> >
> > I think the assumption here is the user controls the program instructions at
> > runtime, but that's not the case. The BPF program we are loading is not
> > dynamically generated, it is built at build time and it is loaded from a
> > secure verified partition, so even though it can do bpf_probe_read, it is
> > still not something that the user can change.
> 
> so you're saying that by having a set of signed bpf programs which
> instructions are known to be non-malicious and allowed set of tracepoints
> to attach via selinux whitelist, such setup will be safe?
> Have you considered how mix and match will behave?

Do you mean the effect of mixing tracepoints and programs? I have not
considered this. I am Ok with further enforcing of this (only certain
tracepoints can be attached to certain programs) if needed. What do
you think? We could have a new bpf(2) syscall attribute specify which
tracepoint is expected, or similar.

I wanted to walk you through our 2 usecases we are working on:

1. timeinstate: By hooking 2 programs onto sched_switch and cpu_frequency
tracepoints, we are able to collect CPU power per-UID (specific app). Connor
O'Brien is working on that.

2. inode to file path mapping: By hooking onto VFS tracepoints we are adding to
the android kernels, we can collect data when the kernel resolves a file path
to a inode/device number. A BPF map stores the inode/dev number (key) and the
path (value). We have usecases where we need a high speed lookup of this
without having to scan all the files in the filesystem.

For the first usecase, the BPF program will be loaded and attached to the
scheduler and cpufreq tracepoints at boot time and will stay attached
forever.  This is why I was saying having a daemon to stay alive all the time
is pointless. However, if since you are completely against using tracefs
which it sounds like, then we can do a daemon that is always alive.

For the second usecase, the program attach is needed on-demand unlike the
first usecase, and then after the usecase completes, it is detached to avoid
overhead.

For the second usecase, privacy is important and we want the data to not be
available to any process. So we want to make sure only selected processes can
attach to that tracepoint. This is the reason why I was doing working on
these patches which use the tracefs as well, since we get that level of
control.

As you can see, I was trying to solve the sticky tracepoint problem in
usecase 1 and the privacy problem in usecase 2.

I had some discussions today at office and we think we can use the daemon
approach to solve both these problems as well which I think would make you
happy as well.

What do you think about all of this? Any other feedback?

> > And, we are planning to make it
> > even more secure by making it kernel verify the program at load time as well
> > (you were on some discussions about that a few months ago).
> 
> It sounds like api decisions for this sticky raw_tp feature are
> driven by security choices which are not actually secure.
> I'm suggesting to avoid bringing up point of security as a reason for
> this api design, since it's making the opposite effect.

Ok, that's a fair point.

thanks,

 - Joel

