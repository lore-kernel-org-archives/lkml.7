Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86502C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 22:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 546F920828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 22:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="VQZ0NCkR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfH0WDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 18:03:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39318 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfH0WDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 18:03:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so347557wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 15:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E8kWPfvitV3tejZX+gv3oXWDOG1isXhxhZzoRKHZBpQ=;
        b=VQZ0NCkRtodLVBzjzh714vGAb3YynHGPmRxlKUuxUWfqaWkzYeGjBNnD8iBIErMjUi
         ElZl50wwQ/EAIZIASfkNYg9b4y2Xif5nel3AlTG2QvcduCEmdn621g8nZUNYTfq0c9/z
         5lNBaRiFxpNAO5DP6JKeFoSGRj/Heef6Mdk9e4cPsXHFnIIsqmGBbAlpcqFW2EpaJn4X
         DVgF6wbChPWbB1FMVIHDLwb4SrISAH9X1lW4WmsFY8hLWJ/QNfJ583atVfHsEidswRlE
         //bmDu7SvfQ3dUUsAau98K37NPK5hnnLu4vGhs3Oe/7G5jLnNGHI+IqjmKpZuZqE4ZJC
         hxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E8kWPfvitV3tejZX+gv3oXWDOG1isXhxhZzoRKHZBpQ=;
        b=W3c6gIqr+tjFB9ey+CUp+MzRcUgK3GPGUb3r6Ga4xumRz7Dvycsadr03gfiXmTNo7K
         GrPUYDysFsk+KmdvMe6RHJ/Pq4cBSQRGPZEyyjCJmCq3CZHQYV9/ITZpxnG3NUPrrQVj
         cC/xu1CgrfliN1UGOSxkfySmhZzt7sCFrHF8ClrXyBCYyGfcU/XvgkgGi7PJqvoxaGg6
         H5HRHw0046tcotxBGagI82fXXbDaGSm3IrjDAI4uBCFyf8RrahAUNh2FsBMzCd9TmNyI
         ULwKHsslQFVc4lCKI+aBEYih3haHoFlGTyoxlTykAipCGgLEDJcF+4i5SfX/uFtQ2lBK
         DGgg==
X-Gm-Message-State: APjAAAUlpMJu2Olb293qkFtSFmZfJjUCRKIhDnfFdi/z4lY4k3TTKLT0
        y8umnQ2P6PSQqAZbTVZLvzQrzQ==
X-Google-Smtp-Source: APXvYqyXZ5iPTxF3RQ9WCEc6M7RPhTpB8OAvEVRd3uqjpMljr9O1xzGBQwU05/93enNFmVhwMDxDTg==
X-Received: by 2002:adf:bd84:: with SMTP id l4mr332773wrh.143.1566943428983;
        Tue, 27 Aug 2019 15:03:48 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s64sm1099339wmf.16.2019.08.27.15.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 15:03:48 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>
Subject: [PATCH] mailmap: Add aliases for Dmitry Safonov
Date:   Tue, 27 Aug 2019 23:03:46 +0100
Message-Id: <20190827220346.11123-1-dima@arista.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't work for Virtuozzo or Samsung anymore and I've noticed that
they have started sending annoying html email-replies.

And I prioritize my personal emails over work email box, so while at
it add an entry for Arista too - so I can reply faster when needed.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 .mailmap | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.mailmap b/.mailmap
index acba1a6163f1..ce3463a93515 100644
--- a/.mailmap
+++ b/.mailmap
@@ -64,6 +64,9 @@ Dengcheng Zhu <dzhu@wavecomp.com> <dengcheng.zhu@imgtec.com>
 Dengcheng Zhu <dzhu@wavecomp.com> <dczhu@mips.com>
 Dengcheng Zhu <dzhu@wavecomp.com> <dengcheng.zhu@gmail.com>
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
+Dmitry Safonov <0x7f454c46@gmail.com> <dsafonov@virtuozzo.com>
+Dmitry Safonov <0x7f454c46@gmail.com> <d.safonov@partner.samsung.com>
+Dmitry Safonov <0x7f454c46@gmail.com> <dima@arista.com>
 Domen Puncer <domen@coderock.org>
 Douglas Gilbert <dougg@torque.net>
 Ed L. Cashin <ecashin@coraid.com>
-- 
2.22.0

