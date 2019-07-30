Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC2BC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F47520882
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="I1JeO/u2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbfG3Hga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 03:36:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46762 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfG3Hg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:36:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so64539020wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 00:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6U2acd1QmQp/fq0L96aRRGzLE2S05j+iUMMl/7Ujgp4=;
        b=I1JeO/u2t/9GtL4gb/6m3g7NQxNda7RBoL3u/BA4m3wmjG5pt9vru1WU9kUlKHh+TC
         5B5w9WYYre+FTnHTNqUp1FeYn/NuopIyDJJ5jD22bCDNEtLOl2qp7mqD5yUp0iPxbHMs
         U5KnIhavW/n2QLqF37U2bM9CqL7CPSf7Blg3DxyVQwBTruspAU+/kTvscIiG1RojUOUT
         q/fACG+tK3bBrNQXzYUjfKHji27uEAeZE/AA1o7lA/5MlHRq1MtiF8EgSuog2xvJ3RE2
         0tUerzh5y9KoUC7nN7zl+rVjq7brxpYDqrP+GsPO9SR8uFrWI/SkZFF6FerhO2zo5j87
         dzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6U2acd1QmQp/fq0L96aRRGzLE2S05j+iUMMl/7Ujgp4=;
        b=Pfj0hRhbp35MoDWFsTD8H14FzAX+str55dHDdGOfxAPPcpiW3hP0uQrNnAB5vEMjJl
         DLBhdmHPrqxvDMHReynxVHCAP3XhV9EYLDATnaxRpSbDO2IkBH8GVCXAYQxeL80Ucpu1
         o+7AHWq805xIqF2F/ERD2j7a4aBYQU6JplLD7jS+x62RiO4ldCkmHY1yYrjaVreCDeFd
         BlCiPwyereaO9Jx89lS8ovG91ApP+5Vp3xiK41SCRFsIII2SeirOb0KLuhLnag7nLOfK
         bLdrCSMPbmD0ItNfm12shNZLmJVS2jSp31jMIbhnJnxy1eUFz66Pp3OQbSOmfzO5/Uh/
         dfIw==
X-Gm-Message-State: APjAAAWKK1zMB16F/WKZjjfaGHcofglDDzV3gydsJD68JTvZQ81/q6lJ
        L3EzSAakfbPt+AGCYPxWWaGrway/rRPDKnyb2Y4=
X-Google-Smtp-Source: APXvYqySD/VhLD/1gRxFJ7qx4IrEkz4AhGCFJYUHqM5n38YeZUjiLceMw/XbhrPAFunOMf8mFEW26/rfKEpjphPolrI=
X-Received: by 2002:a5d:6284:: with SMTP id k4mr93182866wru.179.1564472186392;
 Tue, 30 Jul 2019 00:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190729115544.17895-1-anup.patel@wdc.com> <mvm5znkau8u.fsf@suse.de>
In-Reply-To: <mvm5znkau8u.fsf@suse.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 30 Jul 2019 13:06:15 +0530
Message-ID: <CAAhSdy3+vkJkugqrDrw4tnPWRsPw0L8r_49pEWqrqxes69X2Pw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/16] KVM RISC-V Support
To:     Andreas Schwab <schwab@suse.de>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim K <rkrcmar@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 12:23 PM Andreas Schwab <schwab@suse.de> wrote:
>
> ERROR: "riscv_cs_get_mult_shift" [arch/riscv/kvm/kvm.ko] undefined!
> ERROR: "riscv_isa" [arch/riscv/kvm/kvm.ko] undefined!
> ERROR: "smp_send_reschedule" [arch/riscv/kvm/kvm.ko] undefined!
> ERROR: "riscv_timebase" [arch/riscv/kvm/kvm.ko] undefined!

Found the issue.

These symbols are not exported and you are building KVM RISC-V as module.

Thanks for reporting. We will fix it.

Regards,
Anup
