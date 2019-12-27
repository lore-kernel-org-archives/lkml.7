Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C553EC2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 01:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D9020740
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 01:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfL0ByL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 20:54:11 -0500
Received: from trent.utfs.org ([94.185.90.103]:36084 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbfL0ByL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 20:54:11 -0500
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id B7B4465591;
        Fri, 27 Dec 2019 02:54:09 +0100 (CET)
Date:   Thu, 26 Dec 2019 17:54:09 -0800 (PST)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        torvalds@linux-foundation.org
Subject: [PATCH] Re: filesystem being remounted supports timestamps until
 2038
In-Reply-To: <alpine.DEB.2.21.99999.375.1912201332260.21037@trent.utfs.org>
Message-ID: <alpine.DEB.2.21.99999.375.1912261445200.21037@trent.utfs.org>
References: <alpine.DEB.2.21.99999.375.1912201332260.21037@trent.utfs.org>
User-Agent: Alpine 2.21.99999 (DEB 375 2019-10-29)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Dec 2019, Christian Kujau wrote:
> I noticed the following messages in my dmesg:
> 
>  xfs filesystem being remounted at /mnt/disk supports imestamps until 2038 (0x7fffffff)
> 
> These messages get printed over and over again because /mnt/disk is 
> usually a read-only mount that is remounted (rw) a couple of times a day 
> for backup purposes.
> 
> I see that these messages have been introduced with f8b92ba67c5d ("mount: 
> Add mount warning for impending timestamp expiry") resp. 0ecee6699064 
> ("fix use-after-free of mount in mnt_warn_timestamp_expiry()") and I was 
> wondering if there is any chance to either adjust this to pr_debug (but 
> then it would still show up in dmesg, right?) or to only warn once when 
> it's mounted, but not on re-mount?

I realize that "it's the holidays", but it'd be a shame if this gets 
forgotten :(


# uptime; dmesg | grep -c 2038
 14:45:15 up 6 days, 21:16,  1 user,  load average: 0.20, 0.22, 0.27
350

Attached is a "fix" that changes pr_warn into pr_debug, but that's maybe 
not what was intended here.


Thanks,
Christian.


commit c9a5338b4930cdf99073042de0717db43d7b75be
Author: Christian Kujau <lists@nerdbynature.de>
Date:   Thu Dec 26 17:39:57 2019 -0800

    Commit f8b92ba67c5d ("mount: Add mount warning for impending timestamp expiry") resp.
    0ecee6699064 ("fix use-after-free of mount in mnt_warn_timestamp_expiry()") introduced
    a pr_warn message and the following gets sent to dmesg on every remount:
    
     [...] filesystem being remounted at /mnt supports timestamps until 2038 (0x7fffffff)
    
    When file systems are remounted a couple of times per day (e.g. rw/ro for backup
    purposes), dmesg gets flooded with these messages. Change pr_warn into pr_debug
    to make it stop.
    
    Signed-off-by: Christian Kujau <lists@nerdbynature.de>

diff --git a/fs/namespace.c b/fs/namespace.c
index be601d3a8008..afc6a13e7316 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2478,7 +2478,7 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
 
 		time64_to_tm(sb->s_time_max, 0, &tm);
 
-		pr_warn("%s filesystem being %s at %s supports timestamps until %04ld (0x%llx)\n",
+		pr_debug("%s filesystem being %s at %s supports timestamps until %04ld (0x%llx)\n",
 			sb->s_type->name,
 			is_mounted(mnt) ? "remounted" : "mounted",
 			mntpath,



-- BOFH excuse #132:

SCSI Chain overterminated
