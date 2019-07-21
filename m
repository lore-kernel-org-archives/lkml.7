Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1020CC76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 20:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88A62147A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 20:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfGUUyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 16:54:41 -0400
Received: from smtprelay0068.hostedemail.com ([216.40.44.68]:45604 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbfGUUyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 16:54:41 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id C6CE9283D;
        Sun, 21 Jul 2019 20:54:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: badge91_457dfadbc403e
X-Filterd-Recvd-Size: 2397
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sun, 21 Jul 2019 20:54:37 +0000 (UTC)
Message-ID: <817d0c88a2764ef07b4169bd0e2632f3e78c47d8.camel@perches.com>
Subject: Re: [PATCH v10 2/6] usb:common Separated decoding functions from
 dwc3 driver.
From:   Joe Perches <joe@perches.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Pawel Laszczak <pawell@cadence.com>, felipe.balbi@linux.intel.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        rogerq@ti.com, linux-kernel@vger.kernel.org, jbergsagel@ti.com,
        nsekhar@ti.com, nm@ti.com, sureshp@cadence.com, jpawar@cadence.com,
        kurahul@cadence.com, aniljoy@cadence.com
Date:   Sun, 21 Jul 2019 13:54:35 -0700
In-Reply-To: <Pine.LNX.4.44L0.1907211639390.9901-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.1907211639390.9901-100000@netrider.rowland.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-07-21 at 16:45 -0400, Alan Stern wrote:
> On Sun, 21 Jul 2019, Joe Perches wrote:
> 
> > On Sun, 2019-07-21 at 19:32 +0100, Pawel Laszczak wrote:
> > > Patch moves some decoding functions from driver/usb/dwc3/debug.h driver
> > > to driver/usb/common/debug.c file. These moved functions include:
> > []
> > > diff --git a/drivers/usb/common/debug.c b/drivers/usb/common/debug.c
> > []
> > > +static void usb_decode_set_clear_feature(__u8 bRequestType, __u8 bRequest,
> > > +                                    __u16 wValue, __u16 wIndex,
> > > +                                    char *str, size_t size)
> > 
> > It's probably not necessary to use Hungarian
> > when moving these functions into generic code.
> 
> In fact, these are the well known and commonly accepted names for these
> data values, as given in the USB specification and used in many other
> places in the Linux USB stack.  See for example the definition of
> struct usb_ctrlrequest in include/uapi/linux/usb/ch9.h.
>
> Changing them here would only make the code less readable.

Perhaps, but these have already been converted from
the __le types, so perhaps not.  It might be more
sensible to convert the __u16 uses to u16 and avoid
the __le16 names.

cheers, Joe

