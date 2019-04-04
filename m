Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562D7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF81217D4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554410354;
	bh=rTs5v1L17kQH/iEWdJ4/swpmSDYtyjqb2Nkp1p5ObKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B5HMjs2cZIOglSRD+X2Lxr92LC0PtgxjI+LrqwYjCF/+Caid+e/cA6FFZX0Y9vITE
	 TyEPNhQskXfrbgtgJamO/N4y3zFlMQ70MXTJyPYEsCLWOz3g0Q+hlly29IHEX8tVAx
	 y8RyhEjSHIq2b17Dpkrubz2Xbs/6I3GPDd43UXVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbfDDUjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:39:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729400AbfDDUjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:39:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D03C20663;
        Thu,  4 Apr 2019 20:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554410351;
        bh=rTs5v1L17kQH/iEWdJ4/swpmSDYtyjqb2Nkp1p5ObKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zE+P+rp/ETe04cjbzKS31qh05RU0YiFMuceQpAypUXPuG56ErfkdzSGbkiwYhoc52
         51FhLRO18scbDATcAwyf0aygupANWtpfUMp4YpismLHpQpqXARBGzXYik5pe2cgAj9
         fXYziRQN6as0sgtvv6/9W8/5byxDGZAAiqu8yUTs=
Date:   Thu, 4 Apr 2019 22:35:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Okash Khawaja <okash.khawaja@gmail.com>
Cc:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Gregory Nowak <greg@gregn.net>, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, Kirk Reiser <kirk@reisers.ca>,
        Peter Hurley <peter@hurleysoftware.com>,
        Jiri Slaby <jslaby@suse.com>, speakup@linux-speakup.org,
        John Covici <covici@ccs.covici.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Chris Brannon <chris@the-brannons.com>
Subject: Re: [PATCH 1/2] vt: selection: allow functions to be called from
 inside kernel
Message-ID: <20190404203549.GA9319@kroah.com>
References: <20190404194530.1170-1-okash.khawaja@gmail.com>
 <20190404194530.1170-2-okash.khawaja@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404194530.1170-2-okash.khawaja@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 08:45:29PM +0100, Okash Khawaja wrote:
> diff --git a/include/linux/selection.h b/include/linux/selection.h
> index a8f5b97b216f..171d77dfc825 100644
> --- a/include/linux/selection.h
> +++ b/include/linux/selection.h
> @@ -11,13 +11,12 @@
>  #include <linux/tiocl.h>
>  #include <linux/vt_buffer.h>
>  
> -struct tty_struct;
> -

Nit, why remove these lines?

thanks,

greg k-h
