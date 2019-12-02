Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4A1C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608582073C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a7pSC3sy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfLBXdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:33:00 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38041 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfLBXc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 18:32:56 -0500
Received: by mail-pf1-f193.google.com with SMTP id x185so658770pfc.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 15:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:in-reply-to:cc:to:message-id:mime-version
         :content-transfer-encoding;
        bh=9v4dAOFWeUoulcUWR2FPbEilDOjTg0ynLEW3tZkwRN0=;
        b=a7pSC3syJXJ/RzJ6cFp/GYto5jHycfrj8u1u8lC8a2c3lRWcXzc/QGsA82Guq3sXiR
         CDBqqCdc7lWYT05yWdZXwT5bdktUuATDSQZh/jUMgHzioXWa5wEi8U+9wLMGGBoBQqw2
         wBHbd7jcbJ27qOYKhb0NXTTzqAHc5RkYLNss8J/YwWWsuZ+ZjdpU0qUbDvpyxjsX2TTA
         TozvZASd16ZIGAzt7VrBP38+PHaSpC4aKre4cehhYbIJVkK2wUPPpROE7s13YIs6ee2Z
         84werYyTJ4AneJirfQwTqHVKQ82Ix/Bj/ZPs6wNMdn9HAi3to5IizNAEusVUPlGZKSKv
         xczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:in-reply-to:cc:to:message-id
         :mime-version:content-transfer-encoding;
        bh=9v4dAOFWeUoulcUWR2FPbEilDOjTg0ynLEW3tZkwRN0=;
        b=PP+hVyHaJnpVYtF8KvpxlQ/RGNAPdcPm4QGVPOdRr/5xkXKus9mSs8qbjdw1jLNniX
         yogGeQ+Nt9YCdOVsKkUAA6R8Nzjw8rDBeT9UbSyWTfra034cNnlK0jtaBY5/7VSvjkqs
         BFuUyuNsQBjaYYpDPAmhX2/lFve7PVMnhpbWQLQ5rbdZlGKRslUwjNdEvE+/SeIiSgb9
         e4aRlyjo/VMNxUCf28O2Ffn9WYy9wJ3CS8baAizVwmvVljBDXYCshMsrzmwh/V9P9t7h
         4RiIcye/hiRQnFPsJ2WPAwMwzLcvNPpyrMXWK6MLCP6RGT+dCqATnyBuaajNfmLtF+F7
         ZVOA==
X-Gm-Message-State: APjAAAWlc0lX7yYyJJwTN5AJdPx0NhzlpmnkQNLZatGUlXcaJPZlwyxn
        2TC77tkf/BAuUnIYAPf+QPjfv9Swj/M=
X-Google-Smtp-Source: APXvYqzsJlkbx6bHlCnEaOUxEXBTCoTlfxjxE47Wgg1nbutvA7Rhpy0/MWfBFr4TYzQFuyYc/+hSQg==
X-Received: by 2002:a62:447:: with SMTP id 68mr1399108pfe.70.1575329575638;
        Mon, 02 Dec 2019 15:32:55 -0800 (PST)
Received: from localhost ([2620:15c:211:200:12cb:e51e:cbf0:6e3f])
        by smtp.gmail.com with ESMTPSA id 16sm665895pgm.86.2019.12.02.15.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 15:32:54 -0800 (PST)
Date:   Mon, 02 Dec 2019 15:32:54 -0800 (PST)
X-Google-Original-Date: Mon, 02 Dec 2019 15:32:42 PST (-0800)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH 0/4] QEMU Virt Machine Kconfig option
In-Reply-To: <20191125132147.97111-1-anup.patel@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org, Anup Patel <Anup.Patel@wdc.com>,
        linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-2aaba21d-2b4a-45aa-9c76-809cb5b61e6c@palmerdabbelt.mtv.corp.google.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2019 05:22:13 PST (-0800), Anup Patel wrote:
> This patch series primarily adds QEMU Virt machine kconfig opiton and
> does related RV32/RV64 defconfig updates.
>
> This series can be found in riscv_soc_virt_v1 branch at:
> https//github.com/avpatel/linux.git
>
> Anup Patel (4):
>   RISC-V: Add kconfig option for QEMU virt machine
>   RISC-V: Enable QEMU virt machine support in defconfigs
>   RISC-V: Select SYSCON Reboot and Poweroff for QEMU virt machine
>   RISC-V: Select Goldfish RTC driver for QEMU virt machine
>
>  arch/riscv/Kconfig.socs           | 24 ++++++++++++++++++++++++
>  arch/riscv/configs/defconfig      | 17 +++--------------
>  arch/riscv/configs/rv32_defconfig | 18 +++---------------
>  3 files changed, 30 insertions(+), 29 deletions(-)

Thanks.

LMK if you're going to spin a v2 with the updated commit message.
