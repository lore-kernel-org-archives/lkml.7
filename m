Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D44AC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E8D205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012563;
	bh=XGQqCVW6zSXcWoE/i4NhLzwM9TEfNzVmYhy2pL5CaBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MqP2ToENoK1iPXcOJ0tHxRPOx4DGjOOrvRX9c16meYV7VHZR61naq5zwxhRaQ7qFa
	 dTlVt+dz61Pw9b0/Ym1XA0BTFoDLQjDgBNpxNfYdPXZvsLLLNBptJgfIjqz2A1EqLE
	 bbukEGEwyyJLZmvKYKbF5fXbFWtFsg+62AvYEb8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfLJVN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:13:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:39388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729263AbfLJVNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:13:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16D0C214D8;
        Tue, 10 Dec 2019 21:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012398;
        bh=XGQqCVW6zSXcWoE/i4NhLzwM9TEfNzVmYhy2pL5CaBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bgHqBzgM42g9uOGW+ZmHbgB2DDUOOu80hpiRZrqCEMLAwcDVeOv3AC1MuJUtZrCuN
         xcfNdCC7bbvOjiKPT73dkLlNsXv776WtkzxbrcFqG2FZs8chk7WwYWCISdx4PMcfyx
         D77eu8Szc2Q4Bv7V8jrdEjVtWJopL+77+rvwTFrc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 318/350] s390/kasan: support memcpy_real with TRACE_IRQFLAGS
Date:   Tue, 10 Dec 2019 16:07:03 -0500
Message-Id: <20191210210735.9077-279-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit 13f9bae579c6bd051e58f326913dd09af1291208 ]

Currently if the kernel is built with CONFIG_TRACE_IRQFLAGS and KASAN
and used as crash kernel it crashes itself due to
trace_hardirqs_off/trace_hardirqs_on being called with DAT off. This
happens because trace_hardirqs_off/trace_hardirqs_on are instrumented and
kasan code tries to perform access to shadow memory to validate memory
accesses. Kasan shadow memory is populated with vmemmap, so all accesses
require DAT on.

memcpy_real could be called with DAT on or off (with kasan enabled DAT
is set even before early code is executed).

Make sure that trace_hardirqs_off/trace_hardirqs_on are called with DAT
on and only actual __memcpy_real is called with DAT off.

Also annotate __memcpy_real and _memcpy_real with __no_sanitize_address
to avoid further problems due to switching DAT off.

Reviewed-by: Philipp Rudo <prudo@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/mm/maccess.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/s390/mm/maccess.c b/arch/s390/mm/maccess.c
index 1864a8bb9622f..59ad7997fed16 100644
--- a/arch/s390/mm/maccess.c
+++ b/arch/s390/mm/maccess.c
@@ -70,7 +70,7 @@ void notrace s390_kernel_write(void *dst, const void *src, size_t size)
 	spin_unlock_irqrestore(&s390_kernel_write_lock, flags);
 }
 
-static int __memcpy_real(void *dest, void *src, size_t count)
+static int __no_sanitize_address __memcpy_real(void *dest, void *src, size_t count)
 {
 	register unsigned long _dest asm("2") = (unsigned long) dest;
 	register unsigned long _len1 asm("3") = (unsigned long) count;
@@ -91,19 +91,23 @@ static int __memcpy_real(void *dest, void *src, size_t count)
 	return rc;
 }
 
-static unsigned long _memcpy_real(unsigned long dest, unsigned long src,
-				  unsigned long count)
+static unsigned long __no_sanitize_address _memcpy_real(unsigned long dest,
+							unsigned long src,
+							unsigned long count)
 {
 	int irqs_disabled, rc;
 	unsigned long flags;
 
 	if (!count)
 		return 0;
-	flags = __arch_local_irq_stnsm(0xf8UL);
+	flags = arch_local_irq_save();
 	irqs_disabled = arch_irqs_disabled_flags(flags);
 	if (!irqs_disabled)
 		trace_hardirqs_off();
+	__arch_local_irq_stnsm(0xf8); // disable DAT
 	rc = __memcpy_real((void *) dest, (void *) src, (size_t) count);
+	if (flags & PSW_MASK_DAT)
+		__arch_local_irq_stosm(0x04); // enable DAT
 	if (!irqs_disabled)
 		trace_hardirqs_on();
 	__arch_local_irq_ssm(flags);
-- 
2.20.1

