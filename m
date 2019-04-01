Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F8CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B0021929
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138361;
	bh=VY4jNl1p2xWfqnE0floxqbk9Kr7P5KblGNSV2knrJok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NAJoiwrFzrzJKi6WP24LiEZcSEBVtpHPmHQQ2tnD/NPzR29zLAgceafOLU1NTHndj
	 EzRQg5RNZWNR1ya1eCie3nHZNoH5+1weVh7MMz4rkDj5TKZjIouUvutID1QBHe3/Gx
	 mpZf/Fm0Ihoy+3Vscdhw8M+PfP/bVdKPkzwZ3zj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfDARF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:05:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729068AbfDARF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:05:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA6F621924;
        Mon,  1 Apr 2019 17:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138357;
        bh=VY4jNl1p2xWfqnE0floxqbk9Kr7P5KblGNSV2knrJok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lg3ktdJIUZIvBdAPW0Wp7akntcuIYnbmPDw6GYAW9N+rl1yuLe12BcVfPrSEz2vMG
         LGXG/f8yue4Pd7P9PXfwtj1c0ZoN/MBP883D+Q+mzTA3wN++wvuEspJfeIySpAfJ94
         PiQVP4CKfCwIod2hvhsmTnT14734hQONf6rcjdJY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>,
        Andrea Righi <andrea.righi@canonical.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.0 041/146] btrfs: raid56: properly unmap parity page in finish_parity_scrub()
Date:   Mon,  1 Apr 2019 19:00:53 +0200
Message-Id: <20190401170051.981481040@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrea Righi <andrea.righi@canonical.com>

commit 3897b6f0a859288c22fb793fad11ec2327e60fcd upstream.

Parity page is incorrectly unmapped in finish_parity_scrub(), triggering
a reference counter bug on i386, i.e.:

 [ 157.662401] kernel BUG at mm/highmem.c:349!
 [ 157.666725] invalid opcode: 0000 [#1] SMP PTI

The reason is that kunmap(p_page) was completely left out, so we never
did an unmap for the p_page and the loop unmapping the rbio page was
iterating over the wrong number of stripes: unmapping should be done
with nr_data instead of rbio->real_stripes.

Test case to reproduce the bug:

 - create a raid5 btrfs filesystem:
   # mkfs.btrfs -m raid5 -d raid5 /dev/sdb /dev/sdc /dev/sdd /dev/sde

 - mount it:
   # mount /dev/sdb /mnt

 - run btrfs scrub in a loop:
   # while :; do btrfs scrub start -BR /mnt; done

BugLink: https://bugs.launchpad.net/bugs/1812845
Fixes: 5a6ac9eacb49 ("Btrfs, raid56: support parity scrub on raid56")
CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/raid56.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2429,8 +2429,9 @@ static noinline void finish_parity_scrub
 			bitmap_clear(rbio->dbitmap, pagenr, 1);
 		kunmap(p);
 
-		for (stripe = 0; stripe < rbio->real_stripes; stripe++)
+		for (stripe = 0; stripe < nr_data; stripe++)
 			kunmap(page_in_rbio(rbio, stripe, pagenr, 0));
+		kunmap(p_page);
 	}
 
 	__free_page(p_page);


