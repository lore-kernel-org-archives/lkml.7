Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028C0C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8C22184E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558683956;
	bh=ObrvGpPLiHEvyPviS1L6MjtoBDnP+praLC5ukqMFU0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U6bBPwUc6v6ocmm2NKQ+Px5ZffZolFFuQx06G47ccRMDIq5a6L0Iuu9ev8vGrGc0u
	 DIiecEvQxLZB/+pljeTa+zjMzmzoLu4eXhH3D8Sb9+42RwWvvDdDry5k7RsPzQKDTe
	 fkd0RxRqXMyU0kJCwIopkgcarKXq8qXOBd4/23JI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389122AbfEXHpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 03:45:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388911AbfEXHpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 03:45:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2B0D217F9;
        Fri, 24 May 2019 07:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558683954;
        bh=ObrvGpPLiHEvyPviS1L6MjtoBDnP+praLC5ukqMFU0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EUN9fDVX77IBJUkCIzY9sNbVP5n/uaDGltIbrw7RwF72ifujn+NUZ3fD5lGSp2vF3
         ES8/uxnuMieLrmdE953JA4Aznd29rvq5GXNIemu2kQtvCEi6Rilck3U7Ab+62zbQ+W
         6H23cbY3lGz9eJcBK+CbpAf6HrBR8eMoOGFxBtfs=
Date:   Fri, 24 May 2019 09:45:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] usb: mtu3: fix up undefined reference to
 usb_debug_root
Message-ID: <20190524074552.GA1080@kroah.com>
References: <ee71197a681165aa72cb73c7f6cb402953351805.1558678075.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee71197a681165aa72cb73c7f6cb402953351805.1558678075.git.chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 02:11:33PM +0800, Chunfeng Yun wrote:
> When CONFIG_USB is not set, and CONFIG_USB_GADGET is set,
> there is an issue:
> 
> ld:
> drivers/usb/mtu3/mtu3_debugfs.o: in function 'ssusb_debugfs_create_root':
> mtu3_debugfs.c:(.text+0xba3): undefined reference to 'usb_debug_root'
> 
> usb_debug_root is only built when CONFIG_USB is enabled, so here drop it
> and use NULL instead.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  drivers/usb/mtu3/mtu3_debugfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Why resend?

> diff --git a/drivers/usb/mtu3/mtu3_debugfs.c b/drivers/usb/mtu3/mtu3_debugfs.c
> index 62c57ddc554e..b7c86ccd50b4 100644
> --- a/drivers/usb/mtu3/mtu3_debugfs.c
> +++ b/drivers/usb/mtu3/mtu3_debugfs.c
> @@ -528,8 +528,7 @@ void ssusb_dr_debugfs_init(struct ssusb_mtk *ssusb)
>  
>  void ssusb_debugfs_create_root(struct ssusb_mtk *ssusb)
>  {
> -	ssusb->dbgfs_root =
> -		debugfs_create_dir(dev_name(ssusb->dev), usb_debug_root);
> +	ssusb->dbgfs_root = debugfs_create_dir(dev_name(ssusb->dev), NULL);

This moves the directory to a new location no matter what the
configuration is. What's wrong with where it is today?  And shoudn't we
create the usb root directory if only gadget is enabled?

thanks,

greg k-h
