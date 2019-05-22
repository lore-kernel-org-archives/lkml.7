Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0277CC18E7C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 00:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC07F217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 00:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKkfQhz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfEVAgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 20:36:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40700 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfEVAgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 20:36:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id d30so352553pgm.7;
        Tue, 21 May 2019 17:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xbyzh1GJJ8m0Sm1ENljBkms7F5sprXDnDoT8XWgkBJE=;
        b=PKkfQhz87VyLXywfWJU0zQCGTaOjfOsBWtuSXc8bcUmWt3ddU25a0weMhIItrXdrXY
         a1AeEKPD19hJGoD92FnQM/EJugJaI6h3BfU7BDUvPHlCiyQm5/99wgOvDyKrSxuQKa74
         Xf0x2HcIDuFdprsYOgziU9IYsdHigA56WAGBLyLFIF79sUV0fDZYrii1BuDEnaUYGU70
         VoKttFxTbBrpnEy7zt++M9GgkngCSHpsb91dEamU2bXGia1tpm+AeaNu6jlT1MuD8YP1
         pYgDQC3UJ3eyUWklehfS9FJHlaWf8A9jlEhYqILCeKMwPsRee4cWQPzao65Jt7TOMsHX
         objw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xbyzh1GJJ8m0Sm1ENljBkms7F5sprXDnDoT8XWgkBJE=;
        b=BUUz30EBKXNaiKWGD2wKm57EOBBUnwR3orUuNkVtBmhQqCEFh1f7fgP2fQjtFDLifX
         2VjQ7UB9/VmPGRZazw264Dl0RQG12SXhzhm9di2awlx0pkDH9kFv4/6VBB28q799yVvJ
         S47orEtuDsQblpH3bKXylqYyJl5TlAmYSmhqR0cp8bQM2/CJBK7DRS5AGs8jvI3mOift
         BWq27xq3OJsEiE+ElIm3THHEBziQUkhw4enRkdUnswGMzKzNX6pf5doscP+Z6anMCzcx
         oiFWTw1Pgdd+wq5bk6byQ4tecrRyIFUt3+UGmzmIqyEKEwgTBU9YORt/YMgyKWaZjWqk
         xjuQ==
X-Gm-Message-State: APjAAAXrE7upY4VW6BDJsY8bv0AVrhx9z2tCeNaejPsLZHmQAMmRpMT5
        0S8Cw9GKVkYKFWQcZWGsa6Q=
X-Google-Smtp-Source: APXvYqyWEM2ys6h9C/EWx0uwlzEjQDxreysX5yp85RmjiTBxeSOaRxKQLGuzPsoBvtLxYOIjQeKCbw==
X-Received: by 2002:a65:4649:: with SMTP id k9mr87616022pgr.239.1558485367175;
        Tue, 21 May 2019 17:36:07 -0700 (PDT)
Received: from localhost ([2601:640:4:f15a:d07:291f:4ccd:776a])
        by smtp.gmail.com with ESMTPSA id u6sm33092780pfa.1.2019.05.21.17.36.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 17:36:06 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
To:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <ynorov@marvell.com>, Qian Cai <cai@lca.pw>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] slab: cleanup after /proc/slab_allocators removal
Date:   Tue, 21 May 2019 17:36:04 -0700
Message-Id: <20190522003604.28236-1-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yury Norov <ynorov@marvell.com>

The commit 7878c231dae0 ("slab: remove /proc/slab_allocators")
removes DEBUG_SLAB_LEAK config everywhere but a parisc config.
It doesn't look intentional. Fix it.

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 arch/parisc/configs/c8000_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/parisc/configs/c8000_defconfig b/arch/parisc/configs/c8000_defconfig
index 088ab948a5ca..900b00084953 100644
--- a/arch/parisc/configs/c8000_defconfig
+++ b/arch/parisc/configs/c8000_defconfig
@@ -225,7 +225,6 @@ CONFIG_UNUSED_SYMBOLS=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_SLAB=y
-CONFIG_DEBUG_SLAB_LEAK=y
 CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_PANIC_ON_OOPS=y
-- 
2.17.1

