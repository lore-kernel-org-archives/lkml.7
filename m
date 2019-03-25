Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40939C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073D820863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="LYcxUCWN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbfCYHB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:01:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33642 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbfCYHB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 03:01:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id z6so8862233wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 00:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KvnJRariGhCONlRkbXzdF6w8C5rUCgeKPJ0uWv2M9Us=;
        b=LYcxUCWN8lPhtX8z9/qSmsIAUJgGbIW0MtmpLmAxpuELSkMFJkCs1poGCedAZpt+sk
         coWZo/PoxNoZd7Ztu2/NgRfWqIN02d95xLNCri2ZuWVFHTUNhI0n7jKUZh/WBTJRFz5Z
         L1JOxmsqvnFPTKGkqDZ20PN2UUYVMNaFmTyi2EhTgWJ+GKPIJWHnmSCNmC1pQutj7FAS
         M08cqXenzQSW8eU5E0+VNi7bvsOdzeZeNGHk2dRkVq0NBjjv6wUsFJB2XUn6TS2szisb
         01zeGln5gOd5dOUmks3Y/jqZ7fFbo1Sa/utYBfYrs2eJm2RkJQVLT2DDbcswuoSBh4q6
         Y/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KvnJRariGhCONlRkbXzdF6w8C5rUCgeKPJ0uWv2M9Us=;
        b=h040sKJNyR/xpVC3e6OVkeGLdy27MDSFPr60KremxBY4Gu4xFnpY2ONQuWTXlgHApj
         aVkcQ/YPrLXJu47jZULDG2bhyptyYDHI7M/yb/ZLyNHHb5RWXKW4fDG8PQuoj4TTQnHe
         PSjL/TjDe0pYzWsn/9+1mtewU0/fVArDWS7nChq6COhdi/uq4QMvb30furkfLDrfkiQq
         5X1J1dJHhiN3PrkzL/6C7mMrHjx9jqXmsE96nhHPR6NTNrcWuYdPbfiUWt4N7sN8CIwX
         l/c+vnE902pwSwoaXvBwCvSK83WKgW+XPxPu6NVpSpXWda8U3yMxtJrJssHmXqfon+gf
         ZfrA==
X-Gm-Message-State: APjAAAVzCjpgLBPspFmaS3Nud21Pg05AAzrvnNIFuI5r8GnQwKA0luPT
        PJQuGIdXnUOboCcohveS9xj+lbPY9Tn+chmDtqzS1A==
X-Google-Smtp-Source: APXvYqxwYXa4uYwkaFCS1hzKyQqYyN8SdJvPQheIEeUZY9/kgIzrQScC3DReQvk7yeRlVezjJR2rpfPG/kZBvvr3Y2k=
X-Received: by 2002:a7b:cf18:: with SMTP id l24mr2412100wmg.132.1553497316107;
 Mon, 25 Mar 2019 00:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190325033648.16171-1-anup.patel@wdc.com> <20190325052550.GA30996@andestech.com>
 <20190325064826.GA29111@infradead.org>
In-Reply-To: <20190325064826.GA29111@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 25 Mar 2019 12:31:45 +0530
Message-ID: <CAAhSdy2-CX729tVuuZzArswpFEC_OeRXhwXtCaiNe53AuzqdTw@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Always compile mm/init.c with cmodel=medany
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alan Kao <alankao@andestech.com>, Anup Patel <Anup.Patel@wdc.com>,
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

On Mon, Mar 25, 2019 at 12:18 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Mar 25, 2019 at 01:25:50PM +0800, Alan Kao wrote:
> > Hi Anup,
> >
> > Sorry for being late to the party.  I think one more thing should
> > move together with setup_vm():
>
> Ah, I wonded about that yesterday but wasn't sure.  Maybe notrace
> is a little cleaner?  Either way we should probably document both
> the mcmodel and notrace assumptions in source comments for the next
> person touching this code.

The setup_vm() should be allowed to call other functions within mm/init.c
so let's go with file-level notrace (just like how it was done) for
kernel/setup.c

I certainly add comments for setup_vm() based on all our findings so far.

Regards,
Anup
