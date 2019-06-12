Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CDDC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDAE20896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437908AbfFLJzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 05:55:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:48761 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437752AbfFLJza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:55:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 02:55:30 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga005.fm.intel.com with ESMTP; 12 Jun 2019 02:55:28 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hazya-0007sG-Dq; Wed, 12 Jun 2019 12:55:28 +0300
Date:   Wed, 12 Jun 2019 12:55:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v2] device property: Add helpers to count items in an
 array
Message-ID: <20190612095528.GF9224@smile.fi.intel.com>
References: <20190520135004.15203-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520135004.15203-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 04:50:04PM +0300, Andy Shevchenko wrote:
> The usual pattern to allocate the necessary space for an array of properties is
> to count them first by calling:
> 
>   count = device_property_read_uXX_array(dev, propname, NULL, 0);
>   if (count < 0)
> 	return count;
> 
> Introduce helpers device_property_count_uXX() to count items by supplying hard
> coded last two parameters to device_property_readXX_array().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Rafael, can be this applied if you have no objections?

> ---
> - gathered tags
> - rephrase a bit the commit message and fix a typo (Sakari)
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
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


