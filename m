Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BDCC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 10:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA11620679
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 10:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfJMKVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 06:21:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728528AbfJMKVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 06:21:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4AA1320E9;
        Sun, 13 Oct 2019 10:21:14 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-81.pek2.redhat.com [10.72.12.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7380B5DA2C;
        Sun, 13 Oct 2019 10:21:04 +0000 (UTC)
Date:   Sun, 13 Oct 2019 18:20:59 +0800
From:   Dave Young <dyoung@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Lianbo Jiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, bhe@redhat.com, jgross@suse.com,
        dhowells@redhat.com, Thomas.Lendacky@amd.com, vgoyal@redhat.com,
        kexec@lists.infradead.org
Subject: Re: [PATCH 3/3 v3] x86/kdump: clean up all the code related to the
 backup region
Message-ID: <20191013102059.GA11190@dhcp-128-65.nay.redhat.com>
References: <20191012022140.19003-1-lijiang@redhat.com>
 <20191012022140.19003-4-lijiang@redhat.com>
 <87d0f22oi5.fsf@x220.int.ebiederm.org>
 <20191012121625.GA11587@dhcp-128-65.nay.redhat.com>
 <87zhi51ers.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhi51ers.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Sun, 13 Oct 2019 10:21:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/19 at 10:54pm, Eric W. Biederman wrote:
> Dave Young <dyoung@redhat.com> writes:
> 
> > Hi Eric,
> >
> > On 10/12/19 at 06:26am, Eric W. Biederman wrote:
> >> Lianbo Jiang <lijiang@redhat.com> writes:
> >> 
> >> > When the crashkernel kernel command line option is specified, the
> >> > low 1MiB memory will always be reserved, which makes that the memory
> >> > allocated later won't fall into the low 1MiB area, thereby, it's not
> >> > necessary to create a backup region and also no need to copy the first
> >> > 640k content to a backup region.
> >> >
> >> > Currently, the code related to the backup region can be safely removed,
> >> > so lets clean up.
> >> >
> >> > Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> >> > ---
> >> 
> >> > diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> >> > index eb651fbde92a..cc5774fc84c0 100644
> >> > --- a/arch/x86/kernel/crash.c
> >> > +++ b/arch/x86/kernel/crash.c
> >> > @@ -173,8 +173,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
> >> >  
> >> >  #ifdef CONFIG_KEXEC_FILE
> >> >  
> >> > -static unsigned long crash_zero_bytes;
> >> > -
> >> >  static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
> >> >  {
> >> >  	unsigned int *nr_ranges = arg;
> >> > @@ -234,9 +232,15 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
> >> >  {
> >> >  	struct crash_mem *cmem = arg;
> >> >  
> >> > -	cmem->ranges[cmem->nr_ranges].start = res->start;
> >> > -	cmem->ranges[cmem->nr_ranges].end = res->end;
> >> > -	cmem->nr_ranges++;
> >> > +	if (res->start >= SZ_1M) {
> >> > +		cmem->ranges[cmem->nr_ranges].start = res->start;
> >> > +		cmem->ranges[cmem->nr_ranges].end = res->end;
> >> > +		cmem->nr_ranges++;
> >> > +	} else if (res->end > SZ_1M) {
> >> > +		cmem->ranges[cmem->nr_ranges].start = SZ_1M;
> >> > +		cmem->ranges[cmem->nr_ranges].end = res->end;
> >> > +		cmem->nr_ranges++;
> >> > +	}
> >> 
> >> What is going on with this chunk?  I can guess but this needs a clear
> >> comment.
> >
> > Indeed it needs some code comment, this is based on some offline
> > discussion.  cat /proc/vmcore will give a warning because ioremap is
> > mapping the system ram.
> >
> > We pass the first 1M to kdump kernel in e820 as system ram so that 2nd
> > kernel can use the low 1M memory because for example the trampoline
> > code.
> >
> >> 
> >> >  
> >> >  	return 0;
> >> >  }
> >> 
> >> > @@ -356,9 +337,12 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
> >> >  	memset(&cmd, 0, sizeof(struct crash_memmap_data));
> >> >  	cmd.params = params;
> >> >  
> >> > -	/* Add first 640K segment */
> >> > -	ei.addr = image->arch.backup_src_start;
> >> > -	ei.size = image->arch.backup_src_sz;
> >> > +	/*
> >> > +	 * Add the low memory range[0x1000, SZ_1M], skip
> >> > +	 * the first zero page.
> >> > +	 */
> >> > +	ei.addr = PAGE_SIZE;
> >> > +	ei.size = SZ_1M - PAGE_SIZE;
> >> >  	ei.type = E820_TYPE_RAM;
> >> >  	add_e820_entry(params, &ei);
> >> 
> >> Likewise here.  Why do we need a special case?
> >> Why the magic with PAGE_SIZE?
> >
> > Good catch, the zero page part is useless, I think no other special
> > reason, just assumed zero page is not usable, but it should be ok to
> > remove the special handling, just pass 0 - 1M is good enough.
> 
> But if we have stopped special casing the low 1M.  Why do we need a
> special case here at all?

Seems both Lianbo and I do not understand the query. Let me try to
explain it more.

The 2nd kernel still need use low memory for the trampoline use. So we
have to let 2nd kernel access the low memory as system ram.

The original special case is far more than above we are doing, it does
several things:
1. backup the low 640K into kdump reserved high memory
2. set the low 640K as System RAM in kdump kernel as we do in this
patch.
3. in /proc/vmcore elf header, map the low 640K to the backup region so
that /proc/vmcore can give right old memory for that region.
 
After the change we are doing in this series, we dropped the 1 and 3 but
2 is still needed because kdump kernel still need use low memory.
But we do not care the vmcore part because nobody use the memory in old
kernel, we already reserve it, and excluded the range in vmcore.

I think another thing you mentioned about some reserved memory under 1M,
even if we set 0-1M as System RAM,  we still keep all the reserved
regions in /proc/iomem as identical between 1st and 2nd kernels, so it
just works, see below about cat /proc/iomem in kdump kernel (dropped
into a shell before copying the vmcore out):
kdump:/# cat /proc/iomem|less
00000000-00000fff : Reserved
00001000-0009ffff : System RAM
000a0000-000bffff : PCI Bus 0000:00
000f0000-000fffff : System ROM
30000000-3000006f : System RAM
30000070-39f5cfff : System RAM
  38600000-39001070 : Kernel code
  39001071-396ce5ff : Kernel data
  39acd000-39bfffff : Kernel bss

You can see 000a0000-000bffff : PCI Bus 0000:00 is same across the kdump
reboot.

But maybe if it is not elegant enough with simply using 0 - 1M, maybe
use 0 - 640K as Lianbo said in another reply?

-------------

BTW, we also discussed about compatibility issues,  for kexec_file it
just works because our change is in kernel.  For kexec-tools part, we
can just leave the userspace code as is, that means if one wants the SME
case be fixed he needs an kernel update to reserve the low memory. 

We can not drop the kexec-tools special case about 640K because if we
drop it and people use old kernels which does not reserve low 1M then
kdump can not work at all.

Thanks
Dave
