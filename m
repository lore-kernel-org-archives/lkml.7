Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38915C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD0C20830
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbfDBIIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:08:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfDBIIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:08:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C24EBA70E;
        Tue,  2 Apr 2019 08:08:15 +0000 (UTC)
Received: from localhost (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F9576155F;
        Tue,  2 Apr 2019 08:08:14 +0000 (UTC)
Date:   Tue, 2 Apr 2019 16:08:11 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3] x86/boot/KASLR: skip the specified crashkernel region
Message-ID: <20190402080811.GO7627@MiWiFi-R3L-srv>
References: <1554178246-8162-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554178246-8162-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 02 Apr 2019 08:08:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* handle crashkernel=x@y or =range1:size1[,range2:size2,...]@offset options */
> +static void mem_avoid_specified_crashkernel_region(char *option)
> +{
> +	unsigned long long crash_size, crash_base = 0;
> +	char	*first_colon, *first_space, *cur = option;
> +

Another thing which need be noticed is that you may only need to handle
when '@' is found. Otherwise just let it go. Right?

> +	first_colon = strchr(option, ':');
> +	first_space = strchr(option, ' ');
> +	/* if contain ":" */
> +	if (first_colon && (!first_space || first_colon < first_space)) {
> +		int i;
> +		u64 total_sz = 0;
> +		struct boot_e820_entry *entry;
> +
> +		for (i = 0; i < boot_params->e820_entries; i++) {
> +			entry = &boot_params->e820_table[i];
> +			/* Skip non-RAM entries. */
> +			if (entry->type != E820_TYPE_RAM)
> +				continue;
> +			total_sz += entry->size;
> +		}
> +		handle_crashkernel_mem(option, total_sz, &crash_size,
> +			&crash_base);
> +	} else {
> +		crash_size = memparse(option, &cur);
> +		if (option == cur)
> +			return;
> +		while (*cur && *cur != ' ' && *cur != '@')
> +			cur++;
> +		if (*cur == '@') {
> +			option = cur + 1;
> +			crash_base = memparse(option, &cur);
> +		}
> +	}
> +	if (crash_base) {
> +		mem_avoid[MEM_AVOID_CRASHKERNEL].start = crash_base;
> +		mem_avoid[MEM_AVOID_CRASHKERNEL].size = crash_size;
> +	} else {
> +		/*
> + 		 * Clearing mem_avoid if no offset is given. This is consistent
> + 		 * with kernel, which uses the last crashkernel= option.
> +		 */
> +		mem_avoid[MEM_AVOID_CRASHKERNEL].start = 0;
> +		mem_avoid[MEM_AVOID_CRASHKERNEL].size = 0;
> +	}
> +}
