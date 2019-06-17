Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1571C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853D02084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="U3MmIqGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfFQKc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 06:32:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50105 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFQKc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 06:32:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HAWVh43369424
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 03:32:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HAWVh43369424
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560767551;
        bh=SGiDScOW+04JIag0rskL4Q58SLPhRhXUC5m2sT3LU2Q=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=U3MmIqGEqoNLxyRVY/uzpG2hFXgidkHhjByatvdEh5SOWbYjYP3EN0Oy541mzBeoI
         G1epuWlaOZGAfBY7GiqXHvTCOyYwIf9z4FIIHxX0YfjrwmXiCIgAUS2Uyjo0bbjdSz
         tQxX/veCiQaYofWNWXufOJkoO2niivQagkhg6VqOl+8tF3BuWbww2DCDBAd8exFssI
         ymNZwX5KwJGjQop8yHq5ywLEd3ejeD6hTlvUHYTz0fXbVBY/rKxm1Bg/ph61nOulTx
         T1qY0URt2i2krndQYVMFeS36KNcUdlDEIv7XFN2swQaF9agXlLy5T6y1XKJkscvT/n
         +D30W6DTckoDg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HAWUgu3369421;
        Mon, 17 Jun 2019 03:32:30 -0700
Date:   Mon, 17 Jun 2019 03:32:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Christoph Hellwig <tipbot@zytor.com>
Message-ID: <tip-466329bf407cc5143c3211620faa2c132b9d9a06@git.kernel.org>
Cc:     hpa@zytor.com, dave.hansen@intel.com, mingo@kernel.org, bp@suse.de,
        nstange@suse.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, tglx@linutronix.de, mingo@redhat.com,
        hch@lst.de, riel@surriel.com
Reply-To: x86@kernel.org, nstange@suse.de, bp@suse.de,
          dave.hansen@intel.com, mingo@kernel.org, hpa@zytor.com,
          riel@surriel.com, hch@lst.de, mingo@redhat.com,
          tglx@linutronix.de, bigeasy@linutronix.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190604071524.12835-4-hch@lst.de>
References: <20190604071524.12835-4-hch@lst.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Remove the fpu__save() export
Git-Commit-ID: 466329bf407cc5143c3211620faa2c132b9d9a06
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  466329bf407cc5143c3211620faa2c132b9d9a06
Gitweb:     https://git.kernel.org/tip/466329bf407cc5143c3211620faa2c132b9d9a06
Author:     Christoph Hellwig <hch@lst.de>
AuthorDate: Tue, 4 Jun 2019 09:15:24 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 17 Jun 2019 12:21:26 +0200

x86/fpu: Remove the fpu__save() export

This function is only use by the core FPU code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190604071524.12835-4-hch@lst.de
---
 arch/x86/kernel/fpu/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 3f92cfad88f0..12c70840980e 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -134,7 +134,6 @@ void fpu__save(struct fpu *fpu)
 	trace_x86_fpu_after_save(fpu);
 	fpregs_unlock();
 }
-EXPORT_SYMBOL_GPL(fpu__save);
 
 /*
  * Legacy x87 fpstate state init:
