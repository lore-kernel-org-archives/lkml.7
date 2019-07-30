Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C478C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20ABD20644
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbfG3JXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:23:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35889 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfG3JXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:23:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id g67so51841945wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 02:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mWMZh3wUcWsqPn07oFt7cBOH5RBu0IlIBiCukBD3l9o=;
        b=Bitkvbdi/4L9CmILWmwwpZcuGSjsHwHzUhWvhRVEExo81XaK7DiC6xJbBQClrYnICc
         0zgSuj6XFr/fYLJ5YEhAN+JDXw9bIIu5MFhsFDuEDCDo065+J/1r4Cs6jrYae59Jl0P8
         ApmK3/UFgEheRpmfLm0v7XbL6SuZp5JDn80YP5oNHD7MG6exzT1P8SB9fm5VZBpKrgps
         TETqe4c1XivQrWZAo3RUPsMsU8HCbJCUPuLAd0f/JqcyH/G7llkr35zjUNf9H1S1HlGw
         mFtRHCefeOfXLxj2QD0OGq8lmm5sNfDP/3IWOu6t1iVLI5NBhDCsc+sZz7hXDOLYllkf
         J5IQ==
X-Gm-Message-State: APjAAAUBCTGQibQDgbpdfO075U9xjO5Xu3Q7OSqT/JokJaX2n4PWyi6R
        9H7A0sXEx0zl7XrTQz7lhLRMvntCCck=
X-Google-Smtp-Source: APXvYqyjkTFE8K19/Ax2T+TuTtN5zUHOBpO/LA8yzScwVqCfBWpuwT+J9Qb8/NNoeIAkuB0HbwVZzQ==
X-Received: by 2002:a7b:cc04:: with SMTP id f4mr40005383wmh.125.1564478622449;
        Tue, 30 Jul 2019 02:23:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29d3:6123:6d5f:2c04? ([2001:b07:6468:f312:29d3:6123:6d5f:2c04])
        by smtp.gmail.com with ESMTPSA id s10sm48654942wrt.49.2019.07.30.02.23.40
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 02:23:41 -0700 (PDT)
Subject: Re: [RFC PATCH 03/16] RISC-V: Add initial skeletal KVM support
To:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Radim K <rkrcmar@redhat.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Anup Patel <anup@brainfault.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190729115544.17895-1-anup.patel@wdc.com>
 <20190729115544.17895-4-anup.patel@wdc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <309b9fb3-9909-48d6-eabf-88356df4bb3b@redhat.com>
Date:   Tue, 30 Jul 2019 11:23:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729115544.17895-4-anup.patel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/19 13:56, Anup Patel wrote:
> +	case KVM_CAP_DEVICE_CTRL:
> +	case KVM_CAP_USER_MEMORY:
> +	case KVM_CAP_SYNC_MMU:

Technically KVM_CAP_SYNC_MMU should only be added after you add MMU
notifiers.

Paolo

> +	case KVM_CAP_DESTROY_MEMORY_REGION_WORKS:
> +	case KVM_CAP_ONE_REG:
> +	case KVM_CAP_READONLY_MEM:
> +	case KVM_CAP_MP_STATE:
> +	case KVM_CAP_IMMEDIATE_EXIT:
> +		r = 1;
> +		break;

