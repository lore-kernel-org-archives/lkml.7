Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EB3C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D800621925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhQBWrx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKLBSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:18:21 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39005 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfKLBSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:18:21 -0500
Received: by mail-ot1-f68.google.com with SMTP id e17so12931848otk.6;
        Mon, 11 Nov 2019 17:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3lBuSLniBfxOtbZPc5uBPKwf2C9wf9/68vgFfge/XIw=;
        b=WhQBWrx94wCGYhMrvqnfuqQ37he3o2NG/qpAkS0ZBzKwFCtEdURmWzVXyJVyTJLnXB
         kUbIPnwa67FsXTobd6wvczudo2cOpa+ukmWMeslnh9Eo/QwnalaF3SjYqnnoe5UFoMbQ
         sErB1GxroWw4ZcM8HzQ8dugQdtBKpD61mdo7rAYDhD0okeC0dQxOn2w6nLBkD8C46SMK
         9SjanOPjxmLvivuJh83AjC9RzrwLl8+RngtUYZXS6PSnCb4DY7ePOLv4aAsVlTsC+siQ
         4lBYnBQAj1zyV0PMldgVM4D8ab+YEHQCKHdvB+ZvBV7MZ+9+4ORUciFU9EdSuVQGASHR
         Y63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3lBuSLniBfxOtbZPc5uBPKwf2C9wf9/68vgFfge/XIw=;
        b=UV6SednGSkY32eaPd1bwz28YzRUkJ2L//wZPL7im+Bm7SE+qWiX2zlXQyedoEPnX8P
         cymmjavmY2CF5VQ1pLGHtg684qp+CmqWohBVdnM6L2AU8FLirCNJJBfofZSeXy6wr5QR
         9Is7zETUbJTVmiXgGVstglubTpHtoN4lqDNdxEY1HXAlxtMN6qTH824RWCWL5P13gIT1
         nkVwAfqJKgh4rL6DS97GwNa4nc6O9d7RD2fMBlTgnHe8H9TI5oLCWH1IuPWTdH8dRwaS
         tGCxsNKc7kWdF0J9JVC9EUf17w9SfR99kSQ0AGcihrNPT630Y8teuVzzb7xKjOxGWOvk
         IlwA==
X-Gm-Message-State: APjAAAVFbA3ILWAgIXHdlvXMWZYYP+6+aOaxre5+Ry7UJm/h00lfrC//
        wey6Eg1s31hb+88yXTPiJEkRI89wdCgoO5+YB/k=
X-Google-Smtp-Source: APXvYqzs9jLymC/LGhXlFA2x2mI3e+pqq6h3FIftSS7u8rOxKwRI4UGUYb3QWmAyqw1Ka0WTgzXQm87m6FkzHlom0Zk=
X-Received: by 2002:a9d:b83:: with SMTP id 3mr22791896oth.56.1573521500347;
 Mon, 11 Nov 2019 17:18:20 -0800 (PST)
MIME-Version: 1.0
References: <1573283135-5502-1-git-send-email-wanpengli@tencent.com> <87mud2sgsz.fsf@vitty.brq.redhat.com>
In-Reply-To: <87mud2sgsz.fsf@vitty.brq.redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Tue, 12 Nov 2019 09:18:11 +0800
Message-ID: <CANRm+CyzwArrMokQHBOr1FDYmXS=8z1+hnbKnXAjoFvpBe67HA@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: X86: Single target IPI fastpath
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2019 at 21:06, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Wanpeng Li <kernellwp@gmail.com> writes:
>
> > +
> >  static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
> >  {
> >       struct vcpu_vmx *vmx = to_vmx(vcpu);
> > @@ -6615,6 +6645,12 @@ static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
> >                                 | (1 << VCPU_EXREG_CR3));
> >       vcpu->arch.regs_dirty = 0;
> >
> > +     vmx->exit_reason = vmx->fail ? 0xdead : vmcs_read32(VM_EXIT_REASON);
> > +     vcpu->fast_vmexit = false;
> > +     if (!is_guest_mode(vcpu) &&
> > +             vmx->exit_reason == EXIT_REASON_MSR_WRITE)
> > +             vcpu->fast_vmexit = handle_ipi_fastpath(vcpu);
>
> I have to admit this looks too much to me :-( Yes, I see the benefits of
> taking a shortcut (by actualy penalizing all other MSR writes) but the
> question I have is: where do we stop?

In our iaas environment observation, ICR and TSCDEADLINE are the main
MSR write vmexits.

Before patch:
tscdeadline_immed 3900
tscdeadline 5413

After patch:
tscdeadline_immed 3912
tscdeadline 5427

So the penalize can be tolerated.

>
> Also, this 'shortcut' creates an imbalance in tracing: you don't go down
> to kvm_emulate_wrmsr() so handle_ipi_fastpath() should probably gain a
> tracepoint.

Agreed.

>
> Looking at 'fast_vmexit' name makes me think this is something
> generic. Is this so? Maybe we can create some sort of an infrastructure
> for fast vmexit handling and make it easy to hook things up to it?

Maybe an indirect jump? But I can have a try.

    Wanpeng
