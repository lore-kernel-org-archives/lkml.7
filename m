Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E21C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534072087B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbfHENav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:30:51 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:58279 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbfHENar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:30:47 -0400
Received: from [167.98.27.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hud4W-0004bY-Ou; Mon, 05 Aug 2019 14:30:44 +0100
Message-ID: <12c095e595836a7ff7f2c7b2a32cb5544dd29b55.camel@codethink.co.uk>
Subject: Re: [Y2038] [PATCH 05/20] utimes: Clamp the timestamps before update
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Deepa Dinamani <deepa.kernel@gmail.com>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        arnd@arndb.de
Date:   Mon, 05 Aug 2019 14:30:43 +0100
In-Reply-To: <20190730014924.2193-6-deepa.kernel@gmail.com>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
         <20190730014924.2193-6-deepa.kernel@gmail.com>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-29 at 18:49 -0700, Deepa Dinamani wrote:
> POSIX is ambiguous on the behavior of timestamps for
> futimens, utimensat and utimes. Whether to return an
> error or silently clamp a timestamp beyond the range
> supported by the underlying filesystems is not clear.
> 
> POSIX.1 section for futimens, utimensat and utimes says:
> (http://pubs.opengroup.org/onlinepubs/9699919799/functions/futimens.html)
> 
> The file's relevant timestamp shall be set to the greatest
> value supported by the file system that is not greater
> than the specified time.
> 
> If the tv_nsec field of a timespec structure has the special
> value UTIME_NOW, the file's relevant timestamp shall be set
> to the greatest value supported by the file system that is
> not greater than the current time.
> 
> [EINVAL]
>     A new file timestamp would be a value whose tv_sec
>     component is not a value supported by the file system.
> 
> The patch chooses to clamp the timestamps according to the
> filesystem timestamp ranges and does not return an error.
> This is in line with the behavior of utime syscall also
> since the POSIX page(http://pubs.opengroup.org/onlinepubs/009695399/functions/utime.html)
> for utime does not mention returning an error or clamping like above.
> 
> Same for utimes http://pubs.opengroup.org/onlinepubs/009695399/functions/utimes.html
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> ---
>  fs/utimes.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/utimes.c b/fs/utimes.c
> index 350c9c16ace1..4c1a2ce90bbc 100644
> --- a/fs/utimes.c
> +++ b/fs/utimes.c
> @@ -21,6 +21,7 @@ static int utimes_common(const struct path *path, struct timespec64 *times)
>  	int error;
>  	struct iattr newattrs;
>  	struct inode *inode = path->dentry->d_inode;
> +	struct super_block *sb = inode->i_sb;
>  	struct inode *delegated_inode = NULL;
>  
>  	error = mnt_want_write(path->mnt);
> @@ -36,16 +37,24 @@ static int utimes_common(const struct path *path, struct timespec64 *times)
>  		if (times[0].tv_nsec == UTIME_OMIT)
>  			newattrs.ia_valid &= ~ATTR_ATIME;
>  		else if (times[0].tv_nsec != UTIME_NOW) {
> -			newattrs.ia_atime.tv_sec = times[0].tv_sec;
> -			newattrs.ia_atime.tv_nsec = times[0].tv_nsec;
> +			newattrs.ia_atime.tv_sec =
> +				clamp(times[0].tv_sec, sb->s_time_min, sb->s_time_max);
> +			if (times[0].tv_sec == sb->s_time_max || times[0].tv_sec == sb->s_time_min)

This is testing the un-clamped value.

> +				newattrs.ia_atime.tv_nsec = 0;
> +			else
> +				newattrs.ia_atime.tv_nsec = times[0].tv_nsec;
>  			newattrs.ia_valid |= ATTR_ATIME_SET;
>  		}
>  
>  		if (times[1].tv_nsec == UTIME_OMIT)
>  			newattrs.ia_valid &= ~ATTR_MTIME;
>  		else if (times[1].tv_nsec != UTIME_NOW) {
> -			newattrs.ia_mtime.tv_sec = times[1].tv_sec;
> -			newattrs.ia_mtime.tv_nsec = times[1].tv_nsec;
> +			newattrs.ia_mtime.tv_sec =
> +				clamp(times[1].tv_sec, sb->s_time_min, sb->s_time_max);
> +			if (times[1].tv_sec >= sb->s_time_max || times[1].tv_sec == sb->s_time_min)

Similarly here, for the minimum.

I suggest testing for clamping like this:

			if (newattrs.ia_atime.tv_sec != times[0].tv_sec)
				...
			if (newattrs.ia_mtime.tv_sec != times[1].tv_sec)
				...

Ben.

> +				newattrs.ia_mtime.tv_nsec = 0;
> +			else
> +				newattrs.ia_mtime.tv_nsec = times[1].tv_nsec;
>  			newattrs.ia_valid |= ATTR_MTIME_SET;
>  		}
>  		/*
-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

