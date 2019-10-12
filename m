Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB563C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 12:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96842089C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 12:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbfJLMQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 08:16:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbfJLMQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 08:16:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EF21F3082A98;
        Sat, 12 Oct 2019 12:16:37 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-125.pek2.redhat.com [10.72.12.125])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CECEE10013D9;
        Sat, 12 Oct 2019 12:16:32 +0000 (UTC)
Date:   Sat, 12 Oct 2019 20:16:25 +0800
From:   Dave Young <dyoung@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Lianbo Jiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, bhe@redhat.com, jgross@suse.com,
        dhowells@redhat.com, Thomas.Lendacky@amd.com, vgoyal@redhat.com,
        kexec@lists.infradead.org
Subject: Re: [PATCH 3/3 v3] x86/kdump: clean up all the code related to the
 backup region
Message-ID: <20191012121625.GA11587@dhcp-128-65.nay.redhat.com>
References: <20191012022140.19003-1-lijiang@redhat.com>
 <20191012022140.19003-4-lijiang@redhat.com>
 <87d0f22oi5.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0f22oi5.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Sat, 12 Oct 2019 12:16:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 10/12/19 at 06:26am, Eric W. Biederman wrote:
> Lianbo Jiang <lijiang@redhat.com> writes:
> 
> > When the crashkernel kernel command line option is specified, the
> > low 1MiB memory will always be reserved, which makes that the memory
> > allocated later won't fall into the low 1MiB area, thereby, it's not
> > necessary to create a backup region and also no need to copy the first
> > 640k content to a backup region.
> >
> > Currently, the code related to the backup region can be safely removed,
> > so lets clean up.
> >
> > Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> > ---
> 
> > diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> > index eb651fbde92a..cc5774fc84c0 100644
> > --- a/arch/x86/kernel/crash.c
> > +++ b/arch/x86/kernel/crash.c
> > @@ -173,8 +173,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
> >  
> >  #ifdef CONFIG_KEXEC_FILE
> >  
> > -static unsigned long crash_zero_bytes;
> > -
> >  static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
> >  {
> >  	unsigned int *nr_ranges = arg;
> > @@ -234,9 +232,15 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
> >  {
> >  	struct crash_mem *cmem = arg;
> >  
> > -	cmem->ranges[cmem->nr_ranges].start = res->start;
> > -	cmem->ranges[cmem->nr_ranges].end = res->end;
> > -	cmem->nr_ranges++;
> > +	if (res->start >= SZ_1M) {
> > +		cmem->ranges[cmem->nr_ranges].start = res->start;
> > +		cmem->ranges[cmem->nr_ranges].end = res->end;
> > +		cmem->nr_ranges++;
> > +	} else if (res->end > SZ_1M) {
> > +		cmem->ranges[cmem->nr_ranges].start = SZ_1M;
> > +		cmem->ranges[cmem->nr_ranges].end = res->end;
> > +		cmem->nr_ranges++;
> > +	}
> 
> What is going on with this chunk?  I can guess but this needs a clear
> comment.

Indeed it needs some code comment, this is based on some offline
discussion.  cat /proc/vmcore will give a warning because ioremap is
mapping the system ram.

We pass the first 1M to kdump kernel in e820 as system ram so that 2nd
kernel can use the low 1M memory because for example the trampoline
code.

> 
> >  
> >  	return 0;
> >  }
> 
> > @@ -356,9 +337,12 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
> >  	memset(&cmd, 0, sizeof(struct crash_memmap_data));
> >  	cmd.params = params;
> >  
> > -	/* Add first 640K segment */
> > -	ei.addr = image->arch.backup_src_start;
> > -	ei.size = image->arch.backup_src_sz;
> > +	/*
> > +	 * Add the low memory range[0x1000, SZ_1M], skip
> > +	 * the first zero page.
> > +	 */
> > +	ei.addr = PAGE_SIZE;
> > +	ei.size = SZ_1M - PAGE_SIZE;
> >  	ei.type = E820_TYPE_RAM;
> >  	add_e820_entry(params, &ei);
> 
> Likewise here.  Why do we need a special case?
> Why the magic with PAGE_SIZE?

Good catch, the zero page part is useless, I think no other special
reason, just assumed zero page is not usable, but it should be ok to
remove the special handling, just pass 0 - 1M is good enough.

Thanks
Dave
