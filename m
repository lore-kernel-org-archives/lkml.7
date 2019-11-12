Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9401C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71543206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573590836;
	bh=Mnvf0QMRCj4tI0M1jvvA/Cd6q+zg1D2YAk4ccvhV8aQ=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=jI/As8GtlSb+75XcR+8heUFt3Njnk20waKgMU3kRMOs6TJ8vdmKkjXvVqzZQDzXQI
	 AwAuylaa/gBxmwRoppUipS4REHsvV5hSMiAMH8cKI15cFgLO23ZwSnI6AQDBvIwt6l
	 6kp0Bg/fIyekaasuPaqd1JRNORooqodYVQLGCCsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfKLUdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 15:33:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:46406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbfKLUdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 15:33:55 -0500
Received: from localhost (unknown [8.46.76.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43D24206A3;
        Tue, 12 Nov 2019 20:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573590832;
        bh=Mnvf0QMRCj4tI0M1jvvA/Cd6q+zg1D2YAk4ccvhV8aQ=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=RQzt25HxE4MPL9H3xgO0Hu7OIaUSat5u0D+HttH0Y3AqB+W2OS+1h3ieDUKhQFeC6
         tqu9JeoGJ29UjtkkjWFu7WY3BrTov29jq6zd4Ckf4wvqRhQyW51lpfIzlhppixl28x
         j+dc4iv0RB7wxAfv7IbOMh2quB9XMD4C3HIiz1Pw=
Date:   Tue, 12 Nov 2019 21:33:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [PATCH 7/9] staging: rtl8723bs: Fix incorrect type in argument
 warnings
Message-ID: <20191112203343.GA1833645@kroah.com>
References: <cover.1573577309.git.jarias.linux@gmail.com>
 <637726782ce6c6ed3d68b5e595481857916bbc56.1573577309.git.jarias.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <637726782ce6c6ed3d68b5e595481857916bbc56.1573577309.git.jarias.linux@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 11:55:27AM -0500, Javier F. Arias wrote:
> Fix incorrect type in declarations to solve the 'incorrect
> type in argument 3' warnings in the rtw_get_ie function calls.
> Issue found by Sparse.
> 
> Signed-off-by: Javier F. Arias <jarias.linux@gmail.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> index db6528a01229..bb63295e8d4e 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> @@ -83,7 +83,7 @@ static char *translate_scan(struct adapter *padapter,
>  {
>  	struct iw_event iwe;
>  	u16 cap;
> -	u32 ht_ielen = 0;
> +	sint ht_ielen = 0;

sint?  Ick, try fixing up the function call itself please.

thanks,

greg k-h
