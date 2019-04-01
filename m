Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F463C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046022133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554118845;
	bh=LDLVMlUNKStBigWemtht62j/hMd0pxWIk3S+zjMBFiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DGoRPA99Pt0ujHp6+cXjTGQYdAJjhr1jtzswOTgWrWp1Rj1fj4ZteNi+Gl2eWxqBw
	 dUU5DfD6LwTY+6sj0fXqUvtgD98suIBqGr7ejhoY5XHhpd3VLe2L8JoutSUa4Ay4iO
	 n0mnhN2rRbCvbgIVz0sog6fvpsz5IlfFbIiTCbQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfDALko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:40:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfDALkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:40:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2C0B20880;
        Mon,  1 Apr 2019 11:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554118843;
        bh=LDLVMlUNKStBigWemtht62j/hMd0pxWIk3S+zjMBFiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VMf7ddR/57qNwcZ8gPViQ8TrKrSWtjDFsUhfNALRNSoLtPjV4RAC7C9rhRYwe8Jvc
         XgBV8/3F7BhlpVBSLRFDRgsz3igJc1axFVTp7FZgKm4H0bUlnsr4rsSx4lT5XMMtHX
         B37TcqroFP7bXCbYyRJroQ2JseC3axNDJucV40wM=
Date:   Mon, 1 Apr 2019 13:40:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH for-4.19 1/2] staging: erofs: fix error handling when
 failed to read compresssed data
Message-ID: <20190401114040.GC8156@kroah.com>
References: <20190401065309.68109-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401065309.68109-1-gaoxiang25@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 02:53:08PM +0800, Gao Xiang wrote:
> commit b6391ac73400eff38377a4a7364bd3df5efb5178 upstream.
> 
> Complete read error handling paths for all three kinds of
> compressed pages:
> 
>  1) For cache-managed pages, PG_uptodate will be checked since
>     read_endio will unlock and SetPageUptodate for these pages;
> 
>  2) For inplaced pages, read_endio cannot SetPageUptodate directly
>     since it should be used to mark the final decompressed data,
>     PG_error will be set with page locked for IO error instead;
> 
>  3) For staging pages, PG_error is used, which is similar to
>     what we do for inplaced pages.
> 
> Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
> Cc: <stable@vger.kernel.org> # 4.19+
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
> This series resolves the following conflicts:
> FAILED: patch "[PATCH] staging: erofs: fix error handling when failed to read" failed to apply to 4.19-stable tree
> FAILED: patch "[PATCH] staging: erofs: keep corrupted fs from crashing kernel in" failed to apply to 4.19-stable tree

Thanks for both of these, now queued up.

greg k-h
