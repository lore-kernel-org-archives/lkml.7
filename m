Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B8BC282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F7821841
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558697608;
	bh=qsSpekRTMO6soSqgbGN+CDeIL1lm1krs6w3p0H8XQJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WWdK7SXafRp0Q33IELG69vpjW1L+IGMao9akj1su+ht6rX2m1lbbHPmkX8D4D1mxz
	 RFYBdQKcRFjezYKfbmuT9G1KJpTI/Degu48ZGvRohRTwE8zZsladm4IJTpObBF9AZj
	 nNEJG1vAgktuigdNJpa5d4Wa+cjEfKX3gmjB9Wlc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390987AbfEXLd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:33:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390654AbfEXLd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:33:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B782217F9;
        Fri, 24 May 2019 11:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558697606;
        bh=qsSpekRTMO6soSqgbGN+CDeIL1lm1krs6w3p0H8XQJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J28+TsNIIP/dFub2mHSp/HM5iob1cAFymNIpICdMmFWS1rtbjRgLqFp5VpQF0WTcp
         EU7DKD6sFmDNNFxfiioA7iPyk7g36wq2A0CqCSnwZmMBgO4av735JVq9pTxm6xiDsd
         G9L8xLX59PeNMp/Da2UBdrLRP913ArMRz1AX2nVE=
Date:   Fri, 24 May 2019 13:33:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] usb: mtu3: fix up undefined reference to
 usb_debug_root
Message-ID: <20190524113322.GA32094@kroah.com>
References: <ee71197a681165aa72cb73c7f6cb402953351805.1558678075.git.chunfeng.yun@mediatek.com>
 <20190524074552.GA1080@kroah.com>
 <1558689951.10179.422.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558689951.10179.422.camel@mhfsdcap03>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 05:25:51PM +0800, Chunfeng Yun wrote:
> On Fri, 2019-05-24 at 09:45 +0200, Greg Kroah-Hartman wrote:
> > On Fri, May 24, 2019 at 02:11:33PM +0800, Chunfeng Yun wrote:
> > > When CONFIG_USB is not set, and CONFIG_USB_GADGET is set,
> > > there is an issue:
> > > 
> > > ld:
> > > drivers/usb/mtu3/mtu3_debugfs.o: in function 'ssusb_debugfs_create_root':
> > > mtu3_debugfs.c:(.text+0xba3): undefined reference to 'usb_debug_root'
> > > 
> > > usb_debug_root is only built when CONFIG_USB is enabled, so here drop it
> > > and use NULL instead.
> > > 
> > > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > > ---
> > >  drivers/usb/mtu3/mtu3_debugfs.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > Why resend?
> Sorry, I should send it out as v2 due to acked-by is added.

Then please document that below the --- line, otherwise I have no idea :(

> > > diff --git a/drivers/usb/mtu3/mtu3_debugfs.c b/drivers/usb/mtu3/mtu3_debugfs.c
> > > index 62c57ddc554e..b7c86ccd50b4 100644
> > > --- a/drivers/usb/mtu3/mtu3_debugfs.c
> > > +++ b/drivers/usb/mtu3/mtu3_debugfs.c
> > > @@ -528,8 +528,7 @@ void ssusb_dr_debugfs_init(struct ssusb_mtk *ssusb)
> > >  
> > >  void ssusb_debugfs_create_root(struct ssusb_mtk *ssusb)
> > >  {
> > > -	ssusb->dbgfs_root =
> > > -		debugfs_create_dir(dev_name(ssusb->dev), usb_debug_root);
> > > +	ssusb->dbgfs_root = debugfs_create_dir(dev_name(ssusb->dev), NULL);
> > 
> > This moves the directory to a new location no matter what the
> > configuration is. What's wrong with where it is today?  
> it seems usb_debug_root is only for host, but not for gadget only, it's
> defined and created in usb/core/usb.c

True, but you just moved the root if usb core is present too.

> > And shoudn't we
> > create the usb root directory if only gadget is enabled?
> Yes, need modify udc/core.c, it's better if support it, do you want me
> to send a patch for it?

Yes please, let's see what that looks like.

thanks,

greg k-h
