Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA3DC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE40B20651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356168;
	bh=Z+zRC5mWqOWSLREDEnOJhPZv1KKEsZuKcPJ2BElwfcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2RLeVlROoEbvDYjE0W2kVSgl5pmL/7+v2d0sG01u6JT+XnTAPT2l7Et4ztdYRduJN
	 pjN9TheyaERi50kMhQvjW5xQbaVAHCONNKhS46l+EpWFyGFRyHTRalA/Waz/qXOGmY
	 y4LikYSm84c5F9Mc4iFRZvu5RlmoMEdlgGrHj3wc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbfDOTWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:22:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730322AbfDOTH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:07:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CE93218DA;
        Mon, 15 Apr 2019 19:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355278;
        bh=Z+zRC5mWqOWSLREDEnOJhPZv1KKEsZuKcPJ2BElwfcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A0Bmw2o9QmV/ltVXIZh3F0tpXwu4rMbdA1dk2AuEz5nWJazX3MQ6JQoRq5A8GS9zk
         fMo/iOX6EORf3I7Wh5nDEhE4CJpKecrw9mpmR+X1dpeGg/AgiXloIvaVie//6yLtMb
         GjEb/sFytEOsBqsd9dS0fCewSdQx0OAyb54hkA1A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Schnelle <svens@stackframe.org>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 4.19 058/101] parisc: also set iaoq_b in instruction_pointer_set()
Date:   Mon, 15 Apr 2019 20:58:56 +0200
Message-Id: <20190415183743.579799341@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Schnelle <svens@stackframe.org>

commit f324fa58327791b2696628b31480e7e21c745706 upstream.

When setting the instruction pointer on PA-RISC we also need
to set the back of the instruction queue to the new offset, otherwise
we will execute on instruction from the new location, and jumping
back to the old location stored in iaoq_b.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Fixes: 75ebedf1d263 ("parisc: Add HAVE_REGS_AND_STACK_ACCESS_API feature")
Cc: stable@vger.kernel.org # 4.19+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/include/asm/ptrace.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/parisc/include/asm/ptrace.h
+++ b/arch/parisc/include/asm/ptrace.h
@@ -28,7 +28,8 @@ static inline unsigned long regs_return_
 static inline void instruction_pointer_set(struct pt_regs *regs,
 						unsigned long val)
 {
-        regs->iaoq[0] = val;
+	regs->iaoq[0] = val;
+	regs->iaoq[1] = val + 4;
 }
 
 /* Query offset/name of register from its name/offset */


