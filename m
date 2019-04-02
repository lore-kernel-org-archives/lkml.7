Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A3DC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9C620833
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbfDBGwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:52:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbfDBGwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:52:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CFF883082B4F;
        Tue,  2 Apr 2019 06:52:50 +0000 (UTC)
Received: from localhost (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DEA160BE5;
        Tue,  2 Apr 2019 06:52:49 +0000 (UTC)
Date:   Tue, 2 Apr 2019 14:52:45 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     Pingfan Liu <kernelfans@gmail.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3] x86/boot/KASLR: skip the specified crashkernel region
Message-ID: <20190402065245.GN7627@MiWiFi-R3L-srv>
References: <1554178246-8162-1-git-send-email-kernelfans@gmail.com>
 <20190402061926.GA1555@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402061926.GA1555@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 02 Apr 2019 06:52:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/19 at 02:19pm, Chao Fan wrote:
> On Tue, Apr 02, 2019 at 12:10:46PM +0800, Pingfan Liu wrote:
> >crashkernel=x@y or or =range1:size1[,range2:size2,...]@offset option may
> or or?
> >fail to reserve the required memory region if KASLR puts kernel into the
> >region. To avoid this uncertainty, asking KASLR to skip the required
> >region.
> >
> >Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> >Cc: Thomas Gleixner <tglx@linutronix.de>
> >Cc: Ingo Molnar <mingo@redhat.com>
> >Cc: Borislav Petkov <bp@alien8.de>
> >Cc: "H. Peter Anvin" <hpa@zytor.com>
> >Cc: Baoquan He <bhe@redhat.com>
> >Cc: Will Deacon <will.deacon@arm.com>
> >Cc: Nicolas Pitre <nico@linaro.org>
> >Cc: Pingfan Liu <kernelfans@gmail.com>
> >Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
> >Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> >Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >Cc: linux-kernel@vger.kernel.org
> >---
> [...]
> >+
> >+/* handle crashkernel=x@y or =range1:size1[,range2:size2,...]@offset options */
> 
> Before review, I want to say more about the background.
> It's very hard to review the code for someone who is not so familiar
> with kdump, so could you please explain more ahout
> the uasge of crashkernel=range1:size1[,range2:size2,...]@offset.
> And also there are so many jobs who are parsing string. So I really
> need your help to understand the PATCH.

The hard part may be handle_crashkernel_mem() itself. However, it's
almost copied from parse_crashkernel_mem() completely. If we can reuse
that function, thing's gonna be perfect.

> 
> >+static void mem_avoid_specified_crashkernel_region(char *option)
> >+{
> >+	unsigned long long crash_size, crash_base = 0;
> >+	char	*first_colon, *first_space, *cur = option;
> Is there a tab after char?
> >+
> >+	first_colon = strchr(option, ':');
> >+	first_space = strchr(option, ' ');
> >+	/* if contain ":" */
> >+	if (first_colon && (!first_space || first_colon < first_space)) {
> >+		int i;
> >+		u64 total_sz = 0;
> >+		struct boot_e820_entry *entry;
> >+
> >+		for (i = 0; i < boot_params->e820_entries; i++) {
> >+			entry = &boot_params->e820_table[i];
> >+			/* Skip non-RAM entries. */
> >+			if (entry->type != E820_TYPE_RAM)
> >+				continue;
> >+			total_sz += entry->size;
> I wonder whether it's needed to consider the memory ranges here.
> I think it's OK to only record the regions should to be avoid.
> I remeber I ever talked with Baoquan about the similiar problems.
> @Baoquan, I am not sure if I misunderstand something.

Not sure if I get you. Could you be more specific?
