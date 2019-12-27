Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3C7C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF9620882
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="THit34Zi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfL0NrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 08:47:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40917 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfL0NrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 08:47:02 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so26108149wrn.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 05:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yZ/6rUUablOcK/gSYaJ1J/S/ZDD9h2V3ve00gP29MQk=;
        b=THit34ZiuBw3+jK+KFUpFLkmYXbdb8/ZNnqSHVM3awyzn328KcupVxnWUwSM0HHhJp
         eBw/DlTUztk8K/20SSqzjfR89ps7DzEs438AAVC8HjyTJjyQ542rT077LvEIJ/hWTZtC
         MsaqUYZsWOc6LvyRRypYMnmqzN11zLaVxArrLwr0ckZbEUyo9j0n0bYxO8JAp/D8Eb1p
         8CsiT5HyvC5Etjl5tMPJCge/VpZsPMp1+20XOGQm8TE33+xjvJnNYN6yLGxYX4a6Nbh4
         mmrnaVp61OyGX/itgnT7Y/fre7Vz4CvcR1TiVLvL3hIA0h5Ramj0K2MMMU/LUjQOt4El
         Tqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yZ/6rUUablOcK/gSYaJ1J/S/ZDD9h2V3ve00gP29MQk=;
        b=Ca/lVkqHYXNYQ72s503zuiwgB/8DDEwjjBPufa9PDi+Eunl9az6/E4YWobWWQjrArL
         4b2PpBPh44hukqoCuHe9pXQP1sT6du/c+1j4bnjmzpVQp5hcU464C6a4TPdFxXXR88LQ
         wkq5lPQmjkfK11VbpINZB1FQ6ImBaF8D57LZ4CKJ6mzZz884bkZQFubAZjqEvDnYnkY1
         KMiEls6z2GB6sqFHT+5bOSFWfc0dVBxrVcEVPoTpgxGvRUlvh/zUaoluEpwYLZO9in2+
         ib3tcuLbqlMOxsn0Ef9lCQH4esR4CL5L4F66yfoL0EUx0qg5xWp9VxQp5MpxJgtpIRr4
         IwRw==
X-Gm-Message-State: APjAAAVHxhthT5EGcATCncixWV6jGJesD/0aFvUl7buSHPy9SXwBpdjW
        O6Gmr/PpBdt9L7wKb6kCpiAOhQ==
X-Google-Smtp-Source: APXvYqz5bF4p5vRQNTNOjHdV17xFXC4IuIbpDB90AxO030jdtkF1VMtwEkIyLQC/u0SoPSTSkeoWQQ==
X-Received: by 2002:a5d:4045:: with SMTP id w5mr47677833wrp.59.1577454420599;
        Fri, 27 Dec 2019 05:47:00 -0800 (PST)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id b10sm35648532wrt.90.2019.12.27.05.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 05:46:59 -0800 (PST)
From:   Martijn Coenen <maco@android.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, sspatil@google.com, drosen@google.com,
        Martijn Coenen <maco@android.com>
Subject: [PATCH] ext4: Add EXT4_IOC_FSGETXATTR/EXT4_IOC_FSSETXATTR to compat_ioctl.
Date:   Fri, 27 Dec 2019 14:46:39 +0100
Message-Id: <20191227134639.35869-1-maco@android.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are backed by 'struct fsxattr' which has the same size on all
architectures.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 fs/ext4/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index e8870fff8224..a0ec750018dd 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1377,6 +1377,8 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case EXT4_IOC_CLEAR_ES_CACHE:
 	case EXT4_IOC_GETSTATE:
 	case EXT4_IOC_GET_ES_CACHE:
+	case EXT4_IOC_FSGETXATTR:
+	case EXT4_IOC_FSSETXATTR:
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
2.24.1.735.g03f4e72817-goog

