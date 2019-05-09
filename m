Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08074C04A6B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 01:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1517205ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 01:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/7+vmEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfEIBjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 21:39:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46848 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbfEIBjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 21:39:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id h21so517933ljk.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 18:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hLMQoawtf7zEIInnvJYm+TQ2l/zeMDbM81eV5mgMe5I=;
        b=X/7+vmElyjBWNBsb1JgMyNZqvJuMIQvL+Y8Zp0Nz7YQ29HxJTUaJsvfs8RjIIIwH+W
         xPFnXatt+h0EQ1xtlFzvEm9wndgh1eawjR8RyC0HAmnTd5QwstvGZm+p6QIlgCi+oFFr
         xNX0tjStcYBDAUM8e71Yl4RhalJaxL06e8B4PfkWzvDgaL8jmLFwzDk9MyVfEkhNNkjG
         zXh6gb5Kar9u4NX2vQdZgyEXwM9AgyEcl734F+qfpgOCpI6AL3DzS6rJIZEtwt6kQj1k
         jdIUDVQgzgbtLoVuuYAmKblgfpLowSGzn+CTz3BUq7XbLANw5xybjD7evO23lfFa5Vxc
         AoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hLMQoawtf7zEIInnvJYm+TQ2l/zeMDbM81eV5mgMe5I=;
        b=CepB5MQLE43JCcfQmzgm0kxb5TFBsRT/ttZwd5L9Pb62gO38krJ7cZEwJPjLqr6znu
         ozHcqAR+E41HEsNI1Fr8U6SCL6UfdWwudZn1fmb9k/Nthmq3q9w1BZomlNbrA6Z548gC
         FUpT5FSUPBv64EmZxHCQs/5vzLCye1TxqFgBhsL7RhQIwhSV9FW2ySeSLGoj1vSqqGEH
         ZKCMNH7CVNkuuhe+GKrYiMiBT6prz4AhtX6kSrXO+Wzyh3WzaWpmkvIMGceTozARXW22
         sjNTTjqpDNdMJLKlr2ohTjnq37SG8Q7cDZjGP7iJrc7gI44Ls0QjtrhDjFPEu3AlvnvW
         XSow==
X-Gm-Message-State: APjAAAWudMpWb9or/Hvp/Vb6XAzynQIOjTKvWZHsaAoI6MB5piuizCoU
        j1cYcqP2q/PdBq0cnqoLkwLzZG9d2uDY53C9W+U=
X-Google-Smtp-Source: APXvYqw1fnLy/3pDnP6VQZtirMi9hVF0iXwdyyXdP/mW5qDqVSdf9w1auJeE0QHjpdXBf5SCB+GHghhRqFjf/5r4G2g=
X-Received: by 2002:a2e:984d:: with SMTP id e13mr544040ljj.61.1557365946270;
 Wed, 08 May 2019 18:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <2364f2b65bf50826d881c84d7634b6565dfee527.1556025155.git.vpillai@digitalocean.com>
 <20190429061516.GA9796@aaronlu> <6dfc392f-e24b-e641-2f7d-f336a90415fa@linux.intel.com>
 <777b7674-4811-dac4-17df-29bd028d6b26@linux.intel.com> <CAERHkrvU0nay-cG9equdOBejOZ5Ffdxo+67ZRp9q0L9BQkcAtQ@mail.gmail.com>
 <eb9abb34-d946-c63c-750b-8f52ed842670@oracle.com> <28fb6854-2772-5d29-087a-6a0cf6afe626@oracle.com>
 <CAERHkrsavsBoEOR5Eq-nm6ADarS0zTi5Mu-T7TO6JoSUi7TRfQ@mail.gmail.com> <8098b70b-2095-91ea-d4ad-9181829066c7@oracle.com>
In-Reply-To: <8098b70b-2095-91ea-d4ad-9181829066c7@oracle.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Thu, 9 May 2019 09:38:54 +0800
Message-ID: <CAERHkrvKfvrSOKoJ5StYWENm9domgx1OkPyeKHacP9AGrgf8cg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/17] sched: Basic tracking of matching tasks
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
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

On Thu, May 9, 2019 at 8:29 AM Subhra Mazumdar
<subhra.mazumdar@oracle.com> wrote:
>
>
> On 5/8/19 5:01 PM, Aubrey Li wrote:
> > On Thu, May 9, 2019 at 2:41 AM Subhra Mazumdar
> > <subhra.mazumdar@oracle.com> wrote:
> >>
> >> On 5/8/19 11:19 AM, Subhra Mazumdar wrote:
> >>> On 5/8/19 8:49 AM, Aubrey Li wrote:
> >>>>> Pawan ran an experiment setting up 2 VMs, with one VM doing a
> >>>>> parallel kernel build and one VM doing sysbench,
> >>>>> limiting both VMs to run on 16 cpu threads (8 physical cores), with
> >>>>> 8 vcpu for each VM.
> >>>>> Making the fix did improve kernel build time by 7%.
> >>>> I'm gonna agree with the patch below, but just wonder if the testing
> >>>> result is consistent,
> >>>> as I didn't see any improvement in my testing environment.
> >>>>
> >>>> IIUC, from the code behavior, especially for 2 VMs case(only 2
> >>>> different cookies), the
> >>>> per-rq rb tree unlikely has nodes with different cookies, that is, all
> >>>> the nodes on this
> >>>> tree should have the same cookie, so:
> >>>> - if the parameter cookie is equal to the rb tree cookie, we meet a
> >>>> match and go the
> >>>> third branch
> >>>> - else, no matter we go left or right, we can't find a match, and
> >>>> we'll return idle thread
> >>>> finally.
> >>>>
> >>>> Please correct me if I was wrong.
> >>>>
> >>>> Thanks,
> >>>> -Aubrey
> >>> This is searching in the per core rb tree (rq->core_tree) which can have
> >>> 2 different cookies. But having said that, even I didn't see any
> >>> improvement with the patch for my DB test case. But logically it is
> >>> correct.
> >>>
> >> Ah, my bad. It is per rq. But still can have 2 different cookies. Not sure
> >> why you think it is unlikely?
> > Yeah, I meant 2 different cookies on the system, but unlikely 2
> > different cookies
> > on one same rq.
> >
> > If I read the source correctly, for the sched_core_balance path, when try to
> > steal cookie from another CPU, sched_core_find() uses dst's cookie to search
> > if there is a cookie match in src's rq, and sched_core_find() returns idle or
> > matched task, and later put this matched task onto dst's rq (activate_task() in
> > sched_core_find()). At this moment, the nodes on the rq's rb tree should have
> > same cookies.
> >
> > Thanks,
> > -Aubrey
> Yes, but sched_core_find is also called from pick_task to find a local
> matching task.

Can a local searching introduce a different cookies? Where is it from?

> The enqueue side logic of the scheduler is unchanged with
> core scheduling,

But only the task with cookies is placed onto this rb tree?

> so it is possible tasks with different cookies are
> enqueued on the same rq. So while searching for a matching task locally
> doing it correctly should matter.

May I know how exactly?

Thanks,
-Aubrey
