Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FDCC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201EC208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hcUxkiLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfHLPFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 11:05:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40240 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbfHLPFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 11:05:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so12074480wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 08:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0F14BMpIdBrIwMf7OjjkwazZeUP2fIGMTLlIBF/IWMI=;
        b=hcUxkiLMAl/dOL9yDehEtGU40JS15/VaEJX7cLv7kSyabMcS76nD4k9opnYkQI5gcJ
         2XQpSltFueRPr5Uv3n7XKjJvkNQxge8xqaWkLq3fh9Ub1HBWm+3JYhYtGUqXd+XH8NKU
         sRHzVgZ5QdEIy1LUOeutX20teYv35UfEOKCkOirih34BcteeFXYVybJnbGsB471APt0e
         lKP0K/u6nmxlXefO7Erc05fD5IIj04PBY6YDERiJ+hDhYhI4GPVAIY7BVskFSOjIYe4I
         5yH34TVBNH19zLAlC9cFyuHKEYUe4SRTZk/AxKv3Z8qzM4kqRc8JLfUF0+ip2KQW3xvX
         OFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0F14BMpIdBrIwMf7OjjkwazZeUP2fIGMTLlIBF/IWMI=;
        b=ZU6xX7w59iw/q8mLiEv2+C/wGpMtPphCS79w6veiNu8jNVxtH/f2oclWpjnOCssusa
         NSO28nblZ+P032NIjtmZXh0ikzbCvr4BdQcZiG4ooyZXs+/o0ycoJ9EYpwZS4/rEcUzW
         CSfRfZMbIHvoxfnRwGvkYtfn/XhD45HGfNFUp3uIJ5H2aUeop6yEvpXwmzelinl163v2
         Ktz1lUemxKrZ8734vPDEwOiIw4Z13F2LplQL7X+8m08RtZghinBj6j4nNf+Ojr4keDVy
         aMpYWf1OvqhX/Tm/fv9HJa91W2EzByr+63bIif2UZ0u+U3poBQEU7lSuV9fktNQfZ4vu
         QDsQ==
X-Gm-Message-State: APjAAAUhEtbqC+Kb3IzivzMm50dgrxoPVqn30BkidtnSS+wqctSW5rut
        jVTni5TGw2bR/j/OOvjf7gAzew==
X-Google-Smtp-Source: APXvYqxVoum+LOqtIzp50rwSLvG9uIS5/obLJMti4ktZt9A0ZS170CA9sAsz2ehuh+K1j+tQns7n/Q==
X-Received: by 2002:a1c:be11:: with SMTP id o17mr27956868wmf.115.1565622306575;
        Mon, 12 Aug 2019 08:05:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:587:a407:da00:1c0e:f938:89a1:8e17])
        by smtp.gmail.com with ESMTPSA id h97sm31027269wrh.74.2019.08.12.08.05.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 08:05:05 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Narendra K <Narendra.K@dell.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [GIT PULL 0/5] EFI updates for v5.4
Date:   Mon, 12 Aug 2019 18:04:47 +0300
Message-Id: <20190812150452.27983-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next

for you to fetch changes up to b194a77fcc4001dc40aecdd15d249648e8a436d1:

  efi: cper: print AER info of PCIe fatal error (2019-08-12 12:06:23 +0300)

----------------------------------------------------------------
EFI changes for v5.4:
- Some refactoring of the EFI config table handling across architectures.
- Add support for the Dell EMC OEM config table.
- Include AER diagnostic output to CPER handling of fatal PCIe errors.

----------------------------------------------------------------
Ard Biesheuvel (3):
      efi: x86: move efi_is_table_address() into arch/x86
      efi/x86: move UV_SYSTAB handling into arch/x86
      efi: ia64: move SAL systab handling out of generic EFI code

Narendra K (1):
      efi: Export Runtime Configuration Interface table to sysfs

Xiaofei Tan (1):
      efi: cper: print AER info of PCIe fatal error

 Documentation/ABI/testing/sysfs-firmware-efi |   8 ++
 arch/ia64/include/asm/sal.h                  |   1 +
 arch/ia64/include/asm/sn/sn_sal.h            |   2 +-
 arch/ia64/kernel/efi.c                       |   3 +
 arch/ia64/kernel/setup.c                     |   2 +-
 arch/x86/include/asm/efi.h                   |   5 +
 arch/x86/include/asm/uv/uv.h                 |   4 +-
 arch/x86/mm/ioremap.c                        |   1 +
 arch/x86/platform/efi/efi.c                  |  39 ++++++-
 arch/x86/platform/uv/bios_uv.c               |  10 +-
 drivers/firmware/efi/Kconfig                 |  13 +++
 drivers/firmware/efi/Makefile                |   1 +
 drivers/firmware/efi/cper.c                  |  15 +++
 drivers/firmware/efi/efi.c                   |  39 +------
 drivers/firmware/efi/rci2-table.c            | 147 +++++++++++++++++++++++++++
 include/linux/efi.h                          |  14 +--
 16 files changed, 251 insertions(+), 53 deletions(-)
 create mode 100644 drivers/firmware/efi/rci2-table.c
