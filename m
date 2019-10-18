Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1B7CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF5421835
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="jOgX/6IA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393941AbfJRFJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:09:37 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:45892 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388497AbfJRFJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:09:36 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 949A9272
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 04:30:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mhnCGDYrv2_U for <linux-kernel@vger.kernel.org>;
        Thu, 17 Oct 2019 23:30:01 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 70F1F269
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 23:30:01 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id a22so6814644ioq.23
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 21:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=S+ExY7RtG2HqIxYagBLe/T94lp0xElb1mK1Anml9C8I=;
        b=jOgX/6IAAce6fxtFdSpduVfsmh5bsIHnA+8VVZ0mbnCPUCT+tzRAGa3T5u7u6FNRXs
         pTJMp7STs6Wf/JPbaLXY8YXbz5sf/WtjaBPRLva6TWdHgmtZxwQ/5HXd2OPWsXVFm7au
         OA2DAJJJ67vhacDjOwXzwHbZxSTjr7XHqrav28tCL6Tov8x/wkXSUIenG91dU3laGTuw
         CDqGtzgXShdroBwoiixulNlnaiH329FsYYLzbA2GgMEZ4nm+uXNUc4ZYlhS2UR/3nR5x
         MR4Gr5pQyqmv7MeK5wZkVyEprVQeCh54BeulCAYlSOWTitR72M8+eEMycBQqIRS3oqMA
         D1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S+ExY7RtG2HqIxYagBLe/T94lp0xElb1mK1Anml9C8I=;
        b=c/J6m91ZGk2d7l7me3eXlijqQVCT/Pz4HjsFXah/SMbx0wAObsrwoYWiJMP3wM9L7J
         Q05eQBREonrAvdfjnHQgFtyCRnZ1r+gV3TLi4PSrcnup65rT9sqe98IKzPWSa64qfb26
         gRjTuJ58r9xkSHQPmCi6hJBk3/4l6l9CqmVNdhaZeASBahmziSiX6QBJm+UleWLaXSUk
         31rjYkNFR0xtJAeU48d4F29oSY4JuFDk9MqdVZDbTHgsNu54Se3Iv4k94rWxT5S+VQjx
         wqopPbbII6QmBy2ISlV93Wi78+tyBAzmV8lLOoMLytw85M1cE1wR8/qN/TX9IM+2i7n0
         CVMg==
X-Gm-Message-State: APjAAAV2qpn6kg3YwS9pzyDQ8bFAF7P75tacKNZdt7f8fgmndL5XEBXt
        udqoeqo4xA7BgYOquyzdNpR+WEAr01MRFvgkUp0LXffgfXau3Mz+Pc6hKoOnEkOeD1QJhHdcT5B
        qcJapgVabSs0us6OxBwGGYqbOBKrw
X-Received: by 2002:a92:8bca:: with SMTP id i193mr8102479ild.136.1571373000721;
        Thu, 17 Oct 2019 21:30:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxVhwgtJqw281TwokvjEpYKzpFxY3mjcnKghYUQJtb90u5SQgULX83RETrMAXvH1tZvYPo8ZA==
X-Received: by 2002:a92:8bca:: with SMTP id i193mr8102457ild.136.1571373000345;
        Thu, 17 Oct 2019 21:30:00 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id d14sm1698308ilm.15.2019.10.17.21.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 21:29:59 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gma/gma500: fix a memory disclosure bug due to uninitialized bytes
Date:   Thu, 17 Oct 2019 23:29:53 -0500
Message-Id: <20191018042953.31099-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`best_clock` is an object that may be sent out. Object `clock`
contains uninitialized bytes that are copied to `best_clock`,
which leads to memory disclosure and information leak.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/gpu/drm/gma500/cdv_intel_display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_display.c b/drivers/gpu/drm/gma500/cdv_intel_display.c
index f56852a503e8..8b784947ed3b 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_display.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_display.c
@@ -405,6 +405,8 @@ static bool cdv_intel_find_dp_pll(const struct gma_limit_t *limit,
 	struct gma_crtc *gma_crtc = to_gma_crtc(crtc);
 	struct gma_clock_t clock;
 
+	memset(&clock, 0, sizeof(clock));
+
 	switch (refclk) {
 	case 27000:
 		if (target < 200000) {
-- 
2.17.1

