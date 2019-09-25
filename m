Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F89AC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 13:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9DF21D7C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 13:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406360AbfIYNRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 09:17:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406332AbfIYNRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 09:17:42 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D25689AC6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 13:17:42 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id v18so2366227wro.16
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 06:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=KFMcKSB28vicD7mJB9VGf2zDH2JPjeINiiBxo90LMbQ=;
        b=OquYN/Fj6UiJB+O6KRkytQ6lem/N4OLBjdIDgSHelOv4gV62Wdd5rzRKf+0n0YUI58
         pWv0bpK+dygvGxUgCP1IV6IsiJAXKR1mTI5AvhYbzfTRSrrIDxOLCqgNP9ImGRrIQlXA
         v5p+n65FZzEjLg21o5wVtHDPnpFVGYYVQs2i+A3BhOFgvOccQBGmMZLwINa9Sg/cRAHl
         GAxqJj1uNP/aNMEsXlLs9e7IdSSZwO4bIsl7+FTvr9cr8HC0zFWuBmDngERiVlNhrLeW
         /aszBxu3tXeIsiN37OmZb2PQcWQmYLsrZRh/OGayA7CqW9WEHI8oIiX7LFy6TfNb8KMQ
         kb4w==
X-Gm-Message-State: APjAAAUvTXRcKGs629hAijZxhAJ6o+7gK6g7LQDU9J1ZiMLYa/3XHfsf
        6TMlsiS4OyCrItxSOz82Vp1Mquvs7PIGJo4TwDzJ8Kj8fDTh6cuXiUyX7dtVy8+tKATcGkp8htP
        yZMtKOtttOK1vMUPKYcIDRd7U
X-Received: by 2002:a1c:a851:: with SMTP id r78mr7765925wme.166.1569417460905;
        Wed, 25 Sep 2019 06:17:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyDxoF4IGLsMV5Fm6FzZNwokbfobF8/BfLCX5YBkz5lgs3B9lT1iwzQ3B2G/0XzN9ZNkujVRw==
X-Received: by 2002:a1c:a851:: with SMTP id r78mr7765898wme.166.1569417460667;
        Wed, 25 Sep 2019 06:17:40 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id l10sm7860611wrh.20.2019.09.25.06.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 06:17:39 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "kvm\@vger.kernel.org" <kvm@vger.kernel.org>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
Subject: RE: [PATCH] KVM: vmx: fix a build warning in hv_enable_direct_tlbflush() on i386
In-Reply-To: <KL1P15301MB0261653DB1FE73A1EB885E2D92870@KL1P15301MB0261.APCP153.PROD.OUTLOOK.COM>
References: <20190925085304.24104-1-vkuznets@redhat.com> <KL1P15301MB0261653DB1FE73A1EB885E2D92870@KL1P15301MB0261.APCP153.PROD.OUTLOOK.COM>
Date:   Wed, 25 Sep 2019 15:17:39 +0200
Message-ID: <87y2yc7bws.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tianyu Lan <Tianyu.Lan@microsoft.com> writes:

> There is another warning in the report.
>
> arch/x86/kvm/vmx/vmx.c: In function 'hv_enable_direct_tlbflush':
> arch/x86/kvm/vmx/vmx.c:507:20: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>   evmcs->hv_vm_id = (u64)vcpu->kvm;
>                     ^
> The following change can fix it.
> -       evmcs->hv_vm_id = (u64)vcpu->kvm;
> +       evmcs->hv_vm_id = (unsigned long)vcpu->kvm;
>         evmcs->hv_enlightenments_control.nested_flush_hypercall = 1;
>

Missed that one (and I have to admit I haven't compiled my patch on i386
:-). Will send v2 with this included, thanks!

-- 
Vitaly
