Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AA1C742A1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4803C20872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562876264;
	bh=ecxQia7h6zY6lkWAw+wdMlXxzbuuZS5Qi/XXUMkiRSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jqCGQPpREtKDKCK4FxG8LkEfdDbZs9iqQWAOcOS6c6zfF/HoSROHXZfbiu4+/qLGS
	 V9Qq72hp/NLeia4a7H5Temoq2BeK8j2w3A7yaRiwiEu0VximTGBz2dJGVXXQTwPOZf
	 G9SHIYv/dl4u4HnDw+a9FG54W6dCU8mMqv9VSI18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbfGKURn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 16:17:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36407 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfGKURm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 16:17:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id k8so3606634plt.3;
        Thu, 11 Jul 2019 13:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N9MaYRqFkwAqF71ONnWTbJHi2D4rYHtA0InGA4H4rtg=;
        b=jRwO0RU1eD9uhuPJB7SM4XRu53do87oN8eoHLUW6PVVlTBOGDG6d2h/dRHNfz1pzLD
         3GMYzI6zSDRQWN+Xoo2ZzIDTqZKzTudzwmH4OHBxRvP2KujXlP3iVMEV02h3x78JMN0I
         VdwG1G++4ju7anDfUgVsizF+90IE+a3p5Fcux5x/M0o1QYIWVHsttw1HScD4Lovd99Z+
         NVDaJKY2G7H3wNa71683ET7L5nemHP4SjzsAS5TjIHgl9QnczSmU6aRGT69id6YrWsi/
         KZ1nWIqiPhksGN7A9+KjmZV6eBYv7BP+PTEAQeojBrCOZyDxzExqsG9g2T+I7DCsLQ7w
         22sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=N9MaYRqFkwAqF71ONnWTbJHi2D4rYHtA0InGA4H4rtg=;
        b=JNlrFUuu8xVvIKomRso3IaCr+yknEBL2q8Xfaw8pGhQItuT/fwRWjhAvqJE4tpUue5
         MaXPFhqLUi4WDZwiz9+lY6OWu1IZBIMSkJkA+OjdENtigxicqzcmq6MtmAuf6IW67PHP
         yhyb9e6Bzi4qFYwe/Q9z5KujVqiVstzRkQnMiaydgGItOTI5+KVcQhMCwkJtRFbdq/5c
         X79fcfDhZUYI+gHVOV5PDFxP0ZpIrk0ife3uCNQNxhj2rfvfFcTW8N71sUh0CFqzEhgn
         5TLGLgzz7WpOfyrV9DcRm26mSwZP1jdPhYT4QwX5hC+xjGoxbHn8U2wYkAjGt1b53jCr
         HXWw==
X-Gm-Message-State: APjAAAWxYwVXjZNCZniK7sqlJNrNBwn4Hxa/NsWi+qb1Sowgu4dZFoHm
        i7cqNO4z4NfByyVRsVMxMPM=
X-Google-Smtp-Source: APXvYqyN8jV+gtWrH9cp4npV6WpiaPT8McmMqTbhekQ4Aituc/lP2flHFGQoYVZe04X31XueQMx80g==
X-Received: by 2002:a17:902:2aab:: with SMTP id j40mr6422191plb.76.1562876261867;
        Thu, 11 Jul 2019 13:17:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:4153])
        by smtp.gmail.com with ESMTPSA id e63sm5911276pgc.62.2019.07.11.13.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 13:17:39 -0700 (PDT)
Date:   Thu, 11 Jul 2019 13:17:36 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jens Axboe <axboe@kernel.dk>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: Re: linux-next: build failure after merge of the block tree
Message-ID: <20190711201736.GQ657710@devbig004.ftw2.facebook.com>
References: <20190711151507.7ec1fd18@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711151507.7ec1fd18@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Yeah, my patche series raced with 8648de2c581e ("f2fs: add bio cache
for IPU").  Jens, can you please apply this one too?

On Thu, Jul 11, 2019 at 03:15:07PM +1000, Stephen Rothwell wrote:
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 11 Jul 2019 15:13:21 +1000
> Subject: [PATCH] f2fs: fix for wbc_account_io rename
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  fs/f2fs/data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 323306630f93..4eb2f3920140 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -513,7 +513,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>  	}
>  
>  	if (fio->io_wbc)
> -		wbc_account_io(fio->io_wbc, page, PAGE_SIZE);
> +		wbc_account_cgroup_owner(fio->io_wbc, page, PAGE_SIZE);

  Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
