Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09F1C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 11:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80746206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 11:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YVZTIM/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfEFL1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 07:27:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46284 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfEFL1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 07:27:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id j11so6583237pff.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 04:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MkPuHs9MpdmcYLP05ibBDjwFgoo9Bzabjg0rXaXjY8o=;
        b=YVZTIM/PRH70xiHiNZ3g4QeIjRfn6Spvf7lAc4DK9eDJENXGWEbwBGHPRuEWzvXB3K
         eeYjKpOvjVA6W+1IWTdLmyb5D7UwurznsaIQBklg2OVuP6ya8Nuy7uZRYw4ks+ttRt4x
         xEoE8R+Gs40NAu0+DOK6T40m1CdJF5cNgcJOxvqxxNJ6JXuxg44jYMrm8Eg3+Pkm4aYm
         sXjB4XphUS+L8hWhMsucwjRVW3qu4/L0Tilxoz94EDqKxVKMK0SZ55/6glKz3TEFsjhh
         8xPK1Z822u3Aj/22Z8Pk1rrKbuf4YuQUw6VTa7h+9V0tWFTcczuc3gTUelkDvPGvQcUD
         n1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MkPuHs9MpdmcYLP05ibBDjwFgoo9Bzabjg0rXaXjY8o=;
        b=q1YrmFZAU2Qukd3obFDZIt94QQjLtN+qgL3ybsbC/PTSkppreEBrCMb8uLWRP1gpD6
         RZlJb1FG5QUuGL0JubmiTY56Pf3LjHutqOVkM1aLz9iMVmsBQUGUShgqazM9lkaW4LPU
         uJQI+vqc6d+gYwkBiS0BQPxOws5KWceWd/HSdGb90eNmTFD5VJoQFZVFxc13Khi2vrQ+
         20RhSAtcZrxtwufDTWz/bBftLoC7Vw70rSzBnQ1hvaIONJmEwjHHrHqYN7xRXbIqKrNH
         8X3M97dvSK1fMkLBjs77JZQTY5bKuDv5W6ufDFt7ZTz5Ih0Tg8bIvCJsHLjpaDs3SsZ4
         XaIg==
X-Gm-Message-State: APjAAAUYdI2EkroLu43OBka9b97kS6VsQIANQD8e1qJa7TuaaV5h5gqk
        k6xs915YCNG4rNvwVjEJhmSLjQ==
X-Google-Smtp-Source: APXvYqypdffY+Z23d/npCXxA3vA8vPoVVmSlKn+AhYIVb+CdTJzYHXc/Pk9JzJmfD2szzXOKjQVSfA==
X-Received: by 2002:a65:5687:: with SMTP id v7mr31142196pgs.299.1557142053267;
        Mon, 06 May 2019 04:27:33 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id k4sm23990693pgh.27.2019.05.06.04.27.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 04:27:32 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     linux-edac@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@sifive.com, bp@alien8.de, james.morse@arm.com
Cc:     paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, mchehab@kernel.org, sachin.ghadi@sifive.com,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v2] EDAC support for SiFive SoCs
Date:   Mon,  6 May 2019 16:57:05 +0530
Message-Id: <1557142026-15949-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds an EDAC platform driver for SiFive SoCs.

This patch was earlier part of the patch series:
'L2 cache controller and EDAC support for SiFive SoCs'
https://lkml.org/lkml/2019/4/15/320
In order to merge L2 cache controller driver without any dependency on EDAC,
this EDAC patch is re-posted separately with updated MAINTAINERS entry.

This patch depends on patch
'RISC-V: sifive_l2_cache: Add L2 cache controller driver for SiFive SoCs'
https://lkml.org/lkml/2019/5/6/255
The EDAC driver registers for notifier events from the L2 cache controller
driver (arch/riscv/mm/sifive_l2_cache.c) for L2 ECC events

The patch is based on Linux 5.1-rc2 and tested on HiFive Unleashed board
with additional board related patches needed for testing can be found at
dev/yashs/L2_cache_controller branch of:
https://github.com/yashshah7/riscv-linux.git

Changes since v1
- Move extern definition into sifive_l2_cache header file
- Replace NOTIFY_STOP with NOTIFY_OK in ecc_err_event()
- Other minor fixes based upon comments against v1

Yash Shah (1):
  edac: sifive: Add EDAC platform driver for SiFive SoCs

 MAINTAINERS                |   6 +++
 arch/riscv/Kconfig         |   1 +
 drivers/edac/Kconfig       |   6 +++
 drivers/edac/Makefile      |   1 +
 drivers/edac/sifive_edac.c | 119 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 133 insertions(+)
 create mode 100644 drivers/edac/sifive_edac.c

-- 
1.9.1

