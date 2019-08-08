Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3246EC32754
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 00:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D6B217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 00:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EQ1V5532"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbfHHAxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 20:53:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44468 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730433AbfHHAxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 20:53:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so43019622pfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 17:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RYvASjp7Wn9RMY59p408gW18WYgaC6cZBG6rwBoYt8c=;
        b=EQ1V5532pWSC01xRIbBals7TfyG8s0+WGku7qiJ5OJ8JmmQN7e+VFUFiIRP4vj2NWq
         SJtgkNzW3gStYja/vtBrUY+SBwOsXWnZsCNGWiGNjGtg6Yji/EkgQ3mDYSdjFuJm3BC/
         YKOCb/nDnL1cpXWi/bMZHltHFiEn8YRLmKfnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RYvASjp7Wn9RMY59p408gW18WYgaC6cZBG6rwBoYt8c=;
        b=Em/XoUKdczt4+HlQPp7HbaDDaCok/HxShe0Hp6cfXmm1+CfeiBTNeOWcnYo3RwKD29
         GazKYwyYJfAofPxxXHp9iCM2pt0DhOSJTIPGWdv/FX5YyXy5RWycC8yAdIMzd56r1POZ
         ldrS2XMKH5ufyLggG9w5ksUuspLeB9R62gfcIMaWLP8dQXHgo6QIVVJc+6OIqW6P8bIp
         qRBgrJmAWPp4PwJoxhNfRfQxZNTtwN12gTWU2ghA7W//oGus1BfWEJtoGX2DDoVd/lQ8
         GQqkuvnnuos0tir+zqoB+EygaaO/1YEJcivcpedyQa8uCP9NUFBbxT981O5o3uVgDMMF
         w8pw==
X-Gm-Message-State: APjAAAVxG10cF/0wOnKRBprp3JXE+toHQ/UZRwj7+7dsPPUZuIztxdGF
        IYuVrLts74HH5Y8UeRBGNCFyyohUFV8=
X-Google-Smtp-Source: APXvYqyMfzV1h6/SCyekjmDcrbuLcZLPLV1nHCP/caQMz+jJuG+42aGNUBeRBEeIFp/PVkM4tniLEw==
X-Received: by 2002:aa7:93bb:: with SMTP id x27mr12721421pff.10.1565225595039;
        Wed, 07 Aug 2019 17:53:15 -0700 (PDT)
Received: from egranata0.mtv.corp.google.com ([2620:15c:202:0:20e7:7eb9:f5ee:bbbc])
        by smtp.gmail.com with ESMTPSA id 64sm94456617pfe.128.2019.08.07.17.53.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 17:53:14 -0700 (PDT)
From:   egranata@chromium.org
To:     linux-kernel@vger.kernel.org
Cc:     mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        trivial@kernel.org, egranata@google.com
Subject: [PATCH] vhost: do not reference a file that does not exist
Date:   Wed,  7 Aug 2019 17:52:55 -0700
Message-Id: <20190808005255.106299-1-egranata@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enrico Granata <egranata@google.com>

lguest was removed from the mainline kernel in late 2017.

Signed-off-by: Enrico Granata <egranata@google.com>
---
 drivers/vhost/vhost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 0536f8526359..2c376cb66971 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -4,8 +4,8 @@
  *
  * Author: Michael S. Tsirkin <mst@redhat.com>
  *
- * Inspiration, some code, and most witty comments come from
- * Documentation/virtual/lguest/lguest.c, by Rusty Russell
+ * Inspiration, some code, and most witty comments come from lguest.c
+ * by Rusty Russell
  *
  * Generic code for virtio server in host kernel.
  */
-- 
2.22.0.770.g0f2c4a37fd-goog

