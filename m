Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3152CC10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24F521741
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554861538;
	bh=7YTbpC+S42wTWvYFjOYL0o3r7vaXsMlP2T4iWgEMSnw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bCvG9b/shT4RDbYhZID+JrYIYuStNc7GapV9xKO21m/MsMjDLZFviGDTjZoormbUG
	 ltoLi1hJV9xWhOlJ07aaEYrImKnR4p0zWMNYIs7wn6Vq0PQeGpMrcdbmqlZ2o4IGuj
	 vq7Kp7k6IPQOEVzrULKTHBmtZbxxwpKkuSssC20I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfDJB64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 21:58:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726577AbfDJB64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 21:58:56 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF786218FC
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 01:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554861535;
        bh=7YTbpC+S42wTWvYFjOYL0o3r7vaXsMlP2T4iWgEMSnw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PPLYDAOFhSkrlqOBSb/hLiEFHaW1D2dh1azUH/p736Ufu2ni35KQ42ZYfcTsM6U41
         K6LyCBr7BQBRj/B5iDF8APEUmhQYKTqldpGVmaGfIBhzMmHEw9lqLaMV1JtQ6Cn4JR
         PchDaRNtBZ/28KtfS1bsD9g7I+czTJnyAjlypLlQ=
Received: by mail-wm1-f52.google.com with SMTP id r186so3605118wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 18:58:54 -0700 (PDT)
X-Gm-Message-State: APjAAAVicTU5H9sqpUStQj8zuwMJ1bDJt9uJxcYmTp+edMKqpJV45fgB
        UVp0bMwBD72lqHi8vlLydhl02AEsUnpRjtih6nDkTA==
X-Google-Smtp-Source: APXvYqy5adWmgC4rqeQvXKMy0S118HQDOricYPdsLLDmXtiDy9qOlFfzCwYaG9RsD83tV7hjxWP0TMIBvauKFuoyDno=
X-Received: by 2002:a05:600c:2189:: with SMTP id e9mr841728wme.4.1554861533515;
 Tue, 09 Apr 2019 18:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190410015326.24500-1-aubrey.li@linux.intel.com>
In-Reply-To: <20190410015326.24500-1-aubrey.li@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 9 Apr 2019 18:58:41 -0700
X-Gmail-Original-Message-ID: <CALCETrWV9SVDGQmzvZuub4aOPGyVqx7gPdk6D0s2_7j471jT_g@mail.gmail.com>
Message-ID: <CALCETrWV9SVDGQmzvZuub4aOPGyVqx7gPdk6D0s2_7j471jT_g@mail.gmail.com>
Subject: Re: [PATCH v14 1/3] /proc/pid/status: Add support for architecture
 specific output
To:     Aubrey Li <aubrey.li@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, aubrey.li@intel.com,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 6:55 PM Aubrey Li <aubrey.li@linux.intel.com> wrote:
>
> The architecture specific information of the running processes could
> be useful to the userland. Add support to examine process architecture
> specific information externally.
>
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> Cc: Linux API <linux-api@vger.kernel.org>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  fs/proc/array.c         | 5 +++++
>  include/linux/proc_fs.h | 2 ++
>  2 files changed, 7 insertions(+)
>
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index 2edbb657f859..331592a61718 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -401,6 +401,10 @@ static inline void task_thp_status(struct seq_file *m, struct mm_struct *mm)
>         seq_printf(m, "THP_enabled:\t%d\n", thp_enabled);
>  }
>
> +void __weak arch_proc_pid_status(struct seq_file *m, struct task_struct *task)
> +{
> +}

This pointlessly bloats other architectures.  Do this instead in an
appropriate header:

#ifndef arch_proc_pid_status
static inline void arch_proc_pid_status(...)
{
}
#endif

Or add /proc/PID/x86_status, which sounds better in most respects to me.
