Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF8DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65722067D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3BQGwCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfKSLg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:36:28 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45561 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfKSLg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:36:28 -0500
Received: by mail-ot1-f67.google.com with SMTP id r24so17534271otk.12;
        Tue, 19 Nov 2019 03:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O4bgGlnr9YGraqcGqRTVWqBe6uwtLwxkzJh4SzEwyFo=;
        b=n3BQGwCJfycuAMFvnZDcr3Hu3ukTzjDamexrrbqiaODw+rVgtGLjTiBrkTLbLXr0KV
         02hdg8VUZMlaPMJrBouxnpN0dVeRNlEHMPrZ/OHqurwG5weCsFK5b5m9e4c9YzOZ7qxL
         bN8OK6UnhNljuWzW7COd3E0FoGk0V0e71CiTVtJxUFRuKcPuCbT7RRdeq9fp1Ib4/B3o
         ESZzMIQS7diJdAp2RfpLOSD1sZHZ7u9LXOVjZNTZIejYhrTu+n+aLBBoyqw5ITuJrG2n
         cF+1wL7tzqwg5jkwagS/VTIA100j2yEGKE4zFlVWCQKUoZfQpcg36LFoG/Tp0CPe2M52
         xqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O4bgGlnr9YGraqcGqRTVWqBe6uwtLwxkzJh4SzEwyFo=;
        b=WXD/n8gmwfRdgK4xN05UmOLtcYRAn38VX1VFibb74RzA1yVVmEuhN72jFBcLC80eBH
         OLKHwrvI2rUkrz6MDKgdwxss7uQEDupPRJimBDeaIZwv7Mm5F4BuqhwwlCBJ/4IjWQTa
         Oa+n/W+LJYGLp9+Ef6SK3vRx1eErW/+I3gAfi0Lzke79/vGIVkUQ75Nl0owZ0m+wu6ah
         n86FpVESy8YMv3oHd71L69i2i7INMXiB6hY8N9EVShint0pUSmAXi2osbVE3Gk6P0u0u
         /t9bkiZ3WYFTP2dIQM+JOnQwpl065EmLnPKSGEBAbpRjYl8erZ+bEXtz66wkx0FxSxZk
         Ma6g==
X-Gm-Message-State: APjAAAWB8KuctPycfzGuaLo7OFof+5a/MtjRDjF1TGzfVksrDTyhOKu8
        GBdEQcE4gzHHhyUY+LXLYnHyqQyrAGMT4KbNU4I=
X-Google-Smtp-Source: APXvYqyDpAorsfYdBpBR7EzrIYuwOiOE/+kKmQo8NuX1/d/ejR8FXEbCO3p7ECFkoT2VHLhSYf+JnIGOFaAWsURHIeA=
X-Received: by 2002:a05:6830:4ae:: with SMTP id l14mr3403148otd.185.1574163387705;
 Tue, 19 Nov 2019 03:36:27 -0800 (PST)
MIME-Version: 1.0
References: <20191111172012.28356-1-joao.m.martins@oracle.com> <20191111172012.28356-3-joao.m.martins@oracle.com>
In-Reply-To: <20191111172012.28356-3-joao.m.martins@oracle.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Tue, 19 Nov 2019 19:36:19 +0800
Message-ID: <CANRm+CyrbiJ068zLRH8ZMttqjnEG38qb1W1SMND+H-D=8N8tVw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] KVM: VMX: Do not change PID.NDST when loading a
 blocked vCPU
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     kvm <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Liran Alon <liran.alon@oracle.com>,
        Jag Raman <jag.raman@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Nov 2019 at 01:23, Joao Martins <joao.m.martins@oracle.com> wrote:
>
> While vCPU is blocked (in kvm_vcpu_block()), it may be preempted which
> will cause vmx_vcpu_pi_put() to set PID.SN.  If later the vCPU will be

How can this happen? See the prepare_to_swait_exlusive() in
kvm_vcpu_block(), the task will be set in TASK_INTERRUPTIBLE state,
kvm_sched_out will set vcpu->preempted to true iff current->state ==
TASK_RUNNING.

    Wanpeng
