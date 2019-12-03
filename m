Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556B1C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 03:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E422206E0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 03:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="RSZFGEoT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfLCDDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 22:03:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43444 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfLCDDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 22:03:45 -0500
Received: by mail-wr1-f66.google.com with SMTP id n1so1744358wra.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 19:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nSSI5Pl4WsOsY1gybGzxrdiZXoJtDsuzjGBtDtfi5nQ=;
        b=RSZFGEoTRXXTEiFiqV9Ygwye58GVZCrG3BAvVe1gR2fWzt7MnfPmLjaDG3tYawEz6E
         lJKpLVwxLdFROe8VzQJkYfds1g+KMGzf9/5u79iJ9Ba3wmvbIYHb8CZ/Q+hhGxmyP9VX
         QnSvtItTZQ2mxF20nrfwZbQDVrBo4efctNSQKQnQbpQvn0yR4VNtaDvJB0MJ2S1BoX+x
         ipAPJ6JjTJBw7Qdz4nr1EiBap+l86VNHjsApR0JU/74Jf+mM2TOO5+Zq7jpb1HU/LGW/
         kRZVkGM8OzPNN8cA/1yjjwqeQHVTY75vjaLI2AfSaJbe724IQBp0hQfVjjkqN40PIHBa
         7Ong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nSSI5Pl4WsOsY1gybGzxrdiZXoJtDsuzjGBtDtfi5nQ=;
        b=gtsU0hJ7t47BJqCT+TsuyTz6I1srLV8OB66Go9XZyjhQQVZC0qFRXC4azX6D6AL23S
         afi4UahqTJ7wItryPSfhhZ93iclJqq5+2wk2HkYPbJXHPlHEMIQz3MmxsXUBmCRP/X12
         l9fGODnA+IbYNRSGItGpz7GDQjWa72bFs4Zf8EpwevK26EOzYvifJM8uus4zAyNm2Awt
         X8aOWSA9ltBQ82QewIO8QfSfUmfNQnWzvErxey5mAtnZS2fHnBhQQO/z25N/EEs4IUqR
         NljfklWsUdS4wko7fF0Kza0V3KNhRJ/+ZFrqGmTiQaQoy5HgmXMrP9vCmgDQS0aTwA/Z
         d8vw==
X-Gm-Message-State: APjAAAWBfoDhVpluK1jVFXXHEaV8mbQ2akFuuyOAS+QYQONED5bIDQqa
        yi9IL1ATlJdKYiUG18dvFGjk06y2MAwcdbe9KUOAtQ==
X-Google-Smtp-Source: APXvYqwxn8gi9d4Y7yeKhhhBKs3G3DMQuJJ8HdGF2Ye4GnVemP0+QYxC6GICLVsPw22G+e6/GlfU4MtK/Rv0dkTJCms=
X-Received: by 2002:adf:b746:: with SMTP id n6mr2388512wre.65.1575342223221;
 Mon, 02 Dec 2019 19:03:43 -0800 (PST)
MIME-Version: 1.0
References: <20191125132147.97111-1-anup.patel@wdc.com> <mhng-2aaba21d-2b4a-45aa-9c76-809cb5b61e6c@palmerdabbelt.mtv.corp.google.com>
In-Reply-To: <mhng-2aaba21d-2b4a-45aa-9c76-809cb5b61e6c@palmerdabbelt.mtv.corp.google.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 3 Dec 2019 08:33:33 +0530
Message-ID: <CAAhSdy3yduX3Yorc=tECOJHH82K_uy+a997Q1qJRccxEOVGKFQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] QEMU Virt Machine Kconfig option
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 5:02 AM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> On Mon, 25 Nov 2019 05:22:13 PST (-0800), Anup Patel wrote:
> > This patch series primarily adds QEMU Virt machine kconfig opiton and
> > does related RV32/RV64 defconfig updates.
> >
> > This series can be found in riscv_soc_virt_v1 branch at:
> > https//github.com/avpatel/linux.git
> >
> > Anup Patel (4):
> >   RISC-V: Add kconfig option for QEMU virt machine
> >   RISC-V: Enable QEMU virt machine support in defconfigs
> >   RISC-V: Select SYSCON Reboot and Poweroff for QEMU virt machine
> >   RISC-V: Select Goldfish RTC driver for QEMU virt machine
> >
> >  arch/riscv/Kconfig.socs           | 24 ++++++++++++++++++++++++
> >  arch/riscv/configs/defconfig      | 17 +++--------------
> >  arch/riscv/configs/rv32_defconfig | 18 +++---------------
> >  3 files changed, 30 insertions(+), 29 deletions(-)
>
> Thanks.
>
> LMK if you're going to spin a v2 with the updated commit message.

There are some conflicts for Linux-5.5-rcX. I will rebase this series and
also update commit message.

Regards,
Anup
