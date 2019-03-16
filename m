Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F00C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431F2218D4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6A697S/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfCPR62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 13:58:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42554 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfCPR6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 13:58:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id r15so5737860pfn.9;
        Sat, 16 Mar 2019 10:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EXXdq7GrYAICjYexP9jF/A5d/mueQ96ws92MW4tT5O4=;
        b=F6A697S/ffgJNB8KpLbzzjE1ufFH+GzS0i5kboYL5MTAgRfj3I850Ka+KDnEYqSflF
         fa8ZyZQg9sxQ+hoKvqeIp0j2j7cVXz2r0cLHumV6M+AJZxpN/KNQKSwgr/Jo4hLqD6ok
         h1CupS8vXwP4Ok8CjXPQrgw60GKElSpuhfrvp2jJ6li9Urea3VCiz+SMoXPk7TEFqdhm
         sLcJzRm6gv4dKSRm79nuXL24mtMmlk/7c2wyZxIGeUU2FcggGH3Vrg70mrY9eOHKIFyM
         L32M2k9DAy6ftffLYNK9vT7/67Uh5h7uytamW4n9IcgamOaZjGky1OUg0ZaKpT+IzS6r
         Yg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EXXdq7GrYAICjYexP9jF/A5d/mueQ96ws92MW4tT5O4=;
        b=g+p3+YVrSOazsmp0RSWgu5RMEeLkhWBcEXXgHWxbE1U49ow4CIipSvjIYsUZx3n329
         Uq/Lnp5wCvwBZwzchQzD4mBPqFxoRfHq6r205OpKuGmPoDd2orA4G+P9Xp2uAb2HaXR5
         oUePGIDWN9QMLvv657UaSDcGPcD9SjRzjma1OJ+awJ3D0VepcObZYkcz+eRDmjR42hn+
         Ug/CZ7kje8Hodo+Q1ehh4uZ68IhzEAYFU/khUJz3/JcXbtEU47915AUAN1W9S24Zu2Zl
         vHVt9OaGOes5clLeJpT1w0bEbHwLRKFOqShxXPgY4OHNhtFktaqzGk0vZA/bwfxd8y8o
         d88g==
X-Gm-Message-State: APjAAAV24BLGW7UZYNLYmi0v1BArqytisAVjLLvvmyITTuDEce5QV5EE
        nylKbEBt2i/c+psdQWLen4g=
X-Google-Smtp-Source: APXvYqzWWucCKBBbJ0xLZ8o0aHX+Vb7Kd1DK5eHeXf1rLN3n8YtoQ8SObjxcyZ/gxs0fpLQCCVPWNg==
X-Received: by 2002:a17:902:266:: with SMTP id 93mr10945271plc.161.1552759105006;
        Sat, 16 Mar 2019 10:58:25 -0700 (PDT)
Received: from castle.hsd1.ca.comcast.net ([2603:3024:1704:3e00::d657])
        by smtp.gmail.com with ESMTPSA id p86sm11025638pfa.104.2019.03.16.10.58.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Mar 2019 10:58:24 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     Roman Gushchin <guro@fb.com>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH v9 5/9] kselftests: cgroup: don't fail on cg_kill_all() error in cg_destroy()
Date:   Sat, 16 Mar 2019 10:58:08 -0700
Message-Id: <20190316175812.6787-6-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190316175812.6787-1-guro@fb.com>
References: <20190316175812.6787-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the cgroup destruction races with an exit() of a belonging
process(es), cg_kill_all() may fail. It's not a good reason to make
cg_destroy() fail and leave the cgroup in place, potentially causing
next test runs to fail.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: kernel-team@fb.com
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/cgroup/cgroup_util.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 14c9fe284806..eba06f94433b 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -227,9 +227,7 @@ int cg_destroy(const char *cgroup)
 retry:
 	ret = rmdir(cgroup);
 	if (ret && errno == EBUSY) {
-		ret = cg_killall(cgroup);
-		if (ret)
-			return ret;
+		cg_killall(cgroup);
 		usleep(100);
 		goto retry;
 	}
-- 
2.20.1

