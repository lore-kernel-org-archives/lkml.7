Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC429C468C1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 06:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8CC207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 06:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387902AbfFJGvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 02:51:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57508 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387614AbfFJGvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 02:51:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 99CE5307D854;
        Mon, 10 Jun 2019 06:51:53 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-59.pek2.redhat.com [10.72.12.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 876F71975F;
        Mon, 10 Jun 2019 06:51:49 +0000 (UTC)
Date:   Mon, 10 Jun 2019 14:51:45 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Pingfan Liu <kernelfans@gmail.com>, kexec@lists.infradead.org,
        Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, yinghai@kernel.org,
        vgoyal@redhat.com, Randy Dunlap <rdunlap@infradead.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190610065145.GF3388@dhcp-128-65.nay.redhat.com>
References: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
 <20190125103924.GB27998@zn.tnic>
 <20190125134518.GA23595@dhcp-128-65.nay.redhat.com>
 <20190125140823.GC27998@zn.tnic>
 <20190128095809.GC3732@dhcp-128-65.nay.redhat.com>
 <20190128101831.GA27154@zn.tnic>
 <20190607173016.GM20269@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607173016.GM20269@zn.tnic>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 10 Jun 2019 06:51:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/19 at 07:30pm, Borislav Petkov wrote:
> On Mon, Jan 28, 2019 at 11:18:31AM +0100, Borislav Petkov wrote:
> > On Mon, Jan 28, 2019 at 05:58:09PM +0800, Dave Young wrote:
> > > Another reason is in case ,high we will need automatically reserve a
> > > region in low area for swiotlb.  So for example one use
> > > crashkernel=256M,high,  actual reserved memory is 256M above 4G and
> > > another 256M under 4G for swiotlb.  Normally it is not necessary for
> > > most people.  Thus we can not make ,high as default.
> > 
> > And how is the poor user to figure out that we decided for her/him that
> > swiotlb reservation is something not necessary for most people and thus
> > we fail the crashkernel= reservation?
> > 
> > IOW, that "logic" above doesn't make a whole lot of sense to me from
> > user friendliness perspective.
> 
> So to show what I mean: I'm trying to reserve a crash kernel region on a
> box here. I tried:
> 
> crashkernel=64M@16M
> 
> as it is stated in Documentation/kdump/kdump.txt.
> 
> Box said:
> 
> [    0.000000] crashkernel reservation failed - memory is in use.
> 
> Oh great.
> 
> Then I tried:
> 
> crashkernel=64M@64M
> 
> Box said:
> 
> [    0.000000] crashkernel reservation failed - memory is in use.
> 
> So I simply did:
> 
> crashkernel=64M
> 
> and the box said:
> 
> [    0.000000] Reserving 64MB of memory at 3392MB for crashkernel (System RAM: 16271MB)
> 
> So I could've gone a long time poking at the memory to find a suitable
> address.
> 
> So do you see what I mean with making this as user-friendly and as
> robust as possible?

Yes, it is clear to me, I absolutely agree that is not friendly :)

Previously without KASLR, one can check /proc/iomem to find a possible
free area and use it for next and future boot.  But in case KASLR
enabled nowadays it become harder to predict the persistent free areas.

> 
> In this case I don't care about *where* my crash kernel is - I only want
> to have one loaded *somewhere*.

We would suggest people to use crashkernel=X instead.  for the X@Y
I believe it is some historic thing, it *should* be able to be obsolete
at least on X86, (not sure other arches).
I expect people can comment if they have some use cases requiring this
X@Y way. 

We have modified the crashkernel=X to search 0 - 4G memory instead
of old 0 - 896M for low memory areas, so a possible case is people who
uses very old kexec-tools which can only load kernel to memory under
896M.

Another way is we just obsolete X@Y, but introduce another interface
like crahskernel=X,max=  (max will be used like the CRASH_ADDR_HIGH_MAX
in arch/x86/kernel/setup.c)

> 
> And the same strategy should be applied to other reservation attempts
> - we should try hard to reserve and if we cannot reserve, then try an
> alternating range.
> 
> I even think that
> 
> crashkernel=X@Y
> 
> should not simply fail if Y is occupied but keep trying and say
> 
> [    0.000000] Reserving 64MB of memory at alternative address 3392MB for crashkernel (System RAM: 16271MB)
> 
> and only fail when the user doesn't really want the kernel to try hard
> by booting with
> 
> crashkernel=X@Y,strict
> 
> But that's for another day.

Maybe X@Y,max=..  Then kernel will search begin with Y, and stop until
max - 1;

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.

Thanks
Dave
