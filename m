Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19A6C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C372067C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOVlVtHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfLPOm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:42:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54537 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfLPOm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 09:42:26 -0500
Received: by mail-wm1-f65.google.com with SMTP id b19so6991330wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 06:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KJoLeDJ1j0DXYyFjMxUNlCQ+KXCcnYb8/fg6dDgMi/o=;
        b=sOVlVtHZXIgdspg634XjI/BfxHHQUeT5hIb5N28/nB2NlZ0GDRz9BbkBGMZ6+hyDgN
         T/3jK3jl8RPUviMWfUnlOYYvr7LO5pZrcSQPtLYkAh13LW1VO6lgC5XImMdeAlvukd3S
         RB++qReyAWymn1C22ymbKpyOFHRl+RPhIGzxvloaP7D3xLyZEun4zlGc97OZdcjN/4pW
         1sD3iDrCsd2Zp2I/wfO98SELqQQtbjBS0tkH9FxGrj45iHvJKMnVxLOfqFaDvVUpkO7a
         7bz1i+nD5ENkPjX6RvEui++l4GntcAW4GnD658V2uzdWFBgCGa/RdBXSaOiCKpq5X+wU
         j16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KJoLeDJ1j0DXYyFjMxUNlCQ+KXCcnYb8/fg6dDgMi/o=;
        b=hO4Rok6BxD7U4eTBoaSM+F47tVJsps4SdeLxeg/crOpKaF95rvU+FCF7J05avW8ngS
         6QS06+QBSugqYO96QO3OWPiX9/OZhKNnkYF7PX8ZcU7jZbRGccOXTX9YLNxfvBWmyDA/
         N1GwJHYnrqgNU/GNzrIjMzUHCZWm34aQrcDQqPPP9zXcIwZ40g7EgxUz6l10xEl2Ct79
         br2vPIYBFCJ79mLkQxQoikAZGwnAGGYhgBywObQ21lsOQNknpjrjEZJ2V+lQYkPcUhGA
         vXyg8d29QAtfaOs9SRTm2erKk9x/3VtQFhn6dZDjIEt08QvchLmehrW1s3jEnHFdWyW5
         tFmA==
X-Gm-Message-State: APjAAAUtaETVdBDl3r1c7YijBNeBQ3YyC8IseucQzkRvtIz8GabmskOl
        t51fwf4UhNjicdszQ11wG3lnkxypoV90
X-Google-Smtp-Source: APXvYqy2uHPM4SANB3GkOLx9s+ih4VLP/fs5eJBktla+gGeLfrJ0LFCxdxyi5CnQnhupcYp/VFCQnw==
X-Received: by 2002:a1c:4c5:: with SMTP id 188mr30593393wme.82.1576507343841;
        Mon, 16 Dec 2019 06:42:23 -0800 (PST)
Received: from ninjahub.lan (host-92-15-174-53.as43234.net. [92.15.174.53])
        by smtp.googlemail.com with ESMTPSA id w22sm20249113wmk.34.2019.12.16.06.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 06:42:23 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     tglx@linutronix.de, maz@kernel.org, linux-kernel@vger.kernel.org,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 1/2] kernel: irq: add releases() notation
Date:   Mon, 16 Dec 2019 14:42:07 +0000
Message-Id: <20191216144208.29852-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add releases() notation to remove issue detected by sparse tool.
 warning: context imbalance in __irq_put_desc_unlock() - unexpected unlock

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/irq/irqdesc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 5b8fdd659e54..98a5f10d1900 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -891,6 +891,7 @@ __irq_get_desc_lock(unsigned int irq, unsigned long *flags, bool bus,
 }
 
 void __irq_put_desc_unlock(struct irq_desc *desc, unsigned long flags, bool bus)
+	__releases(&desc->lock)
 {
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 	if (bus)
-- 
2.23.0

