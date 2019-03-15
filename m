Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BC0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB1921871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbfCOISm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 04:18:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:50253 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727476AbfCOISm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 04:18:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 01:18:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,481,1544515200"; 
   d="scan'208";a="155275113"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 15 Mar 2019 01:18:36 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 15 Mar 2019 10:18:35 +0200
Date:   Fri, 15 Mar 2019 10:18:35 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Min Guo <min.guo@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 4/6] usb: roles: add API to get usb_role_switch by node
Message-ID: <20190315081835.GD7752@kuha.fi.intel.com>
References: <1552635513-2378-1-git-send-email-chunfeng.yun@mediatek.com>
 <1552635513-2378-5-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552635513-2378-5-git-send-email-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 03:38:31PM +0800, Chunfeng Yun wrote:
> Add usb_role_switch_get_by_node() to make easier to get
> usb_role_switch by node which register it.
> It's useful when there is not device_connection registered
> between two drivers and only knows the node which register
> usb_role_switch.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/usb/roles/class.c | 30 ++++++++++++++++++++++++++++++
>  include/linux/usb/role.h  |  1 +
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
> index 99116af07f1d..284b19856dc4 100644
> --- a/drivers/usb/roles/class.c
> +++ b/drivers/usb/roles/class.c
> @@ -11,6 +11,7 @@
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/of.h>
>  #include <linux/slab.h>
>  
>  static struct class *role_class;
> @@ -121,6 +122,35 @@ struct usb_role_switch *usb_role_switch_get(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(usb_role_switch_get);
>  
> +static int __switch_match_node(struct device *dev, const void *node)
> +{
> +	return dev->parent->of_node == (const struct device_node *)node;
> +}

Andy already pointed out that you need to use fwnodes.

Rule of thumb: You always use fwnodes. Only if there is something that
can't be done with fwnodes you use DT or ACPI nodes directly.

In this case there is absolutely nothing that would prevent you from
using fwnodes.


thanks,

-- 
heikki
