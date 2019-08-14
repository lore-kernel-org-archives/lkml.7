Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6907BC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476AA205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfHNL15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 07:27:57 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40180 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfHNL14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:27:56 -0400
Received: by mail-ot1-f68.google.com with SMTP id c34so41460098otb.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 04:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eHJv3mBwdvxIqxRvBcDhwQC/E4iNX17l5fHFn/2pxlg=;
        b=tMrHSMKRQO65M5VX2KCTM4rzANVZsV/fwzUUPowZqMAug3YBf/yqzqHau1d8TW0jn2
         ntRYtBlLnelSfiGuTRWDxSEk1W3adamQiMbtRY4vfCPDd0P0wAbnmnqoYnvmQGnsAzZ1
         AFAEU3ic7OOrZUtxP79XDuNVAZIjbV+P6UMbGTuKXvgVxN/ibI3VFCSA9HC1N8RGAMMx
         Ze7ZgldWd6axORvpnv6VcF+CewX1ngAGePT18TOH0ZfVh1H1JqN2NPyyXzfffwmW0+5s
         Q8+HwYNZ6NYOFWmeo87SA0NMI4ICNlqIcUrwDxMoQ1N1q26BdwahCMwMncN3UPc/5O1h
         ogKg==
X-Gm-Message-State: APjAAAXJ0yn4MUZpjq29697VrmyMe7Tln/rW/X4d69k5Wrn2knz7lwY7
        iUC8HQk16NqTV4QAB4tXZ0tNiGgza7SDawPZXqAAdA==
X-Google-Smtp-Source: APXvYqz0tmE1NdQyHIxkApv4Apv7/kFajZZswy1BxlRQJKik8AGuMMWgrI0l/n9TEs2X36e4jLiY3taT1Uz+YIn90GY=
X-Received: by 2002:a9d:5c11:: with SMTP id o17mr35152868otk.107.1565782075936;
 Wed, 14 Aug 2019 04:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190814104131.20190-1-mark.rutland@arm.com> <20190814104131.20190-3-mark.rutland@arm.com>
In-Reply-To: <20190814104131.20190-3-mark.rutland@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 14 Aug 2019 13:27:45 +0200
Message-ID: <CAMuHMdWEq69VAwNZsWN_8OUZ1S1m0uFrG6ET_iH3c9peiCLyDA@mail.gmail.com>
Subject: Re: [PATCH 2/9] sched: treewide: use is_kthread()
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>, kan.liang@intel.com,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Wed, Aug 14, 2019 at 12:43 PM Mark Rutland <mark.rutland@arm.com> wrote:
> Now that we have is_kthread(), let's convert existing open-coded checks
> of the form:
>
>   task->flags & PF_KTHREAD
>
> ... over to the new helper, which makes things a little easier to read,
> and sets a consistent example for new code to follow.
>
> Generated with coccinelle:
>
>   ----
>   virtual patch
>
>   @ depends on patch @
>   expression E;
>   @@
>
>   - (E->flags & PF_KTHREAD)
>   + is_kthread(E)
>   ----
>
> ... though this didn't pick up the instance in <linux/cgroup.h>, which I
> fixed up manually.
>
> Instances checking multiple PF_* flags at ocne are left as-is for now.
>
> There should be no functional change as a result of this patch.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

>  arch/m68k/kernel/process.c       | 2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
