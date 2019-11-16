Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92E0C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B6121479
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573920851;
	bh=gUbBaBqeNzDCPkiKzKsFnWC4UNaWjQUjPjfR/d+HDI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jWV7CkKsaEeI2lkUV+mQlHAW26QNcsY02uw0z2RSNzDYGoTpAW9vMtWU8zKQOK/6i
	 elDm/6lEhGYv/Dydq2/z7384NdUFntLQghw9dxipqNXJEpjA2de1WIJsE58RdURYge
	 nxP8RZoloQD/gKEt5kMIVmusqeOO4NkOnALKnaBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbfKPQOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:14:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:54716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729843AbfKPPry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:47:54 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7569B20729;
        Sat, 16 Nov 2019 15:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919273;
        bh=gUbBaBqeNzDCPkiKzKsFnWC4UNaWjQUjPjfR/d+HDI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t1W1/f8w71PDGbyV+GruGhmPPLHSLWwIbm/0zGtts5yZ7WKeQ+TxK/ZZWbCQKmDW0
         npDv1yCwdFVoNz0ZMlk6IpEVI8fNzhgqOpjeuYAIIM1arjkctn5+dHh0QXu1Y2J2vV
         QWk05ru37kfW4RA7CWnIMr4XgKzqNPaKIihguoTM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Angelo Dureghello <angelo@sysam.it>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH AUTOSEL 4.14 021/150] m68k: fix command-line parsing when passed from u-boot
Date:   Sat, 16 Nov 2019 10:45:19 -0500
Message-Id: <20191116154729.9573-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154729.9573-1-sashal@kernel.org>
References: <20191116154729.9573-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Angelo Dureghello <angelo@sysam.it>

[ Upstream commit 381fdd62c38344a771aed06adaf14aae65c47454 ]

This patch fixes command_line array zero-terminated
one byte over the end of the array, causing boot to hang.

Signed-off-by: Angelo Dureghello <angelo@sysam.it>
Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/m68k/kernel/uboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/kernel/uboot.c b/arch/m68k/kernel/uboot.c
index b29c3b241e1bb..1070828770645 100644
--- a/arch/m68k/kernel/uboot.c
+++ b/arch/m68k/kernel/uboot.c
@@ -102,5 +102,5 @@ __init void process_uboot_commandline(char *commandp, int size)
 	}
 
 	parse_uboot_commandline(commandp, len);
-	commandp[size - 1] = 0;
+	commandp[len - 1] = 0;
 }
-- 
2.20.1

