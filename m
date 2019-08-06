Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF74FC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 03:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C4C20C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 03:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="xQaMHCEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbfHFDTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 23:19:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34026 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbfHFDTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 23:19:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id w9so7929147wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 20:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dr2+cEWOTjWIrHgq1rAPpBc6r9tZtYF1YbUnLR69BFg=;
        b=xQaMHCEu94MSWV0KnK1zA0WkUuR9+C2JoA7OyFGL1bMhbTfgWoKYiPiBLsiLmW+h+x
         MQ3B6t0N0TyWSy9h9rZc8F+4VTFAIH8Iedrf8KilAY2c5AOdX2tC2CndcOeVjxSy2GHO
         GI93PGu9zITG/U5rrHWGkkA5Ju5ktIJiHKkSvIGs+vOJ9Kez1Xb0dI8QvVhhWkfzaKsV
         tMP55LDR3YYdlt9K21sGMwHzYF9O1rH+IegheKtwbw9tlS2hUgPhoge/HJIJWt3xMgRz
         uA7D4HcLjXGGPwdp50RKYHh/RJ0kRwQ0JvqWO80/m5fi1DQlNlA09FUD+/020u8Gvf4D
         8o6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dr2+cEWOTjWIrHgq1rAPpBc6r9tZtYF1YbUnLR69BFg=;
        b=gd5s/zkNj3YzeDdWdU+tTcQR+DmXmsj+9JdvB0gD5IAqQOEwoqXGzzAo3PXABjwYeq
         teG0iHCq6iajbonOtcM59Y4UXuja+3G3e/YaJkbQYjfwFiZ/VJuq/uiXJZqz7AABKiTq
         StP1UoursbpYR8gtdloMz2uxgdOVC/CLS++ZpIjN0Vc6+nZib7B3G8OAZjtvWUOTMnUe
         X6S2A8aEgOlJ/cOwOi0BPBB/dbHz3mv2SEaMFuiPIRKR+OLQlflf/VXiF88hB0mcEiK9
         Dx8NlHaOgew0q7j7qh5ApGctfBjR6/9aRVMGMwJwK74a9SFpVAATdiZVUBrCv0w0Q0xS
         oM3g==
X-Gm-Message-State: APjAAAXso7VVs0f0hkbU5/Y+VobNgTFJ+ZiX7f8zH2lxSNielNEqrRnw
        nn9nL2tjw1NqQGbaPUluPstcVu634sYrrc9bjqeFPQ==
X-Google-Smtp-Source: APXvYqwH6qC9nSAJAWBGGxZ0uXvKgHP/raIkzQCYLK0pRSGDcTtZMMyScdsr3bxWn1y3xiVpXqFzA7f5nHQEnBJZ3yw=
X-Received: by 2002:a05:600c:254b:: with SMTP id e11mr1313747wma.171.1565061575887;
 Mon, 05 Aug 2019 20:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190805134201.2814-1-anup.patel@wdc.com> <20190805134201.2814-12-anup.patel@wdc.com>
 <21bdde39-8d33-6aae-e729-476ce11406a3@redhat.com>
In-Reply-To: <21bdde39-8d33-6aae-e729-476ce11406a3@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 6 Aug 2019 08:49:24 +0530
Message-ID: <CAAhSdy03G-8S0y7kg96PzC-4npdEFv+WCCuBvoCbEt9244kDOg@mail.gmail.com>
Subject: Re: [PATCH v3 11/19] RISC-V: KVM: Implement VMID allocator
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
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

On Mon, Aug 5, 2019 at 9:33 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 05/08/19 15:43, Anup Patel wrote:
> > +     spin_lock(&vmid_lock);
> > +
> > +     /*
> > +      * We need to re-check the vmid_version here to ensure that if
> > +      * another vcpu already allocated a valid vmid for this vm.
> > +      */
> > +     if (!kvm_riscv_stage2_vmid_ver_changed(vmid)) {
> > +             spin_unlock(&vmid_lock);
> > +             return;
> > +     }
> > +
> > +     /* First user of a new VMID version? */
> > +     if (unlikely(vmid_next == 0)) {
> > +             WRITE_ONCE(vmid_version, READ_ONCE(vmid_version) + 1);
> > +             vmid_next = 1;
> > +
> > +             /*
> > +              * On SMP, we know no other CPUs can use this CPU's or
> > +              * each other's VMID after forced exit returns since the
> > +              * vmid_lock blocks them from re-entry to the guest.
> > +              */
> > +             spin_unlock(&vmid_lock);
> > +             kvm_flush_remote_tlbs(vcpu->kvm);
> > +             spin_lock(&vmid_lock);
>
> This comment is not true anymore, so this "if" should become a "while".

Sure, I will update in v4.

Regards,
Anup
