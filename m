Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ECEC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1302339D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567518188;
	bh=BZuBxz5LjyjK3mxQ5wcwZ9xiDK4G1tNxcl6nHbFb1mM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p4UDT/QkkMbo8mEeDdW0wkNkYy/V9Cg5MwLEOrmPXwUkiUPjAewEDEmszelPLQvNc
	 rkTU5rPPDiywGXNs5+pXeSTfYnD7ZlUO5nH3CZYWg59T9B2Nt6bjqpru8KdDvH5YTY
	 m2cStOUhEfxGVKr7dn4XFR3l+lJvYHvX4qcLb7TI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbfICNnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:43:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728854AbfICNnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:43:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4183E2087E;
        Tue,  3 Sep 2019 13:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567518186;
        bh=BZuBxz5LjyjK3mxQ5wcwZ9xiDK4G1tNxcl6nHbFb1mM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jk16iEEfPJmtAHM0GX+d5PcvvnsvpmMlWndFqoWNmP7NYa4eTLLEL5GcsSa/khvHz
         mJE4vH93jo8RelEWm8vyeMLlzXnaIrgxohhTaiYJFrf5/xGgnxuawpu1VpIROUI2iS
         nfX3JnwGPgeytXXJ+fzX/emBppDOwM78HE8RbxRk=
Date:   Tue, 3 Sep 2019 15:43:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     Colin King <colin.king@canonical.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][usb-next] usb: cdns3: fix missing assignment of ret
 before error check on ret
Message-ID: <20190903134304.GB9435@kroah.com>
References: <20190902145035.18200-1-colin.king@canonical.com>
 <BYAPR07MB4709DF377BFBD54FD6BF88B3DDBE0@BYAPR07MB4709.namprd07.prod.outlook.com>
 <BYAPR07MB470927CBDF6CC2345DD350E6DDB90@BYAPR07MB4709.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR07MB470927CBDF6CC2345DD350E6DDB90@BYAPR07MB4709.namprd07.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 03:29:50AM +0000, Pawel Laszczak wrote:
> Hi Colin
> 
> >Hi Colin
> >
> >>
> >>From: Colin Ian King <colin.king@canonical.com>
> >>
> >>Currently the check on a non-zero return code in ret is false because
> >>ret has been initialized to zero.  I believe that ret should be assigned
> >>to the return from the call to readl_poll_timeout_atomic before the
> >>check on ret.  Since ret is being re-assinged the original initialization
> >>of ret to zero can be removed.
> >
> >Thanks you for letting me know.
> >Fortunately that's not a critical bug and has no impact for driver.
> >I will correct it.
> >
> >Cheers
> >Pawell
> >
> >>
> >>Addresses-Coverity: ("'Constant' variable guards dead code")
> >>Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> >>Signed-off-by: Colin Ian King <colin.king@canonical.com>
> >>---
> >> drivers/usb/cdns3/gadget.c | 6 +++---
> >> 1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >>diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> >>index 3094ad65ffc9..0eb3022838d6 100644
> >>--- a/drivers/usb/cdns3/gadget.c
> >>+++ b/drivers/usb/cdns3/gadget.c
> >>@@ -2154,7 +2154,7 @@ int __cdns3_gadget_ep_clear_halt(struct cdns3_endpoint *priv_ep)
> >> {
> >> 	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
> >> 	struct usb_request *request;
> >>-	int ret = 0;
> >>+	int ret;
> >> 	int val;
> >>
> >> 	trace_cdns3_halt(priv_ep, 0, 0);
> >>@@ -2162,8 +2162,8 @@ int __cdns3_gadget_ep_clear_halt(struct cdns3_endpoint *priv_ep)
> >> 	writel(EP_CMD_CSTALL | EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
> >>
> >> 	/* wait for EPRST cleared */
> >>-	readl_poll_timeout_atomic(&priv_dev->regs->ep_cmd, val,
> >>-				  !(val & EP_CMD_EPRST), 1, 100);
> >>+	ret = readl_poll_timeout_atomic(&priv_dev->regs->ep_cmd, val,
> >>+					!(val & EP_CMD_EPRST), 1, 100);
> >> 	if (ret)
> >> 		return -EINVAL;
> 
> What about such condition:
> 	if (unlikely(ret)) {

Only use likely/unlikely if you can actually measure the performance
impact of not using it.  Otherwise drop it as the compiler and CPU will
almost always get it correct for you (like in this case).

thanks,

greg k-h
