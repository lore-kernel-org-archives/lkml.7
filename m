Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE20EC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF422077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbfDJRes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:34:48 -0400
Received: from namei.org ([65.99.196.166]:33488 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727226AbfDJRes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 13:34:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x3AHYh3C026648;
        Wed, 10 Apr 2019 17:34:43 GMT
Date:   Thu, 11 Apr 2019 03:34:43 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Kangjie Lu <kjlu@umn.edu>
cc:     pakki001@umn.edu, "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security: inode: fix a missing check for
 securityfs_create_file
In-Reply-To: <20190315210025.17832-1-kjlu@umn.edu>
Message-ID: <alpine.LRH.2.21.1904110334380.25754@namei.org>
References: <alpine.LRH.2.21.1903160608080.2905@namei.org> <20190315210025.17832-1-kjlu@umn.edu>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019, Kangjie Lu wrote:

> securityfs_create_file  may fail. The fix checks its status and
> returns the error code upstream if it fails.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> 

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

> ---
> Return the exact error code upstream.
> ---
>  security/inode.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/security/inode.c b/security/inode.c
> index b7772a9b315e..667f8b15027d 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -339,6 +339,11 @@ static int __init securityfs_init(void)
>  #ifdef CONFIG_SECURITY
>  	lsm_dentry = securityfs_create_file("lsm", 0444, NULL, NULL,
>  						&lsm_ops);
> +	if (IS_ERR(lsm_dentry)) {
> +		unregister_filesystem(&fs_type);
> +		sysfs_remove_mount_point(kernel_kobj, "security");
> +		return PTR_ERR(lsm_dentry);
> +	}
>  #endif
>  	return 0;
>  }
> 

-- 
James Morris
<jmorris@namei.org>

