Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A2EC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C27217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558638545;
	bh=DR2Hg/fRrmYxcQi0/v7BdYlawFDvUxGS549mG4XxQ/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XyUcQgWfO9Jwh2hpE9A6C6vchuDefh3AJmpqe81DMAnySd194KiC+Wb+fxmWRNEJT
	 sUIicVRLa8IRyBNPs4ct9kbGoYwFegq/T3/QL90fs0n8RBjE3JxonjQqDDAFMkw+ec
	 to8PTcqUzm2Xb1c1TquWsenyP7fJgj91NacVJbp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732038AbfEWTJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:09:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731992AbfEWTJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:09:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA09E21841;
        Thu, 23 May 2019 19:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558638541;
        bh=DR2Hg/fRrmYxcQi0/v7BdYlawFDvUxGS549mG4XxQ/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LEew0I1CtePbIm1nva7N0OCYSwjT6YByPxrTtE+z+hRqja3fRiELrjojqWf429TMC
         L/ddQau3FABLgMrll/9cdi62fuNAEdQJUYjCgJ31Wx67zx0lcp0gMcvDiXb1tmKQKd
         L8GdSeMqJEw1m7rn8CTO0w0rgEBSS4GjMODergwI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: [PATCH 4.9 09/53] parisc: Skip registering LED when running in QEMU
Date:   Thu, 23 May 2019 21:05:33 +0200
Message-Id: <20190523181712.376411617@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181710.981455400@linuxfoundation.org>
References: <20190523181710.981455400@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helge Deller <deller@gmx.de>

commit b438749044356dd1329c45e9b5a9377b6ea13eb2 upstream.

No need to spend CPU cycles when we run on QEMU.

Signed-off-by: Helge Deller <deller@gmx.de>
CC: stable@vger.kernel.org # v4.9+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/parisc/led.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/parisc/led.c
+++ b/drivers/parisc/led.c
@@ -568,6 +568,9 @@ int __init register_led_driver(int model
 		break;
 
 	case DISPLAY_MODEL_LASI:
+		/* Skip to register LED in QEMU */
+		if (running_on_qemu)
+			return 1;
 		LED_DATA_REG = data_reg;
 		led_func_ptr = led_LASI_driver;
 		printk(KERN_INFO "LED display at %lx registered\n", LED_DATA_REG);


