Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305D0C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D06206DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="L/w7YB1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfGXUeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:34:08 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35245 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbfGXUeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:34:07 -0400
Received: by mail-io1-f66.google.com with SMTP id m24so92482619ioo.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 13:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=Xe754XdQFiMOz0DCn2UE7HYtLMDtwZfqOEnlJWYqqBE=;
        b=L/w7YB1g6rwLdJCd50raJQe5EjeHMw7jN5fwyaUcTUOYeTAIjT5z8dRsGkpb9Ol2mY
         IFuF5D1EFmHtnxp3LiRFBs3vfb0FwoZ/doQpjGN9NW8FGdJNkAUi4nsqr7KpN8+/etZr
         IKN7miGwPezunChdFgIZT2Pngv+Uticzot8pgU53X+B+p5lrhrn3md7zeHrDUr2hsckO
         ecYYzb9pXECvU5upoNFpVZzSImg54xvgBUMrsLXrvRLMnbE2ZHYbsQjZhmAzlSHd/dKh
         LCQABnH2e1w7JEcbSbGl1OiDs3LWQsur0qqLogMN2xGfdQe3KxTL1iqO9rHfsGlsOzMl
         wC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=Xe754XdQFiMOz0DCn2UE7HYtLMDtwZfqOEnlJWYqqBE=;
        b=FkFIzlw/9Fypk2Ri5akQI3pU+YjSQeU0XXVVFkyHdoPolYv4P57yOo3nms1RAXJtph
         y/mnq0jX3XXgDMKOY5f99Nw1QkxlYpEVnHrxMw3hCndKHuMQjy+odc7CJ+QoRh5SprY8
         /1trg849tdsMD2qF2SDmhq8kAhwx5BW5wyLF8ZhMrI0UnWuwkh07YTzGYwyjLdAngU/t
         20tE7O3ClO/fyxaIQwj2u/TGY1iDiHAJDHyoYNYHVnL+s6Fj2MsMHvyxn6F7iCzBIn6C
         NCG9ijNL/jPqfq807AZNveFReUy3WBkOTz0C3TTKhe5RJiHq2fGNGdx+QH31rLGevfK1
         Wmqw==
X-Gm-Message-State: APjAAAVWxpTyBCNYLBJcJQDu6b8CYORO0/2JOUWuPZZ8Xvdr3/psru3M
        rnQVLoAKnA6Zu34IaDQhSI3TKTUUFeE=
X-Google-Smtp-Source: APXvYqwO+v2VYplsQ/5ClrTxQxYoVRVi+nuWq0G66IWyPpRGjCRkod5Qu66H/jszMP3KqY9o82uJ0Q==
X-Received: by 2002:a6b:6d08:: with SMTP id a8mr69878303iod.191.1564000445971;
        Wed, 24 Jul 2019 13:34:05 -0700 (PDT)
Received: from localhost (67-0-24-96.albq.qwest.net. [67.0.24.96])
        by smtp.gmail.com with ESMTPSA id c23sm39477798iod.11.2019.07.24.13.34.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 13:34:05 -0700 (PDT)
Date:   Wed, 24 Jul 2019 13:34:03 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     torvalds@linux-foundation.org
cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [GIT PULL] RISC-V updates for v5.3
Message-ID: <alpine.DEB.2.21.9999.1907241331250.28120@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

I inadvertently based these changes on the commit immediately 
preceding the v5.3-rc1 tag, rather than the v5.3-rc1 tag itself.  Let me 
know if you'd like us to rebase them.


- Paul


The following changes since commit 3bfe1fc46794631366faa3ef075e1b0ff7ba120a:

  Merge tag 'for-5.3/dm-changes-2' of git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm (2019-07-18 14:49:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.3-rc2

for you to fetch changes up to 26091eef3c179f940d2967e9bef6e22c9e1c445f:

  riscv: dts: Add DT node for SiFive FU540 Ethernet controller driver (2019-07-22 14:49:31 -0700)

----------------------------------------------------------------
RISC-V updates for v5.3-rc2

Four minor RISC-V-related changes for v5.3-rc2:

- Add support for the new clone3 syscall for RV64, relying on the
  generic support

- Add DT data for the gigabit Ethernet controller on the SiFive FU540
  and the HiFive Unleashed board

- Update MAINTAINERS to add me to the arch/riscv maintainers' list

- Add support for PCIe message-signaled interrupts by reusing the
  generic header file

----------------------------------------------------------------
Palmer Dabbelt (1):
      MAINTAINERS: Add Paul as a RISC-V maintainer

Paul Walmsley (1):
      riscv: enable sys_clone3 syscall for rv64

Wesley Terpstra (1):
      riscv: include generic support for MSI irqdomains

Yash Shah (1):
      riscv: dts: Add DT node for SiFive FU540 Ethernet controller driver

 MAINTAINERS                                         |  1 +
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi          | 15 +++++++++++++++
 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  9 +++++++++
 arch/riscv/include/asm/Kbuild                       |  1 +
 arch/riscv/include/uapi/asm/unistd.h                |  1 +
 5 files changed, 27 insertions(+)
