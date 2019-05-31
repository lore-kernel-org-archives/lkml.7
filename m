Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFEEC46460
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 05:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8153F263BE
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 05:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfEaFo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 01:44:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:41385 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfEaFo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 01:44:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 22:44:58 -0700
X-ExtLoop1: 1
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga003.jf.intel.com with ESMTP; 30 May 2019 22:44:55 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH] usb: create usb_debug_root for gadget only
In-Reply-To: <1559201499.8487.40.camel@mhfsdcap03>
References: <cffd6d75f69e4d908c8f39b8a60ddae27d6b7c88.1559028752.git.chunfeng.yun@mediatek.com> <87k1ebj8vt.fsf@linux.intel.com> <1559201499.8487.40.camel@mhfsdcap03>
Date:   Fri, 31 May 2019 08:44:55 +0300
Message-ID: <87sgsv2n54.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Chunfeng Yun <chunfeng.yun@mediatek.com> writes:

> Hi Felipe,
> On Tue, 2019-05-28 at 11:11 +0300, Felipe Balbi wrote:
>> Hi,
>> 
>> Chunfeng Yun <chunfeng.yun@mediatek.com> writes:
>> > diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
>> > index 7fcb9f782931..88b3ee03a12d 100644
>> > --- a/drivers/usb/core/usb.c
>> > +++ b/drivers/usb/core/usb.c
>> > @@ -1190,7 +1190,7 @@ EXPORT_SYMBOL_GPL(usb_debug_root);
>> >  
>> >  static void usb_debugfs_init(void)
>> >  {
>> > -	usb_debug_root = debugfs_create_dir("usb", NULL);
>> > +	usb_debug_root = debugfs_create_dir(USB_DEBUG_ROOT_NAME, NULL);
>> >  	debugfs_create_file("devices", 0444, usb_debug_root, NULL,
>> >  			    &usbfs_devices_fops);
>> >  }
>> 
>> might be a better idea to move this to usb common. Then have a function
>> which can be called by both host and gadget to maybe create the
>> directory:
>> 
>> static struct dentry *usb_debug_root;
>> 
>> struct dentry *usb_debugfs_init(void)
>> {
>> 	if (!usb_debug_root)
>>         	usb_debug_root = debugfs_create_dir("usb", NULL);
>> 
>> 	return usb_debug_root;
>> }
>> 
>> 
>> Then usb core would be updated to something like:
>> 
>> static void usb_core_debugfs_init(void)
>> {
>> 	struct dentry *root = usb_debugfs_init();
>> 
>> 	debugfs_create_file("devices", 0444, root, NULL, &usbfs_devices_fops);
>> }
>> 
> I find a problem when move usb_debugfs_init() and usb_debugfs_cleanup()
> into usb common, it's easy to create "usb" directory, but difficult to
> cleanup it:
>
> common/common.c
>
> struct dentry *usb_debugfs_init(void)
> {
>     if (!usb_debug_root)
>         usb_debug_root = debugfs_create_dir("usb", NULL);
>
>     return usb_debug_root;
> }
>
> void usb_debugfs_cleanup(void)
> {
>     debugfs_remove_recursive(usb_debug_root);
>     usb_debug_root = NULL;
> }
>
> core/usb.c
>
> static void usb_core_debugfs_init(void)
> {
>     struct dentry *root = usb_debugfs_init();
>
>     debugfs_create_file("devices", 0444, root, NULL,
> &usbfs_devices_fops);
> }
>
> static int __init usb_init(void)
> {
>     ...
>     usb_core_debugfs_init();
>     ...
> }
>
> static void __exit usb_exit(void)
> {
>     ...
>     usb_debugfs_cleanup();
>     // will be error, gadget may use it.
>     ...
> }
>
> gadget/udc/core.c
>
> static int __init usb_udc_init(void)
> {
>     ...
>     usb_debugfs_init();
>     ...
> }
>
> static void __exit usb_udc_exit(void)
> {
>     ...
>     usb_debugfs_cleanup();
>     // can't cleanup in fact, usb core may use it.
> }
>
> How to handle this case? introduce a reference count? do you have any
> suggestion?

I guess a simple refcount is the way to go:

struct dentry *usb_debugfs_init(void)
{
	if (!usb_debug_root)
		usb_debug_root = debugfs_create_dir("usb", NULL);

	usb_debug_root_refcnt++;
	return usb_debug_root;
}

void usb_debugfs_cleanup(void)
{
	if (!(--usb_debug_root_refcnt)) {
		debugfs_remove_recursive(usb_debug_root);
		usb_debug_root = NULL;
	}
}

Or something along those lines

-- 
balbi
