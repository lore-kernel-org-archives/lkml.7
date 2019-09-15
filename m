Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC45C4CEC9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 03:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02202053B
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 03:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXe4Q8xk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfIOCfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 22:35:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40362 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfIOCfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 22:35:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so17330521pgj.7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 19:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fhQRRoTWVDlkY7bkl1HwIxtbioEN9dfRxohZkdD1f9M=;
        b=oXe4Q8xkuN/WPthulSrCIQoFnOzQuOLjaM94ovBClDefXyw5ovNZQI5UxwCo1NsTrI
         qVl/6cRRmr+qcvtWQPmX/5Yz+sphzpUOsP4WG9Y8yRIFaaysposUEHDahrjcSYfzD2fi
         dNjKpndLrX/FWkY6oJc6gHsADmWv45gjJMUL3WIzunxOmhd6N01z/PvDsnMKCwhfS9L8
         zmW986xrcgPO9AsSS0Y84PEZjyS6KkPVHSKUiUYvqnRwFH5DElGEZNhZOJ4d9Y/ITR70
         GcLf46BfWLGbFaNLXSH9EhNaOcg3wR+dNXqVvixO1ziCL4N5U+JiGLr5ilv//dX8FwsM
         fvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fhQRRoTWVDlkY7bkl1HwIxtbioEN9dfRxohZkdD1f9M=;
        b=Zhp71Dp/F4W4+BSSIpP4FIAwvZV4SOaDBL2gn5587HEBMqpVLzFUjHBo1oa/Yumtyb
         rYy8xsQVLYSutNfVhez8qz5cpmgSSvP382pQE4wdxttdTxI0zRTDSFduSqtQE6kYUle+
         Bn9c/GUP0e7rFRnE5rsneMcMqdPBkAvc7vliWjd6uVMuQNIa4/ABLQ0axzwBw/xasBie
         ctynwyrgjbA9ZlPhlyhxYWSiy7cRsHv5wPnpUY7TA7V9A9Mg+7ow5/1HOWIEyHl9i9ou
         MS904Osi5jAlDy3pDEmi4c2tTGGlLnIT1gHEHu1XwF3aZAwGeCUngAGy8SDa5qVQcMb8
         vRyQ==
X-Gm-Message-State: APjAAAXDK0bieiced4Hd/QzupaZ5hzYD4fzM5GmuDBvjC93OWsCqUB59
        VO2TsnZYq3/p/Z9OnhdiRLQ=
X-Google-Smtp-Source: APXvYqx06da70srL4i4scsPW1kg1/C9aD5pMasQ7FoZzWmxFwg25UIdGOhHDBr6G6FhNTB7IHEefjg==
X-Received: by 2002:a63:2216:: with SMTP id i22mr7782671pgi.430.1568514942554;
        Sat, 14 Sep 2019 19:35:42 -0700 (PDT)
Received: from [192.168.68.119] (220-245-129-191.tpgi.com.au. [220.245.129.191])
        by smtp.gmail.com with ESMTPSA id e1sm3291519pgd.21.2019.09.14.19.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Sep 2019 19:35:41 -0700 (PDT)
Subject: Re: [PATCH V7 2/3] arm64/mm: Hold memory hotplug lock while walking
 for kernel page table dump
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com, will@kernel.org
Cc:     mark.rutland@arm.com, mhocko@suse.com, ira.weiny@intel.com,
        david@redhat.com, cai@lca.pw, logang@deltatee.com,
        cpandya@codeaurora.org, arunks@codeaurora.org,
        dan.j.williams@intel.com, mgorman@techsingularity.net,
        osalvador@suse.de, ard.biesheuvel@arm.com, steve.capper@arm.com,
        broonie@kernel.org, valentin.schneider@arm.com,
        Robin.Murphy@arm.com, steven.price@arm.com, suzuki.poulose@arm.com
References: <1567503958-25831-1-git-send-email-anshuman.khandual@arm.com>
 <1567503958-25831-3-git-send-email-anshuman.khandual@arm.com>
From:   Balbir Singh <bsingharora@gmail.com>
Message-ID: <66922798-9de7-a230-8548-1f205e79ea50@gmail.com>
Date:   Sun, 15 Sep 2019 12:35:21 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567503958-25831-3-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/9/19 7:45 pm, Anshuman Khandual wrote:
> The arm64 page table dump code can race with concurrent modification of the
> kernel page tables. When a leaf entries are modified concurrently, the dump
> code may log stale or inconsistent information for a VA range, but this is
> otherwise not harmful.
> 
> When intermediate levels of table are freed, the dump code will continue to
> use memory which has been freed and potentially reallocated for another
> purpose. In such cases, the dump code may dereference bogus addresses,
> leading to a number of potential problems.
> 
> Intermediate levels of table may by freed during memory hot-remove,
> which will be enabled by a subsequent patch. To avoid racing with
> this, take the memory hotplug lock when walking the kernel page table.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/mm/ptdump_debugfs.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
> index 064163f25592..b5eebc8c4924 100644
> --- a/arch/arm64/mm/ptdump_debugfs.c
> +++ b/arch/arm64/mm/ptdump_debugfs.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/debugfs.h>
> +#include <linux/memory_hotplug.h>
>  #include <linux/seq_file.h>
>  
>  #include <asm/ptdump.h>
> @@ -7,7 +8,10 @@
>  static int ptdump_show(struct seq_file *m, void *v)
>  {
>  	struct ptdump_info *info = m->private;
> +
> +	get_online_mems();
>  	ptdump_walk_pgd(m, info);
> +	put_online_mems();

Looks sane, BTW, checking other arches they might have the same race.
Is there anything special about the arch?

Acked-by: Balbir Singh <bsingharora@gmail.com>

