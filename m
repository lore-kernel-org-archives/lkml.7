Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12241C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4369208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="DFgF/0bz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731635AbfFYMoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 08:44:37 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35735 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfFYMoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:44:37 -0400
Received: by mail-qk1-f193.google.com with SMTP id l128so12426495qke.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 05:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vY1P3TR1JMlx3/olYt70oLIeMNySWo4qDa658Q/bTik=;
        b=DFgF/0bzewn+n/PL9ZLvg7U/zHK/8dal4r9yQ0LFAoG7YdWsgL9+mY2gPNvTiC42qu
         3gl4bEJtEonjcDSN473+7iOWwQmHIzHRbKCzmtu9Lql5jvnKD/TT2Q2pyREt7f53i3QH
         zhfzWELhChmeTb1miNVPNGyZJL/GE7iGEvl37bBUnWf067fLYy0R17hn1TeT2afEn2vf
         byCuSjvrD11zxjzf7lvYUABmCoBiXoHBSG5QZ4v1zftF5D9ucylJPWiiB80r9Yf3EtFZ
         Jt5sVMYy9ugHMpGBpdZKG6hraqdoEHkA8HLdkygA8UAcovMFOuCGHsdqx4liopODijwN
         3Ucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vY1P3TR1JMlx3/olYt70oLIeMNySWo4qDa658Q/bTik=;
        b=tHPS2Zy7TQ2Z/YcHsHBHqfz7+4gxLNTeUtfaAQ0TviS71dHHVRVdrJRIZB6cSkBZSl
         EwdUw7E0qu5O8eW9NLCHzT/BdxWl286cK2kchtf8vuS4PrXljxOlUvc+QCmlLgB/937W
         EGLveRvf0kbJUmdoilAZuvafSRGKgdZopljfsw29OVH7+toYk5NbTIQg7iw5n9LGg8l4
         C7ssgKYbuf/dFjrW/7zLoVC77WxmJXZBcgcCmGlaKhh3cAyCoV0P+wDLKgCzxHVVtLb0
         /DpF45RFLKTK00YFr+FUvn2Y17w84s6udKI4LTvQ7umD5vs7HxvyMUBEpBJwRPkchE9p
         TtNQ==
X-Gm-Message-State: APjAAAWFQbjuC6HtubmFhnRFXNs3v2MqpoXh/7+EVBk9IXA2HHfqFSiB
        d12UGrWa/xHBeMM2aulynotA/g==
X-Google-Smtp-Source: APXvYqxi7g7Njj3VFUtVK3/9ena26Iye8MvkzGjpZ3DmS6ZBB3kfoVLpg596dEN8oa5pyRriwQaWaw==
X-Received: by 2002:ae9:e20c:: with SMTP id c12mr125438259qkc.210.1561466676265;
        Tue, 25 Jun 2019 05:44:36 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id s25sm7119940qkm.130.2019.06.25.05.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 05:44:35 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     valentin.schneider@arm.com, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v2] sched/core: silence a warning in sched_init()
Date:   Tue, 25 Jun 2019 08:44:22 -0400
Message-Id: <1561466662-22314-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling a kernel with both FAIR_GROUP_SCHED=n and RT_GROUP_SCHED=n
will generate a warning using W=1,

kernel/sched/core.c: In function 'sched_init':
kernel/sched/core.c:5906:32: warning: variable 'ptr' set but not used
[-Wunused-but-set-variable]
  unsigned long alloc_size = 0, ptr;
                                ^~~

It apparently the maintainers don't like the previous fix [1] which
contains ugly idefs, so silence it by appending the __maybe_unused
attribute for it instead.

[1] https://lore.kernel.org/lkml/1559681162-5385-1-git-send-email-cai@lca.pw/

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: Incorporate the feedback from Valentin.

 kernel/sched/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 874c427742a9..12b9b69c8a66 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5903,7 +5903,8 @@ int in_sched_functions(unsigned long addr)
 void __init sched_init(void)
 {
 	int i, j;
-	unsigned long alloc_size = 0, ptr;
+	unsigned long alloc_size = 0;
+	unsigned long __maybe_unused ptr;
 
 	wait_bit_init();
 
-- 
1.8.3.1

