Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4B0C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 04:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02942075E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 04:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfEVEuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 00:50:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfEVEuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 00:50:40 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CA5013082B15;
        Wed, 22 May 2019 04:50:39 +0000 (UTC)
Received: from localhost (ovpn-12-45.pek2.redhat.com [10.72.12.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DD5927CD6;
        Wed, 22 May 2019 04:50:36 +0000 (UTC)
Date:   Wed, 22 May 2019 12:50:33 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        bp@alien8.de, hpa@zytor.com, kirill.shutemov@linux.intel.com,
        x86@kernel.org
Subject: Re: [PATCH v4 2/3] x86/kexec/64: Error out if try to jump to old
 4-level kernel from 5-level kernel
Message-ID: <20190522045033.GC3805@MiWiFi-R3L-srv>
References: <20190509013644.1246-1-bhe@redhat.com>
 <20190509013644.1246-3-bhe@redhat.com>
 <20190522032029.GB31269@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522032029.GB31269@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 22 May 2019 04:50:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22/19 at 11:20am, Dave Young wrote:
> How about the userspace kexec-tools?  It needs a similar detection, but
> I'm not sure how to detect paging mode, maybe some sysfs entry or
> vmcoreinfo in /proc/vmcore

In usersapce, I plan to parse /proc/kcore to get the starting address
of page_offset or vmalloc. You can see the different level has different
value range.

4-level:
   ffff888000000000 | -119.5  TB | ffffc87fffffffff |   64 TB | direct mapping of all physical memory (page_offset_base)
   ffffc88000000000 |  -55.5  TB | ffffc8ffffffffff |  0.5 TB | ... unused hole
   ffffc90000000000 |  -55    TB | ffffe8ffffffffff |   32 TB | vmalloc/ioremap space (vmalloc_base)
   ffffe90000000000 |  -23    TB | ffffe9ffffffffff |    1 TB | ... unused hole
   ffffea0000000000 |  -22    TB | ffffeaffffffffff |    1 TB | virtual memory map (vmemmap_base)


5-level:
   ff11000000000000 |  -59.75 PB | ff90ffffffffffff |   32 PB | direct mapping of all physical memory (page_offset_base)
   ff91000000000000 |  -27.75 PB | ff9fffffffffffff | 3.75 PB | ... unused hole
   ffa0000000000000 |  -24    PB | ffd1ffffffffffff | 12.5 PB | vmalloc/ioremap space (vmalloc_base)
   ffd2000000000000 |  -11.5  PB | ffd3ffffffffffff |  0.5 PB | ... unused hole
   ffd4000000000000 |  -11    PB | ffd5ffffffffffff |  0.5 PB | virtual memory map (vmemmap_base)
> 
> 
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> > index 22f60dd26460..858cc892672f 100644
> > --- a/arch/x86/kernel/kexec-bzimage64.c
> > +++ b/arch/x86/kernel/kexec-bzimage64.c
> > @@ -321,6 +321,11 @@ static int bzImage64_probe(const char *buf, unsigned long len)
> >  		return ret;
> >  	}
> >  
> > +	if (!(header->xloadflags & XLF_5LEVEL) && pgtable_l5_enabled()) {
> > +		pr_err("Can not jump to old 4-level kernel from 5-level kernel.\n");
> 
> 4-level kernel sounds not very clear, maybe something like below?
> 
> "5-level paging enabled, can not kexec into an old kernel without 5-level
> paging facility"?

Oops, tglx commented on this message. He suggested changing it like:

	"bzImage cannot handle 5-level paging mode\n"

I forgot updating this part. Any one is fine to me. Will update.

Thanks
Baoquan
