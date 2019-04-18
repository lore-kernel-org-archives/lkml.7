Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588DDC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297472186A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388082AbfDRHOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 03:14:06 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:35538 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfDRHOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 03:14:06 -0400
Received: by mail-wr1-f51.google.com with SMTP id o12so1602685wrn.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 00:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=KDmQA5vkLWxGPxFVassSlW3/WlZCgZYWuWBWwkSTvgM=;
        b=iv2tEtSXum6udthqboNsaXojDrCO50sc6WHJUnRtCu0R8PIWeEE6UaQDdF5zS6VXf5
         rU9RKnCEiTsfjvj+gf6N8VsFMIRnsRHIvb4TQ0Oq7OmGCw3HOTkEvQjv9EFRd+3hK8fQ
         h10PvYfZnONg1enUFKCXdSZzIZNXbqm+uEfjVqw8zUkZ3s0tFfR0SPBKZzWx59OyYRVX
         dpr9Ett6x/NGmLwjZ/SkNmX+WlK41LKE/jB1X7vPp8ew5ciUHYCtzqOnN0pG2nqvz1py
         2PcZI0kMmLetCAtgrmezq+L1IB5sSfhHwuag1k81pLmwopJ8gwrldV2vdm12J3aYPpTS
         trbw==
X-Gm-Message-State: APjAAAXvgRJOS4zeHU/NlrLHDlOLZ6rya+mim13rFjaM6Pxg3OiS5Svf
        uN1CtWf+YctN30+EuH1r48K8OG3Kx+k=
X-Google-Smtp-Source: APXvYqxe1pcPMAR1fisjXVqfI4GbBB39W0W1lpy/X6JxSfJqQVcR3DlM8Eoc6xWJqgCMstR9hU9Ufg==
X-Received: by 2002:adf:e703:: with SMTP id c3mr6467850wrm.98.1555571644645;
        Thu, 18 Apr 2019 00:14:04 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-213-220-248-130.net.upcbroadband.cz. [213.220.248.130])
        by smtp.gmail.com with ESMTPSA id j7sm1267661wrt.96.2019.04.18.00.14.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 00:14:03 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: kvm: hyper-v: deal with buggy TLB flush requests from WS2012
In-Reply-To: <20190320174320.9459-1-vkuznets@redhat.com>
References: <20190320174320.9459-1-vkuznets@redhat.com>
Date:   Thu, 18 Apr 2019 09:14:03 +0200
Message-ID: <87sguf23b8.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> It was reported that with some special Multi Processor Group configuration,
> e.g:
>  bcdedit.exe /set groupsize 1
>  bcdedit.exe /set maxgroup on
>  bcdedit.exe /set groupaware on
> for a 16-vCPU guest WS2012 shows BSOD on boot when PV TLB flush mechanism
> is in use.
>
> Tracing kvm_hv_flush_tlb immediately reveals the issue:
>
>  kvm_hv_flush_tlb: processor_mask 0x0 address_space 0x0 flags 0x2
>
> The only flag set in this request is HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES,
> however, processor_mask is 0x0 and no HV_FLUSH_ALL_PROCESSORS is specified.
> We don't flush anything and apparently it's not what Windows expects.
>
> TLFS doesn't say anything about such requests and newer Windows versions
> seem to be unaffected. This all feels like a WS2012 bug, which is, however,
> easy to workaround in KVM: let's flush everything when we see an empty
> flush request, over-flushing doesn't hurt.
>

Ping) I understand the lack of interest towards this ugly hack but I
don't see a better option ...

-- 
Vitaly
