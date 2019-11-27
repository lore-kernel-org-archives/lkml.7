Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1374CC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD45021789
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887334;
	bh=uf/SQX7gvex7V0ZjiMgcVzRM39CtftIlMt1fKTjPSYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pzCn7FkaP/CWv9/Ov/nXDaeNQPqMxgoFrwX6/t5uTopB/E3nomp8P2p9ncG5q7xfZ
	 ovd9UuH03PQJh1o9BzRIqHFSqubaLXV8DdNxfEq8/H7H1W7+eEnTFkuo3yp5frXgpF
	 Mv6S7N7doIVmV4Bouvh67yi7OOLLTXqPWAdCJvMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfK0UmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:42:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:48146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728764AbfK0UmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:42:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DD1721789;
        Wed, 27 Nov 2019 20:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887328;
        bh=uf/SQX7gvex7V0ZjiMgcVzRM39CtftIlMt1fKTjPSYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=veSs15Q1/cY0flUQBYer7ebuNg7ekXpeGx3OR64z48YJ9z9ZgL2aui60s254OwFl+
         o2EKMCl9OySX+BczIOa6Gbkjw//so/PwfTYbAGMyNfQFzKlPhEOzeRTv1eX+yPSa/j
         jqZY09HVdf5Nzs2/cOBFTKp+i8cBHl12Uu3IP2W0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Angelo Dureghello <angelo@sysam.it>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 026/151] m68k: fix command-line parsing when passed from u-boot
Date:   Wed, 27 Nov 2019 21:30:09 +0100
Message-Id: <20191127203016.991243313@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index b3536a82a2620..e002084af1012 100644
--- a/arch/m68k/kernel/uboot.c
+++ b/arch/m68k/kernel/uboot.c
@@ -103,5 +103,5 @@ __init void process_uboot_commandline(char *commandp, int size)
 	}
 
 	parse_uboot_commandline(commandp, len);
-	commandp[size - 1] = 0;
+	commandp[len - 1] = 0;
 }
-- 
2.20.1



