Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95551C31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 01:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC412082C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 01:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="vcKtePLx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfFNBRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 21:17:47 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34118 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfFNBRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 21:17:47 -0400
Received: by mail-oi1-f196.google.com with SMTP id j184so779602oih.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 18:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8nbgoaA9t+VRRLs+GjQMqxqxNpifdpztNtP3T59dnl0=;
        b=vcKtePLxEoFUoXy+89bQnDDlZ0mUEPsGWsAYPOgRInH7NilDUDLImYUbNTQhZvJYlL
         3GmJ1IDvfOkbX1aykOjRJzjlrymJucTJ3b89o7Oxq1rDU+qr9udIXor3Ji7DKQKWd5Fr
         vqH0KgpaGote+shp3W2x5LAlrIfKSF8ZpXdS6tOBnfRzUc24Xwo5krz/ZTOD+Ezb0wFH
         N7jTA00CjMa9VcbDY+sL0im8c3B+PmKc1OyqgzGlkFBXOVpXBQk3gvXBPfLtpNKQ8K9g
         iZQtDJLRjtiSv/j3bdtRMTKZs45r31pqFO0qn5vNRQ/HG5uXC/4ny592rMfZkZn6rnL7
         2WVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8nbgoaA9t+VRRLs+GjQMqxqxNpifdpztNtP3T59dnl0=;
        b=iUtgnHa5mfg3LKizgKg+U3g860Y6ASwQlR60Xwof+aJl703K2acY0YltW7e0OjqLcV
         n+3gXWO5TgCy6Wx83UIRnnogvJrKYAcU7DVVivgdMvx36xKHe63A7+408DkKVN01Qv5b
         6M8T+ptBlCM/wKVHCxtrp1TfxQwaePVs2S32h/a29C1muLo9KP/7AuUeXsRyClPI3/Ul
         aZbAqelkR5tD5JsKU/FMv4I7m9qcEsZ5s9CDosxaBfoeOF8EV4zOgNEvs5xcm67LF/r2
         xni9xZ5K2j4jrJWACvxL8hZdECvOaiJcjVu8T6uel+KPYJj1aLJbac47hDBb1zTAIs8P
         j/Fw==
X-Gm-Message-State: APjAAAUMwKXi7PgiQtJ68AqyWHpGWs7l4LCb787rTE/jur03+AP8mutX
        cLg4DSO+ZWCgMlsICFCjDNGebIi5xKxe4wZ4YADt6Q==
X-Google-Smtp-Source: APXvYqwnLvLUXAIBseQng2RkfJRQeHEAdwzemebMnlXZNkRFXGIM74a/VpUj/BftE9ogX5hDYp+SuC6GzNHuSRcTVD0=
X-Received: by 2002:aca:ec82:: with SMTP id k124mr222963oih.73.1560475066694;
 Thu, 13 Jun 2019 18:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <1560366952-10660-1-git-send-email-cai@lca.pw> <CAPcyv4hn0Vz24s5EWKr39roXORtBTevZf7dDutH+jwapgV3oSw@mail.gmail.com>
 <1560451362.5154.14.camel@lca.pw>
In-Reply-To: <1560451362.5154.14.camel@lca.pw>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 13 Jun 2019 18:17:34 -0700
Message-ID: <CAPcyv4hYfDtRHF-i0dNzo=ffQk6qnrasRwkVfAVnwgWj0PJ4jg@mail.gmail.com>
Subject: Re: [PATCH -next] mm/hotplug: skip bad PFNs from pfn_to_online_page()
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 11:42 AM Qian Cai <cai@lca.pw> wrote:
>
> On Wed, 2019-06-12 at 12:37 -0700, Dan Williams wrote:
> > On Wed, Jun 12, 2019 at 12:16 PM Qian Cai <cai@lca.pw> wrote:
> > >
> > > The linux-next commit "mm/sparsemem: Add helpers track active portions
> > > of a section at boot" [1] causes a crash below when the first kmemleak
> > > scan kthread kicks in. This is because kmemleak_scan() calls
> > > pfn_to_online_page(() which calls pfn_valid_within() instead of
> > > pfn_valid() on x86 due to CONFIG_HOLES_IN_ZONE=n.
> > >
> > > The commit [1] did add an additional check of pfn_section_valid() in
> > > pfn_valid(), but forgot to add it in the above code path.
> > >
> > > page:ffffea0002748000 is uninitialized and poisoned
> > > raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
> > > raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
> > > page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
> > > ------------[ cut here ]------------
> > > kernel BUG at include/linux/mm.h:1084!
> > > invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
> > > CPU: 5 PID: 332 Comm: kmemleak Not tainted 5.2.0-rc4-next-20190612+ #6
> > > Hardware name: Lenovo ThinkSystem SR530 -[7X07RCZ000]-/-[7X07RCZ000]-,
> > > BIOS -[TEE113T-1.00]- 07/07/2017
> > > RIP: 0010:kmemleak_scan+0x6df/0xad0
> > > Call Trace:
> > >  kmemleak_scan_thread+0x9f/0xc7
> > >  kthread+0x1d2/0x1f0
> > >  ret_from_fork+0x35/0x4
> > >
> > > [1] https://patchwork.kernel.org/patch/10977957/
> > >
> > > Signed-off-by: Qian Cai <cai@lca.pw>
> > > ---
> > >  include/linux/memory_hotplug.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> > > index 0b8a5e5ef2da..f02be86077e3 100644
> > > --- a/include/linux/memory_hotplug.h
> > > +++ b/include/linux/memory_hotplug.h
> > > @@ -28,6 +28,7 @@
> > >         unsigned long ___nr = pfn_to_section_nr(___pfn);           \
> > >                                                                    \
> > >         if (___nr < NR_MEM_SECTIONS && online_section_nr(___nr) && \
> > > +           pfn_section_valid(__nr_to_section(___nr), pfn) &&      \
> > >             pfn_valid_within(___pfn))                              \
> > >                 ___page = pfn_to_page(___pfn);                     \
> > >         ___page;                                                   \
> >
> > Looks ok to me:
> >
> > Acked-by: Dan Williams <dan.j.williams@intel.com>
> >
> > ...but why is pfn_to_online_page() a multi-line macro instead of a
> > static inline like all the helper routines it invokes?
>
> Sigh, probably because it is a mess over there.
>
> memory_hotplug.h and mmzone.h are included each other. Converted it directly to
> a static inline triggers compilation errors because mmzone.h was included
> somewhere else and found pfn_to_online_page() needs things like
> pfn_valid_within() and online_section_nr() etc which are only defined later in
> mmzone.h.

Ok, makes sense I had I assumed it was something horrible like that.

Qian, can you send more details on the reproduction steps for the
failures you are seeing? Like configs and platforms you're testing.
I've tried enabling kmemleak and offlining memory and have yet to
trigger these failures. I also have a couple people willing to help me
out with tracking down the PowerPC issue, but I assume they need some
help with the reproduction as well.
