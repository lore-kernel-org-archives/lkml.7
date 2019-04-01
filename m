Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E9BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3D720883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfDAKl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:41:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35181 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfDAKlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:41:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id y197so10783121wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 03:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=CIkPZ4hE+jyUzNonViu5/h2dRfSbj83iTiTZgWvTnBA=;
        b=kr36ozrnDzffmocpii+eG2SQo1YvL8m/jLALZSFxPx88JKlrZqvxq9YCWfRDcr6sib
         JWcY+GY6D/VptqBWnrkkmWT+8l4cfZPkigVha3VwvHcCKAzosEtHSMU5l7yQA3xuxcmf
         juqTtWfxJHsnPeyEv0q/9Kvulv1t+wQUvEPzdtFN6p22/odMb0dCSqv/YQpt9L0kz4aI
         160I1E0qrE2FTBF98UWAi1ToL7vG7sL6yoi6E0ndQQnX3eTDzSwXPsrwsTlBiMGdKzWi
         zmYTLs4uit1VFndm7SWYZjSQNO65wgmli+VJHZAc9Y8fQKlXEaZ/DdZWGyBbPsGqv3Go
         CYGA==
X-Gm-Message-State: APjAAAXsl0t2HoqY9P4cEFAbKwRiUFYtv3jf9KWHcIYjyW8VDP+Zc0Tn
        ax0fVb9yjQT4BxmPJlqXgz+uuXFUXZE=
X-Google-Smtp-Source: APXvYqyqpAbd3xpQVRe9HrP/otEoQg1vkR4RMyqY0RKUmUutDNa6+cunCCHTEnjtqAUQyUuxrnJFUQ==
X-Received: by 2002:a7b:c743:: with SMTP id w3mr12372088wmk.75.1554115313595;
        Mon, 01 Apr 2019 03:41:53 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q17sm8137644wrw.70.2019.04.01.03.41.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 03:41:52 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Liran Alon <liran.alon@oracle.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] KVM: x86: vmx: throttle immediate exit through preemtion timer to assist buggy guests
In-Reply-To: <B70317FC-A5AF-41B7-8D1E-A38B14806FE4@oracle.com>
References: <20190328203110.20655-1-vkuznets@redhat.com> <f64742ef-c67d-db0f-d812-2b6f5048d7ee@redhat.com> <87d0m93frp.fsf@vitty.brq.redhat.com> <89d4189b-de6a-7634-de8b-29a044a86e12@redhat.com> <63F1B6AE-F7A0-40D9-9582-558723800682@oracle.com> <32296de3-8ce0-c20a-5948-a7eef267a328@redhat.com> <87v9zy15mc.fsf@vitty.brq.redhat.com> <B70317FC-A5AF-41B7-8D1E-A38B14806FE4@oracle.com>
Date:   Mon, 01 Apr 2019 12:41:51 +0200
Message-ID: <87lg0u0zyo.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liran Alon <liran.alon@oracle.com> writes:

> So to sum-up: This matches what I mentioned in my previous emails right?
> That vector 96 is not related, and the only issue here is that level-triggered interrupt handler for vector 80 is doing EOI before lowering the irq-line.
> Which cause vector 80 to be injected in infinite loop.
> And this is not even related to being a nested virtualization
> workload. It’s just an issue in Hyper-V (L1) interrupt handler for
> vector 80.

Yes, it may be related to how communications between Hyper-V and Windows
partition are organized but it's a pure speculation.

>
> Therefore the only action-items are:
> 1) Microsoft to fix Hyper-V vector 80 interrupt handler to lower irq-line before EOI.
> 2) Patch QEMU IOAPIC implementation to have a mechanism similar to KVM to delay injection of level-triggered interrupt
>     in case we are injecting the same interrupt for X times in a row.

I'm intended to do 2) and we already let MS know there's an issue.

Thanks for your help with the investigation guys!

-- 
Vitaly
