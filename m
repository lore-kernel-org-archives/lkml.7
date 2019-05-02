Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDE9C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 05:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3CF620873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 05:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqyT76+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfEBFmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 01:42:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43509 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfEBFmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 01:42:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id n8so504026plp.10;
        Wed, 01 May 2019 22:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EGH1MUM577FslO7/IvvF8BfMS+g7IS6EKHX5XHDHMT0=;
        b=bqyT76+VjZxOOqydpx77q1wViWG7RzQEH9NCYNlp0Cd6961tPtT1TUxSSvorjxVkXT
         0MDTSReKNbdrkbn1CEj29FDcQg5gnMAJMOhBK2lD3eocquQYQimBnmFFJwov7D4uMn+o
         iAWSpc40IQPGEOcHlZRq6xiXW42L4rccv+UvToiWBQ5JIkryVCjUD98dbtsHwkMg3YWD
         kvW09h9GxYF3AO/zila7bLOnS9qz2dSCCV4M6vJQLnIM9JGwmRDoY/G/AS+OzQGrsMfd
         72cHexwl2gIrTTAZlNGq3X37qfMvhhBhwDR9wK8wv1grL8X3F10vRNeyFyDouqMdG8bs
         +j1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EGH1MUM577FslO7/IvvF8BfMS+g7IS6EKHX5XHDHMT0=;
        b=XLFj1q8qzujLS4YW9NcAHvHUmcfGPtyeiCKiGEAiT8+Ju+Rb5nX/I3NmPlxXOpzEiS
         MYo0le+8Jbt3qydaDd2KrRAAL4vliMqUnq8YTuocn6A3aI3+SSCzH2kOu4MiCsTM+amH
         Lec7iwnF18y5RQx1Jm597D6BrTVdcRHq7A8ZnWShwgVY/DIZFc3/nR1kJtQEU+j01Kjq
         lnq0AyzZlJFmvb0NefaFdfxBnmMGZuQerX+mBT7eFT+t/J/JKTwQN3EkQgO90c5TB+DL
         yjTnqoOtjYGkEhuQe69L59mumn/qBQmLQK2NprUMGNlUPGh23KAousy/sz94xIm2477f
         zIPQ==
X-Gm-Message-State: APjAAAVbBzN9HSUCD646a6wqsVtHioRAaV3/2Z/OTvXeEcmTLGTfi89s
        cejljwEVzHVdUudbDK2FEJU=
X-Google-Smtp-Source: APXvYqw29TdjQIPjhLiujKI2+RF1Knz+NGn3wdpOxVdqER07W9h+l0ZWPM3S1DYD7PYFyecAl8Myhw==
X-Received: by 2002:a17:902:4523:: with SMTP id m32mr1705967pld.98.1556775735796;
        Wed, 01 May 2019 22:42:15 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id u5sm20047305pfb.60.2019.05.01.22.42.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 01 May 2019 22:42:15 -0700 (PDT)
Date:   Thu, 2 May 2019 13:42:04 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/27] Documentation: x86: convert i386/IO-APIC.txt to
 reST
Message-ID: <20190502054202.x2oli2ceseneyzdo@mail.google.com>
References: <20190426153150.21228-1-changbin.du@gmail.com>
 <20190426153150.21228-21-changbin.du@gmail.com>
 <20190427152449.19df3fcb@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427152449.19df3fcb@coco.lan>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 03:24:49PM -0300, Mauro Carvalho Chehab wrote:
> Em Fri, 26 Apr 2019 23:31:43 +0800
> Changbin Du <changbin.du@gmail.com> escreveu:
> 
> > This converts the plain text documentation to reStructuredText format and
> > add it to Sphinx TOC tree. No essential content change.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  .../x86/i386/{IO-APIC.txt => IO-APIC.rst}     | 26 ++++++++++++-------
> >  Documentation/x86/i386/index.rst              | 10 +++++++
> >  Documentation/x86/index.rst                   |  1 +
> >  3 files changed, 27 insertions(+), 10 deletions(-)
> >  rename Documentation/x86/i386/{IO-APIC.txt => IO-APIC.rst} (93%)
> >  create mode 100644 Documentation/x86/i386/index.rst
> > 
> > diff --git a/Documentation/x86/i386/IO-APIC.txt b/Documentation/x86/i386/IO-APIC.rst
> > similarity index 93%
> > rename from Documentation/x86/i386/IO-APIC.txt
> > rename to Documentation/x86/i386/IO-APIC.rst
> > index 15f5baf7e1b6..aec98f742763 100644
> > --- a/Documentation/x86/i386/IO-APIC.txt
> > +++ b/Documentation/x86/i386/IO-APIC.rst
> > @@ -1,3 +1,11 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=======
> > +IO-APIC
> > +=======
> > +
> > +:Author: Ingo Molnar <mingo@kernel.org>
> > +
> >  Most (all) Intel-MP compliant SMP boards have the so-called 'IO-APIC',
> >  which is an enhanced interrupt controller. It enables us to route
> >  hardware interrupts to multiple CPUs, or to CPU groups. Without an
> > @@ -13,7 +21,7 @@ usually worked around by the kernel. If your MP-compliant SMP board does
> >  not boot Linux, then consult the linux-smp mailing list archives first.
> >  
> >  If your box boots fine with enabled IO-APIC IRQs, then your
> > -/proc/interrupts will look like this one:
> > +/proc/interrupts will look like this one::
> >  
> >     ---------------------------->
> ...
>      <----------------------------
> 
> I would remove those lines, as they sounds like a way used by the
> doc author to "escape" a literal block.
>
Removed.

> Either way:
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> 
> 
> >    hell:~> cat /proc/interrupts  
> > @@ -37,14 +45,14 @@ none of those IRQ sources is performance-critical.
> >  In the unlikely case that your board does not create a working mp-table,
> >  you can use the pirq= boot parameter to 'hand-construct' IRQ entries. This
> >  is non-trivial though and cannot be automated. One sample /etc/lilo.conf
> > -entry:
> > +entry::
> >  
> >  	append="pirq=15,11,10"
> >  
> >  The actual numbers depend on your system, on your PCI cards and on their
> >  PCI slot position. Usually PCI slots are 'daisy chained' before they are
> >  connected to the PCI chipset IRQ routing facility (the incoming PIRQ1-4
> > -lines):
> > +lines)::
> >  
> >                 ,-.        ,-.        ,-.        ,-.        ,-.
> >       PIRQ4 ----| |-.    ,-| |-.    ,-| |-.    ,-| |--------| |
> > @@ -56,7 +64,7 @@ lines):
> >       PIRQ1 ----| |-  `----| |-  `----| |-  `----| |--------| |
> >                 `-'        `-'        `-'        `-'        `-'
> >  
> > -Every PCI card emits a PCI IRQ, which can be INTA, INTB, INTC or INTD:
> > +Every PCI card emits a PCI IRQ, which can be INTA, INTB, INTC or INTD::
> >  
> >                                 ,-.
> >                           INTD--| |
> > @@ -78,19 +86,19 @@ to have non shared interrupts). Slot5 should be used for videocards, they
> >  do not use interrupts normally, thus they are not daisy chained either.
> >  
> >  so if you have your SCSI card (IRQ11) in Slot1, Tulip card (IRQ9) in
> > -Slot2, then you'll have to specify this pirq= line:
> > +Slot2, then you'll have to specify this pirq= line::
> >  
> >  	append="pirq=11,9"
> >  
> >  the following script tries to figure out such a default pirq= line from
> > -your PCI configuration:
> > +your PCI configuration::
> >  
> >  	echo -n pirq=; echo `scanpci | grep T_L | cut -c56-` | sed 's/ /,/g'
> >  
> >  note that this script won't work if you have skipped a few slots or if your
> >  board does not do default daisy-chaining. (or the IO-APIC has the PIRQ pins
> >  connected in some strange way). E.g. if in the above case you have your SCSI
> > -card (IRQ11) in Slot3, and have Slot1 empty:
> > +card (IRQ11) in Slot3, and have Slot1 empty::
> >  
> >  	append="pirq=0,9,11"
> >  
> > @@ -105,7 +113,7 @@ won't function properly (e.g. if it's inserted as a module).
> >  If you have 2 PCI buses, then you can use up to 8 pirq values, although such
> >  boards tend to have a good configuration.
> >  
> > -Be prepared that it might happen that you need some strange pirq line:
> > +Be prepared that it might happen that you need some strange pirq line::
> >  
> >  	append="pirq=0,0,0,0,0,0,9,11"
> >  
> > @@ -115,5 +123,3 @@ Good luck and mail to linux-smp@vger.kernel.org or
> >  linux-kernel@vger.kernel.org if you have any problems that are not covered
> >  by this document.
> >  
> > --- mingo
> > -
> > diff --git a/Documentation/x86/i386/index.rst b/Documentation/x86/i386/index.rst
> > new file mode 100644
> > index 000000000000..8747cf5bbd49
> > --- /dev/null
> > +++ b/Documentation/x86/i386/index.rst
> > @@ -0,0 +1,10 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +============
> > +i386 Support
> > +============
> > +
> > +.. toctree::
> > +   :maxdepth: 2
> > +
> > +   IO-APIC
> > diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> > index 526f7a008b8e..19323c5b89ce 100644
> > --- a/Documentation/x86/index.rst
> > +++ b/Documentation/x86/index.rst
> > @@ -26,3 +26,4 @@ Linux x86 Support
> >     microcode
> >     resctrl_ui
> >     usb-legacy-support
> > +   i386/index
> 
> 
> 
> Thanks,
> Mauro

-- 
Cheers,
Changbin Du
