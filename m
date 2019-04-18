Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC20FC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B972F21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="lPDP9gRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389749AbfDRQ65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:58:57 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44791 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388401AbfDRQ65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:58:57 -0400
Received: by mail-ot1-f67.google.com with SMTP id d24so2260411otl.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 09:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RGS6YsOAVjQwa/YToZjt45UAijXd7Hd/Y2bsvCoDiv4=;
        b=lPDP9gRl2UM8hL2yHwEifePQ2gNrAFI7Lm7RsIYQ6i/ADklZsURlEsFOJzxucAfxEw
         lUaRhOTQcSS1bZvlJD7canHxoZsoBpryjPw2fpJ81Q8YMJvjGSFtilCNnJlWHWNgRHwo
         O3w01XwE6RAvU3KhewiLqPAOTt8H788oq3cOeLbii5wRr/l83ayuQCdbw4GPyO/Dx4si
         sb+3FQtXCv8psVj21FtUDDpIZi5Q5qEWf1Uyoj6ELOR3LBIKkjOjip1fGiW6pm5wXc/+
         UObMfY8J4ms31f9IoSjhzGfRWVfMpHteNuGS9kH/FLe6yKdMaVg9sDii9o6qLqfDcYV1
         4DMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RGS6YsOAVjQwa/YToZjt45UAijXd7Hd/Y2bsvCoDiv4=;
        b=K8bF1kwahH/GFnuje2zc03wwDyJe+jOEX5auxjc8ANI7/zO3BY0ZtXGOyyfNoPfmA2
         6yDnILymR6KhS+3khxz7/3z0KLnLnOr4na2HPC9BjC8LgJ+ZK5gTc0e7fyFbjQfCs44m
         2cDBaNRNOCYd2onrxi8k0OOmGkBp8i2frirRkZqwVKCM/hfvTVTG24XkYaNgtGUDw6ZG
         RMn12kJsPots6ZhfycbCACuX3l1COOilDRYGtPCC0A1+L3LzPs5bhYSTBLLFH+U1jWCi
         wCXJPJm03N83PmPlayesV2z9Bts7JjtRqr5ULeZXeQ7QK3dRcdTnaAWYAgFf5/i6ufsz
         k7Fg==
X-Gm-Message-State: APjAAAWDL2750NIihx7BWIHIn+g8C5zQS85W+aEVgJl/HMfhTSaLOmoS
        fWxh+MEjnySjTJqbKqFQNBHlYuS5wXq3BGHGaL4Thw==
X-Google-Smtp-Source: APXvYqzG9AhEh+CfRsyU3+SnE2IKIkora7yoZ4lhLKbo3TwMDMW8FpW9W0RM8ttvNJnHFNXaiaMWi7ypdHHrK54vTYo=
X-Received: by 2002:a05:6830:15d4:: with SMTP id j20mr4430515otr.367.1555606736360;
 Thu, 18 Apr 2019 09:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190416174900.GT2217@ZenIV.linux.org.uk> <20190416175340.21068-1-viro@ZenIV.linux.org.uk>
 <20190416175340.21068-49-viro@ZenIV.linux.org.uk> <20190418121620.GI28541@quack2.suse.cz>
In-Reply-To: <20190418121620.GI28541@quack2.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 18 Apr 2019 09:58:45 -0700
Message-ID: <CAPcyv4jomNs0V_0+VHUZyx88tbAijEF9KJfb4jDzyqkCR-ds=g@mail.gmail.com>
Subject: Re: [RFC PATCH 49/62] dax: make use of ->free_inode()
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 5:16 AM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 16-04-19 18:53:27, Al Viro wrote:
> > From: Al Viro <viro@zeniv.linux.org.uk>
> >
> > we might want to drop ->destroy_inode() there - it's used only for
> > WARN_ON() now, and AFAICS that could be moved to ->evict_inode()
> > if we had one...
> >
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> >  drivers/dax/super.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
>
> Added Dan to CC since I'm not sure how closely he follows fsdevel. The
> patch looks good to me FWIW so feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks Jan.

Acked-by: Dan Williams <dan.j.williams@intel.com>

Al, I assume you'll merge this with the other free_inode changes.
