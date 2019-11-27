Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AF0C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C8D2158A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887555;
	bh=J2jEDIB84FkSWu1oMfmtTGw5MNeF5Bk9bqktBzNWDWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uTcpTsKrRF2O8F26Ng8SQw5wCIOgDLvyGS0BcJMvSUFYPamqnr5jvLb8y4KhVqeHS
	 Xi4MpAAD8IMjXMUoivx5BlJnIXcWi6Frzmcx1Jh50QPJvhItXWzJuBC+oPmMp5rhhV
	 z+cyxjOt71Hx5DeHdD8d3Tb0C/nxnLb60UH1emgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfK0Upy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:45:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:57170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729792AbfK0Upv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:45:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01FD4217D9;
        Wed, 27 Nov 2019 20:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887551;
        bh=J2jEDIB84FkSWu1oMfmtTGw5MNeF5Bk9bqktBzNWDWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xT6qeFo2rBoU+bxvxpsCJTWbmffIDhJrt01YfiyX1tfMntx0fc0am6CQqswLnC1aX
         l4zeqWTFot1p09LBL+LK9Yb77I6Ctvw1Y8h4X1vC3qYx2XTVH1dx2eq9CtziJhGjDL
         IvNKIEzwF7x5DFTv/TjLVVlPf06PPR5vZQ4TqJAg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hari Vyas <hari.vyas@broadcom.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.9 114/151] arm64: fix for bad_mode() handler to always result in panic
Date:   Wed, 27 Nov 2019 21:31:37 +0100
Message-Id: <20191127203043.904101337@linuxfoundation.org>
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
@@ -611,7 +611,6 @@ asmlinkage void bad_mode(struct pt_regs
 		handler[reason], smp_processor_id(), esr,
 		esr_get_class_string(esr));
 
-	die("Oops - bad mode", regs, 0);
 	local_irq_disable();
 	panic("bad mode");
 }


