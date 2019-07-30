Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DF9C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD10206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbfG3Inz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 04:43:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46506 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbfG3Inx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:43:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so64767670wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 01:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OKR3QlVurOR6Gm48332ZWWebgWYH2Zh0VKVpzZimroE=;
        b=IG5AKR5nSXMeFyFXum9BfAv6VW7xOa0h/cQ1XTJXLPFlWYi/8J+JURJGQpXxHDeOm2
         w+lf4PuijhkzAEQjyNoUAVq+8EERq5fpoPbM5rMJ+XD4YVaOf7EWAxKZtuJohcS60+v1
         2skXnItJmAuS3nZ9nk3a3iQlxHgLkmA/ODbYMDgLwdaUdxri5qqeN999iPAJiwOrtoV5
         QNuA6Ua+2oCWsf9e8qhxDO5wr7FTQA1jc4Mocd81rZtZ9NuJxwUN6XvZkTKKbEej1Em7
         Hbz75LeB7vciWZmKCxJ5goNi8mUmpOEdFuHciL4o4Mt2t4cpw+Rk5/EZa2+yMlgW7MhP
         PlTQ==
X-Gm-Message-State: APjAAAULiPbknZIFq/ZE9SYA9JRCkMztQYzZxj976XEGbpHwzN40gnE9
        JSFBNAeWdn38wqJ0MdV3exsOe6sCfNc=
X-Google-Smtp-Source: APXvYqzgTuWikIL4H6O0gthhwCoTiNJf6weUuD0qK1XMCURLTfCQZKU3zgmP7+7VU5FOQIvoP3Pgnw==
X-Received: by 2002:adf:80e6:: with SMTP id 93mr88188887wrl.298.1564476231141;
        Tue, 30 Jul 2019 01:43:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29d3:6123:6d5f:2c04? ([2001:b07:6468:f312:29d3:6123:6d5f:2c04])
        by smtp.gmail.com with ESMTPSA id d10sm75314371wro.18.2019.07.30.01.43.49
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 01:43:50 -0700 (PDT)
Subject: Re: [RFC PATCH 06/16] RISC-V: KVM: Implement
 KVM_GET_ONE_REG/KVM_SET_ONE_REG ioctls
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
 <20190729115544.17895-7-anup.patel@wdc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3caa5b31-f5ed-98cd-2bdf-88d8cb837919@redhat.com>
Date:   Tue, 30 Jul 2019 10:43:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729115544.17895-7-anup.patel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/19 13:56, Anup Patel wrote:
> The PC register represents program counter whereas the MODE
> register represent VCPU privilege mode (i.e. S/U-mode).
> 

Is there any reason to include this pseudo-register instead of allowing
SSTATUS access directly in this patch (and perhaps also SEPC)?

Paolo
