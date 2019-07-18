Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052B9C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58F5205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419642;
	bh=6TvLc+s1Z5B/h1l3/U0Pe2FamVxtuWOhIhEnM7zXQp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NYg/L5glLZj2v0mOkLM4v8GDxifes1K9R2HXBwMSwe0doQTFg5piH+VKOM13XAf1h
	 vFMLbdryHAglpV+09f65VQk1TjqRawUle59XTgsHJF9OwFNV4B6ZYIDLdawBdba5wf
	 HYcC5iF0/geOxHKy5VhNLygAHkAJPUuFFEwsA7nc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391657AbfGRDOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:14:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390583AbfGRDN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:13:56 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12DB821848;
        Thu, 18 Jul 2019 03:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419635;
        bh=6TvLc+s1Z5B/h1l3/U0Pe2FamVxtuWOhIhEnM7zXQp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lmzyvBDU+FeN2TezDPf7Rp42SG6v82t4R1HhGU8ctwGgTMQDDdRc8ClLEVUyAONm8
         rJEYQqdiKIWq94BGhnqigN9yjWbqFAY869yUjwF8/Msn8uuTus67JMF+6aQCUOOSNW
         rEZYsw2ve/D5yjVs3c6SZo4Z5H4ELrLFxkRsysjY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 4.9 51/54] ARC: hide unused function unw_hdr_alloc
Date:   Thu, 18 Jul 2019 12:02:21 +0900
Message-Id: <20190718030053.575683711@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030048.392549994@linuxfoundation.org>
References: <20190718030048.392549994@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

commit fd5de2721ea7d16e2b16c4049ac49f229551b290 upstream.

As kernelci.org reports, this function is not used in
vdk_hs38_defconfig:

arch/arc/kernel/unwind.c:188:14: warning: 'unw_hdr_alloc' defined but not used [-Wunused-function]

Fixes: bc79c9a72165 ("ARC: dw2 unwind: Reinstante unwinding out of modules")
Link: https://kernelci.org/build/id/5d1cae3f59b514300340c132/logs/
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arc/kernel/unwind.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/arch/arc/kernel/unwind.c
+++ b/arch/arc/kernel/unwind.c
@@ -185,11 +185,6 @@ static void *__init unw_hdr_alloc_early(
 				       MAX_DMA_ADDRESS);
 }
 
-static void *unw_hdr_alloc(unsigned long sz)
-{
-	return kmalloc(sz, GFP_KERNEL);
-}
-
 static void init_unwind_table(struct unwind_table *table, const char *name,
 			      const void *core_start, unsigned long core_size,
 			      const void *init_start, unsigned long init_size,
@@ -370,6 +365,10 @@ ret_err:
 }
 
 #ifdef CONFIG_MODULES
+static void *unw_hdr_alloc(unsigned long sz)
+{
+	return kmalloc(sz, GFP_KERNEL);
+}
 
 static struct unwind_table *last_table;
 


