Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D3BC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D9F20836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbfLKNpj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:45:39 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41608 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729540AbfLKNpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:45:35 -0500
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1if2J2-0008Qx-4P
        for linux-kernel@vger.kernel.org; Wed, 11 Dec 2019 13:45:32 +0000
Received: by mail-pg1-f198.google.com with SMTP id t12so9055082pgs.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 05:45:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kq+q9UoCbJWekUGal6VdA3tM3gj9G0YEqra+olhLR4k=;
        b=o8makLJPwvICu4CuG8KxlKDTVSwBvk9aXtqgIu86xpMMbWczJPEYXeUPNLnJ/X/I+R
         cA74DRtRUxPP0cZwKXQMhqx4DfyYdh/sIdvNNnN9N4PGftYGdC82PDjnWmdqCjn/TTrw
         kf4sLGWD8tyvlVAB0On+9o+B7+bc8hlW2ck8n+PbBMWxA+eUgEFTKFeqsoPrYt5FuwAX
         V+qySBWbENy9O+swxfGUHQJAXLliVs1BpGcbJ8OWN+VYIdW5mv1aVXaaMPRQTa2XPI9+
         lyHW7DddPMLAuu01Zm57JOKUklMoBpMqsAjoanCKVsCHiT6zdnI6eWIZ6U6ChDGpMsPQ
         wGOw==
X-Gm-Message-State: APjAAAVEX5ALm9ZWhnw5+XeoVgHKDy4XLH3dCYaK+pzqTeC7xLkjnaP5
        6Dppskp4svbLtlyy5YX7/Mmz+zVSzjfqryvk5zI2DJkLuBd5Ixr0eIW9Ezv/ojhq9PCRuGXcx2g
        K1koLZJQ605t/tmJjOpdnasblZ3a+XgV0yGOzdl9pfQ==
X-Received: by 2002:a17:902:6bca:: with SMTP id m10mr3367182plt.212.1576071930529;
        Wed, 11 Dec 2019 05:45:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqz084GCSMaapgObJICUVeCPfP8dI0/c9sjZURFS5lhO9QLqyPNZGQCUenriObwSiGGR6XaFUQ==
X-Received: by 2002:a17:902:6bca:: with SMTP id m10mr3367151plt.212.1576071930098;
        Wed, 11 Dec 2019 05:45:30 -0800 (PST)
Received: from 2001-b011-380f-3c42-bdac-6ba6-1bf8-ef7f.dynamic-ip6.hinet.net (2001-b011-380f-3c42-bdac-6ba6-1bf8-ef7f.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:bdac:6ba6:1bf8:ef7f])
        by smtp.gmail.com with ESMTPSA id k101sm2824765pjb.5.2019.12.11.05.45.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Dec 2019 05:45:29 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH v2 2/2] USB: core: Attempt power cycle port when it's in
 eSS.Disabled state
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20191129174115.31683-2-kai.heng.feng@canonical.com>
Date:   Wed, 11 Dec 2019 21:45:26 +0800
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <62C4527A-5231-4A69-BE7C-9844E2123A90@canonical.com>
References: <20191129174115.31683-1-kai.heng.feng@canonical.com>
 <20191129174115.31683-2-kai.heng.feng@canonical.com>
To:     Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 30, 2019, at 01:41, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> On Dell TB16, Realtek USB ethernet (r8152) connects to an SMSC hub which
> then connects to ASMedia xHCI's root hub:
> 
> /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 5000M
>    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/7p, 5000M
>            |__ Port 2: Dev 3, If 0, Class=Vendor Specific Class, Driver=r8152, 5000M
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
> despite the warm reset attempts. Accoding to spec this can be caused by
> invalid VBus, after some expiremets, the SMSC hub can be brought back
> after a powercycle.
> 
> So let's power cycle the port at the end of reset resume attempt, if
> it's in eSS.Disabled state.

If there's no objection, can this fix be reviewed and merged?

Kai-Heng

> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
> - Lower dev_info() to dev_dbg().
> 
> drivers/usb/core/hub.c | 16 ++++++++++++++++
> 1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 6b6cd76ac5e6..a2e6001046f5 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2739,6 +2739,18 @@ static bool hub_port_warm_reset_required(struct usb_hub *hub, int port1,
> 		|| link_state == USB_SS_PORT_LS_COMP_MOD;
> }
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
> static void hub_port_power_cycle(struct usb_hub *hub, int port1)
> {
> 	struct usb_port *port_dev = hub->ports[port1  - 1];
> @@ -3601,6 +3613,10 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
> 	if (status < 0) {
> 		dev_dbg(&udev->dev, "can't resume, status %d\n", status);
> 		hub_port_logical_disconnect(hub, port1);
> +		if (hub_port_power_cycle_required(hub, port1, portstatus)) {
> +			dev_dbg(&udev->dev, "device in disabled state, attempt power cycle\n");
> +			hub_port_power_cycle(hub, port1);
> +		}
> 	} else  {
> 		/* Try to enable USB2 hardware LPM */
> 		usb_enable_usb2_hardware_lpm(udev);
> -- 
> 2.17.1
> 

