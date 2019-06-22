Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83D7C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 08:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2DF208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 08:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J5J/G+b6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfFVIvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 04:51:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36294 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfFVIvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 04:51:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so7530472wrs.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 01:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YdrNbZk4+5GMH7+vINq3bjHxz2Mgfb8BRnXaK4Rpn5w=;
        b=J5J/G+b6+9YRAeBH4SXoiGYyWPDtznpGbzjZ6RJl7YlEvuROsMMjZBmDsffY2K20bR
         STp64a7nX+qTrx7cOvvK93yZIc1FCDBRxoXGHSNsHd3ccqa/9oMhlc4V47atX9JRsf+B
         qCoN5DY5ObbjPLmQG0i1MLZJ/GWSb8SsqDOB5XpZan8Cv0NZgAam4n+LnLh/tZmnyfxE
         GaCQllumsHuKrMDX6bZ+iCE6hs/s2KSm0cD4AIvU2kway0TWcr733LtPN0QQYUuXlcFv
         KbrHbU7QVtpeQ06RHxCopl490UGIfQe5Givt8772bb9LfGSvvZCDYtIRNgBT3e2VwNji
         U9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YdrNbZk4+5GMH7+vINq3bjHxz2Mgfb8BRnXaK4Rpn5w=;
        b=lHxFRoBGIFAkOEZh7ru1mgiuiy1/Tc3pNjCh36pH8v1Mq2i5C2f8mFegU6Ft5qpLem
         dpqn6Ab5FIYLudmpIkOECIb/i2Yk0gA2g70nCP5ApzyZ8/EJzAzKinjiAhsqvwBFYyqU
         wIVMrfES2AUcKuaRTACyXOF7oRwJLWyT4PMvfxh2mOKN0fJ3wR+8NIdp36acbbphL9CV
         9j1VN4LRv83krWk/4BIhyTvkM2DsHPu/cpnE9TCDyXdZRLGU6XFl4rxPojMXdgxFRmnK
         P2q+g10Lo2h2s2oZVi6VO6ZkuL+gseDQAgYBFmtafw5sVzIV8HGSjggvWkTnl3ZEfP/e
         7M6A==
X-Gm-Message-State: APjAAAVD4w9iAhCR56yumUgePqBDOxLlFRt9qSAS5ENIJuuonhLUdrZ8
        rhLR89gyitpOagUw50famUxTJg==
X-Google-Smtp-Source: APXvYqy4Be5mkwMCWQ+mh8cyOP9H7kRvS9JY5Hnofo0qmiISxWzTOaXY1q1Fh0sj8nBIH7SJgvxN2A==
X-Received: by 2002:adf:f886:: with SMTP id u6mr31159299wrp.23.1561193471422;
        Sat, 22 Jun 2019 01:51:11 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:4bd:3f91:4ef8:ae7e])
        by smtp.gmail.com with ESMTPSA id v15sm4863589wrt.25.2019.06.22.01.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Jun 2019 01:51:10 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jonathan Richardson <jonathan.richardson@broadcom.com>,
        Luo XinanX <xinanx.luo@intel.com>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        Qian Cai <cai@lca.pw>, Tian Baofeng <baofeng.tian@intel.com>
Subject: [GIT PULL 0/4] EFI fixes for v5.2
Date:   Sat, 22 Jun 2019 10:51:02 +0200
Message-Id: <20190622085106.24859-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d1fdb6d8f6a4109a4263176c84b899076a5f8008:

  Linux 5.2-rc4 (2019-06-08 20:24:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent

for you to fetch changes up to 975a6166a8584ee4a1b8bd93098e49dc101d7171:

  efibc: Replace variable set function in notifier call (2019-06-22 10:24:57 +0200)

----------------------------------------------------------------
Another handful of EFI fixes for v5.2:
- fix a potential crash after kexec on arm64 with GICv3
- fix a build warning on x86
- stop policing the BGRT feature flags
- use a non-blocking version of SetVariable() in the boot control driver

----------------------------------------------------------------
Ard Biesheuvel (1):
      efi/memreserve: deal with memreserve entries in unmapped memory

Hans de Goede (1):
      efi/bgrt: Drop BGRT status field reserved bits check

Qian Cai (1):
      x86/efi: fix a -Wtype-limits compilation warning

Tian Baofeng (1):
      efibc: Replace variable set function in notifier call

 arch/x86/platform/efi/quirks.c  |  2 +-
 drivers/firmware/efi/efi-bgrt.c |  5 -----
 drivers/firmware/efi/efi.c      | 12 ++++++++++--
 drivers/firmware/efi/efibc.c    | 12 +++++++-----
 4 files changed, 18 insertions(+), 13 deletions(-)
