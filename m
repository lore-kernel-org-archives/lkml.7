Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674D3C04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6AE208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392868AbfETRXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:23:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36212 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392854AbfETRXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:23:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id s17so15538607wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5IBTHlLWle5UHeHtFTJc2+zC+bcnwX/bM8+GOzR3AZs=;
        b=qKq5TDrXTcIG00Y7F3EUAI141t+DhQXLgcgyqPEp3KMu+gS5Luc06LsMW7A41/f2i8
         jKo3ki66STo4iP20N8Um8SoqGM9tfSWJvH9txDDwlSdWPqwyI8/SFyNQBzZT9x70yhDV
         rrZCnoRWpzzIMZIWbx8E/UvNP70wOmF1jbjQsM27nCwufyuPyvDbvspTvNB+Gv4EMQL5
         xHCrhCpzNSRW1/f582/5BDiRSsKDdSwjA3aDaahe+DVZJlKbXYzuYzQmX64F63dxJos3
         8lsDcLGd9SRTWZ7usv8yN5a+g2CaCS5JVoqJoPS98xGjdRXoK9k3hkM66Q3+DYINlJS3
         DolQ==
X-Gm-Message-State: APjAAAXjEtrIeBFnPi344zf1zWAU9zPkV/93aJHBAL/5gHYfqohHxApd
        F+Hu3fiacAipolhrnykuFbWRYTEhXit7sA==
X-Google-Smtp-Source: APXvYqyMHAUocoJjg+Rd0QCpMErsETkEHHPCbpKrDtr/Wh2IbPJRUt3kGmDTQyjsfGosb8vnh6kVmw==
X-Received: by 2002:a5d:53c8:: with SMTP id a8mr10808166wrw.152.1558373024313;
        Mon, 20 May 2019 10:23:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac04:eef9:b257:b844? ([2001:b07:6468:f312:ac04:eef9:b257:b844])
        by smtp.gmail.com with ESMTPSA id x6sm27281408wru.36.2019.05.20.10.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 10:23:43 -0700 (PDT)
Subject: Re: [PATCH RESEND] kvm: make kvm_vcpu_(un)map dependency on
 CONFIG_HAS_IOMEM explicit
To:     Michal Kubecek <mkubecek@suse.cz>, kvm@vger.kernel.org
Cc:     Radim Krcmar <rkrcmar@redhat.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        linux-kernel@vger.kernel.org
References: <20190520164418.06D1CE0184@unicorn.suse.cz>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <41adfaf7-90e8-b011-2716-ea5dc464ae5a@redhat.com>
Date:   Mon, 20 May 2019 19:23:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520164418.06D1CE0184@unicorn.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/19 18:44, Michal Kubecek wrote:
> Recently introduced functions kvm_vcpu_map() and kvm_vcpu_unmap() call
> memremap() and memunmap() which are only available if HAS_IOMEM is enabled
> but this dependency is not explicit, so that the build fails with HAS_IOMEM
> disabled.
> 
> As both function are only used on x86 where HAS_IOMEM is always enabled,
> the easiest fix seems to be to only provide them when HAS_IOMEM is enabled.
> 
> Fixes: e45adf665a53 ("KVM: Introduce a new guest mapping API")
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> ---

Thank you very much.  However, it's better if only the memremap part is
hidden behind CONFIG_HAS_IOMEM.  I'll send a patch tomorrow and have it
reach Linus at most on Wednesday.

There is actually nothing specific to CONFIG_HAS_IOMEM in them,
basically the functionality we want is remap_pfn_range but without a
VMA.  However, it's for a niche use case where KVM guest memory is
mmap-ed from /dev/mem and it's okay if for now that part remains
disabled on s390.

Paolo
