Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34162C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 10:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE56207FC
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 10:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfIHKWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 06:22:31 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:41984 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbfIHKWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 06:22:30 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id DFE0E15CBF0;
        Sun,  8 Sep 2019 19:22:29 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-14) with ESMTPS id x88AMSGl022374
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 8 Sep 2019 19:22:29 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-14) with ESMTPS id x88AMS95011910
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 8 Sep 2019 19:22:28 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id x88AMRmx011907;
        Sun, 8 Sep 2019 19:22:27 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fat: Delete an unnecessary check before brelse()
References: <cfff3b81-fb5d-af26-7b5e-724266509045@web.de>
Date:   Sun, 08 Sep 2019 19:22:27 +0900
In-Reply-To: <cfff3b81-fb5d-af26-7b5e-724266509045@web.de> (Markus Elfring's
        message of "Tue, 3 Sep 2019 15:00:11 +0200")
Message-ID: <87r24rxf30.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Elfring <Markus.Elfring@web.de> writes:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 3 Sep 2019 14:56:16 +0200
>
> The brelse() function tests whether its argument is NULL
> and then returns immediately.
> Thus the test around the call is not needed.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Thanks.

> ---
>  fs/fat/dir.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
> index 1bda2ab6745b..f4bc87a3c98d 100644
> --- a/fs/fat/dir.c
> +++ b/fs/fat/dir.c
> @@ -88,9 +88,7 @@ static int fat__get_entry(struct inode *dir, loff_t *pos,
>  	int err, offset;
>
>  next:
> -	if (*bh)
> -		brelse(*bh);
> -
> +	brelse(*bh);
>  	*bh = NULL;
>  	iblock = *pos >> sb->s_blocksize_bits;
>  	err = fat_bmap(dir, iblock, &phys, &mapped_blocks, 0, false);
> --
> 2.23.0
>

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
