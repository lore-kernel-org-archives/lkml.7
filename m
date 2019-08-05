Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D27C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896F420657
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="fkloISZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfHEHMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 03:12:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34700 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfHEHMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 03:12:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so5974736wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 00:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RbR9NwuvYbRC7roIhZ22yTnxvDklbtSaOkHnRd59pwA=;
        b=fkloISZ+Sy0hPMWNbFKzEh/r7BhtZqP4GA9lIr/AitoV+f7H+Fa7NB134TAcewDaga
         io6DQRB5IDIoD4C8l3IdKPdVydc3xBbfQTQKNK4pvGQOtEOV7NPS9kLb/ycbLIYQ4ixj
         S+BY0o8SGrF7PrawJsDGnZJA1XjoraSGN7GwBv63aKNlTAXgwRHD16mxFdujm2jDq5nE
         pnxdBIoxB7WYlD0IEyZQsOy0CB7mD1+BhBc4wxNsSVMAYDlxkDIhcx21gpviKA6DUGzT
         DGcGMFNArITF0bDZIC0/1AZ5lXMhi51gYZ8uNmpGsK/l2c/0V6EZBuSAK5qpuKlGM5Sl
         4C7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RbR9NwuvYbRC7roIhZ22yTnxvDklbtSaOkHnRd59pwA=;
        b=aXNER62rzEDLLUgt2vJc7hPL5cwAODYlMjixlQCKft/+l5cWEUZ8bRMU24v/agQWNX
         p/8fIWhmVb2f0UjNEg4FFX4sOq++PvOHQXXOpUf+rEQ4/NVOh6+R4WiU1iaYvG27j8s2
         3Gn6H1lS4hj6cBDQDrFbAlEGAMuxf7IWLQfaiwHNondzhPo/uXoqN0wL/DPyx2c/4nL0
         S7/r0pjAK3qko8wNDWBZhtS5YoG4NpEKZprM1bkVCNWLzBA18TsZKNz/nRHZuNcJq1qC
         LDlB0iz9zZQeg/8If2MiOkwDQpUFpGG7f0l4eZidB86gEYo6go/jNfg+QB1QoTdOvB2L
         dOEg==
X-Gm-Message-State: APjAAAWu+d76pdiD7IUWnnYHHCbMQe6wuznY9pCAvYrDit+zD4Ky8Itm
        lklRbHU96D8QRw0F9CBfzePFgjQV5N9Lmr+LsBK+LA==
X-Google-Smtp-Source: APXvYqxEZZ7R692/L4v5lwezCh25EnrYJqzhpkuE8O4sIMjCiDsF/mYrMWwoKnFFt8t13omA8PT+Bmmhx3XjiZllRlI=
X-Received: by 2002:a1c:cfc5:: with SMTP id f188mr15608477wmg.24.1564989135533;
 Mon, 05 Aug 2019 00:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190802074620.115029-1-anup.patel@wdc.com> <20190802074620.115029-11-anup.patel@wdc.com>
 <5b966171-4d11-237d-5a43-dc881efb7d0a@redhat.com>
In-Reply-To: <5b966171-4d11-237d-5a43-dc881efb7d0a@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 5 Aug 2019 12:42:03 +0530
Message-ID: <CAAhSdy0BVqagYTTnaG2hwsxxM51ZZ2QpJbZtQ21v__8UaXCOWA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/19] RISC-V: KVM: Handle WFI exits for VCPU
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

On Fri, Aug 2, 2019 at 2:33 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 02/08/19 09:47, Anup Patel wrote:
> > +             if (!kvm_riscv_vcpu_has_interrupt(vcpu)) {
>
> This can be kvm_arch_vcpu_runnable instead, since kvm_vcpu_block will
> check it anyway before sleeping.

I think we can skip this check here because kvm_vcpu_block() is
checking it anyway. Agree ??

Regards,
Anup
