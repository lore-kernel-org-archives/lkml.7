Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD17C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 18:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2896E20637
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 18:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="FmskHlzg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfLCSfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 13:35:38 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38883 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfLCSfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 13:35:38 -0500
Received: by mail-qt1-f196.google.com with SMTP id 14so4814668qtf.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 10:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YOfocbvIxC0iu9uOHcUapzST4lCL7cP23eKj1vMSlro=;
        b=FmskHlzgPfYc9RuTSKhCb1dS/OuIvm1U1ED45iv8aC9CBBl5CaalVD2LOcKK2XR+tP
         W5s3zggyrlhZBVGP7rJHGlQ6u5DtBCrk8eT6SOXXEJXbKM+2+7TNFSOxEcMTCII7GEL3
         +VIyLO2dQMMa2wRYUXRtXHUuBqgMkp/PLH35Sbp5WUEmefM6G6jTk0igw54lN53rRc+x
         Xy0YCezqKFjO5aOLkmi0vfWq8XF09PMhFyt7s344i+9M8BmShGzKQMnTFN5c48W925cV
         OAdoKdNcBmel2qHgYsxxtwEhWYoqjRoiC/W1SIZrtC7Y++zjE3Pg5AbC/WJQFchVBDTj
         irnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YOfocbvIxC0iu9uOHcUapzST4lCL7cP23eKj1vMSlro=;
        b=hpi+rqvLFywLI2ElVD2OfTkRdQNfq0R3CkPHMa5vkbffelToOuAZ63MQ6U3zraMMNa
         jqqKXWDG7WQj3nCU48npvmWCjpkUhIRDoFLZVcpXOIruBBCk10D6jUKpxwwVGy/dS/K9
         iR7TQPZ8KhQjc2pwd92acUIeKNMxVShRSQr7t2XodHOKpHwEAfeoGLt76rSU7M02FJpv
         8qZdia8YaM1j/b7zCt4x2QUF7EfL5UaN5yF6Gu+WfVs3VusrX9Uy7IG41pKORC2Oi9Sl
         RbBm2ZcbKQKohTozC1scMWp5gXN+9vn8b8HS6gvrzdZAOmAzI6SMaUKgpFSu177ZCuAp
         sorw==
X-Gm-Message-State: APjAAAWB3xHJuddKbimydoHo+1Jem4Fo6fUsBBGJxVl2qN4ExkMOqrER
        cnOCO3rAeLyp4v3We9+SG+Yb5baJkYY=
X-Google-Smtp-Source: APXvYqwQFSPsMhtxC9HqmnfodmktUCuzthfKi5QH/SwAfSrFRLR3rXrYeh9SygKdg/E9JSDU9lKPPA==
X-Received: by 2002:ac8:6f09:: with SMTP id g9mr6529852qtv.275.1575398137095;
        Tue, 03 Dec 2019 10:35:37 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:cbfe])
        by smtp.gmail.com with ESMTPSA id d15sm2184192qti.69.2019.12.03.10.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 10:35:36 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jingfeng Xie <xiejingfeng@linux.alibaba.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] psi: fix a division error in psi poll()
Date:   Tue,  3 Dec 2019 13:35:24 -0500
Message-Id: <20191203183524.41378-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203183524.41378-1-hannes@cmpxchg.org>
References: <20191203183524.41378-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The psi window size is a u64 an can be up to 10 seconds right now,
which exceeds the lower 32 bits of the variable. We currently use
div_u64 for it, which is meant only for 32-bit divisors. The result is
garbage pressure sampling values and even potential div0 crashes.

Use div64_u64.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 kernel/sched/psi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 970db4686dd4..ce8f6748678a 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -482,7 +482,7 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
 		u32 remaining;
 
 		remaining = win->size - elapsed;
-		growth += div_u64(win->prev_growth * remaining, win->size);
+		growth += div64_u64(win->prev_growth * remaining, win->size);
 	}
 
 	return growth;
-- 
2.24.0

