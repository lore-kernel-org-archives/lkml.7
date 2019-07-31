Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1B7C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 23:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9732067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 23:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dM/JvIQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbfGaXpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 19:45:33 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41107 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfGaXpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 19:45:33 -0400
Received: by mail-io1-f68.google.com with SMTP id j5so136107244ioj.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 16:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rPPJInGn5mcKaK62eGkVbrjaFAcg+JQw+Axl27ql6vE=;
        b=dM/JvIQODfYw8czZ9IPfxhBOPNK/TztKjUSRlcmFQPeaLDr2O1SNPXVwau4KeZJIeD
         m/bhzguK5AX5MeKLhRXovtQNIW9REEXOeLXLxm7mRIpGAO3PklbLd4A8zSxNwSKP/Oqb
         Lhm5DoA2qGkIscJqEeP65qybIaVNiUktLQjTVPj5+adWFlh0MW5AmYXZd6drGu0JhoYA
         113AoBMq/pMH4EMo4QhQsxmDW+CdxvFkBrJDhUYOINFRik+krsBzJy/iI5M/4BdzOpln
         Pk5MH+LgIH7YpxuJjm+m31TqvEHErBQsaJ3pOMhJLsEusO3UOcla8NBnpiF024TczZay
         3Hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rPPJInGn5mcKaK62eGkVbrjaFAcg+JQw+Axl27ql6vE=;
        b=RsMh+4xe8kdiE4MnmcyIvzjWzMtMp9Ud+NYSgaAH5KvgOKs3/plKg08ZeNPflNSAU6
         wm5SybLxjUBwDV6teMY+hlsq5IEbQTEfinoRP0+FcO1Jq+pMGrnc4ZFf1YC9P20hWiox
         SY3e31yaUetTp4C7oSgkWOOIgC9SfCL2zvhca8fzCpTjROKTubJdqIr9/9T6MwSj3QWD
         NWC5CdABdh0vvh2L1W3baD/Y9t0Bhj0fcsMNABPR2ipdQOB8WHPNlG5ZJo+R6qfkqIpy
         d+SB+UXoyE4V9/sGuwyDHAoK4pQVUolMmkbVknfjrXfo+R0kHqGdNCzahw+DC4GDmRdu
         6VoQ==
X-Gm-Message-State: APjAAAVfG/2OVNVz/IE7LCW080Dvki9UilXDeXacnxb3fjy2rAAZMa+a
        ZnldlxMg1V20tQVXAnENM2rM758raYhaQKkq6ZVaDA==
X-Google-Smtp-Source: APXvYqxsAnlo0HnFzOoBpzX+/vkVOreIRE1vIVYBe7yxFQriMXMo/a7UaidTN0LxSPRocHjQy0k75hCc8NIXhMTb6Bk=
X-Received: by 2002:a5e:8508:: with SMTP id i8mr122215860ioj.108.1564616732306;
 Wed, 31 Jul 2019 16:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190620110240.25799-1-vkuznets@redhat.com> <20190620110240.25799-4-vkuznets@redhat.com>
 <CALMp9eQ85h58NMDh-yOYvHN6_2f2T-wu63f+yLnNbwuG+p3Uvw@mail.gmail.com>
 <87ftmm71p3.fsf@vitty.brq.redhat.com> <36a9f411-f90c-3ffa-9ee3-6ebee13a763f@redhat.com>
 <CALMp9eQLCEzfdNzdhPtCf3bD-5c6HrSvJqP7idyoo4Gf3i5O1w@mail.gmail.com> <20190731233731.GA2845@linux.intel.com>
In-Reply-To: <20190731233731.GA2845@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 31 Jul 2019 16:45:21 -0700
Message-ID: <CALMp9eRRqCLKAL4FoZVMk=fHfnrN7EnTVxR___soiHUdrHLAMQ@mail.gmail.com>
Subject: Re: [PATCH RFC 3/5] x86: KVM: svm: clear interrupt shadow on all
 paths in skip_emulated_instruction()
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 4:37 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:

> At a glance, the full emulator models behavior correctly, e.g. see
> toggle_interruptibility() and setters of ctxt->interruptibility.
>
> I'm pretty sure that leaves the EPT misconfig MMIO and APIC access EOI
> fast paths as the only (VMX) path that would incorrectly handle a
> MOV/POP SS.  Reading the guest's instruction stream to detect MOV/POP SS
> would defeat the whole "fast path" thing, not to mention both paths aren't
> exactly architecturally compliant in the first place.

The proposed patch clears the interrupt shadow in the VMCB on all
paths through svm's skip_emulated_instruction. If this happens at the
tail end of emulation, it doesn't matter if the full emulator does the
right thing.
