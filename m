Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6740BC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 23:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2D721775
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 23:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="DQ8SOL9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfK1XUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 18:20:53 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39736 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfK1XUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 18:20:52 -0500
Received: by mail-qt1-f193.google.com with SMTP id g1so21239515qtj.6;
        Thu, 28 Nov 2019 15:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4wrtfYJ0ZRrF4xIj+YbUY5RqDD+dbVWXsMfnfGny9K0=;
        b=DQ8SOL9lmuVc4+VIprdeMwthCtcVkZkpRiob6V8S37zLs8HMl+j2V9n8hBAOis9L4y
         TElD3yoUACaiWPWuAbDHwJ8S3nsnO9BthUkkZwafCnzIqnvu1tWRPFLcMU7ZZkRPtKLZ
         0QdlGBcRuUIj9joHC36DEbJiszdfYb6tGDKxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4wrtfYJ0ZRrF4xIj+YbUY5RqDD+dbVWXsMfnfGny9K0=;
        b=jCkBOJfQDjLmpa09/0UBCLw3JbNsuLJEJ1mJKiSiRKGbKE8JLidhb0A/lwrUMWk2/P
         SCRm9WQDxIh43/6EUArJLrclBeOR/NpaKmCPFSyKuCjwBFENROX9CWYVn82vlkaQm3s1
         12eODAiMyEPjM3OC0eyC7cIVLyc+CYosWINwpaQQj4i87wPs5QhnGveKm+MlbH1wGMGH
         MU0LJFhfL1WX/UV97sT5Gk7hYgwShSwlr6SDiZRSUwea4SWjDBXYZkXbIcoPOFSZTCeA
         ds+c5kJ4tYyfHNWymciwmavbqMmT0blKkiFNV0Z5U+8p9mmsKKMREcVc3S1cuhafo7qx
         Zc9Q==
X-Gm-Message-State: APjAAAUVCWqVeZVHP1X7lqsbGR+eUiU64FPAXXCeXjGwuNEVqQzfIjGA
        Xh0h9J8BsTQ5ufYYnZcatVg2TmkArbwDhcA5n80=
X-Google-Smtp-Source: APXvYqwatmHj0nyfkI7nUoMvvCCmElW8d4G1PMsMWzHdku2gYbzMtkvo6PKmBNcVPGflvvGM9+dpNIRGvarYvaoZgT4=
X-Received: by 2002:ac8:8f3:: with SMTP id y48mr48872868qth.269.1574983251287;
 Thu, 28 Nov 2019 15:20:51 -0800 (PST)
MIME-Version: 1.0
References: <20191122233120.110344-1-colin.king@canonical.com>
In-Reply-To: <20191122233120.110344-1-colin.king@canonical.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 28 Nov 2019 23:20:38 +0000
Message-ID: <CACPK8Xe=Xa6fo98PDBKbXDyjgJNdu30gPOtY8K4TZyEqQ2VOuw@mail.gmail.com>
Subject: Re: [PATCH] fsi: fix bogos error returns from cfam_read and cfam_write
To:     Colin King <colin.king@canonical.com>
Cc:     Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-fsi@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On Fri, 22 Nov 2019 at 23:31, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> In the case where errors occur in functions cfam_read and cfam_write
> the error return code in rc is not returned and a bogus non-error
> count size is returned instead. Fix this by returning the correct
> error code when an error occurs or the count size if the functions
> worked correctly.

 You're correct that if there's an error we need to return an error.

However the other case is when there's a partial read that completed.
We already advance the file offset, but I think we should also return
the number of bytes successfully read.

Cheers,

Joel

>
> Addresses-Coverity: ("Unused value")
> Fixes: d1dcd6782576 ("fsi: Add cfam char devices")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/fsi/fsi-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
> index 8244da8a7241..c3885b138ead 100644
> --- a/drivers/fsi/fsi-core.c
> +++ b/drivers/fsi/fsi-core.c
> @@ -718,7 +718,7 @@ static ssize_t cfam_read(struct file *filep, char __user *buf, size_t count,
>         rc = count;
>   fail:
>         *offset = off;
> -       return count;
> +       return rc;
>  }
>
>  static ssize_t cfam_write(struct file *filep, const char __user *buf,
> @@ -755,7 +755,7 @@ static ssize_t cfam_write(struct file *filep, const char __user *buf,
>         rc = count;
>   fail:
>         *offset = off;
> -       return count;
> +       return rc;
>  }
>
>  static loff_t cfam_llseek(struct file *file, loff_t offset, int whence)
> --
> 2.24.0
>
