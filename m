Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B10C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8AC20856
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iX+HDWfm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfH0XYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 19:24:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45471 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfH0XYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 19:24:19 -0400
Received: by mail-lj1-f195.google.com with SMTP id l1so792360lji.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 16:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cHg8GFr+9ZLzMMJHsvNHHov8vbKz3Whz26E/ZLxuKA8=;
        b=iX+HDWfmnaBb46CDRKHFXgE++7V892uyzQG2a2Arn8P7n3x1TVmXI1UBDIOxvNoVsZ
         vTvkURufC5eQN/hJlhLxs6BDYLZ0RHg6A2x+e4YRZ4c6vswP50JqKB9rBpeTZF4tHN7w
         DDEem62jlZZ7rWjYmqKbDJg0Q2BS+F8b4Lr2E6wFwXCf9kkWqpzGu2oy3dTPgGULBFk8
         LL2zCJpX2GYXqA387DlXwohraUo74Wotv8dMoSnQbAFW4zEr/wGExZDhBGr8jLGEiB+6
         RleqUUoy+AX2bzmTFqwtY0tPCGwrLGMV8LdMx+uM2reGhqj/OeJ3+OZ2+/akdcsNjuys
         QM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cHg8GFr+9ZLzMMJHsvNHHov8vbKz3Whz26E/ZLxuKA8=;
        b=UusF4JWSxEiYJlVFbZW39m+ZQsqpcw15zNnxJA+vYmWNfg7/VBUQPoQGgJE4FFQCVI
         OW/7ZRpycKjAWoKszlVZiksRCIjA6a9hdg0oTc59RZEORkhbUY91Ufg1P7y60pz5NTpM
         zIoxcpaX1BcPtZY/kRw7ooPqIfxbzS/nGBgI4dDNglphxGdLPPoqmCSPVOiIeDodzW5k
         jnotGzoONF25sfxHhAEJUiQbHJUQ445DbE7WBWtcoZtydZuf8xd8OdvXDkd0RLRy+BYq
         IshtDRoouxvIMGJbt0tHop+WWkF7Sqg6rnY/vWr1Q2iw/tzDB2Oo5cfId/FtuzukEYkp
         PjRw==
X-Gm-Message-State: APjAAAXK4RScUY2WaQoultAqZwwSNAoIbFjGiw6o6HyXupI/fOAev8+B
        LFlvN1lvekmdnGyeWyiep+8CtGfFRlcn7Ak9hX5gn7LP
X-Google-Smtp-Source: APXvYqzm2XLoVNUYSKUOIOGn3CRGqm5tJ47pKMk0lvV0X08v3Xf1Axais5Ej32acW70AX1P6z4muAdmj47ClBJ9+foo=
X-Received: by 2002:a2e:81c3:: with SMTP id s3mr415016ljg.70.1566948257736;
 Tue, 27 Aug 2019 16:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559129225.git.vpillai@digitalocean.com> <20190827211417.snpwgnhsu5t6u52y@srcf.ucam.org>
In-Reply-To: <20190827211417.snpwgnhsu5t6u52y@srcf.ucam.org>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Wed, 28 Aug 2019 07:24:06 +0800
Message-ID: <CAERHkrtr_Vd+y85EX3WXVjJ8Vu-c3Xh8Zr-zpuDHWmN=gQ6j9g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 5:14 AM Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> Apple have provided a sysctl that allows applications to indicate that
> specific threads should make use of core isolation while allowing
> the rest of the system to make use of SMT, and browsers (Safari, Firefox
> and Chrome, at least) are now making use of this. Trying to do something
> similar using cgroups seems a bit awkward. Would something like this be
> reasonable? Having spoken to the Chrome team, I believe that the
> semantics we want are:
>
> 1) A thread to be able to indicate that it should not run on the same
> core as anything not in posession of the same cookie
> 2) Descendents of that thread to (by default) have the same cookie
> 3) No other thread be able to obtain the same cookie
> 4) Threads not be able to rejoin the global group (ie, threads can
> segregate themselves from their parent and peers, but can never rejoin
> that group once segregated)
>
> but don't know if that's what everyone else would want.
>
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 094bb03b9cc2..5d411246d4d5 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -229,4 +229,5 @@ struct prctl_mm_map {
>  # define PR_PAC_APDBKEY                        (1UL << 3)
>  # define PR_PAC_APGAKEY                        (1UL << 4)
>
> +#define PR_CORE_ISOLATE                        55
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 12df0e5434b8..a054cfcca511 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2486,6 +2486,13 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>                         return -EINVAL;
>                 error = PAC_RESET_KEYS(me, arg2);
>                 break;
> +       case PR_CORE_ISOLATE:
> +#ifdef CONFIG_SCHED_CORE
> +               current->core_cookie = (unsigned long)current;

Because AVX512 instructions could pull down the core frequency,
we also want to give a magic cookie number to all AVX512-using
tasks on the system, so they won't affect the performance/latency
of any other tasks.

This could be done by putting all AVX512 tasks into a cgroup, or
by AVX512 detection the following patch introduced.

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=2f7726f955572e587d5f50fbe9b2deed5334bd90

Thanks,
-Aubrey
