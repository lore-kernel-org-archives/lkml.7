Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168ECC606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2C021783
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599459;
	bh=KawLcqAK8Jtlnzz5LbCaBUmEuHDVz6zoCaHEviFevVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IQ/2AA6A2LLuMmr8WKII9lLXuBvBHj8tIOEegUe6DkZPn94NWyDyI3sSjWvdEdRIi
	 tf6s4LW/A5zFqBxy4yNuGSeg56omu95o2mhq4vdhAIHFK55pTQ/qeBw23EricZrlpS
	 wXqO0z1VjVXWkyG72bWWuN1qfbSkz0A3ujNzzqFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732235AbfGHPYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:24:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388328AbfGHPYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:24:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41CA0214C6;
        Mon,  8 Jul 2019 15:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599454;
        bh=KawLcqAK8Jtlnzz5LbCaBUmEuHDVz6zoCaHEviFevVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qs+gVPY2oD4Pjd9CmZFoMm3fFcHVIpLBA94U0zsck0SHFvgjeB38s76HbvJdHX7Nh
         uq7AY4WPpbUyimh3Qz/Q2OtShnszqI6L4a/O/i0W3k+fdZuaep330uHaQphW5b6/NS
         9hKW9t1371MkpxbnGD+08AGjvjPaGUvDaV/SVcaw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Ganesan Ramalingam <ganesanr@broadcom.com>,
        James Hogan <jhogan@kernel.org>,
        Jayachandran C <jnair@caviumnetworks.com>,
        John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 21/56] MIPS: netlogic: xlr: Remove erroneous check in nlm_fmn_send()
Date:   Mon,  8 Jul 2019 17:13:13 +0200
Message-Id: <20190708150520.811521205@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150514.376317156@linuxfoundation.org>
References: <20190708150514.376317156@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 02eec6c9fc0cb13169cc97a6139771768791f92b ]

In nlm_fmn_send() we have a loop which attempts to send a message
multiple times in order to handle the transient failure condition of a
lack of available credit. When examining the status register to detect
the failure we check for a condition that can never be true, which falls
foul of gcc 8's -Wtautological-compare:

  In file included from arch/mips/netlogic/common/irq.c:65:
  ./arch/mips/include/asm/netlogic/xlr/fmn.h: In function 'nlm_fmn_send':
  ./arch/mips/include/asm/netlogic/xlr/fmn.h:304:22: error: bitwise
    comparison always evaluates to false [-Werror=tautological-compare]
     if ((status & 0x2) == 1)
                        ^~

If the path taken if this condition were true all we do is print a
message to the kernel console. Since failures seem somewhat expected
here (making the console message questionable anyway) and the condition
has clearly never evaluated true we simply remove it, rather than
attempting to fix it to check status correctly.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/20174/
Cc: Ganesan Ramalingam <ganesanr@broadcom.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Jayachandran C <jnair@caviumnetworks.com>
Cc: John Crispin <john@phrozen.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/netlogic/xlr/fmn.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/xlr/fmn.h b/arch/mips/include/asm/netlogic/xlr/fmn.h
index 5604db3d1836..d79c68fa78d9 100644
--- a/arch/mips/include/asm/netlogic/xlr/fmn.h
+++ b/arch/mips/include/asm/netlogic/xlr/fmn.h
@@ -301,8 +301,6 @@ static inline int nlm_fmn_send(unsigned int size, unsigned int code,
 	for (i = 0; i < 8; i++) {
 		nlm_msgsnd(dest);
 		status = nlm_read_c2_status0();
-		if ((status & 0x2) == 1)
-			pr_info("Send pending fail!\n");
 		if ((status & 0x4) == 0)
 			return 0;
 	}
-- 
2.20.1



