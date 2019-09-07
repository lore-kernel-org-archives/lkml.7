Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BF4C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 00:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C25A208C3
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 00:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567817945;
	bh=UMDYgnxp3GRCRmVhNbIrX7MDdX/vY3f+PdMjj4NEFdE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2PAL4KocIW79D6RTo5/M9jR4hmj4jb1eFI2id6rzj7LxAT4oLsYOn30WSM3C1bOUC
	 ehYP/1CabgwTAVtoSI9kofO80RZFyJbIn142igsaNizxfdnpPJ84jwkWjckUrGO0Ub
	 J/HCCwCXresaSQwcbEfk4yNqTBvj+8BvzWvdYvv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393695AbfIGA7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 20:59:04 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40016 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393395AbfIGA7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 20:59:04 -0400
Received: by mail-lf1-f67.google.com with SMTP id u29so6433425lfk.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 17:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8kIgqDMkFTwayvksrS5XNZf9m8Rh0h1cv78i3UXEbJI=;
        b=UzgJfyFPXKrT2RfymPeUESR/PTDrIQ6zjcAAqtzEsY/l6Z0RvXCSYMqyGTmMRe2lfk
         802GnJTSRxtczCYfICGArDe1W834IMuCpm6ELnZD3/LuJ25fNG1vsprh/mk23dxdZ/fl
         hA0RXX4iAKQJUE3fmV7aWUWNPwEhg1ppDW85Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8kIgqDMkFTwayvksrS5XNZf9m8Rh0h1cv78i3UXEbJI=;
        b=JjovNePaR8HQG1ktwZq6v3mybkPmzZVmeHUYpCi9wsQKk/YfCfXE0GtxlL6Id/UUNR
         a5xG+BRbeMjtPEdsXFMfi3/N41Gm7ws4Pzle48QwKlqXgE15voTwLXxLsqOw/eXvA5RY
         8rRU+CMktZturU+U2vgAJQ5x21LYp3RjQuof1KLoVpbJZpoHE1ASJCh/Lf0Pwn3c/l82
         VMKW14lhz0AzcLH4QIyOsRSBSKPQi/MTBS9EUeFPqs5tmqpzh4+gwzqIpBa0JB25PBQI
         ZKyLloCzE07BBYUR0QWp1P5s0b9aTePwOEdJsVr/L+sYoRW3rX57mqcKMXUPAncNbeEC
         1/BA==
X-Gm-Message-State: APjAAAUTmXGdur0RKNbidGN9qOpTTry1OIrKmUGWGIjEG6mh/LvVECzg
        3pXX003CUM6zRC/1K+GMlXYW4rk64Ds=
X-Google-Smtp-Source: APXvYqyqazbCRiNbem+zlnoEkfPUvXrtiLi2vpWNYkz0aYPXj76R1CuCGxd8Ce/4DV96U4XvLpLgFA==
X-Received: by 2002:ac2:4257:: with SMTP id m23mr8180355lfl.6.1567817941373;
        Fri, 06 Sep 2019 17:59:01 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id r75sm1409015lff.7.2019.09.06.17.59.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 17:59:00 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id z21so6476727lfe.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 17:59:00 -0700 (PDT)
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr8411029lfp.61.1567817939765;
 Fri, 06 Sep 2019 17:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190904181740.GA19688@gmail.com> <CAHk-=wi2VOPoweqnDhxXKJ9fcLQzkV1oEDjteV=z-C7KXrpomg@mail.gmail.com>
 <CANiq72mXLbaefVBqZzz1vSREi0=HiBUgR1KU3iRjOCum7rvfrw@mail.gmail.com>
 <CAHk-=wiNksYaQ5zRFgTdY4TMHkxRi3aOcTC2zMMS6+aVSx+yeQ@mail.gmail.com>
 <CANiq72kyk6uzxS3LRvcOs9zgYYh7V7V2yPtAFkDwpHmyYcsz_Q@mail.gmail.com>
 <CAKwvOdkodVFxUr_Xc-qeUHnpxEmofENDhNdvCuiRzcGXQ54QkQ@mail.gmail.com>
 <CAHk-=wg+PD-+FEdKJuRVrrsgnFFLoAgU4Uz7tnohq_TgsEcNig@mail.gmail.com>
 <CAKwvOdmCBgKMLkXt29=vgvws_ek4XY3urMdfBUzbREH8Bj3uYA@mail.gmail.com>
 <CAHk-=whZ-ac4jm9zt=805xWsXaDAFWn2Bwn2PNtOBVx1vUmVvQ@mail.gmail.com> <CAKwvOdkWcB6jhqpr6p3LQkJOOt2si3i=bTGM11Poz8cZypS5EA@mail.gmail.com>
In-Reply-To: <CAKwvOdkWcB6jhqpr6p3LQkJOOt2si3i=bTGM11Poz8cZypS5EA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Sep 2019 17:58:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiyxKDMW2fPumh2WyP3tP1BHpispjGfTWQ-we8keZ=q7Q@mail.gmail.com>
Message-ID: <CAHk-=wiyxKDMW2fPumh2WyP3tP1BHpispjGfTWQ-we8keZ=q7Q@mail.gmail.com>
Subject: Re: [GIT PULL] compiler-attributes for v5.3-rc8
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Burton <paul.burton@mips.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Behan Webster <behanw@gmail.com>,
        Behan Webster <behanw@converseincode.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 5:45 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> > Yes. With the appropriate test cycle
>
> Sedat reported the issue and already tested/verified the fix.  How
> long should it sit in -next before sending a PR for inclusion to 5.3
> (as opposed to letting it ride out to 5.4)?

If the original patch was already in -next, I wouldn't worry about it,
as long as you do enough local testing that there's nothing stupid
going on.

The -next cycle is a few days, and even with an rc8 we're getting
close enough to release that I'd rather get it earlier than later.  So
I'd rather get a pull request this weekend than then have to deal with
it when traveling next week.

             Linus
