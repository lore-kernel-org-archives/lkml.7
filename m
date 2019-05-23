Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FA2C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5B42133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558617473;
	bh=QzLR9zKzuUVe41ed3CRRrcG2QPpg2Y8M+WRioHn45M8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=go99Kr+9YxgAPDxCiLNfrxxEOaWUP26pdLLLhxWNfTnasug8ZtyM2yfTVf5gfqj5z
	 eSghKpcMw7+sAjmcIbchvDPAT/j5MiCmWJXGY5dIe6vlHOPmmjfii4V4HJHVPbkKpo
	 Cww4eddKdXNz5pvNZoQ+XGSbuX3+zRB0aD1n9XTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbfEWNRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 09:17:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbfEWNRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 09:17:51 -0400
Received: from [192.168.0.101] (unknown [58.212.135.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 868DD2075B;
        Thu, 23 May 2019 13:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558617470;
        bh=QzLR9zKzuUVe41ed3CRRrcG2QPpg2Y8M+WRioHn45M8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=zckNYzzXHUDDRnhqURRK9fAY/jYl+qGGa8r92VtFHnC6sj5UAjhlvArQFPgsZu/Uw
         ulm4Wm9CdTfUB+EmTy8eXAhr7ep5ZdWQXVwa0Jf1TGRAgSlfJufuEGy3igjclkEMOo
         b6FEJVwkeZIGPf8M049PDt0veZ5Biq9LYFCU4bZw=
Subject: Re: [f2fs-dev] [PATCH 1/2] Revert "f2fs: don't clear
 CP_QUOTA_NEED_FSCK_FLAG"
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20190521180625.10562-1-jaegeuk@kernel.org>
 <8e9a4cac-c81b-11ce-0a5a-c6f5caf716c4@kernel.org>
 <20190522174448.GA81051@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <1f370d69-cb4e-5526-cc87-e67100d91294@kernel.org>
Date:   Thu, 23 May 2019 21:17:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190522174448.GA81051@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-5-23 1:44, Jaegeuk Kim wrote:
> On 05/22, Chao Yu wrote:
>> On 2019-5-22 2:06, Jaegeuk Kim wrote:
>>> This reverts commit fb40d618b03978b7cc5820697894461f4a2af98b.
>>>
>>> The original patch introduced # of fsck triggers.
>>
>> How about pointing out the old issue has been fixed with below patch:
>>
>> f2fs-tools: fix to check total valid block count before block allocation
>>
>> Otherwise, user should keep kernel commit "f2fs: don't clear
>> CP_QUOTA_NEED_FSCK_FLAG".
> 
> Actually, that didn't fix my testing issue, but I found we were not using
> error control for quota_sysfile. Now I've seen no issue with the below patch.

Alright.

> 
> From e1b7de7050fd87b7c20e033b062b1cc6505679d3 Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Mon, 20 May 2019 16:17:56 -0700
> Subject: [PATCH] f2fs: link f2fs quota ops for sysfile
> 
> This patch reverts:
> commit fb40d618b039 ("f2fs: don't clear CP_QUOTA_NEED_FSCK_FLAG").
> 
> We were missing error handlers used in f2fs quota ops.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Good catch!

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/checkpoint.c | 6 ++----
>  fs/f2fs/super.c      | 5 +----
>  2 files changed, 3 insertions(+), 8 deletions(-)
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
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 856f9081c599..34f2adf191ed 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3169,10 +3169,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  
>  #ifdef CONFIG_QUOTA
>  	sb->dq_op = &f2fs_quota_operations;
> -	if (f2fs_sb_has_quota_ino(sbi))
> -		sb->s_qcop = &dquot_quotactl_sysfile_ops;
> -	else
> -		sb->s_qcop = &f2fs_quotactl_ops;
> +	sb->s_qcop = &f2fs_quotactl_ops;
>  	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
>  
>  	if (f2fs_sb_has_quota_ino(sbi)) {
> 
