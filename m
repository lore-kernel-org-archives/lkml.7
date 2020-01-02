Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_TONAME_EQ_TOLOCAL_HDRS_LCASE,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8246C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 15:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D3720848
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 15:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgABPWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 10:22:50 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:41548 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728645AbgABPWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 10:22:50 -0500
Received: (qmail 1847 invoked by uid 2102); 2 Jan 2020 10:22:49 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Jan 2020 10:22:49 -0500
Date:   Thu, 2 Jan 2020 10:22:49 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     atmgnd <atmgnd@protonmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: Fw: usbcore missing parentheses in USE_NEW_SCHEME
In-Reply-To: <ca600d41-d978-d799-a871-ce6e1438a4cc@infradead.org>
Message-ID: <Pine.LNX.4.44L0.2001021018330.1546-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jan 2020, Randy Dunlap wrote:

> [adding linux-usb mailing list]
> 
> On 1/1/20 6:46 AM, atmgnd wrote:
> > I think there is missing parentheses in macro USE_NEW_SCHEME, it should be:
> > #define USE_NEW_SCHEME(i, scheme)      ((i) / 2 == (int)(scheme))
> > 
> > causes a fail wiht "device descriptor read/64, error -110" using my usb drive on vmware using usb 3.0 hub.
> > from https://github.com/torvalds/linux/commit/25244227158e1502062041365a439a54cb8fe673#diff-28615d62e1250eadc353d804f49bc6d6
> > 
> > someone changed USE_NEW_SCHEME, but without parentheses for second parameter. as result. in fuction use_new_scheme when old_scheme_first is 1, use_new_scheme will return 1 always(actullay is should return 0). it also make https://github.com/torvalds/linux/commit/bd0e6c9614b95352eb31d0207df16dc156c527fa#diff-28615d62e1250eadc353d804f49bc6d6 fails.
> > 
> > I cannot use git send-mail, there some issue with my network provider. patch below, :
> > 
> > 
> > From 85f01b89d050a988f4d9fc78232de47e793c6a7c Mon Sep 17 00:00:00 2001
> > From: atmgnd <atmgnd@outlook.com>
> > Date: Wed, 1 Jan 2020 21:27:13 +0800
> > Subject: [PATCH] usb: hub: missing parentheses in USE_NEW_SCHEME
> > 
> > accroding to bd0e6c9#diff-28615d62e1250eadc353d804f49bc6d6, will try old enumeration
> > scheme first for high speed devices. for example, when a high speed device pluged in,
> > line 2720 should expand to 0 at the first time. USE_NEW_SCHEME(0, 0 || 0 || 1) === 0.
> > but it wrongly expand to 1(alway expand to 1 for high speed device), and change
> > USE_NEW_SCHEME to USE_NEW_SCHEME((i) % 2 == (int)(scheme)) may be better ?
> > 
> > Signed-off-by: atmgnd <atmgnd@outlook.com>
> > ---
> >  drivers/usb/core/hub.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index f229ad6952c0..7d17deca7021 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -2692,7 +2692,7 @@ static unsigned hub_is_wusb(struct usb_hub *hub)
> >  #define SET_ADDRESS_TRIES 2
> >  #define GET_DESCRIPTOR_TRIES 2
> >  #define SET_CONFIG_TRIES (2 * (use_both_schemes + 1))
> > -#define USE_NEW_SCHEME(i, scheme) ((i) / 2 == (int)scheme)
> > +#define USE_NEW_SCHEME(i, scheme) ((i) / 2 == (int)(scheme))
> > 
> >  #define HUB_ROOT_RESET_TIME 60 /* times are in msec */
> >  #define HUB_SHORT_RESET_TIME 10
> > --
> > 2.17.1

atmgnd:

Please resend this patch to Greg Kroah-Hartman
<gregkh@linuxfoundation.org> with the appropriate CC's.  Also, your
Signed-off-by: line should contain a real name, not an email userid
(you probably don't use "atmgnd" as your signature on legal
documents!).

When you resend the patch, you can include:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern

