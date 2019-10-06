Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,GAPPY_SUBJECT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFED5ECE58F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 16:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9811D20862
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 16:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRCGlzEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfJFQth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 12:49:37 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44067 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfJFQth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 12:49:37 -0400
Received: by mail-io1-f65.google.com with SMTP id w12so23545798iol.11;
        Sun, 06 Oct 2019 09:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gitR6prE2tnQKW2d8vwg8C75oWlKUdv67rXVU7q0QOQ=;
        b=DRCGlzEtnAKAXsK/2hn1rAPa+00ur0pwb7bfnsPV4inoX1EZo9f+x/DVaJh3kTSbvi
         EwRDB6fUbQk1/rsy5egGmgH7bYlcXmGHzRajWercwPT1mZvXWa4HpuUmfY4pFtU0/3IC
         Somjz9/4ecpl/+/yIkZ7GAORqGj8k8bdBaTZWXsRp4KXVc2ycIcMdGM2IbFKi+Pxg31W
         kFatCmY+0Dy9QUmOdHaVpCrY2A2KPq+lIYzAbToHi0nxs6dptrLB9wgohM3H3Zr/nZm/
         PVEq146Ba46kpeaoXCqP1UbN7ZSRrQsxVJailmMq0xQbY9qTMOUGx0WvMQvJoH86IJJl
         s7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gitR6prE2tnQKW2d8vwg8C75oWlKUdv67rXVU7q0QOQ=;
        b=pMdL3V28vLn9ZtqkpSocDzFkeHmnRkYHTo7s4Dp0k5RbeiFlfgOgA64/gsssRKKfVe
         uLrd6hEZgZx1O2YtJUgowLJmW8ysPmY3YqGJ+UNVdHW11Y2SaPiTAKXeN8CZn8oVIVOI
         mBfKerZCaR6ysnXFx7SVz/j0ph6IrNELmSUZvo7zmj1w5Q/OIQss7cw8GuWuUsp8UfZt
         nUFb8P2z4JgX71E+ZJSG19eii4hppneJgBvQqsIDjBXSAiDFSE5v7a6cUMiQZp7sEd7J
         ISlpJZtWbNJiK1U8X+hQZuBDE4+BeiwkceskIfcyU8w7T3iLEjteEcKYYwR7TXSrBD34
         hjWA==
X-Gm-Message-State: APjAAAUa/JM2JkZNE/nimvipfWYLG+SWlJwHE9eGooIxW4IdmnbEIHfs
        Quqh6ha6AMo7H1aIkYmkccKyz1R1DMAAxPbJ/Kg=
X-Google-Smtp-Source: APXvYqzGZYdzHVT/2p6rnwPtcBhy8+JdFhrM+z5AfNJSgF/qYn5iG9mbEGZsWcc2vspca5ATINmbfjn4WGtO7qG9mW4=
X-Received: by 2002:a05:6602:10d:: with SMTP id s13mr12183510iot.244.1570380576506;
 Sun, 06 Oct 2019 09:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
 <1562410493-8661-5-git-send-email-s.mesoraca16@gmail.com> <CAG48ez35oJhey5WNzMQR14ko6RPJUJp+nCuAHVUJqX7EPPPokA@mail.gmail.com>
 <CAJHCu1+35GhGJY8jDMPEU8meYhJTVgvzY5sJgVCuLrxCoGgHEg@mail.gmail.com>
In-Reply-To: <CAJHCu1+35GhGJY8jDMPEU8meYhJTVgvzY5sJgVCuLrxCoGgHEg@mail.gmail.com>
From:   Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date:   Sun, 6 Oct 2019 17:49:24 +0100
Message-ID: <CAJHCu1JobL7aj51=4gvaoXPfWH8aNdYXgcBDq90wV4_jN2iUfw@mail.gmail.com>
Subject: Re: [PATCH v5 04/12] S.A.R.A.: generic DFA for string matching
To:     Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Brad Spengler <spender@grsecurity.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        PaX Team <pageexec@freemail.hu>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Salvatore Mesoraca <s.mesoraca16@gmail.com> wrote:
>
> Jann Horn <jannh@google.com> wrote:
> >
> > On Sat, Jul 6, 2019 at 12:55 PM Salvatore Mesoraca
> > <s.mesoraca16@gmail.com> wrote:
> > > Creation of a generic Discrete Finite Automata implementation
> > > for string matching. The transition tables have to be produced
> > > in user-space.
> > > This allows us to possibly support advanced string matching
> > > patterns like regular expressions, but they need to be supported
> > > by user-space tools.
> >
> > AppArmor already has a DFA implementation that takes a DFA machine
> > from userspace and runs it against file paths; see e.g.
> > aa_dfa_match(). Did you look into whether you could move their DFA to
> > some place like lib/ and reuse it instead of adding yet another
> > generic rule interface to the kernel?
>
> Yes, using AppArmor DFA cloud be a possibility.
> Though, I didn't know how AppArmor's maintainers feel about this.
> I thought that was easier to just implement my own.
> Anyway I understand that re-using that code would be the optimal solution.
> I'm adding in CC AppArmor's maintainers, let's see what they think about this.

I don't want this to prevent SARA from being up-streamed.
Do you think that having another DFA here could be acceptable anyway?
Would it be better if I just drop the DFA an go back to simple string
matching to speed up things?

Thank you,

Salvatore
