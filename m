Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00497C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10EA217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfE1Rrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 13:47:53 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42429 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfE1Rrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 13:47:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id go2so8626671plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 10:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=yQ0wPLtkdAzUq5XjJlbPIX/NMo5+U32U+TCJOUeQptg=;
        b=TBovtBygk+ZIlkYKe37NadbVTUbqn3G4NcMMu/UzUF20xllryQ0Hi2MDc6/G3NcWax
         BBsuadPOwqvXqdCF/xtS0bEAz434edl0DhG7wovwxyEQvJfGQNIhYFCMTKPeUGwGTUVf
         PFBrIS+MMXD8WfLVKr5h3qC57QzkJs0yuhJ9beEUitnzZpE5yY73kRkV3UfPRP2ex4Oa
         /IsYJgtMttiRpjucb6r8qiPiAcTHuD44l/aiVT79fZ7FX9KcBcJCHopXs3CSIm+4SNUJ
         pG6pgLMZO2GZW4yEWYHccpEB7X07asUO8JzQ8put2923bFyn9MbsNUDY4BuMYVVjafCM
         ck8Q==
X-Gm-Message-State: APjAAAVRAv5zzfyrhDj9BFQSHTuBNkoi8V706J4gg8CSbAmS4ZkLFB6w
        DzyaRn2N9MeTbIemmjDq43d05g==
X-Google-Smtp-Source: APXvYqzqUp9mZrKkwVeBMEF04LcIL97F2p9K1BbOvKaRPaeqWYNzhaM6QsYL3PqLaC3AC8ackdjoMA==
X-Received: by 2002:a17:902:1126:: with SMTP id d35mr101551544pla.82.1559065671746;
        Tue, 28 May 2019 10:47:51 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id d9sm12944666pgj.34.2019.05.28.10.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 10:47:51 -0700 (PDT)
Date:   Tue, 28 May 2019 10:47:51 -0700 (PDT)
X-Google-Original-Date: Tue, 28 May 2019 10:47:49 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: defconfig: Enable NO_HZ_IDLE and HIGH_RES_TIMERS
In-Reply-To: <CAAhSdy3GqjS06QxCtY6OUkBZds4gygQsAkaoaa+sMj3z6qgUBQ@mail.gmail.com>
CC:     Anup Patel <Anup.Patel@wdc.com>, aou@eecs.berkeley.edu,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org, Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <mhng-2b0ca072-2d6d-4422-96a2-2a4254255cc6@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2019 01:05:22 PDT (-0700), anup@brainfault.org wrote:
> On Wed, May 15, 2019 at 12:00 PM Anup Patel <Anup.Patel@wdc.com> wrote:
>>
>> This patch enables NO_HZ_IDLE (idle dynamic ticks) and HIGH_RES_TIMERS
>> (hrtimers) in RV32 and RV64 defconfigs.
>>
>> Both of the above options are enabled by default for architectures
>> such as x86, ARM, and ARM64.
>>
>> The idle dynamic ticks helps use save power by stopping timer ticks
>> when the system is idle whereas hrtimers is a much improved timer
>> subsystem compared to the old "timer wheel" based system.
>>
>> This patch is tested on SiFive Unleashed board and QEMU Virt machine.
>>
>> Signed-off-by: Anup Patel <anup.patel@wdc.com>
>> ---
>>  arch/riscv/configs/defconfig      | 2 ++
>>  arch/riscv/configs/rv32_defconfig | 2 ++
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
>> index 2fd3461e50ab..f254c352ec57 100644
>> --- a/arch/riscv/configs/defconfig
>> +++ b/arch/riscv/configs/defconfig
>> @@ -1,5 +1,7 @@
>>  CONFIG_SYSVIPC=y
>>  CONFIG_POSIX_MQUEUE=y
>> +CONFIG_NO_HZ_IDLE=y
>> +CONFIG_HIGH_RES_TIMERS=y
>>  CONFIG_IKCONFIG=y
>>  CONFIG_IKCONFIG_PROC=y
>>  CONFIG_CGROUPS=y
>> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
>> index 1a911ed8e772..d5449ef805a3 100644
>> --- a/arch/riscv/configs/rv32_defconfig
>> +++ b/arch/riscv/configs/rv32_defconfig
>> @@ -1,5 +1,7 @@
>>  CONFIG_SYSVIPC=y
>>  CONFIG_POSIX_MQUEUE=y
>> +CONFIG_NO_HZ_IDLE=y
>> +CONFIG_HIGH_RES_TIMERS=y
>>  CONFIG_IKCONFIG=y
>>  CONFIG_IKCONFIG_PROC=y
>>  CONFIG_CGROUPS=y
>> --
>> 2.17.1
>>
>
> Hi All,
>
> Any comments on this one?
>
> @Palmer, It would be nice to have this in Linux-5.2

My only issue here is testing: IIRC last time we tried this it ended up causing
trouble.  I'm in the process of switching to Yocto right now for my tests, so
it'll be a bit slow.
