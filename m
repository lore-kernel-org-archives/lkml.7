Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD82C388F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 07:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC38B21855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 07:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfI3HWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 03:22:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35133 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfI3HWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 03:22:13 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7445D80436; Mon, 30 Sep 2019 09:21:57 +0200 (CEST)
Date:   Mon, 30 Sep 2019 09:21:57 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 53/63] f2fs: fix to do sanity check on segment
 bitmap of LFS curseg
Message-ID: <20190930072157.GB22914@atrey.karlin.mff.cuni.cz>
References: <20190929135031.382429403@linuxfoundation.org>
 <20190929135040.450358370@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190929135040.450358370@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> +		for (blkofs += 1; blkofs < sbi->blocks_per_seg; blkofs++) {
> +			if (!f2fs_test_bit(blkofs, se->cur_valid_map))
> +				continue;
> +out:
> +			f2fs_msg(sbi->sb, KERN_ERR,
> +				"Current segment's next free block offset is "
> +				"inconsistent with bitmap, logtype:%u, "
> +				"segno:%u, type:%u, next_blkoff:%u, blkofs:%u",
> +				i, curseg->segno, curseg->alloc_type,
> +				curseg->next_blkoff, blkofs);
> +			return -EINVAL;
> +		}

So this is detecting filesystem corruption, right? Should it be
-EUCLEAN?

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
