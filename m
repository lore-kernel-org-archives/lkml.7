Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD973C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE61420857
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555411128;
	bh=08pqCf0mblmvYaCZiDBeQHcOa6u4+HtIRC440BSetf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jbCYFvknNu+hkLodPzhMXobIHP1JdV5z8cEka7bvIGajsAzeecbtVdM400ZomJIe1
	 nV2aj8gfK4h2Evih8LKgLLPNxZn0EzQ1u9ExCUzw5D3uLPfxgsdCKb1g/RXtRv4HWs
	 Dg7Wg8wSjl7oInSAS0tTQ+0WqeFcrHhMLbyWPtZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbfDPKir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:38:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbfDPKiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:38:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51C0E206BA;
        Tue, 16 Apr 2019 10:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555411125;
        bh=08pqCf0mblmvYaCZiDBeQHcOa6u4+HtIRC440BSetf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vrje8Sp9BtChWl4iBvqwAlufYFCj4JWJszjQDcaUqgY9swnCZ3Fa3A3EUG6GETvZJ
         /FUf9k/d8TNnqszjZ+xMbaQnnHU/7Rld2lQxaUidd/ibnf3dWiiv9canJ5YehWo5LY
         0Q4bq/4K7rCfEpupE5U/ZR538pRtp1nQ34Ua6yc8=
Date:   Tue, 16 Apr 2019 12:12:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [v2 PATCH 1/6] usb: xhci-mtk: get optional clock by
 devm_clk_get_optional()
Message-ID: <20190416101258.GA26091@kroah.com>
References: <bc6cdc2dce698dddbd692ba100fbf08c15c7b023.1554877692.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc6cdc2dce698dddbd692ba100fbf08c15c7b023.1554877692.git.chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 02:47:24PM +0800, Chunfeng Yun wrote:
> Use devm_clk_get_optional() to get optional clock
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: no changes
> ---
>  drivers/usb/host/xhci-mtk.c | 19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> index 60987c787e44..026fe18972d3 100644
> --- a/drivers/usb/host/xhci-mtk.c
> +++ b/drivers/usb/host/xhci-mtk.c
> @@ -206,19 +206,6 @@ static int xhci_mtk_ssusb_config(struct xhci_hcd_mtk *mtk)
>  	return xhci_mtk_host_enable(mtk);
>  }
>  
> -/* ignore the error if the clock does not exist */
> -static struct clk *optional_clk_get(struct device *dev, const char *id)
> -{
> -	struct clk *opt_clk;
> -
> -	opt_clk = devm_clk_get(dev, id);
> -	/* ignore error number except EPROBE_DEFER */
> -	if (IS_ERR(opt_clk) && (PTR_ERR(opt_clk) != -EPROBE_DEFER))

Are you sure about this?

devm_clk_get_optional() does not check for -EPROBE_DEFER, so you just
changed the functionality of this code.  Is that ok?  If so, please call
it out explicitly in your changelog comment when you resend this.

thanks,

greg k-h
