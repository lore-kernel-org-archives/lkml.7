Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28D4C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD30A2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfCMKRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 06:17:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37979 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfCMKRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 06:17:08 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <andrea.righi@canonical.com>)
        id 1h40wc-00056T-Lw
        for linux-kernel@vger.kernel.org; Wed, 13 Mar 2019 10:17:06 +0000
Received: by mail-wr1-f69.google.com with SMTP id z16so678458wrt.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 03:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=gtgImAkOnibGwd2zSzHyi7rA7YpC32VupyrC3qtJjFo=;
        b=LluKrsUsMAGjbAj2Wn6/IQj7gpjBw9HunwS9zCDmE3n6uQqGXMBWvYtc1cq7wk6+3S
         HSdlaftatEWKOubbuTMic/QwebPRYw0iRd+wtQ417Dp+74hyu0aW4Xol/ZwDxxniho7u
         5+kEUh9NGzk4JVm6Lh+nkRGNQO/2LylHQtmmoeyElHQsW8EX/uxouJvLJrKweATwzRVv
         kGKpsrzWO6rsB/AOBNzbMVLUW0QZkZY7rpdntBD+3xjZMmAeFCMMU/roU/VFQmgjMEa5
         WcXRrNs513yUuLXYqthr0PNOsFT9o5ao67w359RZJ9QOTs5YqT9g0udNWNbGWfpLFmux
         AJYQ==
X-Gm-Message-State: APjAAAWmeKSl8RSXYk3yDzDhRx36zM+ySR1wC6CtHESq+spRKRuYTtUw
        AKQfMy0Tx/x/fONjH6oKeHMisnfDo09/Z35BdgfCCcHm+Cr4lnW8pHKYK3b8N0OFiRH4TQPEWhU
        KQiircvEcfyoiodVnCsCC5kPnTFUFktNUWSQV4EI5AA==
X-Received: by 2002:adf:ea04:: with SMTP id q4mr629653wrm.97.1552472226372;
        Wed, 13 Mar 2019 03:17:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxRAhCNdvLfNwc4P4YZDUFkSesdlUiW9Qodvog6+7PyNZn+cDqIOxa8DrTdnNbHGdz5gZy5QA==
X-Received: by 2002:adf:ea04:: with SMTP id q4mr629633wrm.97.1552472226098;
        Wed, 13 Mar 2019 03:17:06 -0700 (PDT)
Received: from localhost (host82-131-dynamic.21-87-r.retail.telecomitalia.it. [87.21.131.82])
        by smtp.gmail.com with ESMTPSA id t69sm2071235wmt.16.2019.03.13.03.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 03:17:05 -0700 (PDT)
Date:   Wed, 13 Mar 2019 11:17:04 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: raid56: properly unmap parity page in
 finish_parity_scrub()
Message-ID: <20190313101703.GA9155@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parity page is incorrectly unmapped in finish_parity_scrub(), triggering
a reference counter bug on i386, i.e.:

 [ 157.662401] kernel BUG at mm/highmem.c:349!
 [ 157.666725] invalid opcode: 0000 [#1] SMP PTI

Steps to reproduce the bug:
 - create a raid5 btrfs filesystem:
   # mkfs.btrfs -m raid5 -d raid5 /dev/sdb /dev/sdc /dev/sdd /dev/sde

 - mount it:
   # mount /dev/sdb /mnt

 - run btrfs scrub in a loop:
   # while :; do btrfs scrub start -BR /mnt; done

BugLink: https://bugs.launchpad.net/bugs/1812845
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 fs/btrfs/raid56.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 1869ba8e5981..67a6f7d47402 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2430,8 +2430,9 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 			bitmap_clear(rbio->dbitmap, pagenr, 1);
 		kunmap(p);
 
-		for (stripe = 0; stripe < rbio->real_stripes; stripe++)
+		for (stripe = 0; stripe < nr_data; stripe++)
 			kunmap(page_in_rbio(rbio, stripe, pagenr, 0));
+		kunmap(p_page);
 	}
 
 	__free_page(p_page);
-- 
2.19.1

