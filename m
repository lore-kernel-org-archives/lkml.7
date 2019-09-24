Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD32EC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 01:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BD6207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 01:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503852AbfIXBZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 21:25:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392632AbfIXBZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 21:25:37 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F953356C5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 01:25:37 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id r21so55549wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 18:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xj3D9weBvvGH4QzczcqBFTO/vVNmZQd4hYXQQeqeaII=;
        b=sn5NcbxSC4GaTXFde6sSD/uZMLm2FHaY+azOTql90qQYpltZymRpjgVM5Uvj0kFOGq
         qUTGfP66ifSNdXw/Oa5Rt0ukzUOwY3q98tOM1Wfwuyh0RYC0pl7/XixIWKfuEj+3oew0
         DjUSEPz/BLf4xASzFGJfxGuKjmSZbkw9IDeOCLyAa+S3yQM8vUV3kTc9F/eSYzpC+Luf
         zHxlN4nFrC72kj4MlKxouzv15UTAbO4AFRQ9/zgXnXF/KdKM80/WQbRkAnw4OITHVuIt
         SFN+rg2fxQ41n4tJwrhw+wi1SBHVzNfzoL+Joct9RB0O6pXD+2V1nE6kTLzJ9NY926W0
         owSA==
X-Gm-Message-State: APjAAAU0OQcW+lisL2SAlot3qRAcmI+356ANk7Jbw+EXYZsyXO7NcHIR
        HADlWOPkZdiNm+dr6CjRnrQVjmVx4VCN9HNnTzviFrMxKkdxHy5plBjsnxkwI8EZIFLNXTe1DOI
        SvXnG6B4986O/qyZkFiDZK9/V
X-Received: by 2002:a05:6000:1184:: with SMTP id g4mr127590wrx.361.1569288335715;
        Mon, 23 Sep 2019 18:25:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyJvHeB3EfxNQ+c0VPwzgcez8G6EPsqpQZUikOxoYmksWOE7tQWSxWJ9eRpcysQ5/DTMSQ6og==
X-Received: by 2002:a05:6000:1184:: with SMTP id g4mr127577wrx.361.1569288335478;
        Mon, 23 Sep 2019 18:25:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id q10sm268496wrd.39.2019.09.23.18.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 18:25:34 -0700 (PDT)
Subject: Re: [PATCH 14/17] KVM: monolithic: x86: inline more exit handlers in
 vmx.c
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190920212509.2578-1-aarcange@redhat.com>
 <20190920212509.2578-15-aarcange@redhat.com>
 <6a1d66a1-74c0-25b9-692f-8875e33b2fae@redhat.com>
 <20190924010056.GB4658@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a75d04e1-cfd6-fa2e-6120-1f3956e14153@redhat.com>
Date:   Tue, 24 Sep 2019 03:25:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924010056.GB4658@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/19 03:00, Andrea Arcangeli wrote:
> Before and after this specific commit there is a difference with gcc 8.3.
> 
> full patchset applied
> 
>  753699   87971    9616  851286   cfd56 build/arch/x86/kvm/kvm-intel.ko
> 
> git revert
> 
>  753739   87971    9616  851326   cfd7e  build/arch/x86/kvm/kvm-intel.ko
> 
> git reset --hard HEAD^
> 
>  753699   87971    9616  851286   cfd56  build/arch/x86/kvm/kvm-intel.ko
> 
> git revert
> 
>  753739   87971    9616  851326   cfd7e  build/arch/x86/kvm/kvm-intel.ko

So it's forty bytes.  I think we can leave this out.

Paolo
