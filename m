Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B14C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 12:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE00222C1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 12:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKKMZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 07:25:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:47060 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726927AbfKKMZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 07:25:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9D9EAB14E;
        Mon, 11 Nov 2019 12:25:57 +0000 (UTC)
Subject: Re: [PATCH][next] xen/gntdev: remove redundant non-zero check on ret
To:     Colin King <colin.king@canonical.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191111122009.67789-1-colin.king@canonical.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <04efe197-2914-ab1d-918b-8899aa0354af@suse.com>
Date:   Mon, 11 Nov 2019 13:25:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191111122009.67789-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.11.19 13:20, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The non-zero check on ret is always going to be false because
> ret was initialized as zero and the only place it is set to
> non-zero contains a return path before the non-zero check. Hence
> the check is redundant and can be removed.

Which version did you patch against? In current master the above
statement is not true.


Juergen

> 
> Addresses-Coverity: ("Logically dead code")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/xen/gntdev.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
> index 10cc5e9e612a..07d80b176118 100644
> --- a/drivers/xen/gntdev.c
> +++ b/drivers/xen/gntdev.c
> @@ -524,11 +524,6 @@ static int gntdev_open(struct inode *inode, struct file *flip)
>   	}
>   #endif
>   
> -	if (ret) {
> -		kfree(priv);
> -		return ret;
> -	}
> -
>   	flip->private_data = priv;
>   #ifdef CONFIG_XEN_GRANT_DMA_ALLOC
>   	priv->dma_dev = gntdev_miscdev.this_device;
> 

