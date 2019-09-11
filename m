Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88817C4740A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 04:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5528D21A4C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 04:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Hs+rUzHv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfIKE1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 00:27:40 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:64464 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfIKE1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 00:27:40 -0400
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x8B4RY3q018152
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 13:27:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x8B4RY3q018152
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1568176055;
        bh=2bJShX4Ff3PHK48gMEQzP3cEPpqbzfOY7VjrtVo5UdE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Hs+rUzHvcvyixmd4WHBymTPg9eM8TpjwUJ4vFyDVkUagWGjFfo6xJO3TNLLOECcA2
         8TH0W6loMI2+LzBH7C605ynFFMC2F2gI45BKaNhtOz/7LWgN539M79Ztbbz5plvDXf
         DbnWn24NDIR08VdXE8cd5pIKq6i+vo3K+UtJf2lyAwYHMJBKywvf9pwVhdzzp55reQ
         rv9WMwPpA4rIDguE1ZVDSINae+++fzo7xyd27gWzOy567gshnqNw2YNmRs7n5HUplr
         H1XLV9mI+WxV2Y6wMgheXjKbwJJZ9PP9Y2XfP8D+mw2ltPYiB6MuZBH5ozMyqMPTLa
         G4cuVSLNech7w==
X-Nifty-SrcIP: [209.85.221.178]
Received: by mail-vk1-f178.google.com with SMTP id q186so4071759vkb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 21:27:35 -0700 (PDT)
X-Gm-Message-State: APjAAAXYtvgccZhTFu1/OCGcOFVwcT5es0UYMSX3+U5akVCWCVxH2XvV
        MXGUU2BfPG/5pYwFHece5ylzXy+ebTMGDnvXSyo=
X-Google-Smtp-Source: APXvYqxcC7v9qXKkiFdYOioajynW6ENkts6eVJhzv73g0b3GlVu6ohGHdS3vnp8EInycfekShhmHhrgynXloMMplkJc=
X-Received: by 2002:a1f:2343:: with SMTP id j64mr12520866vkj.84.1568176054022;
 Tue, 10 Sep 2019 21:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <1568169216-12632-1-git-send-email-yuzenghui@huawei.com> <1568169216-12632-2-git-send-email-yuzenghui@huawei.com>
In-Reply-To: <1568169216-12632-2-git-send-email-yuzenghui@huawei.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 11 Sep 2019 13:26:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNARPo6VgzXn5kfrL7MWRtBoNf83yCM0r8jZ0iURU_to_BA@mail.gmail.com>
Message-ID: <CAK7LNARPo6VgzXn5kfrL7MWRtBoNf83yCM0r8jZ0iURU_to_BA@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: arm/arm64: vgic: Use the appropriate TRACE_INCLUDE_PATH
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     maz@kernel.org, James Morse <james.morse@arm.com>,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wanghaibin.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 11:35 AM Zenghui Yu <yuzenghui@huawei.com> wrote:
>
> Commit 49dfe94fe5ad ("KVM: arm/arm64: Fix TRACE_INCLUDE_PATH") fixes
> TRACE_INCLUDE_PATH to the correct relative path to the define_trace.h
> and explains why did the old one work.
>
> The same fix should be applied to virt/kvm/arm/vgic/trace.h.
>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>

Please feel free to replace the Cc: with my:

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Thanks.


> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  virt/kvm/arm/vgic/trace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/virt/kvm/arm/vgic/trace.h b/virt/kvm/arm/vgic/trace.h
> index 55fed77a9f73..4fd4f6db181b 100644
> --- a/virt/kvm/arm/vgic/trace.h
> +++ b/virt/kvm/arm/vgic/trace.h
> @@ -30,7 +30,7 @@ TRACE_EVENT(vgic_update_irq_pending,
>  #endif /* _TRACE_VGIC_H */
>
>  #undef TRACE_INCLUDE_PATH
> -#define TRACE_INCLUDE_PATH ../../../virt/kvm/arm/vgic
> +#define TRACE_INCLUDE_PATH ../../virt/kvm/arm/vgic
>  #undef TRACE_INCLUDE_FILE
>  #define TRACE_INCLUDE_FILE trace
>
> --
> 2.19.1
>
>


-- 
Best Regards
Masahiro Yamada
