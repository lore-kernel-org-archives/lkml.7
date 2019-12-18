Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE3AC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0482465E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vh54jrbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfLRTi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:38:56 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34071 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfLRTiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:38:55 -0500
Received: by mail-io1-f66.google.com with SMTP id z193so3243312iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 11:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wQW9QdLYlN06sOdAVJaom6yjE9EzAuBpW13d3wxDdbs=;
        b=vh54jrbXr+r+lI4hsqpZhEbUrs02QVjOMq943tuCNLPDFd04S24SvHCh56TQZlbk/c
         A33hRJ7yBlL8/lIQdqY6CS6VMSfizjJ5IRzmJmAePBqnRn/LP8qXy8weSy3VsqFr8PEI
         CFxfpzvpbINZEgw6gK2Fvodm7w183RLO5Pj0UKZBB9RMgkMJ3FG5Vvc5nPwYQGtcnHN/
         W7+t64Iodxrwk++bf/tPCGyVhyqu1i3BTehegsKOdQ+DOFbM4Q0ggoQC88mSOGxxjmgM
         SWEha7dgHzJHFw3oJfVrmY9HzqhxWP0Z715vO1JmT1WFoQTB9rbsyLv4ttuiq1+jRjbw
         x/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wQW9QdLYlN06sOdAVJaom6yjE9EzAuBpW13d3wxDdbs=;
        b=HTWEj6BFD/6A2VtlT4MINU0q0PgokUXnqRoCBacKTX5kUV24x89zXu+1okteZHhFuA
         zPKzqd/MMe7uwgS3QPMMNHNoyfkaKWq25haklOHNUoUEaqdizdcBNfDgU2nG6i7h/GGE
         l8dW9xs8bvsqeGiBJtN54lwel2SjZXcC3aURd6GkU6CEKu21rDyqk5paD2VaCuIYjVqi
         AbrrAx1Jdc3ovZA3tSyDsGGZ8/PalW5IwhRYzQB9zK7HN3jQk5oRO8y3Ak+OCbZu7oKB
         8g34B4Eli9sZvfYUucedhw4EXgcLyzHX43oSybcUAfsaP3bjq9fUf3j6A9n80IYQ80oW
         9Ueg==
X-Gm-Message-State: APjAAAVUPmRW2GWw7rJvZTOb/WXs3sAe4NdjoRN73nYrljDgIFbDRZ6K
        KLggUpdNFj478eLFzImT1kI5bRpS4X9qek5Q2L+vUA==
X-Google-Smtp-Source: APXvYqzfsE8wwYFLUgK5vmDSI7g6h8kRB88v7iIIqSttpf6NImvY1/yY2CvGltz4bp3OTqvM74VZauQJIwvSiMEwfnw=
X-Received: by 2002:a5e:924c:: with SMTP id z12mr3017670iop.296.1576697935001;
 Wed, 18 Dec 2019 11:38:55 -0800 (PST)
MIME-Version: 1.0
References: <20191218174255.30773-1-sean.j.christopherson@intel.com>
In-Reply-To: <20191218174255.30773-1-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 18 Dec 2019 11:38:43 -0800
Message-ID: <CALMp9eR-ssCUT_6oZntZ=-5SEN7Y8q-HnraKW=WDHuAn9gYZfQ@mail.gmail.com>
Subject: Re: [RFC PATCH] KVM: x86: Disallow KVM_SET_CPUID{2} if the vCPU is in
 guest mode
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 9:42 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Reject KVM_SET_CPUID{2} with -EBUSY if the vCPU is in guest mode (L2) to
> avoid complications and potentially undesirable KVM behavior.  Allowing
> userspace to change a guest's capabilities while L2 is active would at
> best result in unexpected behavior in the guest (L1 or L2), and at worst
> induce bad KVM behavior by breaking fundamental assumptions regarding
> transitions between L0, L1 and L2.

This seems a bit contrived. As long as we're breaking the ABI, can we
disallow changes to CPUID once the vCPU has been powered on?
