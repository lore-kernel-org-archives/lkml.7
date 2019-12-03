Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E335C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 18:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6989120637
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 18:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="eFpGufSM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfLCSfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 13:35:38 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:39942 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfLCSfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 13:35:38 -0500
Received: by mail-qt1-f176.google.com with SMTP id z22so4795508qto.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 10:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+mPpij2urIiFa+tGhxc3F5vXjgowsH5MsfLmE//ET0E=;
        b=eFpGufSMKcL/mX8THLDgjTjkvYdjrL0SOxx35M3oj/ID7pJCebwdLuGxRFePfkOdQU
         RCBFNo566AUXmwLq4NN7B7bw+/+W0PHUsSkKc0IeVkFS/f/LwrS50YG69BiPUsuoLKpG
         SOE0wIqaJiYLkA38FJOLzoOeEpl6741La82mEof938Pzv7Ce23/jC2peDKJT81j4wXx1
         xb0PlElEt7xjnN3y6aZykLmHZlAyNBkQrDIb49Guq15kRL3/eCxfqCCr1S48IZ2FLSFG
         +3ae8zefxFsSgSjK02+w4zbuMWK572aCBvOCHqRV3BumGeATgp72K53qJFKkGEbSlmyd
         BA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+mPpij2urIiFa+tGhxc3F5vXjgowsH5MsfLmE//ET0E=;
        b=QToSNUxKPqIAzkZgg3VZoeXcDzlYAskQVexFLk1/Psjk+zFkPXDj7XkoWKtr4KWfCL
         ERtn4OgJl1f1ed0k6TeQCmmyEBVWSBida8d7puOdYjZq7BBfNTb1A5eNnhOUZQ1oVcb/
         MNJ3zSUBGXGmFBWuaHrDxFHcLIK9CEuifQ5TeIFSAML4y2qzmupieZthdCN8GFc4WFdv
         cR0s/nef5uJNNa0KbDeNmPBW7mIsucBTrcbRBiq0poDD46XA0yyNtUwWNsTH8zvCE1Xm
         im5nCm5U/I0GszyIdk5rbk/ISt/LQWK4B3UvdhkX+3WmnhxlVoGTcIvEhVvlw51q3GUh
         pTpw==
X-Gm-Message-State: APjAAAUPGsoniNCO2VCMnUS2rYhm0r0CWfCVWc8wGDjMK8NIjiYtE7cG
        CuZEA674Decr5r+/p329x2+uwA==
X-Google-Smtp-Source: APXvYqyVLo1MCokVY2fKXLO30tW+QSUcrD93wzVwb6SzRrl2LVaIhJkSsPCvZcpBlad5+BJaDYruRQ==
X-Received: by 2002:ac8:173c:: with SMTP id w57mr6544619qtj.39.1575398134049;
        Tue, 03 Dec 2019 10:35:34 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:cbfe])
        by smtp.gmail.com with ESMTPSA id q187sm2251776qkd.92.2019.12.03.10.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 10:35:33 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jingfeng Xie <xiejingfeng@linux.alibaba.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] psi: two division fixes
Date:   Tue,  3 Dec 2019 13:35:22 -0500
Message-Id: <20191203183524.41378-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

here is a patch that should fix the rare div0 crashes reported by
Jingfeng, and a second patch for a div32-with-64-bit-divisor issue
spotted during code review.

Can you please take a look and route them through the scheduler tree?

Thanks!

 kernel/sched/psi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


