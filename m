Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9740C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 03:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E19520856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 03:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="g4m4GWyM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbfCZD6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 23:58:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34772 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbfCZD6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 23:58:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id o10so1384403wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 20:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iRH1s9YJiR31RJ2pG6ORxQtgVj/UdG3ppK8QCCdxAA0=;
        b=g4m4GWyMNOWkRVyfb+owJZVT4jIOlAsRd9tFpObihKfpMBk2r+gA09kyiKy7vhtftA
         Gp303w373mNuTgqCMyjNjIQYNmObPu7Y5fCeE74mockFkoKhwOaM+PCT1wzEe4+fzucf
         nsWmWXDPWlT7tLjdCsx5s8WdiI0aDxWOUf++Z7bSElLuSJF33gDapD09sDncRUK/0R45
         kIrtvdMYDgCOiMOnNOFhyzih8gK0H1VC89JGKB9DgHGIApuUvLvLSUZxnnSJd6cko0Ce
         JLuoz3j7whiOF/uzLTdSXFPTzE1ak0eoYKrYD9Bovk9tac9jEVz7QX3rV+t/BnL+nPEG
         swqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iRH1s9YJiR31RJ2pG6ORxQtgVj/UdG3ppK8QCCdxAA0=;
        b=nn+7z5kRU68rGF2GOqwO5SQqXvr4g0cVT8GB8Rhdi+M6kCow0FQSVQssPDApIlPqF6
         2rt37xzJOS5N4GVcTSvLYOBseEOd00JGrT3wUD0MEEEC1iiqnTVC4CYjDxd5r6PvFOGe
         xsisHw/B5dzC+KD2AdT0Tpwd53F3dJWT/VfoMt193dgjAv15xnpXQkO1jSSffCmoBKoe
         ZDAc/zt0E4H0x1abrk53WlHL0InDMqDznYOBZYoWMAlOf8pAUHqyzqFIUl2j6RVRe9fW
         pCQ72oiOgYBlyz4NQEMlePFyQwZbCD048QfA6ZDiVKYM2MwFFLlCEeMC+hFtdMg/M+j9
         ZuHw==
X-Gm-Message-State: APjAAAVskdoKd0YBN364PZVxpya1MVs1g9QlbqRKJzjqJRekxSd8jq6P
        eMSx+4PQRcIy85ODQnNfZEhsArfZt9goQAs72BNgnw==
X-Google-Smtp-Source: APXvYqz3TE5j2MQ/ay3Y0//XjNpnqYEOIp9n6myVVm0DT6hB4/Awsu1fzt3kbP21He5Bv1wG4AWlxOkW9EvAGrFZanY=
X-Received: by 2002:a7b:cf18:: with SMTP id l24mr5300725wmg.132.1553572684717;
 Mon, 25 Mar 2019 20:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190325083027.6393-1-anup.patel@wdc.com> <20190325113748.GA27843@infradead.org>
In-Reply-To: <20190325113748.GA27843@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 26 Mar 2019 09:27:53 +0530
Message-ID: <CAAhSdy1XsLkrJRyzi9WV6uAi+WFC420hs_asE=1oQ5L2ZrTuOg@mail.gmail.com>
Subject: Re: [PATCH v3] RISC-V: Always compile mm/init.c with cmodel=medany
 and notrace
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 5:08 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +ifdef CONFIG_FTRACE
> > +CFLAGS_REMOVE_init.o = -pg
> > +endif
> > +
> >  obj-y += init.o
> >  obj-y += fault.o
> >  obj-y += extable.o
> >  obj-y += ioremap.o
> >  obj-y += cacheflush.o
> > +
> > +CFLAGS_init.o := -mcmodel=medany
>
> Can you keep the two flags adjustments togther, preferably towards
> the top of the file?

Sure, I will more the flags together.

>
> > +/*
> > + * The setup_vm() is called from head.S with MMU-off.
>
> s/The //g

Okay, I will update.

>
> Otherwis looks fine:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Regards,
Anup
