Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AD7C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E82217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbfG3JbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:31:10 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:55402 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730931AbfG3JbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:31:10 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 9548A15F926;
        Tue, 30 Jul 2019 18:31:08 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id x6U9V7FK030262
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 30 Jul 2019 18:31:08 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id x6U9V7O4001723
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 30 Jul 2019 18:31:07 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id x6U9V65R001722;
        Tue, 30 Jul 2019 18:31:06 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org
Subject: Re: [PATCH 12/20] fs: fat: Initialize filesystem timestamp ranges
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
        <20190730014924.2193-13-deepa.kernel@gmail.com>
Date:   Tue, 30 Jul 2019 18:31:06 +0900
In-Reply-To: <20190730014924.2193-13-deepa.kernel@gmail.com> (Deepa Dinamani's
        message of "Mon, 29 Jul 2019 18:49:16 -0700")
Message-ID: <878ssfc1id.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deepa Dinamani <deepa.kernel@gmail.com> writes:

> +/* DOS dates from 1980/1/1 through 2107/12/31 */
> +#define FAT_DATE_MIN (0<<9 | 1<<5 | 1)
> +#define FAT_DATE_MAX (127<<9 | 12<<5 | 31)
> +#define FAT_TIME_MAX (23<<11 | 59<<5 | 29)
> +
>  /*
>   * A deserialized copy of the on-disk structure laid out in struct
>   * fat_boot_sector.
> @@ -1605,6 +1610,7 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
>  	int debug;
>  	long error;
>  	char buf[50];
> +	struct timespec64 ts;
>  
>  	/*
>  	 * GFP_KERNEL is ok here, because while we do hold the
> @@ -1698,6 +1704,12 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
>  	sbi->free_clus_valid = 0;
>  	sbi->prev_free = FAT_START_ENT;
>  	sb->s_maxbytes = 0xffffffff;
> +	fat_time_fat2unix(sbi, &ts, 0, cpu_to_le16(FAT_DATE_MIN), 0);
> +	sb->s_time_min = ts.tv_sec;
> +
> +	fat_time_fat2unix(sbi, &ts, cpu_to_le16(FAT_TIME_MAX),
> +			  cpu_to_le16(FAT_DATE_MAX), 0);
> +	sb->s_time_max = ts.tv_sec;

At least, it is wrong to call fat_time_fat2unix() before setup parameters
in sbi.

And please move those timestamp stuff to fat/misc.c like other fat
timestamp helpers. (Maybe, provide fat_time_{min,max}() from fat/misc.c,
or fat_init_time() such?).

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
