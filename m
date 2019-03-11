Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AD8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 02:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A7720657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 02:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfCKCtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 22:49:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbfCKCtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 22:49:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7D17D307E046;
        Mon, 11 Mar 2019 02:49:12 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB1D6600C7;
        Mon, 11 Mar 2019 02:49:11 +0000 (UTC)
Date:   Mon, 11 Mar 2019 10:49:08 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Pingfan Liu <kernelfans@gmail.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/boot/KASLR: skip the specified crashkernel reserved
 region
Message-ID: <20190311024908.GE21116@MiWiFi-R3L-srv>
References: <1551081596-2856-1-git-send-email-kernelfans@gmail.com>
 <20190225094522.GC26145@zn.tnic>
 <CAFgQCTtYp5mV0xmt4ZJbS0igBFe8S1ZbUnuTWE1-wj8CuHPJew@mail.gmail.com>
 <20190226104653.GB14836@zn.tnic>
 <20190227013034.GP14858@MiWiFi-R3L-srv>
 <20190227073958.GA1786@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227073958.GA1786@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 11 Mar 2019 02:49:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27/19 at 08:39am, Borislav Petkov wrote:
> + Kees.
> 
> @Kees, you might want to go upthread a bit for context.
> 
> On Wed, Feb 27, 2019 at 09:30:34AM +0800, Baoquan He wrote:
> > Agree that 'crashkernel=x' should be encouraged to use as the first
> > choice when reserve crashkernel. If we decide to not obsolete
> > 'crashkernel=x@y', it will leave a unstable kernel parameter.
> 
> Is anyone even talking about obsoleting this?
> 
> And if anyone is, anyone can think a bit why we can't do this.

Oh, just a saying about that. If we can't prove this is a good fix,
we may need to persuit resolving it in other ways. Like obsoleting, or
adding a doc to notice user.

As for 'crashkernel=x@y', I rethink about it later, it's userful for user
in some cases. E.g those kinds of big server with hundreds of CPU and
tons of PCI-e devices (we did get report about kdump issue on this kind
of machine, and 'crashkernel=x@y' is needed), they can make use of
'crashkernel=x@y' to specify a memory region to make crash kernel be very
far away from 4G position, e.g 20G. Then if kernel crashed because of some
driver issues, etc, we can exclude the suspicion of crashkernel region.

> > Another worry is that KASLR won't always fail 'crashkernel=x@y',
> > customer may set and check in testing stage, then later in production
> > environment one time of neglect to not check may cause carashed kernel
> > uncaptured.
> >
> > IMHO, 'crashkernel=x@y' is similar to those specified memmap=ss[#$!]nn
> > which have been avoided in boot stage KASLR.
> 
> So my worry is that by specifying too many exclusion ranges, we might
> limit the kaslr space too much and make it too predictable. Especially
> since distros slap those things automatically and most users take them
> for granted.

Indeed. There have been so many avoided regions that the original KASLR
code has been covered with a bundle of atches. This add difficulity to
code maintaining of kernel text KASLR. However, most of time they won't
be specified at one time in one system. And on small systems, like virt
guest system, memmap=, mem= may not be added. As for crashkernel=x@y, it
may not expect too much memory, basically 256 MB can cover more than 90%
of systems. Have to admit that code complixity will be increased a
little because of 'crashkernel=x@y' handling, yet it won't weaken KASLR
much.

Personal opinion.

Thanks
Baoquan
