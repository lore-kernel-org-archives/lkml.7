Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079E7C2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 16:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1B82176D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 16:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOuV4oow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfLYQzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 11:55:41 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42572 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfLYQzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 11:55:41 -0500
Received: by mail-pl1-f196.google.com with SMTP id p9so9589051plk.9;
        Wed, 25 Dec 2019 08:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AySHyODX723ypmTC5O2oQybWpRk/Zz477qDH+2iKNgc=;
        b=oOuV4oowDUNNEP1zGbyM86daC5q8vhrFyNvDRI5PuNHF1bMi826cqx6Ezio3cjELdk
         pRc+s/kp9b8mq/ZBERaL/stJVv+YlAy0SuE7Ho5pdD8YO0kdcpLoQ18ZrzY0UkflS04x
         iQ4OXpAR1XraTAlbLGuv1EgEm5VpMhIS8+y+q2PMGFiy76i0DquY2XHVvU1vVJ6dcXq0
         ceGpImP8ntDjQA4/5A8kXO7n0gkpcEbwlkteSZWcba2xCXoK155R+reiy8sPaOrdXC52
         u/O3D596FEj44rgAw3xIuLxdI+z4mkIMWRES6X1JLwy6U2oqBhsMk4XDrFszLb1EWpTv
         mmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AySHyODX723ypmTC5O2oQybWpRk/Zz477qDH+2iKNgc=;
        b=JZJZkRTO7/BW0FBk5yhfRNkD302XMBE8XPnMmKbsjjt9LFEZc9dVpkYgQAoDut8lTz
         vqa9NQrgEe1Y9nqhS7NJ0w/aoP5umGqrfEyylAv1NV+YlHWcECTF4T9LD0+v+4HY0dsw
         sMDLQb0SrTyT3fjy9s1ebgY3AnQ/BiUguqo7dvmzMLjhN8JprzYegjwr5oLGuN9dum34
         AmbebND4hw+rRL4D1OGbTouVM9R19tpaAxjmYjLZi6KXaVACTxiH7hZw90yynAtbMVag
         BuQOqTaYdX1rBC+lnis+dwsVoMFJN5sftlt5Xdm1Zfv/sDhy1ldn5p4NzC/4f7QIPBOL
         orEw==
X-Gm-Message-State: APjAAAWdLVVFrwzi/g3z6PP3IaIZZpvs3LFnq8XFlno4Yu3jwZ0jW/kN
        x6v+kwk4jS/ZPNlz1E2dLFLHMzVukAA=
X-Google-Smtp-Source: APXvYqzLBLg+gEhnXhZnRUG9AfI31aohkIJAYtp3BLvP1VmKLagFrVScK1T5WKxVX+xJhKlM51bX4Q==
X-Received: by 2002:a17:90a:2645:: with SMTP id l63mr13784307pje.88.1577292940343;
        Wed, 25 Dec 2019 08:55:40 -0800 (PST)
Received: from masabert (i118-21-156-233.s30.a048.ap.plala.or.jp. [118.21.156.233])
        by smtp.gmail.com with ESMTPSA id x18sm32811353pfr.26.2019.12.25.08.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Dec 2019 08:55:39 -0800 (PST)
Received: by masabert (Postfix, from userid 1000)
        id E976420123B; Thu, 26 Dec 2019 01:55:36 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     madhu.cr@ti.com, linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, zbr@ioremap.net
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] docs: w1: Fix a typo in omap-hdq.rst
Date:   Thu, 26 Dec 2019 01:55:34 +0900
Message-Id: <20191225165534.9395-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.24.1.590.gb02fd2accad4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix a spelling typo in omap-hdq.rst

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 Documentation/w1/masters/omap-hdq.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/w1/masters/omap-hdq.rst b/Documentation/w1/masters/omap-hdq.rst
index 345298a59e50..5347b5d9e90a 100644
--- a/Documentation/w1/masters/omap-hdq.rst
+++ b/Documentation/w1/masters/omap-hdq.rst
@@ -44,7 +44,7 @@ that the ID used should be same for both master and slave driver loading.
 e.g::
 
   insmod omap_hdq.ko W1_ID=2
-  inamod w1_bq27000.ko F_ID=2
+  insmod w1_bq27000.ko F_ID=2
 
 The driver also supports 1-wire mode. In this mode, there is no need to
 pass slave ID as parameter. The driver will auto-detect slaves connected
-- 
2.24.1.590.gb02fd2accad4

