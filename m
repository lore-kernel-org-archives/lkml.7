Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C18BC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 263622089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="gbw6Cwke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbfG3LqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 07:46:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45785 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730893AbfG3LqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 07:46:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so65397755wre.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 04:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DSo219uBBQuUIUjoxpKujZtQ/5w8YP4pzpQJT3D8aBA=;
        b=gbw6CwkeXhENGj0Eco2ek5ibwxV16dRDV7am21QurDDO6eOhOkVzbupEo0vU5bjnX8
         wooptB/qSlORBPn6AJO9d6w6OTdp8aKbkrTjrp8IMloxRKPXN2yYh47vKeAN/CFaSZYc
         Wv4D9akzJgzNvlbW6kCYgSG5YfrJLKMHeK5qJ5Os6kkfd8HRUesS8DW3VJif/ZhFLgVa
         ISCTcC/JSf8tTK7eXzEfjoBsWfG2JmxjnSA0s37YubJ9mISX5km8dbVKEIjFQRlWhxxD
         c/GVRcN0F/txPzvFKgC/LRk0YOagBkFUvHIj1KabmrGucdZCwu0ckNAkGrLyj6NzYnMs
         9YXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DSo219uBBQuUIUjoxpKujZtQ/5w8YP4pzpQJT3D8aBA=;
        b=JAYwBEbxed7I8r+oXrFSrkR/R8U2HUudlb0cKcyCGIPLwpuNVc2FSrhNL6femQMmJC
         KaXnC1EhDg4Yh4ea5dBPykdYl0J8m15vCJ45vOhr9SVm8Cs0TnKPtT+MNdXgVrtO3xlh
         MkqapCvSkQiIhnRxysKV9nzleovCkExXeRepAPLvH64zp73vuxb2QD0aSGrHqxDkp4JF
         XQ7fZUAP9mju6AAXWGeIJ0dSfD5/inPB3gF2eKKl+f6K2MAZdPqFe93v6OPb4O//dfhF
         yvhuJYyVMZ8KnLceZCNtS45gtD6JqxQGLUINY6f8pFLGyi2isIsWNJNC2UVic8UBeDM0
         H0kg==
X-Gm-Message-State: APjAAAWCAmYwDYmKQ0jcuvS/9hptXTBGREr9aZcDpCvVoiqIqy0bB8zA
        vMJA5lPtW4qs4AC5AiAr+LHFMVDfdMtq5b3iawU=
X-Google-Smtp-Source: APXvYqxcNGyAMDSQUqXUF4ibEZV0Hg0QLhoWESRbxN2cYy12N9UTrjz1RoeAXOIYGCVQ4YlqG0W4pvPRidpxQg32B0Y=
X-Received: by 2002:a5d:6284:: with SMTP id k4mr94957352wru.179.1564487165402;
 Tue, 30 Jul 2019 04:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190729115544.17895-1-anup.patel@wdc.com> <20190729115544.17895-5-anup.patel@wdc.com>
 <ade614ae-fcfe-35f2-0519-1df71d035bcd@redhat.com> <2de10efc-56f8-ff47-ed69-7e471a099c80@redhat.com>
In-Reply-To: <2de10efc-56f8-ff47-ed69-7e471a099c80@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 30 Jul 2019 17:15:53 +0530
Message-ID: <CAAhSdy0OH9h-R=2NxhhPs6jmFPNgZVSwFtCjtJrf++htu82ifA@mail.gmail.com>
Subject: Re: [RFC PATCH 04/16] RISC-V: KVM: Implement VCPU create, init and
 destroy functions
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

On Tue, Jul 30, 2019 at 3:46 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 30/07/19 10:48, Paolo Bonzini wrote:
> > On 29/07/19 13:56, Anup Patel wrote:
> >> +    cntx->hstatus |= HSTATUS_SP2V;
> >> +    cntx->hstatus |= HSTATUS_SP2P;
> > IIUC, cntx->hstatus's SP2P bit contains the guest's sstatus.SPP bit?
>
> Nevermind, that was also a bit confused.  The guest's sstatus.SPP is in
> vsstatus.  The pseudocode for V-mode switch is
>
> SRET:
>   V = hstatus.SPV (1)
>   MODE = sstatus.SPP
>   hstatus.SPV = hstatus.SP2V
>   sstatus.SPP = hstatus.SP2P
>   hstatus.SP2V = 0
>   hstatus.SP2P = 0
>   ...
>
> trap:
>   hstatus.SP2V = hstatus.SPV
>   hstatus.SP2P = sstatus.SPP
>   hstatus.SPV = V (1)
>   sstatus.SPP = MODE
>   V = 0
>   MODE = 1
>

Yes, this kind of pseudo-code are not explicitly specified in the
RISC-V spec. The RISC-V formal model is supposed to cover
this kind of detailed HW state transition.

> so:
>
> 1) indeed we need SP2V=SPV=1 when entering guest mode
>
> 2) sstatus.SPP contains the guest mode
>
> 3) SP2P doesn't really matter for KVM since it never goes to VS-mode
> from an interrupt handler, so if my reasoning is correct I'd leave it
> clear, but I guess it's up to you whether to set it or not.

Yes, SP2P does not matter but we set it to 1 here so that from Guest
perspective it seems we were in S-mode previously.

Regards,
Anup
