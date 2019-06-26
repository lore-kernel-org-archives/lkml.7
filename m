Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22C3C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A256721743
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfFZRld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 13:41:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39200 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFZRld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:41:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id x4so3719362wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 10:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=t2qwRs7koe0N7pYzHfarivbdbI697R0UkLvgOjEc6fg=;
        b=rNWScwCtIc3FS+PqLO6TGwiLFcIJtJxD+jaULsarqZ2w74dugcaLPDSdvP0+lTIGSU
         v33OiUzXZEsd7Wi7wY2sFZ53yOBP8sQLwJIgwPT+zjZ7+zHHQOgJzUBsi4Zov1dhpCjY
         r26KvGml+iAKaU3ZFtDya4VU+1P8nlBOR/UL383c5wAnm+1S+Po3A1OnTOJQulqRbgzh
         Z4HZhf9x8UAFJ9P2U1K5Sd0clH73ACAX0CV89X3ST6Wjo6NQolKtm6Qp4ADJ9L8too4k
         d2u41GcJ9V9RqpFJFFlkG+AO0PvdPJErgDhSwo55gzXuyvKHcMuII0tpdAkhwGFwut71
         wT6w==
X-Gm-Message-State: APjAAAU+MqkkgJ4CF90FYZrqRyZ8zCGtrNb/RXWR8yagCWa18FrCV1LX
        uE2NMWfJHkBn9mCZJyAhs+aRxFEiNuk=
X-Google-Smtp-Source: APXvYqwJ4Z4pdKRax8Z2pKF/BL7aG7XRGilbIpnO+wMYHg1EmrVhaIhK8YsHNXK6Nvcm7thSb6IuMg==
X-Received: by 2002:adf:ee91:: with SMTP id b17mr4595442wro.182.1561570891172;
        Wed, 26 Jun 2019 10:41:31 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 72sm24638446wrk.22.2019.06.26.10.41.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 10:41:30 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>, Nadav Amit <namit@vmware.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "kvm\@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH 6/9] KVM: x86: Provide paravirtualized flush_tlb_multi()
In-Reply-To: <CALCETrW2kudQ-nt7KFKRizNjBAzDVfLW7qQRJmkuigSmsYBFhg@mail.gmail.com>
References: <20190613064813.8102-1-namit@vmware.com> <20190613064813.8102-7-namit@vmware.com> <cb28f2b4-92f0-f075-648e-dddfdbdd2e3c@intel.com> <401C4384-98A1-4C27-8F71-4848F4B4A440@vmware.com> <CALCETrWcUWw8ep-n6RaOeojnL924xOM7g7eb9g=3DRwOHQAgnA@mail.gmail.com> <35755C67-E8EB-48C3-8343-BB9ABEB4E32C@vmware.com> <CALCETrUPKj1rRn1bKDYkwZ8cv1navBne72kTCtGHjnhTM0cOVw@mail.gmail.com> <A52332CE-80A2-4705-ABB0-3CDDB7AEC889@vmware.com> <CALCETrW2kudQ-nt7KFKRizNjBAzDVfLW7qQRJmkuigSmsYBFhg@mail.gmail.com>
Date:   Wed, 26 Jun 2019 19:41:29 +0200
Message-ID: <878stockhi.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:

> All this being said, do we currently have any system that supports
> PCID *and* remote flushes?  I guess KVM has some mechanism, but I'm
> not that familiar with its exact capabilities.  If I remember right,
> Hyper-V doesn't expose PCID yet.
>

It already does (and support it to certain extent), see

commit 617ab45c9a8900e64a78b43696c02598b8cad68b
Author: Vitaly Kuznetsov <vkuznets@redhat.com>
Date:   Wed Jan 24 11:36:29 2018 +0100

    x86/hyperv: Stop suppressing X86_FEATURE_PCID

-- 
Vitaly
