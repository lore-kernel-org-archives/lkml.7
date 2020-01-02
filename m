Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6D2C2D0DE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 03:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4986020863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 03:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FdObOX2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbgABDMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 22:12:45 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45342 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgABDMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 22:12:45 -0500
Received: by mail-pl1-f195.google.com with SMTP id b22so17290689pls.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 19:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TMcYLN3IkMoBxMFdCkuvjs15n5cIfbofEAZTiuFMn6Y=;
        b=FdObOX2dsbDRlFC6cfrSgH4NJ8u/d+dDPwphvVvBQMbbrMyq/5qEKGfXT/55/7uL59
         Jo3U18bfpPcWYIvMqK6ERmXXv/0/SxBSydcYObUABZdNVkXGEsSybeP2fYSRWCNWoS89
         jjKQ+mme76LObO7nKf41OjNe56NjbwypL839Gv672GwQSyyd6BVt3HR4cicOdSqgh0Ac
         VKBimMsvkR7pHdMD5TB33+7lxYvAdQjOC/iLxYy97adq5ZB9Q6B9j0n4pHJzV6E+o6q7
         yuK1vSHaINe+aEUibokjtTdNyaEI9nDbu4WlUQo7eiOZm3KmIiBg0mZoEEI9TSpdLu/x
         tr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TMcYLN3IkMoBxMFdCkuvjs15n5cIfbofEAZTiuFMn6Y=;
        b=W3szhblsOKFXzmNfRoU5AeLcVjVEzSDRb4nBJB65hYtlsDWunq7NkVZk4QQo4slw3T
         lj2XddO9QKFSyhEAO8mgQSjyGwWnc4qR92AxysIHpUICqkna63LdG4qWU6sBJ19kAX8e
         7WYXYt7Yl6DfZ8o9pXx72V4i2U39QgjKFMkiZ/T5qsrZWOmThJb3ozuugm/IK2+b0hj4
         CfCBSeGG18rFBQ01njz74C+dOp92GsbfJn4REDZhJBvpaHTegCkEkN6nWDW9yNve6HrN
         gqg2BT6mT/XzWRmx/oiOUMkUNcmqSrPZVEGwsBQ8M8yonp59kX+K137bdLIosszLLlrl
         N7YA==
X-Gm-Message-State: APjAAAUcviMGAsDC2uD+HjWfxPtHAU6N6CQMflKL6j73iQvVJVsad4vt
        /NE/snO7JRH+tpzWohl7baE1VRtYvc4=
X-Google-Smtp-Source: APXvYqwbFnj6ajJf+Fid3c7aNGr3nMJJR57DIC+mTq8Y6qZG36OlFLZnwtxd01211MJAnFu9F1Q6jg==
X-Received: by 2002:a17:90b:3011:: with SMTP id hg17mr16969954pjb.90.1577934764625;
        Wed, 01 Jan 2020 19:12:44 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id l127sm57943938pgl.48.2020.01.01.19.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 19:12:44 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 0/2] riscv: mm: add support for CONFIG_DEBUG_VIRTUAL
Date:   Thu,  2 Jan 2020 11:12:38 +0800
Message-Id: <20200102031240.44484-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements CONFIG_DEBUG_VIRTUAL to do additional checks on
virt_to_phys and __pa_symbol calls. virt_to_phys used for linear mapping
check, and __pa_symbol used for kernel symbol check. In current RISC-V,
kernel image maps to linear mapping area. If CONFIG_DEBUG_VIRTUAL is
disable, these two functions calculate the offset on the address feded
directly without any checks.

Zong Li (2):
  riscv: mm: add support for CONFIG_DEBUG_VIRTUAL
  riscv: mm: use __pa_symbol for kernel symbols

 arch/riscv/Kconfig            |  1 +
 arch/riscv/include/asm/page.h | 16 +++++++++++++--
 arch/riscv/mm/Makefile        |  2 ++
 arch/riscv/mm/init.c          | 12 ++++++------
 arch/riscv/mm/physaddr.c      | 37 +++++++++++++++++++++++++++++++++++
 5 files changed, 60 insertions(+), 8 deletions(-)
 create mode 100644 arch/riscv/mm/physaddr.c

-- 
2.24.1

