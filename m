Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2DCC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C54204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bd0e7iEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfEQTc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:32:27 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:37092 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727714AbfEQTc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:32:26 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5A997C00E5;
        Fri, 17 May 2019 19:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1558121535; bh=j8O86pkhB/C8JdbxUYCEms78o2TDvjnHPnzfvRgCTBU=;
        h=From:To:CC:Subject:Date:From;
        b=bd0e7iEZBw/UgUZefEPip61U0Mf+y9nMaVcosE0jeKniy9v9fZApg2EWMvJgfOllG
         Y8Wt4hrz7ixqKdXIIQIoTgPCFDK2L6u13+/MMZxLQgMzLpHlvsms/ubBthw5oaTOd0
         6gMXCxjY5QjvU90xhyjAyptkfcyoyI6JobDgTdLb182mJIIM7zh8mJl1qeHcwjsU3W
         XOwryS4S5OrpCSuUUmJSKFizivb4YoD3UEQfpY/Lz38DvibpQVEOn2pbZdbSxIqn4c
         21pfIa5kueRS6X2s8u9600KohX5NtonMlM9DXYcmS3AB/Fvr59Bq7UPxyzidQPwJAD
         nxS7HN5FEBMTw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7E3A5A0067;
        Fri, 17 May 2019 19:32:25 +0000 (UTC)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 17 May 2019 12:32:25 -0700
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sat, 18 May 2019 01:02:34 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.10.161.89) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sat, 18 May 2019 01:02:21 +0530
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     <linux-snps-arc@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 0/5] Rewrite ARCv2 interrupt/expecption entry code
Date:   Fri, 17 May 2019 12:32:03 -0700
Message-ID: <1558121528-30184-1-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.10.161.89]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was along pending todo item to remove the copy-paste from NO_AUTOSAVE
support as well use LDD/STD instructions for better generated code.

Thx,
-Vineet

Vineet Gupta (5):
  ARCv2: entry: comments about hardware auto-save on taken interrupts
  ARCv2: entry: push out the Z flag unclobber from common
    EXCEPTION_PROLOGUE
  ARCv2: entry: avoid a branch
  ARCv2: entry: rewrite to enable use of double load/stores LDD/STD
  ARC: entry: EV_Trap expects r10 (vs. r9) to have exception cause

 arch/arc/include/asm/entry-arcv2.h   | 361 ++++++++++++++++++-----------------
 arch/arc/include/asm/entry-compact.h |   4 +-
 arch/arc/include/asm/linkage.h       |  18 ++
 arch/arc/kernel/asm-offsets.c        |   7 +
 arch/arc/kernel/entry-arcv2.S        |   4 +-
 arch/arc/kernel/entry.S              |   4 +-
 arch/arc/mm/tlbex.S                  |  11 ++
 7 files changed, 232 insertions(+), 177 deletions(-)

-- 
2.7.4

