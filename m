Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DD1C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 07:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46AD72077B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 07:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9bc7JNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfLMHDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 02:03:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60336 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725497AbfLMHDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 02:03:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576220624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O0TmJQsXXUj8xvxj2oZLq4RGHQS1jnAITIBcro7LElU=;
        b=g9bc7JNueOhoH+5+GkgTt8BM8ZdMF5Tp1jY5kStccLNmV/ZF25KOGJl/Gy192TTJSoHUJ4
        jUEvQBSEHFAu+q39V26sFyMd4kO2FPps7HMAjZO3eZGyJNTTZiuxbgFzc5v2w17+JOrGSo
        oIgAM30Q7ReRauPK3vpiA/DPO3ShM8s=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-plFVpiP4Ol2I4R0dr0UiDA-1; Fri, 13 Dec 2019 02:03:43 -0500
X-MC-Unique: plFVpiP4Ol2I4R0dr0UiDA-1
Received: by mail-qv1-f70.google.com with SMTP id w13so1117909qvb.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 23:03:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O0TmJQsXXUj8xvxj2oZLq4RGHQS1jnAITIBcro7LElU=;
        b=U4gSxcrOpgyGDg1bGaoM33OpTvXQMT9bfUJAowjg1w/2Ht/Bdm8rBY1T5ATz5XGF3j
         qIUU9/B5eqFbETtTHb8OFl21rorG4DD+5i9x9qjUJV6sHRZDZBOozYQz7mGj6EftRx8S
         BxMf+75xNERaT64tPu66wr2S2h87u9n+U1U/SMpK46O3XhWYjZqh/00o+fxj3T+Kw+PH
         WhjQnCPfnvWOmQh+X1+/VfC/Viuv6MQsmWJRB6SDREtNvrtqVbtzpk1qT0M6Z+P3x15c
         R+M4Tlftty8LNyFOvHv9nzBX6b03KE8AXn7FYxdtEFT++du5F75q+gusjzbLjQDl/2/Q
         KqmQ==
X-Gm-Message-State: APjAAAWmdm2Jr60MvArs4fV9xxl2thLIU2kF+Rg9ganSSJkeuCFEqZTY
        ze+juEK6lZb7jcdPt9Ng3Dd6CNmcVo8f5J6fpHC1NnoCfQVNlGZ24vKpWnU6unMtF+w1mhLgw/z
        YRJV5rklp8JvrqMWPy89INe/3
X-Received: by 2002:a05:620a:25d:: with SMTP id q29mr11763239qkn.158.1576220623040;
        Thu, 12 Dec 2019 23:03:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqwE+l6t4BDHspvGuls9UqQ3pXQQoiWbu2vcki2BukIvZreKNXPLa8JnHLl7gMpZXw6MDOH2qA==
X-Received: by 2002:a05:620a:25d:: with SMTP id q29mr11763215qkn.158.1576220622793;
        Thu, 12 Dec 2019 23:03:42 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id e13sm2971383qtr.80.2019.12.12.23.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 23:03:41 -0800 (PST)
Date:   Fri, 13 Dec 2019 02:03:34 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        vbabka@suse.cz, yang.zhang.wz@gmail.com, nitesh@redhat.com,
        konrad.wilk@oracle.com, david@redhat.com, pagupta@redhat.com,
        riel@surriel.com, lcapitulino@redhat.com, dave.hansen@intel.com,
        wei.w.wang@intel.com, aarcange@redhat.com, pbonzini@redhat.com,
        dan.j.williams@intel.com, alexander.h.duyck@linux.intel.com,
        osalvador@suse.de
Subject: Re: [PATCH v15 5/7] virtio-balloon: Pull page poisoning config out
 of free page hinting
Message-ID: <20191213020316-mutt-send-email-mst@kernel.org>
References: <20191205161928.19548.41654.stgit@localhost.localdomain>
 <20191205162247.19548.38842.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205162247.19548.38842.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 08:22:47AM -0800, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> Currently the page poisoning setting wasn't being enabled unless free page
> hinting was enabled. However we will need the page poisoning tracking logic
> as well for free page reporting. As such pull it out and make it a separate
> bit of config in the probe function.
> 
> In addition we need to add support for the more recent init_on_free feature
> which expects a behavior similar to page poisoning in that we expect the
> page to be pre-zeroed.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/virtio/virtio_balloon.c |   23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 15b7f1d8c334..252591bc7e01 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -849,7 +849,6 @@ static int virtio_balloon_register_shrinker(struct virtio_balloon *vb)
>  static int virtballoon_probe(struct virtio_device *vdev)
>  {
>  	struct virtio_balloon *vb;
> -	__u32 poison_val;
>  	int err;
>  
>  	if (!vdev->config->get) {
> @@ -916,11 +915,20 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  						  VIRTIO_BALLOON_CMD_ID_STOP);
>  		spin_lock_init(&vb->free_page_list_lock);
>  		INIT_LIST_HEAD(&vb->free_page_list);
> -		if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
> +	}
> +	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
> +		/* Start with poison val of 0 representing general init */
> +		__u32 poison_val = 0;
> +
> +		/*
> +		 * Let the hypervisor know that we are expecting a
> +		 * specific value to be written back in balloon pages.
> +		 */
> +		if (!want_init_on_free())
>  			memset(&poison_val, PAGE_POISON, sizeof(poison_val));
> -			virtio_cwrite(vb->vdev, struct virtio_balloon_config,
> -				      poison_val, &poison_val);
> -		}
> +
> +		virtio_cwrite(vb->vdev, struct virtio_balloon_config,
> +			      poison_val, &poison_val);
>  	}
>  	/*
>  	 * We continue to use VIRTIO_BALLOON_F_DEFLATE_ON_OOM to decide if a
> @@ -1021,7 +1029,10 @@ static int virtballoon_restore(struct virtio_device *vdev)
>  
>  static int virtballoon_validate(struct virtio_device *vdev)
>  {
> -	if (!page_poisoning_enabled())
> +	/* Tell the host whether we care about poisoned pages. */
> +	if (!want_init_on_free() &&
> +	    (IS_ENABLED(CONFIG_PAGE_POISONING_NO_SANITY) ||
> +	     !page_poisoning_enabled()))
>  		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
>  
>  	__virtio_clear_bit(vdev, VIRTIO_F_IOMMU_PLATFORM);

