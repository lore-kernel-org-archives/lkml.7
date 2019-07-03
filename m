Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC628C46478
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86081218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="QWyJjuDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfGCAml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:42:41 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36702 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfGCAml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:42:41 -0400
Received: by mail-ot1-f66.google.com with SMTP id r6so506873oti.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 17:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0AGSyMvf0zexOMokX4EpC11/R6d7poyoJeo3TShyztM=;
        b=QWyJjuDYJNyB44jlcWkT2Do84tRKoTgiiRWbe8c+iRWLpEQXaFEgT0w9ZSZH2Cs9Tf
         NgpgZ8pPPSpSGIZa0MJeB+dtoragQ2H4oPc7bonqaiiNZhCo2ZOJ7wWuogIDhfx9e4s/
         ZfZgI41C2VLSea49134z094gXVVtjlcxZP9bHzuIY6XmQJlEzTwh4QKqYp1GvIhzTBqP
         C0rfgeI6tqW1a8lFZkStsJB+FEkRAIaU3kaEYBQPQGtfGa8CabE6/0FtfDI1lC7Xc0F+
         6+LCGjufHIildbzfwK5DH2jwZiLcBGxTCOHmP+FN42+bD0bPJuwOEVfltIw786Xw5ebf
         Gk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0AGSyMvf0zexOMokX4EpC11/R6d7poyoJeo3TShyztM=;
        b=W0uXxpdT0MiHTijrpMKCfM9ihAbVhgXfhVnbIfOpUzrCN48ZL93lXsF/Wdvneh5fnJ
         hBwOrFLStv9xXsv3oIBLtPsWy2xWu5XyXfjy9WEepnpAKKvSn+EINf93N2dJmhufiOrv
         D89VeOQNw2+Lcj/iVhlEwk+cCeZ0UILlnfzl6ZZMLTv/Skj6C1CF0DOCp1rdcAQwkxp9
         V6IcFkVzKKWhawmQNaMOuwNnpykEIOr98Rv5BV+cl4TkvVcnxKRSRZUJsYKzYDb5i+EI
         kibXenSHx7zVoNyw3X/ahhPtMxMXshZmEk4PUoZO4w87M30APsuQlO09kiJpVSiuzfPz
         TFeQ==
X-Gm-Message-State: APjAAAVtkpz+Es9WSNIbV0RRyrQn0hSH/o65QYIO8d+UGKBAOYTgnfKN
        qEwP/24K4mz48F3aHgV/QM3f47aaK8uMUBjJCPiG3g==
X-Google-Smtp-Source: APXvYqwt/AruSNRNxTjRUQk6hQeRuA06O8pI4+Ci7eZfCus0eFiY7ywxyleud1COJr+2irFyLNDBtxvmvCpYM8UHPzM=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr25111745otn.247.1562114560450;
 Tue, 02 Jul 2019 17:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4jjqooboxivY=AsfEPhCvxdwU66GpwE9vM+cqrZWvtX3g@mail.gmail.com>
 <CAPcyv4h6HgNE38RF5TxO3C268ZvrxgcPNrPWOt94MnO5gP_pjw@mail.gmail.com>
 <CAPcyv4gwd1_VHk_MfHeNSxyH+N1=aatj9WkKXqYNPkSXe4bFDg@mail.gmail.com>
 <20190627195948.GB4286@bombadil.infradead.org> <CAPcyv4iB3f1hDdCsw=Cy234dP-RXpxGyXDoTwEU8nt5qUDEVQg@mail.gmail.com>
 <20190629160336.GB1180@bombadil.infradead.org> <CAPcyv4ge3Ht1k_v=tSoVA6hCzKg1N3imhs_rTL3oTB+5_KC8_Q@mail.gmail.com>
 <CAA9_cmcb-Prn6CnOx-mJfb9CRdf0uG9u4M1Vq1B1rKVemCD-Vw@mail.gmail.com>
 <20190630152324.GA15900@bombadil.infradead.org> <CAPcyv4j2NBPBEUU3UW1Q5OyOEuo9R5e90HpkowpeEkMsAKiUyQ@mail.gmail.com>
 <20190702033410.GB1729@bombadil.infradead.org> <CAPcyv4iEkN1o5HD6Gb9m5ohdAVQhmtiTDcFE+PMQczYx635Vwg@mail.gmail.com>
 <fa9b9165-7910-1fbd-fb5b-78023936d2f2@gmail.com>
In-Reply-To: <fa9b9165-7910-1fbd-fb5b-78023936d2f2@gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 2 Jul 2019 17:42:28 -0700
Message-ID: <CAPcyv4ihQ9djQvgnqZoTLRH3CwFhpWK_uUrmWSLH_3-Fi1g1qw@mail.gmail.com>
Subject: Re: [PATCH] filesystem-dax: Disable PMD support
To:     Boaz Harrosh <openosd@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Seema Pandit <seema.pandit@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Robert Barror <robert.barror@intel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 5:23 PM Boaz Harrosh <openosd@gmail.com> wrote:
>
> On 02/07/2019 18:37, Dan Williams wrote:
> <>
> >
> > I'd be inclined to do the brute force fix of not trying to get fancy
> > with separate PTE/PMD waitqueues and then follow on with a more clever
> > performance enhancement later. Thoughts about that?
> >
>
> Sir Dan
>
> I do not understand how separate waitqueues are any performance enhancement?
> The all point of the waitqueues is that there is enough of them and the hash
> function does a good radomization spread to effectively grab a single locker
> per waitqueue unless the system is very contended and waitqueues are shared.

Right, the fix in question limits the input to the hash calculation by
masking the input to always be 2MB aligned.

> Which is good because it means you effectively need a back pressure to the app.
> (Because pmem IO is mostly CPU bound with no long term sleeps I do not think
>  you will ever get to that situation)
>
> So the way I understand it having twice as many waitqueues serving two types
> will be better performance over all then, segregating the types each with half
> the number of queues.

Yes, but the trick is how to manage cases where someone waiting on one
type needs to be woken up by an event on the other. So all I'm saying
it lets live with more hash collisions until we can figure out a race
free way to better scale waitqueue usage.

>
> (Regardless of the above problem of where the segregation is not race clean)
>
> Thanks
> Boaz
