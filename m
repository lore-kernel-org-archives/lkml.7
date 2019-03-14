Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA361C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 21:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20D821019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 21:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="bLwhLJfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfCNVRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 17:17:40 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:39328 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfCNVRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 17:17:39 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 6BEA6CD4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 21:17:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dgVZeYoCjRtX for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 16:17:38 -0500 (CDT)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 3BE55CDE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 16:17:38 -0500 (CDT)
Received: by mail-it1-f200.google.com with SMTP id z131so5755186itb.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 14:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1BU9kEzPXs7XL0lomFvApW+7xo8xyvn5BVlkJddm4mk=;
        b=bLwhLJfXuiH0mSJm2vMvcUGDD1iAxaxWrde2gHZ36HOC35A56OI12yp0QOjB+q4jQe
         Axo+jVLsV9kPRYSxApfVmEh9Kr8JHMPLZ15t6ihsGt7s0bv8Iejlaf4Je5YHVYxY5vlb
         Y0MCZN9Zglhrl8Zc6NnPcaNYd5O9Z4m0BKBhefmbE5aVKKATt1+SO3+SwzfiU1eOM9wV
         UDo+AuBYl0OSyFn2H/HFhQmCVtjE4KSilPe/0INV+vOQz0Qn8mxAGNe3/6KsRyomHblq
         pDt5ZvlebI1z1tXHSO1oqvdY51lv/yKLKAnasY+JhFFvHshkhJGLen8O/+JQ8R0loJNx
         ENBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1BU9kEzPXs7XL0lomFvApW+7xo8xyvn5BVlkJddm4mk=;
        b=uQzd+2obs2h0rzGhXQBlN2qFLLbv6ss70apLO9wjyoJaKwFCMSjwn4vt8FPtjdZLQZ
         OYlIjThFtNVfklA+Wve51cLJ6YJKu3snYDQgY1S88BXrHdD3kqznKqWI1NWXFI4GR58l
         VG543jTCBAzRkeTM9rVrdVYY28Fc8jbhNdt5bWuFqTwKA02Oz1C3ejSsZzBDPrHbHxTK
         3hw5aWJMEpardZjNPQpp/Hx89wPGt7uUn7+G1KiokiyV7wKce3Iz5qNQyAXs2j/kBjaK
         hbmX0TQ3uIFLpbUtbuWT3bZG9XwDdOMkSNZsVJ/QfYlPttG/tk4Bm6xSKOax8gHIQ+8I
         ooGA==
X-Gm-Message-State: APjAAAVTH1wHehB+iW/8Hz6Tc8rVlXyizZrbugJkYsQzB8LExTIdx4ZY
        FOvDy7duDjzOO9YdrS79EoKqvvutkgjBrpFoglApoj8irkrUa+CxROfEVvmV0RWyd3K4Vsk5HYP
        +0J+7m8bHj0guC3LvN2N9osawySd4
X-Received: by 2002:a24:6707:: with SMTP id u7mr395711itc.105.1552598257696;
        Thu, 14 Mar 2019 14:17:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqznB2G9P75bY+b8EMpBa61RxKYreIn9fCsS/mC3L08yO6VpWUpye+fJ5DVccQHuy5RHmADmmA==
X-Received: by 2002:a24:6707:: with SMTP id u7mr395654itc.105.1552598256628;
        Thu, 14 Mar 2019 14:17:36 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id g4sm104571ioc.1.2019.03.14.14.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 14:17:36 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Ilya Dryomov <idryomov@gmail.com>,
        "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        ceph-devel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] libceph: Avoid a NULL pointer dereference
Date:   Thu, 14 Mar 2019 16:17:24 -0500
Message-Id: <20190314211724.21306-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc allocates memory for dest->name and attempts to call
memcpy without a check for failure. This patch avoids such a scenario.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 net/ceph/osdmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 48a31dc9161c..c76a7c7e6a77 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1901,6 +1901,8 @@ void ceph_oid_copy(struct ceph_object_id *dest,
 	} else {
 		dest->name = dest->inline_name;
 	}
+	if (!dest->name)
+		return;
 	memcpy(dest->name, src->name, src->name_len + 1);
 	dest->name_len = src->name_len;
 }
-- 
2.17.1

