Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144EAC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CAC20645
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHr8RLIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbfETLkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:40:00 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33757 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730708AbfETLkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:40:00 -0400
Received: by mail-oi1-f193.google.com with SMTP id q186so3027635oia.0;
        Mon, 20 May 2019 04:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=44L6cEnx4TRmAaeTvxDONBxhfaF21/upIkBICkfjKkY=;
        b=bHr8RLIt91biK7iigtLZcjVNFcOwKVPjNeVI687TtYDUi1JjPrExUi2+P1Iptq7Mg0
         USm/LztXpGWXUV4PC2RaEmSaCYVp4U3pp/NeoALvMa5kclANhUrVr+IzDLz9BePad5b9
         c+5FLsLiFS7mDKdYMy/eMFMdjO9mvVLz7nUBVVe4c5GR365pfRgggCbLQHAkOIlmKhmS
         XZVzhKsEaqKj7EV7q9Pge7toXiv2fzB9XNWwdg+wXOjNjKp+ilNlQyebFF1bDq/etThh
         afoQ+hO2ayyXNIRk1yXgFPqcu0Fs3BEjwBJgyMCK75Uda5CAviqRWcsV4lPKsKL36vbc
         CT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=44L6cEnx4TRmAaeTvxDONBxhfaF21/upIkBICkfjKkY=;
        b=IdnumE8hybWlnIio/Oco2H1wX/ziiO2B2D+O3XWYLXmEFOCAbb1Zu4h3NLwu7sB5FE
         40FxJZZcLFhubSqjrpARWqbi6b+fYTfrGKyDfBiwJkXg/72R0QOI8ZqutG3c4NzettUW
         vXtmoBHkzOb4YsWgo97yNOuN2f7EJkZ8D/o+0wAtTzmo1M9fXrg7O+Hzkc3ci3nfYP9J
         y+8z7lq+3oQhrAmcEPYRnW4JqWzax0j/U9GHIDX69uptfBplcasFcazyIs/cSMBx/cOb
         3wA8OqKY/6j6wfcVE84GMjGLCHqzovruSdhTGPtdqyK2zJg+CpM5EqBWyGIKznyG+sfp
         JhlA==
X-Gm-Message-State: APjAAAWvNITLSiG4cSjkI0NAu0ohYF4MfObNo2QMesGlaOw2+H0qVcDG
        M3Hdry7T/CjdaJno3ul/5IcEm4GmlehmTS0YOuoB9A==
X-Google-Smtp-Source: APXvYqx9PctHUEASD2bRyy2WbrCEnqfZjZV/8lGUIXbMnRESp8XKe1Ed9sqZ2qK3AQY5MChbfRJX3p8qOfKT/uYooO8=
X-Received: by 2002:aca:da07:: with SMTP id r7mr23708730oig.5.1558352399589;
 Mon, 20 May 2019 04:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <1558082990-7822-1-git-send-email-wanpengli@tencent.com>
 <1558082990-7822-2-git-send-email-wanpengli@tencent.com> <e96eecd6-7095-58b3-32a7-2cfde2f2ebcc@redhat.com>
In-Reply-To: <e96eecd6-7095-58b3-32a7-2cfde2f2ebcc@redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Mon, 20 May 2019 19:39:50 +0800
Message-ID: <CANRm+Cze1YGtsXibqmRvL=XNHNETH3ZcpH4HEy-7qwE4qPnA9Q@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/4] KVM: X86: Emulate MSR_IA32_MISC_ENABLE MWAIT bit
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Liran Alon <liran.alon@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2019 at 18:34, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 17/05/19 10:49, Wanpeng Li wrote:
> > MSR IA32_MSIC_ENABLE bit 18, according to SDM:
> >
> > | When this bit is set to 0, the MONITOR feature flag is not set (CPUID.01H:ECX[bit 3] = 0).
> > | This indicates that MONITOR/MWAIT are not supported.
> > |
> > | Software attempts to execute MONITOR/MWAIT will cause #UD when this bit is 0.
> > |
> > | When this bit is set to 1 (default), MONITOR/MWAIT are supported (CPUID.01H:ECX[bit 3] = 1).
> >
> > The CPUID.01H:ECX[bit 3] ought to mirror the value of the MSR bit,
> > CPUID.01H:ECX[bit 3] is a better guard than kvm_mwait_in_guest().
> > kvm_mwait_in_guest() affects the behavior of MONITOR/MWAIT, not its
> > guest visibility.
> >
> > This patch implements toggling of the CPUID bit based on guest writes
> > to the MSR.
>
> Won't this disable mwait after migration, unless IA32_MISC_ENABLE is set
> correctly by firmware or userspace?  I think you need to hide this

Agreed.

> behind KVM_CAP_DISABLE_QUIRKS.  (Also, what is the reason for this
> change in general besides making behavior closer to real hardware?)

Just making behavior closer to real hardware. :)

Regards,
Wanpeng Li
