Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAE9C31E44
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 00:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E02A208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 00:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRm2KOro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405651AbfFLAo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 20:44:27 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38353 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405015AbfFLAo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 20:44:27 -0400
Received: by mail-ot1-f67.google.com with SMTP id d17so13770871oth.5;
        Tue, 11 Jun 2019 17:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rom31ac+oTIgk+nM7YCEF4uKjf6HAUZ2gRCm9n6eGlE=;
        b=RRm2KOrokA19xU1MyfdHQKveGTVmuPjyOyDOgBJ0901rg3gcSIUAcmwKrOI9N4Gsqz
         Ei5EK/eyaR6hwp/2V9DpGKAAWcQzNqJaKd+73ohRdtn8qe/sCseGGRK25Puvv8Ln+KlR
         C3pEf7YqRJMCgAfBY4ca4OcpMJhSISuwmKL010tvq1LfCoClSh7A7g2FPTW6/GZo4nxk
         TUied5oyVr/YWeZ0485ASZ7FDT2kb9BjmLgHE1JqY+59xn3++E4n9BtXZ5WWcYxhDoh1
         OlJEix/bCHEAOn2TRTuxZaXHi8M+mWLXdcNhQKU54XwJrcEma1q1MnGd24oZ+Sf04tkh
         GzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rom31ac+oTIgk+nM7YCEF4uKjf6HAUZ2gRCm9n6eGlE=;
        b=R5uNhtC4Z4kGtloerr/zJnk1+3lDfzfQIGHVMRNmIvWSHNv/L9ZQVF4cqN1PzzAjCB
         A56V3p69e5uz5yMhnTSajwa6x55ZCMSsFiay26yGW8Rzx90nh2XJRpBYcij2E9E56NUH
         fO49wKsYQcBclKdQErCOQq4XkfKItyCZNhLFQqPU1SXoTRbFPtKiypLDgXyF0oDp8ceF
         JLcrleu3Lx447pF4qXgS5MkMaoUZYP+Poo4zqOh0f8Ah8Ff4p2CNkHoe6v1CAk0Qube+
         aGbgybsVrBTejKjckGRRjs3nbsIxm7vWBhLh0xuHiKgcEpkMJ6DFfFNG0WOEVXT3Yu2e
         Mwkg==
X-Gm-Message-State: APjAAAU02vaJuPz+MjOsFK/0G3uTktbHKcn6IvWku26Ge3vd9QOftAA5
        brcbSUudPWsbRvE4FVHYX7vmxOJuoN1niPZl2PQ6jg==
X-Google-Smtp-Source: APXvYqxCTelBtBy8c7ZzcF6pLAiYq933Kz+WQV+xqodYVKyK1hqOCvJY+Cl0TGO/rUc8CCP9lZlqQCjpY2RLdGCuUak=
X-Received: by 2002:a9d:2c47:: with SMTP id f65mr37530306otb.185.1560300266463;
 Tue, 11 Jun 2019 17:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <1560255429-7105-1-git-send-email-wanpengli@tencent.com>
 <1560255429-7105-2-git-send-email-wanpengli@tencent.com> <20190611203919.GB7520@amt.cnet>
In-Reply-To: <20190611203919.GB7520@amt.cnet>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Wed, 12 Jun 2019 08:45:10 +0800
Message-ID: <CANRm+CxX4__=p8BJ_Dd6GbKrgEpQH733sN_FATYrD2jNRayXaA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] KVM: LAPIC: Make lapic timer unpinned when timer
 is injected by pi
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2019 at 04:39, Marcelo Tosatti <mtosatti@redhat.com> wrote:
>
> On Tue, Jun 11, 2019 at 08:17:06PM +0800, Wanpeng Li wrote:
> > From: Wanpeng Li <wanpengli@tencent.com>
> >
> > Make lapic timer unpinned when timer is injected by posted-interrupt,
> > the emulated timer can be offload to the housekeeping cpus.
> >
> > The host admin should fine tuned, e.g. dedicated instances scenario
> > w/ nohz_full cover the pCPUs which vCPUs resident, several pCPUs
> > surplus for housekeeping, disable mwait/hlt/pause vmexits to occupy
> > the pCPUs, fortunately preemption timer is disabled after mwait is
> > exposed to guest which makes emulated timer offload can be possible.
>
> Li,
>
> Nice!
>
> I think you can drop the HRTIMER_MODE_ABS_PINNED and
> instead have
>
> void kvm_set_pending_timer(struct kvm_vcpu *vcpu)
> {
>         kvm_make_request(KVM_REQ_PENDING_TIMER, vcpu);
>         kvm_vcpu_kick(vcpu);
> }
>
> As an alternative to commit 61abdbe0bcc2b32745ab4479cc550f4c1f518ee2
> (as a first patch in your series).
>
> This will make the logic simpler (and timer migration, for
> nonhousekeeping case, ensures timer is migrated).

Good point. :)

>
> Also, should make this work for non housekeeping case as well.
> (But that can be done later).

The timer fire may cause other vCPUs vmexits for non housekeeping
case(after migrating timers fail during vCPU is scheduled to run in a
different pCPU). Could you explain more?

Regards,
Wanpeng Li
