Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBDBC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 22:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A708217D4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 22:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbfDDWGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 18:06:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46504 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfDDWGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 18:06:30 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCAUy-00030m-Gn; Fri, 05 Apr 2019 00:06:16 +0200
Date:   Fri, 5 Apr 2019 00:06:16 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     =?ISO-8859-15?Q?Jan_H=2E_Sch=F6nherr?= <jan@schnhrr.de>
cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] x86/tsc: Allow quick PIT calibration despite
 interruptions
In-Reply-To: <alpine.DEB.2.21.1902142320300.1646@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1904050005130.1802@nanos.tec.linutronix.de>
References: <20190214214608.8672-1-jan@schnhrr.de> <alpine.DEB.2.21.1902142320300.1646@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1007672906-1554415576=:1802"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1007672906-1554415576=:1802
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 14 Feb 2019, Thomas Gleixner wrote:
> On Thu, 14 Feb 2019, Jan H. Schönherr wrote:
> 
> Cc+: Linus (he wrote the original implementation and might have opinions)
> 
> > Some systems experience regular interruptions (60 Hz SMI?), that prevent
> > the quick PIT calibration from succeeding: individual interruptions can be
> > so long, that the PIT MSB is observed to decrement by 2 or 3 instead of 1.
> > The existing code cannot recover from this.
> > 
> > The system in question is an AMD Ryzen Threadripper 2950X, microcode
> > 0x800820b, on an ASRock Fatal1ty X399 Professional Gaming, BIOS P3.30.
> > 
> > Change the code to handle (almost) arbitrary interruptions, as long
> > as they happen only once in a while and they do not take too long.
> > Specifically, also cover an interruption during the very first reads.
> > 
> > Signed-off-by: Jan H. Schönherr <jan@schnhrr.de>
> > ---
> > 
> > v2:
> > - Dropped the other hacky patch for the time being.
> > - Fixed the early exit check.
> > - Hopefully fixed all inaccurate math in v1.
> > - Extended comments.
> 
> That looks halfways sane, but I'm way too tired to wrap my head around
> it right now.

Went through it again and did not find any obvious issue. Nice work!

> Vs. comments: The big comment above pit_verify_msb() needs a big overhaul
> as well.

Would you please fix that up and repost?

Thanks,

	tglx
--8323329-1007672906-1554415576=:1802--
