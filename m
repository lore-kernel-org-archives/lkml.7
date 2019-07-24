Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802D2C76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C2122AEC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="gTXhj9Zq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfGXOLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:11:09 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37040 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfGXOLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:11:08 -0400
Received: by mail-qt1-f193.google.com with SMTP id y26so45598461qto.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 07:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XSMSBO973DfvMeeteXqgGKF7W2+Loe7uKWtbLSmRJp4=;
        b=gTXhj9ZqVqh/c1Tlp0kQKLmIeOJZ9I0W7iJFijeEbYc2pw5WqfBaHyQhl/qzepZJlM
         infzsQJLb6v93ckbqBV7S4YQa39ItbL+e6nnT2zbh2KV3vK9UtV6EzNmp94ycAMB1PUP
         atzF38AlS0gWScipZSZVHIq9i57oaULt3ldLlCTsYx28piF73voCpHpl7b/DOKE6ELrD
         mwIezPCPGgOTGcpKkEbaGHZHCB2MeHoJxwuArMiAJFxhHUOmsSfckuqq/kkciwpYzhlD
         CNSrJEALAFWZKGCY85HLPMPi/4ZUb1MQOZuknR+CuwqWRTiFtOj9ESf4E4PNr9UjN6kR
         aNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XSMSBO973DfvMeeteXqgGKF7W2+Loe7uKWtbLSmRJp4=;
        b=BxRTMvhecnrgQ/sV2O2RSZ39spIyxYFpC1UHVLsSTsofVyHt+SKnIG61lgOE4EcG0o
         q1kWjNeQBwxbQdA+aSsd6HbbqPbNyV9p0Yb4PkS6dM9vX8ZNjbyWQkbJ+O1BKymoCy6x
         PGXRXI4/mLbSuCQIv9G1HMBdU9MuvStUtI6vqgncX9HGx0dyNAiBHnKGsKEr7EtT82yU
         cXBHBVTy3yZHtIvJG7vf67R0BsUzfj7QtOUfpfJBO427vCs8hxhXIEXnbNVCydEXHzDD
         ZQ12yGPe5TTGPW3WF+Q+woBET8iv18FFxij9Bl0I8ak9Y2ymOHp4AvyUMFC3FwQfW0oy
         7qjw==
X-Gm-Message-State: APjAAAVEN64xii6eWEObQ6GAajyZ9SW7cdYq/+t+jHGEJOXuxfni733v
        cLEA7hS2kCfVLVJXtkOpMe3+KQ==
X-Google-Smtp-Source: APXvYqy0tj9o47/lvntHG1UXs42ZsSWDwBvJZWHf+0IOq45oHpMmcsWa56sAZ9oeA906uiVqylpMDQ==
X-Received: by 2002:ac8:2642:: with SMTP id v2mr55104887qtv.333.1563977467644;
        Wed, 24 Jul 2019 07:11:07 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id r36sm24461459qte.71.2019.07.24.07.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 07:11:07 -0700 (PDT)
Message-ID: <1563977465.11067.9.camel@lca.pw>
Subject: Re: [PATCH] mm/mmap.c: silence variable 'new_start' set but not used
From:   Qian Cai <cai@lca.pw>
To:     YueHaibing <yuehaibing@huawei.com>, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com, vbabka@suse.cz,
        yang.shi@linux.alibaba.com, jannh@google.com, walken@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Wed, 24 Jul 2019 10:11:05 -0400
In-Reply-To: <20190724140739.59532-1-yuehaibing@huawei.com>
References: <20190724140739.59532-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-24 at 22:07 +0800, YueHaibing wrote:
> 'new_start' is used in is_hugepage_only_range(),
> which do nothing in some arch. gcc will warning:
> 
> mm/mmap.c: In function acct_stack_growth:
> mm/mmap.c:2311:16: warning: variable new_start set but not used [-Wunused-but-
> set-variable]

Nope. Convert them to inline instead.

> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  mm/mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index e2dbed3..56c2a92 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2308,7 +2308,7 @@ static int acct_stack_growth(struct vm_area_struct *vma,
>  			     unsigned long size, unsigned long grow)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
> -	unsigned long new_start;
> +	unsigned long __maybe_unused new_start;
>  
>  	/* address space limit tests */
>  	if (!may_expand_vm(mm, vma->vm_flags, grow))
