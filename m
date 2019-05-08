Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7532AC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BAA214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="AaSAORnu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfEHNKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 09:10:24 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35846 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfEHNKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:10:23 -0400
Received: by mail-qt1-f194.google.com with SMTP id a17so2095225qth.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 06:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bFa5fWOj2U39bADpZiNUIdboEoriIx8kxrH5dUaTGmo=;
        b=AaSAORnuiyrLy4PFh/pbfE/NUYTkNM9t+xn/oTFhNa7mX9sFbcaoVkJmtjF5sY1MXr
         eIqj3qnqmzXQf3o3O2SkcLx/OstU8qzgySEj2W774c/ByF6zLPv23RBIY4/AdgqDX69h
         EviloJdUjLgbLAaKBBr73X4eiqQGOVvj+ngtfEcjYbzHmsYnmkMhfwihIpIXwxyWhYC4
         P9wewZNWzPkhrAL+SemyWnARTqAOxs6aObkeomkAd+cUPUB9gKUlTbMdI1yFIc/blKLS
         prRJc8G/OKf329fbsQGzeslm5Dmgr/SUc0aGC1j/Ff9mMKPmoeDMAUkVDIggh9P0Q4cU
         WJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bFa5fWOj2U39bADpZiNUIdboEoriIx8kxrH5dUaTGmo=;
        b=H8OzIAaPDQCEr9lFOYt7hlWPSZsZzTnZLR6U1mQUzssGx1qi6gD089ynLVKdxYAWt0
         fM3RhhQK4BYpjvKQZS/iLpcKv34Gw7ilWBAXVFghE3PUBm5OSD1OVIAA7z7d42OONBpa
         ZbtxKg7LW+j3lHzKa6JCEv6JC+8jFbGgpRUR5/YR6igBh7UsKKDVH5D1R2EFBf0Erodo
         JhaicAbicVzHb2JhLrn08wjmtp+YJQ6MpFdiZirnRJaZfyGeU1T82P3vMbNd+sLffpKC
         YaRRxFuXliRsMbZcgQF5E1TxtvFNTdwzgTAU5mZHkDpiLTaqgVXRtgyUso/cSjkmmIPQ
         r9Pw==
X-Gm-Message-State: APjAAAULTSOwgBVQ92orXG/wyPtcu1g+wTpuYtsAy9ZRv5nmbW+4PFGw
        85/gyBojZuhaLckY6572wpOoTg==
X-Google-Smtp-Source: APXvYqzm+oveL+e4Ksxqb7E1V14270yzcZkoBPQa3SSnfTb4ZkyMqyPZpOmRXi68d8c82QtaH6B5NQ==
X-Received: by 2002:a0c:8d07:: with SMTP id r7mr17494725qvb.206.1557321022824;
        Wed, 08 May 2019 06:10:22 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v190sm6992635qkc.9.2019.05.08.06.10.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 06:10:22 -0700 (PDT)
Message-ID: <1557321021.6132.21.camel@lca.pw>
Subject: Re: ptrace warning due to "cgroup: get rid of
 cgroup_freezer_frozen_exit()"
From:   Qian Cai <cai@lca.pw>
To:     Roman Gushchin <guro@fb.com>
Cc:     "oleg@redhat.com" <oleg@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "lizefan@huawei.com" <lizefan@huawei.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 08 May 2019 09:10:21 -0400
In-Reply-To: <20190507213752.GA24308@tower.DHCP.thefacebook.com>
References: <1557259462.6132.20.camel@lca.pw>
         <20190507213752.GA24308@tower.DHCP.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-07 at 21:37 +0000, Roman Gushchin wrote:
> Can you, please, try if the following patch fixes the problem?

It works great.

> --
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 16b72f4f14df..bf2f268f1386 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2484,9 +2484,6 @@ bool get_signal(struct ksignal *ksig)
>                 sigdelset(&current->pending.signal, SIGKILL);
>                 recalc_sigpending();
>                 current->jobctl &= ~JOBCTL_TRAP_FREEZE;
> -               spin_unlock_irq(&sighand->siglock);
> -               if (unlikely(cgroup_task_frozen(current)))
> -                       cgroup_leave_frozen(true);
>                 goto fatal;
>         }
>  
> @@ -2608,8 +2605,10 @@ bool get_signal(struct ksignal *ksig)
>                         continue;
>                 }
>  
> -               spin_unlock_irq(&sighand->siglock);
>         fatal:
> +               spin_unlock_irq(&sighand->siglock);
> +               if (unlikely(cgroup_task_frozen(current)))
> +                       cgroup_leave_frozen(true);
>  
>                 /*
>                  * Anything else is fatal, maybe with a core dump.
