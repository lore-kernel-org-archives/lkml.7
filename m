Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F040CC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A55217FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387453AbfDQVUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:20:15 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58981 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfDQVUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 17:20:15 -0400
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hGryH-0005mC-Kp; Wed, 17 Apr 2019 23:19:57 +0200
Date:   Wed, 17 Apr 2019 23:19:50 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nadav Amit <nadav.amit@gmail.com>
cc:     Ingo Molnar <mingo@kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>, juergh@gmail.com,
        Tycho Andersen <tycho@tycho.ws>, jsteckli@amazon.de,
        keescook@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        deepa.srinivasan@oracle.com, chris.hyser@oracle.com,
        tyhicks@canonical.com, David Woodhouse <dwmw@amazon.co.uk>,
        Andrew Cooper <andrew.cooper3@citrix.com>, jcm@redhat.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        iommu <iommu@lists.linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-arm-kernel@lists.infradead.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Khalid Aziz <khalid@gonehiking.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Dave Hansen <dave@sr71.net>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arjan van de Ven <arjan@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
 Ownership (XPFO)
In-Reply-To: <063753CC-5D83-4789-B594-019048DE22D9@gmail.com>
Message-ID: <alpine.DEB.2.21.1904172317460.3174@nanos.tec.linutronix.de>
References: <cover.1554248001.git.khalid.aziz@oracle.com> <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com> <20190417161042.GA43453@gmail.com> <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com> <20190417170918.GA68678@gmail.com>
 <56A175F6-E5DA-4BBD-B244-53B786F27B7F@gmail.com> <20190417172632.GA95485@gmail.com> <063753CC-5D83-4789-B594-019048DE22D9@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1402638458-1555535997=:3174"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1402638458-1555535997=:3174
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 17 Apr 2019, Nadav Amit wrote:
> > On Apr 17, 2019, at 10:26 AM, Ingo Molnar <mingo@kernel.org> wrote:
> >> As I was curious, I looked at the paper. Here is a quote from it:
> >> 
> >> "In x86-64, however, the permissions of physmap are not in sane state.
> >> Kernels up to v3.8.13 violate the W^X property by mapping the entire region
> >> as “readable, writeable, and executable” (RWX)—only very recent kernels
> >> (≥v3.9) use the more conservative RW mapping.”
> > 
> > But v3.8.13 is a 5+ years old kernel, it doesn't count as a "modern" 
> > kernel in any sense of the word. For any proposed patchset with 
> > significant complexity and non-trivial costs the benchmark version 
> > threshold is the "current upstream kernel".
> > 
> > So does that quote address my followup questions:
> > 
> >> Is this actually true of modern x86-64 kernels? We've locked down W^X
> >> protections in general.
> >> 
> >> I.e. this conclusion:
> >> 
> >>  "Therefore, by simply overwriting kfptr with 0xFFFF87FF9F080000 and
> >>   triggering the kernel to dereference it, an attacker can directly
> >>   execute shell code with kernel privileges."
> >> 
> >> ... appears to be predicated on imperfect W^X protections on the x86-64
> >> kernel.
> >> 
> >> Do such holes exist on the latest x86-64 kernel? If yes, is there a
> >> reason to believe that these W^X holes cannot be fixed, or that any fix
> >> would be more expensive than XPFO?
> > 
> > ?
> > 
> > What you are proposing here is a XPFO patch-set against recent kernels 
> > with significant runtime overhead, so my questions about the W^X holes 
> > are warranted.
> > 
> 
> Just to clarify - I am an innocent bystander and have no part in this work.
> I was just looking (again) at the paper, as I was curious due to the recent
> patches that I sent that improve W^X protection.

It's not necessarily a W+X issue. The user space text is mapped in the
kernel as well and even if it is mapped RX then this can happen. So any
kernel mappings of user space text need to be mapped NX!

Thanks,

	tglx
--8323329-1402638458-1555535997=:3174--
