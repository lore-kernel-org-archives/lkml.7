Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3939C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8898621852
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VO8JDuiY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfKTIEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 03:04:16 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41050 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfKTIEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 03:04:15 -0500
Received: by mail-io1-f68.google.com with SMTP id r144so26566131iod.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 00:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=BacJ7EBR9ytS2/6OwHcGzjIg710Zu5B5M5aCR72bJWA=;
        b=VO8JDuiYDFx9cSL5SqJK3STzGgAjyrHydkFR2rL2wLLXNbBFnDHTepn7fMtUJpbe4E
         obnzLYzJIX2DCUk7C9YHLXU+G/1wcpLygGrJzo4jNx1u9lQjIztdjytuGSy8eYhTw7xO
         FJAdNaw27IoeGn1j3JYhZNcTVl1HUxjR62WpPXz9x2KYxe+Wh7ujofcnk4UlKbm9EThJ
         4ltquqg9ml2N8qlVXt26KMAokZAyaFR0pjwaQmFfZC5vVWS5bnQ/9I+2WYKOL5KpV6vj
         L44Q1Om9Kbq0JPnB6E0RsIhuJOl9iQ+syl0zVUoU/MXq4vVI6t+72g1afJuZlmB060iZ
         a+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=BacJ7EBR9ytS2/6OwHcGzjIg710Zu5B5M5aCR72bJWA=;
        b=dDgk202UntEOziawzinWKqADj/8xi19lbEwjKhbwCFBHwdjxL/KKUYFzJelYC+mi/4
         tVII0QXOCBcyz+l08Gg5P1gGECGmAF9fb1+NE69Fvdllxi5aWNhl85nUINrNjp72HqCX
         4rHIfa6nKjub3oONilA8ctLLYYFlFdGE2cesjuKGOZVpt4QHsRwhG94swvUWfzuqH0gq
         FJjZHvv2pDp2Sg9U3p0+avljrKO7YG2TebTJbebjf+qoBwFXvSRS949HVN8VcvpaDH2v
         ild5wBrRClUEmC8nXCE1mZP4pNn3T78uxOdnRPCZnxE0ytOY2OCoCr1obk4TfE0Jg/MY
         JV5Q==
X-Gm-Message-State: APjAAAXYgW5FLHC1IZA5H2C9ydc8ijdF6N8Nz5rX6EvJt7vSiEgNOBJo
        PBjM3t5SV5M5nDAhQ1O+t7q39A==
X-Google-Smtp-Source: APXvYqy+717NLJlVd20jJMYLKR/1De7mJqNFF+/oYOiwoN3AGBAq1ytMXqic/gdugH11qYE0ztUcQg==
X-Received: by 2002:a5e:a70e:: with SMTP id b14mr1088130iod.166.1574237054759;
        Wed, 20 Nov 2019 00:04:14 -0800 (PST)
Received: from localhost (67-0-26-4.albq.qwest.net. [67.0.26.4])
        by smtp.gmail.com with ESMTPSA id a11sm6274182ilb.72.2019.11.20.00.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 00:04:14 -0800 (PST)
Date:   Wed, 20 Nov 2019 00:04:13 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Anup Patel <Anup.Patel@wdc.com>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim K <rkrcmar@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Graf <graf@amazon.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Anup Patel <anup@brainfault.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 03/22] RISC-V: Add initial skeletal KVM support
In-Reply-To: <20191016160649.24622-4-anup.patel@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1911200002310.490@viisi.sifive.com>
References: <20191016160649.24622-1-anup.patel@wdc.com> <20191016160649.24622-4-anup.patel@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 16 Oct 2019, Anup Patel wrote:

> This patch adds initial skeletal KVM RISC-V support which has:
> 1. A simple implementation of arch specific VM functions
>    except kvm_vm_ioctl_get_dirty_log() which will implemeted
>    in-future as part of stage2 page loging.
> 2. Stubs of required arch specific VCPU functions except
>    kvm_arch_vcpu_ioctl_run() which is semi-complete and
>    extended by subsequent patches.
> 3. Stubs for required arch specific stage2 MMU functions.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Alexander Graf <graf@amazon.com>

Olof's autobuilder found an issue with this patch (below)

> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
> new file mode 100644
> index 000000000000..9459709656be
> --- /dev/null
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -0,0 +1,81 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

This should be

/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */

to match the license used in the kvm.h files in other architectures.


- Paul
