Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA619ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6A72190F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570641977;
	bh=OxtsmDZcRyjTy/TwgnZe5iInYm/ARc+kAq5vsnT/P2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pFWJ7PM1wEBo+pIoFhTALWOoWq8Ea69aM8mtDaBu28c0RevjLMBxEv+J8JOletxMK
	 IYQQJjLQp3X9v9FsYg4m+io8QniDjLRj9N/Hjj4OHL9AasxxInibR3WLInOAWgR4Gp
	 ns3Ht2z0651GeG1PB9JfUcgN0RoRFONd5/JxUOCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732723AbfJIR0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:26:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732457AbfJIRYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:24:47 -0400
Received: from sasha-vm.mshome.net (unknown [167.220.2.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8CA020B7C;
        Wed,  9 Oct 2019 17:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570641887;
        bh=OxtsmDZcRyjTy/TwgnZe5iInYm/ARc+kAq5vsnT/P2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kojkYKNZ84BIjvqH/enoWSKQ/tPp+PqVFTmea+S64Y042dlOqU8l/dDEu97AnX8AE
         FC5PUMLGpUXbCJU+U8VPmKbZ+iKScT3Plziiib1V8i2hANdEp+HVNNK7PuU6VqQqrJ
         cUweVdbx8qTTqa33092nObR1/gbxAa1yl1e/aVJA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Paul Burton <paul.burton@mips.com>, chenhc@lemote.com,
        ralf@linux-mips.org, jhogan@kernel.org, linux-mips@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 10/13] mips: Loongson: Fix the link time qualifier of 'serial_exit()'
Date:   Wed,  9 Oct 2019 13:06:29 -0400
Message-Id: <20191009170635.536-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009170635.536-1-sashal@kernel.org>
References: <20191009170635.536-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 25b69a889b638b0b7e51e2c4fe717a66bec0e566 ]

'exit' functions should be marked as __exit, not __init.

Fixes: 85cc028817ef ("mips: make loongsoon serial driver explicitly modular")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: chenhc@lemote.com
Cc: ralf@linux-mips.org
Cc: jhogan@kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/loongson64/common/serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/loongson64/common/serial.c b/arch/mips/loongson64/common/serial.c
index ffefc1cb26121..98c3a7feb10f8 100644
--- a/arch/mips/loongson64/common/serial.c
+++ b/arch/mips/loongson64/common/serial.c
@@ -110,7 +110,7 @@ static int __init serial_init(void)
 }
 module_init(serial_init);
 
-static void __init serial_exit(void)
+static void __exit serial_exit(void)
 {
 	platform_device_unregister(&uart8250_device);
 }
-- 
2.20.1

