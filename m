Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFD8CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 07:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E879F20873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 07:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="m7jOLGDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfJaHNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 03:13:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58352 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbfJaHNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 03:13:52 -0400
Received: from nazgul.tnic (unknown [46.218.74.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 21B001EC0CC3;
        Thu, 31 Oct 2019 08:13:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1572506031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iSXPghAWzlU3fW//jNjEO3q3vXqfETkOCwCibktbWkY=;
        b=m7jOLGDqL1xwgbpgs/O8iIxBDc+jsqg5zmPK5lKvA0Hb4n0PdavGVcKrImucGyHsTYsYLX
        pBj0XC0+BiGEeENr0jw9SZiLqsplAgNA8g+vi07jBXUnBSmOi4ND+ravIFExkM1tzlyK/G
        YfboQAlTwwu8NSVgAiaMEOGluGtIaas=
Date:   Thu, 31 Oct 2019 08:13:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, bhe@redhat.com, dyoung@redhat.com,
        jgross@suse.com, dhowells@redhat.com, Thomas.Lendacky@amd.com,
        ebiederm@xmission.com, vgoyal@redhat.com, d.hatayama@fujitsu.com,
        horms@verge.net.au, kexec@lists.infradead.org
Subject: Re: [PATCH 1/2 RESEND v8] x86/kdump: always reserve the low 1M when
 the crashkernel option is specified
Message-ID: <20191031071345.GA17248@nazgul.tnic>
References: <20191031033517.11282-1-lijiang@redhat.com>
 <20191031033517.11282-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191031033517.11282-2-lijiang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 11:35:16AM +0800, Lianbo Jiang wrote:
> Kdump kernel will reuse the first 640k region because the real mode
> trampoline has to work in this area. When the vmcore is dumped, the
> old memory in this area may be accessed, therefore, kernel has to
> copy the contents of the first 640k area to a backup region so that
> kdump kernel can read the old memory from the backup area of the
> first 640k area, which is done in the purgatory().
> 
> But, the current handling of copying the first 640k area runs into
> problems when SME is enabled, kernel does not properly copy these
> old memory to the backup area in the purgatory(), thereby, kdump
> kernel reads out the encrypted contents, because the kdump kernel
> must access the first kernel's memory with the encryption bit set
> when SME is enabled in the first kernel. Please refer to this link:
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204793
> 
> Finally, it causes the following errors, and the crash tool gets
> invalid pointers when parsing the vmcore.
> 
> crash> kmem -s|grep -i invalid
> kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac099f0c5a4
> kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac099f0c5a4
> crash>
> 
> To avoid the above errors, when the crashkernel option is specified,
> lets reserve the remaining low 1M memory(after reserving real mode
> memory) so that the allocated memory does not fall into the low 1M
> area, which makes us not to copy the first 640k content to a backup
> region in purgatory(). This indicates that it does not need to be
> included in crash dumps or used for anything except the processor
> trampolines that must live in the low 1M.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> Reported-by: kbuild test robot <lkp@intel.com>

Please do not merge a 0day bot fix with another patch of yours which
does not cause it in the first place. When you look at this patch alone,
what do you think the Reported-by tag means, if anything at all?

Also, it is not a "RESEND" if you change them. You can call them v8.1 or
whatever to denote that the change is small.

Also, do not send v9 or v8.1 or whatever, immediately but wait for other
reviews. You have sent these patches 4(!) times in this week alone. How
would you feel if I hammer your inbox with patches on a daily basis?

You can read

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

in the meantime, especially section

"9) Don't get discouraged - or impatient"

while waiting.

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
