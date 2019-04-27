Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0C9C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 21:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B72208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 21:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBfVQdii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfD0Vp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 17:45:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34770 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfD0Vp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 17:45:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id s7so3305851ljh.1;
        Sat, 27 Apr 2019 14:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lGCktDZhO9yy3XwpF+5iW72ZtqBr/yzzAAemZw+ANno=;
        b=nBfVQdiiDHLlyYAMKPP1SB8AEc1d2M2RhQvdXGd+0DzqYdCk8c2HazrDkmKHGvFPBx
         0QvRX11bOc2bHJcgsnXSDaQ15M3iPbRqfFypWlPoNK8Oc083IOuxoMg/Sj0NcpdWh4e6
         +ki1KzpwcOtMk7GVVRMUVDsQVuLRhTRhsK+T8YKKyEC6fvm2EzHNS0WzVYGmMdRQ5x5U
         BTk5og+1poxtymZIlfkksmDAwSdarFvPKM3gG3Eha7cb14jlcV+7oNSPOhjmWVQANSzL
         hz8WMjAD6/EwfAi2oiObemfZYc5inSDtczsU6M7SEYNdWcPtjUtfViCj99tnKEb7WQjy
         c3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lGCktDZhO9yy3XwpF+5iW72ZtqBr/yzzAAemZw+ANno=;
        b=JEgylmg9dZkL1wGkrF/7+hpKI1Jq1kyn+ghWyzWzrHQaO7qqSPHCeHSWtaaxmXgN5e
         qudOimJOcfDOu4P9BmA7yZtBZ0GsT+JUUHipfUYV9L2yVy1eslLO+zMJeBCO4YG/fipt
         YK46nwO+B9qsfBHI/r7CgO94ARv+f6OO9YMpCzVQP3MtLOes6QULc0X+2XAXUoN/b0Ym
         QR54vd2AIsJhloVMIPa/SudE8o82VSR6Zg7FG85ZbWGl4J+BR6OYvyvbDKIEeWoxKzTo
         DC0oCoyNfF18+rbJqV7+sxAJnuEupoc1uyUOZt+cydemV1HF72kHCj8olr/y8UicZNpV
         FZGw==
X-Gm-Message-State: APjAAAUYac0GQpC7gbmOnhi5i3/QqIi5jEZ5SBneeE6QnbXZyEzGD+ls
        nQK0pTJSB/9A4OXidYEc9g==
X-Google-Smtp-Source: APXvYqwlBGdZ+9ctLYbFVMcekfQgGgOXckHiTVFa3SEs5J3pGbJZ/g+qK3lh54GbMhqpKjDBSxLQgA==
X-Received: by 2002:a2e:808e:: with SMTP id i14mr28243920ljg.103.1556401526026;
        Sat, 27 Apr 2019 14:45:26 -0700 (PDT)
Received: from avx2 ([46.53.240.140])
        by smtp.gmail.com with ESMTPSA id n28sm5977383lfi.79.2019.04.27.14.45.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Apr 2019 14:45:25 -0700 (PDT)
Date:   Sun, 28 Apr 2019 00:45:22 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ram Pai <linuxram@us.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Sandeep Patil <sspatil@android.com>,
        Rafael Aquini <aquini@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs/proc: add VmTaskSize field to /proc/$$/status
Message-ID: <20190427214522.GA7074@avx2>
References: <1556305328-2001-1-git-send-email-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1556305328-2001-1-git-send-email-jsavitz@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 03:02:08PM -0400, Joel Savitz wrote:
> In the mainline kernel, there is no quick mechanism to get the virtual
> memory size of the current process from userspace.
> 
> Despite the current state of affairs, this information is available to the
> user through several means, one being a linear search of the entire address
> space. This is an inefficient use of cpu cycles.

You can test only a few known per arch values. Linear search is a self
inflicted wound.

prctl(2) is more natural place and will also be arch neutral.

> A component of the libhugetlb kernel test does exactly this, and as
> systems' address spaces increase beyond 32-bits, this method becomes
> exceedingly tedious.

> For example, on a ppc64le system with a 47-bit address space, the linear
> search causes the test to hang for some unknown amount of time. I
> couldn't give you an exact number because I just ran it for about 10-20
> minutes and went to go do something else, probably to get coffee or
> something, and when I came back, I just killed the test and patched it
> to use this new mechanism. I re-ran my new version of the test using a
> kernel with this patch, and of course it passed through the previously
> bottlenecking codepath nearly instantaneously.
> 
> This patched enabled me to upgrade an O(n) codepath to O(1) in an
> architecture-independent manner.

> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -74,7 +74,10 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
>  	seq_put_decimal_ull_width(m,
>  		    " kB\nVmPTE:\t", mm_pgtables_bytes(mm) >> 10, 8);
>  	SEQ_PUT_DEC(" kB\nVmSwap:\t", swap);
> -	seq_puts(m, " kB\n");
> +	SEQ_PUT_DEC(" kB\nVmSwap:\t", swap);
> +	seq_put_decimal_ull_width(m,
> +		    " kB\nVmTaskSize:\t", TASK_SIZE >> 10, 8);
> +	seq_puts(m, " kB\n");

All fields in this file are related to the task. New field related
to "current" will stick like an eyesore.
