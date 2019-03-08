Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F3BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E622085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049589;
	bh=hZqm+KjDh9PPuZn/9v8ye7LVHhAIMQDMdOM+dX1bEFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=scLWJen0u0z3RSjaLCvffo9T7zkr5WtlH4ALIV4/u/CHGKkXewprIfhYnguFcXpX/
	 QUQXfD5JJEjIGwiyk73BJbzIEk2sK9GX49nvWyMp2Vsget74FBJuW2FF+WnQWw0swr
	 5Nd0wQ5kQvERCTNOUy1XpVoKG9YdzW5XMyk9OT44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfCHMxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:53:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:56806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbfCHMxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:53:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15DC02087C;
        Fri,  8 Mar 2019 12:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049586;
        bh=hZqm+KjDh9PPuZn/9v8ye7LVHhAIMQDMdOM+dX1bEFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U3stpnYb7cgcOeTEKzYy8/dUDNzopVWlvutKCvR2IoXUgeYYYFxSr/PuH4kr0JAmB
         TBFrxHRbH7RWjEmh9m7dTU4OJ25fARWvSWBffsRlq+8wg97qIGA4yqoSQwggaEXIqg
         +XX/r/vsB7k8VzwDyzyoUMvHNRaZDCDUidOv6C4I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 5.0 38/46] xtensa: fix get_wchan
Date:   Fri,  8 Mar 2019 13:50:11 +0100
Message-Id: <20190308124904.704863160@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124902.257040783@linuxfoundation.org>
References: <20190308124902.257040783@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Filippov <jcmvbkbc@gmail.com>

commit d90b88fd3653f1fb66ecc6571b860d5a5749fa56 upstream.

Stack unwinding is implemented incorrectly in xtensa get_wchan: instead
of extracting a0 and a1 registers from the spill location under the
stack pointer it extracts a word pointed to by the stack pointer and
subtracts 4 or 3 from it.

Cc: stable@vger.kernel.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/xtensa/kernel/process.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -321,8 +321,8 @@ unsigned long get_wchan(struct task_stru
 
 		/* Stack layout: sp-4: ra, sp-3: sp' */
 
-		pc = MAKE_PC_FROM_RA(*(unsigned long*)sp - 4, sp);
-		sp = *(unsigned long *)sp - 3;
+		pc = MAKE_PC_FROM_RA(SPILL_SLOT(sp, 0), sp);
+		sp = SPILL_SLOT(sp, 1);
 	} while (count++ < 16);
 	return 0;
 }


