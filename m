Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B99C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED6F22CE9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567179023;
	bh=4YEfwjCL8KGZqdVDjILI1x1D8dUWKR6zysQ436BCo80=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zzKJuNO91NxnidiAFadDCotdnehWu1Df0FqvMyHUjIa+6fcIl+oycDk/+SWFpxoTL
	 8wARQNmbo0wXGFRqy3AFePCCRmhAJVbYiYCp7mzzrQUc6JgLCVk3EhhyRceNKRQSlY
	 WePO1WjMPHBNPE0wThDkJzjp3t6t+gtjTd1cOlpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfH3PaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:30:22 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:34524 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbfH3PaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:30:22 -0400
Received: by mail-lf1-f54.google.com with SMTP id z21so5693245lfe.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 08:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W/o6qGSsxejf0yS82rNr/PkS8E0j6uONKAzqFB+iPGo=;
        b=Ppje7GIrcvaI++RZmoqAeR91vtmzSIPUQXE0/2FnoGfyi4mDiUOehZuyYrYgZQPmd0
         GCG+p/p7oXOOWCu5fmhdV+bYwW10kLzpFoOybgucGti1ZxQ03Z07jFu1U8dNpYu5+5U8
         qTiZuk9alIANGLyB+ibMYrSYdVQTM/w8LlCiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W/o6qGSsxejf0yS82rNr/PkS8E0j6uONKAzqFB+iPGo=;
        b=SgMNrW/NQnTEsHXIBX1G/XdZxWMuKp5KCidu6SoDmLHsWW9t2nIF9vrayKuM2JB29b
         lbW5ik5G2YSm+C09wfYyAMNGqkav2Qi6WQ9fpUy7+AaC+8UwhNLL9UC8kEYH9J9m+RbW
         mQgYPvkbQnhe4k44pn9QJEmeFtLx4PXDkcapgVKjd1Gq9n6kcWFRK6Yzmb6IdAh9+TOU
         H2YxdF9cARN5fvX5XAamcLFW93LLehmT80z6SDsNjaVPO+HoNpdaMs/JQXHYnhv8pGws
         GY8UnPuabONM5BB5mxLflFKDW1ah9eXI4tUeQR1zZIwshz0d2JAk3axV+YMhOd2a9yqC
         2pFA==
X-Gm-Message-State: APjAAAXQDS36AxLzsoRieG2TK1RQURnAOxKj4FVQ2irhUEyu05KA6f9Y
        7GUwy1MIMBBSAuuKWkGbeefp0thyFOY=
X-Google-Smtp-Source: APXvYqwJmz9uplwOeyvtW8Dl3Lv9szwj6ysSedClhpBFRpO5vba0CKR/Xu5N1C0BHrX13NjAUjDbqQ==
X-Received: by 2002:a19:428f:: with SMTP id p137mr10023327lfa.149.1567179019456;
        Fri, 30 Aug 2019 08:30:19 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id a20sm894202ljk.34.2019.08.30.08.30.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2019 08:30:17 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id m24so6868725ljg.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 08:30:16 -0700 (PDT)
X-Received: by 2002:a05:651c:1104:: with SMTP id d4mr1597943ljo.90.1567179016569;
 Fri, 30 Aug 2019 08:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190830140805.GD13294@shell.armlinux.org.uk>
In-Reply-To: <20190830140805.GD13294@shell.armlinux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Aug 2019 08:30:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=whuggNup=-MOS=7gBkuRqUigk7ABot_Pxi5koF=dM3S5Q@mail.gmail.com>
Message-ID: <CAHk-=whuggNup=-MOS=7gBkuRqUigk7ABot_Pxi5koF=dM3S5Q@mail.gmail.com>
Subject: Re: [BUG] Use of probe_kernel_address() in task_rcu_dereference()
 without checking return value
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov@parallels.com>,
        Kirill Tkhai <ktkhai@parallels.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 7:08 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> which means that when probe_kernel_address() returns -EFAULT, the
> destination is left uninitialised.  In the case of
> task_rcu_dereference(), this means that "siginfo" can be used without
> having been initialised, resulting in this function returning an
> indeterminant result (based on the value of an uninitialised variable
> on the stack.)

Do you actually see that behavior?

Because the foillowing lines:

        smp_rmb();
        if (unlikely(task != READ_ONCE(*ptask)))
                goto retry;

are what is supposed to protect it - yes, it could have faulted, but
only if 'task' isn't valid any more, and we just re-checked it.

              Linus
