Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E2BC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 13:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0606820863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 13:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpdZR2hq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgABNa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 08:30:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58298 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728342AbgABNa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 08:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577971855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZsBhJwwJv21RoNj2+tx20MPsedLMGWgIPllyzpaocXw=;
        b=bpdZR2hqwp1a20GqJDCGCxeKkLTeiHYUWYavg0W2C+hh7IpTGZtiEWX8TxmKBnpNtKCKf4
        LOhfAYbdYMla8YHTyphv27d5GHPV8vQ6znnG12iV39kSsVT/gZsAET1w1NqDug70+lmdkw
        tQ9KIx5jeZIdPcDHk0ixP3itKq8tU7k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-1LgD_l0nO9e_SZ72wPaxiw-1; Thu, 02 Jan 2020 08:30:54 -0500
X-MC-Unique: 1LgD_l0nO9e_SZ72wPaxiw-1
Received: by mail-wr1-f71.google.com with SMTP id c17so15470167wrp.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 05:30:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ZsBhJwwJv21RoNj2+tx20MPsedLMGWgIPllyzpaocXw=;
        b=kmELHsI49pb5850ljd3Qj3uW70SNreZGkm9ga4jvXbrn6AJ0DjfaA2jwt4nOJlgIcD
         vSktP+dfQ9eZcC3mc69DrdKzBIUb+iK6663cgWNIb7Vp49tRVCRFlbNyxwWLKwd6rEyv
         PVQyV/jYaGbUblWytrBPy3sBR5LnoQsRZ5a8uOPeU/HWCWqWz4QwGW5s50ZWYdjZfEUt
         WWELw8lmIed3vbbWHD+wuGaYmwZ9aRQETopwMnKIbI8tLNTlMnIZ6gis3q6q1YWACqev
         8CmQRjd5a5QqMXzJpbSgdk58spZdQurlmUfxjQSMuPEalrb52kbmK/Il9CPka15ApV1W
         foUg==
X-Gm-Message-State: APjAAAWX3c7fA7ad2D0igam2wuRsU9W17Q9e5JiWMDG5ni4fsRoUniI0
        yA2gh2ctoa1eLQAiJwgmR7fxYAmdBO8c2REI95+11On+rw2Yfy0J9OZ2bo/dKjlLgqnnlPybtnl
        cYtvK8jTf3/u601hM0zZab6gH
X-Received: by 2002:a5d:6901:: with SMTP id t1mr77010005wru.94.1577971853250;
        Thu, 02 Jan 2020 05:30:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqwdUwZjrRwC+kY/eme4evBi91EVFOSdeA7R/8x+3GHU0hsElt9g82hKc60ZmQsjwClQc7mtPQ==
X-Received: by 2002:a5d:6901:: with SMTP id t1mr77009989wru.94.1577971853010;
        Thu, 02 Jan 2020 05:30:53 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id z8sm55295423wrq.22.2020.01.02.05.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 05:30:52 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     liran.alon@oracle.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, sean.j.christopherson@intel.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Subject: Re: [PATCH] KVM: SVM: Fix potential memory leak in svm_cpu_init()
In-Reply-To: <1577931640-29420-1-git-send-email-linmiaohe@huawei.com>
References: <1577931640-29420-1-git-send-email-linmiaohe@huawei.com>
Date:   Thu, 02 Jan 2020 14:30:50 +0100
Message-ID: <878smq7zp1.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linmiaohe <linmiaohe@huawei.com> writes:

> From: Miaohe Lin <linmiaohe@huawei.com>
>
> When kmalloc memory for sd->sev_vmcbs failed, we forget to free the page
> held by sd->save_area.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/svm.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 8f1b715dfde8..89eb382e8580 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -1012,7 +1012,7 @@ static int svm_cpu_init(int cpu)
>  	r = -ENOMEM;
>  	sd->save_area = alloc_page(GFP_KERNEL);
>  	if (!sd->save_area)
> -		goto err_1;
> +		goto free_cpu_data;
>  
>  	if (svm_sev_enabled()) {
>  		r = -ENOMEM;

Not your fault but this assignment to 'r' seem to be redundant: it is
already set to '-ENOMEM' above, but this is also not perfect as ... 

> @@ -1020,14 +1020,16 @@ static int svm_cpu_init(int cpu)
>  					      sizeof(void *),
>  					      GFP_KERNEL);
>  		if (!sd->sev_vmcbs)
> -			goto err_1;
> +			goto free_save_area;
>  	}
>  
>  	per_cpu(svm_data, cpu) = sd;
>  
>  	return 0;
>  
> -err_1:
> +free_save_area:
> +	__free_page(sd->save_area);
> +free_cpu_data:
>  	kfree(sd);
>  	return r;

... '-ENOMEM' is actually the only possible outcome here. In case you'll
be re-submitting, I'd suggest we drop 'r' entirely and just reture
-ENOMEM here.

Anyways, your patch seems to be correct, so:

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

