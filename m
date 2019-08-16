Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF9EC41514
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F882171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bR6jRalC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfHPVpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 17:45:52 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41883 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbfHPVpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 17:45:51 -0400
Received: by mail-io1-f65.google.com with SMTP id j5so9127688ioj.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 14:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OJfTLw9HSdNJm60I6uHAdDZzXWuRnU4z9y6bRN6cjWc=;
        b=bR6jRalCIevq0ABoPuEl+Eq5L3NPtBnWeWiPN6gDyoSRG9W3Oug49waSn0b2wcOuqE
         mLn5q9cZWGTUD2uCOQsX/3YyybikGIdtBpKTFbQSl6WODe6Qj5V8LQxMDhl2J8/8Mlqe
         PB+MIDgCC2Cb10JGUeb55QghgaT4OQeE3CiTjNfW+aHvh88Vb0u/01ioxETMCcUETfhM
         pUY0CDbvV1ZrmexMFsrb1Ua5cm7yg5FHv+xdNqj2Kk5nMw4AghSrmNQthLlw2jB9mdgT
         B7k+ODKNuu+0SAP5EIxWAl1wFjzVkoqlDnPYldXHEhU/yDFA9uAFuFKiZiaDpYwuxElg
         OBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJfTLw9HSdNJm60I6uHAdDZzXWuRnU4z9y6bRN6cjWc=;
        b=Kkfbzf1NZeUsmCK9md7GTW5rnaescLXYxQoKJ2ORY17+qISIxDsyL4VnaF+CIAUrBj
         v47K9plu02oi8n4odbfuoTv66moefCam85vrOCywW83HHtRkmfxO6DJFY/e8QfV+LSnf
         YMzIwxYuZa9eYLc/ZAbymtiVYKEwHWUrSlrIYRBHoKZtApRUn04MDfkn3vQib3bfKOy9
         chOjgHtK3onVhDLtuStCJdgVMPqWuAn9kCwtlTdxqubycqsHUkUlRr4dK4whkIrONSL7
         b51lWLwGto/9Vkuck4AaOrZQ4Od1UU4cQxzzjN7gpz4cvQwzQmzTA9VxacEVohhixlN6
         MHpA==
X-Gm-Message-State: APjAAAVOMTfy8CgcABdHCJtPuPx2giNUrhh1vH9NkcRrtY73YLJRULcZ
        0YdBJfFcSI+rBLjQGalHr1uiOw7e/BYWtcKJcr81YA==
X-Google-Smtp-Source: APXvYqxPtkxRLjKQu3ETL2kWtt1SS8e+n/w7xSU/d4dfUkR3+vCZ9D/nhCKQcpgFlNue3llsyg8JXJW8rPcBEHgWmno=
X-Received: by 2002:a02:a405:: with SMTP id c5mr13413575jal.54.1565991950591;
 Fri, 16 Aug 2019 14:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <1565854883-27019-1-git-send-email-pbonzini@redhat.com> <1565854883-27019-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1565854883-27019-2-git-send-email-pbonzini@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 16 Aug 2019 14:45:39 -0700
Message-ID: <CALMp9eQcRbMjQ_=jQ=qaYmh1Lavc3PYvm4Qcf3zY+N8j3zZe-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: x86: fix reporting of AMD speculation bug CPUID leaf
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 12:41 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The AMD_* bits have to be set from the vendor-independent
> feature and bug flags, because KVM_GET_SUPPORTED_CPUID does not care
> about the vendor and they should be set on Intel processors as well.
> On top of this, SSBD, STIBP and AMD_SSB_NO bit were not set, and
> VIRT_SSBD does not have to be added manually because it is a
> cpufeature that comes directly from the host's CPUID bit.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

On AMD systems, aren't AMD_SSBD, AMD_STIBP, and AMD_SSB_NO set by
inheritance from the host:

/* cpuid 0x80000008.ebx */
const u32 kvm_cpuid_8000_0008_ebx_x86_features =
        F(WBNOINVD) | F(AMD_IBPB) | F(AMD_IBRS) | F(AMD_SSBD) | F(VIRT_SSBD) |
        F(AMD_SSB_NO) | F(AMD_STIBP) | F(AMD_STIBP_ALWAYS_ON);

I am curious why the cross-vendor settings go only one way. For
example, you set AMD_STIBP on Intel processors that have STIBP, but
you do not set INTEL_STIBP on AMD processors that have STIBP?
Similarly, you set AMD_SSB_NO for Intel processors that are immune to
SSB, but you do not set IA32_ARCH_CAPABILITIES.SSB_NO for AMD
processors that are immune to SSB?

Perhaps there is another patch coming for reporting Intel bits on AMD?
