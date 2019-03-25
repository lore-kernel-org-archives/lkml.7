Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76947C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E3B20828
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="ymR9rmTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbfCYDUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 23:20:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43846 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbfCYDUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 23:20:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id k17so393543wrx.10
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 20:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4frdgXGH7cSsbNOuZ25SduNt9T/mHeqrTc80EFiJ7tg=;
        b=ymR9rmTAlBzO/iMnBt39G4DKcBy6CxEfVN0QDSapbkjDhcb9rJ1SFFcd+9RXj1O81B
         /VyGDoZ8q7iuzZtixA6UY1vvj9VaI19YR+YoGsayqHBnvjKlcqCmA3qa/z6rAR3kuXA/
         Fb9+ThDaxEiLN3/hZMcoTffcFNZeI4RyLjSOq8v5kt3CpdnloqF5Ri32RNaiyvZE0S6I
         vOg2NUHgMH0jijBEFMemnZ0w8i0RuVduhJP4DveKzdZkIsJ9Ipj8gOqynQtVJi5qqR4Y
         OyxGJ3Pe4s8ILQSXuFmg2yNRgISNHQgQ550Cr49AQaaeg4DAz8eV1ZyUkMXsziRHx5Av
         E5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4frdgXGH7cSsbNOuZ25SduNt9T/mHeqrTc80EFiJ7tg=;
        b=Ii3cvUpBQuTi4/P9DLLcgK+afuQdEQfIGIIaEweK50nQFO9IKLhH9N43R3dVMTcsjT
         /H6WQfwJ2D5QD+lTyBf0sAW5fF7LzuJgax/QsfSfTfgQc/zrNwSNvE1/ziv99xEKyWtj
         CPL8n+3b7LwIvQTDeEV5HRazbDnp+UYseujmyko+dpppv2eCYOJaLqu8/vW0cgjq0yVk
         uTCgFvbpEGdu3kocFaRSDkyjav58EFnGb7DHXTToMIYrsnuQfus+9vtHR/bz3/a9dzQc
         IlRzK5ysDTGPwnYM79lU5AZZcnOgWoKgiqXZVuLN8QTCJ9oyCvsiO6T79NlzYdraXLiY
         XGzQ==
X-Gm-Message-State: APjAAAUXKhegc7ZRJQC3VzO0qUBJmvQB5wMkwSFCt7pSEMZYmoE3pOnl
        bx6UUlwIRSbbTFnAsVftWdluPYqIIP0PVNPWokuSIQ==
X-Google-Smtp-Source: APXvYqzVuVFW+JYOd73puecteXHdHSWmZReIZrIc+m3xk8Wkz8sbpPU8+81litdzQ/4KJ2i9WfhHqFWhFFe3SJvNVe4=
X-Received: by 2002:a5d:4087:: with SMTP id o7mr2277794wrp.9.1553484001453;
 Sun, 24 Mar 2019 20:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190324110804.68555-1-anup.patel@wdc.com> <20190324145708.GA3355@lst.de>
In-Reply-To: <20190324145708.GA3355@lst.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 25 Mar 2019 08:49:50 +0530
Message-ID: <CAAhSdy1PRXpn-mgB0p4N-9q87xtWTwNPKJsUaGc6nTyz0ZsJug@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Always compile mm/init.c with cmodel=medany
To:     Christoph Hellwig <hch@lst.de>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 8:27 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Sun, Mar 24, 2019 at 11:08:29AM +0000, Anup Patel wrote:
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>
> Huh?  I don't think this is from Mike and me.
>
> > +unsigned long va_pa_offset;
> > +EXPORT_SYMBOL(va_pa_offset);
> > +unsigned long pfn_base;
> > +EXPORT_SYMBOL(pfn_base);
>
> Can you move va_pa_offset and pfn_base next to the swapper_pg_dir
> declaration?  Thats where I move them in my current nommu patchset,
> as that allows to just have a single CONFIG_NOMMU in mm/init.c.
>
> Otherwise this looks fine to me.

Sure, no problem. I will send update and send v2.

Regards,
Anup
