Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EBFCA9ED3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 02:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EDD720717
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 02:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbfKECb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 21:31:29 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:41530 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729760AbfKECb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 21:31:29 -0500
X-UUID: 7fffc5ef7400452bb4f7ddf0176366e7-20191105
X-UUID: 7fffc5ef7400452bb4f7ddf0176366e7-20191105
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1067987505; Tue, 05 Nov 2019 10:31:21 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 5 Nov
 2019 10:31:16 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 5 Nov 2019 10:31:16 +0800
Message-ID: <1572921077.18464.55.camel@mhfsdcap03>
Subject: Re: [RFC PATCH] usb: common: change usb_debug_root as static
 variable
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Tue, 5 Nov 2019 10:31:17 +0800
In-Reply-To: <20191101090221.GC2671695@kroah.com>
References: <1572575349-5596-1-git-send-email-chunfeng.yun@mediatek.com>
         <20191101090221.GC2671695@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 2BCAD82B0D71AB466DCD90ED35262FF773AEF73C748AB309528833C8BCB79ED62000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-01 at 10:02 +0100, Greg Kroah-Hartman wrote:
> On Fri, Nov 01, 2019 at 10:29:09AM +0800, Chunfeng Yun wrote:
> > Try to avoid using extern global variable, and provide two
> > functions for the usage cases
> 
> That is 3 different things all in one patch, not generally considered a
> good thing at all.

> 
> Also, who is going to use these new functions?  Why are they needed?
After remove global variable usb_debug_root, the drivers using
usb_debug_root to create directory or files will use these new APIs
instead.

> 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> > NOTE:
> >     Prepared but not send out patches for drivers using usb_debug_root,
> > because I'm not sure whether this patch is needed, and many drivers
> > will be modified.
> > ---
> >  drivers/usb/common/common.c | 16 ++++++++++++++--
> >  include/linux/usb.h         |  5 ++++-
> >  2 files changed, 18 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
> > index 1433260d99b4..639ee6d243a2 100644
> > --- a/drivers/usb/common/common.c
> > +++ b/drivers/usb/common/common.c
> > @@ -293,8 +293,20 @@ struct device *usb_of_get_companion_dev(struct device *dev)
> >  EXPORT_SYMBOL_GPL(usb_of_get_companion_dev);
> >  #endif
> >  
> > -struct dentry *usb_debug_root;
> > -EXPORT_SYMBOL_GPL(usb_debug_root);
> > +static struct dentry *usb_debug_root;
> 
> Doesn't this break things as-is? 
Yes, it will, I didn't send out other patches for the drivers using
usb_debug_root.

>  You can't do that in a single patch
> either :(
When I make usb_debug_root as static variable, two APIs need be added
due to other driver use it to create directory or file.

> 
> > +
> > +struct dentry *usb_debugfs_create_dir(const char *name)
> > +{
> > +	return debugfs_create_dir(name, usb_debug_root);
> > +}
> > +EXPORT_SYMBOL_GPL(usb_debugfs_create_dir);
> > +
> > +struct dentry *usb_debugfs_create_file(const char *name, umode_t mode,
> > +			void *data, const struct file_operations *fops)
> > +{
> > +	return debugfs_create_file(name, mode, usb_debug_root, data, fops);
> 
> I doubt many people want to create a file in the usb "root" debugfs
> directory, right?  They _should_ be just creating a new subdirectory in
> there instead.
Currently only three .c files creates a file under usb 'root' debugfs
directory.

> 
> thanks,
> 
> greg k-h


