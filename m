Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4BCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 04:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F942186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 04:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="cfbeEAFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfCOEM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 00:12:27 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:49798 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfCOEM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 00:12:27 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 91D75D2D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 04:12:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ut4OcKmoHqTX for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 23:12:25 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 61F30D21
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 23:12:25 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id w19so6006227ioa.15
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 21:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KyAtAXLoO0Lx7qX0yX2cfZ4ZJAPxGU3dEX7ZZcghMJw=;
        b=cfbeEAFlGx+UfdHjURZfnBGy5sMDk9SZA93MPcjkOi5tF8CwRRGuRkXtT+1Cr2cHma
         c7dG65SHdky8zjlC1d+4G88OeItNjAGtmQ+MSAkGegDrBMNmlFQ0/nMAHNhBTsJUjrnZ
         sIFTOYrYRa+Ra9KXOqX4w3QCxTtGkP+FprnfvpasWEfKTz/Cf9C4EnnPIF41fbCX5Mps
         T2DR9XcVoEdoo+78W3G9xwaM0fTvIAvuLDjvPL0FO+ncdd9T12/otmJtXZ2MsMY888Yv
         ebP7VW36bf3z1LQdh8AUH5duagqj19osd1durbrOZqbnPUAmO+Cs0udy+zXYfdFXOfrn
         gcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KyAtAXLoO0Lx7qX0yX2cfZ4ZJAPxGU3dEX7ZZcghMJw=;
        b=V5TBYt0OjzhaCBN+3klFfqML8xHoKI89F4z6HvW8SqLce2Nfv1M8s68KNoNLu9G75s
         BFXm+hqnjZWHjrPs3SEtGl5Ry4hTNI5OF9Zh5Jt6O07igEqDzuu6/NdNEC1BZQMKhP8g
         7vvTAB0BCtaOdSzDfH/Oej0PXkgbPgrtiablBTqvwxfzTXdf8raOn0hJk8KzHUoZ7sYI
         87zHYI3oPD/5XBA8XZHgUUhV9bH/yKslHWKvLom24p7VZGKDUx2UfQU5m9CauYBZwgNF
         HoqN5daPWRaxq/BbqulZYRY8uuYlIIuhB17/YUVTVgnLoOS9Nw5OMltdqNaBile2SUOK
         Yr2Q==
X-Gm-Message-State: APjAAAVdsqTNCZUDFqL13WywAx2oWayerkPRlWxfvH3+rzaxs7Fl7ycT
        S6ZvWzryR41X/yeKETWC9YUHOzrc6vfDX+8Dh8USm7K4Euh8A6Gv0Dy0hmoo+C3MHpWbMZj5/sP
        tzQOCaohGBXUr6eAEu34u11p58E6l
X-Received: by 2002:a02:960a:: with SMTP id c10mr335775jai.31.1552623145024;
        Thu, 14 Mar 2019 21:12:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz8WQEI0okd5gVnCzK9Ikz9kiZ51jTKHsQdl6+DGG4WJJQCupIfzzDiwHVpe1v43lI8ED6/hg==
X-Received: by 2002:a02:960a:: with SMTP id c10mr335757jai.31.1552623144773;
        Thu, 14 Mar 2019 21:12:24 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id 7sm472140iow.58.2019.03.14.21.12.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 21:12:24 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, "David S. Miller" <davem@davemloft.net>,
        Doron Roberts-Kedes <doronrk@fb.com>,
        Vakul Garg <vakul.garg@nxp.com>,
        Dave Watson <davejwatson@fb.com>,
        YueHaibing <yuehaibing@huawei.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: strparser: fix a missing check for create_singlethread_workqueue
Date:   Thu, 14 Mar 2019 23:12:06 -0500
Message-Id: <20190315041208.32432-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case create_singlethread_workqueue fails, the check returns
an error to callers to avoid potential NULL pointer dereferences.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 net/strparser/strparser.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
index da1a676860ca..860dcfb95ee4 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -550,6 +550,8 @@ EXPORT_SYMBOL_GPL(strp_check_rcv);
 static int __init strp_mod_init(void)
 {
 	strp_wq = create_singlethread_workqueue("kstrp");
+	if (unlikely(!strp_wq))
+		return -ENOMEM;
 
 	return 0;
 }
-- 
2.17.1

