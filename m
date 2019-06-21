Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81081C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A772089E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfFUImj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 04:42:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39501 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfFUImi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 04:42:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so5708547wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 01:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=NCZe/wzhmqVTkfL4kbg/RhaDPy78lQA1X7HEK+EaBNc=;
        b=mU9C5f/cJg8IizAtcXgvrhMsbjnQZz1ifBtM09aCqcsa7vvraCoy8yAFPUvGyijUAg
         UIY4A4KbK9SFHdAi7ed8AavdZDjGc9SlYLlMxtuadRwK/oeO9GifoW9donCpIzR0VtZb
         pue1YeDZMrJWa9+Nccom2KIoAbIygOqql4iWYOc9V7jF4q3zZaKmXruamsXkff9LjlXa
         qlpK6wh0juYZFmUDTXcHv3M/zyH2ApVdHxFOPio1SPI1MSNGXGqJYH32dj26LJ2oCL0b
         7XaBRMHkuoVYD4xXWg8aW1hYDL+WjVPhjnTFVjgvpCB35e8ptVVh+03jrxolB2I6OrhI
         IM4w==
X-Gm-Message-State: APjAAAVg1fmanwGHsNvRN1Mg5STWNiDESc5RDg1OdeSrsSS7L7rRKO1D
        9z3OwPILeMPfbIPVeGUThwnBog==
X-Google-Smtp-Source: APXvYqxHByJaYhGLeLp7ST63EtIhJTeBSDbHrjOV2E/XCor6/o/FJQ21g0mLwcv3882Pfibb/UxTow==
X-Received: by 2002:adf:e841:: with SMTP id d1mr32311861wrn.204.1561106556746;
        Fri, 21 Jun 2019 01:42:36 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-89-176-127-31.net.upcbroadband.cz. [89.176.127.31])
        by smtp.gmail.com with ESMTPSA id c4sm1707922wrt.86.2019.06.21.01.42.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 01:42:36 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH RFC 1/5] x86: KVM: svm: don't pretend to advance RIP in case wrmsr_interception() results in #GP
In-Reply-To: <CALMp9eTZSWA-7SOHS=2xrMKaXv_imKpURHGcDpfgusF+JDXFMg@mail.gmail.com>
References: <20190620110240.25799-1-vkuznets@redhat.com> <20190620110240.25799-2-vkuznets@redhat.com> <CALMp9eTZSWA-7SOHS=2xrMKaXv_imKpURHGcDpfgusF+JDXFMg@mail.gmail.com>
Date:   Fri, 21 Jun 2019 10:42:35 +0200
Message-ID: <87r27nfhxg.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Mattson <jmattson@google.com> writes:

> On Thu, Jun 20, 2019 at 4:02 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> svm->next_rip is only used by skip_emulated_instruction() and in case
>> kvm_set_msr() fails we rightfully don't do that. Move svm->next_rip
>> advancement to 'else' branch to avoid creating false impression that
>> it's always advanced.
>>
>> By the way, rdmsr_interception() has it right already.
>
> I think I actually prefer the current placement, because this allows
> the code that's common to both kvm-amd.ko and kvm-intel.ko to be
> hoisted into the vendor-agnostic kvm module. Also, this hard-coded '2'
> should be going away, right?

This whole change goes away in PATCH5 (with hardcoded '+2'), I added
this patch just to make it clear that RIP advancement we're doing here
is only being used by kvm_skip_emulated_instruction() and
kvm_inject_gp() branch is not affected.

We can throw this patch away from the series.

-- 
Vitaly
