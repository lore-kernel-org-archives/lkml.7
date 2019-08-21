Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99784C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6510022DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tZOH3QR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbfHUTpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:45:42 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43734 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbfHUTpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:45:42 -0400
Received: by mail-io1-f66.google.com with SMTP id 18so7001205ioe.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 12:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YpMEj+NWj00I7foN2WrqzBLVN+AGOJvo2s3dxJ45E5M=;
        b=tZOH3QR0fZUbdQ7kAWqBMyzJ2J3tx6QAJAHPkFTCCf0h58w7Dz7jtudO3qgo5ubKTd
         cR6Cilk2rkU0EVZL3KEy3pTR3RcwCh2HqolL29QYRG+tvsmuJK1kC5+B0M4+xFvb/Ojf
         JpiyoCEkA5QbA+AoFHAZZqtwJi4sptLMCzj9Eb38L2lMV7bxR3H+LaYXuCz3mOBBG2hM
         NOkMcwJHbajBdp5NX56FcZof+blQlpJ+Jt6amvRVr8YMUwUmB2FbvZDQulpQVDQuWaMS
         kL9B1UwBEeAF3Garanxfhoq87nBlqpevdagqPd4r2mY68SBMuM3UtztvhgVu49pBzx0E
         LofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YpMEj+NWj00I7foN2WrqzBLVN+AGOJvo2s3dxJ45E5M=;
        b=AVtpP+rj4YnO9QndTHz8F2QBonD/4XwhS77tJaTUT5mKg03Fv3dUXlCkJkGR2/UL+C
         IcX7I76k4e4Pn623g3PLd7xvug/3jO8GKnU+GcxB46F0Zus2AcG5VvaSq3jwZDkIHA8y
         nyX/aDwtM/MdbHG4AjmbLRpBO7tUJridYfmNjTRuHktCftR3jnQVF4E3FgUSDwxLXYgK
         dgVE0814uFQfEPXs9R4Z+ZfAUU4PAAvm5Ar8DiMyGNlAo+fvkM5RttBYQBQtWJjUgkd7
         k+v3xWg7FYkjnA9vQem1FH0WdbyRfam/PnNIYNwyD3t+GDDvObV3dEEhpFXBdBND7jP5
         Lbxg==
X-Gm-Message-State: APjAAAW59KwCE7C6jyPx9ptGkbASXVMIYU2zPXGXZJJHpLsGaFfzGK/Z
        KaYroZ087bLqj4zC4BBTChCmxhqFOoMiYqWy4rsPeA==
X-Google-Smtp-Source: APXvYqxFfK6hxk1+ostWDfVFMf1N3zdsSZ97J/GlbNiJ9ZeNnr3BcrpU1baCdKWNQ7dpGMfOkIos5oOpIs7zZN38vSE=
X-Received: by 2002:a02:a405:: with SMTP id c5mr11796233jal.54.1566416740913;
 Wed, 21 Aug 2019 12:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <1566376002-17121-1-git-send-email-pbonzini@redhat.com> <1566376002-17121-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566376002-17121-2-git-send-email-pbonzini@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 21 Aug 2019 12:45:29 -0700
Message-ID: <CALMp9eQoHLngzb5v9aqxpJ39OszXLjdm+sWbHdeOk2JaPofv5Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] KVM: x86: fix reporting of AMD speculation bug CPUID leaf
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, jmattson@redhat.com,
        Eduardo Habkost <ehabkost@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 1:27 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The AMD_* bits have to be set from the vendor-independent
> feature and bug flags, because KVM_GET_SUPPORTED_CPUID does not care
> about the vendor and they should be set on Intel processors as well.
> On top of this, SSBD, STIBP and AMD_SSB_NO bit were not set, and
> VIRT_SSBD does not have to be added manually because it is a
> cpufeature that comes directly from the host's CPUID bit.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
