Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D46C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 19:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D767206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 19:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYGH2L40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391458AbfIETxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 15:53:43 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34659 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfIETxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:53:43 -0400
Received: by mail-lf1-f66.google.com with SMTP id z21so3072378lfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 12:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9zCJtK2i3AG3fO1Xw+tQfg0dDvvG588ofrGHY7FaHlo=;
        b=sYGH2L40pXPqJzbDiQbnXeTLrE5oymwD0ylq9MIoUNupaLov9bprle3VbSx1S6H7nR
         dvNF5SN6nDG9uqKvE/vDSDi+d3q38Ou9sYP9c6OPADal64CWjd9sgJjVW0f++3f3+DBn
         LewH46zTcna/EpVABfOIAVLrrhqQ0EVFZmB95BLNn92ZLKtGcvGUj+SVJC/SkNCI2IwV
         IdIVhCzP8UUD91ohF8qI1rKrEJoPA8XJY2FGRa9JWsPaxcJMY2FC7oPyip3lQbwkgxb4
         Gd/UqdRb1gDH+o/e8hPC/89Hi+Kxoh6TLAfivgF4SWkLs7/u70kXigTZ6aU1+/MRNPbl
         Whtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9zCJtK2i3AG3fO1Xw+tQfg0dDvvG588ofrGHY7FaHlo=;
        b=V36n2W4w1Hd2yDd0ZOMu6hKp4toLPTzzvV6vEcfuNOk6VmwMGRE3zIm6xmJeVHGMru
         zvLVLUyFAWNzf3cZZIv7skMj9NDCC6yc8IL9y/A3UV6zxt8MY2arRQOfFbq4Kt1SorhN
         H9V2Ex0McYS5MPSd3KaVQN4AKggyvt7Kre1JmsalcAYh7myp969Sourz4byClXuKH52e
         ulKBd13FNnyra+4Q0s/77XZyXRGih8TnOzbaiUNMaEV37MqVfvWGpZAmLGrlm0axlnJ7
         oXqBMqlL9uEMJpbdUPOWpJJ0CnU+bPa1nnadB/aaf8VxIi3khylZlCVpLvNRBdNiJhpH
         OHSQ==
X-Gm-Message-State: APjAAAWC5Sgt8GH/CbSmF0zR0WVHIsyfdo7CXKGQFsENzUDiZk2pZM7P
        qXFPNHupy8DYBjZxjeLM1HirCmO8Wa4tNjxFVJY=
X-Google-Smtp-Source: APXvYqyY5bMJg4XnA+kFfos76RwPQPYC2mJjWGCx9v/liXcFaOHy8FjstKArgAjYDhciZiJxCL65dW7ARdCScWnuHvs=
X-Received: by 2002:ac2:52b8:: with SMTP id r24mr3819533lfm.131.1567713221154;
 Thu, 05 Sep 2019 12:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190904181740.GA19688@gmail.com> <CAHk-=wi2VOPoweqnDhxXKJ9fcLQzkV1oEDjteV=z-C7KXrpomg@mail.gmail.com>
 <CAKwvOdm3CbZ1Uad4b8+9HU8qDgTwSFw2oqjcAvFkR8jaQQN-5g@mail.gmail.com> <CAHk-=wjBsC0bWrCy++Gzimwwfx2+3kSaac9_PbBWmH9hrWdC8g@mail.gmail.com>
In-Reply-To: <CAHk-=wjBsC0bWrCy++Gzimwwfx2+3kSaac9_PbBWmH9hrWdC8g@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 5 Sep 2019 21:53:29 +0200
Message-ID: <CANiq72k-qrvf4C9fn=SaRaTzaLLoym6be=6otLEB3dzfq8musQ@mail.gmail.com>
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

On Thu, Sep 5, 2019 at 7:22 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> "Why not just clean up the rest" is how bugs happen.
>
> If it's not a fix, and it's not marked for stable (or a regression
> from the merge window) it shouldn't go in this late in the rc period.
>
> Send me _fixes_. Don't send me stuff that is "fixes plus random
> cleanups that were noticed at the same time".

Yeah, I was on the fence about this and I imagined you could also
react this way. I will be more firm next time :-)

On Nick's defense, he was trying to do his best to clean this up for
5.3 but AFAIK he got quite busy meanwhile during rc3-5.

Cheers,
Miguel
