Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D462C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEFD20866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391433AbfFMQKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:10:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391415AbfFMQKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:10:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6D35681DEB;
        Thu, 13 Jun 2019 16:09:52 +0000 (UTC)
Received: from treble (ovpn-121-232.rdu2.redhat.com [10.10.121.232])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 28DD919700;
        Thu, 13 Jun 2019 16:09:49 +0000 (UTC)
Date:   Thu, 13 Jun 2019 11:09:47 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Julien Thierry <Julien.Thierry@arm.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [RFC V2 00/16] objtool: Add support for Arm64
Message-ID: <20190613160947.vlysyfmwuo3xshsc@treble>
References: <20190516103655.5509-1-raphael.gault@arm.com>
 <20190516142917.nuhh6dmfiufxqzls@treble>
 <26692833-0e5b-cfe0-0ffd-c2c2f0815935@arm.com>
 <20190528222415.x63qw55ujm33dozb@treble>
 <09745535-2782-fa11-ed65-3119b9455e79@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <09745535-2782-fa11-ed65-3119b9455e79@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 13 Jun 2019 16:10:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 04:55:31PM +0100, Raphael Gault wrote:
> Hi Josh,
> 
> On 5/28/19 11:24 PM, Josh Poimboeuf wrote:
> > On Tue, May 21, 2019 at 12:50:57PM +0000, Raphael Gault wrote:
> > > Hi Josh,
> > > 
> > > Thanks for offering your help and sorry for the late answer.
> > > 
> > > My understanding is that a table of offsets is built by GCC, those
> > > offsets being scaled by 4 before adding them to the base label.
> > > I believe the offsets are stored in the .rodata section. To find the
> > > size of that table, it is needed to find a comparison, which can be
> > > optimized out apprently. In that case the end of the array can be found
> > > by locating labels pointing to data behind it (which is not 100% safe).
> > > 
> > > On 5/16/19 3:29 PM, Josh Poimboeuf wrote:
> > > > On Thu, May 16, 2019 at 11:36:39AM +0100, Raphael Gault wrote:
> > > > > Noteworthy points:
> > > > > * I still haven't figured out how to detect switch-tables on arm64. I
> > > > > have a better understanding of them but still haven't implemented checks
> > > > > as it doesn't look trivial at all.
> > > > 
> > > > Switch tables were tricky to get right on x86.  If you share an example
> > > > (or even just a .o file) I can take a look.  Hopefully they're somewhat
> > > > similar to x86 switch tables.  Otherwise we may want to consider a
> > > > different approach (for example maybe a GCC plugin could help annotate
> > > > them).
> > > > 
> > > 
> > > The case which made me realize the issue is the one of
> > > arch/arm64/kernel/module.o:apply_relocate_add:
> > > 
> > > ```
> > > What seems to happen in the case of module.o is:
> > >    334:   90000015        adrp    x21, 0 <do_reloc>
> > > which retrieves the location of an offset in the rodata section, and a
> > > bit later we do some extra computation with it in order to compute the
> > > jump destination:
> > >    3e0:   78625aa0        ldrh    w0, [x21, w2, uxtw #1]
> > >    3e4:   10000061        adr     x1, 3f0 <apply_relocate_add+0xf8>
> > >    3e8:   8b20a820        add     x0, x1, w0, sxth #2
> > >    3ec:   d61f0000        br      x0
> > > ```
> > > 
> > > Please keep in mind that the actual offsets might vary.
> > > 
> > > I'm happy to provide more details about what I have identified if you
> > > want me to.
> > 
> > I get the feeling this is going to be trickier than x86 switch tables
> > (which have already been tricky enough).
> > 
> > On x86, there's a .rela.rodata section which applies relocations to
> > .rodata.  The presence of those relocations makes it relatively easy to
> > differentiate switch tables from other read-only data.  For example, we
> > can tell that a switch table ends when either a) there's not a text
> > relocation or b) another switch table begins.
> > 
> > But with arm64 I don't see a deterministic way to do that, because the
> > table offsets are hard-coded in .rodata, with no relocations.
> > 
> >  From talking with Kamalesh I got the impression that we might have a
> > similar issue for powerpc.
> > 
> > So I'm beginning to think we'll need compiler help.  Like a GCC plugin
> > that annotates at least the following switch table metadata:
> > 
> > - Branch instruction address
> > - Switch table address
> > - Switch table entry size
> > - Switch table size
> > 
> > The GCC plugin could write all the above metadata into a special section
> > which gets discarded at link time.  I can look at implementing it,
> > though I'll be traveling for two out of the next three weeks so it may
> > be a while before I can get to it.
> > 
> 
> I am completely new to GCC plugins but I had a look and I think I found a
> possible solution to retrieve at least part of this information using the
> RTL representation in GCC. I can't say it will work for sure but I would be
> happy to discuss it with you if you want.
> Although there are still some area I need to investigate related to
> interacting with the RTL representation and storing info into the ELF
> I'd be interested in giving it a try, if you are okay with that.

Sounds promising.  I've been stretched thin lately with other work, and
I'll be out again next week, so please go ahead :-)

-- 
Josh
