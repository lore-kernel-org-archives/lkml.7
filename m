Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB0AC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 22:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3A620674
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 22:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555628352;
	bh=GJUGMmSU6m4TkJBcxkyc5JCmEDVChhroBIwaxkfxeQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=X2miVdqvQVTc7gZ0/UxiJ4uTq38zNGR7+rVQoOMtx7XwqW28wrFAf+XtMJSoOjOI/
	 lgbbDjH5NOMEJwNfWzfciZ75Rd1JoTQcBz+ZI3mXIi9DD83s/WGMaRTrSSZhA8JREW
	 j/pG1qv9725BWY4wbBw2ct9S9J3C8utYlyGsrI3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfDRW7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 18:59:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35300 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfDRW7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 18:59:10 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 689491A12;
        Thu, 18 Apr 2019 22:50:20 +0000 (UTC)
Date:   Thu, 18 Apr 2019 15:50:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     jannh@google.com, reiserfs-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reiserfs: Force type conversion in xattr_hash
Message-Id: <20190418155019.ab5189e4e317df2b36861012@linux-foundation.org>
In-Reply-To: <20190417115200.GA10168@bharath12345-Inspiron-5559>
References: <20190417115200.GA10168@bharath12345-Inspiron-5559>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 17:22:00 +0530 Bharath Vedartham <linux.bhar@gmail.com> wrote:

> This patch fixes the sparse warning:
> 
> fs/reiserfs//xattr.c:453:28: warning: incorrect type in return
> expression (different base types)
> fs/reiserfs//xattr.c:453:28:    expected unsigned int
> fs/reiserfs//xattr.c:453:28:    got restricted __wsum
> fs/reiserfs//xattr.c:453:28: warning: incorrect type in return
> expression (different base types)
> fs/reiserfs//xattr.c:453:28:    expected unsigned int
> fs/reiserfs//xattr.c:453:28:    got restricted __wsum
> 
> csum_partial returns restricted integer __wsum whereas xattr_hash
> expects a return type of __u32.
> 
> ...
>
> --- a/fs/reiserfs/xattr.c
> +++ b/fs/reiserfs/xattr.c
> @@ -450,7 +450,7 @@ static struct page *reiserfs_get_page(struct inode *dir, size_t n)
>  
>  static inline __u32 xattr_hash(const char *msg, int len)
>  {
> -	return csum_partial(msg, len, 0);
> +	return (__force __u32)csum_partial(msg, len, 0);
>  }
>  
>  int reiserfs_commit_write(struct file *f, struct page *page,

hm.  Conversion from int to __u32 should be OK - why is sparse being so
picky here?

Why is the __force needed, btw?
