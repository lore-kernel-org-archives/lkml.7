Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64845C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361EC222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vi8Oaw85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfLSTKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:10:09 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56793 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726945AbfLSTKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 14:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576782604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TsFvSsTqVBZ+tF91hnxKk0O+iZiuPyz2pCFwyuo+kkY=;
        b=Vi8Oaw85Ju3XcuQ2UDLXXfAadUpjWLJFKI+ylyBu4Mdsyy8e07+7/uS4d/oUCXqdvKQLGE
        9wO/AUYzGHaX/D4Ho8HUR69/uHCcRqpit/GB+dlmWVqfcEHGuuq2Q6T+SCoj0UYJ5QQKxb
        UYEedLlxWITs+dJVJUmqoR9BScy0gtw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-BPpn836kPWi9Ccny7his-Q-1; Thu, 19 Dec 2019 14:10:01 -0500
X-MC-Unique: BPpn836kPWi9Ccny7his-Q-1
Received: by mail-wr1-f70.google.com with SMTP id f17so2729225wrt.19
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 11:10:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=TsFvSsTqVBZ+tF91hnxKk0O+iZiuPyz2pCFwyuo+kkY=;
        b=WcgxoIafFfmLBuZ6lIVpJw+PnUCCXDUhlc7O2DWI4XVoI8dzc7NqAIan0RE7WeMUVT
         DDzEQWwnbatWDp/cqmAgA0WDL56CmkH/hyxYXv6QdVfi65dBG320CHvSDxTOeXO5b8el
         7cS85tenQ8LpxOFpMkwWzKAQJJ2PChdITSWoFkQeOzYGw55ZKc5gHu5A6KZU0UrH+mMZ
         llDz5dx4I0GUGXc5KmnB6HbsAR9skzw2XnJqPNQ95YD205h/5DNeAaBvcblsF6HM987M
         N+ZGsoGR1jO7J4c/LZlHo/swylv4KpH4/Ru8wxw7/jofl9taH+OdwhyGGZeyiYFWZc6S
         e1Pw==
X-Gm-Message-State: APjAAAUNBVy3N3ek6/02lHtm6BuyELHVwmNflozmhbrmaU9S17RjY3/A
        2W7VW0ILE+D9H3GdFVR9/kUTppxOdNptvo7m1oAxqAxjozjHJOzWr9t+pjTgjVZ3MKSY77xh6St
        waIVKMFOnhiep8L9r/kqgcAVL
X-Received: by 2002:a1c:4d03:: with SMTP id o3mr11976160wmh.164.1576782599915;
        Thu, 19 Dec 2019 11:09:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqyCPSAQBtZpVyCHuMDoSVEQwEOPH4leBjaVKeWb7GppTaUWkTOvT9jwqDl7h6ChPbVt3S9Xrw==
X-Received: by 2002:a1c:4d03:: with SMTP id o3mr11976139wmh.164.1576782599685;
        Thu, 19 Dec 2019 11:09:59 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f65sm7124998wmf.2.2019.12.19.11.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 11:09:58 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     John Allen <john.allen@amd.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, John Allen <john.allen@amd.com>
Subject: Re: [PATCH] kvm/svm: PKU not currently supported
In-Reply-To: <20191219152332.28857-1-john.allen@amd.com>
References: <20191219152332.28857-1-john.allen@amd.com>
Date:   Thu, 19 Dec 2019 20:09:57 +0100
Message-ID: <87immc873u.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John Allen <john.allen@amd.com> writes:

> Current SVM implementation does not have support for handling PKU. Guests
> running on a host with future AMD cpus that support the feature will read
> garbage from the PKRU register and will hit segmentation faults on boot as
> memory is getting marked as protected that should not be. Ensure that cpuid
> from SVM does not advertise the feature.
>
> Signed-off-by: John Allen <john.allen@amd.com>
> ---
>  arch/x86/kvm/svm.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 122d4ce3b1ab..f911aa1b41c8 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -5933,6 +5933,8 @@ static void svm_set_supported_cpuid(u32 func, struct kvm_cpuid_entry2 *entry)
>  		if (avic)
>  			entry->ecx &= ~bit(X86_FEATURE_X2APIC);
>  		break;
> +	case 0x7:
> +		entry->ecx &= ~bit(X86_FEATURE_PKU);

Would it make more sense to introduce kvm_x86_ops->pku_supported() (and
return false for SVM and boot_cpu_has(X86_FEATURE_PKU) for vmx) so we
don't set the bit in the first place?

>  	case 0x80000001:
>  		if (nested)
>  			entry->ecx |= (1 << 2); /* Set SVM bit */

-- 
Vitaly

