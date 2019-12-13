Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715DFC341CB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BC324753
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfLMMbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 07:31:39 -0500
Received: from mga07.intel.com ([134.134.136.100]:38502 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbfLMMbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 07:31:39 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 04:31:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,309,1571727600"; 
   d="scan'208";a="220913279"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 13 Dec 2019 04:31:35 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 13 Dec 2019 14:31:34 +0200
Date:   Fri, 13 Dec 2019 14:31:34 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: fusb302: Fix an undefined reference to
 'extcon_get_state'
Message-ID: <20191213123134.GG31345@kuha.fi.intel.com>
References: <20191212122053.GA1541203@kroah.com>
 <1576239378-50795-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576239378-50795-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 08:16:18PM +0800, zhong jiang wrote:
> Fixes the following compile error:
> 
> drivers/usb/typec/tcpm/fusb302.o: In function `tcpm_get_current_limit':
> fusb302.c:(.text+0x3ee): undefined reference to `extcon_get_state'
> fusb302.c:(.text+0x422): undefined reference to `extcon_get_state'
> fusb302.c:(.text+0x450): undefined reference to `extcon_get_state'
> fusb302.c:(.text+0x48c): undefined reference to `extcon_get_state'
> drivers/usb/typec/tcpm/fusb302.o: In function `fusb302_probe':
> fusb302.c:(.text+0x980): undefined reference to `extcon_get_extcon_dev'
> make: *** [vmlinux] Error 1
> 
> It is because EXTCON is build as a module, but FUSB302 is not.
> 
> Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
> index 72481bb..5b986d6 100644
> --- a/drivers/usb/typec/tcpm/Kconfig
> +++ b/drivers/usb/typec/tcpm/Kconfig
> @@ -32,6 +32,7 @@ endif # TYPEC_TCPCI
>  config TYPEC_FUSB302
>  	tristate "Fairchild FUSB302 Type-C chip driver"
>  	depends on I2C
> +	depends on EXTCON || !EXTCON
>  	help
>  	  The Fairchild FUSB302 Type-C chip driver that works with
>  	  Type-C Port Controller Manager to provide USB PD and USB
> -- 
> 1.7.12.4

thanks,

-- 
heikki
