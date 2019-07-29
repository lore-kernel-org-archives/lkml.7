Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC630C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89567205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389227AbfG2Tkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:40:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32899 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389211AbfG2Tkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:40:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so63227845wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 12:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZgugjlZTeEEE0y6ZY8Fe7n+SwxVvrWXZp+43yEbz1Lw=;
        b=qAvPLQ/aVSyf4FOj7h4kXae4dw+cEkJlxL3X7smkLeWTAVBXi39rRcakfcAP/GT8Kb
         15/YJaCECeLVppeiVdExgZU3NaE7vT/PjkE9cIknQQ3PhYlpvU/3qaAk8YjGnwS6HUQs
         FtRkLUxnfiTN/t+8QpotSRVoUY18V/yVDQXYaJ8FzOx0JfAwITsLhN4OQkGqVPizZtBs
         q1WcaOnXKPEoX2iJvhsV2xJUE7lKPyGB1uRUtzc+hJyA5bleJYEGOejFPEyuUodIgdsI
         lapow/il+e0dGSF/Fteu7SxnLSsB0TlKqdHxtTM5ELhr1fC4ma5/Ih9EMzVm6cguciUU
         c1bA==
X-Gm-Message-State: APjAAAUOPN/iU8Ae8822TvwbGz5YUAzNnOpYwLVuLNWzzzn3jtupL1Uz
        eio0/pt/MGuhDfnXeiCbr5EYaRgh6JY=
X-Google-Smtp-Source: APXvYqztxhuL0SbDbz8vPIEpjg5swquwVED7MQQUtvXwCf8LmsIfLWHOThEiOBoLm/Omt/wkMP0pWw==
X-Received: by 2002:adf:ce82:: with SMTP id r2mr44441848wrn.223.1564429244726;
        Mon, 29 Jul 2019 12:40:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29d3:6123:6d5f:2c04? ([2001:b07:6468:f312:29d3:6123:6d5f:2c04])
        by smtp.gmail.com with ESMTPSA id v16sm46139077wrn.28.2019.07.29.12.40.43
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 12:40:43 -0700 (PDT)
Subject: Re: [RFC PATCH 15/16] RISC-V: KVM: Add SBI v0.1 support
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
 <20190729115544.17895-16-anup.patel@wdc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b461c82f-960a-306e-b76b-f2c329cabf21@redhat.com>
Date:   Mon, 29 Jul 2019 21:40:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729115544.17895-16-anup.patel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/19 13:57, Anup Patel wrote:
> +	csr_write(CSR_HSTATUS, vcpu->arch.guest_context.hstatus | HSTATUS_SPRV);
> +	csr_write(CSR_SSTATUS, vcpu->arch.guest_context.sstatus);
> +	val = *addr;

What happens if this load faults?

Paolo
