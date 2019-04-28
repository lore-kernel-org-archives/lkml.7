Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE45C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 17:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECB420675
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 17:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556473328;
	bh=lP7Ptbz2ex8bmy79usgyHqSd/jjPI0pqOc76a8czw0Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=am4Psfr9Q2ITmy0mzX/z8UOzMrTFFaegtzgpMvTbgLi849Mz8dP9C5lP2bNB806Zk
	 5/ExY3gT3SvagBao5Z1vJWHqmWw1hO7i2Q2phzwKttvZEmV5zCct+OPc7JWcMGbdBy
	 YSiUiSD+z/Ait/3beMu5v98CtxBH7xqsbbprh64A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfD1RmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 13:42:07 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:45175 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfD1RmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 13:42:06 -0400
Received: by mail-lf1-f49.google.com with SMTP id t11so6043590lfl.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 10:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vDrmIaA3Vzf9bbBFBbVbErBDAWr0mxl7pPsqulHftsw=;
        b=WsYLbenXA1fqX7qn4S4KGlaj28GkpPhsyd+JpMlsTB7q9dKV9ooPg9f9goIsGAFjvC
         fnXMbCiwhR+LnkIZVQ8Ieo2q2b+Hsvq/3WDzT2IwVDTMnzvy6ABDlyhbUmuZo0huShjR
         OCcOqvxrgmvzHu5SvZLT6tyurA2NzleLF4n3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vDrmIaA3Vzf9bbBFBbVbErBDAWr0mxl7pPsqulHftsw=;
        b=DRkTCrSud10dIAtRLPiBh+coIViEkPK5W0UMAKYrthlpVhVm9+rufLi0kC0bAdINuI
         hPACJlyBDAMlzdxQ+G+KDmGiJOkTaE5peikIw6XTcg0aI6OMf9jbVqpVEYs95JNjcIwW
         npDwZUTUsp9c07g9qF7fxXvHMHWQVcfaZXANiRCz/uPX7qd18bSZkD1B8R9V2/NTLdaa
         FlcQ3UQr5EVUcXKpMoVMCWhaMBELIIdro89Q+F1ni53U1WjlnB/zHhpfDMagKzMUZcUI
         VvYbRwi9uUfr1jdaRSzAUiuMoxSeRdWxMUqf/djxiEV6gZf50NkqM6f0qG5Catw3/SuE
         RmhQ==
X-Gm-Message-State: APjAAAVzhdHNrZeKY6GjTKbzgkcnCRCar5/wgOEoZV8E4Y+6qKk+yGxJ
        nNgvUbDS118fQV/i8pu3LbS6MyIfT2I=
X-Google-Smtp-Source: APXvYqyGsF98v2XSBthDD+348dnrU5KE729ADIpZ5bmne4WlGmX++8h6BewJn1MTb2Ks6hg3CMsuUw==
X-Received: by 2002:ac2:51da:: with SMTP id u26mr30172718lfm.32.1556473324175;
        Sun, 28 Apr 2019 10:42:04 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id q15sm1604075lfh.59.2019.04.28.10.42.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 10:42:03 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id b12so6089197lji.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 10:42:03 -0700 (PDT)
X-Received: by 2002:a2e:8090:: with SMTP id i16mr5058575ljg.135.1556473322801;
 Sun, 28 Apr 2019 10:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190428155755.14267-1-longman@redhat.com> <20190428155755.14267-2-longman@redhat.com>
In-Reply-To: <20190428155755.14267-2-longman@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Apr 2019 10:41:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgCrtM7fPd=qmmg6UUDRcw9iq7a7_ypOHH3740xgv6wkQ@mail.gmail.com>
Message-ID: <CAHk-=wgCrtM7fPd=qmmg6UUDRcw9iq7a7_ypOHH3740xgv6wkQ@mail.gmail.com>
Subject: Re: [PATCH-tip v6 01/20] locking/rwsem: Prevent decrement of reader
 count before increment
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 8:58 AM Waiman Long <longman@redhat.com> wrote:
>
> +
> +       /* 2nd pass */
> +       list_for_each_entry(waiter, &wlist, list) {

This is not safe, as far as I can tell.

As this loop walks the list, you do that

                smp_store_release(&waiter->task, NULL);

and that very action means that the "waiter" is now released, and you
cannot possibly use it.

HOWEVER.

"list_for_each_entry()" will load "waiter->next" to go forward in the list.

So you absolutely *have* to use "list_for_each_entry_safe()" in this
loop, I think. You should treat that "smp_store_release()" as if you
deleted the list entry, because you cannot trust it after you've done
it, because the sleeper may have gone its own merry ways and released
the on-stack 'waiter' allocation.

It's the *first* loop that you could play games with, because you hold
the lock, and the list is stable during that loop. So the *first* loop
could just walk the list, and then do one list splitting operation
instead of doing that "list_move_tail()" thing for each entry.

But as long as you do "list_move_tail()" in the first loop, you'll
obviously have to use list_for_each_entry_safe() there too, since
right now you change that list as you walk it.

I'm just saying that you *could* optimize that first phase to just
walk it and then perhaps split it with list_cut_before() when you find
the first entry that isn't going to be woken up.

            Linus
