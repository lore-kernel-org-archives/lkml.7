Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67A5C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 21:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869A12086A
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 21:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SMl+5KtT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfHJVv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 17:51:58 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37511 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfHJVv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 17:51:58 -0400
Received: by mail-ot1-f67.google.com with SMTP id f17so10696289otq.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 14:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=BXzhJMcP8sUrbiDUCA84lEyIOcPFyZ1BvR0HhIB3IoA=;
        b=SMl+5KtTl/n9Ap142CBKocbUdrfTmsY30zKYh4Z6ioty7GXFoGlJTXcPy3/Of7D4FT
         xN67MbSWu9WhaedfinFmyl4/RuFsB6yxKlY/fL4YV3mVDtvxfv5dC4fBnI3wqDZz1LDY
         mAH6LQ6NJBDHkSCmO78vQ6VB6dqHBP/6/LZcsKrkrHTFiL5YnSSgqGmEhP8lFu5XRs5d
         ZABK7t1fRYaEZ0PlIfSYY4QYDY0jxLxL08Kjkx039Rwii1pfSzsXDyeyJG02qIbXVZ4D
         kXzJ+A3qM0JZZIvwbco4Ew0uA4KD1+bHgh2vOVRTBiPoLZ4uJYsfUhl9uuSoSLw+qoGd
         ypgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=BXzhJMcP8sUrbiDUCA84lEyIOcPFyZ1BvR0HhIB3IoA=;
        b=REVf0UwT1QoucFBB2Rn4eSb2W/yoBd5cuFEJhI5FTFrVY58co2f55fCOKoykISf1Y1
         lUEQf4C3A+5iqJxNuyAuvGhgBo7wAFP+xKfKcwkKD8uicnSiqMS3v8mhZqA8i0Zs8RgX
         JRl0RYXn91xvxoYCW7XFxZpFuLRxL7IiONdF8GpJ6Saki8Lq3Eji+GFlZ6m87f5bYUJ/
         ngXbJRNtHl6q9c537b6vb6svGW0YZrN+hyRybctcTIx/u1DkuUHpwKcqZVYn9Zc3P4zv
         Pj9+u5Q/M4B5cvvN+aVNhfDCCWqurq/45m8QMlRxivCzpvJmPEXzcvt2N0V1OBrWa2dE
         aFlw==
X-Gm-Message-State: APjAAAXPyyd7+OaxXsIA0QqOf529aG/jecTCQq741gJOr/Z694JRpa8k
        q7Iv7agJbLviyiQWypE1WN5CGw==
X-Google-Smtp-Source: APXvYqw975ALnEQ7gqJUAF1qVfME8rEeVeTWqcDdVogCmy40Ah4etxLC0gnFpyhMM3OYNIzP/TPLnw==
X-Received: by 2002:a02:c9d8:: with SMTP id c24mr8346028jap.38.1565473917462;
        Sat, 10 Aug 2019 14:51:57 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id k6sm8386344iob.11.2019.08.10.14.51.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 14:51:57 -0700 (PDT)
Date:   Sat, 10 Aug 2019 14:51:56 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     torvalds@linux-foundation.org
cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [GIT PULL] RISC-V updates for v5.3-rc4
Message-ID: <alpine.DEB.2.21.9999.1908101451050.22177@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit e21a712a9685488f5ce80495b37b9fdbe96c230d:

  Linux 5.3-rc3 (2019-08-04 18:40:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.3-rc4

for you to fetch changes up to b390e0bfd2996f1215231395f4e25a4c011eeaf9:

  dt-bindings: riscv: fix the schema compatible string for the HiFive Unleashed board (2019-08-08 16:05:38 -0700)

----------------------------------------------------------------
RISC-V updates for v5.3-rc4

A few minor RISC-V updates for v5.3-rc4:

- Remove __udivdi3() from the 32-bit Linux port, converting the only
  upstream user to use do_div(), per Linux policy

- Convert the RISC-V standard clocksource away from per-cpu data structures,
  since only one is used by Linux, even on a multi-CPU system

- A set of DT binding updates that remove an obsolete text binding in
  favor of a YAML binding, fix a bogus compatible string in the schema
    (thus fixing a "make dtbs_check" warning), and clarifies the future
      values expected in one of the RISC-V CPU properties

----------------------------------------------------------------
Atish Patra (2):
      RISC-V: Remove per cpu clocksource
      dt-bindings: Update the riscv,isa string description

Palmer Dabbelt (1):
      RISC-V: Remove udivdi3

Paul Walmsley (3):
      riscv: delay: use do_div() instead of __udivdi3()
      dt-bindings: riscv: remove obsolete cpus.txt
      dt-bindings: riscv: fix the schema compatible string for the HiFive Unleashed board

 Documentation/devicetree/bindings/riscv/cpus.txt   | 162 ---------------------
 Documentation/devicetree/bindings/riscv/cpus.yaml  |  16 ++
 .../devicetree/bindings/riscv/sifive.yaml          |   2 +-
 arch/riscv/lib/Makefile                            |   2 -
 arch/riscv/lib/delay.c                             |   6 +-
 arch/riscv/lib/udivdi3.S                           |  32 ----
 drivers/clocksource/timer-riscv.c                  |   6 +-
 7 files changed, 24 insertions(+), 202 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/riscv/cpus.txt
 delete mode 100644 arch/riscv/lib/udivdi3.S
