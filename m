Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FDDC47E49
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 17:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE4020700
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 17:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571765260;
	bh=JWegfatqnKGnwIzK55U0uFuQH+f+y/FRqF/iMkFMuJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IF2jseycrP3Mzlko8AGMlJU8XSFJ58/pcoVP0wXz32+BiJ0Yf1oX9RObKjmidEV8P
	 +hGygmg0gRCmlUVCIN07Mo3rhAJgGpk5LIaebEi/GMOJkP8leOhaThGnZczXF169PC
	 zLMllDrujKfvoFm4knennU61P6CfD8FUolNAn1vs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731853AbfJVR1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 13:27:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730141AbfJVR1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 13:27:36 -0400
Received: from localhost (mobile-166-172-186-56.mycingular.net [166.172.186.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED62B206C2;
        Tue, 22 Oct 2019 17:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571765254;
        bh=JWegfatqnKGnwIzK55U0uFuQH+f+y/FRqF/iMkFMuJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hVs/wyGwoVAsJ0TQf6lKLkQzLCMuchKjQbWtTsoTnkegv7sobTel1iNjAkDUD5138
         GK+NNZYulZV+MFFAqnG1RvGYBoquhmWp3OktbwKtyeFTMQqbRBjh+veSftBgpN32Nw
         HEZGO0WqmZ0vCmMeU/kXEDgNiTc7IAfefr5yiKJ0=
Date:   Tue, 22 Oct 2019 13:27:31 -0400
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Puma Hsu <pumahsu@google.com>
Cc:     heikki.krogerus@linux.intel.com, badhri@google.com,
        kyletso@google.com, albertccwang@google.com, rickyniu@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] usb: typec: Add sysfs node to show connector
 orientation
Message-ID: <20191022172731.GA230934@kroah.com>
References: <20191022085924.92783-1-pumahsu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022085924.92783-1-pumahsu@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 04:59:24PM +0800, Puma Hsu wrote:
> Export the Type-C connector orientation so that user space
> can get this information.
> 
> Signed-off-by: Puma Hsu <pumahsu@google.com>
> ---
>  Documentation/ABI/testing/sysfs-class-typec | 11 +++++++++++
>  drivers/usb/typec/class.c                   | 18 ++++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> index d7647b258c3c..b22f71801671 100644
> --- a/Documentation/ABI/testing/sysfs-class-typec
> +++ b/Documentation/ABI/testing/sysfs-class-typec
> @@ -108,6 +108,17 @@ Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
>  Description:
>  		Revision number of the supported USB Type-C specification.
>  
> +What:		/sys/class/typec/<port>/connector_orientation
> +Date:		October 2019
> +Contact:	Puma Hsu <pumahsu@google.com>
> +Description:
> +		Indicates which typec connector orientation is configured now.
> +		cc1 is defined as "normal" and cc2 is defined as "reversed".

Why the blank line after "Description:"?  Shouldn't "Indicates..." be
right after it?
> +
> +		Valid value:
> +		- unknown (nothing configured)
> +		- normal (configured in cc1 side)
> +		- reversed (configured in cc2 side)
>  
>  USB Type-C partner devices (eg. /sys/class/typec/port0-partner/)
>  
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 94a3eda62add..911d06676aeb 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1245,6 +1245,23 @@ static ssize_t usb_power_delivery_revision_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(usb_power_delivery_revision);
>  
> +static const char * const typec_connector_orientation[] = {
> +	[TYPEC_ORIENTATION_NONE]		= "unknown",
> +	[TYPEC_ORIENTATION_NORMAL]		= "normal",
> +	[TYPEC_ORIENTATION_REVERSE]		= "reversed",
> +};
> +
> +static ssize_t connector_orientation_show(struct device *dev,
> +						struct device_attribute *attr,
> +						char *buf)

Can you line this up properly?

thanks,

greg k-h
