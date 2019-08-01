Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD859C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D3A20838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kam.mff.cuni.cz header.i=@kam.mff.cuni.cz header.b="pvLWO7li"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbfHANvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 09:51:03 -0400
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:34562 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfHANvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 09:51:03 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Aug 2019 09:51:00 EDT
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 3081)
        id 2A775281EE0; Thu,  1 Aug 2019 15:42:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kam.mff.cuni.cz;
        s=gen1; t=1564666970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Tgtx8AU1eDvtzwgrnSCNWwtGnoWIuLmdAOsYfNaJttw=;
        b=pvLWO7li2agCXnOPRX+RP+FfBG/H4UjD1Z36HStX9QXgqzBne9yrQdkyv4dwY6R/M8kvw6
        psKsU6cNwkhptR0NCmhwUdYXyXXJS+CHvs7YUWjnVbYdszIp/dolw8ejrWNBHYW1QRG9IB
        AEi4mT+wDS4rybhu1FxQzlzI6dAPZYI=
Date:   Thu, 1 Aug 2019 15:42:50 +0200
From:   Jan Hadrava <had@kam.mff.cuni.cz>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, wizards@kam.mff.cuni.cz
Subject: [BUG]: mm/vmscan.c: shrink_slab does not work correctly with memcg
 disabled via commandline
Message-ID: <20190801134250.scbfnjewahbt5zui@kam.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be a bug in mm/vmscan.c shrink_slab function when kernel is
compilled with CONFIG_MEMCG=y and it is then disabled at boot with commandline
parameter cgroup_disable=memory. SLABs are then not getting shrinked if the
system memory is consumed by userspace.

This issue is present in linux-stable 4.19 and all newer lines.
    (tested on git tags v5.3-rc2 v5.2.5 v5.1.21 v4.19.63)
And it is no not present in 4.14.135 (v4.14.135).

Git bisect is pointing to commit:
	b0dedc49a2daa0f44ddc51fbf686b2ef012fccbf

Particulary the last hunk seems to be causing it:

@@ -585,13 +657,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
                        .memcg = memcg,
                };

-               /*
-                * If kernel memory accounting is disabled, we ignore
-                * SHRINKER_MEMCG_AWARE flag and call all shrinkers
-                * passing NULL for memcg.
-                */
-               if (memcg_kmem_enabled() &&
-                   !!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
+               if (!!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
                        continue;

                if (!(shrinker->flags & SHRINKER_NUMA_AWARE))

Following commit aeed1d325d429ac9699c4bf62d17156d60905519
deletes conditional continue (and so it fixes the problem). But it is creating
similar issue few lines earlier:

@@ -644,7 +642,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
        struct shrinker *shrinker;
        unsigned long freed = 0;

-       if (memcg && !mem_cgroup_is_root(memcg))
+       if (!mem_cgroup_is_root(memcg))
                return shrink_slab_memcg(gfp_mask, nid, memcg, priority);

        if (!down_read_trylock(&shrinker_rwsem))
@@ -657,9 +655,6 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
                        .memcg = memcg,
                };

-               if (!!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
-                       continue;
-
                if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
                        sc.nid = 0;


How was the bisection done:

 - Compile kernel with x86_64_defconfig + CONFIG_MEMCG=y
 - Boot VM with cgroup_disable=memory and filesystem with 500k Inodes and run
   simple script on it:
   - Observe number of active objects of ext4_inode_cache
     --> around 400, but anything under 1000 was accepted by the bisect script

   - Call `find / > /dev/null`
   - Again observe number of active objects of ext4_inode_cache
     --> around 7000, but anything over 6000 was accepted by the script

   - Consume whole memory by simple program `while(1){ malloc(1); }` until it
     gets killed by oom-killer.
   - Again observe number of active objects of ext4_inode_cache
     --> around 7000, script threshold: >= 6000 --> bug is there
     --> around 100, script threshold <= 1000 --> bug not present

Real-world appearance:

We encountered this issue after upgrading kernel from 4.9 to 4.19 on our backup
server. (Debian Stretch userspace, upgrade to Debian Buster distribution kernel
or custom build 4.19.60.) The server has around 12 M of used inodes and only
4 GB of RAM. Whenever we run the backup, memory gets quickly consumed by kernel
SLABs (mainly ext4_inode_cache). Userspace starts receiving a lot of hits by
oom-killer after that so the server is completly unusable until reboot.

We just removed the cgroup_disable=memory parameter on our server. Memory
footprint of memcg is significantly smaller then it used to be in the time we
started using this parameter. But i still think that mentioned behaviour is a
bug and should be fixed.

By the way, it seems like the raspberrypi kernel was fighting this issue as well:
	https://github.com/raspberrypi/linux/issues/2829
If I'm reading correctly: they disabled memcg via commandline due to some
memory leaks. Month later: they hit this issue and reenabled memcg.


Thanks,
Jan
