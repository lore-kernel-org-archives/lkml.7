Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9EFCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 05:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F3A20B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 05:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="t5XI80Bi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731086AbfJVFH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 01:07:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39710 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfJVFH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 01:07:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id r141so5188173wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 22:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bTTMrmciHM4aiFMZR2LK71art6dDZteKsZ9m8QnTfYE=;
        b=t5XI80Bi4Lrln9mq+PcmKnh/yO/hMUHXGheJlgPjZHmjiOAKjNpjlwjXrH4e/9yOUp
         mR8jmhWjv/5OpGM8yjQhMT8lwxbmAwBue+sy9/eMu5EVFXjYnAzl3zU2VUOWqfu32NZM
         Z3zKuEf4f89oQkuqGUuY3+NKXqsGn82fXWfMpOdyot1HwqClZ0rZbi6horJoccoHlqBr
         kwilw8JQ+36mVE/vxn2gYkr710UiwpoIXu4c7yr5Z6txLx1fUYfbJjV7PbNxFvpZlrFo
         UqUOOHNXqgUT5BX0UdU1JbK4lADmJtAa4wyL7NBU3sCdNhXQnJrx368cQvjh4NYcUPA4
         8zGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bTTMrmciHM4aiFMZR2LK71art6dDZteKsZ9m8QnTfYE=;
        b=E3YiCUoxJHunWFEVn1hLJmBnpsS+1mR6cB/KrqFnxC7OAXecRwhtxYHq//xAtinwMp
         f9ZE20FpJUhDvjYqv+TJeUvCc+Nj4YwVGFNQtgJmCn/25kKSCMrugFWC1uxnkwlT0vlA
         tqNtZu2wBNm9vPvCEX4hZhUWzrmX8fJXt4JBW0630zaO6+6hlwEJKf1ru1fT36cK2CQg
         tQ4SkAKBuOAiwEEW6qNgkUIgBsodinwc1jy8Yw6icX314ZpzPjcoVQhc+WPKYDPkiHIM
         YhCfRLXh6aDxv+pCaB8Cr1bUh6vYVnBbjm/ZNZFYHz8iFBFZl31gb6pdk0n+FFOhQKeT
         CmyA==
X-Gm-Message-State: APjAAAX8LCKV17uDqQTPJRfJpjSoiM+H92fVZOJHHjn2dqzyjF4w4No8
        btvldb2ZXTEtyYozXqNnYfEQZOHMLLYL8AoFrSD5OA==
X-Google-Smtp-Source: APXvYqxl6FUWzhNJmV/twRIMg5J5dk1jL54DHL5eRqSLGaUjuAJZJFHphqKMrxpAOmdnSQ0pZAWlWkDR4Yx7NICACVk=
X-Received: by 2002:a1c:9695:: with SMTP id y143mr1119738wmd.103.1571720874948;
 Mon, 21 Oct 2019 22:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191016160649.24622-1-anup.patel@wdc.com> <20191016160649.24622-21-anup.patel@wdc.com>
 <1d2e9514-235e-183e-b4fc-d3becc9ce471@redhat.com>
In-Reply-To: <1d2e9514-235e-183e-b4fc-d3becc9ce471@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 22 Oct 2019 10:37:43 +0530
Message-ID: <CAAhSdy33b=EcNnNP80dNqAEpSOErfXenNXHD0GhC4yYPB7L3Ow@mail.gmail.com>
Subject: Re: [PATCH v9 20/22] RISC-V: KVM: Fix race-condition in kvm_riscv_vcpu_sync_interrupts()
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Radim K <rkrcmar@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Graf <graf@amazon.com>,
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

On Mon, Oct 21, 2019 at 10:57 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 16/10/19 18:12, Anup Patel wrote:
> > +     /* Read current VSIP and VSIE CSRs */
> > +     vsip = csr_read(CSR_VSIP);
> > +     csr->vsie = csr_read(CSR_VSIE);
> > +
> > +     /* Sync-up VSIP.SSIP bit changes does by Guest */
> > +     if ((csr->vsip ^ vsip) & (1UL << IRQ_S_SOFT)) {
> > +             if (!test_and_set_bit(IRQ_S_SOFT, &v->irqs_pending_mask)) {
> > +                     if (vsip & (1UL << IRQ_S_SOFT))
> > +                             set_bit(IRQ_S_SOFT, &v->irqs_pending);
> > +                     else
> > +                             clear_bit(IRQ_S_SOFT, &v->irqs_pending);
> > +             }
>
> Looks good, but I wonder if this could just be "csr->vsip =
> csr_read(CSR_VSIP)", which will be fixed up by flush_interrupts on the
> next entry.

It's not just "csr->vsip = csr_read(CSR_VSIP" because "irqs_pending"
bitmap has to be in-sync with Guest updates to VSIP because WFI
trap-n-emulate will check for pending interrupts which in-turn checks
"irqs_pending" bitmap.

Regards,
Anup
