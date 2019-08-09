Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8C1C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F1620C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565362288;
	bh=/MIKG1QqU/ZdAJJXW04QhI3YlfySCS1j/5dx63m1gXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qiMAi75lLUH3U4GiEbdTzY7jZfTbRBD9jHpOsP8OOephJMXhq2f+STuE129CevxBc
	 EmjgO5zjXXjinRvX77BpnDUXvkkj/HN1IcRlm0egNAeH4SX+L2wOyvPgo4eNfwGLNd
	 vZo2uvO6gImGbFvAcYl1HN9xbwKDR19AgWedCNvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407059AbfHIOv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:51:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfHIOv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:51:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4C532085B;
        Fri,  9 Aug 2019 14:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565362285;
        bh=/MIKG1QqU/ZdAJJXW04QhI3YlfySCS1j/5dx63m1gXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zvS33yVsxWsgFW9UWXOFBXbnSt+HLTg+B0Wpd+w04IWMfK0X3z/2XUKI6h8t1WgQ4
         WPeBhtrXhFgHKokhopOFtYcaN2FGoFSQf669vvK8mIYhCKqCp9fPq5M2Umig4xb3m9
         m/caGijs+c+UHkdqUB9n3lyldzR/2zT91D7/7xSE=
Date:   Fri, 9 Aug 2019 16:51:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hridya Valsaraju <hridya@google.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v3 2/2] binder: Validate the default binderfs device
 names.
Message-ID: <20190809145123.GC16262@kroah.com>
References: <20190808222727.132744-1-hridya@google.com>
 <20190808222727.132744-3-hridya@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808222727.132744-3-hridya@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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

Shouldn't this be a bugfix separate from patch 1/2?

And shouldn't it be backported to older kernels that currently have this
issue?

thanks,

greg k-h
