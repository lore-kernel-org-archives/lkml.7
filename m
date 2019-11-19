Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CCFC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97FF206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141649;
	bh=ks2R9c+gJRIhU1kOjJzzbLPw+dP1+cZFyS4+4a0PfI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KmMI1hhkzoov+AzqwhpJlObT/QbuLL893KqRjp5dRh3dUbblh9JypGjhIt/51Y4OJ
	 2PSrK+3UvA+mOp6j75X0hApbuH3Oz3H7zHl6om0sUq1n/WLwb6mddL0oqGlKSvIRln
	 vDVX05H97CByxru6nufClG0S646xjN+YltCXCsBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbfKSFeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:34:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:54710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729129AbfKSFeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:34:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76D57206EC;
        Tue, 19 Nov 2019 05:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141642;
        bh=ks2R9c+gJRIhU1kOjJzzbLPw+dP1+cZFyS4+4a0PfI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ueyeqbxVyUMDOcmV/H5yMHIIM6+CW6Qs2b9eyopal0qXpoGpTtfOOPpJcJ3/gk/Eg
         zxW0844oWoeYmlUXDdARFbkI32fRR0/GGMmcuCN0uPHppVoYHrxvJ/RMQMuNR2D3QI
         /LqW2sbPsmAEInR5zy6kWXIkGAl5WS0zPFLVy1K8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 190/422] ALSA: hda: Fix implicit definition of pci_iomap() on SH
Date:   Tue, 19 Nov 2019 06:16:27 +0100
Message-Id: <20191119051410.833052144@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 3e978b75be9ac..f2cabfdced05c 100644
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



