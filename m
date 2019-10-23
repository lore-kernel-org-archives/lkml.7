Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACE9CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047BD21A4A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x6ROYP7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbfJWRcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 13:32:02 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40267 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfJWRcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 13:32:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id b24so20430938wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 10:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dmtFsSUBWA54jB5wbZR7TL/ePVjER+sBaUCUBdLRxXM=;
        b=x6ROYP7fQnUWXi7GomAjmzViOaiRf4rEu2CVqKuswbfpWXqv40LiLqN/Eg94rawgyb
         zfXZ5hSKFTk2Up6JdnCD1FYkuKwTL32r+TbfVH6AmSgoOGG5sBM0Rnm+k14ieZ3qhJOO
         JWZlSgfcBVsyOhb5kG2YnCjItfXoSU7aIM+8DABOW0XbziSqB86q2LnPaoQ1bKqhgIH8
         akwKAcbwQl69DKFd9/sRxkTd99DsVW5XMglsRSyJSl2OR3OklDESQOUDdlNA1IvavfwF
         cet7YlMT3pjXyHyXx6AIQVTnxkFoE00naoHSTo98s8dAKlz+ZDvA0A/KN0esS8cKuHp1
         067Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dmtFsSUBWA54jB5wbZR7TL/ePVjER+sBaUCUBdLRxXM=;
        b=cSN0qJlDW81uHRq9O38MMLFWC7UE/cF7tU1p+b3Wf4vVwnHobYk5xau83VzKVlMUcu
         dXQKZyLmy2l8GiFeYRatcPIrR68P3VZRaUMpfdQv9BTN3Mswl4zCnUmK9G+X2A/JtiZt
         tN9lkXsJyGB2EmTPzyfVuUzrlAz2yUX4gQE8hgL9p1bsFVGPfy9NkuNZmk1OkZLEPsFb
         hN5KxHqJgQdkDM4YFPHf64cJKmxohlprsXNPUaz5KlH0f9RoBug6Kg++6fyL2p6BpUPE
         Y8lFvZYEM7yHbhO+Cf6vECpKH+sC2rc48J8w0azmVhvfTD8sW4aBRx/hq6dcuU3AZ5b+
         hfIQ==
X-Gm-Message-State: APjAAAVfU/fm3wd/7ZALhNPRhbXUvBb/eFFC7B0ZW5Xq6/W4+KYoTW4E
        2BnvqmyfNT/v1aSuHfBjPPUFQw==
X-Google-Smtp-Source: APXvYqwpg48qOMHAuNtyyvSmuZgoDwb0BYtWY3fWDcD0ur3NTmDRxKFO5PFgey3pimscOkk/uSduog==
X-Received: by 2002:a1c:2cc4:: with SMTP id s187mr985909wms.166.1571851920625;
        Wed, 23 Oct 2019 10:32:00 -0700 (PDT)
Received: from e123331-lin.home (lfbn-mar-1-643-104.w90-118.abo.wanadoo.fr. [90.118.215.104])
        by smtp.gmail.com with ESMTPSA id f7sm14900374wre.68.2019.10.23.10.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 10:31:59 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Chester Lin <clin@suse.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guillaume Gardet <Guillaume.Gardet@arm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Kairui Song <kasong@redhat.com>,
        Narendra K <Narendra.K@dell.com>
Subject: [GIT PULL 0/5] EFI fixes for v5.4
Date:   Wed, 23 Oct 2019 19:31:56 +0200
Message-Id: <20191023173201.6607-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
X-ARM-No-Footer: FoSSMail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7d194c2100ad2a6dded545887d02754948ca5241:

  Linux 5.4-rc4 (2019-10-20 15:56:22 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git efi-urgent

for you to fetch changes up to 0d0013109c849cccb16560df213b5d6115a2d206:

  x86, efi: never relocate kernel below lowest acceptable address (2019-10-23 09:00:10 +0200)

----------------------------------------------------------------
Some more fixes for the EFI subsystem:
- Prevent boot problems on HyperV due to incorrect placement of the kernel
- Classify UEFI randomness as bootloader randomness
- Fix EFI boot for the Raspberry Pi2 running U-boot
- Some more odd fixes.

----------------------------------------------------------------
Ard Biesheuvel (1):
      efi: libstub/arm: account for firmware reserved memory at the base of RAM

Dominik Brodowski (1):
      efi/random: treat EFI_RNG_PROTOCOL output as bootloader randomness

Jerry Snitselaar (1):
      efi/tpm: return -EINVAL when determining tpm final events log size fails

Kairui Song (1):
      x86, efi: never relocate kernel below lowest acceptable address

Narendra K (1):
      efi: Make CONFIG_EFI_RCI2_TABLE selectable on x86 only

 arch/x86/boot/compressed/eboot.c               |  4 +++-
 drivers/firmware/efi/Kconfig                   |  1 +
 drivers/firmware/efi/efi.c                     |  2 +-
 drivers/firmware/efi/libstub/Makefile          |  1 +
 drivers/firmware/efi/libstub/arm32-stub.c      | 16 +++++++++++++---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 24 ++++++++++--------------
 drivers/firmware/efi/tpm.c                     |  1 +
 include/linux/efi.h                            | 18 ++++++++++++++++--
 8 files changed, 46 insertions(+), 21 deletions(-)
