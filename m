Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DD5C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FAF20717
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfLPNOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:14:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:52824 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727656AbfLPNOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:14:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 505B2AEF5;
        Mon, 16 Dec 2019 13:14:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 027C41E0B2E; Mon, 16 Dec 2019 14:14:19 +0100 (CET)
Date:   Mon, 16 Dec 2019 14:14:19 +0100
From:   Jan Kara <jack@suse.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>
Subject: Re: [PATCH v2 09/24] quota: avoid time_t in v1_disk_dqblk definition
Message-ID: <20191216131419.GG22157@quack2.suse.cz>
References: <20191213204936.3643476-1-arnd@arndb.de>
 <20191213205221.3787308-6-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213205221.3787308-6-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 13-12-19 21:52:14, Arnd Bergmann wrote:
> The time_t type is part of the user interface and not always the
> same, with the move to 64-bit timestamps and the difference between
> architectures.
> 
> Make the quota format definition independent of this type and use
> a basic type of the same length. Make it unsigned in the process
> to keep the v1 format working until year 2106 instead of 2038
> on 32-bit architectures.
> 
> Hopefully, everybody has already moved to a newer format long
> ago (v2 was introduced with linux-2.4), but it's hard to be sure.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

What's worse, time_t is actually a part of on-disk format for this ancient
quota format making format incompatible between 32-bit and 64-bit
systems... Anyway, your patch looks good, I'll add it to my tree (speak up
if you want to merge it yourself due to something depending on it).

								Honza

> ---
>  fs/quota/quotaio_v1.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/quota/quotaio_v1.h b/fs/quota/quotaio_v1.h
> index bd11e2c08119..31dca9a89176 100644
> --- a/fs/quota/quotaio_v1.h
> +++ b/fs/quota/quotaio_v1.h
> @@ -25,8 +25,10 @@ struct v1_disk_dqblk {
>  	__u32 dqb_ihardlimit;	/* absolute limit on allocated inodes */
>  	__u32 dqb_isoftlimit;	/* preferred inode limit */
>  	__u32 dqb_curinodes;	/* current # allocated inodes */
> -	time_t dqb_btime;	/* time limit for excessive disk use */
> -	time_t dqb_itime;	/* time limit for excessive inode use */
> +
> +	/* below fields differ in length on 32-bit vs 64-bit architectures */
> +	unsigned long dqb_btime; /* time limit for excessive disk use */
> +	unsigned long dqb_itime; /* time limit for excessive inode use */
>  };
>  
>  #define v1_dqoff(UID)      ((loff_t)((UID) * sizeof (struct v1_disk_dqblk)))
> -- 
> 2.20.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
