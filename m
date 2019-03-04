Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4AFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABAC32070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="p6msLUXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfCDWtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:49:08 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:55056 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfCDWtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 17:49:05 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id DB0F5836
        for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2019 22:49:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id L6Lr45pVUapl for <linux-kernel@vger.kernel.org>;
        Mon,  4 Mar 2019 16:49:04 -0600 (CST)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id B39C6B23
        for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2019 16:49:04 -0600 (CST)
Received: by mail-io1-f69.google.com with SMTP id d7so5378548ios.17
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 14:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pM/smRIiwNLORcNubGeBTq6tnPXwa13vYAEleLn2xTE=;
        b=p6msLUXeCA/PNVmc46QhsbmXGUDJmcuGNgiaEA+fb9FIiMrdWOV4twoidqKjbvq8Ho
         noNg50KbP/KbDJ147wvzT3q/z75OkRKbWPInC2QeV+kCUelkAmDi+/7M3qV6Swhq68W7
         DrZoYAvyFTznAOR2+4f4y6bdM2+HmoZ7RMiRYQmcUJt2fTJZdUH5uor9bWCp92a8TCtk
         w9qewyjMBvWpptcnkvd2NSzOvLBeY60iy6TdMFYJS19nYppOlaziwxM3has+EeZENSzv
         mGFmx0J2Si/8j3lHjQaV8vFGVQJXxxNatcNoI3YpjFVBaLnHIR8OOr9u2eWTr0KJjBsJ
         gQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pM/smRIiwNLORcNubGeBTq6tnPXwa13vYAEleLn2xTE=;
        b=Kbna4zpNmkJluA8+bKbQKYGY7AhG/QhE83w+vHHoueC3qbAGcikFNFU90RVNfVrgx1
         nH47Igg44GAVx4nlFdSUIb/TvcxibFLtUql0BPF4cL34EEibZ9lyZuspIEOyOBEY8Ava
         IMQpmkIyiopGYcMdHlVfcawOFJRWF06+d5iC9jKR8vtaBbjmIY3OlQUy5rAVjMmwK1vs
         dqQjp+ISoVXh2vcpi2oJDrfEDzQPrvrEVdyGiZqIQF7sxKjBuqwP3t8bVcl0UCjbBWIV
         bnDIEiPX4R/7uI6gQeHGZpoOoVEupGRhtcJ42Z8oYRD0Gl5mFx8hVYJ6zwORsg0o40u0
         pEHg==
X-Gm-Message-State: APjAAAV/jmg9O4dMkezA3tOHMfZSNxbL15DEGxcG99gm3hCdx4aGomfQ
        zOXJs88Bnt+ARaha/qiZvBLp3vtfdxkfrVE+a6E5tOkYy5O9sB4ZWwArvK7Dn9Sb77kAZXsKefu
        u+hIIxE/XPwRJewfW27/XnWXPlbD3
X-Received: by 2002:a24:e50b:: with SMTP id g11mr1039404iti.14.1551739744182;
        Mon, 04 Mar 2019 14:49:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqyNHsVprFSf+sh+GVQwEIwdc3b4aBwdKI6O/ZlwaP1wphWUmH0ba6eqjLBxCc3u3FzfuwzknQ==
X-Received: by 2002:a24:e50b:: with SMTP id g11mr1039395iti.14.1551739743972;
        Mon, 04 Mar 2019 14:49:03 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id t68sm3837790ita.4.2019.03.04.14.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 14:49:03 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Shaohua Li <shli@kernel.org>,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] md: Fix failed allocation of md_register_thread
Date:   Mon,  4 Mar 2019 16:48:54 -0600
Message-Id: <20190304224854.12494-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mddev->sync_thread can be set to NULL on kzalloc failure downstream.
The patch checks for such a scenario and frees allocated resources.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/md/raid10.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index abb5d382f64d..f52b4d9bcd24 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3939,6 +3939,8 @@ static int raid10_run(struct mddev *mddev)
 		set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
 		mddev->sync_thread = md_register_thread(md_do_sync, mddev,
 							"reshape");
+		if (!mddev->sync_thread)
+			goto out_free_conf;
 	}
 
 	return 0;
-- 
2.17.1

