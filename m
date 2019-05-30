Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB29C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2FC25A40
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559225718;
	bh=TgiKb0LMDBwyXVpyciZYBGWFy30QWuuM3QhZdETmGI0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ibLH44rqiU9LxvbXMQQjF/ZlbsbcuL4QA9ryIoYF4qq7h0WXW1TiraMGShlEUbx4E
	 tDGe9Y+YpCZMQ/aDgDdwUfDro50X5xsQ8RUOtYbnnmPoEiXc5xu0vRgCj/4DyC5rfG
	 qQ1Fz0J99aU4N54bhPN/HkWusx12snfz+63X/8ro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfE3OPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 10:15:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfE3OPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:15:17 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31D3F25A45
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 14:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559225716;
        bh=TgiKb0LMDBwyXVpyciZYBGWFy30QWuuM3QhZdETmGI0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uZvvF0f/LcJKglvkgh6kWLECMnXX8b/4EAgOWhCACEOnoC+kAAEipNLIxQyXHqUG8
         CQMyF0ZlK1PMfnhdK4qKkd50h/vHiIRWDHaaVr4MUgfzjFLgEAng6sDy02j+ChdgZA
         8czIPvOWladMb7X1JDN8N+3ORF8KmIKmsu4yNV68=
Received: by mail-wm1-f45.google.com with SMTP id g135so894947wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 07:15:16 -0700 (PDT)
X-Gm-Message-State: APjAAAVnF/RaBG3UF7J0OwzrUp+MgIWex4L0AGF2id0sMGzAifeueZ35
        sDF7pX4nAlRhLIvC/7qkQ6Hv/E7uFV8PGkVF3ZRKPQ==
X-Google-Smtp-Source: APXvYqy0Jd7vq87R9JRAr8ympb8fBUTx5Yhddpy2tBHwXEyyf6UIGWa9hry2ptC31PLqXl6Wul7HgwtYhMCTazC9z2c=
X-Received: by 2002:a1c:d10e:: with SMTP id i14mr2546017wmg.161.1559225714741;
 Thu, 30 May 2019 07:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <1559116604-23105-1-git-send-email-zhenzhong.duan@oracle.com>
In-Reply-To: <1559116604-23105-1-git-send-email-zhenzhong.duan@oracle.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 30 May 2019 07:15:02 -0700
X-Gmail-Original-Message-ID: <CALCETrU96Pjw5AEy_Aju_hMkv=QdE3YVfx5aY24B8WwDqM1A9Q@mail.gmail.com>
Message-ID: <CALCETrU96Pjw5AEy_Aju_hMkv=QdE3YVfx5aY24B8WwDqM1A9Q@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/tlb: Do partial TLB flush when possible
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, srinivas.eeda@oracle.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 12:56 AM Zhenzhong Duan
<zhenzhong.duan@oracle.com> wrote:
>
> This is a small optimization to stale TLB flush, if there is one new TLB
> flush, let it choose to do partial or full flush. or else, the stale
> flush take over and do full flush.

I think this is invalid because:

>
> +       if (unlikely(f->new_tlb_gen <= local_tlb_gen &&
> +           local_tlb_gen + 1 == mm_tlb_gen)) {
> +               /*
> +                * For stale TLB flush request, if there will be one new TLB
> +                * flush coming, we leave the work to the new IPI as it knows
> +                * partial or full TLB flush to take, or else we do the full
> +                * flush.
> +                */
> +               trace_tlb_flush(reason, 0);
> +               return;

We do indeed know that the TLB will get flushed eventually, but we're
actually providing a stronger guarantee that the TLB will be
adequately flushed by the time we return.  Otherwise, after
flush_tlb_mm_range(), there will be a window in which the TLB isn't
flushed yet.
