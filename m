Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA3FC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 11:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7FF217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 11:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569236836;
	bh=W0KNg5xYO1RpjuUgzP6+f9w0r6wSlpxmvibubDyLGNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EtWjUz2QP04ufHPo9jkTw7i+NN63q/5yTUjhQCfJAdJMsZGhKrIxNgrY+GzAjXnC7
	 lCwoxSmXZHIQ71+HtXCw0TP0TfWHUdSDjim8CPdgzs3PqSCLInrlR28LqZHPk+zbae
	 KJ5/DgxDI8dzIHKNj5k5esg5WF1D7s5o1uHJ5oWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393624AbfIWLHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 07:07:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393136AbfIWLHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 07:07:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E173206C2;
        Mon, 23 Sep 2019 11:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569236834;
        bh=W0KNg5xYO1RpjuUgzP6+f9w0r6wSlpxmvibubDyLGNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QKfhuDUP7h7hvtym8KIgPYGx1JBz6O6Es0ztrwChHx3yTuQQDgIxu2ueTFWKBj8E7
         Ilh966pCG2d/hu6Mm7a5QFZxoF7HZaePPJfls1fHVjwFNRh0O5FoPG6ff9quWABy2V
         wTn6iW001Grrg/sIwvNnKd2Z2YwoP88e/iFdk0SY=
Date:   Mon, 23 Sep 2019 13:07:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Dennis Wassenberg <dennis.wassenberg@secunet.com>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: hub add filter for device with specific VID&PID
Message-ID: <20190923110712.GA2796979@kroah.com>
References: <20190923105102.37413-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923105102.37413-1-ran.wang_1@nxp.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 06:51:02PM +0800, Ran Wang wrote:
> USB 2.0 Embedded Host PET Automated Test (CH6) 6.7.23 A-UUT "Unsupported
> Device" Message require to stop enumerating device with VID=0x1a0a PID=0x0201
> and pop message to declare this device is not supported.

Why is this a requirement?

And why those specific vid/pid values?  What do they refer to?

> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
>  drivers/usb/core/hub.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index bbcfa63..3cda0da 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -4982,6 +4982,18 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
>  		if (status < 0)
>  			goto loop;
>  
> +		 /* USB 2.0 Embedded Host PET Automated Test (CH6)
> +		 * 6.7.23 A-UUT "Unsupported Device" Message
> +		 * require to filter out below device when enumeration
> +		 */

Nit, can you align your comment lines, to match the other multi-line
comments in this file?  Otherwise it starts to look bad over time.



> +		if ((udev->descriptor.idVendor == 0x1a0a)
> +		 && (udev->descriptor.idProduct == 0x0201)) {

Are you sure you don't have to convert this value into cpu endian before
checking it?

thanks,

greg k-h
