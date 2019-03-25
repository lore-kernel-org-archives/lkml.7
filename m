Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50B7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C25920879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="oxghoU3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfCYERi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 00:17:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51083 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfCYERi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 00:17:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so7426914wmi.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 21:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cmheFdWc1bDfDYTvQE/RQZvBHzMvLSWVjStZrxNss3U=;
        b=oxghoU3BsgelThxLKRNK4sWPtgiqP/FIPAi/imbQyu660GemIu3fEgxNxjeTIRJPW/
         5ta0AY9ZJXSpl/tl17QSTjbRkU4POrFCqv4iRbsrzASNyPS3XbgMpa1HFbhKxEuEktQR
         pTqqlEUlxblf3dr+bPOjuDq2kAloq6LICLrQ34mSTtIWNFC7dQnxwOQ2aKEKKFbFRpav
         aw0iaDtPqxz3rRHg6+E9yVZQSWUx903D0Xr0DhHim5LvKYcwGc/DsxjOWk+cM5SQu+iS
         v2Ocwujgh2mazGTeUn2zUx23FZXZk6lSp+YN3RJc8t3ENDd1DKs+86i3lc7hT93H9tn/
         3SmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cmheFdWc1bDfDYTvQE/RQZvBHzMvLSWVjStZrxNss3U=;
        b=tiAcDgIpv0CA9UDxurf6rZFiF1SaqrDIC/8uq2OzMArreqml9Rtihip8NbujroBLrl
         fuBryDFYSYlJwyeyiC9E1c8jV9GjpiaENIk+/nvmYCVFfAwn3J1qu612Tu4KlKaw/rhn
         GVu80/51c0votQUF5Q55au9KuRvg56DogC7LysCP6E64rm7k7S0avT+QYdXNCnV+ARZB
         b9Kg32joc/eJpGSqxwCu5LbyEeA7G+G68p56O0kDJ9/AZcyMfpfkAwKsRYqF9p//O5+8
         WhfWOAJGpPjUCl2j1HFza1piTB+sBxhfUFRP33J+0QK3QZdvefXAailnNtr9ePjvY6SD
         hfzQ==
X-Gm-Message-State: APjAAAX7RQALmMG3/kP9gZVe5damZF/xl81bBlL+xhRj8hzZ4wmTRk6C
        FUijUDD+pRYyM1qkll1Sdc6tZiuXAch/QffeYWqbTw==
X-Google-Smtp-Source: APXvYqybFx/kXUFhCGsqWtMHK+exoArZmnLJ/lclI8sdgwaIZt69rS75baC/qiOnvb5rkPZG4kjw0pkCwq+hj39qPzw=
X-Received: by 2002:a7b:cf18:: with SMTP id l24mr2088991wmg.132.1553487456191;
 Sun, 24 Mar 2019 21:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190321094710.16552-1-anup.patel@wdc.com> <20190321094710.16552-5-anup.patel@wdc.com>
 <20190322133330.GB32464@infradead.org>
In-Reply-To: <20190322133330.GB32464@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 25 Mar 2019 09:47:24 +0530
Message-ID: <CAAhSdy27fGCiFc_g06Q3AnaVEJ_P6GeOoEFw5vA6tkN++4xRTA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] RISC-V: Remove redundant trampoline page table
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

On Fri, Mar 22, 2019 at 7:03 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> >
> > -     /* Compute satp for kernel page tables, but don't load it yet */
> > +     /* Compute satp for kernel page directory, but don't load it yet */
>
>
> >       /*
> > -      * Load trampoline page directory, which will cause us to trap to
> > +      * Load kernel page directory, which will cause us to trap to
> >        * stvec if VA != PA, or simply fall through if VA == PA
> >        */
>
> If we want to nitpick comments I think this should take about the
> page table root or something like that.

Okay, I will update comments.

>
> Otherwise the idea looks good, but I really think we should do this
> before all the changes to the setup_vm code.

Sure, I will move it before setup_vm code so that setup_vm code is
further simplified.

Regards,
Anup
