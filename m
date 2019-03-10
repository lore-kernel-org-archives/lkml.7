Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC31C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 21:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697DE20652
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 21:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVXtGtbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfCJVhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 17:37:14 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:50575 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfCJVhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 17:37:13 -0400
Received: by mail-it1-f193.google.com with SMTP id m137so4240475ita.0;
        Sun, 10 Mar 2019 14:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=73P3Dft49iftY1p1QpC3pi8LiXQIFmDJRFgq+sY8vCA=;
        b=oVXtGtbEQZpFPC/JgrecJ+DmCTjyTQAktFMHka18apdweh96TngwSS7nIFuWZf7tgw
         +338Ay2YNVmiqdOz+XELTVnTLJvCzpadMqVcl55i31E0K9HjQxNYB5afYoaY76WjE/LS
         uFySCQPEMTQF/UvNRRflVup2qFumRV5JOxG9Kdl3sbzJ4Ls9XhAmp0WVmvDM8XhnTyQO
         NnHR2HTMA79BZN96XzJr4+V2/cNEmDKdGvjLzKDZVbunZ8nleJQ7cWUdCQtqhpmc7z/0
         6Dg041S3fYtwwvNuOiyzOOSMpSiwDo+fe1Uj0pejbZgingSJax3vjAoPDv4lT+eQ2eWR
         IZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=73P3Dft49iftY1p1QpC3pi8LiXQIFmDJRFgq+sY8vCA=;
        b=Kl0f62duQgaFBao4/HRPfrwWqUmBdwcLf/HFjyiELkmABrEZMShiDooyj0yMPuX9Lm
         InqVzHzu/BXDcp1wjQvUK9xLu33BNa0lNQN6rTZ6n3X+VLn8kM+Fg89cPYRhk2lnqtvq
         4yZm/Hynp92xjStfbwjebby3UItMf/Q8bjjDkCAnF2qBo4gU12jLvqi6qOFQJ14/IGi4
         oIBr1cZ9EtW/mdSeHhCpeAvCPdgw7/FUCR4NYdaGLv6Uy5dvdXkgU3tdHnFS25E5R/iB
         QB80nB92VhOCVxjAjC7PUZIEVVHbYQ3viaDpGmcuvFAC5vkOE9/DKPgh7mi/038UntX2
         tO2Q==
X-Gm-Message-State: APjAAAUFzmrsR49G/Ebt7mpRcJL9q2mLkX7n0K+lmmALW/fuTmwPCjCs
        06qAXiaw683juKIqbaeCm5TFCFHIndbs4dUytt8=
X-Google-Smtp-Source: APXvYqyO3KbGN9h0PGX2q1fbSgE4k0Mt8sipPHuCxWe/dGpY826Vw93oIahrb1ZhfGRCq6UdpE4oN3aDeRPUdmoxMD8=
X-Received: by 2002:a05:660c:883:: with SMTP id o3mr13195079itk.32.1552253832497;
 Sun, 10 Mar 2019 14:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez1RVd5mQ_Pb6eygQESaZhpQz765OAZYSoPE0kPqfZEXQg@mail.gmail.com>
 <20190305091904.GB8256@zn.tnic> <20190305122218.GD13380@bombadil.infradead.org>
 <20190305134347.4be2449c@alans-desktop> <20190305145717.GD8256@zn.tnic>
 <CAHk-=wi2E4kugAW7BQwNSVwYHOr=B_9EgzBRMpQ2+1dxAqydDg@mail.gmail.com>
 <20190305173134.GE8256@zn.tnic> <CAHk-=wg0bY=RFhD4NW9x++fC0bME=_-9xM3kexGGM3gefHQTyQ@mail.gmail.com>
 <20190305181138.GG8256@zn.tnic> <20190305181808.GH8256@zn.tnic>
In-Reply-To: <20190305181808.GH8256@zn.tnic>
From:   Matt Turner <mattst88@gmail.com>
Date:   Sun, 10 Mar 2019 14:37:00 -0700
Message-ID: <CAEdQ38G5M3vq9pGBV1iyEViO7JhFuXk5g+VCs-vUH+Z62kNqgQ@mail.gmail.com>
Subject: Re: [PATCH] x86: Deprecate a.out support
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 11:04 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Mar 05, 2019 at 07:11:38PM +0100, Borislav Petkov wrote:
> > I guess you could Cc arch maintainers with the a.out-core.h removal
> > patch to see if anyone screams.
>
> And they're like two for which we need confirmation:
>
> $ git ls-files | grep a.out-core.h
> arch/alpha/include/asm/a.out-core.h
> arch/m68k/include/asm/a.out-core.h
> arch/um/include/asm/a.out-core.h
> arch/x86/include/asm/a.out-core.h
>
> um and x86 are clear.
>
> Adding alpha and m68k MLs to Cc.

I'm not aware of a reason to keep a.out support on alpha.
