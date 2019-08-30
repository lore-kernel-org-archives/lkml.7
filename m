Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B329AC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF572342F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567184317;
	bh=8ig90jW+JUR4eku9uDhNJ4CrI3oT4xE2Y8WA9NNZ+ls=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wfy6/UbCvcaES7wVB5snx7yUTJ17kmkHbLQ+wdzN3PxDmhTeicnr9H7neR4laVWGX
	 qvfOHY+LNMrNbBxHZp3SvAfYMs5abdTfp/iEjSY75sEDdSLItNn1T5QZynMY9htxL4
	 OegkVdM8TGTxDyquj6BLOxr7KX1KLPtvr8E615Ak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfH3Q6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:58:36 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35295 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfH3Q6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:58:36 -0400
Received: by mail-lj1-f195.google.com with SMTP id l14so7128246lje.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 09:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6fGjPTVMFHRepZwqQQxX9lNf+TEmbCR5/5u8N3UwWrA=;
        b=ORNufdWJknR9HTtxh6UwaGSW3fWc31ojtV2AgygMf9XsOEMGGzflCuNc7o+R0O92k4
         BZ+E47ArBnn6UZ1Yt8hbCpE+K2K4XMD+HVYITNgUYobUsF9pvOiGh3QjD6X0rhMbRmw6
         wHmn6L+oNo/GUyIPsie8ZSQxG+0WcHQOARku4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6fGjPTVMFHRepZwqQQxX9lNf+TEmbCR5/5u8N3UwWrA=;
        b=k/5FndMqQW79eOEWszYTk2qNCOfSfMYPnzzXLin+eo+8zp9z2qVJkEZxvSlz2WyEl7
         mDS/F/0GSlaUU0pnLcI5DK9UKI9o5jzvbyX4B10hKgRzAMvc7GhU6TxTWySAPE+jtjAw
         vwNlbxMS4tcN2wL4VaLusAEKXCl9MZjgFtleUSPTiJ7EZU9H4ZjClWz3PWbFZ0IzInn5
         pbJbdNiJC5D4VS42a9XjCx/2l8br3zPu+/YrGWUEGMmmNDQRG8Y7gLSO3TwwifJ8Fsbl
         ns643jvfRovxE+iHUJjAM5d/E/qniGOPyKmHWZFme0/ZLt/39kJTpdYJqapgSQd+jfUN
         Y1gw==
X-Gm-Message-State: APjAAAWWv96c5JJPSpLMm2ajJq35kJ94lQ/3uSHosjz6Uh7u8XdctYdA
        AN/zWIyttoXLhJYBe/4hukhDtaSHzDo=
X-Google-Smtp-Source: APXvYqzEot3M+1hW+ts27txbXBUpQDBo3bnE9fktz8M3KW10VZL5oKot4pyePkkujlsHl1Sg2PUJAg==
X-Received: by 2002:a2e:b0e6:: with SMTP id h6mr8632602ljl.18.1567184313778;
        Fri, 30 Aug 2019 09:58:33 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id y22sm138127ljj.97.2019.08.30.09.58.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2019 09:58:31 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id j4so5856994lfh.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 09:58:31 -0700 (PDT)
X-Received: by 2002:a19:c20b:: with SMTP id l11mr9926951lfc.106.1567184311005;
 Fri, 30 Aug 2019 09:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190830140805.GD13294@shell.armlinux.org.uk> <CAHk-=whuggNup=-MOS=7gBkuRqUigk7ABot_Pxi5koF=dM3S5Q@mail.gmail.com>
 <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
 <20190830160957.GC2634@redhat.com> <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
 <20190830164436.GD2634@redhat.com>
In-Reply-To: <20190830164436.GD2634@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Aug 2019 09:58:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whtj+aSYftniMRG4xvFE8dmmYyrqcJyPmzStsfj5w9r=w@mail.gmail.com>
Message-ID: <CAHk-=whtj+aSYftniMRG4xvFE8dmmYyrqcJyPmzStsfj5w9r=w@mail.gmail.com>
Subject: Re: [BUG] Use of probe_kernel_address() in task_rcu_dereference()
 without checking return value
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 9:44 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> ->curr is not protected by RCU, the last schedule does put_task_struct()
> in finish_task_switch().

Right you are.

It's only the sighand allocation itself that is RCU-allocated (using
SLAB_TYPESAFE_BY_RCU, so only the backing page freeing is RCU-delayed,
it can be re-used immediately).

For some reason I thought the main thread struct was too, but that was
just my fevered imagination.

> Of course we can change this and add another call_rcu (actually we can do
> better), and after that we do not need task_rcu_dereference() at all.

No, we wouldn't do another RCU call, we'd just make task_struct_cachep
be SLAB_TYPESAFE_BY_RCU too. In the reuse case, you have no cost at
all.

However, the overhead of RCU freeing is real. It's much less for the
SLAB_TYPESAFE_BY_RCU case (at least for small allocations) than for
"free every single allocaiton by RCU", but it's still very real.

(For small allocations, you only take the RCU hit when you free the
backing store of the pages, which is much less frequent - but for
something big like the task_struct, I don't know how much of a
buffering the slab allocation ends up being)

So it's probably better to take the hit at task_rcu_dereference() than
add RCU logic to the task freeing.

              Linus
