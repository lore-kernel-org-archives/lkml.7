Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FEDC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 13:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD93A2070D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 13:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564319695;
	bh=RGYkvdDpcR0HF47EADWqXAcQtb7E6WLhRPLvUsHe4n4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=McQX4MawV32rUKpQICCSnGv04dzFnRHjUgnzl2uswIOXfOzW+1tZghfRLuDr1K9cP
	 XURhaBlEGNevjTBcrPXiw9BgGlRA0hS3ZmZggXOi8+DR6u42lbwOqe7lkeZlstzQOl
	 o0oC5UjRwGbWr5woCb467v6ENFK4HBJiFM26qhpc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfG1NO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 09:14:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfG1NO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 09:14:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45D7E2070D;
        Sun, 28 Jul 2019 13:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564319667;
        bh=RGYkvdDpcR0HF47EADWqXAcQtb7E6WLhRPLvUsHe4n4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aMmHqOsXYR6liNxAUgSV6OvhQd06VZTvXyxUKKIZCz/trt/RM0kYuxxSatHZXUztO
         mD1svpDCz1r+X5AeoIs0BOPRac3kTRqEpxXVEOJbW3U3jQ7mKo1V2ZzMFeAY5FeInH
         X48vjwpIDsfcbfL7UO14oEwwgSZnbfemAaJwI2L0=
Date:   Sun, 28 Jul 2019 15:14:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Subject: Re: [PATCH 9/9 v2] habanalabs: allow multiple processes to open FD
Message-ID: <20190728131424.GB5007@kroah.com>
References: <20190728124812.3952-1-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728124812.3952-1-oded.gabbay@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 03:48:12PM +0300, Oded Gabbay wrote:
> This patch removes the limitation of a single process that can open the
> device.
> 
> Now, there is no limitation on the number of processes that can open the
> device and have a valid FD.
> 
> However, only a single process can perform compute operations. This is
> enforced by allowing only a single process to have a compute context.
> 
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> ---
> Changes in v2:
> - Replace WARN with dev_crit

Looks good, thanks.  The other patches in the series looked fine at
first glance as well

greg k-h
