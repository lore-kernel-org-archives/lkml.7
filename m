Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7033C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DDC20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f2Vz+bmb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfCFX7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:59:34 -0500
Received: from mail-ua1-f73.google.com ([209.85.222.73]:46083 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfCFX7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:59:31 -0500
Received: by mail-ua1-f73.google.com with SMTP id r16so2004956uam.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 15:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kn7ZudvBI/03PKgGXw1nMgRojbgZaoMdjyO+S6moRI0=;
        b=f2Vz+bmb72rU8TXAbQUVHV/BS0XxQR8BaDpblMSQJPvqTAWAo8FH6rjvvkmty1lXVN
         SzbdDgeM7GDCN25rpO5I6dfPl172rEj48Xad3Rn1rWnePrIISwkcDNMZIJmSIebAXse+
         XsVqdOdk6J8igYLtIHxW3P/+wEq3nZluCfBLzTbUCUGfEXzDRA1DVrey/hGgFxWjydo3
         Br/WOcIb/h3fwOLZ2puu0+j4YYS73MJj2SVkJvV2a2cVei0ql1giXtp6b0EqMo9Pcxzl
         jYU7HM0VYldodlzN4As8zcXSrmqAaZohjTwKA7+CtISN8JHqDUXoLL6uQwYuEijyqLYM
         4KPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kn7ZudvBI/03PKgGXw1nMgRojbgZaoMdjyO+S6moRI0=;
        b=gNi7Np0YFK1JISrP3EEVZgpzYWAHIADjTXcwqPkagio9HnjrjoVlIpvev0E2UEqcu0
         T7VzjQ1vgAG+ZdqWVcINxBWYFG9rCDrhFz38ALe3V7A09HTjKN5L+fYu8GdWkD+Sx+KW
         bRj+MDAOkkktYyhC/0U9Tw17nYV+gc/81S0VVtN+y1kMt7yE0CBhL7R+5j3LLCAe4k39
         VcTaZquq8nq3slSQtiQC1CWr1vmgDiYp+nXwxGESrXLWFGm544xELRHGAsMgn8tlQ6he
         plTXQYYt3vxo9toldlWhXc/aEhvWvh2N/BHOuv33r3fD2a9ktaPQ80ETtIj3PK4ZOPPg
         GNpw==
X-Gm-Message-State: APjAAAXufHmnPm9tZX7bN7MMtkQ7oP3k79LUd0V6ALpDFbgjCojPpgTy
        PzFC0cRRjl2FaOvqfA02LqqTNw2umGtSwCFc0fG+rg==
X-Google-Smtp-Source: APXvYqwyBc76ufuJgNf8QJakf/yJtUfkEIU7N/GIlS1vx/hEpjh3/Zv/RjQsP/AVVZEJ5HM0N9SUhN/riL25JNLsYMv5wA==
X-Received: by 2002:ab0:641a:: with SMTP id x26mr6875819uao.12.1551916770265;
 Wed, 06 Mar 2019 15:59:30 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:58:50 -0800
In-Reply-To: <20190306235913.6631-1-matthewgarrett@google.com>
Message-Id: <20190306235913.6631-5-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 04/27] Restrict /dev/{mem,kmem,port} when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

Allowing users to read and write to core kernel memory makes it possible
for the kernel to be subverted, avoiding module loading restrictions, and
also to steal cryptographic information.

Disallow /dev/mem and /dev/kmem from being opened this when the kernel has
been locked down to prevent this.

Also disallow /dev/port from being opened to prevent raw ioport access and
thus DMA from being used to accomplish the same thing.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 drivers/char/mem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index b08dc50f9f26..0a2f2e75d5f4 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -786,6 +786,8 @@ static loff_t memory_lseek(struct file *file, loff_t offset, int orig)
 
 static int open_port(struct inode *inode, struct file *filp)
 {
+	if (kernel_is_locked_down("/dev/mem,kmem,port"))
+		return -EPERM;
 	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
 }
 
-- 
2.21.0.352.gf09ad66450-goog

