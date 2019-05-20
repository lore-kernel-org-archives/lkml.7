Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF31FC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95DF213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391518AbfETMw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:52:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:60527 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387769AbfETMwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:52:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 05:52:20 -0700
X-ExtLoop1: 1
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga006.jf.intel.com with ESMTP; 20 May 2019 05:52:19 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 06C7C20788; Mon, 20 May 2019 15:52:17 +0300 (EEST)
Date:   Mon, 20 May 2019 15:52:17 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] device property: Add helpers to count items in an
 array
Message-ID: <20190520125217.q65fkmqtizb54gnb@paasikivi.fi.intel.com>
References: <20190520123848.56422-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520123848.56422-1-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, May 20, 2019 at 03:38:48PM +0300, Andy Shevchenko wrote:
> The usual pattern to allocate the necessary space for an array of properties is
> to count them fist using:

s/fist/first/

With that,

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> 
>   count = device_property_read_uXX_array(dev, propname, NULL, 0);
> 
> Introduce helpers device_property_count_uXX() to count items by supplying hard
> coded last two parameters to device_property_readXX_array().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
> -- 
> 2.20.1
> 

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
