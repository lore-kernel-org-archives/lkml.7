Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C708BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A672087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfCLDpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 23:45:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfCLDpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 23:45:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E8C930832D8;
        Tue, 12 Mar 2019 03:45:41 +0000 (UTC)
Received: from localhost (ovpn-12-19.pek2.redhat.com [10.72.12.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F117608C8;
        Tue, 12 Mar 2019 03:45:40 +0000 (UTC)
Date:   Tue, 12 Mar 2019 11:45:37 +0800
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
Message-ID: <20190312034537.GL21116@MiWiFi-R3L-srv>
References: <20190216140008.28671-1-bhe@redhat.com>
 <20190216140008.28671-2-bhe@redhat.com>
 <CAGXu5j+MUrt70E6YiwM0QWOQxQeU9+rY7UPvuDrASne1pkCZLA@mail.gmail.com>
 <20190218031729.GG14858@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218031729.GG14858@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 12 Mar 2019 03:45:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/18/19 at 11:17am, Baoquan He wrote:
> > > + * When KASLR is active then the MM code makes sure that for each region
> > > + * there's such a single, dynamic, global base address 'unsigned long'
> > > + * variable available for the KASLR code to point to and modify directly:
> > > + *
> > > + *     { &page_offset_base, 0 },
> > > + *     { &vmalloc_base,     0 },
> > > + *     { &vmemmap_base,     1 },
> > > + *
> > > + * @size_tb: size in TB of each memory region. Thereinto, the size of
> > 
> > nit: "Thereinto" is odd. I'd say "Therefore".


Recheck here, there might be a misunderstanding. Here, 'Thereinto', I
want to say among the sizes of these three memory regions, the size of
the physical memory mapping region is variable. Just look it up in dict,
it sounds right. 'Therefore' equals to 'Hence' which is not expected
here. Am I right?
> 
> Will replace it with 'Therefore'.
> 
> > 
> > > + * the physical memory mapping region is variable, calculated according
> > > + * to the actual size of system RAM in order to save more space for
> > > + * randomization. The rest are fixed values related to paging mode.
> > > + *
> > > + * @size_tb: is the size of each memory region after randomization, and
> > > + * its unit is TB.
