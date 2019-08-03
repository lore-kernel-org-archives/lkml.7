Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6B3C31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 14:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D80B2073D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 14:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MWNahO31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfHCOW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 10:22:27 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38741 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfHCOW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 10:22:27 -0400
Received: by mail-io1-f67.google.com with SMTP id j6so38756249ioa.5
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2019 07:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=+SFySWHmm4UbfytF/hIo7gNQJRXwrgC9uVAmtCspVNk=;
        b=MWNahO31L4f/fjhIguRqPGLj3CcevEAS+JmBUiYNJSbWsfzos/g4vEz4RU/+MWqwsW
         1u8aZ5Iy04L2wkDGSIyYNxs8aebr6RugGvwGQslWwp9VWiXKuQAM2ZCoa/JXRfJBlRG2
         hIHpCc2OKt/+oyPoMHhCeP51lxrhgoYEqo4CzK3lNieSpxYrbRYXgh1X6lfrdjVBC2wK
         awzgLSbWmkP1g3Sp5wdOWjsFtSRzAQLsY2TOCBllGzi2GfNrKZW7ytbGGQJwYFDgBvNf
         yZYOoncN5IexND8mqdAoP66/SliWb2wKF7YGOpxVxVhwnD42Ly2d5yYRyLXUUeFNMmHH
         PwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=+SFySWHmm4UbfytF/hIo7gNQJRXwrgC9uVAmtCspVNk=;
        b=OCs9AvKluy/K+4y9zAmQrTtawIKnBI7Mw9tbUjFSXy8+ou4B/FmtAiO7mjHKGveNCE
         0rb/XL65glQcsrZtyz8oMPO9BJjrFbOlyDs6LzsTEL6o/QtvoNRTXuDwMNXA/+ELKM/a
         +AU7IfWYaxllje/+rlc+2i/gpe5DAiEAFr0wF/PlL6N7Mph5eT5PfeYFDli/l1Id4aPw
         UqBHuyLrFj1Bc4cvwmqf/IJhJYMjpXOA4Zmb+J+ItisQBvjE66trz0N+mOHeHuKMVc0c
         Wl9cEAjwgH0cUIuzWKE9lRGavinnUfQJ0Gx9TGtgw5qleon5DvFtHK2wjmIRS9HWBxh3
         ZIwQ==
X-Gm-Message-State: APjAAAURlg4V2P2zH9qOIKxzwfhXPYXZvfVjGKPOivLVzO8ISdZBi/Xl
        W6hg7exK58LOjZ5EHC+83GCmW3h3His=
X-Google-Smtp-Source: APXvYqyq0xQ7FCCAQais7Dvc2x+AXN/25pbNDPArr3AzFzS/SJM4W2dzNvaJgBUdHKdad/5AfUC+Tw==
X-Received: by 2002:a02:230a:: with SMTP id u10mr63091978jau.117.1564842146406;
        Sat, 03 Aug 2019 07:22:26 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id v10sm74104437iob.43.2019.08.03.07.22.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 03 Aug 2019 07:22:25 -0700 (PDT)
Date:   Sat, 3 Aug 2019 07:22:25 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     torvalds@linux-foundation.org
cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [GIT PULL] RISC-V updates for v5.3-rc3
Message-ID: <alpine.DEB.2.21.9999.1908030720490.3783@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.3-rc3

for you to fetch changes up to b7edabfe843805b7ab8a91396b0782042a289308:

  riscv: defconfig: align RV64 defconfig to the output of "make savedefconfig" (2019-07-31 12:26:10 -0700)

----------------------------------------------------------------
RISC-V updates for v5.3-rc3

Three minor RISC-V-related changes for v5.3-rc3:

- Add build ID to VDSO builds to avoid a double-free in perf when
  libelf isn't used

- Align the RV64 defconfig to the output of "make savedefconfig" so
  subsequent defconfig patches don't get out of hand

- Drop a superfluous DT property from the FU540 SoC DT data (since it
  must be already set in board data that includes it)

----------------------------------------------------------------
Mao Han (1):
      riscv: Fix perf record without libelf support

Paul Walmsley (2):
      riscv: dts: fu540-c000: drop "timebase-frequency"
      riscv: defconfig: align RV64 defconfig to the output of "make savedefconfig"

 arch/riscv/boot/dts/sifive/fu540-c000.dtsi |  1 -
 arch/riscv/configs/defconfig               | 10 +++++-----
 arch/riscv/kernel/vdso/Makefile            |  2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)
