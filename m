Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95265C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69AE122CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567011629;
	bh=ZARfaWUbuLbc3qSHosG2JV2Bb68PSz+bxh+2v5STyvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zNqiwtkRswg8KLyXSEMBcTIlLE0Ycgq3ifPINKUb+4wNaYOn1GwQ6UmrfobnTlVUc
	 HwPNCXgf3BDBdVaecqGYUy8kbacQP1l5upBmfZBnK/yosUZ6v9I6sWa8k0j1xAVy07
	 kPz6RK3kFQx+i6nBiMl+mJiOQu19vepgQCopYKmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfH1RA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:00:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfH1RA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:00:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B558722CF5;
        Wed, 28 Aug 2019 17:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567011627;
        bh=ZARfaWUbuLbc3qSHosG2JV2Bb68PSz+bxh+2v5STyvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NKOLjK5d8Reg2OCHJ7+BY+Soq9RzU45DRx1kt7HEjJh1xMM3xK6nV+vW2+x/phyrW
         ycEkdZZ83X7aBD85usZseHdXFSXPtrdcly0vuTdCJsbPN8oc7gPUjYYl3ykxZiPR2K
         PHxqq0tuLFk6VS7lIxXJP6/HVcchTp8df/yM7jv0=
Date:   Wed, 28 Aug 2019 19:00:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     devel@driverdev.osuosl.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20190828170022.GA7873@kroah.com>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190828160817.6250-1-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 06:08:17PM +0200, Greg Kroah-Hartman wrote:
> From: Valdis Klētnieks <valdis.kletnieks@vt.edu>
> 
> The exfat code needs a lot of work to get it into "real" shape for
> the fs/ part of the kernel, so put it into drivers/staging/ for now so
> that it can be worked on by everyone in the community.
> 
> The full specification of the filesystem can be found at:
>   https://docs.microsoft.com/en-us/windows/win32/fileio/exfat-specification
> 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  MAINTAINERS                          |    5 +
>  drivers/staging/Kconfig              |    2 +
>  drivers/staging/Makefile             |    1 +
>  drivers/staging/exfat/Kconfig        |   39 +
>  drivers/staging/exfat/Makefile       |   10 +
>  drivers/staging/exfat/TODO           |   12 +
>  drivers/staging/exfat/exfat.h        |  973 ++++++
>  drivers/staging/exfat/exfat_blkdev.c |  136 +
>  drivers/staging/exfat/exfat_cache.c  |  722 +++++
>  drivers/staging/exfat/exfat_core.c   | 3704 +++++++++++++++++++++++
>  drivers/staging/exfat/exfat_nls.c    |  404 +++
>  drivers/staging/exfat/exfat_super.c  | 4137 ++++++++++++++++++++++++++
>  drivers/staging/exfat/exfat_upcase.c |  740 +++++
>  13 files changed, 10885 insertions(+)
>  create mode 100644 drivers/staging/exfat/Kconfig
>  create mode 100644 drivers/staging/exfat/Makefile
>  create mode 100644 drivers/staging/exfat/TODO
>  create mode 100644 drivers/staging/exfat/exfat.h
>  create mode 100644 drivers/staging/exfat/exfat_blkdev.c
>  create mode 100644 drivers/staging/exfat/exfat_cache.c
>  create mode 100644 drivers/staging/exfat/exfat_core.c
>  create mode 100644 drivers/staging/exfat/exfat_nls.c
>  create mode 100644 drivers/staging/exfat/exfat_super.c
>  create mode 100644 drivers/staging/exfat/exfat_upcase.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e3242687cd19..a484b36e5117 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6097,6 +6097,11 @@ F:	include/trace/events/mdio.h
>  F:	include/uapi/linux/mdio.h
>  F:	include/uapi/linux/mii.h
>  
> +EXFAT FILE SYSTEM
> +M:	Valdis Kletnieks <valdis.kletnieks@vt.edu>
> +S:	Maintained
> +F:	fs/exfat/

Oops, I messed this line up.  I moved this to drivers/staging/ and I
forgot to update this line.  I'll do it in a follow-on patch.

thanks,

greg k-h
