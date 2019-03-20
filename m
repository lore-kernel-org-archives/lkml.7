Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767A5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 03:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43AA520830
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 03:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="avOOWjDE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eKO549Gw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfCTDbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 23:31:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51422 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfCTDbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 23:31:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2249D60E59; Wed, 20 Mar 2019 03:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553052666;
        bh=jiXsFQhQNUbq4WnRHEcC3kDX/VbVeMW7Okj6NBywH/k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=avOOWjDExOOpMj4o/eeIqyqBqOGbZyup+AwtyPKCL7VbdlSMrTmZb1t6Qg9ZOLJv/
         DwJv5BE39oe3fUcTQyionn+8DcXceXGJun0j1DKBIZLb1A8RBPz3GWaMCPmw2dtnjq
         UhrdW8eVPcENKUXiSxXZOWuYA6haN7d8HH+etmug=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 2ED3160850;
        Wed, 20 Mar 2019 03:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553052665;
        bh=jiXsFQhQNUbq4WnRHEcC3kDX/VbVeMW7Okj6NBywH/k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eKO549Gwa+S/JzVrYuMGQuYkRsb7TOaDBupCjrM3+jy0mZNGRGjLBlKAYSng6tuOV
         wBnOj5dZosmiwORqJFyXwbrTJyRFWXijUTzTU9AzDj7wSO929J2R2bQidGX8k2V0n+
         YEQuEUknjTj+JzUrzxHg1xJfAh3krZi4Jl4WU1ww=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Mar 2019 09:01:05 +0530
From:   mgautam@codeaurora.org
To:     fei.yang@intel.com
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        zhangjerry@google.com, andrzej.p@collabora.com,
        plr.vincent@gmail.com, jingx.shen@intel.com,
        john.stultz@linaro.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb-owner@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_fs: don't free buffer prematurely
In-Reply-To: <1553037915-85931-1-git-send-email-fei.yang@intel.com>
References: <1553037915-85931-1-git-send-email-fei.yang@intel.com>
Message-ID: <f382765c6d30972ab84224a1b3982f62@codeaurora.org>
X-Sender: mgautam@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-20 04:55, fei.yang@intel.com wrote:
> From: Fei Yang <fei.yang@intel.com>
> 
> The following kernel panic happens due to the io_data buffer gets 
> deallocated
> before the async io is completed. Add a check for the case where 
> io_data buffer
> should be deallocated by ffs_user_copy_worker.

[snip]

Please add tag - 'Fixes: 772a7a724f6 ("usb: gadget: f_fs: Allow 
scatter-gather buffers")


> ---
>  drivers/usb/gadget/function/f_fs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/f_fs.c
> b/drivers/usb/gadget/function/f_fs.c
> index 20413c2..47be961 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -1133,7 +1133,8 @@ static ssize_t ffs_epfile_io(struct file *file,
> struct ffs_io_data *io_data)
>  error_mutex:
>  	mutex_unlock(&epfile->mutex);
>  error:
> -	ffs_free_buffer(io_data);
> +	if (ret != -EIOCBQUEUED) /* don't free if there is iocb queued */
> +		ffs_free_buffer(io_data);
>  	return ret;
>  }
