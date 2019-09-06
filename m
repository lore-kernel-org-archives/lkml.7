Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A41C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 20:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB3920838
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 20:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKyTyiOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394367AbfIFUL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 16:11:59 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43263 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388396AbfIFUL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 16:11:59 -0400
Received: by mail-lf1-f67.google.com with SMTP id q27so6023742lfo.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 13:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tP24fnQIBLQtciZGMJdns0fvz+gWnf/L1qy3OAOlCF8=;
        b=hKyTyiOEr5dWpp3q15pBIl0wvmaMEic3JNsgjx18DEmxngWG2c0CeFIqRRaAvHVWaw
         28EeIs8r0xA3ddAsQ1WAs5SjKKqzIF1kgeB7ksKMmrI/3KU9XVSMOCuPmQjTASDM6uL7
         tl1KBoz1uUbYaJHh0geLKuyKXkZrASFkLvq4X61yL0MjbFQbgbIjW5WZihIQh+8QCdjr
         R+W3U7A7GCoQ+KTXnv6qnij/dEtZr58nK8Ii75iVIBOJQT7iBz3oADPrttHl6PqNsFl+
         BAxF+w4HkdDCrZp5gm9an6o+fyZblJUtLepSAmCq2s2lu+5R+aDPXkg+OIxd5WA4efoo
         FOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tP24fnQIBLQtciZGMJdns0fvz+gWnf/L1qy3OAOlCF8=;
        b=TJh2VzHMoIDBh7eU0MDrtdoKiVASb0XPwfebHieABz26AJ884aNun/W8Uxy0N5qpMC
         oHKKRxDVePMbat6mi1rEXIxi1NtVN9aKOGLY78KN2njhFgFL9YdKtGZGjHv2kit17+y3
         LAfgx+3hwP9s6PPfL8xVDcA/kh30bAnq5VDAoKW8jEvnBfCkQruMzayGj3ebMdvWNomj
         jzzBp8fCKIU4nN8fshSsfpSkkfqrasJpdVjVC1oEKpiR6aL6PPluIwlXgQJJLvGPMSLG
         GIomk8r/NIOg0FGS6XajI8BXflkpDx+YusGR507m3YwYaLk8obbBsVulnAxJUdFQuSFP
         YQbA==
X-Gm-Message-State: APjAAAXB+jzM358a/y0M0IqTLexo0rOj3ug4hsWKfkQ7tqAFcuN9EeXY
        hTB8qemt94tSuliasV77aG1pgY6oSoqQlNVZZ7Q=
X-Google-Smtp-Source: APXvYqy/KVad41U9S6dPyiddxRDIE2+P/ZBahDz00J9smcyXOHqtOIm5DdfNHsNlb7/sW0FgIVOB5pReRcTE6YiHoSE=
X-Received: by 2002:ac2:4902:: with SMTP id n2mr7794870lfi.0.1567800716663;
 Fri, 06 Sep 2019 13:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190904181740.GA19688@gmail.com> <CAHk-=wi2VOPoweqnDhxXKJ9fcLQzkV1oEDjteV=z-C7KXrpomg@mail.gmail.com>
 <CANiq72mXLbaefVBqZzz1vSREi0=HiBUgR1KU3iRjOCum7rvfrw@mail.gmail.com> <CAHk-=wiNksYaQ5zRFgTdY4TMHkxRi3aOcTC2zMMS6+aVSx+yeQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiNksYaQ5zRFgTdY4TMHkxRi3aOcTC2zMMS6+aVSx+yeQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 6 Sep 2019 22:11:45 +0200
Message-ID: <CANiq72kyk6uzxS3LRvcOs9zgYYh7V7V2yPtAFkDwpHmyYcsz_Q@mail.gmail.com>
Subject: Re: [GIT PULL] compiler-attributes for v5.3-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Burton <paul.burton@mips.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 10:53 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That's probably what we should have done originally, avoiding all the
> issues with "what if we have multi-part strings" etc.
>
> But it's not what we did, probably because it looked slightly simpler
> to do the stringification in the macro for the usual case.
>
> So now we have (according to a quick grep) eight users that have a
> constant string, and about one hundred users that use the unquoted
> section name and expect the automatic stringification. I say "about",
> because I didn't check if any of them might be doing tricks, I really
> just did a stupid grep.
>
> And we have that _one_ insane KENTRY thing that was apparently never
> actually used.
>
> So I think the minimal fix is to just accept that it's what it is,
> remove the unnecessary quotes from the 8 existing users, and _if_
> somebody wants to build the string  by hand (like the KENTRY code
> did), then just use "__attribute__((section(x)))" for that.
>
> But yeah, we could just remove the stringification and make the users do it.
>
> But for the current late rc (and presumably -stable?), I definitely
> want the absolute minimal thing that fixes the oops.

Then I will send a PR with that patch only (Nick, do you know if the
entire patch is needed or we could further reduce it?).

Then for 5.4 I will prepare a new series moving to non-stringification
(unless Nick wants to do it himself).

Cheers,
Miguel
