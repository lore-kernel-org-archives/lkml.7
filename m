Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3523C3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E35233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732421AbfHVIfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 04:35:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730987AbfHVIfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 04:35:18 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F7337FDF4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 08:35:18 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id 19so2642497wmk.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 01:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=503gwfkLwN2+9M3xVVSL4KHdkFSBybLeuL3BTe28L04=;
        b=C+Tfjq5SEsDSKXMn5sdnlOimC5TTiJq4EzoJiiKRMNb1J7gbMDeAHxQ0IvyrktluGt
         W+H2FZ/ydYp2SDeXWoFdUB3FfH0qL44nijHQMwTqRm8Cj7FJNgGyRKaByKxAjlo35/oD
         84SssSE6rjgvaj7xwGTa787gRhJ+aJwkYAdiwF+Qa3zlnTTGQv2OSPy0Ab+0GlLHNWvt
         NzJvbTvWIelmCPp++ytvHrTmecv2AU/auj1BIaVbKNeHGOQn2kAIuPYPzX5nyi+PcbPQ
         DvZqcfOvodL0F2w3tZfS6OVPskHdfB0xJJrHH1xFPT620ClXyJnkMxr5GgXXR2t77skn
         eaoA==
X-Gm-Message-State: APjAAAURpnhESPIxDsqnaxIxxekZidtXxTgYPCMrKS6XLxa9juy4UEVY
        +a0D/5WBPbNeqPWnNb6XMMLGEFWaQ8glX6WHgQPoYzm8AzPtf4dhvvjMyeomazAzahxCX9SSxu1
        DPIrsiAYF0b+icWVepmNADiVz
X-Received: by 2002:adf:ba4a:: with SMTP id t10mr44274891wrg.325.1566462916909;
        Thu, 22 Aug 2019 01:35:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwy4qQ9wEFJUUnOh9sHeQbZqx7L5OjVN+mhbTK5RA/hJKA8heXCGy6dfXj4prjORXC40B78Sg==
X-Received: by 2002:adf:ba4a:: with SMTP id t10mr44274867wrg.325.1566462916663;
        Thu, 22 Aug 2019 01:35:16 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id j17sm20375395wru.24.2019.08.22.01.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2019 01:35:15 -0700 (PDT)
Subject: Re: [PATCH v4 1/6] KVM: Fix leak vCPU's VMCS value into other pCPU
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        "# v3 . 10+" <stable@vger.kernel.org>
References: <1564970604-10044-1-git-send-email-wanpengli@tencent.com>
 <9acbc733-442f-0f65-9b56-ff800a3fa0f5@redhat.com>
 <CANRm+CwH54S555nw-Zik-3NFDH9yqe+SOZrGc3mPoAU_qGxP-A@mail.gmail.com>
 <e7b84893-42bf-e80e-61c9-ef5d1b200064@redhat.com>
 <CANRm+CzJf9Or_45frTe9ivFx9QDfx6Nou7uLT6tm1NmcPKDn8A@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <728bf051-02eb-8fe8-042f-9893f23b4a68@redhat.com>
Date:   Thu, 22 Aug 2019 10:35:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CANRm+CzJf9Or_45frTe9ivFx9QDfx6Nou7uLT6tm1NmcPKDn8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/19 02:46, Wanpeng Li wrote:
> On Tue, 6 Aug 2019 at 14:20, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 06/08/19 02:35, Wanpeng Li wrote:
>>> Thank you, Paolo! Btw, how about other 5 patches?
>>
>> Queued everything else too.
> 
> How about patch 4/6~5/6, they are not in kvm/queue. :)

I queued 4.

For patch 5, I don't really see the benefit since the hypercall
arguments are already traced.

Paolo
