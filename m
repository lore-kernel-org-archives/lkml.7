Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAB3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D4D2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfCSL47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 07:56:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:28336 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbfCSL47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 07:56:59 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 04:56:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,497,1544515200"; 
   d="scan'208";a="156320043"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 19 Mar 2019 04:56:52 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 19 Mar 2019 13:56:51 +0200
Date:   Tue, 19 Mar 2019 13:56:51 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Yu Chen <chenyu56@huawei.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        suzhuangluan@hisilicon.com, kongfei@hisilicon.com,
        liuyu712@hisilicon.com, wanghu17@hisilicon.com,
        butao@hisilicon.com, chenyao11@huawei.com,
        fangshengzhou@hisilicon.com, lipengcheng8@huawei.com,
        songxiaowei@hisilicon.com, xuyiping@hisilicon.com,
        xuyoujun4@huawei.com, yudongbin@hisilicon.com,
        zangleigang@hisilicon.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 08/12] usb: roles: Add usb role switch notifier.
Message-ID: <20190319115651.GT7752@kuha.fi.intel.com>
References: <20190316035342.77998-1-chenyu56@huawei.com>
 <20190316035342.77998-9-chenyu56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316035342.77998-9-chenyu56@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 11:53:38AM +0800, Yu Chen wrote:
> This patch adds notifier for drivers want to be informed of the usb role switch.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> ---
>  drivers/usb/roles/class.c | 20 +++++++++++++++++++-
>  include/linux/usb/role.h  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
> index f45d8df5cfb8..e2caaa665d6e 100644
> --- a/drivers/usb/roles/class.c
> +++ b/drivers/usb/roles/class.c
> @@ -20,6 +20,7 @@ struct usb_role_switch {
>  	struct device dev;
>  	struct mutex lock; /* device lock*/
>  	enum usb_role role;
> +	struct blocking_notifier_head nh;
>  
>  	/* From descriptor */
>  	struct device *usb2_port;
> @@ -49,8 +50,10 @@ int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role)
>  	mutex_lock(&sw->lock);
>  
>  	ret = sw->set(sw->dev.parent, role);
> -	if (!ret)
> +	if (!ret) {
>  		sw->role = role;
> +		blocking_notifier_call_chain(&sw->nh, role, NULL);
> +	}
>  
>  	mutex_unlock(&sw->lock);
>  
> @@ -58,6 +61,20 @@ int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role)
>  }
>  EXPORT_SYMBOL_GPL(usb_role_switch_set_role);
>  
> +int usb_role_switch_register_notifier(struct usb_role_switch *sw,
> +				      struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&sw->nh, nb);
> +}
> +EXPORT_SYMBOL_GPL(usb_role_switch_register_notifier);
> +
> +int usb_role_switch_unregister_notifier(struct usb_role_switch *sw,
> +					struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&sw->nh, nb);
> +}
> +EXPORT_SYMBOL_GPL(usb_role_switch_unregister_notifier);
> +
>  /**
>   * usb_role_switch_get_role - Get the USB role for a switch
>   * @sw: USB role switch
> @@ -271,6 +288,7 @@ usb_role_switch_register(struct device *parent,
>  		return ERR_PTR(-ENOMEM);
>  
>  	mutex_init(&sw->lock);
> +	BLOCKING_INIT_NOTIFIER_HEAD(&sw->nh);
>  
>  	sw->allow_userspace_control = desc->allow_userspace_control;
>  	sw->usb2_port = desc->usb2_port;
> diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
> index c05ffa6abda9..99d8b8e4fe61 100644
> --- a/include/linux/usb/role.h
> +++ b/include/linux/usb/role.h
> @@ -42,6 +42,8 @@ struct usb_role_switch_desc {
>  	bool allow_userspace_control;
>  };
>  
> +
> +#if IS_ENABLED(CONFIG_USB_ROLE_SWITCH)
>  int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role);
>  enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw);
>  struct usb_role_switch *usb_role_switch_get(struct device *dev);
> @@ -51,5 +53,49 @@ struct usb_role_switch *
>  usb_role_switch_register(struct device *parent,
>  			 const struct usb_role_switch_desc *desc);
>  void usb_role_switch_unregister(struct usb_role_switch *sw);
> +int usb_role_switch_register_notifier(struct usb_role_switch *sw,
> +				      struct notifier_block *nb);
> +int usb_role_switch_unregister_notifier(struct usb_role_switch *sw,
> +					struct notifier_block *nb);
> +#else
> +static inline int usb_role_switch_set_role(struct usb_role_switch *sw,
> +		enum usb_role role)
> +{
> +	return 0;
> +}
> +
> +static inline enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw)
> +{
> +	return USB_ROLE_NONE;
> +}
> +
> +static inline struct usb_role_switch *usb_role_switch_get(struct device *dev)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
> +static inline void usb_role_switch_put(struct usb_role_switch *sw) { }
> +
> +static inline struct usb_role_switch *
> +usb_role_switch_register(struct device *parent,
> +			 const struct usb_role_switch_desc *desc)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
> +static inline void usb_role_switch_unregister(struct usb_role_switch *sw) { }
> +
> +static int usb_role_switch_register_notifier(struct usb_role_switch *sw,
> +				      struct notifier_block *nb)
> +{
> +	return -ENODEV;
> +}
> +
> +static int usb_role_switch_unregister_notifier(struct usb_role_switch *sw,
> +					struct notifier_block *nb)
> +{
> +	return -ENODEV;
> +}
> +#endif
>  
>  #endif /* __LINUX_USB_ROLE_H */

Sorry for the late response, but since you are providing a stub for
all the functions, not just the new ones, could you please introduce
them in a separate patch.

Add a patch where you introduce stubs for the exiting functions, and
this patch can then add the stubs for just the new notifier functions.


thanks,

-- 
heikki
