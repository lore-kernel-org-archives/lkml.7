Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED82C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D317206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbfG3I7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 04:59:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42986 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729594AbfG3I7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:59:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id x1so14943632wrr.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 01:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gAOqp4tzpeM+kc2yKMu7T8t6rZFmcQeUo4HHT+xzYZI=;
        b=J6n9eIEfMHvPGpGWSvhOBQNi05sXFiFjpHR7Pa0UqwFoJLbZeSBzETXL6ee/WTrMye
         WDDwb0LQ/5uu+0nxslV9Af7g4VlzEpSJKJ/JxlJtkQxEK9qcMgZAV8QKu6xkr3YlFR/m
         FUE9lmTUloN0Ati2sCZNYa6VmTltbrkCbE6Krauk48lCKoNmxkdTIMjxbCMrayrUOTyV
         HntYgUAxoJBG2Xqqbe5lOfZI8HvALjDYlxbG+5kwJ8lq2T+gXOig+xBeCp+FsfOMtynr
         CFiKQ2TWGGgULxTXWUoSIwJL/6hSLneES2OaR+YnNNRnCcvyPWJudyK3GeD/Zqv7HWTo
         lz3Q==
X-Gm-Message-State: APjAAAUF7ezRh7iosZXDNNfXG/01CpMo+Ikc+niAz5R+3j/BhBZSbjmd
        3BCHuCSBFttZX6Boiq/zuxJDxaZOr+c=
X-Google-Smtp-Source: APXvYqzhAPFkeeQBIg3SYU7j4ftAIiAkZA1CoW1Nhux1UtFgjCYh15jhOXBY/HRWgOoVtocpRAQlHA==
X-Received: by 2002:a5d:6182:: with SMTP id j2mr78631874wru.275.1564477149972;
        Tue, 30 Jul 2019 01:59:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29d3:6123:6d5f:2c04? ([2001:b07:6468:f312:29d3:6123:6d5f:2c04])
        by smtp.gmail.com with ESMTPSA id f10sm51137371wrs.22.2019.07.30.01.59.08
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 01:59:09 -0700 (PDT)
Subject: Re: [RFC PATCH 10/16] RISC-V: KVM: Implement VMID allocator
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
 <20190729115544.17895-11-anup.patel@wdc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4a99b586-a7bb-be3e-c47b-7809e6be610b@redhat.com>
Date:   Tue, 30 Jul 2019 10:59:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729115544.17895-11-anup.patel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/19 13:57, Anup Patel wrote:
> +	/* First user of a new VMID version? */
> +	if (unlikely(vmid_next == 0)) {
> +		atomic_long_inc(&vmid_version);
> +		vmid_next = 1;
> +

vmid_version is only written under vmid_lock, so it doesn't need to be
atomic.  You only need WRITE_ONCE/READ_ONCE.

> +
> +	/* Request stage2 page table update for all VCPUs */
> +	kvm_for_each_vcpu(i, v, vcpu->kvm)
> +		kvm_make_request(KVM_REQ_UPDATE_PGTBL, v);

Perhaps rename kvm_riscv_stage2_update_pgtbl and KVM_REQ_UPDATE_PGTBL to
kvm_riscv_update_hgatp and KVM_REQ_UPDATE_HGATP?

Paolo
