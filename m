Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1489BCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7DB220862
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572598946;
	bh=03ykDqOkaZ+vfMFgBSEbYV3PoG8YuXm3FEcL5G+ws2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wrOUxl5MzfJXeFnaFQtfbyMOk22OokuDKEk9XCqGgyqCK+myUewoxG4pOCHmLYgxF
	 KOCaKrrldnO9pjYKj26DVx7iH9fmzzdmN/nOAUP0qL5fk0bD1tPtm+bhtJs89O+eMN
	 NxTfRUKB06WzBOthx2Z8RkaI6r8lo7k8x0/YJnBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfKAJC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 05:02:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbfKAJCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 05:02:25 -0400
Received: from localhost (unknown [84.241.195.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC5402080F;
        Fri,  1 Nov 2019 09:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572598944;
        bh=03ykDqOkaZ+vfMFgBSEbYV3PoG8YuXm3FEcL5G+ws2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eEu30SGt42zSHoc5LlbGoOeueGeW6yn0Qevu53KZYtf2dIR9IyWJRdto8azhTnLLm
         6gO3bZr94b44n6IGTAVS/RmtJTvo9eAogiTW5naegoh007djmcOALGxUqyTSZuQ7GU
         jNrB4ZY3g8V4ej2K+GtEc1otaCuzw3cf+nx6Z35A=
Date:   Fri, 1 Nov 2019 10:02:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] usb: common: change usb_debug_root as static variable
Message-ID: <20191101090221.GC2671695@kroah.com>
References: <1572575349-5596-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572575349-5596-1-git-send-email-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 10:29:09AM +0800, Chunfeng Yun wrote:
> Try to avoid using extern global variable, and provide two
> functions for the usage cases

That is 3 different things all in one patch, not generally considered a
good thing at all.

Also, who is going to use these new functions?  Why are they needed?

> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> NOTE:
>     Prepared but not send out patches for drivers using usb_debug_root,
> because I'm not sure whether this patch is needed, and many drivers
> will be modified.
> ---
>  drivers/usb/common/common.c | 16 ++++++++++++++--
>  include/linux/usb.h         |  5 ++++-
>  2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
> index 1433260d99b4..639ee6d243a2 100644
> --- a/drivers/usb/common/common.c
> +++ b/drivers/usb/common/common.c
> @@ -293,8 +293,20 @@ struct device *usb_of_get_companion_dev(struct device *dev)
>  EXPORT_SYMBOL_GPL(usb_of_get_companion_dev);
>  #endif
>  
> -struct dentry *usb_debug_root;
> -EXPORT_SYMBOL_GPL(usb_debug_root);
> +static struct dentry *usb_debug_root;

Doesn't this break things as-is?  You can't do that in a single patch
either :(

> +
> +struct dentry *usb_debugfs_create_dir(const char *name)
> +{
> +	return debugfs_create_dir(name, usb_debug_root);
> +}
> +EXPORT_SYMBOL_GPL(usb_debugfs_create_dir);
> +
> +struct dentry *usb_debugfs_create_file(const char *name, umode_t mode,
> +			void *data, const struct file_operations *fops)
> +{
> +	return debugfs_create_file(name, mode, usb_debug_root, data, fops);

I doubt many people want to create a file in the usb "root" debugfs
directory, right?  They _should_ be just creating a new subdirectory in
there instead.

thanks,

greg k-h
