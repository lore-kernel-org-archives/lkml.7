Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EBAC00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783052073A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLqaWPXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgAHKN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 05:13:56 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35187 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727324AbgAHKNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 05:13:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578478434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uVrqj6afqt7XuiTw73oIbm/4tmf2L88UQPwWRVq8vyU=;
        b=JLqaWPXtUG1sRPZ7eOylaEOtu+A4CVAQPk5GeueqhIzy1/lUaRez1kfJu/6DVKaIcQM4P4
        JQdhMS3dTJ6d6f1TsdNAC8haZtNeCkffuYCaCQ+WWGsaHURq65IKuMv8Y77hbH+C5ZeCdU
        L3d0luF2Pd4aqYv8vRaONRw966UHFSc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382--RjDTM3gOh-Ogn3iqM9isQ-1; Wed, 08 Jan 2020 05:13:51 -0500
X-MC-Unique: -RjDTM3gOh-Ogn3iqM9isQ-1
Received: by mail-wm1-f70.google.com with SMTP id f25so653666wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 02:13:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=uVrqj6afqt7XuiTw73oIbm/4tmf2L88UQPwWRVq8vyU=;
        b=atBfsA905CpGkUKUcFeMzn711yxkMwb9zr3blJ17ROwi3KO0xjGgC6K3uJU8LHkp4w
         d8W0DPP9r8DJ7Sgy+XBxt6v/lrLtpuK7K1iQt3ctx/rV2wgB8leQ2BD1icNOtKvL1wyI
         xaTz6JMIDnxZfBET1EBAGJXuSkwWtLLBeXVmet+p/tTb63dz0ysD7LJUZNa12exLlQY6
         47ZLjwnCG/LoaZMDzpT8pHmvlIDADqezT+yPCTsGwjGhGxPwC4ua5LnCUELC/5zG6Wnn
         29OF8FzEjSXWyL4pWY0w34DkOgW+hGRpYEuWZdz4Vt7b3Q8UuWbh9yv/CU5G3rr3xc7r
         QSmw==
X-Gm-Message-State: APjAAAVmZSrYi6DwKOHFCzooH6jmedy5Y0uQJ1c6O8yxTnjh/i+nHjUV
        F94TtL2sFQ+Ygd2jrEWL2h2Fe0YOKlQ5IJWqgjRo8u2vez0gDhZg/jcdCdyOR6IzirhyIXUu1vp
        7UbASMMYj0MWGa0ftRrNVuVjz
X-Received: by 2002:adf:e550:: with SMTP id z16mr3548228wrm.315.1578478430258;
        Wed, 08 Jan 2020 02:13:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqxRB9id3wHWWiu08oCQy3B4XNXmRQaQS6UKvo5KldVbYP8ts/jV70wGa1GYivKccPOmt1on8w==
X-Received: by 2002:adf:e550:: with SMTP id z16mr3548210wrm.315.1578478430066;
        Wed, 08 Jan 2020 02:13:50 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id p5sm3698498wrt.79.2020.01.08.02.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 02:13:49 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: x86/mmu: Fix a benign Bitwise vs. Logical OR mixup
In-Reply-To: <20200108001859.25254-1-sean.j.christopherson@intel.com>
References: <20200108001859.25254-1-sean.j.christopherson@intel.com>
Date:   Wed, 08 Jan 2020 11:13:48 +0100
Message-ID: <87d0bus1b7.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Use a Logical OR in __is_rsvd_bits_set() to combine the two reserved bit
> checks, which are obviously intended to be logical statements.  Switching
> to a Logical OR is functionally a nop, but allows the compiler to better
> optimize the checks.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 7269130ea5e2..72e845709027 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3970,7 +3970,7 @@ __is_rsvd_bits_set(struct rsvd_bits_validate *rsvd_check, u64 pte, int level)
>  {
>  	int bit7 = (pte >> 7) & 1, low6 = pte & 0x3f;
>  
> -	return (pte & rsvd_check->rsvd_bits_mask[bit7][level-1]) |
> +	return (pte & rsvd_check->rsvd_bits_mask[bit7][level-1]) ||
>  		((rsvd_check->bad_mt_xwr & (1ull << low6)) != 0);

Redundant parentheses detected!

>  }

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

