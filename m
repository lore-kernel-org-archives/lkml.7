Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B260AC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 22:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76882242A8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 22:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559169220;
	bh=RH3AfYoY7Hep8k89nDOp88jHf91cqSPkd1Ls/lo/R3E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=i9fs2qiM9tVaUFKwVk3LuxvzPdmDAT50XUbxFHtraffG4pgIPqdKXIseFSBKx7YqF
	 SerGferWfKfUbchRFaOd3XiWmM4/7vGkrSAlFFKorpiBhBQZ3aTZ4UkHZ5336bJFug
	 8FTkn9iYYFFfK2y3rtVzhhsd+cf8yN+gDOr/QmJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfE2Wdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 18:33:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbfE2Wdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 18:33:39 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C0F3242A6;
        Wed, 29 May 2019 22:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559169218;
        bh=RH3AfYoY7Hep8k89nDOp88jHf91cqSPkd1Ls/lo/R3E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d+tLCS4K282W7Kh3BSHxJtRFOqcDCkyMt5IPhssKcqdf2T4rbsMmsIMA2+hYoZwVy
         O8AYShc8nqRBSiGsfjKXQJ1w37cjVYFUn2TVMExXKPGje42inX1u7NO+KsJJ6wDSCM
         Lybn4L8i5o5BHFYFbZiEeJp5Rmdky7WxGk2vngDM=
Date:   Wed, 29 May 2019 15:33:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] proc: use typeof_member() macro
Message-Id: <20190529153337.3e8fcd2b6b54e11e5ef23d04@linux-foundation.org>
In-Reply-To: <20190529191110.GB5703@avx2>
References: <20190529190720.GA5703@avx2>
        <20190529191110.GB5703@avx2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019 22:11:10 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Don't repeat function signatures twice.
> 
> This is a kind-of-precursor for "struct proc_ops".
> 
> Note:
> 
> 	typeof(pde->proc_fops->...) ...;
> 
> can't be used because ->proc_fops is "const struct file_operations *".
> "const" prevents assignment down the code and it can't be deleted
> in the type system.
>
> ...
>
> --- a/fs/proc/inode.c
> +++ b/fs/proc/inode.c
> @@ -200,7 +200,8 @@ static loff_t proc_reg_llseek(struct file *file, loff_t offset, int whence)
>  	struct proc_dir_entry *pde = PDE(file_inode(file));
>  	loff_t rv = -EINVAL;
>  	if (use_pde(pde)) {
> -		loff_t (*llseek)(struct file *, loff_t, int);
> +		typeof_member(struct file_operations, llseek) llseek;

ooh.  That's pretty nifty.


