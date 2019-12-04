Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A339C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2013F20675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="c6YQ/CC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfLDIwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 03:52:11 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:39149 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfLDIwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:52:10 -0500
Received: by mail-io1-f66.google.com with SMTP id c16so7127516ioh.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 00:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=VbSlraRKW1h6H09AWbIwzLPGNtIDxR9arS6sirAYwJA=;
        b=c6YQ/CC7bn4j4hm9q72EVlvKUyNaajPvf64J+26Xmu1skjC54vIn6Ooi02zolvRivY
         XAIZz1anbbfubFp2wtJU2zqyZIBShjO/Qjnl/L0PbyYOxCBRXTfauQcHItm/AYTDDHl2
         jfCIyTZGlNEHVYpnECUIQP5TXN4MIrWN5/on1aZ7FoMTkpD7hvp0Ts2s3J90Zy7shf42
         Dv7s96Fp9xlv+OyRQ+1KXl/MIjYAXGyGGPqwT/euEmFvpkxwXaK7acg4IdHq7cw/IpoR
         eK/AXzs2h7My1DRaziiWwq9PwANx29k4hkvTwqI1f92Mrdrgww09L5LK8iwnUpEJ3OPd
         0NGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=VbSlraRKW1h6H09AWbIwzLPGNtIDxR9arS6sirAYwJA=;
        b=YVuH3+WM3aKJOlCQdNIbG5BPemiMo/jU8WIEFlNrrVaFve2ZDc/EIUFv2fXjoQbTHo
         uC6gRI5zHOZ851b5FN87drVJUKqNa8nEK8vW+uTQkur33luocRVSy5dNRgHhpfVR7hCf
         9pQsaPKdgUoVp0uLmtf3dI9JAc9QGFo4sNuTd8JqwTJKgXkvCVw7HkRwZ2ZtrXBHAjKj
         1HiS8TPA1I95a6xkMIZk1n8d1dcce5NLnR0P6M0Ao3ItTseEZo14ZmMrd447KB9k9/qf
         DewAVH51XhComPp1D6DjNUfG+ozy/SeI/vD77dwTtP2jtvwp8NvZMKf8r7mvNlrZQKMX
         mQFA==
X-Gm-Message-State: APjAAAX4bEVkcW1KsRH+Xx4EGOZLyp8pOIuUZAdxNmz/RCI6L8wwn6nC
        rByHpwSCXNSj4h2pr7+0bTxZLA==
X-Google-Smtp-Source: APXvYqyhs0VOhD8pRYtwYkIDbN3LMMXkKvjbgTwc1G/5AlUPF+NK+mkXe8vUg+Fx0fECgjN0fQhVIg==
X-Received: by 2002:a6b:3b90:: with SMTP id i138mr1354434ioa.105.1575449529990;
        Wed, 04 Dec 2019 00:52:09 -0800 (PST)
Received: from localhost (67-0-26-4.albq.qwest.net. [67.0.26.4])
        by smtp.gmail.com with ESMTPSA id m18sm1320714ioj.74.2019.12.04.00.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 00:52:09 -0800 (PST)
Date:   Wed, 4 Dec 2019 00:52:08 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     torvalds@linux-foundation.org
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Second set of RISC-V updates for v5.5-rc1
Message-ID: <alpine.DEB.2.21.9999.1912040050430.56420@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 5ba9aa56e6d3e8fddb954c2f818d1ce0525235bb:

  Merge branch 'next/nommu' into for-next (2019-11-22 18:59:09 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.5-rc1-2

for you to fetch changes up to 1646220a6d4b27153ddb5ffb117aa1f4c39e3d1f:

  Merge branch 'next/defconfig-add-debug' into for-next (2019-11-22 18:59:23 -0800)

----------------------------------------------------------------
Second set of RISC-V updates for v5.5-rc1

A few minor RISC-V updates for v5.5-rc1 that arrived late.

New features:

- Dump some kernel virtual memory map details to the console if
  CONFIG_DEBUG_VM is enabled

Other improvements:

- Enable more debugging options in the primary defconfigs

Cleanups:

- Clean up Kconfig indentation

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      riscv: Fix Kconfig indentation

Paul Walmsley (4):
      riscv: defconfigs: enable debugfs
      riscv: defconfigs: enable more debugging options
      Merge branch 'next/misc2' into for-next
      Merge branch 'next/defconfig-add-debug' into for-next

Yash Shah (1):
      RISC-V: Add address map dumper

 arch/riscv/Kconfig.socs           | 16 ++++++++--------
 arch/riscv/configs/defconfig      | 24 ++++++++++++++++++++++++
 arch/riscv/configs/rv32_defconfig | 24 ++++++++++++++++++++++++
 arch/riscv/mm/init.c              | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+), 8 deletions(-)
