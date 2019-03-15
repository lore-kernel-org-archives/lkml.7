Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678F7C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3E5218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfCOTJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 15:09:05 -0400
Received: from namei.org ([65.99.196.166]:57212 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfCOTJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 15:09:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x2FJ8ha0003194;
        Fri, 15 Mar 2019 19:08:43 GMT
Date:   Sat, 16 Mar 2019 06:08:43 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Kangjie Lu <kjlu@umn.edu>
cc:     pakki001@umn.edu, "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH] security: inode: fix a missing check for
 securityfs_create_file
In-Reply-To: <20190315040901.31551-1-kjlu@umn.edu>
Message-ID: <alpine.LRH.2.21.1903160608080.2905@namei.org>
References: <20190315040901.31551-1-kjlu@umn.edu>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2019, Kangjie Lu wrote:

> securityfs_create_file  may fail. The fix checks its status and
> returns EFAULT upstream if it fails.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  security/inode.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/security/inode.c b/security/inode.c
> index b7772a9b315e..11d9a6bc2161 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -339,6 +339,11 @@ static int __init securityfs_init(void)
>  #ifdef CONFIG_SECURITY
>  	lsm_dentry = securityfs_create_file("lsm", 0444, NULL, NULL,
>  						&lsm_ops);
> +	if (IS_ERR(lsm_dentry)) {
> +		unregister_filesystem(&fs_type);
> +		sysfs_remove_mount_point(kernel_kobj, "security");
> +		return -EFAULT;
> +	}
>  #endif
>  	return 0;
>  }
> 

Good catch, but you should propagate the error returned from 
securityfs_create_file().


-- 
James Morris
<jmorris@namei.org>

