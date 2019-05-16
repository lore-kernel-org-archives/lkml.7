Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F04C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 21:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037B820818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 21:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gfLcvu9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbfEPVcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 17:32:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33586 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfEPVcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 17:32:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id c66so7927219wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 14:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=icfnX62uLR7atIF4Bprs5XNUI1SninhMooqCIwBFQ0I=;
        b=gfLcvu9QQ0v3Z3TCts+0DL0ESMO5gGwHEDInRZoi0kDcLwWSfp7IteoTs7+jx93qUe
         ls4xk0U5bCZfjsKG8Jg5WjGFVXNf52GMUQcHyxVXeMMabjDMfb79+D8SzQ33CB+5YY2y
         V1yvTaM62gpqbjviy73pqBdnd2v0gh0IOAQyYVa37A/7I1chFAv1CmHE2PzUyuG0+Y+8
         yKUuQjzyVIxwtDMGAcyHuLWRMDSi7/IPJjNPMfSXJthXBol88Dvasn85rFGkBquoB79b
         xCbHS2Ccr9PxqplatDrdkwsq2EcY7DkM7GaHXCVxGJpPtMWte9SaYCnVCP5aUoEYucWE
         PoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=icfnX62uLR7atIF4Bprs5XNUI1SninhMooqCIwBFQ0I=;
        b=docoBay4qbaqIBCw7WvvkUhju75Eg1wpK/YylMjCyYynJBAUepHG8WUhZtBaXxQGNr
         PtyKhqPswPL5KwMEW5uaYTFOv/D+/qgLXA6+ZML/0rst6BEwrOK4KN+E4ue42eQZsZ4Q
         ptoplTP0Hr80mxrxkweZ3PuZWJ+onZ3wX8eop5YlUeFICpq94WN9S1NbWZmRIzVJs6F1
         NIyq+zVHdhsJ3TwTZ9iRXL1vfLjuDTiUe2dSeM3+eabucuGpIjK62JxGoiNUp4q8d2iN
         sEZDYauCbhzjkdoMwmWhvPiOITkpZ7yTYddcAkBzlXuBkOXor5eHtD7Rr8z80QYcP5Ka
         odxg==
X-Gm-Message-State: APjAAAUSlkD3qiZ2wD1eZe7uuTLy9143JAAXzDV7T6FztGioJ1VyXPFk
        pWqEY359dtjNTzV+q1CRy1tDYIGDHU0nTQ==
X-Google-Smtp-Source: APXvYqxCeDpux425AwKFwb/v7bielRInDS2uIWkDtMqFiIqV77kzXUskCUiZRbR4D2Et2VloWDQm0A==
X-Received: by 2002:a7b:c390:: with SMTP id s16mr23637458wmj.112.1558042342021;
        Thu, 16 May 2019 14:32:22 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:55a9:76bd:5bf2:be83])
        by smtp.gmail.com with ESMTPSA id e12sm6756988wrs.8.2019.05.16.14.32.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 14:32:20 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        James Hilliard <james.hilliard1@gmail.com>,
        Peter Jones <pjones@redhat.com>
Subject: [GIT PULL 0/1] EFI fix for v5.2
Date:   Thu, 16 May 2019 23:31:58 +0200
Message-Id: <20190516213159.3530-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a455eda33faafcaac1effb31d682765b14ef868c:

  Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal (2019-05-16 07:56:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent

for you to fetch changes up to 7993a1d12c712a3e2cce8e334dd1a4ab8b93128e:

  fbdev/efifb: ignore framebuffer memmap entries that lack any memory types (2019-05-16 18:25:41 +0200)

----------------------------------------------------------------
EFI fix for v5.2:
- ignore bogus EFI memory map attributes for EFIFB region

----------------------------------------------------------------
Ard Biesheuvel (1):
      fbdev/efifb: ignore framebuffer memmap entries that lack any memory types

 drivers/video/fbdev/efifb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)
