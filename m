Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076ABC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36FB206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q2Q5ZZvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfGaU2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:28:05 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45645 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729730AbfGaU2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:28:05 -0400
Received: by mail-io1-f67.google.com with SMTP id g20so139215987ioc.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 13:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dBGsm49OysEg7bHxsXfAQevchwfTyjC8ZOrR2juUMrM=;
        b=Q2Q5ZZvLyygWDWivclFZ/bbeT+uEMirhfkYAS8VsgPhwm33/Jc50fxvztwqBGotkl4
         Z77nFFONeALg1wxjQFQEPl5UoFIbBWWFs4S9nWN1EOgNVML9wAHPIIZQibmOIIzwDJz3
         if2AqAe6gOov1+C6pHUgExQbnR6eZzQ3t9F1GhfgnVBios2EmHYkB3loA3VHMkVMcBYK
         db7fMEI7Srk5UcuHSJku7GmxCP4WnpXaqwUJfvXX2eOWE7En4qRQS569NYYC20Z5nscq
         qV+0lUKrc8OxaEadG5SqiqKehkqy837x0fj+4KGHGek8q/RibYkZ32XYlvloXV18PUvY
         6Rfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dBGsm49OysEg7bHxsXfAQevchwfTyjC8ZOrR2juUMrM=;
        b=iv8H36eDQdkii+9fZMHMiuaCxdAA8joE7ExxOMOHSlMBiF7KPfFMlOjIaqjiDru+Mk
         rXG3CI5z1957TCFqpm9Hzaa88II0z71Oe/28l+yrM7xFbVXMyCc5Pb8lk41/1z7HVs/b
         VsUnbP/TQ4WY2/lk21gXLmt/9MT/lTDhgg9Kk1iofnEgo7fhofqzWP8dlhbmslEj8plX
         5s3Ncam5cnHChyZxWHw73MrXPAoOPIA2mIzcI1rIASiZtBuubChXS1Ph8QimLPErf1TS
         ndO/WkEVaM0YuPyC8k/37/bNyAv4fzJ9cTl8k6W4+iudP3d1DyIuUG6i4ucPX8eWXGVk
         RWqA==
X-Gm-Message-State: APjAAAUKwWk/quQghznMElewQ6msEKWsNQv9643GGkspd1ScQpozZPWX
        1KhUYAt5Kli5jq/kF9XRSPJ6Ka5x0oHJCyUMrxQV/w==
X-Google-Smtp-Source: APXvYqyOzq7qMPN4kDm5eOtE9EWegyQb/wzIOUIkgNtV+zq8BKZKflp19YlrudQqhSU6vBVMkwR59UO5rIWIwtPEaWs=
X-Received: by 2002:a6b:6310:: with SMTP id p16mr241134iog.118.1564604884032;
 Wed, 31 Jul 2019 13:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190620110240.25799-1-vkuznets@redhat.com> <20190620110240.25799-4-vkuznets@redhat.com>
 <CALMp9eQ85h58NMDh-yOYvHN6_2f2T-wu63f+yLnNbwuG+p3Uvw@mail.gmail.com>
 <87ftmm71p3.fsf@vitty.brq.redhat.com> <36a9f411-f90c-3ffa-9ee3-6ebee13a763f@redhat.com>
In-Reply-To: <36a9f411-f90c-3ffa-9ee3-6ebee13a763f@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 31 Jul 2019 13:27:53 -0700
Message-ID: <CALMp9eQLCEzfdNzdhPtCf3bD-5c6HrSvJqP7idyoo4Gf3i5O1w@mail.gmail.com>
Subject: Re: [PATCH RFC 3/5] x86: KVM: svm: clear interrupt shadow on all
 paths in skip_emulated_instruction()
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 9:37 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 31/07/19 15:50, Vitaly Kuznetsov wrote:
> > Jim Mattson <jmattson@google.com> writes:
> >
> >> On Thu, Jun 20, 2019 at 4:02 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >>>
> >>> Regardless of the way how we skip instruction, interrupt shadow needs to be
> >>> cleared.
> >>
> >> This change is definitely an improvement, but the existing code seems
> >> to assume that we never call skip_emulated_instruction on a
> >> POP-SS/MOV-to-SS/STI. Is that enforced anywhere?
> >
> > (before I send v1 of the series) I looked at the current code and I
> > don't think it is enforced, however, VMX version does the same and
> > honestly I can't think of a situation when we would be doing 'skip' for
> > such an instruction.... and there's nothing we can easily enforce from
> > skip_emulated_instruction() as we have no idea what the instruction
> > is...

Can't we still coerce kvm into emulating any instruction by leveraging
a stale ITLB entry? The 'emulator' kvm-unit-test did this before the
KVM forced emulation prefix was introduced, but I haven't checked to
see if the original (admittedly fragile) approach still works. Also,
for POP-SS, you could always force emulation by mapping the %rsp
address beyond guest physical memory. The hypervisor would then have
to emulate the instruction to provide bus-error semantics.

> I agree, I think a comment is worthwhile but we can live with the
> limitation.

I think we can live with the limitation, but I'd really prefer to see
a KVM exit with KVM_INTERNAL_ERROR_EMULATION for an instruction that
kvm doesn't emulate properly. That seems better than just a comment
that the virtual CPU doesn't behave as architected. (I realize that I
am probably in the minority here.)
