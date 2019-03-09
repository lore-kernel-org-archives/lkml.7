Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E908DC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 04:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FFB2081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 04:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="ldfOFN+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfCIEUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 23:20:00 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:34796 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfCIET7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 23:19:59 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 30DF493E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2019 04:19:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UZsk9yvb8Fq9 for <linux-kernel@vger.kernel.org>;
        Fri,  8 Mar 2019 22:19:58 -0600 (CST)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id F163480F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2019 22:19:57 -0600 (CST)
Received: by mail-it1-f199.google.com with SMTP id w200so13786512itc.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 20:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7eog7oJx2PJgBSvuyndleqUfLc5OD3EgjG/1TSyVsWU=;
        b=ldfOFN+rB/MrY/mXDgmE3QAipnxqper6KVxDFMHnx00WccQRZU7ldT7ymxabMUuDee
         rUC8IXiaul8z8TGrkO2sKg957bKgbH04lT/KbF6Iqq6QqnE4USiy7+tVjeA8ff2CDF4k
         uuZ4c3XstJBQaxoKkwB1E8NmuJ9DyBT+4Q0GdOOf3TCAl1v39PzY6b/S0RYZncnO9BBk
         6OvRUApxa+OpW70l4BlQDEw1xvgyvaqmF/zKdjJxANwHQzergNliIx1A1hucB5pAq2Bg
         Ym1dgqqpbxhs1N6TRM59J6qPRkLN+Tu2JOOmbDrNMOAOgmUNQgkgnzjcy1fkcDlxdt9C
         TGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7eog7oJx2PJgBSvuyndleqUfLc5OD3EgjG/1TSyVsWU=;
        b=UjGclpmb9hWyA/XiRdMPjkjOeHxx4S3zonKjnwRiqiemaXEbmyKiXcSwdC6GsdI7+W
         Abq9d6EPasu1xs6YlGU+qSuiF+MrhgtREKMVdeEqjIbiccvu9sLgNpRY1Sl3pX78RYyB
         mdbUq5w+HN5YPiISzv/htexkn9jbSstlCzki8L8movE8hDRy5dR4t1npXA7X6w+72Pj0
         w7Rr3S0Y9JJaV+0omRggTBl7lLWvpGpPpqYOAmtbtgMPry4WUJFvtqYfEw103TzXydtI
         6WmFK7yH06w5eV1LS7YeIScx1hyd/fq0GkmoY+4jqZ5j0TEgZ+/YpXftWOGwAe9CI/NC
         E9Eg==
X-Gm-Message-State: APjAAAVG5a6VT7NT02FACDnbx1g8bRElNgcnldQ1ol7iEl3DfWN4fgXP
        VFHj+XgwHS7QW3jCkseop4t9QzsvCzuHJzHeWIJW/jMjtSNjU8H8Z7JZWgb5maz3LAkdLlynEBA
        V/qJE+D0P6YYeKbTngtv/SvwvcxvE
X-Received: by 2002:a5d:8d92:: with SMTP id b18mr10917779ioj.272.1552105196572;
        Fri, 08 Mar 2019 20:19:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqysyNrq0vPZx87InMpYskfQPQrNrjUWLxG54PiNcb5M/5Cig1Gnk95kMFLQm9tASmnCdsp+NQ==
X-Received: by 2002:a5d:8d92:: with SMTP id b18mr10917764ioj.272.1552105196336;
        Fri, 08 Mar 2019 20:19:56 -0800 (PST)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id 136sm5022628itu.35.2019.03.08.20.19.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 20:19:55 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Oded Gabbay <oded.gabbay@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpu: amdkfd: fix a missing check of kmemdup
Date:   Fri,  8 Mar 2019 22:19:49 -0600
Message-Id: <20190309041949.3176-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup could fail and return NULL. To avoid null pointer
dereference, the fix checkes its return value and returns
ENOMEM upon failures.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 2e7c44955f43..7ef62d4e7598 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -404,6 +404,9 @@ static int kfd_parse_subtype_iolink(struct crat_subtype_iolink *iolink,
 			return -ENODEV;
 		/* same everything but the other direction */
 		props2 = kmemdup(props, sizeof(*props2), GFP_KERNEL);
+		if (!props2)
+			return -ENOMEM;
+
 		props2->node_from = id_to;
 		props2->node_to = id_from;
 		props2->kobj = NULL;
-- 
2.17.1

