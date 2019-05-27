Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39CBC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B786B2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558937260;
	bh=mw+L/lLqY44mNdz/h0RDLRWC8v4KYOi5aOl1+CIT9wA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vX7akzKwxIw5tv5fFv/aVuwW6eAkSevRGdIZjO2EVTkSKszTtgKmuwQGnGR1XVv8J
	 JhfTycncibf0Z2DMDT/3en24W/IAU88qwF17Y8/o0KgvUc4UqRnj93hZ2TL05u64qC
	 imH0zrEhYIEpDp65mLo/KQujklnzquD+ulUn9UXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfE0GHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 02:07:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfE0GHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:07:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75DBE204EC;
        Mon, 27 May 2019 06:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558937220;
        bh=mw+L/lLqY44mNdz/h0RDLRWC8v4KYOi5aOl1+CIT9wA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RRp7RK35mra3nwfLeSnANm7jg9RuE5Xik4SIoiYMi2PYUvCZu2b5m/t7BU7kliO6J
         1Vf3DetAjGyPp8/lPrqpTmOqANVXTe8co9sTQ3LnD4ptx1nAxwPAFhWJ4B3x7COQQV
         cR2NmSD9PKbsSn0OuiImgyLxb8g+55SRD5uDhAwM=
Date:   Mon, 27 May 2019 08:06:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3 1/2] drivers: base: cacheinfo: Add variable to record
 max cache line size
Message-ID: <20190527060656.GA7997@kroah.com>
References: <1558922768-29155-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558922768-29155-1-git-send-email-zhangshaokun@hisilicon.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 10:06:07AM +0800, Shaokun Zhang wrote:
> Add coherency_max_size variable to record the maximum cache line size
> for different cache levels. We will synchronize it with CTR_EL0.CWG
> reporting in cache_line_size() for arm64.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
> ChangeLog since v2:
>   -- Rebase to 5.2-rc2
>   -- Export cache_line_size for I/O driver
> ChangeLog since v1:
>   -- Move coherency_max_size to drivers/base/cacheinfo.c
>   -- Address Catalin's comments
>   Link: https://www.spinics.net/lists/arm-kernel/msg723615.html
> 
>  drivers/base/cacheinfo.c  | 5 +++++
>  include/linux/cacheinfo.h | 2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index a7359535caf5..8827c60f51e2 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -213,6 +213,8 @@ int __weak cache_setup_acpi(unsigned int cpu)
>  	return -ENOTSUPP;
>  }
>  
> +unsigned int coherency_max_size;

Why are you creating a global variable?

Where are the other patches in this series?

thanks,

greg k-h
