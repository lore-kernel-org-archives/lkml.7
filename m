Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA66C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 20:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8462D21873
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 20:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="WRqmHuPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfCWUUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 16:20:39 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:44456 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfCWUUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 16:20:39 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 95121CC3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 20:20:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ShGCoGdQGIyS for <linux-kernel@vger.kernel.org>;
        Sat, 23 Mar 2019 15:20:37 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 61AE4CC4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 15:20:37 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id s184so4667183iod.23
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 13:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KFf7XYS7PvBJb6ZPERrz0Dwe5SpDIVt67VJxx6X5UGg=;
        b=WRqmHuPTfyWhdp6dOFqteXAkwDYyMVwVA+UDNsPcP9+vCiu1dgmIveaECA9C/c+x9P
         FoWF57QgHvOcezTEIZ+2WiBsa8fraLzsNBhXiRFVPvnuB09wIDgkCCJW1G9HK5+ozI2B
         RIzhbdGNQmjR3D1fZxTBrFN4xB4CXokaP+H5qFw2vA3WYogHWODaHCyqA453Hpx8VV72
         PYZviplYw0xMuVihMOIVCzMU50Y+RjAVDnQbUVo6hOo3lVR7KdJpAwuLGQJ8afPhip+Y
         75gcG5GIxiSfk/xm2ZFaVt4GNYf+q+XbElPJJwB6/O8EepI2ODfSLaAm+WjkLnozuVB5
         4nuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KFf7XYS7PvBJb6ZPERrz0Dwe5SpDIVt67VJxx6X5UGg=;
        b=YYAjOfpRw/EtnjSOBQ+shmd4qrhi++DRIyNq3TRG0kn9ojgWDRRdrydT7iEwOyDphH
         uTbxIEq+qlOxHMjuAjBMAI/CFvu3pYwhKpR3wo/ekidUsYEgvect1OK2bl0PEM+vkYxl
         E2rSpGZDaNeX/DscyATX0Kc1UQg9UDKMhSk7ulDuRr1vorEjVhS1YArVXSrDEeTNQk0k
         ZOkd4ptFnDRpniHjei1RjEJ9EqUbeTUVzzAO203sfC0X59RmThL2JU612R0USgRxFFCi
         AkLwT/1v4Wxt7qeAzCkwq0ps0z4vBNI8TMMlXfoyRIsyc5XUf0WqYhxvcCObhKAlXMxK
         StyA==
X-Gm-Message-State: APjAAAX/Aahh5hCh+cVcMPOcGA6I4EJRruQFLXphMyJGBPvDaP4BlTyn
        06OQoLKvAQ/+2aWMECA//pUK30a4O3Ktgj48wZ80kI14K9Az6Cx0TCd1f/Wap1/IAfVHcXZuF12
        OytpTEtbCt451FCYCjx9vfVEKl0ck
X-Received: by 2002:a24:c8c1:: with SMTP id w184mr6340822itf.135.1553372436978;
        Sat, 23 Mar 2019 13:20:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxDcD0i+nNIhsggx5eIgIYCtA7w1aBr24vi9Cd0nxhHjN8fWZ+zJsx0LqQ5rZzQHFjrfglZ4A==
X-Received: by 2002:a24:c8c1:: with SMTP id w184mr6340815itf.135.1553372436789;
        Sat, 23 Mar 2019 13:20:36 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id y22sm3821372ita.2.2019.03.23.13.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 13:20:36 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] thunderbolt: Fix to check the return value of kmemdup
Date:   Sat, 23 Mar 2019 15:20:33 -0500
Message-Id: <20190323202034.7331-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uuid in add_switch is allocted via kmemdup which can fail. The patch
logs the error and cleans up the allocated memory for switch.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>

---
v1: Change error handling from WARN_ONCE to return after clean up.
---
 drivers/thunderbolt/icm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index e3fc920af682..be1174d86cef 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -473,6 +473,11 @@ static void add_switch(struct tb_switch *parent_sw, u64 route,
 		goto out;
 
 	sw->uuid = kmemdup(uuid, sizeof(*uuid), GFP_KERNEL);
+	if (!sw->uuid) {
+		WARN_ONCE(1, "cannot allocate memory for switch\n");
+		tb_switch_put(sw);
+		goto out;
+	}
 	sw->connection_id = connection_id;
 	sw->connection_key = connection_key;
 	sw->link = link;
-- 
2.17.1

