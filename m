Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF443C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952C4222C0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AaMiU9ll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfJBQSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 12:18:31 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33330 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfJBQSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 12:18:30 -0400
Received: by mail-ed1-f65.google.com with SMTP id c4so15822307edl.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 09:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jpI6Yt4Aabzc1pU0Qm6BvfjugUkT+9WqSHu9chpa9jc=;
        b=AaMiU9llCOuOCzVuMCtvZZbyHXsxo9TXDVn+8kGS8EU77tztkNeDnD/r76KhQ6T2UA
         B9x258ao9jX1dvtqdDaXwAEHp9xU+K6N/T1MewJoh00PaYEvLUUPnqR6nWZ2jrMs8Ztu
         ArV+giXb/5jloKS4VQYdU1esA+mdjo3+Xcjd2OxR2JczcRdbhxHuPLH6qvVpo7xgsuUZ
         a7BpTFzvlCfdtyP/nzjITkOEHUWTJHvgaCpiwcOAAOzGDzm+oM8cCxmAz2r6WphYsaAE
         PuMNDrECbLFS5IKE23FKf+B6XpaNnFgAY6oZJAfUj5LaRh7mnhbfgppK0kYABa1Pg8FA
         +3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jpI6Yt4Aabzc1pU0Qm6BvfjugUkT+9WqSHu9chpa9jc=;
        b=a1pxfTyGobGxYsyYRbtC08N2hDXwxpKwCeGoNqFzHkPnA1o8o4TsxqAA8coUdjrmVD
         CFn3mSR+p8Hgu3NLMySTOYfW0ZH32FFRQqUK1t39VxrRuKI33R2BXZWfhnTmhKhVfBUd
         0xNUK1EaSLne9HspPXG3Vg57VJtQmiThY4vHflN0OZMuRJchdcCJg+xjAnnmMuYtuDlQ
         wK/jn+22heI09y3bU+VF+f4Fm8wxwGxgWyzYlzsx9E4RoUPo7LYA6R2XEj7qyK9G/IW+
         nIN++RObyz+PE+BCB+tYWb6nw9xMXRrD9AUujCevmNe62JaCPw+W7JGjqA5dPdF5b8lR
         85Hw==
X-Gm-Message-State: APjAAAXPyYP49B5933yYuIgMlkJSyfRoA5ln+WZyYq3cC2DzQ7+5obPk
        hL2tnnxaFAFjIygR18bpoqDrgpazBLlj6Q==
X-Google-Smtp-Source: APXvYqyfE5U1txyp0AZRS8S9j8BdSrmQQDbN2GfHD+L4SjllZBaPJ3fnWb8u9TkXDUHopNzQ5VGj0w==
X-Received: by 2002:a17:906:5c16:: with SMTP id e22mr3751787ejq.105.1570033108207;
        Wed, 02 Oct 2019 09:18:28 -0700 (PDT)
Received: from lophozonia ([85.195.192.192])
        by smtp.gmail.com with ESMTPSA id h1sm1567262ejb.86.2019.10.02.09.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 09:18:27 -0700 (PDT)
Date:   Wed, 2 Oct 2019 18:18:25 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v2 3/4] iommu/ioasid: Add custom allocators
Message-ID: <20191002161825.GA626133@lophozonia>
References: <1569110870-12603-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1569110870-12603-4-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569110870-12603-4-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

I have four tiny comments below but the patch looks great otherwise, no
major concern from me.

On Sat, Sep 21, 2019 at 05:07:49PM -0700, Jacob Pan wrote:
> +/*
> + * struct ioasid_allocator_data - Internal data structure to hold information
> + * about an allocator. There are two types of allocators:
> + *
> + * - Default allocator always has its own XArray to track the IOASIDs allocated.
> + * - Custom allocators may share allocation helpers with different private data.
> + *   Custom allocators that share the same helper functions also share the same
> + *   XArray.
> + * Rules:
> + * 1. Default allocator is always available, not dynamically registered. This is
> + *    to prevent race conditions with early boot code that want to register
> + *    custom allocators or allocate IOASIDs.
> + * 2. Custom allocators take precedence over the default allocator.
> + * 3. When all custom allocators sharing the same helper functions are
> + *    unregistered (e.g. due to hotplug), all outstanding IOASIDs must be
> + *    freed. Otherwise, outstand IOASIDs will be lost and orphaned.

                           outstanding

[...]
>  ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
>  		      void *private)
>  {
> -	ioasid_t id;
>  	struct ioasid_data *data;
> +	void *adata;
> +	ioasid_t id;

nit: changing the location of id could be in patch 2/4.

> -	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	data = kzalloc(sizeof(*data), GFP_ATOMIC);

I don't think that one needs to be GFP_ATOMIC. Otherwise it should
probably be done from the start, by patch 2/4.

>  	if (!data)
>  		return INVALID_IOASID;
>  
>  	data->set = set;
>  	data->private = private;
>  
> -	if (xa_alloc(&ioasid_xa, &id, data, XA_LIMIT(min, max), GFP_KERNEL)) {
> -		pr_err("Failed to alloc ioasid from %d to %d\n", min, max);
> +	/*
> +	 * Custom allocator needs allocator data to perform platform specific
> +	 * operations.
> +	 */
> +	spin_lock(&ioasid_allocator_lock);
> +	adata = active_allocator->flags & IOASID_ALLOCATOR_CUSTOM ? active_allocator->ops->pdata : data;
> +	id = active_allocator->ops->alloc(min, max, adata);
> +	if (id == INVALID_IOASID) {
> +		pr_err("Failed ASID allocation %lu\n", active_allocator->flags);
> +		goto exit_free;
> +	}
> +
> +	if ((active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) &&
> +		xa_alloc(&active_allocator->xa, &id, data, XA_LIMIT(id, id), GFP_ATOMIC)) {

nit: aligning at the "if (" would make this block more readable.

> +		/* Custom allocator needs framework to store and track allocation results */
> +		pr_err("Failed to alloc ioasid from %d\n", id);
> +		active_allocator->ops->free(id, active_allocator->ops->pdata);
>  		goto exit_free;
>  	}

Thanks,
Jean
