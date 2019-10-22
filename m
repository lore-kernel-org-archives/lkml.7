Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C99ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6D420B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731606AbfJVJvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:51:54 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:42452 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731220AbfJVJvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:51:53 -0400
X-IronPort-AV: E=Sophos;i="5.67,326,1566856800"; 
   d="scan'208";a="407444175"
Received: from unknown (HELO hadrien) ([213.174.99.147])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 11:51:52 +0200
Date:   Tue, 22 Oct 2019 11:51:51 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To:     Suwan Kim <suwan.kim027@gmail.com>
cc:     shuah@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        julia.lawall@lip6.fr, valentina.manea.m@gmail.com,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v2] usbip: Fix free of unallocated memory in vhci tx
In-Reply-To: <20191022093017.8027-1-suwan.kim027@gmail.com>
Message-ID: <alpine.DEB.2.21.1910221151180.2637@hadrien>
References: <20191022093017.8027-1-suwan.kim027@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Oct 2019, Suwan Kim wrote:

> iso_buffer should be set to NULL after use and free in the while loop.
> In the case of isochronous URB in the while loop, iso_buffer is
> allocated and after sending it to server, buffer is deallocated. And
> then, if the next URB in the while loop is not a isochronous pipe,
> iso_buffer still holds the previously deallocated buffer address and
> kfree tries to free wrong buffer address.
>
> Fixes: ea44d190764b ("usbip: Implement SG support to vhci-hcd and stub driver")
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>

Reviewed-by: Julia Lawall <julia.lawall@lip6.fr>

> ---
> v1 - v2: Move the setting NULL after kfree() and add the comment
> ---
>  drivers/usb/usbip/vhci_tx.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/usb/usbip/vhci_tx.c b/drivers/usb/usbip/vhci_tx.c
> index c3803785f6ef..0ae40a13a9fe 100644
> --- a/drivers/usb/usbip/vhci_tx.c
> +++ b/drivers/usb/usbip/vhci_tx.c
> @@ -147,7 +147,10 @@ static int vhci_send_cmd_submit(struct vhci_device *vdev)
>  		}
>
>  		kfree(iov);
> +		/* This is only for isochronous case */
>  		kfree(iso_buffer);
> +		iso_buffer = NULL;
> +
>  		usbip_dbg_vhci_tx("send txdata\n");
>
>  		total_size += txsize;
> --
> 2.20.1
>
>
