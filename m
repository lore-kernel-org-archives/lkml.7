Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189A1C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 05:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A2E2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 05:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fczt6Y0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfD3FdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 01:33:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41222 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfD3FdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 01:33:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id 188so6495317pfd.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 22:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=iUa57RIax5diLtyq83b+j3YFJPrguoFadxX+EZws2S0=;
        b=Fczt6Y0TjlMYCNPqwhusfFBqHlBuhI9CbSIS4lknqWp3HMC4L6Y5LNxq2hy0pfeNHq
         dmF50EC14comr8xya5dXrNBnqa7oBgE1q1ySckzfl3rRPp/qiYkMYXaKWq0vSO0agAfV
         tGlEx+ozEEUxaTVy/2aC0lTbEN0pRlFtv/O8omFurdLzx9JceOP51yNG2+++u7QJJHgb
         eT+Usdaa/peCAaync5Wlm/awsrGMrvfSimMq7zvgy4NA3OVjsSjDr0EVhaTKtDlsqr90
         VnZ1OVcnXbEwyUNGR6ZIH644xjH6mHwkPwXPqWXgAR8yp5qBb0+MDd0fYWhYvhetYZHg
         smKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=iUa57RIax5diLtyq83b+j3YFJPrguoFadxX+EZws2S0=;
        b=DY2vrgXlYwE2dwVaPg7RkTy+u8k6MTpEdgHOxK0C5lFUgDaKTAEs21FOOG9MN1HBbk
         ay6ppToLCvp31fcJwBdjlOjU9GRBd4eB0NgscU7OPjJ5jMbVPsBE83dByP+26Bpxc3Z/
         5RTrgiRYH5MD1x428nAnr0/pHZkm4bIo/NlUHHf1EtItlp3L1sz1OOef+82MI4LcGbzW
         w6i46Tde7NkxpK2AO414ut7T4kfAAqTBnORK7XBFChcn4ZjCteYqs1VAGjnMAhKbX12P
         Akn5AjOM7E6IaXTzu82j9+XxIvLbeNKSpRM70zOykK2ypF1/+S2YRBUMY8VRMulMMje1
         jBMQ==
X-Gm-Message-State: APjAAAUDQsAo4npu7ubqQ6U03xlFT/tkcN79IckKbYIDNiOw8IZsfCZQ
        4fMhPVJ9sXRweWwzdnxxZy0=
X-Google-Smtp-Source: APXvYqy8QkxkRYqEe44mo+c6pA57YJhS04Y0lImVTl0FIgx3G/GyNdXRFjTwn9p0f5B++VxSFBR8hQ==
X-Received: by 2002:a65:608d:: with SMTP id t13mr39427782pgu.406.1556602402713;
        Mon, 29 Apr 2019 22:33:22 -0700 (PDT)
Received: from localhost (125-227-77-194.HINET-IP.hinet.net. [125.227.77.194])
        by smtp.gmail.com with ESMTPSA id f5sm39568420pgo.75.2019.04.29.22.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 22:33:22 -0700 (PDT)
From:   Timmy Li <scuttimmy@gmail.com>
To:     ebiederm@xmission.com, akpm@linux-foundation.org, mhocko@suse.com,
        willy@infradead.org, oleg@redhat.com, rppt@linux.vnet.ibm.com,
        ktsanaktsidis@zendesk.com, linux-kernel@vger.kernel.org
Subject: [PATCH] pid: Remove unneeded hash header file
Date:   Mon, 29 Apr 2019 22:33:19 -0700
Message-Id: <20190430053319.95913-1-scuttimmy@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hash functions are not needed since idr is used now.
Let's remove hash header file for cleanup.

Signed-off-by: Timmy Li <scuttimmy@gmail.com>
---
 kernel/pid.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index 20881598bdfa..89548d35eefb 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -32,7 +32,6 @@
 #include <linux/init.h>
 #include <linux/rculist.h>
 #include <linux/memblock.h>
-#include <linux/hash.h>
 #include <linux/pid_namespace.h>
 #include <linux/init_task.h>
 #include <linux/syscalls.h>
-- 
2.17.1

