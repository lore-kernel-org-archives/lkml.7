Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4B2C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B842089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="rtURJ5tj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbfG3LEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 07:04:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55589 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfG3LEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 07:04:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so56723737wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 04:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kAaSPn1SAnhMdouNiZFncd+kh2nGtT7o+fO0/xriDJM=;
        b=rtURJ5tjTGQezYchXptus1tZePK5IushptflcrP+I4zOEDOzawXa8lEWlpLTyABP05
         WcvP42levCh9WFweBkXwjLV1O5gjaYCtAwo+LxmXtdams5440uB9Au+0IOqlvgvCQDox
         0QOqGc7cZaSYRFIthov7WGk9xFRrfQ0yCDdK0rjX6zdeViKjkIRWrKXe9a22hTtEjF5w
         KGjWactDJtFahKEJAaqTgK/W8UYIa3JZ9O0X+MmpSKu+T2/MtMpStwlLkpTtXNhqkvZn
         rOUJC9iwH8FJ0XRoZsS1uEXPEwUTIwGTrq2+SSYaj9QV4vsq0oNdAjo25MqtWEk3+RUF
         80Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kAaSPn1SAnhMdouNiZFncd+kh2nGtT7o+fO0/xriDJM=;
        b=txfgu3ivM+2XWo2K5baRkW2lS5sAkOdHajDJVJ52oD5182tLUb35ngsd/BpdycmxV5
         XaXUafRcjtLt5mpWPHED2NISgb0J4K0yI0Dx5vu2kkd0P9EETDJhxzu0K1MtzkMJN0RN
         PW4w76E2J57HRYltnwyty8lAmwEwaHH2NvDpLp50hgbEATSHdaN+L++d4SrX+FQ/m77G
         cmY6k9InmFzHMxEN31/+W+7FFm2wOWTrwe7XlVpadFvyarp4hUZq5ZNHjo+5AAfnNwJd
         qY032+qFt+8FEWv23MnkFdx4XY86a5XWb56JeXUxHybxt1wQYKxE63RhJCU6jXgpyf8l
         BZUw==
X-Gm-Message-State: APjAAAXRw0V+Ka8e14sREMIDKefWfE96hZS5tLvIwkqYkm8qZ4CX4Ta0
        v86lIhWaFqzmAtcrErileX9pub7LpW/nBwJ5gzU=
X-Google-Smtp-Source: APXvYqyCdoUNtlHs7orkEBhS8EG9A8IbKL4dk2VepkFVzYAN9ZWH2nTWL3pZtJ3WiTvF6eb5BbRHk5ldhvDUkb7rXyU=
X-Received: by 2002:a05:600c:254b:: with SMTP id e11mr97733084wma.171.1564484646738;
 Tue, 30 Jul 2019 04:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190729115544.17895-1-anup.patel@wdc.com> <20190729115544.17895-4-anup.patel@wdc.com>
 <d1157450-258b-91c1-72cb-867c96f929d8@redhat.com>
In-Reply-To: <d1157450-258b-91c1-72cb-867c96f929d8@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 30 Jul 2019 16:33:55 +0530
Message-ID: <CAAhSdy3n5DBKZ-_Vq39wYvbQ5iLYvdB2gXctkh+NuhynWzQJzQ@mail.gmail.com>
Subject: Re: [RFC PATCH 03/16] RISC-V: Add initial skeletal KVM support
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

On Tue, Jul 30, 2019 at 2:55 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 29/07/19 13:56, Anup Patel wrote:
> > +void kvm_riscv_halt_guest(struct kvm *kvm)
> > +{
> > +     int i;
> > +     struct kvm_vcpu *vcpu;
> > +
> > +     kvm_for_each_vcpu(i, vcpu, kvm)
> > +             vcpu->arch.pause = true;
> > +     kvm_make_all_cpus_request(kvm, KVM_REQ_SLEEP);
> > +}
> > +
> > +void kvm_riscv_resume_guest(struct kvm *kvm)
> > +{
> > +     int i;
> > +     struct kvm_vcpu *vcpu;
> > +
> > +     kvm_for_each_vcpu(i, vcpu, kvm) {
> > +             vcpu->arch.pause = false;
> > +             swake_up_one(kvm_arch_vcpu_wq(vcpu));
> > +     }
>
> Are these unused?  (Perhaps I'm just blind :))

Not used as of now.

The intention was to have APIs for freezing/unfreezing Guest
which can be used to do some work which is atomic from
Guest perspective.

I will remove it and add it back when required.

Regards,
Anup
