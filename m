Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D77C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A5520820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439501AbfIWKVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 06:21:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439486AbfIWKVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 06:21:47 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E5F6C00E906
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 10:21:46 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id j2so4651798wre.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 03:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OmMWAPk3NRNh1ylKLS9ZJCZTMkn6Nstafcul+5/qUp8=;
        b=nHUY79nRlVsdEV9UboElUiv2b1o+Dzl+5UWm9EU34R4UHXUIGiGRWPM7Wb+wZxm3Ps
         zx5jI8qOMOuJQH/FA8gxuet38xb8uuvtsbKGUsLq+Me6vJRLp49lijN7l4uqGIFCscVp
         Pb0TC1WWcWOUEHFsHb8rsJH3PCcq75fmjRaa036vBGoVYD8CaTMr/P+VT7V1xdJE8bOo
         Dn1D6bnP9xhAlA4FTuUqM9n2SrXiqn2MFM0ARHNbZvgo2GC6xmIT4Mh8W88NwvMN0XLa
         xcER3CZFGLBsZwVJb8r3OKHMONSF9FsND2SSgWlHASEOa/RF3NsJgZkt0aAnn4KH9wMI
         EjzA==
X-Gm-Message-State: APjAAAUAbZtjSaBH9l399m2WYDO+BcmV3eXCs26nlsVYDdgsZas2hnAk
        Vp0EdvNsNQ4mzX8M3O4IamtrzpU5jqsvv7wjIUAiunS/+8y8n7NToStnLzbHyPnvRXh/ZUzVahX
        ZhovhfBvw8wpDOTmwxxpd2PSL
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr8375580wrr.390.1569234105215;
        Mon, 23 Sep 2019 03:21:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxueZ/N0VlXRwKFrYfaXJRgCGYard8ckjZfTB0PSl7gPQxsJBf8/9SSdLkbd6pbpUSZ1j7TIA==
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr8375567wrr.390.1569234104944;
        Mon, 23 Sep 2019 03:21:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id h17sm24346572wme.6.2019.09.23.03.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 03:21:44 -0700 (PDT)
Subject: Re: [PATCH 13/17] KVM: monolithic: x86: drop the kvm_pmu_ops
 structure
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190920212509.2578-1-aarcange@redhat.com>
 <20190920212509.2578-14-aarcange@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <057fc5f2-7343-943f-ed86-59f1ad5122e5@redhat.com>
Date:   Mon, 23 Sep 2019 12:21:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920212509.2578-14-aarcange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/19 23:25, Andrea Arcangeli wrote:
> Cleanup after this was finally left fully unused.
> 
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  3 ---
>  arch/x86/kvm/pmu.h              | 19 -------------------
>  arch/x86/kvm/pmu_amd.c          | 15 ---------------
>  arch/x86/kvm/svm.c              |  1 -
>  arch/x86/kvm/vmx/pmu_intel.c    | 15 ---------------
>  arch/x86/kvm/vmx/vmx.c          |  2 --
>  6 files changed, 55 deletions(-)

Is there any reason not to do the same for kvm_x86_ops?

(As an aside, patch 2 is not copying over the comments in the struct
kvm_x86_ops declarations.  Granted there aren't many, but we should not
lose the few that exist).

Paolo
