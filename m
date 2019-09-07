Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D38C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 16:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F7A20854
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 16:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394933AbfIGQNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 12:13:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:6140 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388922AbfIGQNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 12:13:47 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2019 09:13:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,477,1559545200"; 
   d="scan'208";a="184812388"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 07 Sep 2019 09:13:44 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i6dLL-0007Tt-Qa; Sat, 07 Sep 2019 19:13:43 +0300
Date:   Sat, 7 Sep 2019 19:13:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 3/3] software node: remove separate handling of
 references
Message-ID: <20190907161343.GJ2680@smile.fi.intel.com>
References: <20190906222611.223532-1-dmitry.torokhov@gmail.com>
 <20190906222611.223532-3-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906222611.223532-3-dmitry.torokhov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 03:26:11PM -0700, Dmitry Torokhov wrote:
> Now that all users of references have moved to reference properties,
> we can remove separate handling of references.
> 

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> v1->v2:
> 
> - dropped rename of struct software_node_ref_args ->
> 	struct software_node_reference
> 
>  drivers/base/swnode.c    | 44 +++++++++++++++-------------------------
>  include/linux/property.h | 14 -------------
>  2 files changed, 16 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index bd720d995123..5dc113de0cae 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -570,8 +570,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
>  				 struct fwnode_reference_args *args)
>  {
>  	struct swnode *swnode = to_swnode(fwnode);
> -	const struct software_node_reference *ref;
> -	const struct software_node_ref_args *ref_args;
> +	const struct software_node_ref_args *ref;
>  	const struct property_entry *prop;
>  	struct fwnode_handle *refnode;
>  	int i;
> @@ -580,36 +579,25 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
>  		return -ENOENT;
>  
>  	prop = property_entry_get(swnode->node->properties, propname);
> -	if (prop) {
> -		if (prop->type != DEV_PROP_REF)
> -			return -EINVAL;
> -
> -		/*
> -		 * We expect all references to be stored as arrays via
> -		 * a pointer, even single ones.
> -		 */
> -		if (!prop->is_array)
> -			return -EINVAL;
> -
> -		if (index * sizeof(*ref_args) >= prop->length)
> -			return -ENOENT;
> +	if (!prop)
> +		return -ENOENT;
>  
> -		ref_args = &prop->pointer.ref[index];
> -	} else {
> -		if (!swnode->node->references)
> -			return -ENOENT;
> +	if (prop->type != DEV_PROP_REF)
> +		return -EINVAL;
>  
> -		for (ref = swnode->node->references; ref->name; ref++)
> -			if (!strcmp(ref->name, propname))
> -				break;
> +	/*
> +	 * We expect all references to be stored as arrays via
> +	 * a pointer, even single ones.
> +	 */
> +	if (!prop->is_array)
> +		return -EINVAL;
>  
> -		if (!ref->name || index > (ref->nrefs - 1))
> -			return -ENOENT;
> +	if (index * sizeof(*ref) >= prop->length)
> +		return -ENOENT;
>  
> -		ref_args = &ref->refs[index];
> -	}
> +	ref = &prop->pointer.ref[index];
>  
> -	refnode = software_node_fwnode(ref_args->node);
> +	refnode = software_node_fwnode(ref->node);
>  	if (!refnode)
>  		return -ENOENT;
>  
> @@ -628,7 +616,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
>  	args->nargs = nargs;
>  
>  	for (i = 0; i < nargs; i++)
> -		args->args[i] = ref_args->args[i];
> +		args->args[i] = ref->args[i];
>  
>  	return 0;
>  }
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 6658403f6fa9..5e4adccd6404 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -415,30 +415,16 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
>  /* -------------------------------------------------------------------------- */
>  /* Software fwnode support - when HW description is incomplete or missing */
>  
> -/**
> - * struct software_node_reference - Named software node reference property
> - * @name: Name of the property
> - * @nrefs: Number of elements in @refs array
> - * @refs: Array of references with optional arguments
> - */
> -struct software_node_reference {
> -	const char *name;
> -	unsigned int nrefs;
> -	const struct software_node_ref_args *refs;
> -};
> -
>  /**
>   * struct software_node - Software node description
>   * @name: Name of the software node
>   * @parent: Parent of the software node
>   * @properties: Array of device properties
> - * @references: Array of software node reference properties
>   */
>  struct software_node {
>  	const char *name;
>  	const struct software_node *parent;
>  	const struct property_entry *properties;
> -	const struct software_node_reference *references;
>  };
>  
>  bool is_software_node(const struct fwnode_handle *fwnode);
> -- 
> 2.23.0.187.g17f5b7556c-goog
> 

-- 
With Best Regards,
Andy Shevchenko


