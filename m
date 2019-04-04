Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C9AC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCD020855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbfDDOtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:49:40 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41113 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbfDDOtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:49:39 -0400
Received: by mail-lj1-f194.google.com with SMTP id k8so2337676lja.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 07:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=juueRY59R/m88qkqw19CEd+EkOE6j2K2smQOXFVEsWg=;
        b=id2//iQ4Fb/2L6ll7MXd0pRRwplwmRykBCk2Xx/6uGdiEdJ6pWxajpfNKKdr7HYMBI
         uw/Y92nxUFOMnlprnuIqmlAg4wnirLqtsBPNJ2F3Ee4alQD1eC0ELtaSdiqxD0NrnH0L
         GIJRTTSz+/v62/byEwADAhjukv6FgSfzeveLrVJvdtUW/5uLo6RREUSUyNzeFzmvsJQV
         uY5oKIPEYD9COSJtzsVmB6uYLwwzNP6m71qScNWQbkhzgaSztgNRZHMAaJ18wsu3fK1U
         2p47m25RQU2qLZDpY12AqE5/hPe3HHJtzYb1qNSXB/Ol5he7gS4hQQJkWYJr8V/lKSVl
         IMUA==
X-Gm-Message-State: APjAAAVSYTo1m5t/TbsAWjyV58vQpUWLDH8999FQqwaaRtl6q3HeSwYQ
        b+btb7RQVn++XFXNiD5uf0rLXm0Q+opBunwCNkeIIoLHkMs=
X-Google-Smtp-Source: APXvYqzXX6e2ZpolAsb00jCtcOm2ytmAxZbWErKg/30rpK5kUu6Zikwsm/NCvc8YXxJzqMcBJ5rQO6Ef4q7Q0jNFidc=
X-Received: by 2002:a2e:1245:: with SMTP id t66mr3798426lje.18.1554389377982;
 Thu, 04 Apr 2019 07:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190328130306.25384-1-mcroce@redhat.com> <20190403140203.qq37rgcikvoawb5f@brauner.io>
 <CAGnkfhx+igF579dez6qwAxrtT-JrGSSEn-QmK+92447qBqXPpg@mail.gmail.com>
 <20190403155108.GI22763@bombadil.infradead.org> <CAGnkfhxBafq4KeR8Jp5XBd7yWrMiofmEwqsCpb_7eL+ddgWagw@mail.gmail.com>
 <CAGnkfhyY7QmrGEk-YF9w-X78dHSDOPQMYtxBkVnpb0MS8DkVhQ@mail.gmail.com> <20190404140931.zpmcbfgdnlq6jkqn@brauner.io>
In-Reply-To: <20190404140931.zpmcbfgdnlq6jkqn@brauner.io>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Thu, 4 Apr 2019 16:49:02 +0200
Message-ID: <CAGnkfhzse+vu0VK1zaOig=o-ayPUTZGjjVYdReJcnZ+JyfOmxg@mail.gmail.com>
Subject: Re: [PATCH] kernel/sysctl.c: fix out of bounds access in fs.file-max
To:     Christian Brauner <christian@brauner.io>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Zev Weiss <zev@bewilderbeest.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 4:09 PM Christian Brauner <christian@brauner.io> wrote:
>
> On Wed, Apr 03, 2019 at 07:08:47PM +0200, Matteo Croce wrote:
> > On Wed, Apr 3, 2019 at 6:40 PM Matteo Croce <mcroce@redhat.com> wrote:
> > >
> > > On Wed, Apr 3, 2019 at 5:51 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Wed, Apr 03, 2019 at 05:24:26PM +0200, Matteo Croce wrote:
> > > > > On Wed, Apr 3, 2019 at 4:02 PM Christian Brauner <christian@brauner.io> wrote:
> > > > > > Yeah, maybe but it still feels cleaner and more obvious to just add:
> > > > > >
> > > > > > static long long_zero;
> > > > > >
> > > > > > given that most callers actually seem to want an (unsigned) int.
> > > > > >
> > > > > > I don't have a strong opinion though so if others feel that it's just a
> > > > > > waste of space consider it acked.
> > > > > >
> > > > >
> > > > > Well, given that the value is zero, in this expectional case we could
> > > > > avoid duplicating the symbol and save 4 bytes.
> > > > > What the maintainers think?
> > > >
> > > > If we care about saving four bytes, we could just pass the address of
> > > > ZERO_PAGE(0).
> > >
> > > That would work, work too, maybe it's a bit overkill.
> > > int zero is always there and it's static, so enlarging it to long
> > > should be a straightforward fix.
> > > Obviously we can't do it for other numbers, but we can alias it just
> > > for the zero case..
> > >
> > > Regards,
> > >
> > > --
> > > Matteo Croce
> > > per aspera ad upstream
> >
> > Anyway, I'm fine with both solutions, as I have other patches in the
>
> I think Matthew's idea gets us best of both worlds so I'd suggest to use
> it and resend the patch. You likely want to Cc stable@vger.kernel.org
> since the original patch this fixes got backported by Greg quite a bit
> since this was a rather long-standing issue. Please also Cc Andrew this
> time since he's likely going to pick it up.
>
> Thanks for the patch!
> Christian

So you mean using page_address(ZERO_PAGE(0)) ?
The idea is nice, but since struct ctl_table kern_table is declared as
global variable, how can I assign it to the structure?
GCC complains about 'initializer element is not constant', and
ZERO_PAGE(0)->virtual only works if WANT_PAGE_VIRTUAL.

Anyway, I'm preparing a treewide patch to move all "zero", "one" and
"int_max" to three single, const variables in fs/proc/proc_sysctl.c
as there are 200+ occourrences of them, so I'd rather keep this simple
to have it easily backported to stable.

-- 
Matteo Croce
per aspera ad upstream
