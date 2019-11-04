Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD083CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12A821D7F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572878327;
	bh=B5UuQO+J8loIhp1v4UeAaOlIdXoRPDv7bpQVgIE778Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A5nG6txrjSornaYHjmEfAENR4Y2w2TIKnUTdP49U9OrPoDyf+psBamJWd1uwTwxkk
	 lAmv0xCpchyV0pjXvdVnBMLF4DYFrfJEu3WZSmewBFJyLPK3ilkA8D6teo5PUE0qtx
	 7QpwmvjOTVN9nHCTI7PXdgcbhnnpjEKdtc/S+jNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfKDOiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:38:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:48074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbfKDOiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:38:46 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26A2121D7D;
        Mon,  4 Nov 2019 14:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572878325;
        bh=B5UuQO+J8loIhp1v4UeAaOlIdXoRPDv7bpQVgIE778Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AVrYxjct5LSE7roOysk7Hok2pg/fVDp7GoCM4i2yM3pnMSfAEHYtHyD+GU+Ly8sxd
         yr/fD77+MNbsYKf52tGyUtEla23kL3gphS3a9nn+cRJZ6cQ9aThd06aCA+uYWIOyhd
         bpQqH8zporuM803/tg+ac4kbvNjLiJ0XtMqjJehg=
Date:   Mon, 4 Nov 2019 15:38:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: core: Attempt power cycle when port is in
 eSS.Disabled state
Message-ID: <20191104143838.GA2183570@kroah.com>
References: <20191007182840.4867-1-kai.heng.feng@canonical.com>
 <20191007182840.4867-2-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007182840.4867-2-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 02:28:40AM +0800, Kai-Heng Feng wrote:
> On Dell TB16, Realtek USB ethernet (r8152) connects to an SMSC hub which
> then connects to ASMedia xHCI's root hub:
> 
> /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 5000M
>     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/7p, 5000M
>             |__ Port 2: Dev 3, If 0, Class=Vendor Specific Class, Driver=r8152, 5000M
> 
> Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 004 Device 002: ID 0424:5537 Standard Microsystems Corp. USB5537B
> Bus 004 Device 003: ID 0bda:8153 Realtek Semiconductor Corp. RTL8153 Gigabit Ethernet Adapter
> 
> The SMSC hub may disconnect after system resume from suspend. When this
> happens, the reset resume attempt fails, and the last resort to disable
> the port and see something comes up later, also fails.
> 
> When the issue occurs, the link state stays in eSS.Disabled state
> despite the warm reset attempts. The USB spec mentioned this can be
> caused by invalid VBus, and after some expiremets, it does show that the
> SMSC hub can be brought back after a power cycle.
> 
> So let's power cycle the port at the end of reset resume attempt, if
> it's in eSS.Disabled state.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/usb/core/hub.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 6655a6a1651b..5f50aca7cf67 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2739,20 +2739,33 @@ static bool hub_port_warm_reset_required(struct usb_hub *hub, int port1,
>  		|| link_state == USB_SS_PORT_LS_COMP_MOD;
>  }
>  
> +static bool hub_port_power_cycle_required(struct usb_hub *hub, int port1,
> +		u16 portstatus)
> +{
> +	u16 link_state;
> +
> +	if (!hub_is_superspeed(hub->hdev))
> +		return false;
> +
> +	link_state = portstatus & USB_PORT_STAT_LINK_STATE;
> +	return link_state == USB_SS_PORT_LS_SS_DISABLED;
> +}
> +
>  static void hub_port_power_cycle(struct usb_hub *hub, int port1)
>  {
> +	struct usb_port *port_dev = hub->ports[port1  - 1];
>  	int ret;
>  
>  	ret = usb_hub_set_port_power(hub, port1, false);
>  	if (ret) {
> -		dev_info(&udev->dev, "failed to disable port power\n");
> +		dev_info(&port_dev->dev, "failed to disable port power\n");
>  		return;
>  	}
>  
>  	msleep(2 * hub_power_on_good_delay(hub));
>  	ret = usb_hub_set_port_power(hub, port1, true);
>  	if (ret) {
> -		dev_info(&udev->dev, "failed to enable port power\n");
> +		dev_info(&port_dev->dev, "failed to enable port power\n");
>  		return;
>  	}
>  
> @@ -3600,6 +3613,10 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
>  	if (status < 0) {
>  		dev_dbg(&udev->dev, "can't resume, status %d\n", status);
>  		hub_port_logical_disconnect(hub, port1);
> +		if (hub_port_power_cycle_required(hub, port1, portstatus)) {
> +			dev_info(&udev->dev, "device in disabled state, attempt power cycle\n");

Why dev_info()?  Shouldn't we only care if this fails?

> +			hub_port_power_cycle(hub, port1);

Weren't we only going to do this for the broken types of devices?  And
not for everything?

thanks,

greg k-h
