Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3189C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6402083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HsDX4JA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbfDJRNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:13:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43003 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbfDJRNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 13:13:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id p6so1927590pgh.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 10:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Loqo+ptgBIvQDOyaYvUe0ENLtUskQ9SIaVhe8fwBwp4=;
        b=HsDX4JA03d1+AsAao3WS+PUZr78vdmDtUUzkzxcSROPWrLn8Eb5FR6bTS7gfyX5Se6
         RXHmdSe3i63QH2Uwlc9iWjE2Kb/d+LZwYbiOVxuKvA8EzwkNnof6CPlbrPFGibCBkFp7
         hWnq88og4FTXpEaqx+7oGp51vE2yGyxdwHHhb5UruwL0+wyypViTL9hRTLxGBkBlBe5Z
         5qT13he4my6y/dxSEoIJLSHUik1uC5kGXGYiTwTTRDvnF0GApKaxPmfeOIMK+mweN1/G
         s+svurRAIhhqAOxphSjjmWi/Xc3BUERxrjVzN9O04aDqqGb7V3Bqxtvxuq7qAhEEzT5v
         jJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Loqo+ptgBIvQDOyaYvUe0ENLtUskQ9SIaVhe8fwBwp4=;
        b=a4g1PV/LFo4yWKCfAo9xEqeLLk3WQ74RYeL8DSLzztaElp8X/8+FkWzVSqYqYY8Ga4
         uOw/UcjlzyCSyuIQJDa2L+4/YEjSe0CtvzXdAAwKQSJvspabh7wDxQfW4hUD+TjEpEDs
         ipnXNuKvVb5zGiNFOVhGcKeoL7r9//nK6HBYavw2e94YmnKfkFLC8RKH3Xcu/CvwNnrM
         z6YAU6YU1DTEE9ssjs0HbplCVIR5wKjADle0UfujiQAJHlNhmcOG38zLeTVG8fHhsDYD
         KleER5L/YCxTZ92X/dk75iQcB0H93Lxqs+gfZsJgYWkt2F0zzPEWrgjXHSfUQH/Hblw6
         tkqg==
X-Gm-Message-State: APjAAAVouHbrFgQFnA/GrY2aYRrdI/q3ccFxugE5y0zKJnq3jtpCEisC
        V735/xo98Trr2sTric6ZwrjzWQ==
X-Google-Smtp-Source: APXvYqy4kxmphmV7146MvOIJc2ridXyRqNiZXhX/zaBHLyntGjsvpeu6HO/0SDWusydyn5LL7KjkBw==
X-Received: by 2002:aa7:85cc:: with SMTP id z12mr44427095pfn.142.1554916415354;
        Wed, 10 Apr 2019 10:13:35 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id j62sm35138150pfg.6.2019.04.10.10.13.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 10:13:34 -0700 (PDT)
Date:   Wed, 10 Apr 2019 10:13:34 -0700 (PDT)
X-Google-Original-Date: Wed, 10 Apr 2019 09:43:10 PDT (-0700)
Subject:     Re: [PATCH 1/3] RISC-V: Add separate defconfig for 32bit systems
In-Reply-To: <CAAhSdy1UZ3VZAa+Gtf0KQUY9Ebwm7p=qAB+Xv7HDAjfUYpFuAQ@mail.gmail.com>
CC:     Anup Patel <Anup.Patel@wdc.com>, aou@eecs.berkeley.edu,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>, rppt@linux.ibm.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org
Message-ID: <mhng-291f78d2-5d90-4f44-8bbd-017264cd5be7@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Apr 2019 23:09:03 PDT (-0700), anup@brainfault.org wrote:
> On Tue, Apr 9, 2019 at 10:14 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Tue, 12 Mar 2019 15:08:12 PDT (-0700), Anup Patel wrote:
>> > This patch adds rv32_defconfig for 32bit systems. The only
>> > difference between rv32_defconfig and defconfig is that
>> > rv32_defconfig has  CONFIG_ARCH_RV32I=y.
>>
>> Thanks.  I think it makes sense to have this in 5.1 so I'm going to take it
>> into the next RC.
>
> Thanks, Palmer.
>
> Can you consider "[PATCH v3] RISC-V: Fix Maximum Physical Memory 2GiB
> option for 64bit systems" for 5.1?
>
> Refer, https://patchwork.kernel.org/patch/10886895/
>
> The above patch is also required for 64bit system with more than 128GiB memory
> (i.e. server-class system).
>
> We can remove "Maximum Physical Memory 2GiB" option as separate patch.

Ya, that should go in.  It's on the branch, thanks for the reminder!
