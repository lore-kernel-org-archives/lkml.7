Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E198DC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCB921A4C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Z1jp9Kab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731053AbfISHyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 03:54:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32946 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730118AbfISHyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 03:54:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id n190so1426184pgn.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 00:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=lgSTmC+c9Vj9bE5WscDijHkLpjdSHeo7iIoLFicI/Ow=;
        b=Z1jp9KabrnEgSNSQRJQKgxItKQkZ0/OIvbBIwjm00LGww/v2HjW0V63QhVE7ZwlBRX
         +EObeLsxlxsluz6Sztq/BAUExQKy43X15vIHT9Al+hEqIfpISO5p9SMCxb3WLR0f2Jo2
         cU6EObsPrgdOMm7vdyGLMl0QOluFlRfJewkDMd4XNSb9+nwZ3pDJZ83w/oDnNprGQir1
         /zOdCpNfrZTXVAGpDZRkz1HrDawz8qteJV+6JHcuAsFz8hGTRZbfSg7WwHsDiG2IW0d8
         ioRL7h9rj5wweNHTpuBRtn3TyozMsEyHRxgIEkkCF1BaBrkNpcdoH5yQFM6Qd78DA4vo
         /QEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=lgSTmC+c9Vj9bE5WscDijHkLpjdSHeo7iIoLFicI/Ow=;
        b=ublZRHD+QAjEL5zzce2oF1uJg3TJIISS9FiJjSC+dApY3pAPSleBn2S+pFZLyKelLy
         rbiV1DFEKl3u/9GZTkEZufZLo6u25nsyKXkHz0gWGW2LaXaJKEa6r5AbVNLheyMJZ88z
         txuWYVcgSF5AUU2H40Fp6xLhRYINXFGv4sb4UueP3Vekx5qXpvmzaA3eRUdELc033jBc
         xziM2MgmQ+M3CG2hDWXW+DQg4ojRlhdFpB5hTl4d+QjkG+RhgIWlR/9DRZwqnETees/y
         bjZ2beYrGHxuFzZneC+cLu841e2UO0iqv2+NVC6pju8GLGO8AStIMu4MLBhzCTxBesBt
         742A==
X-Gm-Message-State: APjAAAXlhvAWU7BZMX/SEtE0wAMWfrA+cLNm0sb7eJy0ZvnUtNOBpG4Q
        31+fW1AdrPlD07jauaV34PTpuw==
X-Google-Smtp-Source: APXvYqyZ1YfxJWZc/POGGnlnuSTSDOy5NhfymPV72q6hKL8KbUZaRUFsYbqH+mFYjWl6fs6PCi1YJA==
X-Received: by 2002:a62:1888:: with SMTP id 130mr8993763pfy.72.1568879682508;
        Thu, 19 Sep 2019 00:54:42 -0700 (PDT)
Received: from localhost (57.sub-174-194-139.myvzw.com. [174.194.139.57])
        by smtp.gmail.com with ESMTPSA id z12sm14193738pfj.41.2019.09.19.00.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 00:54:42 -0700 (PDT)
Date:   Thu, 19 Sep 2019 00:54:38 -0700 (PDT)
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
Subject: Re: [PATCH v7 20/21] RISC-V: Enable VIRTIO drivers in RV64 and RV32
 defconfig
In-Reply-To: <20190904161245.111924-22-anup.patel@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1909190054230.28444@viisi.sifive.com>
References: <20190904161245.111924-1-anup.patel@wdc.com> <20190904161245.111924-22-anup.patel@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2019, Anup Patel wrote:

> This patch enables more VIRTIO drivers (such as console, rpmsg, 9p,
> rng, etc.) which are usable on KVM RISC-V Guest and Xvisor RISC-V
> Guest.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Alexander Graf <graf@amazon.com>

Thanks, queued for v5.4-rc.


- Paul
