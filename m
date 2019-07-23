Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC1DC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CC32238C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="krorYgFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391999AbfGWVHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 17:07:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34829 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391987AbfGWVHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 17:07:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id u14so19764422pfn.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 14:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=eXdJyX/5y1/FGa+5JWyiUL+IHdXyD6YsS6A0RC/riP0=;
        b=krorYgFC8c4EEHktVPMM8Uc7p10JFe0m3Uh5Z7ygeHlBHaZoO9KsDsqrGfKaOQ5n45
         Uu4t0n4z/SGQkouCaz5dv002xNN8r2wM56rDbp6+ZTVvamypB6MVSsqNBUzlCunbD8JI
         DmdBacuJcpJxjt2ybAFvHIpYgMHnUYIG12DWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eXdJyX/5y1/FGa+5JWyiUL+IHdXyD6YsS6A0RC/riP0=;
        b=mMDto500e8az3VU783Pk7w3UmVKbnuOKStKUSAeVVr/q2zXQDqlMDBgpcNHY9iGFKa
         EnFjKc/mgVAndhWkEh+VrVSGUyhtCXQjn3nUfSPiP6nEN0A2CWvlWbImqf+9w3Jl9+nd
         B2HUgim5U1xm4Chg2Z9wUTAhbGIz4NbGVDbzkHZBBcNnCnSdWHf8FepqRuNVUo/ygk/p
         FvvICnjY8QXhV3+5XSvh14NV7e76jLii6EZ9j3p4MzgZG2uY/3R1wv36RJ1BGpV+VsEz
         F61qrJ49F5E52yACQycDZDINsp911xdBVckTcxmYLT2vEMfYC9AK/H+NiViKEzRYcU6X
         nbng==
X-Gm-Message-State: APjAAAWr0Yhuk4MABnwl7DLGBx8GqzRBj2Tu2d4oWazc2SCCN1cllWC9
        lqoMXICcjbo6HjM3HrSdQ1WyVg==
X-Google-Smtp-Source: APXvYqx+RlfYYF9BsUFYetL+eK6XXW+0RaA14tPNlGA5LsYqVrZUzX7sAKiZK0j2exSKPYRkMQRd9Q==
X-Received: by 2002:a63:c008:: with SMTP id h8mr75676650pgg.427.1563916066868;
        Tue, 23 Jul 2019 14:07:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:48f4])
        by smtp.gmail.com with ESMTPSA id l31sm69890987pgm.63.2019.07.23.14.07.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 14:07:46 -0700 (PDT)
Date:   Tue, 23 Jul 2019 17:07:37 -0400
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: [PATCH] cgroup: kselftest: Relax fs_spec checks
Message-ID: <20190723210737.GA487@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On my laptop most memcg kselftests were being skipped because it claimed
cgroup v2 hierarchy wasn't mounted, but this isn't correct. Instead, it
seems current systemd HEAD mounts it with the name "cgroup2" instead of
"cgroup":

    % grep cgroup /proc/mounts
    cgroup2 /sys/fs/cgroup cgroup2 rw,nosuid,nodev,noexec,relatime,nsdelegate 0 0

I can't think of a reason to need to check fs_spec explicitly
since it's arbitrary, so we can just rely on fs_vfstype.

After these changes, `make TARGETS=cgroup kselftest` actually runs the
cgroup v2 tests in more cases.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: kernel-team@fb.com
---
 tools/testing/selftests/cgroup/cgroup_util.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 4c223266299a..bdb69599c4bd 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -191,8 +191,7 @@ int cg_find_unified_root(char *root, size_t len)
 		strtok(NULL, delim);
 		strtok(NULL, delim);
 
-		if (strcmp(fs, "cgroup") == 0 &&
-		    strcmp(type, "cgroup2") == 0) {
+		if (strcmp(type, "cgroup2") == 0) {
 			strncpy(root, mount, len);
 			return 0;
 		}
-- 
2.22.0

