Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23582C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 18:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7452086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 18:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kjvql2Fd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfHPST6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 14:19:58 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33901 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbfHPST6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 14:19:58 -0400
Received: by mail-io1-f67.google.com with SMTP id s21so8027659ioa.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 11:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fnuMsmujra29dp1FTSHBcRawQgyoBfthqZjlSsqr0ro=;
        b=kjvql2Fd+K3tNtaX3xqbcP60tjRZd3ve9Avkm5DscmGcY4B4h+AO6NZ4n5M0JxHbK/
         blGJ2jE7epeuYd18BqhU59gcABGrhJDbrTPms2fF72gauL7f11noPHGQRxopt1TlZlES
         jORwP7E1AFDebFCbl8y51+bg56Yt9ONkL0brycIKPoYl1s9AG/Ja8FlXOi7nKXKLTyjm
         860oRbL2N0xnYPErgs8HaRwoQrjr+1JFGQZEnTE1lRY/elPjcV+vrSTx7a74X+eBO87t
         Q5uV+5Je5OCbdijJd6gTQ8VnRk3BSWSIGKLwW8rGO4PLsNAXVxu+5UTHVsIv7XLXiItA
         DS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fnuMsmujra29dp1FTSHBcRawQgyoBfthqZjlSsqr0ro=;
        b=bcARWWXESLOxcTOhTJRCj0OYInkIq7wpGmug7QwNDC2uFWqdOU/g+WZzNbthm16S5E
         1ezTFG4L8queEYb6kBxX60cF6YZBxRyUM31YzLiFbLXI+EAyXGQcU/iaSRqw7JuCQdET
         +RRDpn2xx0O+bZjagsSEAXYe8nzYJOVxQ/1AT2d6hZEKjoR7DByte62me1xKMCfEAIex
         3cIOzXcjD+2AaebvcKbt8X34oR0CN30lEWaFmlwXU3mfl9q8J+i6IHluxfZvLa/4NKO1
         X1+fDKaVtEHh8skGaSzQAcMTpmbKQiIuPmurPrDM2/cTqYzx10STIEMVHcVeObakNgzM
         Un0w==
X-Gm-Message-State: APjAAAU3WZPKri/7ZflzyFcyWu+hsIwv8nJgrgHpk1hXPUx9f9oOPKDI
        o5TNQ2OEjh7/4Ps5aOulMzKQ6ohmhk4QbN6b5246vg==
X-Google-Smtp-Source: APXvYqwfU734wkK0YpcYpc0AOVf/v9+g+Q5CSYSz6+OfVjVVRrlUOQOiqK9kLJGsftekpgUa5W1sAkAr6zNKZZBB29o=
X-Received: by 2002:a05:6638:348:: with SMTP id x8mr12561075jap.31.1565979597300;
 Fri, 16 Aug 2019 11:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190814070403.6588-1-weijiang.yang@intel.com>
 <20190814070403.6588-6-weijiang.yang@intel.com> <87a7cbapdw.fsf@vitty.brq.redhat.com>
 <20190815134329.GA11449@local-michael-cet-test> <CALMp9eTGXDDfVspFwFyEhagg9sdnqZqzSQhDksT0bkKzVNGSqw@mail.gmail.com>
 <20190815163844.GD27076@linux.intel.com> <20190816133130.GA14380@local-michael-cet-test.sh.intel.com>
In-Reply-To: <20190816133130.GA14380@local-michael-cet-test.sh.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 16 Aug 2019 11:19:46 -0700
Message-ID: <CALMp9eRDhbxkFNqY-+GOMtfg+guafdKcCNq1OJt9UgnyFVvSGw@mail.gmail.com>
Subject: Re: [PATCH RESEND v4 5/9] KVM: VMX: Add init/set/get functions for SPP
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        yu.c.zhang@intel.com, alazar@bitdefender.com,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 6:29 AM Yang Weijiang <weijiang.yang@intel.com> wrote:

> Thanks Jim and Sean! Could we add a new flag in kvm to identify if nested VM is on
> or off? That would make things easier. When VMLAUNCH is trapped,
> set the flag, if VMXOFF is trapped, clear the flag.

KVM_GET_NESTED_STATE has the requested information. If
data.vmx.vmxon_pa is anything other than -1, then the vCPU is in VMX
operation. If (flags & KVM_STATE_NESTED_GUEST_MODE), then L2 is
active.
