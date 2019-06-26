Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04826C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D054220B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfFZJjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 05:39:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39370 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfFZJjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:39:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id z23so1358607wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 02:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0oLx6Rnuo9a2CrlixJQ1TNptd79xT0odw2gDg+gLUkM=;
        b=h84dQZW3l/HSGlRxHwn6gOZJuF6XCYQ33jXK7ht05mjA4Fd4koPx8nB9FDGxxR95gE
         mhLyNtUs59UVr0y6d5OkyU2nA/NAOm1T8+tQNg5tD4cBbe0UdRQYclkS/PSGjg/5NDEY
         +JqGjQQYAAVttGE021pbHWnpmHU/B62+RbuZAM9/lG2aZ5RVx4CACpFrcmtbZYvox2OP
         q1d6aMk1gL0u5woflyUZeq48FSjFF1kJIpv7dcqGMC3JvTbxIHo4qjhSqHBAkRJgbU6t
         9F7GDUoJb2HpC8jzvsMdDdnQ7N1Af26UlPj2wynBqeVnUdpNyr7WtvGIsE9A8/Z79mFR
         sJjg==
X-Gm-Message-State: APjAAAWBQ5+ZoUV487opw8Ft48/Luw8fQLlUYW97j2vVtclwCaW/hydD
        DOT29wJb7Sv2i1esGT/pE2XxCQ==
X-Google-Smtp-Source: APXvYqysu4XkmlTfX3pnryWiqDuf/fsvEmP4YQwQk5dJtOFdmaY1wHQXydtGgRz2Lpe8hgMDa5BhPg==
X-Received: by 2002:a1c:cb43:: with SMTP id b64mr2120394wmg.86.1561541980070;
        Wed, 26 Jun 2019 02:39:40 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t140sm1761455wmt.0.2019.06.26.02.39.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 02:39:39 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Liran Alon <liran.alon@oracle.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH] x86/kvm/nVMCS: fix VMCLEAR when Enlightened VMCS is in use
In-Reply-To: <69274969-E2BE-442C-B2D2-0AF94338C31B@oracle.com>
References: <20190624133028.3710-1-vkuznets@redhat.com> <CEFF2A14-611A-417C-BC0A-8814862F26C6@oracle.com> <87r27jdq68.fsf@vitty.brq.redhat.com> <69274969-E2BE-442C-B2D2-0AF94338C31B@oracle.com>
Date:   Wed, 26 Jun 2019 11:39:38 +0200
Message-ID: <87k1d8d6sl.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liran Alon <liran.alon@oracle.com> writes:

>> On 24 Jun 2019, at 17:16, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>> 
>> 
>> That said I'm ok with dropping nested_release_evmcs() for consistency
>> but we can't just drop 'if (vmptr == vmx->nested.hv_evmcs_vmptr)’.
>
> Right. I meant that we can just change code to:
>
> /* Add relevant comment here as this is not trivial why we do this */
> If (likely(!vmx->nested.enlightened_vmcs_enabled) ||
>     nested_enlightened_vmentry(vcpu, &evmptr)) {
>
>     if (vmptr == vmx->nested.current_vmptr)
>         nested_release_vmcs12(vcpu);
>
>     kvm_vcpu_write_guest(…);
> }
>

The change, to my surprise, resulted in a set of L2 guest crashes. After
some debugging I figured out that clean fields is to blame: after
Windows does VMCLEAR it doesn't maintain clean field data before the
next VMLAUNCH - and nested_vmx_handle_enlightened_vmptrld() does nothing
in case evmcs_vmptr stays unchanged (so VMLAUNCH follows VMCLEAR on the
same vCPU). We apparently need to invalidate clean fields data on every
VMLAUCH. This is fix of its own, I'll do more testing and send v2.

-- 
Vitaly
