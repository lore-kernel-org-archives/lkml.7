Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B79C76196
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 20:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D094B21849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 20:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrW2+V7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391590AbfGRUeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 16:34:16 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35552 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbfGRUeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 16:34:16 -0400
Received: by mail-qk1-f194.google.com with SMTP id r21so21607478qke.2;
        Thu, 18 Jul 2019 13:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lUeG90JN23owse4hkCx6s3PvuPmRRtzpsafpqQdcTUA=;
        b=QrW2+V7Xl/KTpbKakLlvwVZhX3mvxwY8oW2vB8V+YuPlRdScITuH23acCo57C3rm+/
         h14/iR5ajTzevvTZgDQqOGErulK0PjguBwTAsH9Y3EKi7j2DqAkinW13yKCiWiMvwlhz
         G337M9FxyP8xW3prNI+Y46tV6LKGfIKoJnpWP/StoXaJ8VaE6k8S6GraWUdl1DQ0jPVo
         5Nzq45cBYGbC8mYGBvPk+lRY+CeB7ljQ0M/WcypXEL0YLyup+trYqw1VrHc7N+XihAnT
         qSr15Qriyhre6ikVXcxStPhA9GKq5L81kUbOPa4ctMEOcvvh0wTxrAiF0q1LX9t8rDOw
         pMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lUeG90JN23owse4hkCx6s3PvuPmRRtzpsafpqQdcTUA=;
        b=tV6AzQ70CZ50bIq9WkIk8mYzhWZnE43IifEmj1tFpm0upBP1EYn3XXh68o+Kv/gTH7
         rV3kE6Cf6f+45UPdPM5yE2lLcWq5QnSnwtQ6EWfOO9yGNcQk/q8l/+lPGfSofhZwjTSM
         wB7H4udHyzDZJGfpj/MOZHL6O5V+Xk5oUmVWzzyL+PEvlm2stJV7XbCjn+iJ8M9oa5g9
         r9MEIh7qWvc/O09UmJGa48ksNCLYnnjp83KVpZUqJ7rwOZmu/uY3BTWQvgEivKE3l1Ia
         sinDbQURHHwgs6x673X9h8+CCC15IpOYDQGtjwR6beBYOKfgDQriNjVVsdmPCbztC7/E
         qYCw==
X-Gm-Message-State: APjAAAXGYLlAm+58JuDOP8Wdlm/SjefGYl5/R2l0pnviuR4AWgYDvUI8
        WQd0NjFxf88hHk7kjLRMJG/6LwimFx1+PyJcqwGTpQ==
X-Google-Smtp-Source: APXvYqwjvJkRVs5rf6lR3JoHp630zNQ2CmcMU/UwjepgFtUoHLwCD2p9IdMuPtw8xc2XXrQdtk3z1AdJz1RZ4J6/Kh8=
X-Received: by 2002:a37:9042:: with SMTP id s63mr31248155qkd.344.1563482055130;
 Thu, 18 Jul 2019 13:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190716055017-mutt-send-email-mst@kernel.org>
 <CAKgT0Uc-2k9o7pjtf-GFAgr83c7RM-RTJ8-OrEzFv92uz+MTDw@mail.gmail.com>
 <20190716115535-mutt-send-email-mst@kernel.org> <CAKgT0Ud47-cWu9VnAAD_Q2Fjia5gaWCz_L9HUF6PBhbugv6tCQ@mail.gmail.com>
 <20190716125845-mutt-send-email-mst@kernel.org> <CAKgT0UfgPdU1H5ZZ7GL7E=_oZNTzTwZN60Q-+2keBxDgQYODfg@mail.gmail.com>
 <20190717055804-mutt-send-email-mst@kernel.org> <CAKgT0Uf4iJxEx+3q_Vo9L1QPuv9PhZUv1=M9UCsn6_qs7rG4aw@mail.gmail.com>
 <20190718003211-mutt-send-email-mst@kernel.org> <CAKgT0UfQ3dtfjjm8wnNxX1+Azav6ws9zemH6KYc7RuyvyFo3fQ@mail.gmail.com>
 <20190718162040-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190718162040-mutt-send-email-mst@kernel.org>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 18 Jul 2019 13:34:03 -0700
Message-ID: <CAKgT0UcKTzSYZnYsMQoG6pXhpDS7uLbDd31dqfojCSXQWSsX_A@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] virtio-balloon: Add support for aerating memory
 via hinting
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Zhang <yang.zhang.wz@gmail.com>, pagupta@redhat.com,
        Rik van Riel <riel@surriel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        lcapitulino@redhat.com, wei.w.wang@intel.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, dan.j.williams@intel.com,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 1:24 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jul 18, 2019 at 08:34:37AM -0700, Alexander Duyck wrote:
> > > > > For example we allocate pages until shrinker kicks in.
> > > > > Fair enough but in fact many it would be better to
> > > > > do the reverse: trigger shrinker and then send as many
> > > > > free pages as we can to host.
> > > >
> > > > I'm not sure I understand this last part.
> > >
> > > Oh basically what I am saying is this: one of the reasons to use page
> > > hinting is when host is short on memory.  In that case, why don't we use
> > > shrinker to ask kernel drivers to free up memory? Any memory freed could
> > > then be reported to host.
> >
> > Didn't the balloon driver already have a feature like that where it
> > could start shrinking memory if the host was under memory pressure? If
> > so how would adding another one add much value.
>
> Well fundamentally the basic balloon inflate kind of does this, yes :)
>
> The difference with what I am suggesting is that balloon inflate tries
> to aggressively achieve a specific goal of freed memory. We could have a
> weaker "free as much as you can" that is still stronger than free page
> hint which as you point out below does not try to free at all, just
> hints what is already free.

Yes, but why wait until the host is low on memory? With my
implementation we can perform the hints in the background for a low
cost already. So why should we wait to free up memory when we could do
it immediately. Why let things get to the state where the host is
under memory pressure when the guests can be proactively freeing up
the pages and improving performance as a result be reducing swap
usage?
