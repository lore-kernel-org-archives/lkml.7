Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2A2C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EEBE2133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfJCInB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 04:43:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:40182 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728322AbfJCInB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:43:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 23F59B14B;
        Thu,  3 Oct 2019 08:42:59 +0000 (UTC)
Message-ID: <1570092176.18913.7.camel@suse.com>
Subject: Re: [RFC PATCH 20/22] thunderbolt: Add support for USB tunnels
From:   Oliver Neukum <oneukum@suse.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-usb@vger.kernel.org
Cc:     Anthony Wong <anthony.wong@canonical.com>,
        Mario.Limonciello@dell.com,
        Andreas Noever <andreas.noever@gmail.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Date:   Thu, 03 Oct 2019 10:42:56 +0200
In-Reply-To: <20191001113830.13028-21-mika.westerberg@linux.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
         <20191001113830.13028-21-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 01.10.2019, 14:38 +0300 schrieb Mika Westerberg:
> From: Rajmohan Mani <rajmohan.mani@intel.com>
> 
> USB4 added a capability to tunnel USB 3.x protocol over the USB4
> fabric. USB4 device routers may include integrated SuperSpeed HUB or a
> function or both. USB tunneling follows PCIe so that the tunnel is
> created between the parent and the child router from USB downstream
> adapter port to USB upstream adapter port over a single USB4 link.
> 
> This adds support for USB tunneling and also capability to discover
> existing USB tunnels (for example created by connection manager in boot
> firmware).
> 
> Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
> Co-developed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/thunderbolt/switch.c  |  35 ++++++++
>  drivers/thunderbolt/tb.c      | 153 ++++++++++++++++++++++++++------
>  drivers/thunderbolt/tb.h      |  15 ++++
>  drivers/thunderbolt/tb_regs.h |   9 +-
>  drivers/thunderbolt/tunnel.c  | 158 +++++++++++++++++++++++++++++++++-
>  drivers/thunderbolt/tunnel.h  |   9 ++
>  drivers/thunderbolt/usb4.c    |  41 ++++++++-
>  7 files changed, 393 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index 58e3f54ddbb9..5a3236fefb76 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -1025,11 +1025,46 @@ bool tb_port_is_enabled(struct tb_port *port)
>  	case TB_TYPE_DP_HDMI_OUT:
>  		return tb_dp_port_is_enabled(port);
>  
> +	case TB_TYPE_USB_UP:
> +	case TB_TYPE_USB_DOWN:
> +		return tb_usb_port_is_enabled(port);
> +
>  	default:
>  		return false;
>  	}
>  }
>  
> +/**
> + * tb_usb_port_is_enabled() - Is the USB adapter port enabled
> + * @port: USB port to check
> + */
> +bool tb_usb_port_is_enabled(struct tb_port *port)

Should these functions be called tb_usb3_port... ?
This looks like all USB would need this.
 
> -static const char * const tb_tunnel_names[] = { "PCI", "DP", "DMA" };
> +static const char * const tb_tunnel_names[] = { "PCI", "DP", "DMA", "USB"};

USB3 ?

	Regards
		Oliver

