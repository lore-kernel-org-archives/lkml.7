Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52560C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F20D2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvVtUppY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbfGQVk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 17:40:58 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41383 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfGQVk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 17:40:57 -0400
Received: by mail-lf1-f66.google.com with SMTP id 62so12704321lfa.8;
        Wed, 17 Jul 2019 14:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AUNlCsTwwbO9HSCCZ59q/nRyBLJZ8Uq2qfPS4sjf2bw=;
        b=PvVtUppYSVSwPllMj/jefCGyUXmYsbq6cX8TAneIQFzhUiVapI8hru8mlyNoC1u5cY
         kX0Fh/e0s20T4TxxryeP7pGijakb1+2YdLXRE836V7aR5S8LhCEEkiQoN0qYmYcwMnko
         /0S8dTbyNZsgIWvBArjoqFlsuFw2Lc3AsiWZz2bAcMQWXq7U57KwuOtNibxmbR60yDUl
         Eyc7EU4tm4scELD6aH/zUdw+yvK+WWBqrywcxkxbaS4egkHu9G1CxgDtOpKE83fwjjFP
         I/It7qlp21yZ4EYrAlzZ4zRz/eH4Z55hmQ+JQm5z0gURy7ijBQytnqwnQ88yGsJ5pmHz
         1gLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AUNlCsTwwbO9HSCCZ59q/nRyBLJZ8Uq2qfPS4sjf2bw=;
        b=m5o9QuO1H7TfMswqt524XohYFRr8D4xXAxdeLspAxujKvnNCDmubYsFXTZ7TbrB4Nr
         0qzO8VP5YQ42cQzeyZVNssPeL0ngPpdN9QvuVtNM+STWg6bqOW0E5I61UOBfPIkGjH7P
         9EJco8AKarsgbwHT5qn4VvcGXcgtGCKBsA7OtVpRNwAdA6fdTS5mmlIuJzyypacpY4Rm
         knm8SdXq8gjou/04TULQFu7IbboUr9EN7AG4WNs36/uFe5dv5u1N/gQ4E6cX73xtgca/
         yCouP9gcTkQ69Y3xUCZQtxjOQDWnC0SPDaMLr4JZmpafEweyryZpEI6kdPgj/Y5IT+e1
         p5kA==
X-Gm-Message-State: APjAAAUKPuRCfLaAKoalqRSxXI6wCazuiNix7Lzfrgkfj6UIAolg2VQt
        wRd5y/45rHWW8hAeRe1vcGXoWvQHd3oSniPsbIBMjbSx
X-Google-Smtp-Source: APXvYqy9PfpIuDhwCi3MxfklB+DfN4XCTqP4heoMN4SE1wUj9s49KxDiS+adaMTbOahayBbHXFx/O7ROh+3tSNPcTNo=
X-Received: by 2002:ac2:4351:: with SMTP id o17mr18944366lfl.100.1563399654721;
 Wed, 17 Jul 2019 14:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190710141548.132193-1-joel@joelfernandes.org>
 <20190716205455.iimn3pqpvsc3k4ry@ast-mbp.dhcp.thefacebook.com>
 <20190716213050.GA161922@google.com> <20190716222650.tk2coihjtsxszarf@ast-mbp.dhcp.thefacebook.com>
 <20190716224150.GC172157@google.com> <20190716235500.GA199237@google.com>
 <20190717012406.lugqemvubixfdd6v@ast-mbp.dhcp.thefacebook.com> <20190717130119.GA138030@google.com>
In-Reply-To: <20190717130119.GA138030@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 17 Jul 2019 14:40:42 -0700
Message-ID: <CAADnVQJY_=yeY0C3k1ZKpRFu5oNbB4zhQf5tQnLr=Mi8i6cgeQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] Add support to directly attach BPF program to ftrace
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Android Kernel Team <kernel-team@android.com>,
        Network Development <netdev@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 6:01 AM Joel Fernandes <joel@joelfernandes.org> wrote:

I trimmed cc. some emails were bouncing.

> > I think allowing one tracepoint and disallowing another is pointless
> > from security point of view. Tracing bpf program can do bpf_probe_read
> > of anything.
>
> I think the assumption here is the user controls the program instructions at
> runtime, but that's not the case. The BPF program we are loading is not
> dynamically generated, it is built at build time and it is loaded from a
> secure verified partition, so even though it can do bpf_probe_read, it is
> still not something that the user can change.

so you're saying that by having a set of signed bpf programs which
instructions are known to be non-malicious and allowed set of tracepoints
to attach via selinux whitelist, such setup will be safe?
Have you considered how mix and match will behave?

> And, we are planning to make it
> even more secure by making it kernel verify the program at load time as well
> (you were on some discussions about that a few months ago).

It sounds like api decisions for this sticky raw_tp feature are
driven by security choices which are not actually secure.
I'm suggesting to avoid bringing up point of security as a reason for
this api design, since it's making the opposite effect.
