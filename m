Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C41BC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDBA20717
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfE1ILy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 04:11:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:17847 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfE1ILy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:11:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 01:11:53 -0700
X-ExtLoop1: 1
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga001.fm.intel.com with ESMTP; 28 May 2019 01:11:51 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH] usb: create usb_debug_root for gadget only
In-Reply-To: <cffd6d75f69e4d908c8f39b8a60ddae27d6b7c88.1559028752.git.chunfeng.yun@mediatek.com>
References: <cffd6d75f69e4d908c8f39b8a60ddae27d6b7c88.1559028752.git.chunfeng.yun@mediatek.com>
Date:   Tue, 28 May 2019 11:11:50 +0300
Message-ID: <87k1ebj8vt.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Chunfeng Yun <chunfeng.yun@mediatek.com> writes:
> diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> index 7fcb9f782931..88b3ee03a12d 100644
> --- a/drivers/usb/core/usb.c
> +++ b/drivers/usb/core/usb.c
> @@ -1190,7 +1190,7 @@ EXPORT_SYMBOL_GPL(usb_debug_root);
>  
>  static void usb_debugfs_init(void)
>  {
> -	usb_debug_root = debugfs_create_dir("usb", NULL);
> +	usb_debug_root = debugfs_create_dir(USB_DEBUG_ROOT_NAME, NULL);
>  	debugfs_create_file("devices", 0444, usb_debug_root, NULL,
>  			    &usbfs_devices_fops);
>  }

might be a better idea to move this to usb common. Then have a function
which can be called by both host and gadget to maybe create the
directory:

static struct dentry *usb_debug_root;

struct dentry *usb_debugfs_init(void)
{
	if (!usb_debug_root)
        	usb_debug_root = debugfs_create_dir("usb", NULL);

	return usb_debug_root;
}


Then usb core would be updated to something like:

static void usb_core_debugfs_init(void)
{
	struct dentry *root = usb_debugfs_init();

	debugfs_create_file("devices", 0444, root, NULL, &usbfs_devices_fops);
}

-- 
balbi
