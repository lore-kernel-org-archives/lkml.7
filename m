Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E06C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627FF21D79
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="GROI0zk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408561AbfIYTON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 15:14:13 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:41494 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfIYTON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 15:14:13 -0400
Received: by mail-yw1-f66.google.com with SMTP id 129so2471017ywb.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 12:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Xm8JaZt34JpJZouJEYtJCJAMSPrJXNrwaxHnJcFeAUc=;
        b=GROI0zk6+t9b0o8qqBzvwit83Yf8otVuWk37zltV/UUXle6QghuPqbyoYrG0Z6J2ZP
         Tfu0DGGAJcJ8fbrjPU8Ne6kAbUDXfn/X4DYEn1qFFGelOHHo3vcqhqOoFxQlC1stM/dK
         b/EKY9GHQzBA26NFrGrttU0aDqsU+51fOzSSz0S59o1DmJy5rJWXwZ9zLPmoIKq3t5Li
         9W2I/1loIpreSw6/DT3B6oL0jZ9as60r05gCvYhuyUgeY08azGHvBVH9GIjgtRVfvJtz
         DW3Py2+6uEtPlxMDLj3FrVzLn7bQFQo1QGFlRDgmp0GyO6PujgUgaaiOodrLF8sF6xTq
         h8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Xm8JaZt34JpJZouJEYtJCJAMSPrJXNrwaxHnJcFeAUc=;
        b=GdaKwlCaEmjtAhKQFruzXRn2PiiFcOtTOjehSbd+6qthM0zcdhx8w89QHvrMftb8Hp
         I/kO51v0gMYi+kw8QdMBVx1em6WjUu1VREhi5v4fqc2UBkrh19k1j8414U76qZ1XXnSl
         qKyOWA6mWL81XLGHmTI89zPh1n9/zODDfTOcUmcEltHzluHvrmXnneBs/wTdqd9PH80D
         cB/t9LJTECdNQNP/5GfCK6eC7Rj78WOwGpCmmkePbS8T1ZBpcUZJNlaEMr4qMKPizbWQ
         gx0JEUN4laE/WutxL0Uak64RqUKwEBZQkOPRksvGvKmG9RoGHBb9i4q+xnvbL25/6XIW
         wRzg==
X-Gm-Message-State: APjAAAUcJwu5p4up+p1TLFJ9gLUlqgiVVSpa/54H7PWgKA7uXp+/Pj3I
        b4ObgRmXqFr1oqX+lezb6NjsWQ==
X-Google-Smtp-Source: APXvYqyIniadt2/l2iR2+nEZXL2S6q2dL8klnXAOrvRz5y0Y/SVWPmRj/L7iOyPVvm4W56ba6+Sdcw==
X-Received: by 2002:a81:9917:: with SMTP id q23mr7379227ywg.404.1569438850932;
        Wed, 25 Sep 2019 12:14:10 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id s187sm1484200ywd.27.2019.09.25.12.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 12:14:08 -0700 (PDT)
Date:   Wed, 25 Sep 2019 15:14:08 -0400
From:   Sean Paul <sean@poorly.run>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/27] drm/dp_mst: Destroy topology_mgr mutexes
Message-ID: <20190925191408.GG218215@art_vandelay>
References: <20190903204645.25487-1-lyude@redhat.com>
 <20190903204645.25487-15-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190903204645.25487-15-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 04:45:52PM -0400, Lyude Paul wrote:
> Turns out we've been forgetting for a while now to actually destroy any
> of the mutexes that we create in drm_dp_mst_topology_mgr. So, let's do
> that.
> 
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Cleanup is overrated :)

Reviewed-by: Sean Paul <sean@poorly.run>


> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 74161f442584..2f88cc173500 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -4339,6 +4339,11 @@ void drm_dp_mst_topology_mgr_destroy(struct drm_dp_mst_topology_mgr *mgr)
>  	mgr->aux = NULL;
>  	drm_atomic_private_obj_fini(&mgr->base);
>  	mgr->funcs = NULL;
> +
> +	mutex_destroy(&mgr->delayed_destroy_lock);
> +	mutex_destroy(&mgr->payload_lock);
> +	mutex_destroy(&mgr->qlock);
> +	mutex_destroy(&mgr->lock);
>  }
>  EXPORT_SYMBOL(drm_dp_mst_topology_mgr_destroy);
>  
> -- 
> 2.21.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
