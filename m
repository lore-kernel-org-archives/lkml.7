Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8480FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F38520848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553563661;
	bh=7RCGyryO7eBho+Imp5KMIH6jfwZHXMtR3f3r7R4xfKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hAcVuOes/RJk1NJCWX1M4I4PJMJV33wI4TrfQgEEmsiMWKevBaBUruwWWODEJW5Xm
	 wWiTJCgRDKQtXLtbJzQPtdOeocloqgFyMNW2QGo8No4FXPtyqt6p2GEIgwx+NQehrt
	 gS9DPuuNpGU8PuE8Qh+Bc50LDYetHMEymYrV654s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbfCZB1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:27:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbfCZB1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 21:27:38 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 028102075D;
        Tue, 26 Mar 2019 01:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553563658;
        bh=7RCGyryO7eBho+Imp5KMIH6jfwZHXMtR3f3r7R4xfKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eH6PbxSFn8g2ZnbTkS54z0eFICM7KyO+pXK5NUge88UA1adAO/Dx+fSI5m+sKvH+F
         V95wmJLbv1Tgjy0xJpAk0v2lTm4B2z51ygUDop+iv+PRaxZ7iBHYYNzix2vO7Bq/jt
         dg3DGKbb4CU7kwOvkVlsBeIF7CtW9Y6y0fnvHumw=
Date:   Tue, 26 Mar 2019 10:27:31 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Jiong Wu <lohengrin1024@gmail.com>,
        Martin Hicks <mort@bork.org>,
        Ziyuan Xu <xzy.xu@rock-chips.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BACKPORT 4.4.y 17/25] mmc: core: don't try to switch block size
 for dual rate mode
Message-ID: <20190326012731.GA30723@kroah.com>
References: <20190322154425.3852517-1-arnd@arndb.de>
 <20190322154425.3852517-18-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322154425.3852517-18-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 04:44:08PM +0100, Arnd Bergmann wrote:
> From: Ziyuan Xu <xzy.xu@rock-chips.com>
> 
> Per spec, block size should always be 512 bytes for dual rate mode,
> so any attempts to switch the block size under dual rate mode should
> be neglected.
> 
> Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> (cherry picked from commit 1712c9373f98ae8ed41599a8d7841a6fba29c264)
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mmc/core/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index df074f8c7cb7..3e17268b9994 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2406,7 +2406,8 @@ int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen)
>  {
>  	struct mmc_command cmd = {0};
>  
> -	if (mmc_card_blockaddr(card) || mmc_card_ddr52(card))
> +	if (mmc_card_blockaddr(card) || mmc_card_ddr52(card) ||
> +	    mmc_card_hs400(card) || mmc_card_hs400es(card))

This breaks the build, there is no mmc_card_hs400es() call in 4.4.y.

How did this build for you?

greg k-h
