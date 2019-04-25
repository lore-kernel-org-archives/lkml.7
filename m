Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D0EC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B9A218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGBxc+Yz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbfDYIVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:21:10 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34426 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfDYIVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:21:09 -0400
Received: by mail-io1-f68.google.com with SMTP id h26so3456017ioj.1;
        Thu, 25 Apr 2019 01:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rnJZSZFnULCRsZrHYmQhLyhrB7ogDN8kv1Uyzro7gws=;
        b=tGBxc+YzDWpHYkIvmCSgRz956C16OLgKkbIcmhzC+1xXoGO6zp3loSiQ7dXl+7dO+q
         9StlZmvfbiUnPNYQCH6g6kNLO/fcc9I9e6HlaKBYOH4O0skD4iSsKeo0vtbuRwZitAhS
         sx3eh3uobQKJ9ACBEilhlzVsxOJK2STZm67gzsaxAdNGfexgEMp+EEh/Gjpsgrzc3FBJ
         EBzN73jWiZOYyCgq4sejX8cT1j0yr8PLJZbUjiwQReQQgjGWuq4qkSNdY9hdmMlxGQaB
         xS6VTR8IHc7sS24lufmtVw2KfS2/pkns3U9hws2n8C14h18FNCMJkWO26IVJOUOfll6v
         BY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rnJZSZFnULCRsZrHYmQhLyhrB7ogDN8kv1Uyzro7gws=;
        b=CzAaK2uxRKK5jVAw2uPFbdBOTuoNNG8UCWf0tTrv8mxVUt2JbN68vk9rkJUlMDhSxb
         AOhj6ANHrZ4QmIq02dP84SPCvNk3akGHmb2Ly0mJlkz+w7cUrHPYG7gOVI5HLh5DKBEz
         Gu6ABQvx+T291YDmVTixOqE2Q+qMpapQyQZTVQqJAAYa8vUj48Xw1I77nNGgsojcfo2M
         STFcQY31SScZ9HDRttsl4wBmPfyNS94d5+ekdHxOOXvtQ0JH+na3feOPFZLXWGGsSmoT
         /+RpNnQpyAueraAxEwvTfsInO4yHU//zRvqsn6ZKZqH/fRlrIOpqum5D9Yq8e4a6Q0Kt
         ARbw==
X-Gm-Message-State: APjAAAUekyz/WnMX7ujoIJAQ1BVUxMEpagjmkpUOiu+xAkJloa2MeQSC
        f+qQIRQy3V6d+IWJowfgJz2TOBTTbGGpXiQSmQ==
X-Google-Smtp-Source: APXvYqyZF0VJ6H/W0KkhLLQMHoR91SLrqlZTBjABevwCr1pHSQAf6ZYLvaN8f4DDJv+zIohe3tXE9+56Cg1iuZAtgHk=
X-Received: by 2002:a6b:b54b:: with SMTP id e72mr645706iof.106.1556180468500;
 Thu, 25 Apr 2019 01:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <1556087581-14513-1-git-send-email-kernelfans@gmail.com> <10dc5468-6cd9-85c7-ba66-1dfa5aa922b7@suse.com>
In-Reply-To: <10dc5468-6cd9-85c7-ba66-1dfa5aa922b7@suse.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 25 Apr 2019 16:20:57 +0800
Message-ID: <CAFgQCTstd667wP6g+maxYekz4u3iBR2R=FHUiS1V=XxTs6MKUw@mail.gmail.com>
Subject: Re: [PATCHv2] kernel/crash: make parse_crashkernel()'s return value
 more indicant
To:     Matthias Brugger <mbrugger@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Rich Felker <dalias@libc.org>,
        linux-ia64@vger.kernel.org,
        Julien Thierry <julien.thierry@arm.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
        linux-mips@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-s390@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        David Hildenbrand <david@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Hogan <jhogan@kernel.org>,
        Dave Young <dyoung@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Borislav Petkov <bp@alien8.de>, Stefan Agner <stefan@agner.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, Tony Luck <tony.luck@intel.com>,
        Baoquan He <bhe@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Paul Burton <paul.burton@mips.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Greg Hackmann <ghackmann@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 4:31 PM Matthias Brugger <mbrugger@suse.com> wrote:
>
>
[...]
> > @@ -139,6 +141,8 @@ static int __init parse_crashkernel_simple(char *cmdline,
> >               pr_warn("crashkernel: unrecognized char: %c\n", *cur);
> >               return -EINVAL;
> >       }
> > +     if (*crash_size == 0)
> > +             return -EINVAL;
>
> This covers the case where I pass an argument like "crashkernel=0M" ?
> Can't we fix that by using kstrtoull() in memparse and check if the return value
> is < 0? In that case we could return without updating the retptr and we will be
> fine.
>
It seems that kstrtoull() treats 0M as invalid parameter, while
simple_strtoull() does not.

If changed like your suggestion, then all the callers of memparse()
will treats 0M as invalid parameter. This affects many components
besides kexec.  Not sure this can be done or not.

Regards,
Pingfan

> >
> >       return 0;
> >  }
> > @@ -181,6 +185,8 @@ static int __init parse_crashkernel_suffix(char *cmdline,
> >               pr_warn("crashkernel: unrecognized char: %c\n", *cur);
> >               return -EINVAL;
> >       }
> > +     if (*crash_size == 0)
> > +             return -EINVAL;
>
> Same here.
>
> >
> >       return 0;
> >  }
> > @@ -266,6 +272,8 @@ static int __init __parse_crashkernel(char *cmdline,
> >  /*
> >   * That function is the entry point for command line parsing and should be
> >   * called from the arch-specific code.
> > + * On success 0. On error for either syntax error or crash_size=0, -EINVAL is
> > + * returned.
> >   */
> >  int __init parse_crashkernel(char *cmdline,
> >                            unsigned long long system_ram,
> >
