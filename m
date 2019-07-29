Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D35BC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8FB2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387811AbfG2OPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:15:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:58806 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbfG2OPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:15:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2019 07:15:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,323,1559545200"; 
   d="scan'208";a="190590604"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 29 Jul 2019 07:15:48 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 29 Jul 2019 17:15:47 +0300
Date:   Mon, 29 Jul 2019 17:15:47 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Gilbert <dgilbert@interlog.com>
Subject: Re: [PATCH v2] usb: typec: tcpm: Add NULL check before dereferencing
 config
Message-ID: <20190729141547.GD28600@kuha.fi.intel.com>
References: <1563979112-22483-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563979112-22483-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 07:38:32AM -0700, Guenter Roeck wrote:
> When instantiating tcpm on an NXP OM 13588 board with NXP PTN5110,
> the following crash is seen when writing into the 'preferred_role'
> sysfs attribute.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000028
> pgd = f69149ad
> [00000028] *pgd=00000000
> Internal error: Oops: 5 [#1] THUMB2
> Modules linked in: tcpci tcpm
> CPU: 0 PID: 1882 Comm: bash Not tainted 5.1.18-sama5-armv7-r2 #4
> Hardware name: Atmel SAMA5
> PC is at tcpm_try_role+0x3a/0x4c [tcpm]
> LR is at tcpm_try_role+0x15/0x4c [tcpm]
> pc : [<bf8000e2>]    lr : [<bf8000bd>]    psr: 60030033
> sp : dc1a1e88  ip : c03fb47d  fp : 00000000
> r10: dc216190  r9 : dc1a1f78  r8 : 00000001
> r7 : df4ae044  r6 : dd032e90  r5 : dd1ce340  r4 : df4ae054
> r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : df4ae044
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb  Segment none
> Control: 50c53c7d  Table: 3efec059  DAC: 00000051
> Process bash (pid: 1882, stack limit = 0x6a6d4aa5)
> Stack: (0xdc1a1e88 to 0xdc1a2000)
> 1e80:                   dd05d808 dd1ce340 00000001 00000007 dd1ce340 c03fb4a7
> 1ea0: 00000007 00000007 dc216180 00000000 00000000 c01e1e03 00000000 00000000
> 1ec0: c0907008 dee98b40 c01e1d5d c06106c4 00000000 00000000 00000007 c0194e8b
> 1ee0: 0000000a 00000400 00000000 c01a97db dc22bf00 ffffe000 df4b6a00 df745900
> 1f00: 00000001 00000001 000000dd c01a9c2f 7aeab3be c0907008 00000000 dc22bf00
> 1f20: c0907008 00000000 00000000 00000000 00000000 7aeab3be 00000007 dee98b40
> 1f40: 005dc318 dc1a1f78 00000000 00000000 00000007 c01969f7 0000000a c01a20cb
> 1f60: dee98b40 c0907008 dee98b40 005dc318 00000000 c0196b9b 00000000 00000000
> 1f80: dee98b40 7aeab3be 00000074 005dc318 b6f3bdb0 00000004 c0101224 dc1a0000
> 1fa0: 00000004 c0101001 00000074 005dc318 00000001 005dc318 00000007 00000000
> 1fc0: 00000074 005dc318 b6f3bdb0 00000004 00000007 00000007 00000000 00000000
> 1fe0: 00000004 be800880 b6ed35b3 b6e5c746 60030030 00000001 00000000 00000000
> [<bf8000e2>] (tcpm_try_role [tcpm]) from [<c03fb4a7>] (preferred_role_store+0x2b/0x5c)
> [<c03fb4a7>] (preferred_role_store) from [<c01e1e03>] (kernfs_fop_write+0xa7/0x150)
> [<c01e1e03>] (kernfs_fop_write) from [<c0194e8b>] (__vfs_write+0x1f/0x104)
> [<c0194e8b>] (__vfs_write) from [<c01969f7>] (vfs_write+0x6b/0x104)
> [<c01969f7>] (vfs_write) from [<c0196b9b>] (ksys_write+0x43/0x94)
> [<c0196b9b>] (ksys_write) from [<c0101001>] (ret_fast_syscall+0x1/0x62)
> 
> Since commit 96232cbc6c994 ("usb: typec: tcpm: support get typec and pd
> config from device properties"), the 'config' pointer in struct tcpc_dev
> is optional when registering a Type-C port. Since it is optional, we have
> to check if it is NULL before dereferencing it.
> 
> Reported-by: Douglas Gilbert <dgilbert@interlog.com>
> Cc: Douglas Gilbert <dgilbert@interlog.com>
> Fixes: 96232cbc6c994 ("usb: typec: tcpm: support get typec and pd config from device properties")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v2: Added missing Cc:. Sorry for the noise.
> 
> Doug:
>     I didn't add your Tested-by: since I added more code.
>     It would be great if you can re-test.
> 
>  drivers/usb/typec/tcpm/tcpm.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index fba32d84e578..77f71f602f73 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -379,7 +379,8 @@ static enum tcpm_state tcpm_default_state(struct tcpm_port *port)
>  			return SNK_UNATTACHED;
>  		else if (port->try_role == TYPEC_SOURCE)
>  			return SRC_UNATTACHED;
> -		else if (port->tcpc->config->default_role == TYPEC_SINK)
> +		else if (port->tcpc->config &&
> +			 port->tcpc->config->default_role == TYPEC_SINK)
>  			return SNK_UNATTACHED;
>  		/* Fall through to return SRC_UNATTACHED */
>  	} else if (port->port_type == TYPEC_PORT_SNK) {
> @@ -4114,7 +4115,7 @@ static int tcpm_try_role(const struct typec_capability *cap, int role)
>  	mutex_lock(&port->lock);
>  	if (tcpc->try_role)
>  		ret = tcpc->try_role(tcpc, role);
> -	if (!ret && !tcpc->config->try_role_hw)
> +	if (!ret && (!tcpc->config || !tcpc->config->try_role_hw))
>  		port->try_role = role;
>  	port->try_src_count = 0;
>  	port->try_snk_count = 0;
> @@ -4701,7 +4702,7 @@ static int tcpm_copy_caps(struct tcpm_port *port,
>  	port->typec_caps.prefer_role = tcfg->default_role;
>  	port->typec_caps.type = tcfg->type;
>  	port->typec_caps.data = tcfg->data;
> -	port->self_powered = port->tcpc->config->self_powered;
> +	port->self_powered = tcfg->self_powered;
>  
>  	return 0;
>  }
> -- 
> 2.7.4

thanks,

-- 
heikki
