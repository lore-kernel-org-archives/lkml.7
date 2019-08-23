Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B2CC3A5A5
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD95B21897
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405287AbfHWMK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 08:10:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403942AbfHWMKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:10:53 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7679461D25
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 12:10:53 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id x12so4743437wrw.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 05:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YmpuoFAf1JV9E3g21xDaHXmAHG9KWMG9xyLy+0tzG68=;
        b=is3gV9Q9In0FVKsbcFxIqG4PLtusE22UZrQVlxfvlD2pUpRSTdLCaN8rdeOw/q6sQx
         8pXBouH+2LN5zBvD1b6HyrSM5oLrTxBrhxIGKhAUjpsSx96ToLmpcccFDDh+au2/iKuK
         E+dF4Vkv1ptcmQLdhf3OgEQ5izIQqf1ekFbwXYRrfATo8ibMqiMMeMby8uJPFb1FSqNc
         Gco5+/0FWFYTMt4vUsuFGA0fCXRv3uyWQColntKkHkwRzgGq72uD7UYUpkfS/6YBYzAU
         t8RCXuZ3QJQFnKf2MaxTrGk6BQZIMOaIQB9tyahYHytKWWJ6lDULG2Mizx2tteLnTSlh
         g7aw==
X-Gm-Message-State: APjAAAVRiwjA5XhQgwqXz89Ostn7Qry31C9+iuhlt1l79CAyhQqNXgBX
        kLyeomMbwN3hkrymZuHnV82J31K91556slh2XLO3ACaB/G9f+xjZgFGHjiC6vj+ZH5MFYrGdbyS
        OscmZRAwSyPHvZWpcHUB2f/BD
X-Received: by 2002:a05:6000:1c8:: with SMTP id t8mr4657582wrx.296.1566562251954;
        Fri, 23 Aug 2019 05:10:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzyVxw1qUQIBTcRkSh95Cdl4gIPkdK+LHTRDd3Xtmfn2XR4EHjMMfyBhL3S7uHbsTcvuBxUtQ==
X-Received: by 2002:a05:6000:1c8:: with SMTP id t8mr4657537wrx.296.1566562251686;
        Fri, 23 Aug 2019 05:10:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4566:f1b0:32e7:463f? ([2001:b07:6468:f312:4566:f1b0:32e7:463f])
        by smtp.gmail.com with ESMTPSA id g197sm2205295wme.30.2019.08.23.05.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2019 05:10:51 -0700 (PDT)
Subject: Re: [PATCH v5 00/20] KVM RISC-V Support
To:     "Graf (AWS), Alexander" <graf@amazon.com>,
        Anup Patel <anup@brainfault.org>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Radim K <rkrcmar@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190822084131.114764-1-anup.patel@wdc.com>
 <8a2a9ea6-5636-e79a-b041-580159e703b2@amazon.com>
 <CAAhSdy2RC6Gw708wZs+FM56UkkyURgbupwdeTak7VcyarY9irg@mail.gmail.com>
 <757C929B-D26C-46D9-98E8-1191E3B86F3C@amazon.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <fda67a5d-6984-c3ef-8125-7805d927f15b@redhat.com>
Date:   Fri, 23 Aug 2019 14:10:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <757C929B-D26C-46D9-98E8-1191E3B86F3C@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/19 13:44, Graf (AWS), Alexander wrote:
>> Overall, I'm quite happy with the code. It's a very clean implementation
>> of a KVM target.

Yup, I said the same even for v1 (I prefer recursive implementation of
page table walking but that's all I can say).

>> I will send v6 next week. I will try my best to implement unpriv
>> trap handling in v6 itself.
> Are you sure unpriv is the only exception that can hit there? What
> about NMIs? Do you have #MCs yet (ECC errors)? Do you have something
> like ARM's #SError which can asynchronously hit at any time because
> of external bus (PCI) errors?

As far as I know, all interrupts on RISC-V are disabled by
local_irq_disable()/local_irq_enable().

Paolo
