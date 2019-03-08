Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEC2C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE8320851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P6TjMG7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfCHVKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:10:00 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39335 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfCHVKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 16:10:00 -0500
Received: by mail-pf1-f196.google.com with SMTP id i20so15008528pfo.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 13:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S1cde1jQsu/UmZpXHCI4YVyEziLBMknSj83sr+RMBZs=;
        b=P6TjMG7fGRK7XyKsHWb0VTW6Q9whc9pDX0eApYKLPbELPHCHHvNO1r7DQOut67QdQf
         FuTtzYitbpr7AHdi+ap23htEvIVldeQFt0CZig1xUByIAmLIDI2O4k4YHsBwJ64kaQWd
         tv9j1KHx2JH1J2tmZPJhMNVFB8etwLial5vzaeR/9qwAV2c1yBvLA3TTyt4/i+HmPcTL
         T/oBwnARgQbuOoODRHRkgsClw63M47siEORCvHIoDAARpKe6irP/WtLHcw7Dj8eT5JuA
         Ilbxwx/EPXlacKb9cRMv1rJi0/JemVW4Hm0J0lIdqHk5YR9babjNToAKh+r2oIKnNfY4
         f0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S1cde1jQsu/UmZpXHCI4YVyEziLBMknSj83sr+RMBZs=;
        b=esS1ZmAmeQi+Z9B9SdklzBWANOW/f3aqe3Wh5jkmGE+DI4dBz09fyyMzf9cHFikJMU
         RBuq2IEu4q5qRX3P2ZuFEgTp+TbYqBiMmDCIDi5ZhfFq9kd4W8VS6f+3w4tlJxdrcHyB
         0EcXqwOaBBRz7y/f9CsdEI5kTMzM4Qb9PVjgUxjGmcU1e98E56Z6NT9AsRXhCdLmCQNq
         5fEk70/Q9Jiiks3g/4p+UdUKMNzZmzI0CaGqp2GmioF+2hr2MNolJuJAEqc9czk0FPKz
         ylHivoz6zSEVM1Bvh4pvCTYpQvDkMl07gbJfc58bBPTaBjfqSoGF8fmZtc7hZN+0zvw7
         3jnw==
X-Gm-Message-State: APjAAAVEWN8UlXeC1eZuwItIyE2OzQ4pTWpYxiVCC+YLdobB2Q1uj8/J
        8BN78yxR+c7DxIMgUUuhSa1T4Rsz50SuoZK4Dw65PQ==
X-Google-Smtp-Source: APXvYqxaUQ5jhATdW1RKgLqB4lqdILD9dACC3jIaYW5eDACGP9qzaugQ2z2LCqttDQxBnJJNnWoLEVD25z3YeGBTuYs=
X-Received: by 2002:a17:902:56a:: with SMTP id 97mr20702494plf.320.1552079398761;
 Fri, 08 Mar 2019 13:09:58 -0800 (PST)
MIME-Version: 1.0
References: <20190307091218.2343836-1-arnd@arndb.de> <20190307152805.GA25101@redhat.com>
 <CAK8P3a2fuD-UBJET_OBKekCxrTDpnAxb0Bpu2LCCXaVT3pXTMQ@mail.gmail.com>
 <20190307164647.GC25101@redhat.com> <CAK8P3a2FU55-7wQnLXDAmRCgiZ-W+2rY6p7CrTiKNe0wda-Hsg@mail.gmail.com>
 <CAKwvOd=nyhM72CxdO-YYSsXr7rh3LUALn_ezVNzyiBaOD7KZkA@mail.gmail.com> <31b6d5bdfda9cbadffa6d8cb3ad0991e237a364c.camel@perches.com>
In-Reply-To: <31b6d5bdfda9cbadffa6d8cb3ad0991e237a364c.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Mar 2019 13:09:47 -0800
Message-ID: <CAKwvOd=+_FjWmo2McyLOAL3r6JOuu1wZEzQknY-GToDnCwzhsQ@mail.gmail.com>
Subject: Re: [PATCH] signal: fix building with clang
To:     Joe Perches <joe@perches.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 4:27 PM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2019-03-07 at 16:22 -0800, Nick Desaulniers wrote:
> > On Thu, Mar 7, 2019 at 1:45 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > I'd have to try, but I think you are right. It was probably an
> > > overoptimization back in 1997 when the code got added to
> > > linux-2.1.68pre1, and compilers have become smarter in the
> > > meantime ;-)
> >
> > How do you track history pre-git (2.6.XX)?
>
> https://landley.net/kdocs/fullhist/

Ah neat! Thanks for the link.  Now to wire that up to fugitive:
http://vimcasts.org/episodes/fugitive-vim-exploring-the-history-of-a-git-repository/

The LLVM project recently switched to git from svn.  For quite some
time the move was delayed in order to preserve history (including for
parked release branches and all kinds of edge cases and things that
don't quite translate from svn to git).  Now I better appreciate the
history preservation.
-- 
Thanks,
~Nick Desaulniers
