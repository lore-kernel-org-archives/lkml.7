Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1CFC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5746820848
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XMQhnmkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbgABEOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 23:14:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41628 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgABEOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 23:14:50 -0500
Received: by mail-pg1-f196.google.com with SMTP id x8so21301545pgk.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 20:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CVJyLIJlyzyIsfGFqktPVcu6xkYJBJCCJvQZrRch0yg=;
        b=XMQhnmkwvdV2wjNx6x8J51g/Xa7k3567jdmjC3ntNFMi83hUqZF2qqMCeJ4TZxZ2bB
         VmjWzDF8ZNHsZA+ZxGHfD2wyKZgLs+eu5j/qWrw/TrMZa1emW/8vUuGrMQnbxRQrPJiV
         3f+Xcni3Gi/2OARKG9Z7le0mjVAkCvmydW2CPrTFQSUp7RVm+gycXB/gJB5Gp8D7OlSH
         oSmJP1pXJsqqv+cG/cNMNw3mDvw/ReVo0HMqp5AI3BnhVGn9v4IzI28mczmxoavbgj1N
         lWHFD41tijcTPmPiY2pKkMcjAc+hQGVHfIofktWSiYlHLqlYHDPl9dOd/NiOPc2n9L21
         uC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CVJyLIJlyzyIsfGFqktPVcu6xkYJBJCCJvQZrRch0yg=;
        b=O1PDSXqFUzBo3y3UnLnRUcI6xnmBrD4zAZLXx5OplkGERCgX6sxOBO8PY4ZNAzc9pr
         gKJfD06VIjPhs8O1Ha2tRzViCx0q/TMMZyz4gI3oy80n6uTcGTZR8++8jpruHJvPk4YZ
         nn61JQNXzWievhvDg1ih8k3ei0eteTGEBk+Khi25lRCv6cVTl+NAWa4UzqdkEsGfAfqU
         SIxtTYvpNWdXQqvm3+otgpXIqZGCiWqiRMJuW82KhYYuNb+7FbMiVsHqHn3UEgWQoMl5
         fOtwDwgyDUH6bCKG2k7PqMuQvJVmYn8jmLuO0bBCil+Na6GGsjojoIiD7TVDgavvdtRz
         xngQ==
X-Gm-Message-State: APjAAAVZUOZiH6CeCvPpdxBZZs/vL2v6u3lGb8i5m/P4jHyByADzqFOg
        Wlc+whu2Vk+luN5xsheywFPvvA==
X-Google-Smtp-Source: APXvYqyHtz4yoWif8cwTQc0pKIJlw7G0c8aH5It4yZeh8zfBsW0BBhcu76XrY3B9xYJe0ile17tFHQ==
X-Received: by 2002:aa7:968d:: with SMTP id f13mr84085549pfk.67.1577938489514;
        Wed, 01 Jan 2020 20:14:49 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id i127sm63870336pfc.55.2020.01.01.20.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 20:14:49 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     corbet@lwn.net, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 0/2] Enable gcov for RISC-V
Date:   Thu,  2 Jan 2020 12:14:43 +0800
Message-Id: <20200102041445.98195-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches enable GCOV code coverage measurement on RISC-V and update
the status of RISC-V arch in documentation.

Lightly tested on QEMU and Hifive Unleashed board, seems to work as
expected.

Changes in v2:
 - Split into two patches for kconfig and documentation respectively.

Zong Li (2):
  riscv: gcov: enable gcov for RISC-V
  Documentation/features: support gcov on RISC-V

 Documentation/features/debug/gcov-profile-all/arch-support.txt | 2 +-
 arch/riscv/Kconfig                                             | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.24.1

