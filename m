Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CD9C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74E321848
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566827503;
	bh=wDfyXIBnwA8sKvOUkduyKciiIMqNec9f7nzYXncOUMc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=lX2ehzILo9wArLcXtJ3Newfjmg4cBFXhim5RgdQCqc1S4gjMmHlOyzLQGy93cCywv
	 Rp0g7/5TaIxv7giHtyMU35jfkEU+rqDDiS99NKAEXfFPO3Ogxl/hJkwlpZ8y2tmwTd
	 ndXvT/y6WLaB9Le7QHrLy8/86oYWy5m8aeDS/3eo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732144AbfHZNvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 09:51:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731873AbfHZNvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 09:51:42 -0400
Received: from [192.168.0.101] (unknown [180.111.132.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4851F217F5;
        Mon, 26 Aug 2019 13:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566827501;
        bh=wDfyXIBnwA8sKvOUkduyKciiIMqNec9f7nzYXncOUMc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DJGGT7qLzAsMVHincMsuYuzSugIWRNFgTdXCKVbUE/dY2fN5cOnVCEwS3orLYNGEC
         nNiGlrwQY9GsaWDqZy0cMZEH8H9Cyz/3quzgw7+qrLd0ACjLZYzCsaBBx2kUmeEL/H
         Jh5Ez4MiSnWq6+EJVXHlFucOeaeYohbr4xMhJd1E=
Subject: Re: [PATCH RESEND] erofs: fix compile warnings when moving out
 include/trace/events/erofs.h
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Miao Xie <miaoxie@huawei.com>, weidu.du@huawei.com,
        Fang Wei <fangwei1@huawei.com>
References: <20190826132234.96939-1-gaoxiang25@huawei.com>
 <20190826132653.100731-1-gaoxiang25@huawei.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <50c3453c-a1be-3e79-da21-4d4c84d49fec@kernel.org>
Date:   Mon, 26 Aug 2019 21:51:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190826132653.100731-1-gaoxiang25@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-8-26 21:26, Gao Xiang wrote:
> As Stephon reported [1], many compile warnings are raised when
> moving out include/trace/events/erofs.h:
> 
> In file included from include/trace/events/erofs.h:8,
>                  from <command-line>:
> include/trace/events/erofs.h:28:37: warning: 'struct dentry' declared inside parameter list will not be visible outside of this definition or declaration
>   TP_PROTO(struct inode *dir, struct dentry *dentry, unsigned int flags),
>                                      ^~~~~~
> include/linux/tracepoint.h:233:34: note: in definition of macro '__DECLARE_TRACE'
>   static inline void trace_##name(proto)    \
>                                   ^~~~~
> include/linux/tracepoint.h:396:24: note: in expansion of macro 'PARAMS'
>   __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
>                         ^~~~~~
> include/linux/tracepoint.h:532:2: note: in expansion of macro 'DECLARE_TRACE'
>   DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
>   ^~~~~~~~~~~~~
> include/linux/tracepoint.h:532:22: note: in expansion of macro 'PARAMS'
>   DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
>                       ^~~~~~
> include/trace/events/erofs.h:26:1: note: in expansion of macro 'TRACE_EVENT'
>  TRACE_EVENT(erofs_lookup,
>  ^~~~~~~~~~~
> include/trace/events/erofs.h:28:2: note: in expansion of macro 'TP_PROTO'
>   TP_PROTO(struct inode *dir, struct dentry *dentry, unsigned int flags),
>   ^~~~~~~~
> 
> That makes me very confused since most original EROFS tracepoint code
> was taken from f2fs, and finally I found
> 
> commit 43c78d88036e ("kbuild: compile-test kernel headers to ensure they are self-contained")
> 
> It seems these warnings are generated from KERNEL_HEADER_TEST feature and
> ext4/f2fs tracepoint files were in blacklist.

For f2fs.h, it will be only used by f2fs module, I guess it's okay to let it
stay in blacklist...

> 
> Anyway, let's fix these issues for KERNEL_HEADER_TEST feature instead
> of adding to blacklist...
> 
> [1] https://lore.kernel.org/lkml/20190826162432.11100665@canb.auug.org.au/
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
