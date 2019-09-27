Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF28AC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71772146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="atPRrpes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfI0OZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 10:25:13 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38052 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfI0OZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 10:25:12 -0400
Received: by mail-yb1-f195.google.com with SMTP id o18so2074074ybp.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 07:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aSckuQ80CIiF/9/8+18nNqYpwKA6GZVh8vgmv4HFPhE=;
        b=atPRrpesEZbMNYxnybbWCv+6b4sE7cKx2UAeCJ28BvLsStCMy3jZSkBYiSKlvqytre
         o/5i6Wli7iHZX9z5HZ3IqR+PVGzvqNKLPWFtaeUa8X4m0GNBrBjoA5tFTX9XhmLvZCvu
         e9CAdiyRq2VjfnJcYh2eitZMbYYChpjGE4tSnObIEENkIq4n23A1NaJ6VYhGYL2ZaFN6
         VLHal0Db4DrplJVIi56yIDXIb4c3ixZ8d8Hb1OvG8rZNvveRSmkjQoPFiqGYcbOIymss
         3wgow+cTMHJ92yfdElO87v9ZR+OPfTxTP9a3P/5ZoVj3ceoiOer0rtvy+KMbQRJ73sfN
         Ttkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aSckuQ80CIiF/9/8+18nNqYpwKA6GZVh8vgmv4HFPhE=;
        b=U1XhpsiMj3WAGUsM/TASnmEdXF7fk8ZZaISIxJB7eXOUOT20hEdBg8QGwxLKv4Lia+
         VN2GwYLF6uRMFMoQ+PU97qpdvfeLYQD4PymvJFkkRDEkgyPB9ovA6uVEvrghDiq5/b+d
         H6bZd4IOqrATsfkjByeBjEZNoki6ck1f9P16Zwds47iVuQB0P8hd33wazqIjLK/5UfKv
         iFAdE2FNcFEWN9YIinopEfaNz6vR4FiqNuIq3LqDZbiESKVT84MTQdaeSmEK7RCBbxFN
         b9o05ZAePejgp9NTpLE6rPp1e0EJgSgEby3mH4LUL+5IqIPUdy1BkPqe6k6X+0DhjNH6
         NRGA==
X-Gm-Message-State: APjAAAV13Har6Bmnr2GAc+pF8sTQE4AJZ+6lxoybKKMd1Hq5xKcoUnmV
        75yuudt/mN7OHhrrPrMOfS15/A==
X-Google-Smtp-Source: APXvYqw9AgvCIoFb5r0eK0QhWLkXx7n2UuZarUJNPoSbq3Jp9VQN/4xEpwhM+Kker0yrzROqSe3rOA==
X-Received: by 2002:a25:af09:: with SMTP id a9mr6448350ybh.405.1569594311669;
        Fri, 27 Sep 2019 07:25:11 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id z137sm616354ywd.18.2019.09.27.07.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 07:25:10 -0700 (PDT)
Date:   Fri, 27 Sep 2019 10:25:10 -0400
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
Subject: Re: [PATCH v2 26/27] drm/dp_mst: Also print unhashed pointers for
 malloc/topology references
Message-ID: <20190927142510.GS218215@art_vandelay>
References: <20190903204645.25487-1-lyude@redhat.com>
 <20190903204645.25487-27-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190903204645.25487-27-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 04:46:04PM -0400, Lyude Paul wrote:
> Currently we only print mstb/port pointer addresses in our malloc and
> topology refcount functions using the hashed-by-default %p, but
> unfortunately if you're trying to debug a use-after-free error caused by
> a refcounting error then this really isn't terribly useful. On the other
> hand though, everything in the rest of the DP MST helpers uses hashed
> pointer values as well and probably isn't useful to convert to unhashed.
> So, let's just get the best of both worlds and print both the hashed and
> unhashed pointer in our malloc/topology refcount debugging output. This
> will hopefully make it a lot easier to figure out which port/mstb is
> causing KASAN to get upset.
> 
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

It's really too bad there isn't a CONFIG_DEBUG_SHOW_PK_ADDRESSES or even a value
of kptr_restrict value that bypasses pointer hashing. I'm sure we're not the
only ones to feel this pain. Maybe everyone just hacks vsnprintf...

As it is, I'm not totally sold on exposing the actual addresses unconditionally.
What do you think about pulling the print out into a function and only printing
px if a debug kconfig is set?

Sean

> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 34 ++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 2fe24e366925..5b5c0b3b3c0e 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -1327,7 +1327,8 @@ static void
>  drm_dp_mst_get_mstb_malloc(struct drm_dp_mst_branch *mstb)
>  {
>  	kref_get(&mstb->malloc_kref);
> -	DRM_DEBUG("mstb %p (%d)\n", mstb, kref_read(&mstb->malloc_kref));
> +	DRM_DEBUG("mstb %p/%px (%d)\n",
> +		  mstb, mstb, kref_read(&mstb->malloc_kref));
>  }
>  
>  /**
> @@ -1344,7 +1345,8 @@ drm_dp_mst_get_mstb_malloc(struct drm_dp_mst_branch *mstb)
>  static void
>  drm_dp_mst_put_mstb_malloc(struct drm_dp_mst_branch *mstb)
>  {
> -	DRM_DEBUG("mstb %p (%d)\n", mstb, kref_read(&mstb->malloc_kref) - 1);
> +	DRM_DEBUG("mstb %p/%px (%d)\n",
> +		  mstb, mstb, kref_read(&mstb->malloc_kref) - 1);
>  	kref_put(&mstb->malloc_kref, drm_dp_free_mst_branch_device);
>  }
>  
> @@ -1379,7 +1381,8 @@ void
>  drm_dp_mst_get_port_malloc(struct drm_dp_mst_port *port)
>  {
>  	kref_get(&port->malloc_kref);
> -	DRM_DEBUG("port %p (%d)\n", port, kref_read(&port->malloc_kref));
> +	DRM_DEBUG("port %p/%px (%d)\n",
> +		  port, port, kref_read(&port->malloc_kref));
>  }
>  EXPORT_SYMBOL(drm_dp_mst_get_port_malloc);
>  
> @@ -1396,7 +1399,8 @@ EXPORT_SYMBOL(drm_dp_mst_get_port_malloc);
>  void
>  drm_dp_mst_put_port_malloc(struct drm_dp_mst_port *port)
>  {
> -	DRM_DEBUG("port %p (%d)\n", port, kref_read(&port->malloc_kref) - 1);
> +	DRM_DEBUG("port %p/%px (%d)\n",
> +		  port, port, kref_read(&port->malloc_kref) - 1);
>  	kref_put(&port->malloc_kref, drm_dp_free_mst_port);
>  }
>  EXPORT_SYMBOL(drm_dp_mst_put_port_malloc);
> @@ -1447,8 +1451,8 @@ drm_dp_mst_topology_try_get_mstb(struct drm_dp_mst_branch *mstb)
>  	int ret = kref_get_unless_zero(&mstb->topology_kref);
>  
>  	if (ret)
> -		DRM_DEBUG("mstb %p (%d)\n", mstb,
> -			  kref_read(&mstb->topology_kref));
> +		DRM_DEBUG("mstb %p/%px (%d)\n",
> +			  mstb, mstb, kref_read(&mstb->topology_kref));
>  
>  	return ret;
>  }
> @@ -1471,7 +1475,8 @@ static void drm_dp_mst_topology_get_mstb(struct drm_dp_mst_branch *mstb)
>  {
>  	WARN_ON(kref_read(&mstb->topology_kref) == 0);
>  	kref_get(&mstb->topology_kref);
> -	DRM_DEBUG("mstb %p (%d)\n", mstb, kref_read(&mstb->topology_kref));
> +	DRM_DEBUG("mstb %p/%px (%d)\n",
> +		  mstb, mstb, kref_read(&mstb->topology_kref));
>  }
>  
>  /**
> @@ -1489,8 +1494,8 @@ static void drm_dp_mst_topology_get_mstb(struct drm_dp_mst_branch *mstb)
>  static void
>  drm_dp_mst_topology_put_mstb(struct drm_dp_mst_branch *mstb)
>  {
> -	DRM_DEBUG("mstb %p (%d)\n",
> -		  mstb, kref_read(&mstb->topology_kref) - 1);
> +	DRM_DEBUG("mstb %p/%px (%d)\n",
> +		  mstb, mstb, kref_read(&mstb->topology_kref) - 1);
>  	kref_put(&mstb->topology_kref, drm_dp_destroy_mst_branch_device);
>  }
>  
> @@ -1546,8 +1551,8 @@ drm_dp_mst_topology_try_get_port(struct drm_dp_mst_port *port)
>  	int ret = kref_get_unless_zero(&port->topology_kref);
>  
>  	if (ret)
> -		DRM_DEBUG("port %p (%d)\n", port,
> -			  kref_read(&port->topology_kref));
> +		DRM_DEBUG("port %p/%px (%d)\n",
> +			  port, port, kref_read(&port->topology_kref));
>  
>  	return ret;
>  }
> @@ -1569,7 +1574,8 @@ static void drm_dp_mst_topology_get_port(struct drm_dp_mst_port *port)
>  {
>  	WARN_ON(kref_read(&port->topology_kref) == 0);
>  	kref_get(&port->topology_kref);
> -	DRM_DEBUG("port %p (%d)\n", port, kref_read(&port->topology_kref));
> +	DRM_DEBUG("port %p/%px (%d)\n",
> +		  port, port, kref_read(&port->topology_kref));
>  }
>  
>  /**
> @@ -1585,8 +1591,8 @@ static void drm_dp_mst_topology_get_port(struct drm_dp_mst_port *port)
>   */
>  static void drm_dp_mst_topology_put_port(struct drm_dp_mst_port *port)
>  {
> -	DRM_DEBUG("port %p (%d)\n",
> -		  port, kref_read(&port->topology_kref) - 1);
> +	DRM_DEBUG("port %p/%px (%d)\n",
> +		  port, port, kref_read(&port->topology_kref) - 1);
>  	kref_put(&port->topology_kref, drm_dp_destroy_port);
>  }
>  
> -- 
> 2.21.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
