Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F24C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E90B2054F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="TFWEEk/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbfHET45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 15:56:57 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.31]:24208 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727830AbfHET45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 15:56:57 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 7C1F138D478
        for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2019 14:56:56 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id uj6GhEvYj3Qi0uj6GhyOIS; Mon, 05 Aug 2019 14:56:56 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=73Ji5AC5KMZkK6fMpGAVZtl81St9Sv4vNuTrXk8naK0=; b=TFWEEk/b9uZIVs5YGnNE/9ccy7
        PDvhGCy+g1TPRCp2xjIOnkiIg4MufYBfidkzLklG58cOzHy5XRrHBTkwZgK0gZgHfelJ3SHuJs3/F
        0/KIy2Ey0l/Tmk6r3XrcSpegCpYoX5RYadmTQ3Hev3wQ9vwzYV5RwuqG9Ei8afqp6F2mmtePBZlsk
        QdRQD5dzVyFfKU/57/b5jmQNhFP6WEi0mjMPho0XYtCMxCVMWgM00uJjySVzVQAYl8Ta+BfykgJTb
        RX2zBRqJjblObc420r2XrLCjDBHKJXSEgLFfVcRd+bdOqzZwrsL0RSzKpdDIBD3wj6NMEUnYNciWV
        gLESlD9w==;
Received: from [187.192.11.120] (port=38244 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1huj6F-003UPU-B4; Mon, 05 Aug 2019 14:56:55 -0500
Date:   Mon, 5 Aug 2019 14:56:54 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] x86/ptrace: Mark expected switch fall-through
Message-ID: <20190805195654.GA17831@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1huj6F-003UPU-B4
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:38244
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 21
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

Fix the following warning (Building: allnoconfig i386):

arch/x86/kernel/ptrace.c:202:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (unlikely(value == 0))
      ^
arch/x86/kernel/ptrace.c:206:2: note: here
  default:
  ^~~~~~~

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 arch/x86/kernel/ptrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 0fdbe89d0754..3c5bbe8e4120 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -201,6 +201,7 @@ static int set_segment_reg(struct task_struct *task,
 	case offsetof(struct user_regs_struct, ss):
 		if (unlikely(value == 0))
 			return -EIO;
+		/* Else, fall through */
 
 	default:
 		*pt_regs_access(task_pt_regs(task), offset) = value;
-- 
2.22.0

