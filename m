Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE27C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A63218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555347500;
	bh=GYACN0p2wjGAv+jMcwdNtW95WFzRSOnlWbGcMv4b6po=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wU184JR7IlgmdTAbdMRk4r54mUmK6pBKaxsSL4U31XJXqXryoKd31dn/QQ/ObvRwK
	 nphTU7Er00CPD9q5oRGcEv1lYZ2GNDSeRfpOjLCzEiTHKq+NAm0b9bd8pvM31F+75c
	 txgFkP+HTjGeydJyalqbbrrhFkwiYL6lalF1Tlhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfDOQ6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:58:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:32892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfDOQ6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:58:17 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C900E218DA
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 16:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555347497;
        bh=GYACN0p2wjGAv+jMcwdNtW95WFzRSOnlWbGcMv4b6po=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZW0bL8k3pZz3YEAIBJW65uPnMTFTzlmZeddbs0gxoFBms70VDJYWNkQWw/Qd95WXc
         EKK8oaeIbAxDL2TvmhHswkHHX61RM2EKW9GXEOTLF4NtO6UPAtOj1V87Rs94ME8GJF
         xd4VS6cXkg+Axq63gVkPr5PbnndKJrNrmT+0c1Hw=
Received: by mail-wr1-f49.google.com with SMTP id k11so22923821wro.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 09:58:16 -0700 (PDT)
X-Gm-Message-State: APjAAAX3xy457WB7wX8fx6JcT6otLVJoqkj1+EtHr9aa/wJa56+CRkXv
        f4leOVSBBOx2hFQcF/DUMhh1mJ5KPook60GKwc5+WQ==
X-Google-Smtp-Source: APXvYqznepmgkucmvgPJhDoJefIZf7GUfwg0Ewga/VKVSzk3Ni/n9cuYtRXyTUMuflCdiSpgj3zqgzE9ABRFLFdpZgs=
X-Received: by 2002:adf:c788:: with SMTP id l8mr47503243wrg.143.1555347495330;
 Mon, 15 Apr 2019 09:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190414155936.679808307@linutronix.de> <20190414160143.591255977@linutronix.de>
 <CALCETrUhVc_u3HL-x7wMnk9ukEbwQPvc9N5Na-Q55se0VwcCpw@mail.gmail.com> <alpine.DEB.2.21.1904141832400.4917@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1904141832400.4917@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 15 Apr 2019 09:58:04 -0700
X-Gmail-Original-Message-ID: <CALCETrXpmj=wp7Uq5r3kUE9iLEg2w6V=zsEL3sMHfc0HF1Yc+Q@mail.gmail.com>
Message-ID: <CALCETrXpmj=wp7Uq5r3kUE9iLEg2w6V=zsEL3sMHfc0HF1Yc+Q@mail.gmail.com>
Subject: Re: [patch V3 01/32] mm/slab: Fix broken stack trace storage
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 9:34 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sun, 14 Apr 2019, Andy Lutomirski wrote:
> > > +               struct stack_trace trace = {
> > > +                       .max_entries    = size - 4;
> > > +                       .entries        = addr;
> > > +                       .skip           = 3;
> > > +               };
> >
> > This looks correct, but I think that it would have been clearer if you
> > left the size -= 3 above.  You're still incrementing addr, but you're
> > not decrementing size, so they're out of sync and the resulting code
> > is hard to follow.
>
> What about the below?
>
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1480,10 +1480,12 @@ static void store_stackinfo(struct kmem_
>         *addr++ = 0x12345678;
>         *addr++ = caller;
>         *addr++ = smp_processor_id();
> +       size -= 3;
>  #ifdef CONFIG_STACKTRACE
>         {
>                 struct stack_trace trace = {
> -                       .max_entries    = size - 4;
> +                       /* Leave one for the end marker below */
> +                       .max_entries    = size - 1;
>                         .entries        = addr;
>                         .skip           = 3;
>                 };

Looks good to me.
