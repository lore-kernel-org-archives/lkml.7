Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5349C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950B22086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfJCIxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 04:53:16 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:32873 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfJCIxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:53:16 -0400
Received: by mail-ot1-f65.google.com with SMTP id 60so1619772otu.0;
        Thu, 03 Oct 2019 01:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4OuXWkCcYZn6iGz6yGmnFOFRK47tt+Gizjfc+eM7TQ=;
        b=hoZf6awo+2ZGQgfftoSqBZ9JDOl0ZMSsCd7t59jSSXJ9PwEiiefpmui+A8SYuDnezf
         i8j3gYXkGGrYgOPG0632lB8YyAfjNtLNSQsogtBgW/HLqtguhr61R7wgouchfmx1Kj7X
         lHr4ztxmHYrVEBEYZ+4C1Qfnqv5jd2kbyM/yoJm53JJ8rySQyPaCZKIde8mXM5/8eMoo
         OLYuG7KfxAj3MPjVit6FtDnOyOUKNcDNaeCqHbDxmk0xRd9y4+QdHKkD39cmAdAnK0lS
         K3P5xOiNrJpUVSpHkvQ74NZ3xNa9RIcuJtFAsgI7y4vja7XVTJwFXqtGvIy1BKEBCaMC
         vHuw==
X-Gm-Message-State: APjAAAVzzxlWeCrNCzf9DJFz7UC6vdodRT7LiTvxmrzxvPAZij2V4ET8
        je2u90zbCyrNpAHf71I+vSzMWDwsj2SxQ5UBLBM=
X-Google-Smtp-Source: APXvYqwbdMbTKx/DAhkGzzchLDJAEOUh/Gil0KvV2Aj9xDuPK1uPz5XIRULAFZrTUlVNXEHJQrqLZFkRq/H2lMnHb4k=
X-Received: by 2002:a9d:730d:: with SMTP id e13mr5825697otk.145.1570092795050;
 Thu, 03 Oct 2019 01:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191003014710.GA13323@paulmck-ThinkPad-P72> <20191003014728.13496-9-paulmck@kernel.org>
In-Reply-To: <20191003014728.13496-9-paulmck@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 3 Oct 2019 10:53:03 +0200
Message-ID: <CAMuHMdW5+RSp6iycmyPnYPv+xHr5tNY7U3w-BVrWqz4BR2Dd7w@mail.gmail.com>
Subject: Re: [PATCH tip/core/rcu 9/9] rcu: Suppress levelspread uninitialized messages
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, dipankar@in.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Thu, Oct 3, 2019 at 3:49 AM <paulmck@kernel.org> wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
>
> New tools bring new warnings, and with v5.3 comes:

According to the kisskb build logs, it happens with gcc 4.6.3 only ;-)

> kernel/rcu/srcutree.c: warning: 'levelspread[<U aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
>
> This commit suppresses this warning by initializing the full array
> to INT_MIN, which will result in failures should any out-of-bounds
> references appear.
>
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
(for the initialization loop, not for the actual INT_MIN value)

Unfortunately I don't have a gcc-4.6.3 Linux cross-compiler anymore.
I tried with msp430-gcc-4.6.3 and some hackery to get it to compile,
but that didn't let me reproduce the warning.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
