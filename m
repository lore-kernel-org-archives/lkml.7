Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4A3C282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A172077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="14TjjWey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389233AbfDYHRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:17:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35701 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387416AbfDYHRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:17:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id y197so8940186wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 00:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y/BUPD6d+UtQII/yZuGbxt7S/zR1HCXjPhQ5wZe2CYQ=;
        b=14TjjWeyO/+ZcGiUgm+nysR7uM0YIFldzaounkys1ZvpchAKEeBY3LpuiTZsBZ61vb
         siXfUnNUmUoA6cb4iZYESWz1Kg2cK4y+b3hxG7jD8Q2KI7wNBGMgTK5GfsFfY7+1lNqA
         WH5TTVe24dMgp2Jp+e/L2tdeSgMYnlIm4nI1MbBU4C2jf4by0pwr9LF955Cn417Vq1zW
         MpLE8AnaB44adbYXviK2SH7rb94DFzDBiPd8X6pQ3v8sIrmXK8X9cuw0qAemCgb5pS/V
         qGXFoWr78/vxeuW4ePOKaNiy+UfwxcCWItis6tzBNDAF1DxaPhNtEf1CwU5HhuRP+geJ
         yphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/BUPD6d+UtQII/yZuGbxt7S/zR1HCXjPhQ5wZe2CYQ=;
        b=ZQVooYYVMG48MSQ8VXpSim/PMUyHatpKGb/RIZxfj4aX1S08R8dfvg/aEovHcsMT5x
         lzK0rmlQeb0el0p4c1Lf97Y8ou1xdH07EGIoYxClRLtNb96bDzE4051B8IsX/fT/byEw
         7K6p0ZRicJ7icQOnboAPL3kAVnHCyC9sEJpkxGsf/9tsUXirwKXjBrzbmqXPt9TzRBBV
         fQ2jGiY9+8FQrbSXT0Vp9Jd9c9wAJeUBB+NLERmH6+tb1R1onBz1WVUWkdgJk5iGmT8z
         JdZI/PuASrfx0FdacyyQNujOTEkA3PiH/7ovEKZ2ct4Y2D0CF8y0oOnXxh4b2vAVfU2P
         xP8g==
X-Gm-Message-State: APjAAAVlg+ahUw1mbf5PLZNyQ73en/8ioavI8PD3g7z5qGvQZiV/t+zb
        +Xso3gFwyfr2VxbgvDDaqHUP5YjQERm31zOmOQcof3nj
X-Google-Smtp-Source: APXvYqyWmug1EZPZRrn81ikjGJ5Rr25YGmfW86k2Vc7/+guwtfM4kUSh659R0i1DWNkuUcy8Oqzqi5XYFEpMl7JE7O4=
X-Received: by 2002:a1c:a907:: with SMTP id s7mr2404626wme.153.1556176624209;
 Thu, 25 Apr 2019 00:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190425055015.45487-1-anup.patel@wdc.com> <20190425055015.45487-3-anup.patel@wdc.com>
 <20190425055757.GA30545@infradead.org>
In-Reply-To: <20190425055757.GA30545@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 25 Apr 2019 12:46:52 +0530
Message-ID: <CAAhSdy36q1R8HQRG3kXDqj5JoJbO_drignvO7wCHJ3-6wkE5rw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] RISC-V: Add interrupt related SCAUSE defines in asm/csr.h
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 11:28 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +#ifdef CONFIG_64BIT
> > +#define SCAUSE_IRQ_FLAG              _AC(0x8000000000000000, UL)
> > +#else
> > +#define SCAUSE_IRQ_FLAG              _AC(0x80000000, UL)
> > +#endif
>
> Please keep the existing defintion that doesn't need an ifdef..

Sure, will do.

Regards,
Anup
