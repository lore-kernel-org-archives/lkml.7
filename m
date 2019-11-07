Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A54FC6194
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 00:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512CF217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 00:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="dPPfGekO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732292AbfKGABn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 19:01:43 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43129 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfKGABm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 19:01:42 -0500
Received: by mail-ot1-f67.google.com with SMTP id l14so385088oti.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 16:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6xfjgZ4C/EchKlv+V6UpiruJFKsW8K/Ar0hBhPPbJyo=;
        b=dPPfGekOsGWnPNe5+q/qIAAv1sillG9Ugyl9YtAXMbR7Xcba7vT5/QdhQPpOZjj6gy
         ggqB125Ht/4zzgNH7xVWpUqFmZbomgb5e54bIgPqVXMaEpRv40R+h9oDHoGmtR0sUTM/
         Cx1P83NOcdMJyZc+0GDN6jvA0n4dUCt2ji8PuR6ZEkBtHNa4ilYorBNmwrPa0XlbHumL
         /aM2dfKuZTLCt80QTBWHfc9lSx0M/xzerPBjvITZTcE/hzoZ81chvLz8JTzw0JMfihNf
         1rUA2sQStaWtDxI8DPepezCDW3HhnMgx5AU0p7Xo+qNWgsYeRDniVh0Ex7KrGNGKEF0O
         TXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6xfjgZ4C/EchKlv+V6UpiruJFKsW8K/Ar0hBhPPbJyo=;
        b=AuZ7H3cSv5CQ5XEaDb1aE+HhXPJd7QafbOleubbE2CL3S5LopqnqK4g+rEcLZz3xl0
         Bg/SOSiovC2kd/h/lOMC4U0cSL6XTImwyxOslQ3ycOFyPJvXKULqUW8N7Phz8Fq5ViHh
         WPEw/YsM/imxgvZ7C7vZWxsi8uOkcGKZk6Iv+3AeUxX7C6H8dGPy7n1a63yFGiPnRCZM
         XwjyB2ci4+A2dbFVspqHaI8tuTLhrEtqrO+Lo7vlDlx5pHET6PaJChOrIOPyPkyh1C8p
         IIWq6xr5Z58ldG3YZOPvQGbsFLJeznfvs9wnRKawNPEnjkxswb+yNS+/Cu4SYWeHIi0m
         D17g==
X-Gm-Message-State: APjAAAWig+Lw9VhHCqDxZiKokYXkoX2axnGEavXuGvaehF3z/1TALKgQ
        jNLkQeOHXlvUN/4fFsSVOo5/aJjUrbqbv5fEL3qpwQ==
X-Google-Smtp-Source: APXvYqz6YJLKIFRcB7Gy1I1pK2v5ojca51ttW+Urubn6MXnIhvG4gp1euFKiQwZ4YOmkONtMzgzLeZmxpUNDGGIiZaE=
X-Received: by 2002:a9d:2d89:: with SMTP id g9mr369121otb.126.1573084902039;
 Wed, 06 Nov 2019 16:01:42 -0800 (PST)
MIME-Version: 1.0
References: <20191106170727.14457-1-sean.j.christopherson@intel.com>
 <20191106170727.14457-2-sean.j.christopherson@intel.com> <CAPcyv4gJk2cXLdT2dZwCH2AssMVNxUfdx-bYYwJwy1LwFxOs0w@mail.gmail.com>
 <1cf71906-ba99-e637-650f-fc08ac4f3d5f@redhat.com> <CAPcyv4hMOxPDKAZtTvWKEMPBwE_kPrKPB_JxE2YfV5EKkKj_dQ@mail.gmail.com>
 <20191106233913.GC21617@linux.intel.com>
In-Reply-To: <20191106233913.GC21617@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 6 Nov 2019 16:01:31 -0800
Message-ID: <CAPcyv4jysxEu54XK2kUYnvTqUL7zf2fJvv7jWRR=P4Shy+3bOQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: MMU: Do not treat ZONE_DEVICE pages as being reserved
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, KVM list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adam Borowski <kilobyte@angband.pl>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 3:39 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Wed, Nov 06, 2019 at 03:20:11PM -0800, Dan Williams wrote:
> > After some more thought I'd feel more comfortable just collapsing the
> > ZONE_DEVICE case into the VM_IO/VM_PFNMAP case. I.e. with something
> > like this (untested) that just drops the reference immediately and let
> > kvm_is_reserved_pfn() do the right thing going forward.
>
> This will break the page fault flow, as it will allow the page to be
> whacked before KVM can ensure it will get proper notification from the
> mmu_notifier.  E.g. KVM would install the PFN in its secondary MMU after
> getting the invalidate notification for the PFN.

How do mmu notifiers get held off by page references and does that
machinery work with ZONE_DEVICE? Why is this not a concern for the
VM_IO and VM_PFNMAP case?
