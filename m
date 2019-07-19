Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D36C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 17:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF202184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 17:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563555737;
	bh=gaugX9ZhIKdDiADtQa4ubEUvcd0E44zHZspxew0b+eQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WdhHhjVbSg+3XbQaZ0C10fJp7pWpuv611ShbD+oS8K04XyZF/HDOuI1vMpjV2MeUV
	 mSMTRImF7kmHNJCp4kfxYsmP2UFS6m/93KkIWJBs1YkxxfKdRr6OY89HQ3mM0vuQHK
	 VKWsVKyW5ONf2+QsG/Ncm8d7r/RysKXkh7GlS7JQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbfGSRCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 13:02:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728476AbfGSRCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 13:02:15 -0400
Received: from localhost (unknown [84.241.199.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1A262184E;
        Fri, 19 Jul 2019 17:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563555735;
        bh=gaugX9ZhIKdDiADtQa4ubEUvcd0E44zHZspxew0b+eQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JkMss7z2IaCuUsVxputAzUIM2ymm12lW7m08ofokuK+NdePzrko3aERRnpx/Lo+Ly
         z2eOvX9EzbP6flCTJKaIFurLcBwbhTeqFDpXZYYmiLuRg0vxT90A7W7iJmZxDHkP0N
         2jo7BBtF5tAraPoai88w9WzyprAZ/Luf7LMVxCho=
Date:   Fri, 19 Jul 2019 19:03:31 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Gen Zhang <blackgod016574@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH AUTOSEL 5.2 014/171] consolemap: Fix a memory leaking bug
 in drivers/tty/vt/consolemap.c
Message-ID: <20190719100331.GA11778@kroah.com>
References: <20190719035643.14300-1-sashal@kernel.org>
 <20190719035643.14300-14-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719035643.14300-14-sashal@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 11:54:05PM -0400, Sasha Levin wrote:
> From: Gen Zhang <blackgod016574@gmail.com>
> 
> [ Upstream commit 84ecc2f6eb1cb12e6d44818f94fa49b50f06e6ac ]
> 
> In function con_insert_unipair(), when allocation for p2 and p1[n]
> fails, ENOMEM is returned, but previously allocated p1 is not freed,
> remains as leaking memory. Thus we should free p1 as well when this
> allocation fails.
> 
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/tty/vt/consolemap.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

No, please do not take this patch, it was reverted in commit
15b3cd8ef46a ("Revert "consolemap: Fix a memory leaking bug in
drivers/tty/vt/consolemap.c"") because it was broken.

Please drop from all of the autosel queues.

thanks,

greg k-h
