Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8E1CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904F620659
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbfJUPIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 11:08:07 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:19476 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726847AbfJUPIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:08:06 -0400
X-IronPort-AV: E=Sophos;i="5.67,323,1566856800"; 
   d="scan'208";a="407263396"
Received: from portablejulia.rsr.lip6.fr ([132.227.76.63])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 17:08:04 +0200
Date:   Mon, 21 Oct 2019 17:08:05 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To:     Suwan Kim <suwan.kim027@gmail.com>
cc:     shuah@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        julia.lawall@lip6.fr, valentina.manea.m@gmail.com,
        kbuild test robot <lkp@intel.com>
Subject: =?ISO-8859-15?Q?Re=3A_=5BPATCH=5D_usbip=3A=A0Fix_free_of_unallo?=
 =?ISO-8859-15?Q?cated_memory_in_vhci_tx?=
In-Reply-To: <20191021142414.27164-1-suwan.kim027@gmail.com>
Message-ID: <alpine.DEB.2.21.1910211706240.2877@hadrien>
References: <20191021142414.27164-1-suwan.kim027@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-480209675-1571670485=:2877"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-480209675-1571670485=:2877
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 21 Oct 2019, Suwan Kim wrote:

> iso_buffer should be set to NULL after use and free in the while loop.
> In the case of isochronous URB in the while loop, iso_buffer is
> allocated and after sending it to server, buffer is deallocated. And
> then, if the next URB in the while loop is not a isochronous pipe,
> iso_buffer still holds the previously deallocated buffer address and
> kfree tries to free wrong buffer address.
>
> Fixes: ea44d190764b (“usbip: Implement SG support to vhci-hcd and stub driver”)
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> ---
>  drivers/usb/usbip/vhci_tx.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/usbip/vhci_tx.c b/drivers/usb/usbip/vhci_tx.c
> index c3803785f6ef..b290e810d11b 100644
> --- a/drivers/usb/usbip/vhci_tx.c
> +++ b/drivers/usb/usbip/vhci_tx.c
> @@ -73,6 +73,7 @@ static int vhci_send_cmd_submit(struct vhci_device *vdev)
>  		memset(&pdu_header, 0, sizeof(pdu_header));
>  		memset(&msg, 0, sizeof(msg));
>  		memset(&iov, 0, sizeof(iov));
> +		iso_buffer = NULL;

Somehow I would have put it after the kfree, since the kfree makes the
value invalid.  iso_buffer is already initialized to NULL for the first
iteration.  If you want to put the setting to NULL at the top of the loop,
maybe the = NULL in the first line should be removed.

julia

>
>  		usbip_dbg_vhci_tx("setup txdata urb seqnum %lu\n",
>  				  priv->seqnum);
> --
> 2.21.0
>
>
--8323329-480209675-1571670485=:2877--
