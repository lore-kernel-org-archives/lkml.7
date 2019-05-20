Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A77C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B305921479
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389052AbfETNiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:38:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:45856 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388793AbfETNiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:38:05 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 06:38:04 -0700
X-ExtLoop1: 1
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 20 May 2019 06:37:59 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 20 May 2019 16:37:58 +0300
Date:   Mon, 20 May 2019 16:37:58 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1] device property: Add helpers to count items in an
 array
Message-ID: <20190520133758.GG1887@kuha.fi.intel.com>
References: <20190520123848.56422-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520123848.56422-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 03:38:48PM +0300, Andy Shevchenko wrote:
> The usual pattern to allocate the necessary space for an array of properties is
> to count them fist using:
> 
>   count = device_property_read_uXX_array(dev, propname, NULL, 0);
> 
> Introduce helpers device_property_count_uXX() to count items by supplying hard
> coded last two parameters to device_property_readXX_array().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

OK by me. FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  include/linux/property.h | 44 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/include/linux/property.h b/include/linux/property.h
> index a29369c89e6e..65e31c090f9f 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -144,6 +144,26 @@ static inline int device_property_read_u64(struct device *dev,
>  	return device_property_read_u64_array(dev, propname, val, 1);
>  }
>  
> +static inline int device_property_count_u8(struct device *dev, const char *propname)
> +{
> +	return device_property_read_u8_array(dev, propname, NULL, 0);
> +}
> +
> +static inline int device_property_count_u16(struct device *dev, const char *propname)
> +{
> +	return device_property_read_u16_array(dev, propname, NULL, 0);
> +}
> +
> +static inline int device_property_count_u32(struct device *dev, const char *propname)
> +{
> +	return device_property_read_u32_array(dev, propname, NULL, 0);
> +}
> +
> +static inline int device_property_count_u64(struct device *dev, const char *propname)
> +{
> +	return device_property_read_u64_array(dev, propname, NULL, 0);
> +}
> +
>  static inline bool fwnode_property_read_bool(const struct fwnode_handle *fwnode,
>  					     const char *propname)
>  {
> @@ -174,6 +194,30 @@ static inline int fwnode_property_read_u64(const struct fwnode_handle *fwnode,
>  	return fwnode_property_read_u64_array(fwnode, propname, val, 1);
>  }
>  
> +static inline int fwnode_property_count_u8(const struct fwnode_handle *fwnode,
> +					   const char *propname)
> +{
> +	return fwnode_property_read_u8_array(fwnode, propname, NULL, 0);
> +}
> +
> +static inline int fwnode_property_count_u16(const struct fwnode_handle *fwnode,
> +					    const char *propname)
> +{
> +	return fwnode_property_read_u16_array(fwnode, propname, NULL, 0);
> +}
> +
> +static inline int fwnode_property_count_u32(const struct fwnode_handle *fwnode,
> +					    const char *propname)
> +{
> +	return fwnode_property_read_u32_array(fwnode, propname, NULL, 0);
> +}
> +
> +static inline int fwnode_property_count_u64(const struct fwnode_handle *fwnode,
> +					    const char *propname)
> +{
> +	return fwnode_property_read_u64_array(fwnode, propname, NULL, 0);
> +}
> +
>  /**
>   * struct property_entry - "Built-in" device property representation.
>   * @name: Name of the property.

Off topic question: Shouldn't we also be able to read the number of
references a reference property holds? I mean, shouldn't
fwnode_property_get_referece_args() also return the number of
references in the property if called without the value parameter?

There can be "empty" references in the middle of the "array" of
references which cause the function to return -ENOENT just like when
called with index out of bounds, so the caller now has in practice
know how many references the property actually has in advance.


thanks,

-- 
heikki
