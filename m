Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A04C10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D73D218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfJBTBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 15:01:45 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:51122 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726076AbfJBTBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 15:01:45 -0400
Received: from mr1.cc.vt.edu (mail.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x92J1him001905
        for <linux-kernel@vger.kernel.org>; Wed, 2 Oct 2019 15:01:43 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x92J1cgL008407
        for <linux-kernel@vger.kernel.org>; Wed, 2 Oct 2019 15:01:43 -0400
Received: by mail-qk1-f200.google.com with SMTP id n135so19468474qke.23
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 12:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=aK+dlxh4aWZdy/McFZvh8C645g1tT1N+aiJMD9e/VE4=;
        b=pUbQ0TAze2/8GFtHi6SXfy2C9tqhPwzENxUK06pBeA8vNW0eyD/lDmQB3e7GXros6k
         hzYn2eD0p4EF0VW/McQiV+UjPW0mgHmegAx/jQsDjwfPyNL4dwyuQIrVgxt21bQlDcHF
         Du18e30I9WPsK/pND918xieVdniH5/vtHyNSHHcVcU4D5ECSNgx4uYckzDZaPQVRQhpY
         v55eN1bR1HS9qdpbiw2OD3WAiHg4vKdwse6Lfon2O/8Hah+KVHjCZOp0nEAWOUG151OY
         bBqAEy+4AUCNc6HlEggUISQoR8X2tWUK0PzFQ7kNz6RSOIZMBF7PDZRqqr/zFqfCUcjX
         xvWA==
X-Gm-Message-State: APjAAAWvbHWOWzBnqz0iOXhSEcA94qeptqY+3YJAszPfcQWpDznuRYd4
        D5OyGNDPApqEAFIlr67T1WlX4rp+AHQ7dBQvQW3MFDHDSPNIcXPKKcsEMEbutwdDa0aep0fUMIK
        8UCPtW+D1GWtBOHNh/x7V5vDIitl5yQ859oA=
X-Received: by 2002:ac8:6658:: with SMTP id j24mr5949604qtp.364.1570042898282;
        Wed, 02 Oct 2019 12:01:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxtfMNWCtc5hidqz4lQIF71wwyWtG81Px7YNTfqRMWzh6KooZ1G7po3RNaHOVP2tbEWtMjLWg==
X-Received: by 2002:ac8:6658:: with SMTP id j24mr5949578qtp.364.1570042897998;
        Wed, 02 Oct 2019 12:01:37 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::9ca])
        by smtp.gmail.com with ESMTPSA id h10sm155063qtk.18.2019.10.02.12.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 12:01:36 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     gregkh@linuxfoundation.org
cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/staging/exfat - explain the fs_sync() issue in TODO
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 02 Oct 2019 15:01:35 -0400
Message-ID: <9837.1570042895@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've seen several incorrect patches for fs_sync() calls in the exfat driver.
Add code to the TODO that explains this isn't just a delete code and refactor,
but that actual analysis of when the filesystem should be flushed to disk
needs to be done.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

---
diff --git a/drivers/staging/exfat/TODO b/drivers/staging/exfat/TODO
index a3eb282f9efc..77c302acfcb8 100644
--- a/drivers/staging/exfat/TODO
+++ b/drivers/staging/exfat/TODO
@@ -3,6 +3,15 @@ same for ffsWriteFile.
 
 exfat_core.c - fs_sync(sb,0) all over the place looks fishy as hell.
 There's only one place that calls it with a non-zero argument.
+Randomly removing fs_sync() calls is *not* the right answer, especially
+if the removal then leaves a call to fs_set_vol_flags(VOL_CLEAN), as that
+says the file system is clean and synced when we *know* it isn't.
+The proper fix here is to go through and actually analyze how DELAYED_SYNC
+should work, and any time we're setting VOL_CLEAN, ensure the file system
+has in fact been synced to disk.  In other words, changing the 'false' to
+'true' is probably more correct. Also, it's likely that the one current
+place where it actually does an bdev_sync isn't sufficient in the DELAYED_SYNC
+case.
 
 ffsTruncateFile -  if (old_size <= new_size) {
 That doesn't look right. How did it ever work? Are they relying on lazy

