Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED8BC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD476206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556221791;
	bh=5+UzOGZVxGDsNphbonQceRHhUCczCcg9VVkdUolF98k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jMQ/4OwwjiMQCbWeUh42mBvZpihTXDVOczkRraZJqYUExiFjAJlXO1vyX15L9zNht
	 8tn2h/MuM/eiBVetqSdRJx6DEi6cxp2gef1gOq6vwy6Yp/veornv5+XZvCJwsWyaD2
	 6qjaXfIbQyZfyUNOfGTDTWjQ8LxkcdT9mk7/qznQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbfDYTtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:49:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfDYTtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:49:49 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6711206BF;
        Thu, 25 Apr 2019 19:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556221789;
        bh=5+UzOGZVxGDsNphbonQceRHhUCczCcg9VVkdUolF98k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OZLq+uyxlePppjoXloRfx0bLLnG0lL45KuktDHBi/j41RbYZGXDBCVz2S16U2BhzE
         j2vCSvFhMFWcWQ4ASX4bRjY0KL8q0GwBaqSRYsw6OeWgNksV0apT2fdoTSPYtDR3d1
         CW9RjecOFoBarLwW8X9S2jF5fF/j5cSdR3eXksOo=
Date:   Thu, 25 Apr 2019 21:49:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chengguang Xu <cgxu519@gmx.com>
Cc:     dan.carpenter@oracle.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] chardev: set variable ret to -EBUSY before checking
 minor range overlap
Message-ID: <20190425194946.GA15196@kroah.com>
References: <20190405135306.10188-1-cgxu519@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405135306.10188-1-cgxu519@gmx.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 09:53:06PM +0800, Chengguang Xu wrote:
> When allocating dynamic major, the minor range overlap check
> in __register_chrdev_region() will not fail, so actually
> there is no real case to passing non negative error code to
> caller. However, set variable ret to -EBUSY before chekcking
> minor range overlap will avoid false-positive warning from
> code analyzing tool(like Smatch) and also make the code more
> easy to understand.
> 
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> ---
>  fs/char_dev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

What tree was this patch made against?  I can't seem to apply it
anywhere :(

Please fix up and resend.

thanks,

greg k-h
