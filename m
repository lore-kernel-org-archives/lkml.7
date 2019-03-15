Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF07C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 22:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EDC21019
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 22:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfCOWf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 18:35:26 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:35339 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfCOWf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 18:35:26 -0400
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2FMYaR3067719;
        Sat, 16 Mar 2019 07:34:36 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Sat, 16 Mar 2019 07:34:36 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2FMYUdl067701
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 16 Mar 2019 07:34:36 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH] security: inode: fix a missing check for
 securityfs_create_file
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <alpine.LRH.2.21.1903160608080.2905@namei.org>
 <20190315210025.17832-1-kjlu@umn.edu>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <4966a731-88b5-5cff-9d3b-0aa649a2065d@I-love.SAKURA.ne.jp>
Date:   Sat, 16 Mar 2019 07:34:32 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190315210025.17832-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/03/16 6:00, Kangjie Lu wrote:
> securityfs_create_file  may fail. The fix checks its status and
> returns the error code upstream if it fails.

Failure in __init functions of vmlinux means that the system failed
before the global /sbin/init process starts. There is little value
with continuing the boot process. Calling panic() or BUG_ON() will
be OK, for the userspace will be get confused by lack of that file
even if we continued without securityfs entry in /proc/filesystems .

> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> 
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

