Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62051C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BB02084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfCLAzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 20:55:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbfCLAzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 20:55:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 08C2481F09;
        Tue, 12 Mar 2019 00:55:38 +0000 (UTC)
Received: from localhost (ovpn-12-19.pek2.redhat.com [10.72.12.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BC4F5DD84;
        Tue, 12 Mar 2019 00:55:37 +0000 (UTC)
Date:   Tue, 12 Mar 2019 08:55:34 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Mike Travis <travis@sgi.com>,
        Thomas Garnier <thgarnie@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v3 1/6] x86/mm/KASLR: Improve code comments about struct
 kaslr_memory_region
Message-ID: <20190312005534.GK21116@MiWiFi-R3L-srv>
References: <20190216140008.28671-1-bhe@redhat.com>
 <20190216140008.28671-2-bhe@redhat.com>
 <CAGXu5j+MUrt70E6YiwM0QWOQxQeU9+rY7UPvuDrASne1pkCZLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+MUrt70E6YiwM0QWOQxQeU9+rY7UPvuDrASne1pkCZLA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 12 Mar 2019 00:55:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/17/19 at 09:07am, Kees Cook wrote:
> > + * E.g the physical memory region, we limit the starting address to be
> > + * taken from the 1st 1/3 part of the whole available virtual address
> > + * space which is from 0xffff880000000000 to 0xfffffe0000000000, namely
> > + * the original starting address of the physical memory mapping region
> > + * to the starting address of cpu_entry_area mapping region. Once a random
> > + * address is chosen for the physical memory mapping, we jump over the
> > + * region and add 1G to begin the next region handling with the remaining
> > + * available space.
> 
> Should the "operation" comments (rather than the struct field
> comments) be moved to the start of the kernel_randomize_memory()
> function instead?

Rethink about this, I think you are right. This paragraph better be
moved to above kernel_randomize_memory(), to explain its behaviour.
Will update and repost. Thanks.

Thanks
Baoquan

> 
> >   */
> > +
> >  static __initdata struct kaslr_memory_region {
> >         unsigned long *base;
> >         unsigned long size_tb;
> > --
> > 2.17.2
> >
> 
> 
> -- 
> Kees Cook
