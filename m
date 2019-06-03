Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02541C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3722741B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7C/10lL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbfFCQmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:42:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43610 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729427AbfFCQmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:42:17 -0400
Received: by mail-lj1-f194.google.com with SMTP id 16so3289192ljv.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 09:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZxdsJUzrzirDV9SoFUmfun9q9AXOSWclIRGIX2baL2Y=;
        b=N7C/10lLvMRhc2gCSkGs8QaF+cwD/Qcw7BW0cuFy6wQsDwPxn8AmDJJUuIvTaSjEXg
         SuzZSrENjfTHUoDrJ6gD+eOIU3cpI6oqUldqD9gs2uNz8p7DQdwOTjAg+JMH/x601m7H
         Esxj/dVD0a+fnLHEKWjDWxB9FvUVdOvgv8KqwpaScBTvTAbmRS3azMY3CwiT4OWn4i6Y
         dWBL2iKbD9fISePhoUn07PDTAFHu94rMZVQ+81cO+p8GrIJhU6lTdQO7ywMxlzLHz6vS
         cuTS+gGOJOMt2YW8aJavsWZNikY7/5MZY90WYuuJip/QPnSi9RebnPJjk6zKZH75y4Fb
         3Oaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZxdsJUzrzirDV9SoFUmfun9q9AXOSWclIRGIX2baL2Y=;
        b=q5O3Ojsoe+X4M3BrPjCT3dbQpKo+CTW0sTj7L9NW9+LKxaS/pK03MvyYJv4uPlGgvR
         EIeUDoN616qOo5Xx2TLqgK96J1IHWCTJHKX52lOYbFUOcDJbjLMkgE/CGc0dLBqmUAcg
         GIZ46V9qiqQGA397kv0x7bAArC1NM5+ydYpcQvmuTwd30znETOB9DFAXKGkFwCgKeLhU
         WCE3M02nr6t7jpcSY30bKcqUBUZMtQzkW1n71Wi/JDyW5Buyy67bNqjnpNesV+/PDKnb
         AIlVPRVq7yW7hMQBK9Y6fD9AOiAmUfw6KHDV4PF7V3k/lsFv7mSrhAhYunhWY3qR6VCg
         mrxw==
X-Gm-Message-State: APjAAAXK0iPl25ARASKEf34rfbiamJ1wVunSckLee1kpffCgfqALCC9I
        e7bRyZNh9X/P+PKwQOkWVb0=
X-Google-Smtp-Source: APXvYqxXFTRtKG8W/wE7vPy3gcwzNZsFCLLCuA9ttno3xoT+sqGIVtk64GC8X0e7QSJHyfZsXHThsg==
X-Received: by 2002:a2e:4256:: with SMTP id p83mr14154095lja.201.1559580135602;
        Mon, 03 Jun 2019 09:42:15 -0700 (PDT)
Received: from krolik-desktop.lan ([91.238.216.6])
        by smtp.gmail.com with ESMTPSA id d5sm3251109lji.85.2019.06.03.09.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 09:42:15 -0700 (PDT)
From:   Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Pawel Dembicki <paweldembicki@gmail.com>,
        Christian Lamparter <chunkeey@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Enable kernel XZ compression option on PPC_85xx
Date:   Mon,  3 Jun 2019 18:41:14 +0200
Message-Id: <20190603164115.27471-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable kernel XZ compression option on PPC_85xx. Tested with
simpleImage on TP-Link TL-WDR4900 (Freescale P1014 processor).

Suggested-by: Christian Lamparter <chunkeey@gmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8c1c636308c8..daf4cb968922 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -196,7 +196,7 @@ config PPC
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK
 	select HAVE_KERNEL_GZIP
-	select HAVE_KERNEL_XZ			if PPC_BOOK3S || 44x
+	select HAVE_KERNEL_XZ			if PPC_BOOK3S || 44x || PPC_85xx
 	select HAVE_KPROBES
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_KRETPROBES
-- 
2.20.1

