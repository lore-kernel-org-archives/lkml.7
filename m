Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BBFC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812C521783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="C7l91imC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfKKOuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:50:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37454 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfKKOuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:50:02 -0500
Received: by mail-wr1-f65.google.com with SMTP id t1so14959950wrv.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 06:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=OPnJSf+FsDJ4AK8qgreISZQp/qVRV4crg89KAbDdM7k=;
        b=C7l91imCRxRt/iXdRWLRpgFZp+d1cU9X9RIrPYVByasB726nYNdqnnPU+D6mL5YSmC
         ihwV7cizd9tDvrMcKaNzoVQxPLyM5LDI4eAZPTQ7r8KNQ960vI4xRHHlXIeCnT9flJgn
         DPgoxIo/FKx56KEMNcFDpRr7eoWz9x+qywUn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=OPnJSf+FsDJ4AK8qgreISZQp/qVRV4crg89KAbDdM7k=;
        b=aQCQ+wncsaD6EMGKjZeOgfvZkxUvPU3P/+fVJgboVwI3lAFjealUv81Ut7deV+wOaa
         3f0uLc9jhHOac+NZ1lsCKmx8hrGBsib3t2Y/TgDTMR6QFsudqFUoEIhNwdq4wvCfR9Qe
         woZ4o+dqKU6Xzqzsu2XDCAnYrQFmu1zbakhF6sd61apyTcKcUXP25C5JorsedM9166bj
         T8xM+cS6/dXf8K3Yu8DxxpFWG0FDYY4ghxoXMjAfD00rE8xGCsby1wZND77ZKBYMGRaU
         iX/saBqdfhTEwLjkhk94bVvixB9weZp4JijEoW6tK6uw7hmATxD4btHFcXMACqw344Vz
         PciA==
X-Gm-Message-State: APjAAAVd1PccpjLspdED46IW6i5qcI0UqDEbtMhQjel09TgZnssAG9dW
        NmAY8LrJ7q70o6K02myC4JzlhZVOU/c=
X-Google-Smtp-Source: APXvYqyMEx/gVsnYP8FYoS2VkeNr+PnO77nToZQSvqb1cbjd5mh9ksLHjNCNdtTLT41TUSF6rICRFw==
X-Received: by 2002:adf:e387:: with SMTP id e7mr15450742wrm.180.1573483800231;
        Mon, 11 Nov 2019 06:50:00 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:3e35])
        by smtp.gmail.com with ESMTPSA id w17sm8434824wrt.45.2019.11.11.06.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 06:49:59 -0800 (PST)
Date:   Mon, 11 Nov 2019 14:49:58 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: [PATCH] docs: cgroup: mm: Document why inactive_X + active_X may not
 equal X
Message-ID: <20191111144958.GA11914@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has confused a significant number of people using cgroups inside
Facebook, and some of those outside as well judging by posts like
this[0] (although it's not a problem unique to cgroup v2). If shmem
handling in particular becomes more coherent at some point in the future
-- although that seems unlikely now -- we can change the wording here.

[0]: https://unix.stackexchange.com/q/525092/10762

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: kernel-team@fb.com
---
 Documentation/admin-guide/cgroup-v2.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 0704552ed94f..0636bcb60b5a 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1289,7 +1289,12 @@ PAGE_SIZE multiple when read back.
 	  inactive_anon, active_anon, inactive_file, active_file, unevictable
 		Amount of memory, swap-backed and filesystem-backed,
 		on the internal memory management lists used by the
-		page reclaim algorithm
+		page reclaim algorithm.
+
+		As these represent internal list state (eg. shmem pages are on anon
+		memory management lists), inactive_foo + active_foo may not be equal to
+		the value for the foo counter, since the foo counter is type-based, not
+		list-based.
 
 	  slab_reclaimable
 		Part of "slab" that might be reclaimed, such as
-- 
2.24.0

