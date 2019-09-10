Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327B7C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B66821479
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbfIJOlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:41:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729518AbfIJOlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:41:02 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6B39C7FDC9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 14:41:02 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id a4so7772023wrg.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 07:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cJrLJhg77HdXITw7W6jWRWxQLFrh8FY3brtGhslg/yU=;
        b=UPhkHjNAwr6cg8GVO0iJVjkKS7JAOiKQzj3D9YxO0b4l/zt166e9A3vkuFrxZ2UgAZ
         rXirXzbjrdI1VVCNtPoVf5ehGKO1//JPZtlp9a1SDNX70gjsdq9iD9aBZLT/CO+L3Q1y
         eYANiXb89wGtiUVh5Rh37ww+e/NvUtUfIGxoUozAIFEDmWJwBDrtvTeKINA7fAi3+Rxl
         QFOKMHijowJrVDe01ezDpBGi0p7EgrQ3XSnC56QWsSV18QrvIGu2CEJhfPf99r5WS6Vn
         isWf4VGJ7Rh4zj7PN4svHXP6ti75iAlBBUj9RZ2MfSjkq0YBwQdhQZGfE/FqxtfqS5tx
         cCKA==
X-Gm-Message-State: APjAAAXT6Hfxnu1gqUXXCEoCdePYcyC0h67wOp7xXk8qLHtJSiu2owLZ
        5NUaXjdFlwUZRnZ2+YBQNRjIA33Qdmt/SDit33kM28BhCbSUzMoBx0bIrIcRyRtVSqvcScxQ2an
        KafhMXFBlY92vPMbAPMEs3S0p
X-Received: by 2002:adf:fc05:: with SMTP id i5mr21459277wrr.134.1568126461120;
        Tue, 10 Sep 2019 07:41:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy7r22ycaiyIAOgheL4k6r1Mn72f2EGSPwZkUVY5WoV3EEGyJTIURDBq8k7n4jtyP6PoMsfpw==
X-Received: by 2002:adf:fc05:: with SMTP id i5mr21459245wrr.134.1568126460876;
        Tue, 10 Sep 2019 07:41:00 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id i9sm3720112wmf.14.2019.09.10.07.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2019 07:41:00 -0700 (PDT)
Subject: Re: [PATCH v3] KVM: x86: Disable posted interrupts for odd IRQs
To:     Christoph Hellwig <hch@infradead.org>,
        Alexander Graf <graf@amazon.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>
References: <20190905125818.22395-1-graf@amazon.com>
 <20190910061554.GD10968@infradead.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <1cc51fa5-ee1c-88a4-c935-c293c947f240@redhat.com>
Date:   Tue, 10 Sep 2019 16:40:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910061554.GD10968@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/19 08:15, Christoph Hellwig wrote:
> And what about even ones? :)
> 
> Sorry, just joking, but the "odd" qualifier here looks a little weird,
> maybe something like "non-standard develiry modes" might make sense
> here.

Indeed, folded this into the commit message.  Thanks Christoph.

Alex, I queued the patch but I don't think I'll include it in 5.3.

Paolo

