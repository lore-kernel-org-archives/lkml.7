Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDE3C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 02:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6BB23429
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 02:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZpoWEnNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfHaCcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 22:32:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37526 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbfHaCcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 22:32:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id y9so5733747pfl.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 19:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=FBpAnnmFSQN+uWiLL2/GrqwNrDFmIljLv+JtnhGF5Sw=;
        b=ZpoWEnNQU8H5ZKyt08S1tNqhM92cHgG1vmOz52sCpNxvSSQGGXfsESroJULNQ8q0JC
         RxjP6qaM6Wdqg0858t9xNpKLfsSc6rYmWO88H0RYgVrFw/7p3VKUcKjpiRiGQHansYWl
         9RTDBZH5d6J0QdFsMeL3CWFDBeUIkvWPShJQ97N3yevT/Gc2PrWbjLB5EQ91nGlavMaK
         rZnYmkUFgjAMzAckgrcJ5i0KiZzUXx6TgNUqFhWbw8cTM4xy1dQr7HcPrXmCj3s0ZqO7
         0DnIMdBwaCuIS+z2OuKjw0+VT55Cn22JZQ8GbIRJQFkBqJlfO51Sl5cf7FFH3dXEUhtb
         Vtpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=FBpAnnmFSQN+uWiLL2/GrqwNrDFmIljLv+JtnhGF5Sw=;
        b=Ut/XBgBKSbF8yGCO6SOJhCiUto4EaKPgPJbNHooETuGS3tmKvYzMxBEZNp/0jySMlW
         Og43xJM/vRI1VsTo6YgfhSkFUq5mq9ldegjE4BqT4sOR1CpnW9juinSSl7f9X1XZpMbD
         L5AdZOXY6Y3FgYFcicp+2unBazVARHNZFpek58swf7CAjoAaV5Q4h2YodqLt0QNO2qTG
         2dxNmiD5z968/vmkK58FnS1gmgG3cSDa8wlAX2d8p6qqyRhwVA8i/wK4F0OloLpaSSZz
         iFbCAmm9oFrorv4fHZmLs5BH1sCCkxmLnifmWJEdKtbZP5YLZbWNvfSnipogP9dzMJWn
         pWGg==
X-Gm-Message-State: APjAAAWJaqGZwzW/qRFzbudKzpuU/bHqdNInOZfcgkFxpo7vjByIw8Zn
        J0+IqoVHnIvAMiEBrngVvW3rfQ==
X-Google-Smtp-Source: APXvYqyI9inCd1df02N4PqNj0BWfnV1BgA+8YV6J4CbPMAGIwTTR8//GTnbP50aeqaDLYIzZdGo/qw==
X-Received: by 2002:a65:500a:: with SMTP id f10mr15415728pgo.105.1567218720386;
        Fri, 30 Aug 2019 19:32:00 -0700 (PDT)
Received: from localhost ([216.9.110.7])
        by smtp.gmail.com with ESMTPSA id a16sm9677276pfo.33.2019.08.30.19.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 19:31:59 -0700 (PDT)
Date:   Fri, 30 Aug 2019 19:31:58 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     torvalds@linux-foundation.org
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RISC-V updates for v5.3-rc7
Message-ID: <alpine.DEB.2.21.9999.1908301929460.8525@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit a55aa89aab90fae7c815b0551b07be37db359d76:

  Linux 5.3-rc6 (2019-08-25 12:01:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.3-rc7

for you to fetch changes up to a256f2e329df0773022d28df2c3d206b9aaf1e61:

  RISC-V: Fix FIXMAP area corruption on RV32 systems (2019-08-28 15:30:12 -0700)

----------------------------------------------------------------
RISC-V updates for v5.3-rc7

One significant fix for 32-bit RISC-V systems:

- Fix the RV32 memory map to prevent userspace from corrupting the
  FIXMAP area.  Without this patch, the system can crash very early
  during the boot.

----------------------------------------------------------------
Anup Patel (1):
      RISC-V: Fix FIXMAP area corruption on RV32 systems

 arch/riscv/include/asm/fixmap.h  |  4 ----
 arch/riscv/include/asm/pgtable.h | 12 ++++++++++--
 2 files changed, 10 insertions(+), 6 deletions(-)

