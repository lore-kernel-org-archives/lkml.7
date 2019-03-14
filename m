Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9299CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5949C2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="FTewbtH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfCNGC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:02:56 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:39708 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfCNGC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:02:56 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id C91B3C84
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 06:02:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wEjlLXp0jyfp for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 01:02:54 -0500 (CDT)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 975C7C01
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 01:02:54 -0500 (CDT)
Received: by mail-it1-f200.google.com with SMTP id v125so3647627itc.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 23:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=neXuhYsdTWmlAnx3qkR0cwBJA2h7eTxStzKGtWycc1A=;
        b=FTewbtH3aB7IV0JNJOoPpslKbetBDgKSsFGAW1wzbOm3JQCifqwMHLf2lErZ0Gdcdh
         p6cRoXCj9Q0ysrFuqmGduL3AuAL3qsGGyB/VW9NcXc/OHzQZVnRZnYTI3qt+rOuJF2QN
         BzlaJb+mt95JZhnsKcZmxeUj1aGNQeDF1TYstwESfCLS11hWR9GIX2mRKmFIWFfREAJF
         UIBmZ12BDAYcv7AsQziqPBJJeNYMw4SzfHNkVXPMSKKKrtrRPQvBLr5GkSDBjUtcHeUU
         xQBmjS63SSoSLukZrBLo5WEk+jPB/27ocsEqwZAXl2PQETyrjqGhlUc+QNWW/oLNzwSX
         TcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=neXuhYsdTWmlAnx3qkR0cwBJA2h7eTxStzKGtWycc1A=;
        b=OlPnjLuaia+Xs5/pqpIx2GKI98UBjfkPQFsGvussbqMfk/KVXeQSlT7PvGHBOt2l/V
         3SFDmflkswT75RH5TfVpbsed/azoQxF4cpBT79As4EmfIO0O5WBiYV3R4ejBkKh5qOA6
         N4xVQe4iUBXiEHl1b+ZBev4kQ5ugZy0ZwezLpcDnz4AF3x90T2x/20mTZbZp630e66xS
         BywsNttor2qP6I9QG+H7pK0CZ7zndEnPjWafnWObX6f4KSJy5eaXCmzrd3woNeaVSa7E
         SE/xksh7YCs6fnoLT4oBX6N1vN3RDACAemspZAq4l0eeo+obgTm3XTeGD+I4oync86N1
         FOAg==
X-Gm-Message-State: APjAAAWyWYW9LglSwxdbh7emfStG+diiyAvQqxeqWR3p23fjYuLPgXDI
        rmT/cb6OMCMIvdRKXE8jdhy6ae91TfIj8zVpsmlPji9exAtQqN5ffoVq4Gsjx4GYygIyPWD5u3Q
        7qmA4iefqOOQGnQU4Y7Dgg8Z0Dv5i
X-Received: by 2002:a02:308:: with SMTP id y8mr27016142jad.142.1552543374226;
        Wed, 13 Mar 2019 23:02:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyJDG1+jR07ZIyV5jIvgpDHlOL3koRjAIkQNXBxMV/NtQ3hrlsI5il1c5c0UL26spFL0gIwfA==
X-Received: by 2002:a02:308:: with SMTP id y8mr27016132jad.142.1552543374011;
        Wed, 13 Mar 2019 23:02:54 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id 22sm6735419ioc.28.2019.03.13.23.02.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 23:02:53 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] power: charger-manager: fix a potential NULL pointer dereference
Date:   Thu, 14 Mar 2019 01:02:47 -0500
Message-Id: <20190314060247.7848-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case create_freezable_workqueue fails, the fix return -ENOMEM
to avoid a potential NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/power/supply/charger-manager.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 38be91f21cc4..d29c4f338157 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1987,6 +1987,9 @@ static struct platform_driver charger_manager_driver = {
 static int __init charger_manager_init(void)
 {
 	cm_wq = create_freezable_workqueue("charger_manager");
+	if (unlikely(!cm_wq))
+		return -ENOMEM;
+
 	INIT_DELAYED_WORK(&cm_monitor_work, cm_monitor_poller);
 
 	return platform_driver_register(&charger_manager_driver);
-- 
2.17.1

