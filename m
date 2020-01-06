Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9077BC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A56C2081E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i1+dxrn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgAFUTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:19:24 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41081 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgAFUTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:19:24 -0500
Received: by mail-io1-f68.google.com with SMTP id c16so46391194ioo.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 12:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZB6+nZpdQdrQFOUezOO+7mxpT7FzTcRrUIFGcgCSmbk=;
        b=i1+dxrn9BwWzBAeJV6afkXOmypBNmAdOB+MN0+uPEwO4tqMBko7kiVkXUabAiq/ryY
         scWsv83FexYHtha29B/rSOy2G6vr01E7gtVoQV9iKwaqofCJYPXWTm0elmL6mtpLgTho
         lRpgbEn8HhvfNgnScOhVlIVNFFnXdJsfyixF2JNW4I9eRGti+9UHcwY0+2nLtiZFBhZq
         NCRVgS4qd+LFAYtEBLVQRHVqJFQP6kgf5nU4jQ5icMM0keUykv268+d69Qtb+UgpH4ur
         fY/YrpuXoruqx1aEjWp30pWNrcxTpzDDu6MMwnEm860W41k4TzD4Wc+e46dLoHWdcj9x
         vn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZB6+nZpdQdrQFOUezOO+7mxpT7FzTcRrUIFGcgCSmbk=;
        b=mKTI+bAobKJUKB1LoyCWkOwS16jCiRH4XhNGSWNmVZotinLM4UFD0dbZthROwpvqfj
         jW6k00avS2HZL7V8x7Rzk/vAO933VNCKly0v3xraFlavJhdf7aebOzWRI744TALys/eU
         hQns8JETi22uC7GDOxGlERqVd8nZFgwIKya7YgZx+saQXbj0eIa/Z37/x+cYMABe6zYr
         OP1Oeacr2Lqrvwuxz2Z3hZU9ZBPlE4/CD65TQNCvMCsPfGtYQFhNh+XDGKoREF9pwlnJ
         /L7Rkh86n/Slb/hk2bdVh5uMEuJjFLPd3gTrkE07qPH8tiNWkAWCPXxIIywFbsTAqvIT
         SAWw==
X-Gm-Message-State: APjAAAWn5lEEfu+DQ1TrF9KvDCciKUjhaCVOVGOlb8a6Z0d4/CwqMdY9
        HXEzwa9Z+S10rajVFWqmZI8FpQpsGkb8OB1tf1LScQ==
X-Google-Smtp-Source: APXvYqz1ADI5pUttsTRFE4tG04m0tcxRUNOV6z/qiW+UMBRbGaQW2wU9EW1eJF1Qghs9D9XaNiAgZu7XxW6hZ4ZQb9Y=
X-Received: by 2002:a02:cd3b:: with SMTP id h27mr80920656jaq.18.1578341963368;
 Mon, 06 Jan 2020 12:19:23 -0800 (PST)
MIME-Version: 1.0
References: <20191211204753.242298-1-pomonis@google.com> <20191211204753.242298-11-pomonis@google.com>
In-Reply-To: <20191211204753.242298-11-pomonis@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 6 Jan 2020 12:19:12 -0800
Message-ID: <CALMp9eT5HVhtCKOKaBxkaVUVs+uQ908Z2coM3n6j9aMU33=HGw@mail.gmail.com>
Subject: Re: [PATCH v2 10/13] KVM: x86: Protect memory accesses from
 Spectre-v1/L1TF attacks in x86.c
To:     Marios Pomonis <pomonis@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Finco <nifi@google.com>, Andrew Honig <ahonig@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 12:49 PM Marios Pomonis <pomonis@google.com> wrote:
>
> This fixes Spectre-v1/L1TF vulnerabilities in
> vmx_read_guest_seg_selector(), vmx_read_guest_seg_base(),
> vmx_read_guest_seg_limit() and vmx_read_guest_seg_ar().
> These functions contain index computations based on the
> (attacker-influenced) segment value.
>
> Fixes: commit 2fb92db1ec08 ("KVM: VMX: Cache vmcs segment fields")
>
> Signed-off-by: Nick Finco <nifi@google.com>
> Signed-off-by: Marios Pomonis <pomonis@google.com>
> Reviewed-by: Andrew Honig <ahonig@google.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Jim Mattson <jmattson@google.com>
