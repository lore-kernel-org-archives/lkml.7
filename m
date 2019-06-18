Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5D3C31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2FA32080C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfFRKnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 06:43:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:59743 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729268AbfFRKnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 06:43:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2019 03:43:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,388,1557212400"; 
   d="scan'208";a="181364060"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 18 Jun 2019 03:43:00 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 18 Jun 2019 13:42:59 +0300
Date:   Tue, 18 Jun 2019 13:42:59 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 14/28] drivers: Introduce
 class_find_device_by_fwnode() helper
Message-ID: <20190618104259.GA25441@kuha.fi.intel.com>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
 <1560534863-15115-15-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560534863-15115-15-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 06:54:09PM +0100, Suzuki K Poulose wrote:
> Add a wrapper to class_find_device() to search for a device
> by the fwnode pointer, reusing the generic match function.
> Also convert the existing users to make use of the new helper.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/roles/class.c |  8 +-------
>  drivers/usb/typec/class.c |  8 +-------
>  include/linux/device.h    | 13 +++++++++++++
>  3 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
> index 07aaa96..5cd87d8 100644
> --- a/drivers/usb/roles/class.c
> +++ b/drivers/usb/roles/class.c
> @@ -85,11 +85,6 @@ enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw)
>  }
>  EXPORT_SYMBOL_GPL(usb_role_switch_get_role);
>  
> -static int switch_fwnode_match(struct device *dev, const void *fwnode)
> -{
> -	return dev_fwnode(dev) == fwnode;
> -}
> -
>  static void *usb_role_switch_match(struct device_connection *con, int ep,
>  				   void *data)
>  {
> @@ -99,8 +94,7 @@ static void *usb_role_switch_match(struct device_connection *con, int ep,
>  		if (!fwnode_property_present(con->fwnode, con->id))
>  			return NULL;
>  
> -		dev = class_find_device(role_class, NULL, con->fwnode,
> -					switch_fwnode_match);
> +		dev = class_find_device_by_fwnode(role_class, con->fwnode);
>  	} else {
>  		dev = class_find_device_by_name(role_class, con->endpoint[ep]);
>  	}
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 18a0687..af4fb73 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -205,11 +205,6 @@ static void typec_altmode_put_partner(struct altmode *altmode)
>  	put_device(&adev->dev);
>  }
>  
> -static int typec_port_fwnode_match(struct device *dev, const void *fwnode)
> -{
> -	return dev_fwnode(dev) == fwnode;
> -}
> -
>  static void *typec_port_match(struct device_connection *con, int ep, void *data)
>  {
>  	struct device *dev;
> @@ -219,8 +214,7 @@ static void *typec_port_match(struct device_connection *con, int ep, void *data)
>  	 * we need to return ERR_PTR(-PROBE_DEFER) when there is no device.
>  	 */
>  	if (con->fwnode)
> -		return class_find_device(typec_class, NULL, con->fwnode,
> -					 typec_port_fwnode_match);
> +		return class_find_device_by_fwnode(typec_class, con->fwnode);
>  
>  	dev = class_find_device_by_name(typec_class, con->endpoint[ep]);
>  
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 9228502..52ac911 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -509,6 +509,19 @@ class_find_device_by_of_node(struct class *class, const struct device_node *np)
>  	return class_find_device(class, NULL, np, device_match_of_node);
>  }
>  
> +/**
> + * class_find_device_by_fwnode : device iterator for locating a particular device
> + * matching the fwnode.
> + * @class: class type
> + * @fwnode: fwnode of the device to match.
> + */
> +static inline struct device *
> +class_find_device_by_fwnode(struct class *class,
> +			    const struct fwnode_handle *fwnode)
> +{
> +	return class_find_device(class, NULL, fwnode, device_match_fwnode);
> +}
> +
>  struct class_attribute {
>  	struct attribute attr;
>  	ssize_t (*show)(struct class *class, struct class_attribute *attr,
> -- 
> 2.7.4

thanks,

-- 
heikki
