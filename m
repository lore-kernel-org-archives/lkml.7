Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53559C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D4120870
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574891048;
	bh=GMCMZVZyPuN5NMozSn6VCkOqGa3amAy7oERLUQtw55Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P0MIxQ3mu+0L+LrA+umgJ4yLMODvI8gR/UoOSz0sieMvu+Bt7V4oJrBPeu84bvGPQ
	 EKwe4Hk9kj1Fsg1CsdKjX6ttOWHvH2DJrXHHVgIa/yUTcC3owpmoNexqjlAQPu9rfu
	 LxRDqjtqtbiK9ZAmFJHLj3VvuIatyEpso65Dvk/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbfK0VoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:44:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:41140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727543AbfK0Uh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:37:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F034C2168B;
        Wed, 27 Nov 2019 20:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887075;
        bh=GMCMZVZyPuN5NMozSn6VCkOqGa3amAy7oERLUQtw55Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hmGI4vaqJDcPOLC6uHY2mZwNxEpEZfbB+2Ole9cgYgta+IN4iinmCn2ZN7Wx9NKmY
         tG+w4zdmffsT/5SQL47Hgv1IyMmYWvI8rVpZjIUweFnbWFiYbEWrNWJrJ3kKkskyHH
         fyEu8aJaxMbKnvSoJyJEDWAn6bPNDa4mMsoE3ikU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hari Vyas <hari.vyas@broadcom.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.4 102/132] arm64: fix for bad_mode() handler to always result in panic
Date:   Wed, 27 Nov 2019 21:31:33 +0100
Message-Id: <20191127203024.460050620@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202857.270233486@linuxfoundation.org>
References: <20191127202857.270233486@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hari Vyas <hari.vyas@broadcom.com>

commit e4ba15debcfd27f60d43da940a58108783bff2a6 upstream.

The bad_mode() handler is called if we encounter an uunknown exception,
with the expectation that the subsequent call to panic() will halt the
system. Unfortunately, if the exception calling bad_mode() is taken from
EL0, then the call to die() can end up killing the current user task and
calling schedule() instead of falling through to panic().

Remove the die() call altogether, since we really want to bring down the
machine in this "impossible" case.

Signed-off-by: Hari Vyas <hari.vyas@broadcom.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/traps.c |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -448,7 +448,6 @@ asmlinkage void bad_mode(struct pt_regs
 	pr_crit("Bad mode in %s handler detected, code 0x%08x -- %s\n",
 		handler[reason], esr, esr_get_class_string(esr));
 
-	die("Oops - bad mode", regs, 0);
 	local_irq_disable();
 	panic("bad mode");
 }


