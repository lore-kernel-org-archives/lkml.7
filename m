Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8538FC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCFC2196E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EoLi5eWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfKKN2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 08:28:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33630 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726910AbfKKN2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573478895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=FoSh0/g3U6MbcnL55kIsQwm9IFAJJTF+M/2yfYHu2HE=;
        b=EoLi5eWRocG4PqLoZTFS9ta00oSQ7i5bZ/CjMACkjDWju2+4v9qi5c+yb2+PdyhHK/kept
        KDFifr1NBdimDhFfaMVkTyPdUNhdyXxb4BQKTWnQ/bdxkQFOnHgMSWAhNe9onuOYxKsdrR
        DEaihP6W83g8U9zYo3TESq2frlYs+/Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-asAfnUTJPZKx7QkzfQCpQQ-1; Mon, 11 Nov 2019 08:28:14 -0500
Received: by mail-wm1-f70.google.com with SMTP id k184so6845640wmk.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 05:28:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KU+gPyOztTq20GSQTzZSVUPDKxWlRM8qWPtXV9rkkj4=;
        b=XrgLcbJoRpQjvAiM+CV+bKQDvqiyDs4fKEsF489LxGdeeEbwINMKuzDwZ1jGgjRtpH
         w42NXKlkW+E03Vg+PTPznqktDaeXeQP1WWkvXnjS+3MrYnLPfMi5bOlbO4IJdyKQ4guL
         KKDGJ+UHA/SoW6bLn3wIDlxtDs7E4Pdle1CL60hErOxU8WW+pTqTtScX5FfBcPAHyIMK
         r6uv4Dai9h7djB4+R77mGWtKkTfDvYXqPT3Bw5kn8EG63irYSKJ0z1gCDILMDoCj5qbG
         Z4hizwPuBrczrGEsVp2okC1DkhYf6p9uUgUGBg9uKelNxXDqaQvn8dirhDtNx9ttqdK9
         FAgg==
X-Gm-Message-State: APjAAAXSXsqsNyvGryno9N+55pd8s2iEe/6th6EN2ylH85RDw9qMRAEy
        386tV+1YsipDfhw7SqvJK20ddCmk818Vq7lgELch3m1b+JR5P9oSn5X7rr0QOt4hlXmvC6Psxwx
        OGKucONswDDNNoQJi3Vid1PfR
X-Received: by 2002:a05:600c:23d1:: with SMTP id p17mr21176425wmb.7.1573478893514;
        Mon, 11 Nov 2019 05:28:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqz0aYN7SGDDu0Hz4GSUD/GrUidKZd0dfcCR+q9egopBPToWi9LeErLj1b+SQ+533tRm/Pthhw==
X-Received: by 2002:a05:600c:23d1:: with SMTP id p17mr21176404wmb.7.1573478893173;
        Mon, 11 Nov 2019 05:28:13 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a0f7:472a:1e7:7ef? ([2001:b07:6468:f312:a0f7:472a:1e7:7ef])
        by smtp.gmail.com with ESMTPSA id j63sm21859722wmj.46.2019.11.11.05.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 05:28:12 -0800 (PST)
Subject: Re: [PATCH v1 0/6] KVM: VMX: Intel PT configuration switch using
 XSAVES/XRSTORS on VM-Entry/Exit
To:     Luwei Kang <luwei.kang@intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, rkrcmar@redhat.com
References: <1557995114-21629-1-git-send-email-luwei.kang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <54ee0d57-098f-32de-6d05-1c614ce9c1ad@redhat.com>
Date:   Mon, 11 Nov 2019 14:28:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1557995114-21629-1-git-send-email-luwei.kang@intel.com>
Content-Language: en-US
X-MC-Unique: asAfnUTJPZKx7QkzfQCpQQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/19 10:25, Luwei Kang wrote:
> This patch set is mainly used for reduce the overhead of switch
> Intel PT configuation contex on VM-Entry/Exit by XSAVES/XRSTORS
> instructions.
>=20
> I measured the cycles number of context witch on Manual and
> XSAVES/XRSTORES by rdtsc, and the data as below:
>=20
> Manual save(rdmsr):     ~334  cycles
> Manual restore(wrmsr):  ~1668 cycles
>=20
> XSAVES insturction:     ~124  cycles
> XRSTORS instruction:    ~378  cycles
>=20
> Manual: Switch the configuration by rdmsr and wrmsr instruction,
>         and there have 8 registers need to be saved or restore.
>         They are IA32_RTIT_OUTPUT_BASE, *_OUTPUT_MASK_PTRS,
>         *_STATUS, *_CR3_MATCH, *_ADDR0_A, *_ADDR0_B,
>         *_ADDR1_A, *_ADDR1_B.
> XSAVES/XRSTORS: Switch the configuration context by XSAVES/XRSTORS
>         instructions. This patch set will allocate separate
>         "struct fpu" structure to save host and guest PT state.
>         Only a small portion of this structure will be used because
>         we only save/restore PT state (not save AVX, AVX-512, MPX,
>         PKRU and so on).
>=20
> This patch set also do some code clean e.g. patch 2 will reuse
> the fpu pt_state to save the PT configuration contex and
> patch 3 will dymamic allocate Intel PT configuration state.
>=20
> Luwei Kang (6):
>   x86/fpu: Introduce new fpu state for Intel processor trace
>   KVM: VMX: Reuse the pt_state structure for PT context
>   KVM: VMX: Dymamic allocate Intel PT configuration state
>   KVM: VMX: Allocate XSAVE area for Intel PT configuration
>   KVM: VMX: Intel PT configration context switch using XSAVES/XRSTORS
>   KVM: VMX: Get PT state from xsave area to variables
>=20
>  arch/x86/include/asm/fpu/types.h |  13 ++
>  arch/x86/kvm/vmx/nested.c        |   2 +-
>  arch/x86/kvm/vmx/vmx.c           | 338 ++++++++++++++++++++++++++-------=
------
>  arch/x86/kvm/vmx/vmx.h           |  21 +--
>  4 files changed, 243 insertions(+), 131 deletions(-)
>=20

Luwei, I found I had missed this series.  Can you check whether it needs
a rebase, since I don't have hardware that supports it?

Paolo

