Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55128C46460
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9A12591B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKcka6UV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfE3Mzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 08:55:45 -0400
Received: from mail-it1-f175.google.com ([209.85.166.175]:53150 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfE3Mzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 08:55:44 -0400
Received: by mail-it1-f175.google.com with SMTP id t184so9635285itf.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 05:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZLW1xk6MLnaOhKxjAOhSGRAO81reaAV4lGbib7H9s5k=;
        b=WKcka6UV3NWduPvibld4d8yUqcUyByrokKY6G+iCDvd6HZ36y1aoZiTjlJu2iNaJjx
         azIsFUtD/Yyrqx1Vnz5DtMMvCyzsX9Z1jM/WgMLv02/FcvuQ/R4Kt5mgNxo/D9jrOXNp
         U8dKa6WykLy01iUkWBz/DSJ2+NBSuHEBIk31mV9/GUMPei3V5dd/aNjN3HdPtcCS8YOm
         4x3V8yqinaPyDzV+4YMzdL+wycjLOn71Hve4jnAHCn5bSC5fIFZfl74IMfIm5bxb7Rpn
         Q1aRCH7DY2StscthroSzFSR+CS59v+ozhFpU4/07BhClMyRsRAmn2/tDzTS+W+tiskTD
         1E2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZLW1xk6MLnaOhKxjAOhSGRAO81reaAV4lGbib7H9s5k=;
        b=lrGnaHTH/SJbRPcR6yMZKy4rR3aw/rKt3OBUbtXB1kqeyYyvxdQRmOztEBSLxinI3U
         NvplIMLJ6BVoMl73i9mFNoh2bzAsQsLgMovcjtvAIKUxgg7DWlHnyxutC0XE+kriIpmz
         nIVfomj/27VMbt8ip5uZ6txcQQy+1xz6GdQRcmduEVpNZX3QCZBwg6rthrCKIsCY4Ufk
         92xhfJujClFF4nkinOWHEX7xoODESCJu8B2YPd182O7v7QJxLwKgHl9sjEJIolDssBOo
         FJC0wkS3gCwpDHIFEtNGKmAYVjQcbv3Sb/tSa4Oa0gFfuc0REs6hWpUkpizffHva0gd+
         MLFw==
X-Gm-Message-State: APjAAAVJGxAZ7nqSJsM8J2PWQhnu5ZtD4UoSFLGcnzLGikLnpkE+rj70
        XZ82ffrEw54RPA8vOakGF+UET1Djw6ul6l8Xag==
X-Google-Smtp-Source: APXvYqwiaONSUG5G2UwUM9H9pZgzyJ5xk3qr7gpb/QqGbbvw7tYPHcxkMWO22H5pPEWQFhhV0jfdTWi3zocd6DPaZ40=
X-Received: by 2002:a24:2e17:: with SMTP id i23mr2484976ita.100.1559220944233;
 Thu, 30 May 2019 05:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190512054829.11899-1-cai@lca.pw> <20190513124112.GH24036@dhcp22.suse.cz>
 <1557755039.6132.23.camel@lca.pw> <20190513140448.GJ24036@dhcp22.suse.cz>
 <1557760846.6132.25.camel@lca.pw> <20190513153143.GK24036@dhcp22.suse.cz>
 <CAFgQCTt9XA9_Y6q8wVHkE9_i+b0ZXCAj__zYU0DU9XUkM3F4Ew@mail.gmail.com>
 <20190522111655.GA4374@dhcp22.suse.cz> <CAFgQCTuKVif9gPTsbNdAqLGQyQpQ+gC2D1BQT99d0yDYHj4_mA@mail.gmail.com>
 <20190528182011.GG1658@dhcp22.suse.cz>
In-Reply-To: <20190528182011.GG1658@dhcp22.suse.cz>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 30 May 2019 20:55:32 +0800
Message-ID: <CAFgQCTtD5OYuDwRx1uE7R9N+qYf5k_e=OxajpPWZWb70+QgBvg@mail.gmail.com>
Subject: Re: [PATCH -next v2] mm/hotplug: fix a null-ptr-deref during NUMA boot
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Barret Rhoden <brho@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@elte.hu>,
        Oscar Salvador <osalvador@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 2:20 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> [Sorry for a late reply]
>
> On Thu 23-05-19 11:58:45, Pingfan Liu wrote:
> > On Wed, May 22, 2019 at 7:16 PM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Wed 22-05-19 15:12:16, Pingfan Liu wrote:
> [...]
> > > > But in fact, we already have for_each_node_state(nid, N_MEMORY) to
> > > > cover this purpose.
> > >
> > > I do not really think we want to spread N_MEMORY outside of the core MM.
> > > It is quite confusing IMHO.
> > > .
> > But it has already like this. Just git grep N_MEMORY.
>
> I might be wrong but I suspect a closer review would reveal that the use
> will be inconsistent or dubious so following the existing users is not
> the best approach.
>
> > > > Furthermore, changing the definition of online may
> > > > break something in the scheduler, e.g. in task_numa_migrate(), where
> > > > it calls for_each_online_node.
> > >
> > > Could you be more specific please? Why should numa balancing consider
> > > nodes without any memory?
> > >
> > As my understanding, the destination cpu can be on a memory less node.
> > BTW, there are several functions in the scheduler facing the same
> > scenario, task_numa_migrate() is an example.
>
> Even if the destination node is memoryless then any migration would fail
> because there is no memory. Anyway I still do not see how using online
> node would break anything.
>
Suppose we have nodes A, B,C, where C is memory less but has little
distance to B, comparing with the one from A to B. Then if a task is
running on A, but prefer to run on B due to memory footprint.
task_numa_migrate() allows us to migrate the task to node C. Changing
for_each_online_node will break this.

Regards,
  Pingfan

> > > > By keeping the node owning cpu as online, Michal's patch can avoid
> > > > such corner case and keep things easy. Furthermore, if needed, the
> > > > other patch can use for_each_node_state(nid, N_MEMORY) to replace
> > > > for_each_online_node is some space.
> > >
> > > Ideally no code outside of the core MM should care about what kind of
> > > memory does the node really own. The external code should only care
> > > whether the node is online and thus usable or offline and of no
> > > interest.
> >
> > Yes, but maybe it will pay great effort on it.
>
> Even if that is the case it would be preferable because the current
> situation is just not sustainable wrt maintenance cost. It is just too
> simple to break the existing logic as this particular report outlines.
> --
> Michal Hocko
> SUSE Labs
