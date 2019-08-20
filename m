Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A65C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 07:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D7C214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 07:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbfHTHL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 03:11:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36731 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbfHTHL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 03:11:57 -0400
Received: from 1.general.tyhicks.us.vpn ([10.172.64.52] helo=elm)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <tyhicks@canonical.com>)
        id 1hzyJ6-0001nu-Ta; Tue, 20 Aug 2019 07:11:53 +0000
Date:   Tue, 20 Aug 2019 00:11:32 -0700
From:   Tyler Hicks <tyhicks@canonical.com>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     "open list:ECRYPT FILE SYSTEM" <ecryptfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ecryptfs: fix a memory leak bug
Message-ID: <20190820071131.GB22824@elm>
References: <1566279234-9634-1-git-send-email-wenwen@cs.uga.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566279234-9634-1-git-send-email-wenwen@cs.uga.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-20 00:33:54, Wenwen Wang wrote:
> In ecryptfs_init_messaging(), if the allocation for 'ecryptfs_msg_ctx_arr'
> fails, the previously allocated 'ecryptfs_daemon_hash' is not deallocated,
> leading to a memory leak bug. To fix this issue, free
> 'ecryptfs_daemon_hash' before returning the error.
> 
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>

Thanks for the patch!

I added the following tags to the commit message:

 Cc: stable@vger.kernel.org
 Fixes: 88b4a07e6610 ("[PATCH] eCryptfs: Public key transport mechanism")

I also added the function name to the commit subject so that it was
unique from your other fix.

I've pushed the fix to the eCryptfs next branch and I'll submit a pull
request for inclusion soon.

Tyler

> ---
>  fs/ecryptfs/messaging.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ecryptfs/messaging.c b/fs/ecryptfs/messaging.c
> index d668e60..c05ca39 100644
> --- a/fs/ecryptfs/messaging.c
> +++ b/fs/ecryptfs/messaging.c
> @@ -379,6 +379,7 @@ int __init ecryptfs_init_messaging(void)
>  					* ecryptfs_message_buf_len),
>  				       GFP_KERNEL);
>  	if (!ecryptfs_msg_ctx_arr) {
> +		kfree(ecryptfs_daemon_hash);
>  		rc = -ENOMEM;
>  		goto out;
>  	}
> -- 
> 2.7.4
> 
