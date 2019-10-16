Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2853DECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DA420872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UByquhJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437375AbfJPVGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:06:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39063 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437357AbfJPVGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:06:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id v4so162523pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 14:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KfBHJjUBIPVStHExUz9nXnaI3W0Mvp+cyl7vMgb3aMg=;
        b=UByquhJzjCJHuCYz95c3u1RCD6OHksnyqZkx7q+5LcmjyG12sDQCiJOVelCpVZ/7AO
         gx7T5FYVaQh3+LtqXgMie/KbXF2Pq+g5TGMCIgBV9xyrOfHbh9h59ocmCt0l7cQSOB7Q
         F6uRHqsftN7AWfqULERuXMWBWZpypOdueZXyUPWUpQsuCJAbDC74E2gu+w5ta6xxkig4
         BhxVsrGu6mko9GOzLMKkWuHFUqKRIPdmrOfb830G6ROnKOOeyfS6I4Gqmvu4h+6owIok
         c0CjX6M7u4fzLSlsZ+mZhJVwnS8SIvsr2EAJMxha5Ac3CpbCjn0kEXDHR04MMF3p3GFn
         dstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KfBHJjUBIPVStHExUz9nXnaI3W0Mvp+cyl7vMgb3aMg=;
        b=b9/RN8mKv+hA+ZZXsTTXCN+lraa7D37FhyWzLlI+GLobdm+UTpqQ0Ctw54i2L3KfPO
         NdRatvb5VJ7ph65mhO0vousMtZ4lLx3GmIKwZBKnfXUvx4LNb8v2vRb/9oZq8haFnTO8
         jgn2GmmODKVjR+DY1XecHKNToqPRTjmRyf9HJ2cAP0yD4zxhus2kcR756t2yyC9mpzfd
         1bGkW3iya44T0InyVTOex2zx5yxcEx7IqBpQSDEFUaS2Y3ClSv64DlVIvYCa86NraLJk
         d8yK9rD2uGLhsf9F5SHOBMWuEQiDwZkwQAfSQZdOHhBWdEUaTmAwWn7n01eJ506gOGGQ
         W35A==
X-Gm-Message-State: APjAAAWyb2Y107kWe+nEHcuX2POVrPvMD7wauLMLRnawlTIgYSfuzI53
        inHSAP5NF/mvymlTgLQEQXqC2b69gax8Gg==
X-Google-Smtp-Source: APXvYqwCwwfHd/Dg8i4CH/RLyyZo4BFLSViqDpLnRtAXL9PHqIZpLeaVyG96e1xr3ZLSpcUyA+DQFQ==
X-Received: by 2002:a63:c045:: with SMTP id z5mr156179pgi.69.1571260005288;
        Wed, 16 Oct 2019 14:06:45 -0700 (PDT)
Received: from localhost.localdomain (155-97-232-235.usahousing.utah.edu. [155.97.232.235])
        by smtp.googlemail.com with ESMTPSA id x11sm11613226pja.3.2019.10.16.14.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 14:06:44 -0700 (PDT)
From:   Tuowen Zhao <ztuowen@gmail.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        acelan.kao@canonical.com, mcgrof@kernel.org, davem@davemloft.net,
        Tuowen Zhao <ztuowen@gmail.com>
Subject: [PATCH v5 0/4] Fix MTRR bug for intel-lpss-pci
Date:   Wed, 16 Oct 2019 15:06:25 -0600
Message-Id: <20191016210629.1005086-1-ztuowen@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some BIOS erroneously specifies write-combining BAR for intel-lpss-pci
in MTRR. This will cause the system to hang during boot. If possible,
this bug could be corrected with a firmware update.

Previous version: https://lkml.org/lkml/2019/10/14/575

Changes from previous version:

 * implement ioremap_uc for sparc64
 * split docs changes to not CC stable (doc location moved since 5.3)

Tuowen Zhao (4):
  sparc64: implement ioremap_uc
  lib: devres: add a helper function for ioremap_uc
  mfd: intel-lpss: use devm_ioremap_uc for MMIO
  docs: driver-model: add devm_ioremap_uc

 .../driver-api/driver-model/devres.rst        |  1 +
 arch/sparc/include/asm/io_64.h                |  1 +
 drivers/mfd/intel-lpss.c                      |  2 +-
 include/linux/io.h                            |  2 ++
 lib/devres.c                                  | 19 +++++++++++++++++++
 5 files changed, 24 insertions(+), 1 deletion(-)

-- 
2.23.0

