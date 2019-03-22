Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E7DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD18A206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731631AbfCVNEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:04:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42169 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730977AbfCVNEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:04:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so2260064wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 06:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=dzohx9uLBVWg4NAwXMeyvzY5YQucALzki7Y15eX3710=;
        b=cgWVPfZcJOwGx9Q06MaqYlsD+zrSq+6OfZKnQpX0reP85NDklRmFeWxEOrACars9d0
         J6+WlcLMnB1cr+PUCAfPphfmYRzuHInzu6NBL5eU0G6/l4vwZzbGhwY1PejuUU9Iv2HB
         0PVDWdslmBxDSOUFiryqM+RECeuiBIzjbdF+6C/g86joKYSqt+8fehMO12XaopplrdBH
         OlQe9atu/v1AIO/im+YJajZFmmv27wIOP44dbjJrDqIjbjU+qL4UC1WjIacuM7CkYUv9
         ZZYsr9OgURCD7VHxxzxaBHLtEeMqqnuqMDtV7nFgbaYBUGZa+yOkP5ovqXyRGDpjSAmq
         BXdg==
X-Gm-Message-State: APjAAAVSOvidQ3CPXlvKZFx7Pw7OvlikAg3w2UQ3Xw/bVVASQApHFBR8
        LavgFlnFIazq/899K8OXDhuadTTdmrM=
X-Google-Smtp-Source: APXvYqw+LXGuKgpZAnsJvwpuNkIlcQhpZkFKw4Ukuhr5g3UqdujjZrrKnT6afPK2eb5E+1Kj+43BWQ==
X-Received: by 2002:a5d:43c9:: with SMTP id v9mr6313895wrr.269.1553259843463;
        Fri, 22 Mar 2019 06:04:03 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 13sm8215249wmj.33.2019.03.22.06.04.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 06:04:02 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Suthikulpanit\, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc:     "joro\@8bytes.org" <joro@8bytes.org>,
        "pbonzini\@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar\@redhat.com" <rkrcmar@redhat.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm\@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH] svm/avic: Fix invalidate logical APIC id entry
In-Reply-To: <20190322101706.9377-1-suravee.suthikulpanit@amd.com>
References: <20190322101706.9377-1-suravee.suthikulpanit@amd.com>
Date:   Fri, 22 Mar 2019 14:04:01 +0100
Message-ID: <87ef6zcb7i.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com> writes:

> Only clear the valid bit when invalidate logical APIC id entry.
> The current logic clear the valid bit, but also set the rest of
> the bits (including reserved bits) to 1.
>
> Fixes: 98d90582be2e ('svm: Fix AVIC DFR and LDR handling')
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  arch/x86/kvm/svm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 7a4ce1a22ca0..f4fb766e474c 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -4640,7 +4640,7 @@ static void avic_invalidate_logical_id_entry(struct kvm_vcpu *vcpu)
>  	u32 *entry = avic_get_logical_id_entry(vcpu, svm->ldr_reg, flat);
>  
>  	if (entry)
> -		WRITE_ONCE(*entry, (u32) ~AVIC_LOGICAL_ID_ENTRY_VALID_MASK);
> +		WRITE_ONCE(*entry, (u32)(*entry & ~AVIC_LOGICAL_ID_ENTRY_VALID_MASK));

I'm not sure how important this is, but this change creates a tiny time
window between reading from *entry and writing there. Should we use
atomic bitops instead?

>  }
>  
>  static int avic_handle_ldr_update(struct kvm_vcpu *vcpu)

-- 
Vitaly
