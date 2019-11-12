Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AA2C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5869420818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573593245;
	bh=otp6BH91f1j1iYKXCkCEPVuG0Yq2lJz8IEkdivgWJPM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=auWfdmTguKVxnwXW1fgGYr5zAQj9bpeE7LhEV9IR02UmSkSnf5x3d/bMhyADv50xh
	 N5WvMTnoILhFvYI1EOA2W/aqwH33DzdYJW661n3p9u42083etbyOb6ntKs3UJHTb7k
	 cMI9Z684ET5EHYgqLT5k1rywqrceKaugM7IL9V5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfKLVOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 16:14:04 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:36564 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbfKLVN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:13:58 -0500
Received: by mail-lj1-f179.google.com with SMTP id k15so59951lja.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 13:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P9XIZS7SU3RS49LRENl5SM7lOZ7kZM4P3ixT/QNzhdE=;
        b=UwY9cZA3V5T0vyNv2V661JB/VTL10yx6gFYc1xtgKQgONfocJfi8ojlq33WVjM/r+L
         cwAON8sR7dBpJMPq9/fq/cuIi8qLzAUszVs0iJ7LDN8D1o4e199T+fOpPSZOiTetQnuj
         Y+nhBGmk1z4MO+7U+QjWjCyy2lbljWp+V5Ag8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P9XIZS7SU3RS49LRENl5SM7lOZ7kZM4P3ixT/QNzhdE=;
        b=ereqeFUnITbU36JiZzbppJI+G5C9CYwglfeAxCUf8Vrcsy9UewU0HNLZbPrrnkYF6I
         CyaVF7k42BRImZUrQOGMGireYE9CSZeSuSlVXXcbTdyJJfepGzBe082OKl+POjffMwrO
         w8xsZwVbubR5ZNn1zW5KLQpGSyw1xvkUKL6y+h6UyN2Og1XONhd5+VEg4E4f5rpkkBwh
         j/NZ6T2niDgY200oVWwkCj1VtkUWtVc5yj4Vp9ecaEvEh7hAA3b0zKS1pFPHN5Eoatxa
         L6xvEAwK8cPyq6+ToDKDZaYzbbUgFEjlq6e+Z2aEKzEQ0eOaVHV/27Wy2X4PBxEJklFy
         aWug==
X-Gm-Message-State: APjAAAXQg6x1e51/0EKWLQOC5zdGZBGL1kY5x7Z8E81c0d7BYz0WaEHk
        VTdcQDgL0EWef/SzfwoyotDU4Q9C2vo=
X-Google-Smtp-Source: APXvYqwM15OwHyxJACviqhG9NBz6lQMjqQcV5zqhN84WwOkp2rUX6EWInMTZlmYHnvJVUer+iPICxA==
X-Received: by 2002:a2e:9dd5:: with SMTP id x21mr21593132ljj.232.1573593235300;
        Tue, 12 Nov 2019 13:13:55 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id g23sm11525202ljn.63.2019.11.12.13.13.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 13:13:52 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id y23so21624ljh.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 13:13:52 -0800 (PST)
X-Received: by 2002:a2e:22c1:: with SMTP id i184mr21906891lji.1.1573593232214;
 Tue, 12 Nov 2019 13:13:52 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjGd0Ce2xadkiErPWxVBT2mhyeZ4TKyih2sJwyE3ohdHw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911121515400.1567-100000@iolanthe.rowland.org> <CAHk-=wgnjMEvqHnu_iJcbr_kdFyBQLhYojwv5T7p9F+CHxA9pg@mail.gmail.com>
In-Reply-To: <CAHk-=wgnjMEvqHnu_iJcbr_kdFyBQLhYojwv5T7p9F+CHxA9pg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Nov 2019 13:13:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg9yCKVdenys6FfcpAc9KSxVMOTT2DddVcj-Ofu1MYNhQ@mail.gmail.com>
Message-ID: <CAHk-=wg9yCKVdenys6FfcpAc9KSxVMOTT2DddVcj-Ofu1MYNhQ@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Marco Elver <elver@google.com>, Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 12:58 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Honestly, my preferred model would have been to just add a comment,
> and have the reporting tool know to then just ignore it. So something
> like
>
> +               // Benign data-race on min_flt
>                 tsk->min_flt++;
>                 perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs, address);
>
> for the case that Eric mentioned - the tool would trigger on
> "data-race", and the rest of the comment could/should be for humans.
> Without making the code uglier, but giving the potential for a nice
> leghibl.e explanation instead of a completely illegible "let's
> randomly use WRITE_ONCE() here" or something like that.

Hmm. Looking at the practicality of this, it actually doesn't look
*too* horrible.

I note that at least clang already has a "--blacklist" ability. I
didn't find a list of complete syntax for that, and it looks like it
might be just "whole functions" or "whole source files", but maybe the
clang people would be willing to add "file and line ranges" to the
blacklists?

Then you could generate the blacklist with that trivial grep before
you start the build, and -fsanitize=thread would automatically simply
not look at those lines.

For a simple first case, maybe the rule could be that the comment has
to be on the line. A bit less legible for humans, but it could be

-               tsk->min_flt++;
+               // Benign race min_flt - statistics only
+               tsk->min_flt++; // data-race

instead.

Wouldn't that be a much better annotation than having to add code?

               Linus
