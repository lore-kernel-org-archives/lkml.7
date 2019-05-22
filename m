Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FBDC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3D7217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558528152;
	bh=upmsRZdkQq8h/PyD9HJOtFErgwAT7ktBsV7srF/AT70=;
	h=Subject:To:References:From:Date:In-Reply-To:List-ID:From;
	b=yQKD8Kr/oR5GvzHPqa/RqJIf3llGtX+lWBeqske1+pXkGW/ljBWdOx10YF4JUer6+
	 mld6a4vvU0PNmqGOJ0IOVKSwX2UaO7GVU7Do9/SGFjXUw5BnFxpZX+FMTJmR4Rg44m
	 EaEzH17zEn90zG06gwWaJSJ1wpJh/21bQdfDBqiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbfEVM3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 08:29:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728914AbfEVM3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 08:29:11 -0400
Received: from [192.168.0.101] (unknown [49.77.233.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30B0C2173C;
        Wed, 22 May 2019 12:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558528150;
        bh=upmsRZdkQq8h/PyD9HJOtFErgwAT7ktBsV7srF/AT70=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=bJfD+mjFb6YdomL+VqHfR6L1H6ztDKFP/+OfrymNyi4djSftXdHR/bx4GkO4OY7Q9
         K96jNO+km9Hcjda9UHQtxiEo3bNKrIdrK3Apk0sWuAsjCaSOLQMQfohPVdtpBvVnQP
         M54ptaNLWAaA8y/o/ba0aZEzLh4ixvb3hJgemL/A=
Subject: Re: [f2fs-dev] [PATCH 1/2] Revert "f2fs: don't clear
 CP_QUOTA_NEED_FSCK_FLAG"
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20190521180625.10562-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <8e9a4cac-c81b-11ce-0a5a-c6f5caf716c4@kernel.org>
Date:   Wed, 22 May 2019 20:29:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190521180625.10562-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-5-22 2:06, Jaegeuk Kim wrote:
> This reverts commit fb40d618b03978b7cc5820697894461f4a2af98b.
> 
> The original patch introduced # of fsck triggers.

How about pointing out the old issue has been fixed with below patch:

f2fs-tools: fix to check total valid block count before block allocation

Otherwise, user should keep kernel commit "f2fs: don't clear
CP_QUOTA_NEED_FSCK_FLAG".

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/checkpoint.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index d0539ddad6e2..89825261d474 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1317,10 +1317,8 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  
>  	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
>  		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> -	/*
> -	 * TODO: we count on fsck.f2fs to clear this flag until we figure out
> -	 * missing cases which clear it incorrectly.
> -	 */
> +	else
> +		__clear_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
>  
>  	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
>  		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> 
