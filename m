Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97732CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7468920830
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732549AbfJ2JVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:21:10 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34051 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfJ2JVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:21:09 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iPNgQ-00044P-FT; Tue, 29 Oct 2019 10:20:58 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1iPNgP-0002iK-23; Tue, 29 Oct 2019 10:20:57 +0100
Date:   Tue, 29 Oct 2019 10:20:57 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     richard@nod.at, dedekind1@gmail.com, yi.zhang@huawei.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubifs: do_kill_orphans: Fix a memory leak bug
Message-ID: <20191029092057.fsklsibqrmbmacar@pengutronix.de>
References: <1572339670-68694-1-git-send-email-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572339670-68694-1-git-send-email-chengzhihao1@huawei.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:14:52 up 113 days, 15:25, 93 users,  load average: 0.01, 0.09,
 0.12
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 05:01:10PM +0800, Zhihao Cheng wrote:
> If there are more than one valid snod on the sleb->nodes list,
> do_kill_orphans will malloc ino more than once without releasing
> previous ino's memory. Finally, it will trigger memory leak.
> 
> Fixes: ee1438ce5dc4 ("ubifs: Check link count of inodes when...")
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> ---
>  fs/ubifs/orphan.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ubifs/orphan.c b/fs/ubifs/orphan.c
> index 3b4b411..f211ed3 100644
> --- a/fs/ubifs/orphan.c
> +++ b/fs/ubifs/orphan.c
> @@ -673,9 +673,11 @@ static int do_kill_orphans(struct ubifs_info *c, struct ubifs_scan_leb *sleb,
>  		if (first)
>  			first = 0;
>  
> -		ino = kmalloc(UBIFS_MAX_INO_NODE_SZ, GFP_NOFS);
> -		if (!ino)
> -			return -ENOMEM;
> +		if (!ino) {
> +			ino = kmalloc(UBIFS_MAX_INO_NODE_SZ, GFP_NOFS);
> +			if (!ino)
> +				return -ENOMEM;
> +		}

This solves only part of the problem. There are several places in the
loop that just return instead of jumping to out_free. These need to be
fixed as well.
I am not sure if it's worth it to allocate ino on demand. It would be
more straight forward to allocate it once initially before the loop.
Not sure though what Richard prefers.

Regards,
  Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
