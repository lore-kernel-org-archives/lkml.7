Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2801C43215
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 03:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D5A20714
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 03:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ep6UGdtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfKWDDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 22:03:24 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:39401 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfKWDDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 22:03:23 -0500
Received: by mail-il1-f194.google.com with SMTP id a7so9076799ild.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 19:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=2llGKEwGqv02JA/iBX+8mG7RLi4bNxYF08xd4XLsLD8=;
        b=ep6UGdtnlU/KZdTqxXNqm0FzL29oHDdirYk4Fc3SybTk4zz23nIC0y2M+TzIOtoB+1
         EBgutDulXFno8wkRsiSMqOf4JrVuVsjjO+br0kUtBtbPda7hCpJ5B/gM9c5YAR6fW3pN
         Ru/3l7SwaiXpg+AFO1AxFQ2njVZJ4vy/bIs5kLhLVGra/NYBrtU/aCHGKUZMQV3214nu
         wVje/GBG1bTJLnUgdOM7pqNhn8X+tSy6tD/DPTEYbayyVCJ9UMOQr9Kaxz2sX+Q585+B
         Q0GsIL6LTzNQ1Hqi96qVQqhtExbH3lUyFsatcmJ6EhXcx6CDJHLhcUt7ISHlDcz+kAws
         s3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=2llGKEwGqv02JA/iBX+8mG7RLi4bNxYF08xd4XLsLD8=;
        b=BhmpZjiH1NAX/vjKmlZOS51zI4JwBxiws83O48B5f34xh0BfdTht9DGL5aKjAA1lbw
         JfYRVb7ekY0iik3TKPruZ7b87x+1qiguvmDJ2JIseGF0NKkExcMz9mqQICeU/8fgjreh
         f8u39LIyGdZlIqHwNb9XCzy1IKsgbh//ntqGh9GZq2w3JxkOFAtxOwXDXLjeMPg7Wov7
         fZL2VY5XM3NKeAbOYjTTvLZRcwOFEkf90DeGpcoBDR8iCe775iQcCyng49VGJrr6OIKN
         9uZ8XEsaNO2KxZ8WX4WtbA/lvnb5P5QvVgaU79n18wMYIjza4XLQYRVyOOckBkKGPwUf
         bW5A==
X-Gm-Message-State: APjAAAXIL0PXvaB6hVBi5e8goeFHmOMTERDPDE3rig/sK9mMcN9XJ7Ze
        0g++wnNXkE9BxWxVu5zK/73TYA==
X-Google-Smtp-Source: APXvYqyflPBOhrUhlsM4NKxHbLsbeWUNItVw1cZNZ7q1pxHf4aG881IEeLsmwO9inXyKq5ciJSUL9A==
X-Received: by 2002:a02:c4cd:: with SMTP id h13mr17996512jaj.33.1574478203111;
        Fri, 22 Nov 2019 19:03:23 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id r17sm3612636ill.19.2019.11.22.19.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 19:03:22 -0800 (PST)
Date:   Fri, 22 Nov 2019 19:03:20 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Anup Patel <Anup.Patel@wdc.com>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Anup Patel <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: Enable SYSCON reboot and poweroff drivers
In-Reply-To: <20191111133421.14390-1-anup.patel@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1911221901320.490@viisi.sifive.com>
References: <20191111133421.14390-1-anup.patel@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2019, Anup Patel wrote:

> We can use SYSCON reboot and poweroff drivers for the
> SiFive test device found on QEMU virt machine and SiFive
> SOCs.
> 
> This patch enables SYSCON reboot and poweroff drivers
> in RV64 and RV32 defconfigs.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

Sounds like Christoph isn't planning to follow up on his reset driver.  
So this patch looks OK to me, as far as QEMU is concerned.  Still it seems 
best to avoid SYSCON for real hardware as much as possible, so, will plan 
to apply this after CONFIG_SOC_VIRT support lands.

thanks,

- Paul
