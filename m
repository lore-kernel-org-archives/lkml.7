Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122BCC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52C720578
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BP+2uBTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731929AbfHOQcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 12:32:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35923 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730705AbfHOQcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:32:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id g4so1267659plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 09:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e5AR81pVrLpSOkNr7/eYssnE7D9iHMmdgw/0YazKbLk=;
        b=BP+2uBTqPhkx+piVq9TF3dGBmo3jHkuJ+wMRP2Ui/bokbaIh0Vg5Adz/5MbS45QDKd
         j0WRkqK6Q+z7BqfoXAf9sBzbU4N+WhobFjNL4dJUmTmdcf6kSETk6jWBYs4PUw5i8HXH
         n5X01pxkbnMYus7IbvZ3lMcIt4i8HpBZLLXrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e5AR81pVrLpSOkNr7/eYssnE7D9iHMmdgw/0YazKbLk=;
        b=SmC2QFxFdrXT6odF4fYJKMI/AKbErHBORL9xCPjW0v1KRMEKu1USFVR448ORz/W9Eu
         GqximLBjD+yLYthq21euODQgzmQJkxrN+zcgbkYyDS+BjuZNRDcR3uPITAyy6vJJ+pVU
         YULvg+iU44GtfqxGwA0m4xHAUalYoV5Wt2yaIUOwsSi42ehRnJPrDzs76wOjh0/1DMP2
         fGofa9Dytx+8NhSw591kRfAPkGPtELwxtzFGEH/mRyHH8leIiDW74Ahiuq3PLSw5fts/
         TTKhHeaFjzwLkrAwcCtJIPTCT5i4FCcZVCsNBfzpS1nqPin9NkY/U+m7YkO3d1cSIs2g
         f2OA==
X-Gm-Message-State: APjAAAUjtL7/TNhLzGmNv1NPq2jsHOp6JxU/ZD+RSAiTywwCRbdgNu6w
        5uifGEzOKiInqBdYbjPwRAaINA==
X-Google-Smtp-Source: APXvYqxbKVoQ2qS9wmLpyTLXKjkjdL92B8ZELrIIY7OLzcGJImUb56OlBZSn6Y0vBcYiZkQmIpVxuA==
X-Received: by 2002:a17:902:7286:: with SMTP id d6mr5095323pll.61.1565886737439;
        Thu, 15 Aug 2019 09:32:17 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id p5sm3442540pfg.184.2019.08.15.09.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:32:16 -0700 (PDT)
Date:   Thu, 15 Aug 2019 12:31:59 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Hridya Valsaraju <hridya@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v3 2/2] binder: Validate the default binderfs device
 names.
Message-ID: <20190815163159.GC75595@google.com>
References: <20190808222727.132744-1-hridya@google.com>
 <20190808222727.132744-3-hridya@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808222727.132744-3-hridya@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 03:27:26PM -0700, Hridya Valsaraju wrote:
> Length of a binderfs device name cannot exceed BINDERFS_MAX_NAME.
> This patch adds a check in binderfs_init() to ensure the same
> for the default binder devices that will be created in every
> binderfs instance.
> 
> Co-developed-by: Christian Brauner <christian.brauner@ubuntu.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> Signed-off-by: Hridya Valsaraju <hridya@google.com>
> ---

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

>  drivers/android/binderfs.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index aee46dd1be91..55c5adb87585 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -570,6 +570,18 @@ static struct file_system_type binder_fs_type = {
>  int __init init_binderfs(void)
>  {
>  	int ret;
> +	const char *name;
> +	size_t len;
> +
> +	/* Verify that the default binderfs device names are valid. */
> +	name = binder_devices_param;
> +	for (len = strcspn(name, ","); len > 0; len = strcspn(name, ",")) {
> +		if (len > BINDERFS_MAX_NAME)
> +			return -E2BIG;
> +		name += len;
> +		if (*name == ',')
> +			name++;
> +	}
>  
>  	/* Allocate new major number for binderfs. */
>  	ret = alloc_chrdev_region(&binderfs_dev, 0, BINDERFS_MAX_MINOR,
> -- 
> 2.22.0.770.g0f2c4a37fd-goog
> 
