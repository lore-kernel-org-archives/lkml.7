Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC35CC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EB621D7B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213321;
	bh=DfJUjl7TXaMhspK+vj3CfnG/Xgjg7ENP/vZt23hUiwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nFZaYY1PnlCOZVDojrmKLfXCjj1Ij7ihp3YtTzL3VotgFRR4D6BlSqihqJlpQi8Fp
	 cOhxl2sNCzDQiVeiUxxfvGm+biSu+R/ukT/QRRfaqfXfbZzCfdPf4S813cxKn3YlhR
	 u00JAK8WMYu3r38dx4RlCxAs5fNt1/DIAaWAhDcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389741AbfKHLmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:42:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:55456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389693AbfKHLly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:41:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29EB620656;
        Fri,  8 Nov 2019 11:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213313;
        bh=DfJUjl7TXaMhspK+vj3CfnG/Xgjg7ENP/vZt23hUiwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KY4iSMEuGbz5jUOJd9UBruD2yclrAdebxs+ibSbw9BU6nqK61MtC1fVugxYz0bIyQ
         UExVGAgY/rqGDBVfVoEY/7A0FwVqSAul3aSBwqYC1RwfQeqnyjZrlXgcFsR9pNO+Mx
         U/s4w78ZAZz+lrDsrIwLD7S5JZdeD9yURKgK/Y/o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, kbuild test robot <lkp@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 159/205] ALSA: hda: Fix implicit definition of pci_iomap() on SH
Date:   Fri,  8 Nov 2019 06:37:06 -0500
Message-Id: <20191108113752.12502-159-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

[ Upstream commit d9b84a15892c02334ac8a5c28865ae54168d9b22 ]

Include asm/io.h directly so we've got a definition of pci_iomap(), the
current set of includes do this implicitly on most architectures but not
on SH.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_ca0132.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 0436789e7cd88..7fce2366f2421 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -31,6 +31,7 @@
 #include <linux/types.h>
 #include <linux/io.h>
 #include <linux/pci.h>
+#include <asm/io.h>
 #include <sound/core.h>
 #include "hda_codec.h"
 #include "hda_local.h"
-- 
2.20.1

