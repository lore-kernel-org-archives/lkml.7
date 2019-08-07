Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9319FC19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6B72086D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="qpivKekg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfHGGzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 02:55:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35973 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728492AbfHGGzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 02:55:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so90253965wrs.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 23:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jCoErHiPNvk13SPfCcqBT6IJoVO0gBMNBIOMvhTHKu4=;
        b=qpivKekgVXwq+eNUFaaCyUsDmoXANXQ23A0g0oz148wDbeLPXCDJoHF/oqUYv4UXMe
         0Qyl1XUojpebWB5JVei1yVMMKylhDlmpCUqGKaTNLroELwyxawmAOY3QfQg/YB2/R7yx
         HY9b93Nx5E4Vnig6g5s/bpQZ15IyFDRJi6l0rJjrH8mp/RikSPmlOqIL3byNr5ma94Nt
         SnxR+ehNzzlt2riihmWQBn7DQrKxBEDDzkxP9z/JPv1m2nLkMamUtSTD5VTmDkfQ8iJH
         EkB6Mm1YFtAazfks1fuZT3aLcs2r0CLZHyZmVJFHuq+tGggHTvvkFany5maEqYXv+GGK
         4VKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jCoErHiPNvk13SPfCcqBT6IJoVO0gBMNBIOMvhTHKu4=;
        b=nob68upvPnGzuCwddh+Y3Qmg/itBUqWmwKHfLgMl5jkDqJaJrYdGde90Pljpq6iNC2
         M+933kKMa50CCNWvfL4fm7AKolmITmpDcjGfTDhbkkWho+eqRS0EaIcQS4wPjE6AJ4xe
         qbkc1Wx7jfeMeOcDXpmD6IEwigt/e78vQjn8clGgrDObNeZd6hnzEIDCImsGUuPckfbr
         ErBSzLfUMHHHCmVX9y5UFM5Sw7j6Lk68TvtQC7mexbcnpRKRhN38hO/qmHV4AG+G6JsT
         tJCJxmEc4KAzaou5cLGJ3/9MYFLwxbmwhn2tj1pqj0R798n4n289MOby7THjC2x41eIn
         11+A==
X-Gm-Message-State: APjAAAVwrGIzr5d08QPKFGxKrlpdp0y0/moykC0aurEHgsFv4+Mwjsbs
        bTEux0SPdzi4BOkjyTY+pQ4O2EzyUNt/vr2OW5NQrw==
X-Google-Smtp-Source: APXvYqz5vYJETic8geIvrMG3/Y/wuhAA21T5TNvWpMpv6MeyTEPLTyBjCy9rs3cydr4EEcB3g10arnXVM9KB3ROF83M=
X-Received: by 2002:adf:b1cb:: with SMTP id r11mr8284877wra.328.1565160946973;
 Tue, 06 Aug 2019 23:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190803042723.7163-1-atish.patra@wdc.com> <20190803042723.7163-3-atish.patra@wdc.com>
 <20190807065119.GA7825@infradead.org>
In-Reply-To: <20190807065119.GA7825@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 7 Aug 2019 12:25:35 +0530
Message-ID: <CAAhSdy2eP+z28XJmP9O6YPftQ=Rg6AwdSrVwu83igrfvYSRKhw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] RISC-V: Add riscv_isa reprensenting ISA features
 common across CPUs
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Alan Kao <alankao@andestech.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anup Patel <anup.patel@wdc.com>,
        Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 12:21 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Aug 02, 2019 at 09:27:21PM -0700, Atish Patra wrote:
> > From: Anup Patel <anup.patel@wdc.com>
> >
> > This patch adds riscv_isa integer to represent ISA features common
> > across all CPUs. The riscv_isa is not same as elf_hwcap because
> > elf_hwcap will only have ISA features relevant for user-space apps
> > whereas riscv_isa will have ISA features relevant to both kernel
> > and user-space apps.
> >
> > One of the use case is KVM hypervisor where riscv_isa will be used
> > to do following operations:
>
> Please add this to the kvm series.  Right now this is just dead code.

Sure, I will include this patch in KVM series.

Regards,
Anup
