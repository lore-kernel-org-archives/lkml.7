Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EE3C282E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 02:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49CA0216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 02:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfE0C4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 22:56:31 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:43771 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725923AbfE0C4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 22:56:30 -0400
X-UUID: fdc718982f0f42ceb23f9eb55922256f-20190527
X-UUID: fdc718982f0f42ceb23f9eb55922256f-20190527
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1648446813; Mon, 27 May 2019 10:56:24 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 27 May
 2019 10:56:22 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 27 May 2019 10:56:22 +0800
Message-ID: <1558925782.10179.429.camel@mhfsdcap03>
Subject: Re: [RESEND PATCH] usb: mtu3: fix up undefined reference to
 usb_debug_root
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Mon, 27 May 2019 10:56:22 +0800
In-Reply-To: <20190524113322.GA32094@kroah.com>
References: <ee71197a681165aa72cb73c7f6cb402953351805.1558678075.git.chunfeng.yun@mediatek.com>
         <20190524074552.GA1080@kroah.com> <1558689951.10179.422.camel@mhfsdcap03>
         <20190524113322.GA32094@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-24 at 13:33 +0200, Greg Kroah-Hartman wrote:
> On Fri, May 24, 2019 at 05:25:51PM +0800, Chunfeng Yun wrote:
> > On Fri, 2019-05-24 at 09:45 +0200, Greg Kroah-Hartman wrote:
> > > On Fri, May 24, 2019 at 02:11:33PM +0800, Chunfeng Yun wrote:
> > > > When CONFIG_USB is not set, and CONFIG_USB_GADGET is set,
> > > > there is an issue:
> > > > 
> > > > ld:
> > > > drivers/usb/mtu3/mtu3_debugfs.o: in function 'ssusb_debugfs_create_root':
> > > > mtu3_debugfs.c:(.text+0xba3): undefined reference to 'usb_debug_root'
> > > > 
> > > > usb_debug_root is only built when CONFIG_USB is enabled, so here drop it
> > > > and use NULL instead.
> > > > 
> > > > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > > > ---
> > > >  drivers/usb/mtu3/mtu3_debugfs.c | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > Why resend?
> > Sorry, I should send it out as v2 due to acked-by is added.
> 
> Then please document that below the --- line, otherwise I have no idea :(
Ok
> 
> > > > diff --git a/drivers/usb/mtu3/mtu3_debugfs.c b/drivers/usb/mtu3/mtu3_debugfs.c
> > > > index 62c57ddc554e..b7c86ccd50b4 100644
> > > > --- a/drivers/usb/mtu3/mtu3_debugfs.c
> > > > +++ b/drivers/usb/mtu3/mtu3_debugfs.c
> > > > @@ -528,8 +528,7 @@ void ssusb_dr_debugfs_init(struct ssusb_mtk *ssusb)
> > > >  
> > > >  void ssusb_debugfs_create_root(struct ssusb_mtk *ssusb)
> > > >  {
> > > > -	ssusb->dbgfs_root =
> > > > -		debugfs_create_dir(dev_name(ssusb->dev), usb_debug_root);
> > > > +	ssusb->dbgfs_root = debugfs_create_dir(dev_name(ssusb->dev), NULL);
> > > 
> > > This moves the directory to a new location no matter what the
> > > configuration is. What's wrong with where it is today?  
> > it seems usb_debug_root is only for host, but not for gadget only, it's
> > defined and created in usb/core/usb.c
> 
> True, but you just moved the root if usb core is present too.
It's an easy way, and other dual-role driver also uses NULL

> 
> > > And shoudn't we
> > > create the usb root directory if only gadget is enabled?
> > Yes, need modify udc/core.c, it's better if support it, do you want me
> > to send a patch for it?
> 
> Yes please, let's see what that looks like.
I'll do it.

Thanks
> 
> thanks,
> 
> greg k-h


