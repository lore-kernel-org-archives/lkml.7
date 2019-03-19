Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48A4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813CA2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfCSLNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 07:13:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:44310 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725934AbfCSLNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 07:13:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0945B028;
        Tue, 19 Mar 2019 11:13:10 +0000 (UTC)
Message-ID: <1552993288.14757.23.camel@suse.com>
Subject: Re: [RFC] xhci: clear port_remote_wakeup on device disconnection
From:   Oliver Neukum <oneukum@suse.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Tue, 19 Mar 2019 12:01:28 +0100
In-Reply-To: <20190318170038.23914-1-nsaenzjulienne@suse.de>
References: <20190318170038.23914-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 2019-03-18 at 18:00 +0100, Nicolas Saenz Julienne wrote:
> 
> This patch clears "port_remote_wakeup" upon detecting a device
> disconnection. Making sure the above mentioned situation doesn't trigger
> a PM busyloop.

Hi,

that is an interesting race condition.

> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/usb/host/xhci-hub.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> index e2eece693655..bea853f45aec 100644
> --- a/drivers/usb/host/xhci-hub.c
> +++ b/drivers/usb/host/xhci-hub.c
> @@ -942,6 +942,9 @@ static void xhci_get_usb3_port_status(struct xhci_port *port, u32 *status,
>  			bus_state->suspended_ports &= ~(1 << portnum);
>  	}
>  
> +	if (!(portsc & PORT_CONNECT))
> +		bus_state->port_remote_wakeup &= ~(1 << portnum);
> +
>  	xhci_hub_report_usb3_link_state(xhci, status, portsc);
>  	xhci_del_comp_mod_timer(xhci, portsc, portnum);
>  }

Why are you putting that logic into xhci_get_usb3_port_status()?
It looks to me like there is already something related in the caller

        /* USB2 and USB3 specific bits, including Port Link State */
        if (hcd->speed >= HCD_USB3)
                xhci_get_usb3_port_status(port, &status, raw_port_status);
        else
                xhci_get_usb2_port_status(port, &status, raw_port_status,
                                          flags);
        /*
         * Clear stale usb2 resume signalling variables in case port changed
         * state during resume signalling. For example on error
         */
        if ((bus_state->resume_done[wIndex] ||
             test_bit(wIndex, &bus_state->resuming_ports)) &&
            (raw_port_status & PORT_PLS_MASK) != XDEV_U3 &&
            (raw_port_status & PORT_PLS_MASK) != XDEV_RESUME) {
                bus_state->resume_done[wIndex] = 0;
                clear_bit(wIndex, &bus_state->resuming_ports);
                usb_hcd_end_port_resume(&hcd->self, wIndex);
        }

Otherwise very good catch!

	Regards
		Oliver

