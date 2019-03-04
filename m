Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B525C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE00820823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551689128;
	bh=1SwplH6VUws6P5E0c+remyQ9+KqB2xc+5OF72RAyawU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MHlEkvf7ZF4/ezXJtlmdEW2XLazNJwxmr37QyVl0CAcyywUoiiCG1+t7ZwadLFxJw
	 A2AbcKjyv7f15j+veVRKbKd2qzWYjwf9cW7uG9FNR3fHiVK8Rxn5B96OTOCa6jVQCy
	 pRIF2dGDbB3FTz6vFSIB5oUKiumIP/pCYYsHiwpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfCDIp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:45:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbfCDI1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:27:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E31020823;
        Mon,  4 Mar 2019 08:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688060;
        bh=1SwplH6VUws6P5E0c+remyQ9+KqB2xc+5OF72RAyawU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=drq0BKo+ePH8jhq0cz3s8xhLVR3AdsMrmw3tKYdIwNvNpiH/uvS7wWlgIQuhSO69a
         uWML5RINm7EuhBLZtthpDTqKKj6DQcT4+RD8/ObybtOcu7D/Wy22ZIrSJ7LOAi/PjR
         mLAwp/MeGkYpKyLkclGXSmOJPKcROUSEZNp22Opw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, RISC-V Patches <patches@groups.riscv.org>,
        Linux RISC-V <linux-riscv@lists.infradead.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Michael Clark <michaeljclark@mac.com>,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH 4.14 50/52] MIPS: fix truncation in __cmpxchg_small for short values
Date:   Mon,  4 Mar 2019 09:22:48 +0100
Message-Id: <20190304081619.964223194@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081617.159014799@linuxfoundation.org>
References: <20190304081617.159014799@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Clark <michaeljclark@mac.com>

commit 94ee12b507db8b5876e31c9d6c9d84f556a4b49f upstream.

__cmpxchg_small erroneously uses u8 for load comparison which can
be either char or short. This patch changes the local variable to
u32 which is sufficiently sized, as the loaded value is already
masked and shifted appropriately. Using an integer size avoids
any unnecessary canonicalization from use of non native widths.

This patch is part of a series that adapts the MIPS small word
atomics code for xchg and cmpxchg on short and char to RISC-V.

Cc: RISC-V Patches <patches@groups.riscv.org>
Cc: Linux RISC-V <linux-riscv@lists.infradead.org>
Cc: Linux MIPS <linux-mips@linux-mips.org>
Signed-off-by: Michael Clark <michaeljclark@mac.com>
[paul.burton@mips.com:
  - Fix varialble typo per Jonas Gorski.
  - Consolidate load variable with other declarations.]
Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: 3ba7f44d2b19 ("MIPS: cmpxchg: Implement 1 byte & 2 byte cmpxchg()")
Cc: stable@vger.kernel.org # v4.13+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/cmpxchg.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/mips/kernel/cmpxchg.c
+++ b/arch/mips/kernel/cmpxchg.c
@@ -54,10 +54,9 @@ unsigned long __xchg_small(volatile void
 unsigned long __cmpxchg_small(volatile void *ptr, unsigned long old,
 			      unsigned long new, unsigned int size)
 {
-	u32 mask, old32, new32, load32;
+	u32 mask, old32, new32, load32, load;
 	volatile u32 *ptr32;
 	unsigned int shift;
-	u8 load;
 
 	/* Check that ptr is naturally aligned */
 	WARN_ON((unsigned long)ptr & (size - 1));


