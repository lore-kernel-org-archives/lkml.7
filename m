Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1E6C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C5F2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387454AbfDQVVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:21:18 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50946 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQVVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 17:21:17 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGrzT-0007xA-Is; Wed, 17 Apr 2019 21:21:11 +0000
Date:   Wed, 17 Apr 2019 22:21:11 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Frank Haverkamp <haver@linux.ibm.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Felipe Balbi <balbi@kernel.org>,
        Jerry Zhang <zhangjerry@google.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Shen Jing <jingx.shen@intel.com>,
        linuxppc-dev@lists.ozlabs.org, megaraidlinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 10/26] compat_ioctl: use correct compat_ptr()
 translation in drivers
Message-ID: <20190417212111.GX2217@ZenIV.linux.org.uk>
References: <20190416202013.4034148-1-arnd@arndb.de>
 <20190416202013.4034148-11-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416202013.4034148-11-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 10:19:48PM +0200, Arnd Bergmann wrote:
> A handful of drivers all have a trivial wrapper around their ioctl
> handler, but don't call the compat_ptr() conversion function at the
> moment. In practice this does not matter, since none of them are used
> on the s390 architecture and for all other architectures, compat_ptr()
> does not do anything, but using the new compat_ptr_ioctl()
> helper makes it more correct in theory, and simplifies the code.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/misc/cxl/flash.c            |  8 +-------
>  drivers/misc/genwqe/card_dev.c      | 23 +----------------------
>  drivers/scsi/megaraid/megaraid_mm.c | 28 +---------------------------
>  drivers/usb/gadget/function/f_fs.c  | 12 +-----------

ACK, provided that all their ioctls are taking pointers (which is
worth mentioning in commit message, assuming it's true)
