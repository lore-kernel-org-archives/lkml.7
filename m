Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC09BC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CFC218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568837524;
	bh=/chlWVQdDDbU1oUJxPB9d8/3qiTPTTojAGNqFxZ0HI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HYYwM0wiqpOtQ463NoLd0VYbNRIYGNHdqloZCxhJxMJZBYQWlYmboRI5k+9VicWv4
	 U+2tmqg/oZVZBtBa4zkLPMFQX9/ZgzlyOwgCRFD2oYjSpM0z4ERvauaxlAzDG1dnpy
	 j7I/DiLEQOUuO6i1spy8Sqyi0Eh06m4PMuqfLxu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391072AbfIRUMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 16:12:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:32778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391057AbfIRUMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:12:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40A8D21A4C;
        Wed, 18 Sep 2019 20:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568837522;
        bh=/chlWVQdDDbU1oUJxPB9d8/3qiTPTTojAGNqFxZ0HI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OgkOx50FcQPkSYnKouKL41ERFq6xpp3MlOmnxXlOJKBMz/LE79/BAZ9d7hhrJxzst
         2RX74uIvXWirN/O9On1s+zoub4FL29DOO3z5dcwXx8bOhVnH8DoFA4j2uxVO7EEoHX
         cc8fCxDxzrG1CxHqKh7505zu53zKyYFk+GoGItUE=
Date:   Wed, 18 Sep 2019 22:12:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Park Ju Hyung <qkrwngud825@gmail.com>
Cc:     alexander.levin@microsoft.com, namjae.jeon@samsung.com,
        sergey.senozhatsky.work@gmail.com, sergey.senozhatsky@gmail.com,
        sj1557.seo@samsung.com, valdis.kletnieks@vt.edu,
        dan.carpenter@oracle.com, devel@driverdev.osuosl.org,
        linkinjeon@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: exfat: rebase to sdFAT v2.2.0
Message-ID: <20190918201200.GA2025570@kroah.com>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190918195920.25210-1-qkrwngud825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918195920.25210-1-qkrwngud825@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 04:59:20AM +0900, Park Ju Hyung wrote:
> The new sdFAT driver base brings many improvements to the table.
> Quoting Namjae Jeon:
> 
> ======================================================================
> 1. sdfat has been refactored to improve compatibility, readability and
> to be linux friendly.(included support mass storages larger than 2TB.)
> 
> 2. sdfat has been optimized for the performance of SD-cards.
>   - Support SD-card friendly block allocation and delayed allocation
>     for vfat-fs only.
>   - Support aligned_mpage_write for both vfat-fs and exfat-fs
> 
> 3. sdfat has been optimized for the performance of general operations
>     like create,lookup and readdir.
> 
> 4. Fix many critical and minor bugs
>  - Handle many kinds of error conditions gracefully to prevent panic.
>  - Fix critical bugs related to rmdir, truncate behavior and so on...
> 
> 5. Fix NLS functions
> ======================================================================
> 
> sdFAT v2.2.0 (from N970FXXU1ASHE) was forked and then cleaned up to better
> suit mainline's standards:
> 
>  * Remove fat12/16/32 handlings and rename to exFAT.
>  * Remove older kernel compatibilities.
>  * Remove Samsung's userspace-specific code (e.g. defrag).
>  * Fix compilation warnings on modern compiler.
>  * Remove unused functions.
>  * Rename non-static functions for avoiding global symbol table pollutions.
>  * Declare functions as static whenever possible.
>  * Fix checkpatch.pl errors.
>  * Remove aligned mpage write for portability.
> 
> Full rebase history can be found on:
> https://github.com/arter97/exfat-linux/commits/for-next
> 
> Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
> ---
>  drivers/staging/exfat/Kconfig        |   88 +-
>  drivers/staging/exfat/Makefile       |   11 +-
>  drivers/staging/exfat/TODO           |   15 +-
>  drivers/staging/exfat/api.h          |  265 ++
>  drivers/staging/exfat/blkdev.c       |  330 +++
>  drivers/staging/exfat/cache.c        |  785 +++++
>  drivers/staging/exfat/config.h       |   32 +
>  drivers/staging/exfat/core.c         | 3169 ++++++++++++++++++++
>  drivers/staging/exfat/core.h         |  149 +
>  drivers/staging/exfat/core_exfat.c   | 1485 ++++++++++
>  drivers/staging/exfat/exfat.h        | 1261 +++-----
>  drivers/staging/exfat/exfat_blkdev.c |  136 -
>  drivers/staging/exfat/exfat_cache.c  |  724 -----
>  drivers/staging/exfat/exfat_core.c   | 3701 -----------------------
>  drivers/staging/exfat/exfat_fs.h     |  398 +++
>  drivers/staging/exfat/exfat_nls.c    |  404 ---
>  drivers/staging/exfat/exfat_super.c  | 4049 --------------------------
>  drivers/staging/exfat/exfat_upcase.c |  740 -----
>  drivers/staging/exfat/extent.c       |  329 +++
>  drivers/staging/exfat/fatent.c       |  113 +
>  drivers/staging/exfat/misc.c         |  356 +++
>  drivers/staging/exfat/nls.c          |  323 ++
>  drivers/staging/exfat/super.c        | 3168 ++++++++++++++++++++
>  drivers/staging/exfat/upcase.h       |  394 +++
>  drivers/staging/exfat/xattr.c        |   76 +
>  25 files changed, 11777 insertions(+), 10724 deletions(-)

That's a lot of rewriting :(

How about at least keeping the file names the same to make it easier to
see what happened here?

Then send a follow-on patch that just does the rename?

And by taking something like this, are you agreeing that Samsung will
help out with the development of this code to clean it up and get it
into "real" mergable shape?

Also, I can't take this patch for this simple reason alone:

> --- a/drivers/staging/exfat/Makefile
> +++ b/drivers/staging/exfat/Makefile
> @@ -1,10 +1,5 @@
> -# SPDX-License-Identifier: GPL-2.0
> -

Don't delete SPDX lines :)

thanks,

greg k-h
