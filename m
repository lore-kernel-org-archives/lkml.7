Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4E4C3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 03:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FD2215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 03:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Oq9bx7v0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgABDue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 22:50:34 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35449 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgABDue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 22:50:34 -0500
Received: by mail-ot1-f67.google.com with SMTP id k16so50735784otb.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 19:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=cO6PVKznnSAM6d/hhV5xCs6Kkc34TVo3fVvX4Ug3jHg=;
        b=Oq9bx7v0qeiZy3puiVm5NDqrFRfXBpqDtVJ615NJpgp3zKVheoOjCaeutuK5nlf9Wt
         WD5Ga6Q7Gx9aidGArb4qAdxJp86jen0KO95ayCJlV9nR4TgiFVSH++vXWZtg659FvUYL
         Z+lzUMmC/yO6oc8sQ+flCzgtAir6EA2O7Fu9hod3gavb0sNOHTu6oXoXfUjjj7cNqDFS
         rxFSQcMfGn8Db1q+wUHvPxoMeYU+A88HQN/oOKt3UPjiPVFbHLch8GiXXU8T84H9Qmz5
         E46VLLBtEjYx9iAkTHQwJt8mHUz3xgFPSRpFX54fUy/RsJLBS0YuTGQ63OexnyOpTdAT
         ZODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=cO6PVKznnSAM6d/hhV5xCs6Kkc34TVo3fVvX4Ug3jHg=;
        b=Da+V7MEwtzucVKMNZoosKwt5XPBrbcZ/RbtRH2tusiwCuUXmUsOvPUDfpAFi7cPabE
         M91tc/h3kz8HZyiVMWeofyPzd+8782W489Pq087YqbXW+55sN6wfjvBl8Ct4TA8ZJ1xz
         cFsaxcPaBgiEDalGV0e0qgR8+3BMH/vnCiY+C2bfzWznB+GFdrraYeVpKHql1S0f0Yii
         /C7XFpRdT0I5DPo9QHxGEYbfrUT/4nI1jxmy3yVuTFx+DrrZLwRsHDDllF80GmNpqTFm
         +zXbXH1JP2e2QCBCbGoe7FeH0xtqxr+5Ul+Eko2dipvHcfF1ElRYr9YG0WpA1LLNDIIo
         da7A==
X-Gm-Message-State: APjAAAXZ93dDLGBqGqPtUCr3ED24Y7MfXNoaiBSGeLJAy1KqtfOWKbnj
        GhOZkaYb2zbSA7z4xTxgD2LY9lzmdBJMqyZsIocprQ==
X-Google-Smtp-Source: APXvYqwh7Ei4wPCDPdjD1UcGJHaq9HDgKEZVV+BaXlYcrf/qdBaIOE6CGfdXDD9qGGv/S+iaU+hosjg2fTlhulLr01c=
X-Received: by 2002:a9d:784b:: with SMTP id c11mr85019992otm.246.1577937031888;
 Wed, 01 Jan 2020 19:50:31 -0800 (PST)
MIME-Version: 1.0
References: <20191223084614.67126-1-zong.li@sifive.com>
In-Reply-To: <20191223084614.67126-1-zong.li@sifive.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Thu, 2 Jan 2020 11:50:22 +0800
Message-ID: <CANXhq0qTG-ezdrJpOEd9fhc-_iRL2syASO9KnQxbDfxoVXwfqQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] RISC-V: fixes issues of ftrace graph tracer
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, rostedt@goodmis.org,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 4:46 PM Zong Li <zong.li@sifive.com> wrote:
>
> Ftrace graph tracer is broken now, these patches fix the problem of ftrace graph
> tracer and tested on QEMU and HiFive Unleashed board.
>
> Zong Li (2):
>   riscv: ftrace: correct the condition logic in function graph tracer
>   clocksource/drivers/riscv: add notrace to riscv_sched_clock
>
>  arch/riscv/kernel/ftrace.c        | 2 +-
>  drivers/clocksource/timer-riscv.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> --
> 2.24.1
>

ping
