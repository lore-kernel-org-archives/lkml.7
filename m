Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FADEC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC632087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fK/8MMRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfCHOVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 09:21:16 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39281 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfCHOVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 09:21:16 -0500
Received: by mail-pf1-f195.google.com with SMTP id i20so14270238pfo.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 06:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kdvQE4/p8pGvk2V3SffZlDdX9H6Gca2gF9bkTEzwrH0=;
        b=fK/8MMROUV6SMxRtYZtlPWHmzKcpX87LA9qGGltI64MM6/fEm2q3RuVTb3x2olx9jV
         kXGw6Xg18kl8XyTh+YeDExtwg+ZpzMyanvyGN4qqOKKZMOTV99xCSQVd4aaRFF1XB6Yc
         IWxOywZ4ImY3nW93PW4K+swrqTCj43YouzLVIiSgw7HsXQrsq58BpX2+qNF8iX6PRQQi
         LQzQE+LfHZrz12WMLZO/lKPfb/c+OZEdGX7CEN5gfAEiVLk0eFH4gQ4MvKJxr796l6W2
         gFXttx8nx2ixKVLQNbrpZcbgbquYZL70QRHGL6xBEGftstcYfvD8Zz6hDS44Ui48/Z61
         wIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kdvQE4/p8pGvk2V3SffZlDdX9H6Gca2gF9bkTEzwrH0=;
        b=OuDasEPMPUTHhJmd4c9FGzu+2z/MorXHe7yNM60zG43DIzSGqK+bTqIv449ZfYrMEP
         ytbiCZRnpv0NCmMEaSkd9vVFgMMu7a1s3XKQQINmlcuz7jv3QZeGgfq4IHCTylzsOxRg
         qi3XudJQIk92O8MWhajuc4xkkv5eK5c+54DsG6gbEnqYeLfEKh4dyQdvmPVz3ki9R2Rv
         7XQeoeAE72HTxtf8vCnwIONzbBmu6AnV9GCcFeAz8Fv0Te7QwYJnTzoVtP58QAvJjVSx
         FrkZ/OcPwJpFieXxpVyv60XeXhX2//i0L4AQMcDwV01HzDMASXP1+7b9PPk1qOoc5L73
         f+ug==
X-Gm-Message-State: APjAAAVrhnvNQeCG0R8ZV27e+L6zgiT2glpQDlPfu9Sn9t1WOrHG9o9+
        pJRoRgA5owpTxf1O7n/bK0M=
X-Google-Smtp-Source: APXvYqxOYm1EkF9JulHri4T4JC3gcYkwrAlMXli6tph8onRbJoUQvD6qnvfn1/3+H7BHiIHp45jJBg==
X-Received: by 2002:a63:4e1a:: with SMTP id c26mr16787856pgb.175.1552054875484;
        Fri, 08 Mar 2019 06:21:15 -0800 (PST)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id u11sm9371355pgq.28.2019.03.08.06.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 06:21:15 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] mailmap: Add Changbin Du
Date:   Fri,  8 Mar 2019 22:21:03 +0800
Message-Id: <20190308142103.4929-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add my email in the mailmap file to have a consistent shortlog output.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 37e1847c7988..b2cde8668dcc 100644
--- a/.mailmap
+++ b/.mailmap
@@ -224,3 +224,5 @@ Yakir Yang <kuankuan.y@gmail.com> <ykk@rock-chips.com>
 Yusuke Goda <goda.yusuke@renesas.com>
 Gustavo Padovan <gustavo@las.ic.unicamp.br>
 Gustavo Padovan <padovan@profusion.mobi>
+Changbin Du <changbin.du@intel.com> <changbin.du@intel.com>
+Changbin Du <changbin.du@intel.com> <changbin.du@gmail.com>
-- 
2.19.1

